trashN = 0
location = nil
local Trashesloc1 = {
{142.42367553711,-200.46145629883,1.5703315734863},
{204.31773376465,-202.72785949707,1.578125},
{240.66979980469,-226.56803894043,1.578125},
{240.01112365723,-166.40657043457,1.578125},
{239.99563598633,-122.40538787842,1.578125},
{240.87278747559,-86.240249633789,1.5703315734863},
{224.66146850586,-80.355361938477,1.578125},
{254.55995178223,-64.971206665039,1.578125},
{274.17462158203,-65.370544433594,1.578125},
{304.76391601563,-63.762660980225,1.578125},
}

local Trashesloc2 = {
{675.14544677734,-646.79650878906,16.3359375},
{689.04473876953,-640.53747558594,16.28870010376},
{688.97100830078,-583.68432617188,16.3359375},
{689.43579101563,-546.74975585938,16.3359375},
{746.67242431641,-537.05737304688,16.3359375},
{766.69897460938,-522.91778564453,16.3359375},
{789.39569091797,-523.44573974609,16.3359375},
{798.12097167969,-574.01141357422,16.3359375},
{806.69415283203,-607.41876220703,16.3359375},
{840.23046875,-576.21520996094,16.3359375},
}
local Trashesloc3 = {
{1261.4633789063,202.63641357422,19.546894073486},
{1286.53, 221.589, 19.555},
{1276.2105712891,238.19271850586,19.5546875},
{1291.4180908203,270.17434692383,19.5546875},
{1307.0999755859,308.86575317383,19.5546875},
{1344.1429443359,352.48513793945,19.5546875},
{1343.2404785156,388.04019165039,19.5546875},
{1368.0242919922,407.81234741211,19.660442352295},
{1377.1212158203,453.15048217773,19.878973007202},
{1413.0541992188,420.06747436523,19.827302932739},
}
local Trashesloc4 = {
{2216.890625,56.098163604736,26.484375},
{2215.1806640625,112.71943664551,26.484375},
{2237.6804199219,160.37084960938,27.156555175781},
{2292.1762695313,150.33686828613,26.484375},
{2302.1057128906,84.005157470703,26.484375},
{2300.857421875,31.363483428955,26.484375},
{2301.8049316406,-20.37718963623,26.484375},
{2286.3122558594,-39.760414123535,26.484375},
{2303.626953125,-74.953674316406,26.484375},
{2295.6096191406,-105.73859405518,26.476945877075},
}
local Trashesloc5 = {
{2261.917, -1477.939, 22.529},
{2247.724, -1476.463, 22.945},
{2229.568, -1475.667, 23.416},
{2205.066, -1464.564, 23.544},
{2204.570, -1449.708, 23.544},
{2204.010, -1433.032, 23.544},
{2203.836, -1408.913, 23.544},
{2169.046, -1393.510, 23.544},
{2138.537, -1409.911, 23.546},
{2138.457, -1439.989, 23.542},
}
local ctrls ={
"sprint",
"jump",
"enter_exit",
"enter_passenger",
"fire", 
"crouch", 
"aim_weapon",
"next_weapon",
"previous_weapon",
}
function randomt()
	local Table = math.random(1,5)
	if Table == 1 then 
		return Trashesloc1
	elseif Table == 2 then
		return Trashesloc2
	elseif Table == 3 then
		return Trashesloc3
	elseif Table == 4 then
		return Trashesloc4
	elseif Table == 5 then
		return Trashesloc5
	end
end

addEvent("GTITrashCollector.onWasteEnter", true)
addEventHandler("GTITrashCollector.onWasteEnter", root, function()
	if (exports.bgo_employment:getPlayerJob(true) == "Lixeiro") and not (isElement(theTrash)) then
		if location == nil then
			newMission()
		end
	end
end )
function Mission()
	if trashN < 10 then
		local x1, y1, z1 = unpack(location[trashN+1])
		takeTrashmarker = createColSphere ( x1, y1, z1, 1.5 ) 
		triggerServerEvent("GTITrashCollector.freeze", resourceRoot, false)
		blip = createBlipAttachedTo(takeTrashmarker, 0, 1.5, 51, 204, 0)
		theTrash = createObject(1264,x1,y1,z1)
					--exports.bgo_util:markPlayer(x1,y1,z1)
					exports.Script_futeis:setGPS("Coordenada", x1,y1,z1)
		setElementCollisionsEnabled(theTrash,false)
		attachElements(takeTrashmarker,theTrash,0,0,0,0,0,0)
		theArrow = createMarker ( x1, y1, z1, "arrow", 1, 51, 204, 0, 170 )
		attachElements(theArrow,theTrash,0,0,1.3,0,0,0)
	else
		if not isElement(paymarker) and not isTimer(paytimer) then
			triggerServerEvent("GTITrashCollector.freeze", resourceRoot, false)
			exports.bgo_hud:dm("Retornar ao despejo para receber o pagamento.", 255, 255, 0) 
			paymarker = createMarker (-1060.059, -1625.499, 76.367-1, "cylinder", 4, 255, 255, 0, 170 )
			
			--exports.bgo_util:markPlayer(-1060.059, -1625.499, 76.367)
			
			exports.Script_futeis:setGPS("Coordenada", -1060.059, -1625.499, 76.367)
			
			
			payblip = createBlipAttachedTo(paymarker,41)
		end
	end
end
function newMission()
	if (getElementModel(getPedOccupiedVehicle(localPlayer)) == 408) then
		location = randomt()
		local x1, y1, z1 = unpack(location[trashN+1])
		local loca = getZoneName(x1,y1,z1)
		exports.bgo_hud:dm("Você foi solicitado a pegar lixo "..loca, 255, 255, 0)
		takeTrashmarker = createColSphere ( x1, y1, z1, 1 ) 
		blip = createBlipAttachedTo(takeTrashmarker, 0, 3.5, 51, 204, 0)
		theTrash = createObject(1264,x1,y1,z1)
		setElementCollisionsEnabled(theTrash,false)
		attachElements(takeTrashmarker,theTrash,0,0,0,0,0,0)
		theArrow = createMarker ( x1, y1, z1, "arrow", 1, 51, 204, 0, 170 )
		--exports.bgo_util:markPlayer( x1, y1, z1)
		exports.Script_futeis:setGPS("Coordenada", x1,y1,z1)
		attachElements(theArrow,theTrash,0,0,1.3,0,0,0)
	end
end
addEvent("GTITrashCollector.createmarker", true)
addEventHandler("GTITrashCollector.createmarker", root, function(SX,SY,SZ,theVeh)
    if isElement(theTrash) then
        local dist = exports.bgo_util:getDistanceBetweenElements3D(localPlayer,theTrash)
        if ( dist < 40 ) and not (isElement(trashmarker))then
			trashmarker = createMarker (SX, SY, SZ, "cylinder", 1, 51, 204, 0, 170 )
			attachElements(trashmarker,theVeh,0,-5,-1.5,1,0,0)
		end
	end
end )



function takeTheTrash(theElement)
    if ( source == takeTrashmarker ) and ( theElement == localPlayer ) and ( isElement ( theTrash ) ) and not ( isPedInVehicle(localPlayer) ) and not ( doesPedHaveJetPack(localPlayer) ) then
		destroyElement(takeTrashmarker)
		destroyElement(blip)
		destroyElement(theArrow)
		triggerServerEvent("GTITrashCollector.freeze", resourceRoot, true)
		for i,v in ipairs(ctrls) do
			toggleControl(v, false)
		end
		setPedWeaponSlot(localPlayer,0)
		triggerServerEvent("GTITrashCollector.anim", resourceRoot,2)
		timer5 = setTimer(function()
			exports.bone_attach:attachElementToBone(theTrash,localPlayer,12,0.3,0.53,0.2,0,0,0)
			triggerServerEvent("GTITrashCollector.anim", resourceRoot,1)
		end, 700,1)
		triggerServerEvent("GTITrashCollector.marker", resourceRoot)
	end
end
addEventHandler ( "onClientColShapeHit", root, takeTheTrash) 


function throwing(thePlayer)
    if ( source == trashmarker ) and ( thePlayer == localPlayer) and (isElement(theTrash)) and ( exports.bone_attach:isElementAttachedToBone(theTrash) == true ) then
		triggerServerEvent("GTITrashCollector.anim", resourceRoot,3)
		for i,v in ipairs(ctrls) do
			toggleControl(v, true)
		end
		destroyElement(trashmarker)
		timer2 = setTimer(function()
			exports.bone_attach:detachElementFromBone(theTrash)
			local origX, origY, origZ = getElementPosition ( theTrash )
			local newZ = origZ + 3
			moveObject ( theTrash, 750, origX, origY, newZ )
		end,550,1)
		timer1 = setTimer(function()
			playSFX("genrl", 32, 10, false)
			destroyElement(theTrash)
			trashN = trashN + 1
			exports.bgo_hud:drawStat("TrashID", "Sacos de lixo", trashN.."/10", 255, 200, 0)
			Mission()
		end,1000,1)
	end
end
addEventHandler("onClientMarkerHit",getRootElement(),throwing) 


function pay(thePlayer)
    if ( source == paymarker ) and ( thePlayer == localPlayer) and isPedInVehicle(localPlayer) and trashN == 10 and not isTimer(paytimer) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if getElementModel( theVehicle ) == 408 then
			destroyElement(payblip)
			destroyElement(paymarker)
			toggleControl("enter_exit",false)
			exports.bgo_hud:drawProgressBar("TrashPro", "Descarga...", 255, 200, 0, 10000)
			setElementFrozen(theVehicle,true)
			unloadsound = playSFX("genrl", 76, 0, true)
			paytimer = setTimer(function()
				toggleControl("enter_exit",true)
				stopSound(unloadsound)
				triggerServerEvent("GTITrashCollector.pay", resourceRoot)
				playSFX("genrl", 77, 2, false)
				setElementFrozen(theVehicle,false)
				trashN = 0
				exports.bgo_hud:drawStat("TrashID", "Sacos de lixo", trashN.."/10", 255, 200, 0)
				newMission()
			end,10000,1)
		end
    end
end
addEventHandler("onClientMarkerHit",getRootElement(),pay) 

function onTakeJob( job )
    if ( job == "Lixeiro" ) then 
		exports.bgo_hud:drawStat("TrashID", "Sacos de lixo", trashN.."/10", 255, 200, 0)
    end
end
addEventHandler ("onClientPlayerGetJob", localPlayer, onTakeJob)

function delelem()
	if (exports.bgo_employment:getPlayerJob(true) == "Lixeiro") then
		trashN = 0
		location = nil
		if isElement(trashmarker) then destroyElement(trashmarker) end
		if isElement(takeTrashmarker) then destroyElement(takeTrashmarker) end
		if isTimer(timer1) then killTimer(timer1) end
		if isTimer(timer2) then killTimer(timer2) end
		if isTimer(timer3) then killTimer(timer3) end
		if isTimer(timer4) then killTimer(timer4) end
		if isTimer(paytimer) then killTimer(paytimer) end
		if isTimer(timer5) then killTimer(timer5) end
		if isElement(theArrow) then destroyElement(theArrow) end    
		if isElement(unloadsound) then stopSound(unloadsound) end
		if isElement(theTrash) then destroyElement(theTrash) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(payblip) then destroyElement(payblip) end
		if isElement(paymarker) then destroyElement(paymarker) end
		toggleAllControls(true)
		setPedAnimation(localPlayer,false)
		exports.bgo_hud:drawStat("TrashID", "Sacos de lixo", trashN.."/10", 255, 200, 0)
	end
end
addEvent( "onClientRentalVehicleHide",true)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
function onJobQuit(job)
    if ( job == "Lixeiro" ) then 
		trashN = 0
		location = nil
		if isElement(trashmarker) then destroyElement(trashmarker) end
		if isElement(takeTrashmarker) then destroyElement(takeTrashmarker) end
		if isTimer(timer1) then killTimer(timer1) end
		if isTimer(timer2) then killTimer(timer2) end
		if isTimer(timer3) then killTimer(timer3) end
		if isTimer(timer4) then killTimer(timer4) end
		if isTimer(timer5) then killTimer(timer5) end
		if isTimer(paytimer) then killTimer(paytimer) end
		if isElement(theArrow) then destroyElement(theArrow) end    
		if isElement(unloadsound) then stopSound(unloadsound) end
		if isElement(theTrash) then destroyElement(theTrash) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(payblip) then destroyElement(payblip) end
		if isElement(paymarker) then destroyElement(paymarker) end
		setPedAnimation(localPlayer,false)
		toggleAllControls(true)
		exports.bgo_hud:drawStat("TrashID", "", "", 255, 200, 0)
	end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)