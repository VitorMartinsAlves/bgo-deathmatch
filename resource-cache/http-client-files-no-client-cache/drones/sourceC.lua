local screenX, screenY = guiGetScreenSize()
local postGui = true

addEventHandler("onClientResourceStart", resourceRoot, function()
	replaceModel("files/drone", 501)
	setCameraTarget(localPlayer)
	setCameraGoggleEffect("normal")
end)

animations = {}

local controlledDrone = nil
local controllPed = nil

local showDroneGUI = false

local cameraMode = 1
local cameraView = 1

local tX, tY, tZ = nil, nil, nil

local font = dxCreateFont("files/Roboto.ttf", 17, false)

local connectionLost = false
local batteryZero = false
local batteryTimer = nil

addEvent("createdDrone", true)
addEventHandler("createdDrone", root, function(drone, ped)
	controlledDrone = drone
	controllPed = ped
	cameraMode = 1
	cameraView = 1
	connectionLost = false
	showDroneGUI = false
end)

addEvent("toggleDrone", true)
addEventHandler("toggleDrone", root, function(state)
	toggleDrone(state)
end)

function bindControl(state)
	if state then
		for k, v in pairs(controls) do
			bindKey(k, "down", function()
				triggerServerEvent("controllDrone", localPlayer, v, true)
			end)

			bindKey(k, "up", function()
				triggerServerEvent("controllDrone", localPlayer, v, false)
			end)
		end
	else
		for k, v in pairs(controls) do
			unbindKey(k, "down", function()
				triggerServerEvent("controllDrone", localPlayer, v, true)
			end)

			unbindKey(k, "up", function()
				triggerServerEvent("controllDrone", localPlayer, v, false)
			end)
		end
	end
end

function droneControlling()
	if not connectionLost or not batteryZero then
		for k, v in pairs(controls) do
			local controlState = getKeyState(k)

			setPedControlState(controllPed, v, controlState)	
		end
	else
		for k, v in pairs(controls) do
			setPedControlState(controllPed, v, false)	
		end
	end
end

addEvent("controllDrone", true)
addEventHandler("controllDrone", root, function(control, state)
	if not connectionLost or not batteryZero then
		setPedControlState(source, control, state)
	end	
end)


function toggleDrone(state)
	if controlledDrone and isElement(controlledDrone) then
		if state then
			local cX, cY, cZ = getElementPosition(getCamera())
			local dX, dY, dZ = getElementPosition(controlledDrone)

			tX, tY, tZ = getElementOffset(controlledDrone, unpack(views[cameraView]))

			initAnimation("cameraMove", false, {cX, cY, cZ}, {dX, dY, dZ}, 1000, "Linear", function()
				showDroneGUI = true
			end)

			bindKey("v", "down", changeCameraView)
			bindKey("b", "down", changeCameraMode)
			bindControl(true)


			--addEventHandler("onClientPreRender", root, droneControlling)
			addEventHandler("onClientRender", root, renderDrone)
			addEventHandler("onClientKey", root, keyHandler)

			toggleAllControls(false)

			if isTimer(batteryTimer) then
				killTimer(batteryTimer)
			end

			batteryTimer = setTimer(batteryUsing, math.random(5, 5) * 1000, 0)
		else
			--removeEventHandler("onClientPreRender", root, droneControlling)
			removeEventHandler("onClientRender", root, renderDrone)
			removeEventHandler("onClientKey", root, keyHandler)

			setCameraGoggleEffect("normal")

			setCameraTarget(localPlayer)
			toggleAllControls(true)


			if isTimer(batteryTimer) then
				killTimer(batteryTimer)
			end

			unbindKey("v", "down", changeCameraView)
			unbindKey("b", "down", changeCameraMode)
			bindControl(false)

			cameraMode = 1
			cameraView = 1
			connectionLost = false
			showDroneGUI = false
			batteryZero = false
		end
	end
end

function renderDrone()
	for k, v in pairs(animations) do
        if not v.completed then
            local currentTick = getTickCount()
            local elapsedTick = currentTick - v.startTick
            local duration = v.endTick - v.startTick
            local progress = elapsedTick / duration

            v.currentValue[1], v.currentValue[2], v.currentValue[3] = interpolateBetween(
                v.startValue[1], v.startValue[2], v.startValue[3], 
                v.endValue[1], v.endValue[2], v.endValue[3], 
                progress, 
                v.easingType or "Linear"
            )

            if progress >= 1 then
                v.completed = true

                if v.completeFunction then
                    v.completeFunction(unpack(v.functionArgs))
                end
            end
        end
	end
	
	if controlledDrone then
		local x, y, z = getElementOffset(controlledDrone, 0, 0, -0.5)
		if isVehicleOnGround(controlledDrone) then
			x, y, z = getElementOffset(controlledDrone, 0, 0, 5)
		end

		tX, tY, tZ = getElementOffset(controlledDrone, unpack(views[cameraView]))

		if animations.cameraMove then
			if not animations.cameraMove.completed then
				x, y, z = unpack(getAnimationValue("cameraMove"))
			end
		end

		setCameraMatrix(x, y, z, tX, tY, tZ)


		if showDroneGUI then
			local dX, dY, dZ = getElementPosition(controlledDrone or localPlayer)
			local pX, pY, pZ = getElementPosition(localPlayer)

			local distance = math.ceil(getDistanceBetweenPoints3D(pX, pY, pZ, dX, dY, dZ))

			connectionLost = lostSignalDistance < distance
			batteryZero = getElementData(controlledDrone, "drone.battery") <= 0

			if batteryZero then
				outputChatBox("The drone battery is exhauster", 255, 0, 0)
				toggleDrone(false)
			end

			if lostSignalDistance < distance then 
				dxDrawImage(0, 0, screenX, screenY, "files/nosig.png", 0, 0, 0, tocolor(255, 255, 255))
			end

			dxDrawImage(0, 0, screenX, screenY, "files/scantext.png", 0, 0, 0, tocolor(255, 255, 255))

			dxDrawRectangle(0, 0, screenX, 75, tocolor(0, 0, 0), postGui)
			dxDrawText("Localização GPS: " .. (connectionLost and "Não é possível solicitar localização" or getZoneName(getElementPosition(controlledDrone or localPlayer))), 10, 10, screenX + 10, 0, tocolor(255, 255, 255), 1, font, "center", "top", false, false, postGui)
			dxDrawText("Modo da câmera: " .. (connectionLost and "Não é possível solicitar câmera. modo" or modes[cameraMode]), 10, 10, screenX + 10, 75 - 10, tocolor(255, 255, 255), 0.7, font, "center", "bottom", false, false, postGui)

			dxDrawText("Sinal GPS: " .. (connectionLost and "PERDIDO" or "BOM"), 10, 10, screenX, 0, tocolor(255, 255, 255), 0.8, font, "left", "top", false, false, postGui)
			dxDrawText("Distância do controlador: " ..(connectionLost and "Sinal Perdido" or distance) .. " - (MAX: " .. lostSignalDistance .. ")", 10, 10, screenX, 75 - 10, tocolor(255, 255, 255), 0.8, font, "left", "bottom", false, false, postGui)

			dxDrawText("Bateria: " .. (connectionLost and "Sem informações" or getElementData(controlledDrone, "drone.battery")) .. "%", 10, 10, screenX - 10, 0, tocolor(255, 255, 255), 0.8, font, "right", "top", false, false, postGui)
			dxDrawText("Status: " .. (connectionLost and "Sem status" or getDroneStatus()), 10, 10, screenX - 10, 75 - 10, tocolor(255, 255, 255), 0.8, font, "right", "bottom", false, false, postGui)
		
			if getElementData(controlledDrone, "drone.battery") <= 30 then
				dxDrawText("BATERIA FRACA", 0, 0, screenX, screenY, tocolor(255, 0, 0), 1.5, font, "center", "center", false, false, postGui)
			end

			dxDrawText("Sair do drone: [BACKSPACE]", 0, 0, screenX - 10, screenY - 40, tocolor(255, 255, 255), 1, font, "right", "bottom", false, false, postGui)
			dxDrawText("Controles:  [W] [A], [S], [D], [V], [B] [SETA PARA CIMA], [SETA PARA BAIXO]", 0, 0, screenX - 10, screenY - 10, tocolor(255, 255, 255), 1, font, "right", "bottom", false, false, postGui)
		end
	end
end

function keyHandler(key, pressed)
	if pressed then
		if key == "backspace" then
			toggleDrone(false)
		end
	end
end

function changeCameraMode()
	cameraMode = cameraMode + 1

	if cameraMode > #modes then
		cameraMode = 1
	end

	setCameraGoggleEffect(modes[cameraMode])
end

function changeCameraView()
	cameraView = cameraView + 1

	if cameraView > #views then
		cameraView = 1
	end
end

function getDroneStatus()
	if isElement(controlledDrone) then
		local status = "BOM"
		if getElementHealth(controlledDrone) < 800 then
			status =  "DANIFICADO"
		end

		if getElementHealth(controlledDrone) < 600 then
			status = "QUEBRADO."
		end

		return status
	end

	return "Não é possível solicitar o status"
end

function batteryUsing()
	if isElement(controlledDrone) then
		local battery = getElementData(controlledDrone, "drone.battery")

		battery = battery - math.random(2, 6)

		if battery <= 0 then
			battery = 0
		end

		setElementData(controlledDrone, "drone.battery", battery)
	end
end


function replaceModel(fileName, modelID, alphaTransparency)
	if fileExists(fileName .. ".txd") then
		local txd = engineLoadTXD(fileName .. ".txd")
		engineImportTXD(txd, modelID)
	end

	if fileExists(fileName .. ".col") then
		local col = engineLoadCOL(fileName .. ".col")
		engineReplaceCOL(col, modelID)
	end
	
	if fileExists(fileName .. ".dff") then
		local dff = engineLoadDFF(fileName .. ".dff")
		engineReplaceModel(dff, modelID, alphaTransparency or false)
	end
end

function getElementOffset(element, x, y, z)
	local m = getElementMatrix(element)
	return x * m[1][1] + y * m[2][1] + z * m[3][1] + m[4][1],
		    x * m[1][2] + y * m[2][2] + z * m[3][2] + m[4][2],
		    x * m[1][3] + y * m[2][3] + z * m[3][3] + m[4][3]
end

function initAnimation(id, storeVal, startVal, endVal, time, easing, compFunction, args)
    if not storeVal then
        animations[id] = {}
    end

    if not animations[id] then
        animations[id] = {}
    end

    animations[id].startValue = startVal
    animations[id].endValue = endVal
    animations[id].startTick = getTickCount()
    animations[id].endTick = animations[id].startTick + (time or 3000)
    animations[id].easingType = easing
    animations[id].completeFunction = compFunction
    animations[id].functionArgs = args or {}

    animations[id].currentValue = storeVal and animations[id].currentValue or {0, 0, 0}
    animations[id].completed = false
end

function getAnimationValue(id)
	if animations[id] then
		return animations[id].currentValue
	end

	return {0, 0, 0}
end

function setAnimationValue(id, val)
    animations[id].currentValue = val 
end

addEvent("bladeOff", true)
addEventHandler("bladeOff", root, function()
	setHeliBladeCollisionsEnabled(source, false)
end)