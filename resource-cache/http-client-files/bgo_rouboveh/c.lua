local sx, sy = guiGetScreenSize()
scmp = (1/1920)*sx
local repairTimer
local function isInBoxEdited(x, y, xmin, ymin, xsize, ysize)
	 return x >= xmin and x <= xmin+xsize and y >= ymin and y <= ymin+ysize
end

local engineBackVeh = {[451] = true}

local partTable = {
{"door_lf_dummy", "Roubar"}
}

local function getNameFromPart(part)
	local returnVal = false
	for k, v in pairs(partTable) do
		if v[1] == part then
			returnVal = v[2]
			break
		end
	end
	return returnVal
end
local function hasPartGotProblem(v, part)
	local returnVal = false
	local lf, lb, rf, rb = getVehicleWheelStates(v)
	
	local lfd, rfd, lrd, rrd,bonnet,boot = getVehicleDoorState(v, 2), getVehicleDoorState(v, 3), getVehicleDoorState(v, 4), getVehicleDoorState(v, 5), getVehicleDoorState(v, 0), getVehicleDoorState(v, 1)
	if part == "door_lf_dummy" and lfd ~= 0 and lfd ~= 1 then
		returnVal = true
	end
	return returnVal
end
local function getPartPosition(element, part)
	local x, y, z = false, nil, nil
	if getElementType(element) == "vehicle" then
		x, y, z = getVehicleComponentPosition(element, part, "world")
		--end
	end
	return x,y,z
end
local function getPartImage(part)
	local returnVal = false
	part = getNameFromPart(part)
	if part then
		if string.find(part, "Porta") then
		end
	end
	return returnVal
end
local overPart = nil
local vehicleRepair = nil
local thePartName = false
addEventHandler("onClientRender", getRootElement(), function()
	--if not isElementWithinFixerColshape(localPlayer) then return end
	

	local vehicleTable = getElementsByType("vehicle", getRootElement(), true)

	if isTimer(repairTimer) then
		remaining, executesRemaining, totalExecutes = getTimerDetails(repairTimer)
		remaining = remaining / 1000
		dxDrawText(remaining,0,0,0,0)
		dxDrawRectangle(sx / 2 - 100,sy - 60,200,30,tocolor(0,0,0,200))
		dxDrawRectangle(sx / 2 - 100,sy - 60,200 - 200 * (remaining/(repairTime/1000)),30,tocolor(255,0,0,200))
		if thePartName then
			dxDrawText(thePartName,sx / 2 - dxGetTextWidth(thePartName,1.5)/2,sy - 60,0,0,tocolor(255,255,255,255),1.5)
		end
	end
	
	local cx, cy = getCursorPosition()
	if cx then
		cx, cy = cx*sx, cy*sy
	end
	overPart = nil
	local xov, yov, zov = nil, nil, nil
	
	if isPedInVehicle(localPlayer) then return end
	--if getElementData(localPlayer, "assalto") == true then
	if getElementData(localPlayer, "char:dutyfaction") == 23 or getElementData(localPlayer, "acc:id") == 1 then
    --if exports.exg_dashboard:isPlayerInFaction(thePlayer, 11) then return end
	local px, py, pz = getElementPosition(localPlayer)

	for kveh, v in pairs(vehicleTable) do
		local engx, engy = 0, 0
		local engrx, engry, engrz = 0, 0
		if getElementData(v, "AssaltoAlready") ~= true and not isVehicleBlown(v) then --and isElementWithinFixerColshape(v) then
			local components = getVehicleComponents(v)
			for k in pairs(components) do
				if getNameFromPart(k) then
					local x, y, z = getPartPosition(v, k)
					if x then
						local scx, scy = getScreenFromWorldPosition(x,y,z,0,false)
						if getDistanceBetweenPoints3D(px, py, pz, x,y,z) < 2.3 then
							local scx, scy = getScreenFromWorldPosition(x,y,z,0,false)
							if scx then
								--if hasPartGotProblem(v, k) then
									if cx then
										if isInBoxEdited(cx, cy, scx-(30*scmp), scy-(10*scmp), (120*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(40*scmp))) then
											if overPart then
												--if getDistanceBetweenPoints3D(xov, yov, zov, getElementPosition(localPlayer)) > getDistanceBetweenPoints3D(x, y, z, getElementPosition(localPlayer)) then
												--	overPart = k
												--	xov, yov, zov = x,y,z
												--end
											else
												overPart = k
												vehicleRepair = v
												xov, yov, zov = x,y,z
											end
										end
									end
									if cx then
										if isInBoxEdited(cx, cy, scx-(30*scmp), scy-(10*scmp), (120*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(40*scmp))) and overPart == k then
											dxDrawRectangle(scx-(30*scmp), scy-(10*scmp), dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 230))
											dxDrawText(getNameFromPart(k), scx, scy, scx+dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial"), scy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
										else
											dxDrawRectangle(scx-(30*scmp), scy-(10*scmp), dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
											dxDrawText(getNameFromPart(k), scx, scy, scx+dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial"), scy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
										end
									else
										dxDrawRectangle(scx-(30*scmp), scy-(10*scmp), dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
										dxDrawText(getNameFromPart(k), scx, scy, scx+dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial"), scy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
									end
								--end
							end
						end
					end
				end
			end
			local vx, vy, vz = getElementPosition(v)
			local m = getElementMatrix(v)
			
			local x, y, z = getPartPosition(v, "bonnet_dummy")
			if x and not engineBackVeh[getElementModel(v)] then
				engx, engy = getScreenFromWorldPosition(x,y,z,0,false)
				if engy then
					 engy = engy  + (80*scmp)
				end
			end
			if (engx == 0 and engy == 0) then
				engx, engy = getScreenFromWorldPosition((-m[2][1])+vx,(-m[2][2])+vy,m[2][3]+vz,0,false)
				engrx, engry, engrz = ((-m[2][1])*2)+vx,((-m[2][2])*2)+vy,((m[2][3])*2)+vz
			end
			if getVehicleType(v) ~= "Automobile" then
				engx, engy = getScreenFromWorldPosition((m[4][1]),(m[4][2]),m[4][3],0,false)
				engrx, engry, engrz = (m[4][1]),(m[4][2]),(m[4][3])
			end
	
		end
	end
	end
end)
local repairPart = nil
local vehicleRepairSave = nil




addEventHandler("onClientClick", root, function(button, state)
	if state ~= "down" or repairPart or not overPart then return end
	if isPedInVehicle(localPlayer) then return end

	--if exports.exg_dashboard:isPlayerInFaction(thePlayer, 11) then return end
		--if getElementData(localPlayer, "char:dutyfaction") == 3 then

		
		if getElementData(vehicleRepair, "veh:owner") == getElementData(localPlayer, "char:id") then 
		outputChatBox("#FFA000[BTC ERROR] #FFFFFFVocê não pode roubar seu próprio veiculo.", 255,255,255, true)
		return 
		end

		if overPart then
		repairPart = overPart
		thePartName = getNameFromPart(overPart) or overPart
		vehicleRepairSave = vehicleRepair
		--setElementData(localPlayer, "playerAnimation", true)


		setElementData(vehicleRepairSave, "AssaltoAlready", true)
		
		addEventHandler( "onClientPlayerQuit",localPlayer,function()
			setElementData(vehicleRepairSave, "AssaltoAlready", false)
		end
		)


		triggerServerEvent("assaltoveiculo2", localPlayer)
		repairTimer = setTimer(function()
			--stopSound(soundEffect)
			
			triggerServerEvent("assaltoveiculo", localPlayer, repairPart, vehicleRepairSave, cost)
			
			exports.bgo_chat:sendLocalMeMessage(localPlayer, "Conseguiu quebrar a fechadura do veiculo!")
	
			repairPart = nil
			setTimer(function()
				setElementData(vehicleRepairSave, "AssaltoAlready", false)
			end, 1000, 1)
		end, repairTime, 1)
	--end
	end

end)



--[[
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName)
	if getElementType(source) == "player" and (dataName == "playerAnimation" and getElementData(source, dataName) == true) then
		if source == localPlayer then
			setElementFrozen(localPlayer, true)
		end
		setPedAnimation(source, "BOMBER","BOM_Plant_Loop", repairTime, true, false, false)
		--exports['evrpsound-system']:playElementSound(source, repairSoundPath, false,0,12,1)
		setTimer(function(elementEdited)
			if elementEdited == localPlayer then
				setElementFrozen(localPlayer, false)
			end
			setPedAnimation(elementEdited, "BOMBER","BOM_Plant_2Idle", -1, false, false, true)
			setElementData(elementEdited, "playerAnimation", false)
			setTimer(function(elementEdited)
				setPedAnimation(elementEdited)
			end, 1000, 1, elementEdited)
		end, repairTime, 1, source)
	end
end)]]--