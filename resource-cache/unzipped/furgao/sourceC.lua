local SCREEN_WIDTH, SCREEN_HEIGHT = guiGetScreenSize()

local streamedAmbulances = {}
local streamedAmbulancesLookup = {}

local ambulanceDoorStates = {}
local ambulanceAnimations = {}

local isEventsHandled = false
local activeAmbulance = false

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		-- Replace the model
		local ambulanceTXD = engineLoadTXD("files/ambulance.txd")
		local ambulanceDFF = engineLoadDFF("files/ambulance.dff")

		engineImportTXD(ambulanceTXD, MODEL_AMBULANCE)
		engineReplaceModel(ambulanceDFF, MODEL_AMBULANCE)

		-- Find streamed-in ambulances immediately
		local streamedVehicles = getElementsByType("vehicle", root, true)

		for i = 1, #streamedVehicles do
			local theVehicle = streamedVehicles[i]

			if isElement(theVehicle) then
				registerAmbulance(theVehicle)
			end
		end

		-- Request existing datas, this only matters if we just now connected (synchronize all door states)
		triggerServerEvent("requestAmbulanceDoorStates", resourceRoot)
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function ()
		-- When the resource stops, the tables get cleared, so we need to reset the component positions too
		for theVehicle, storedData in pairs(ambulanceDoorStates) do
			if isElement(theVehicle) then
				setVehicleComponentPosition(theVehicle, "sd", DOOR_CLOSED_POSITION[1], DOOR_CLOSED_POSITION[2], DOOR_CLOSED_POSITION[3], "parent")
			end
		end
	end
)

addEventHandler("onClientElementStreamIn", root,
	function ()
		registerAmbulance(source)
	end
)

addEventHandler("onClientElementStreamOut", root,
	function ()
		removeAmbulance(source)
	end
)

addEventHandler("onClientElementDestroy", root,
	function ()
		removeAmbulance(source)
	end
)

addEvent("receiveAmbulanceDoorStates", true)
addEventHandler("receiveAmbulanceDoorStates", resourceRoot,
	function (pDoorStates)
		ambulanceDoorStates = pDoorStates

		-- If we received the door states, process it immediately
		for theVehicle in pairs(ambulanceDoorStates) do
			if isElement(theVehicle) then
				processAmbulance(theVehicle)
			end
		end
	end
)

addEvent("syncAmbulanceDoorState", true)
addEventHandler("syncAmbulanceDoorState", resourceRoot,
	function (pVehicle, pNewState)
		if isElement(pVehicle) then
			local oldState = ambulanceDoorStates[pVehicle]

			ambulanceDoorStates[pVehicle] = pNewState

			-- Handle the sync only, if the states don't match
			if pNewState ~= oldState then
				-- If the ambulance streamed-in, animate it
				if streamedAmbulancesLookup[pVehicle] then
					-- Initialize the animation
					if not ambulanceAnimations[pVehicle] then
						local self = {}

						if pNewState == g_DoorStates.DOOR_OPEN then
							self.doorPosition = {DOOR_CLOSED_POSITION[1], DOOR_CLOSED_POSITION[2], DOOR_CLOSED_POSITION[3]}
							self.doorSound = playSound3D("files/open.mp3", 0, 0, 0)
							self.animationState = g_AnimationStates.DOOR_OPEN
							self.animationProgress = 0
							self.animationDuration = g_AnimationTime.DOOR_OPEN
							self.animationDirection = 1
						elseif pNewState == g_DoorStates.DOOR_CLOSE then
							self.doorPosition = {DOOR_OPENED_POSITION[1], DOOR_OPENED_POSITION[2], DOOR_OPENED_POSITION[3]}
							self.doorSound = playSound3D("files/close.mp3", 0, 0, 0)
							self.animationState = g_AnimationStates.DOOR_SLIDE_FORTH
							self.animationProgress = 1
							self.animationDuration = g_AnimationTime.DOOR_SLIDE_FORTH
							self.animationDirection = -1
						end

						if isElement(self.doorSound) then
							setElementInterior(self.doorSound, getElementInterior(pVehicle))
							setElementDimension(self.doorSound, getElementDimension(pVehicle))
						end

						ambulanceAnimations[pVehicle] = self
					end
				-- If streamed-out, set component positions immediately
				else
					processAmbulance(pVehicle)
				end
			end
		end
	end
)

addEventHandler("onClientSoundStopped", resourceRoot,
	function (pReason)
		if pReason == "finished" then
			if isElement(source) then
				destroyElement(source)
			end
		end
	end
)

function processAmbulance(pVehicle)
	local doorState = ambulanceDoorStates[pVehicle]

	if doorState == g_DoorStates.DOOR_OPEN then
		setVehicleComponentPosition(pVehicle, "sd", DOOR_OPENED_POSITION[1], DOOR_OPENED_POSITION[2], DOOR_OPENED_POSITION[3], "parent")
	elseif doorState == g_DoorStates.DOOR_CLOSE then
		setVehicleComponentPosition(pVehicle, "sd", DOOR_CLOSED_POSITION[1], DOOR_CLOSED_POSITION[2], DOOR_CLOSED_POSITION[3], "parent")
	end
end

function registerAmbulance(pVehicle)
	if getElementModel(pVehicle) == MODEL_AMBULANCE then
		if not streamedAmbulancesLookup[pVehicle] then
			streamedAmbulancesLookup[pVehicle] = true

			-- If we have at least one streamed-in ambulance, create the events
			if not isEventsHandled then
				addEventHandler("onClientRender", root, onRender)
				addEventHandler("onClientClick", root, onMouseClick)
				addEventHandler("onClientPreRender", root, onPreRender)
				isEventsHandled = true
			end

			-- Set the component position immediately when the ambulance is just streamed-in
			if eventName == "onClientElementStreamIn" then
				processAmbulance(pVehicle)
			end

			table.insert(streamedAmbulances, pVehicle)
		end
	end
end

function removeAmbulance(pVehicle)
	if streamedAmbulancesLookup[pVehicle] then
		for i = #streamedAmbulances, 1, -1 do
			if streamedAmbulances[i] == pVehicle then
				table.remove(streamedAmbulances, i)
				break
			end
		end

		-- Remove the events, if there's no more streamed-in ambulance
		if #streamedAmbulances == 0 then
			if isEventsHandled then
				removeEventHandler("onClientRender", root, onRender)
				removeEventHandler("onClientClick", root, onMouseClick)
				removeEventHandler("onClientPreRender", root, onPreRender)
				isEventsHandled = false
			end
		end

		streamedAmbulancesLookup[pVehicle] = nil

		if ambulanceAnimations[pVehicle] then
			if isElement(ambulanceAnimations[pVehicle].doorSound) then
				destroyElement(ambulanceAnimations[pVehicle].doorSound)
			end

			ambulanceAnimations[pVehicle] = nil
		end

		-- If the ambulance get destroyed, remove all datas
		if eventName == "onClientElementDestroy" then
			ambulanceDoorStates[pVehicle] = nil
		else -- Otherwise, process it
			processAmbulance(pVehicle)
		end
	end
end

function onPreRender(pDeltaTime)
	for theVehicle in pairs(ambulanceAnimations) do
		local self = ambulanceAnimations[theVehicle]

		if self then
			local isAnimating = true

			self.animationProgress = self.animationProgress + pDeltaTime / self.animationDuration * self.animationDirection

			if self.animationDirection == 1 then
				if self.animationProgress >= 1 then
					if self.animationState == g_AnimationStates.DOOR_OPEN then
						self.animationState = g_AnimationStates.DOOR_SLIDE_BACK
						self.animationDuration = g_AnimationTime.DOOR_SLIDE_BACK
						self.animationProgress = 0
					elseif self.animationState == g_AnimationStates.DOOR_SLIDE_BACK then
						isAnimating = false
					end
				end
			elseif self.animationDirection == -1 then
				if self.animationProgress <= 0 then
					if self.animationState == g_AnimationStates.DOOR_SLIDE_FORTH then
						self.animationState = g_AnimationStates.DOOR_CLOSE
						self.animationDuration = g_AnimationTime.DOOR_CLOSE
						self.animationProgress = 1
					elseif self.animationState == g_AnimationStates.DOOR_CLOSE then
						isAnimating = false
					end
				end
			end

			if isElement(theVehicle) then
				if isAnimating then
					local easingProgress = getEasingValue(self.animationProgress, "InOutQuad")

					if self.animationState == g_AnimationStates.DOOR_OPEN or self.animationState == g_AnimationStates.DOOR_CLOSE then
						self.doorPosition[1] = DOOR_CLOSED_POSITION[1] + (DOOR_OPENED_POSITION[1] - DOOR_CLOSED_POSITION[1]) * easingProgress
					end

					if self.animationState == g_AnimationStates.DOOR_SLIDE_BACK or self.animationState == g_AnimationStates.DOOR_SLIDE_FORTH then
						self.doorPosition[2] = DOOR_CLOSED_POSITION[2] + (DOOR_OPENED_POSITION[2] - DOOR_CLOSED_POSITION[2]) * easingProgress
					end

					setVehicleComponentPosition(theVehicle, "sd", self.doorPosition[1], self.doorPosition[2], self.doorPosition[3], "parent")
				end
			end

			if isElement(self.doorSound) then
				setElementPosition(self.doorSound, getPositionByRelativeOffset(theVehicle, self.doorPosition[1], self.doorPosition[2] - 0.75, self.doorPosition[3]))
			end

			if not isAnimating then
				ambulanceAnimations[theVehicle] = nil
				processAmbulance(theVehicle)
			end
		end
	end
end

function onMouseClick(pButton, pState)
	if pButton == "left" then
		if pState == "up" then
			if isElement(activeAmbulance) then
				if not ambulanceAnimations[activeAmbulance] then
					if getNetworkStats().packetlossLastSecond <= 5 then
						triggerServerEvent("tryToHandleAmbulanceDoor", resourceRoot, activeAmbulance)
					end
				end
			end
		end
	end
end

function onRender()
	activeAmbulance = false

	if isPedInVehicle(localPlayer) then
		return
	end

	local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
	local cursorRelX, cursorRelY = getCursorPosition()
	local cursorAbsX, cursorAbsY = -1, -1

	if isCursorShowing() then
		cursorAbsX = cursorRelX * SCREEN_WIDTH
		cursorAbsY = cursorRelY * SCREEN_HEIGHT
	end

	for i = 1, #streamedAmbulances do
		local theVehicle = streamedAmbulances[i]

		if isElement(theVehicle) then
			if isElementOnScreen(theVehicle) then
				local componentX, componentY, componentZ = getVehicleComponentPosition(theVehicle, "sd", "parent")
				local targetPosX, targetPosY, targetPosZ = getPositionByRelativeOffset(theVehicle, componentX, componentY - 0.1125, componentZ)

				if getDistanceBetweenPoints3D(playerPosX, playerPosY, playerPosZ, targetPosX, targetPosY, targetPosZ) <= 2 then
					local guiPosX, guiPosY, guiDistance = getScreenFromWorldPosition(targetPosX, targetPosY, targetPosZ, 10)

					if guiPosX and guiPosY then
						guiDistance = 5 / guiDistance

						local guiSize = 48 * guiDistance
						local guiMargin = 6 * guiDistance

						guiPosX = guiPosX - guiSize * 0.5
						guiPosY = guiPosY - guiSize * 0.5

						local guiBcgColor = tocolor(20, 20, 20)
						local guiImgColor = tocolor(255, 255, 255)
						local guiImgAngle = ambulanceDoorStates[theVehicle] == g_DoorStates.DOOR_OPEN and 0 or 180

						if not ambulanceAnimations[theVehicle] then
							if cursorAbsX >= guiPosX and cursorAbsX <= guiPosX + guiSize and cursorAbsY >= guiPosY and cursorAbsY <= guiPosY + guiSize then
								guiBcgColor = tocolor(40, 40, 40)
								guiImgColor = tocolor(66, 158, 245)
								activeAmbulance = theVehicle
							end
						else
							guiBcgColor = tocolor(20, 20, 20, 150)
							guiImgColor = tocolor(255, 255, 255, 150)
						end

						dxDrawImage(guiPosX, guiPosY, guiSize, guiSize, "files/circle.png", 0, 0, 0, guiBcgColor)
						dxDrawImage(guiPosX + guiMargin, guiPosY + guiMargin, guiSize - guiMargin * 2, guiSize - guiMargin * 2, "files/arrow.png", guiImgAngle, 0, 0, guiImgColor)
					end
				end
			end
		end
	end
end

function getPositionByRelativeOffset(element, offsetX, offsetY, offsetZ)
	local matrixArray = getElementMatrix(element)
	return
		offsetX * matrixArray[1][1] + offsetY * matrixArray[2][1] + offsetZ * matrixArray[3][1] + matrixArray[4][1],
		offsetX * matrixArray[1][2] + offsetY * matrixArray[2][2] + offsetZ * matrixArray[3][2] + matrixArray[4][2],
		offsetX * matrixArray[1][3] + offsetY * matrixArray[2][3] + offsetZ * matrixArray[3][3] + matrixArray[4][3]
end
