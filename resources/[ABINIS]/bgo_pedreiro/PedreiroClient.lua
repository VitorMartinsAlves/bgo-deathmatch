trashN = 0
location = nil
local Trashesloc1 = {
{2694.233, 904.322, 10.496},
{ 2647.299, 792.516, 5.316},
{ 2636.421, 792.793, 5.316},
{ 2622.799, 789.484, 5.316},
{ 2614.237, 792.11, 5.316},
{ 2583.712, 795.58, 5.316},
{ 2566.834, 789.514, 5.316},
{ 2562.878, 800.538, 5.316},
{ 2574.973, 808.894, 5.316},
{ 2595.302, 810.17, 5.316},
{ 2601.596, 820.36, 5.316},
{ 2618.11, 828.998, 5.316},
{ 2624.1, 823.014, 5.316},
{ 2622.309, 839.51, 5.316},
{ 2634.428, 837.795, 5.316},
{ 2628.35, 852.816, 6.258},
}



local ctrls ={
--"sprint",
"jump",
"enter_exit",
"enter_passenger",
"fire", 
"crouch", 
"aim_weapon",
"next_weapon",
"previous_weapon",
}


addEvent("pedreiro.onWasteEnter", true)
addEventHandler("pedreiro.onWasteEnter", root, function()
	if (exports.bgo_employment:getPlayerJob(true) == "Pedreiro") and not (isElement(trashmarker)) then
		if location == nil then
			Mission()
		end
	end
end )

    
	
	
function Mission()
		local x1, y1, z1 = 2694.233, 904.322, 10.496 --unpack(location[trashN+1])
		takeTrashmarker = createColSphere ( x1, y1, z1, 3 ) 
		--exports.bgo_util:markPlayer(x1,y1,z1)
		
		theTrash = createObject(2960, x1, y1, z1)
		setObjectScale(theTrash, 0.3)
		setElementCollisionsEnabled (theTrash, false)
	
	
		--theTrash = createObject(2912,x1,y1,z1)
		--exports.bgo_util:markPlayer(x1,y1,z1)
		
		exports.Script_futeis:setGPS("Coordenada",x1,y1,z1)
		
		
		--setElementCollisionsEnabled(theTrash,false)
		--attachElements(takeTrashmarker,theTrash,0,0,0,0,0,0)
		
		
		
end


function randomMarkers()
		return unpack( Trashesloc1 [math.random (#Trashesloc1)] )
end


function takeTheTrash(theElement)
    if ( source == takeTrashmarker ) and ( theElement == localPlayer ) and ( isElement ( theTrash ) ) and not ( isPedInVehicle(localPlayer) ) and not ( doesPedHaveJetPack(localPlayer) ) then
		if (exports.bgo_employment:getPlayerJob(true) == "Pedreiro") then
    --if ( source == takeTrashmarker ) and ( theElement == localPlayer ) and not ( isPedInVehicle(localPlayer) ) and not ( doesPedHaveJetPack(localPlayer) ) then

		destroyElement(takeTrashmarker)
		for i,v in ipairs(ctrls) do
			toggleControl(v, false)
		end
		setPedWeaponSlot(localPlayer,0)
		triggerServerEvent("pedreiro.anim", resourceRoot,2)
		timer5 = setTimer(function() 
		--exports.bone_attach:attachElementToBone(theTrash,localPlayer,12,0.3,0.53,0.2,0,0,0)
		
		--local rot = getElementRotation(localPlayer)
		--exports.bone_attach:attachElementToBone(theTrash,localPlayer,3,0, 0.55, -0.1, 0, rot, 0) 
		
		
		-- teste exports.bone_attach:attachElementToBone(theTrash,localPlayer,3, 0, 0.42, 0.45, 0, 0, 0)
		

		
		
			triggerServerEvent("pedreiro.objeto", resourceRoot)
			
			triggerServerEvent("pedreiro.anim", resourceRoot,1)
		end, 700,1)
		local x1, y1, z1 = randomMarkers()
		info = createMarker (x1, y1, z1-0.9, "cylinder", 1, 51, 204, 0, 170 )
		trashmarker = createColSphere ( x1, y1, z1, 2 )  --createMarker (x1, y1, z1-0.9, "cylinder", 1, 51, 204, 0, 170 )
		--exports.bgo_util:markPlayer(x1,y1,z1)
		exports.Script_futeis:setGPS("Coordenada",x1,y1,z1)
	end
	end
end
addEventHandler ( "onClientColShapeHit", root, takeTheTrash) 





function throwing(theElement)
    --if ( source == trashmarker ) and ( theElement == localPlayer) and (isElement(theTrash)) and ( exports.bone_attach:isElementAttachedToBone(theTrash) == true ) then
    if ( source == trashmarker ) and ( theElement == localPlayer) then
		destroyElement(trashmarker)
		
		--timer2 = setTimer(function()
		--	exports.bone_attach:detachElementFromBone(theTrash)
		--end,550,1)
		
		destroyElement(info)
		--setElementFrozen(localPlayer, true)
		
		toggleAllControls ( false ) 
		 
		pay(theElement)
	end
end
--addEventHandler("onClientMarkerHit",getRootElement(),throwing) 
addEventHandler ( "onClientColShapeHit", root, throwing) 

function pay(thePlayer)
    if ( thePlayer == localPlayer) and not isTimer(paytimer) then
			exports.bgo_hud:drawProgressBar("PedreiroPro", "Coletando Dados...", 255, 200, 0, 10000)
			unloadsound = playSFX("genrl", 76, 0, true)
			paytimer = setTimer(function()
			for i,v in ipairs(ctrls) do
			toggleControl(v, true)
			end
			stopSound(unloadsound)
			triggerServerEvent("pedreiro.pay", resourceRoot)
			playSFX("genrl", 77, 2, false)
			triggerServerEvent("pedreiro.anim", resourceRoot,2)
			triggerServerEvent("pedreiro.removeobjeto", resourceRoot, 1)
			exports.bone_attach:detachElementFromBone(theTrash)
			timer1 = setTimer(function()
			playSFX("genrl", 32, 10, false)
			destroyElement(theTrash)
			triggerServerEvent("pedreiro.removeobjeto", resourceRoot, 2)
			
			trashN = trashN + 1
			exports.bgo_hud:drawStat("PedreiroID", "Entreguei", trashN.." Caixas", 255, 200, 0)
			Mission()
			--setElementFrozen(localPlayer, false)
			toggleAllControls ( true )
			end,1000,1)

			end,10000,1)
    end
end
--addEventHandler("onClientMarkerHit",getRootElement(),pay) 

function onTakeJob( job )
    if ( job == "Pedreiro" ) then 
		exports.bgo_hud:drawStat("PedreiroID", "Entreguei", trashN.." Caixas", 255, 200, 0)
    end
end
addEventHandler ("onClientPlayerGetJob", localPlayer, onTakeJob)

function delelem()
	if (exports.bgo_employment:getPlayerJob(true) == "Pedreiro") then
		trashN = 0
		location = nil
		if isElement(trashmarker) then destroyElement(trashmarker) end
		if isElement(info) then destroyElement(info) end
	
		if isElement(takeTrashmarker) then destroyElement(takeTrashmarker) end
		if isTimer(timer1) then killTimer(timer1) end
		if isTimer(timer2) then killTimer(timer2) end
		if isTimer(timer3) then killTimer(timer3) end
		if isTimer(timer4) then killTimer(timer4) end
		if isTimer(paytimer) then killTimer(paytimer) end
		if isTimer(timer5) then killTimer(timer5) end  
		if isElement(unloadsound) then stopSound(unloadsound) end
		if isElement(theTrash) then destroyElement(theTrash) end
		triggerServerEvent("pedreiro.removeobjeto", resourceRoot, 2)
		toggleAllControls(true)
		setPedAnimation(localPlayer,false)
		exports.bgo_hud:drawStat("PedreiroID", "Entreguei", trashN.." Caixas", 255, 200, 0)
	end
end
addEvent( "onClientRentalVehicleHide",true)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
function onJobQuit(job)
    if ( job == "Pedreiro" ) then 
		trashN = 0
		location = nil
		if isElement(trashmarker) then destroyElement(trashmarker) end
		if isElement(info) then destroyElement(info) end
		if isElement(takeTrashmarker) then destroyElement(takeTrashmarker) end
		if isTimer(timer1) then killTimer(timer1) end
		if isTimer(timer2) then killTimer(timer2) end
		if isTimer(timer3) then killTimer(timer3) end
		if isTimer(timer4) then killTimer(timer4) end
		if isTimer(timer5) then killTimer(timer5) end
		if isTimer(paytimer) then killTimer(paytimer) end  
		if isElement(unloadsound) then stopSound(unloadsound) end
		if isElement(theTrash) then destroyElement(theTrash) end
		triggerServerEvent("pedreiro.removeobjeto", resourceRoot, 2)
		setPedAnimation(localPlayer,false)
		toggleAllControls(true)
		exports.bgo_hud:drawStat("PedreiroID", "", "", 255, 200, 0)
	end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)







--[[

function onClientPlayerDamage(attacker, weapon, bodypart, loss)
	if getElementData(localPlayer,"protecaoPedreiro") then
	cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", root, onClientPlayerDamage)]]--