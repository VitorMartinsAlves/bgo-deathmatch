

--setElementData(localPlayer, "veh:ov", false)

local types = {
	["Automobile"] = true,
	["Bike"] = true,
	["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Monster Truck"] = true,
	["Quad"] = true
}

 



local beltVehicles = {
	["Automobile"] = true,
	["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Monster Truck"] = true
}


function playSounds(sounds, bool, veh)
	if not bool then bool = false end
	if sounds == "ov" then
		beltSound = playSound("files/".. sounds ..".mp3", bool)
	else
	   -- playSound("files/".. sounds ..".mp3", bool)
	   
	   if veh then 
	   triggerServerEvent("PlaySoundVehS", localPlayer, localPlayer, sounds, bool, veh)
	   else
	   triggerServerEvent("PlaySoundVehS", localPlayer, localPlayer, sounds, bool)
	   end
	   
	   
	end
end

function tocarsom(element, som, bool, x,y,z)
--playSound("files/".. sounds ..".mp3", bool)

local sound = playSound3D("files/".. som ..".mp3", x,y,z, bool) 
setSoundVolume(sound, 0.9)
setSoundMinDistance(sound, 1)
setSoundMaxDistance(sound, 20)
attachElements ( sound, element, 0, 0, 3 )

end
addEvent("PlaySoundVehC",true)
addEventHandler("PlaySoundVehC",root,tocarsom)

local beltVehicles = {
	["Automobile"] = true,
	["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Monster Truck"] = true
}


addEventHandler("onClientVehicleEnter", root, function(player)
	if player == localPlayer and beltVehicles[getVehicleType(getPedOccupiedVehicle(localPlayer))] then
		setElementData(localPlayer, "veh:ov", false)
	end
end)



addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(vehicle, seat)
	if source == localPlayer then
		local vehid = vehicle:getData("veh:id")
		local vehfk = vehicle:getData("veh:faction")
		local ownername = vehicle:getData("veh:oname")
		local vehowner = vehicle:getData("veh:owner")
		local engine = vehicle:getData("veh:motor")
		if getVehicleType(getPedOccupiedVehicle(localPlayer)) == "BMX" then
			setVehicleEngineState(vehicle, true)
		else
			if not engine then
				setVehicleEngineState(vehicle, false)
			else
				setVehicleEngineState(vehicle, true)
			end
		end
	end
end)



function keyHandler(button,state)
	if not (not guiGetInputEnabled() and not isMTAWindowActive() and not isCursorShowing()) then return end
	if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then
		if not types[getVehicleType(getPedOccupiedVehicle(localPlayer))] then return end
		local veh = getPedOccupiedVehicle(localPlayer)
		if button == "j" and state then
				if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then
					
					local state = getVehicleEngineState ( veh )
					if not state then
						if not isTimer(vehTimer) then
						
						
						if getVehicleType(getPedOccupiedVehicle(localPlayer)) == "Bike" then
						playSounds("starterMoto", false,veh)
						vehTimer = setTimer(kocsiindit,500,1)
						elseif getVehicleType(getPedOccupiedVehicle(localPlayer)) == "Automobile" then
						playSounds("starterCarro", false, veh)
						vehTimer = setTimer(kocsiindit,900,1)
						else
						playSounds("starter")
						vehTimer = setTimer(kocsiindit,1000,1)
						end
						end
					else
						kocsiindit()
					end

				end
		--elseif button == "j" then
		--	if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then
		--		if isTimer(vehTimer) then
		--			killTimer(vehTimer)
				--end	
			--end
		end
	end	
end
addEventHandler("onClientKey",getRootElement(),keyHandler)




function kocsiindit()
	local veh = getPedOccupiedVehicle(localPlayer)
	local state = getVehicleEngineState ( veh )
	local vehID = getElementModel(veh)
	local vehName = getVehicleRealName(vehID)
		if not state then
			m = true
		if getElementData(veh, "veh:fuel") < 1 then
		triggerEvent("bgo>info", localPlayer,"Informação", "Este veiculo está sem gasolina!", "info")
		m = false
		triggerServerEvent("vehicleStart",localPlayer,localPlayer,veh,m)
		return
		end

		if getElementHealth(veh) >= 321 then
			m = true
			triggerServerEvent("vehicleStart",localPlayer,localPlayer,veh,m)
		return
		else
			m = false
			triggerEvent("bgo>info", localPlayer,"Informação", "Este veiculo está quebrado!", "info")
			triggerServerEvent("vehicleStart",localPlayer,localPlayer,veh,m)
		return
		end

				

		else
			m = false
			triggerServerEvent("vehicleStart",localPlayer,localPlayer,veh,m)
		end
		
end

function processLockUnlock(vehicle)
	if vehicle then
		local vehicleID = tonumber(getElementData(vehicle, "veh:id")) or -1
		local vehFaction = tonumber(getElementData(vehicle, "veh:faction")) or 0
		local vehOwner = tonumber(getElementData(vehicle, "veh:owner")) or -1
		local vehJobID = tonumber(getElementData(vehicle, "veh:jobvehID")) or -1
		if getElementData(vehicle, "veh:owner") == getElementData(localPlayer, "acc:id") or (getElementData(vehicle, "owner") == getElementData(localPlayer, "acc:id"))  or vehFaction > 0 and isInGroup(localPlayer,vehFaction) or (tonumber(getElementData(localPlayer,"acc:admin") or 0) >= 1 and getElementData(localPlayer, "char:adminduty") == 1) or (tonumber(getElementData(localPlayer, "acc:admin") or 0)) >= 6 then --utolsó sor idg
				local locked = isVehicleLocked(vehicle)
				local vehID = getElementModel(vehicle)
				local vehName = exports.bgo_realname:getVehicleRealName(vehID)  --getVehicleRealName(vehID)
					if isPedInVehicle(localPlayer) then
						playSounds("lockin")
					else
						playSounds("lockout")
					end
				
					if locked then
						triggerServerEvent("vehicleLock", localPlayer,localPlayer, vehicle, false)
						--exports.bgo_chat:sendLocalMeMessage(localPlayer, "abriu a porta do ".. vehName .."")
						triggerEvent("bgo>info", localPlayer,"Informação", "Porta do ".. vehName .." aberta", "info")
					else
						triggerServerEvent("vehicleLock", localPlayer,localPlayer, vehicle, true)
						--exports.bgo_chat:sendLocalMeMessage(localPlayer, "Fechou a porta do ".. vehName .."")
						triggerEvent("bgo>info", localPlayer,"Informação", "Porta do ".. vehName .." fechada", "info")
					end
		else
		triggerEvent("bgo>info", localPlayer,"Informação", "Você não é dono deste veículo!", "info")
		end
	end
end

function isInGroup(element, groupId)
	if isElement(element) and getElementType(element) == "player" and getElementData(element, "loggedin") then
		local groupCount = getElementData(element, "groupCount")
		if groupCount > 0 then
			for key = 0, groupCount do
				if getElementData(element, "group_"..key) == tonumber(groupId) then
					return true
				end
			end
		else
			return false
		end
	else
		return false
	end
end



function light()
	if klikkTimer then return end
	if isTimer(klikkTimerRun) then return end
	klikkTimer = true
	klikkTimerRun = setTimer(function()
		klikkTimer = false
	end,1000,1)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if isPedInVehicle(localPlayer) and getVehicleController(vehicle) == localPlayer and getVehicleType(vehicle) ~= "BMX" then
		local vehicle = getPedOccupiedVehicle ( localPlayer )
		local vehLampaStat = tonumber(vehicle:getData("veh:light")) or 0
		if vehLampaStat == 0 then
			playSounds("lightswitch")
			triggerServerEvent("setVehLightState",vehicle,vehicle,2, localPlayer)
			vehicle:setData("veh:light",1)
			vehicle:setData("veh >> light",true)
		else
			triggerServerEvent("setVehLightState",vehicle,vehicle,1, localPlayer)
			vehicle:setData("veh:light",0)
			playSounds("lightswitch")
			vehicle:setData("veh >> light",false)
		end
	end
end
bindKey("l", "down", light)



local klikkTimer = false

function setVehicleLockState()
	if klikkTimer then return end
	if isTimer(klikkTimerRun) then return end
	klikkTimer = true
	klikkTimerRun = setTimer(function()
		klikkTimer = false
	end,1000,1)
	local vehicle = getPedOccupiedVehicle ( localPlayer )
	if vehicle then
		processLockUnlock(vehicle)
	else
		local int2 = getElementInterior(localPlayer)
		local dim2 = getElementDimension(localPlayer)
		local mx,my,mz = getElementPosition(localPlayer)
			for k,v in ipairs(getElementsByType("vehicle")) do
				local x,y,z = getElementPosition(v)
				local int = getElementInterior(v)
				local dim = getElementDimension(v)
				local dist = getDistanceBetweenPoints3D(x,y,z,mx,my,mz)
				if dist <= 3 and int2 == int and dim2 == dim then
					processLockUnlock(v)
					return
				end
			end
	end
end
bindKey("k", "down", setVehicleLockState)


setTimer(function()
if isPedInVehicle(localPlayer) then 
	if tonumber(getPedOccupiedVehicle(localPlayer):getData("veh:fuel") or 0) > 0 then

		if getPedOccupiedVehicle(localPlayer):getData("veh:motor") then
			local fogyaszt = 0
			if getElementSpeed(getPedOccupiedVehicle(localPlayer), 1) > 0 then
				fogyaszt = 1.1
			else
				fogyaszt = 0.6
			end
			getPedOccupiedVehicle(localPlayer):setData("veh:fuel",getPedOccupiedVehicle(localPlayer):getData("veh:fuel") - fogyaszt)
		end
	else
		getPedOccupiedVehicle(localPlayer):setData("veh:fuel",0)
		triggerServerEvent("vehicleStart",localPlayer,localPlayer,getPedOccupiedVehicle(localPlayer),false)
	end
end
end,1000*60*2,0)


setTimer(function()
	if isPedInVehicle(localPlayer) and getPedOccupiedVehicle(localPlayer) then 
		if getVehicleEngineState (getPedOccupiedVehicle(localPlayer)) then 
			if tonumber(getPedOccupiedVehicle(localPlayer):getData("veh:fuel") or 0) > 0 then	
			else
				getPedOccupiedVehicle(localPlayer):setData("veh:fuel",0)
				triggerServerEvent("vehicleStart",localPlayer,localPlayer,getPedOccupiedVehicle(localPlayer),false)
			end
		end
	end
end,1000,0)

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function getVehicleSpeed()
	local vehicle = getPedOccupiedVehicle(localPlayer)
    if isPedInVehicle(localPlayer) then
		if vehicle then
			local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
			return math.sqrt(vx^2 + vy^2 + vz^2) * 161		
		end
	end
    return 0
end
---



function dxDrawRectangleBox(left, top, width, height)
	dxDrawRectangle(left, top, width, height, tocolor(128,128,128,200))
	dxDrawRectangle(left-2, top, 2, height, tocolor(0,0,0,220))
	dxDrawRectangle(left+width, top, 2, height, tocolor(0,0,0,220))
	dxDrawRectangle(left, top-2, width, 2, tocolor(0,0,0,220))
	dxDrawRectangle(left, top+height, width, 2, tocolor(0,0,0,220))
end

function math.lerp(from, to, alpha)
    return from + (to - from) * alpha
end

function curving(scaleCalc)

	if scaleCalc < maxScaleCurve[1][1] then
		return maxScaleCurve[1][2]
	end

	for idx = 2,#maxScaleCurve do
		if scaleCalc < maxScaleCurve[idx][1] then
			local x1 = maxScaleCurve[idx - 1][1]
			local y1 = maxScaleCurve[idx - 1][2]
			local x2 = maxScaleCurve[idx][1]
			local y2 = maxScaleCurve[idx][2]

			local alpha = (scaleCalc - x1)/(x2 - x1);

			return math.lerp(y1,y2,alpha)
		end
	end

	return maxScaleCurve[#maxScaleCurve][2]
end




allVehicleName = {
	--pl.
	--[ID] = "Rendes név",
	--[400] = "BMW 750", 
}

function getVehicleRealName(vehicleid)
	if allVehicleName[vehicleid] then
		return allVehicleName[vehicleid]
	else 
		return getVehicleNameFromModel(vehicleid)
	end 
end





