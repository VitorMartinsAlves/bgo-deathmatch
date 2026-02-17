local poste    = {}
local escada1   = {}
local escada2   = {}
local blip     = {}
local zoneP    = {}
local timerFre = {}



local vehIDs = {
[552] = 0.881, -- Pony (Pay Offset)
}

CARDBOARD_BOX = 1550

--local dist = {}			-- Table of Player Distances (Debug Only)
local packages = {}		-- Box Objects
local lastPay = {}

-- Payment Function
-------------------->>
	
function deliverPackage(vehicle, distance, finishMission)
	if (lastPay[client]) then return end
	lastPay[client] = true
	setTimer(function(client) lastPay[client] = nil end, 15000, 1, client)
	local vehOffset = vehIDs[getElementModel(vehicle)]
	local progress = 1
	exports.bgo_admin:setPlayerPagamento(client)
	if (not finishMission) then
		exports.bgo_hud:dm("Pacote entregue!", client, 255, 200, 0)
	else
		exports.bgo_hud:dm("Entrega Completada! Aqui está um bônus.", client, 255, 200, 0)
	end
end
addEvent("Eletrecista.deliverPackage", true)
addEventHandler("Eletrecista.deliverPackage", root, deliverPackage)

-- Sync Packages
----------------->>

function carryPackage(vehicle)
	local x,y,z = getElementPosition(client)
	local rot = getElementRotation(client)
		-- Just in case
	if (packages[player]) then
		destroyElement(packages[player])
		packages[player] = nil
	end
	
	packages[client] = createObject(CARDBOARD_BOX, x, y, z+1.5, 0, 0, rot)
	attachElements(packages[client], client, -0.02, 0.450, 0.676)
	setElementCollisionsEnabled(packages[client], false)
	exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 500, false, false, true, true)

	toggleControl(client, "enter_passenger", false)
	
	setVehicleDoorOpenRatio(vehicle, 4, 1, 500)
	setVehicleDoorOpenRatio(vehicle, 5, 1, 500)
end
addEvent("Eletrecista.carryPackage", true)
addEventHandler("Eletrecista.carryPackage", root, carryPackage)



function dropPackage(vehicle)

	exports.bgo_anims:setJobAnimation(client, "CARRY", "putdwn", 1000, false, false, true, false)
	setTimer(function(player, vehicle)
		exports.bgo_anims:setJobAnimation(player)
		toggleControl(player, "enter_passenger", true)
		toggleAllControls(player, true, true, false)
		if (packages[player]) then
			destroyElement(packages[player])
			packages[player] = nil
		end
	end, 1000, 1, client, vehicle)

end
addEvent("Eletrecista.dropPackage", true)
addEventHandler("Eletrecista.dropPackage", root, dropPackage)



function createScada (player)

        if isElement(escada1[player]) then
        	     destroyElement(escada1[player])
	     end
	     if isElement(escada2[player]) then
	         destroyElement(escada2[player])
	 end
		     triggerClientEvent(player, 'create:escada', resourceRoot)

			


			 bindKey( player, "e", "down", escadaserver )
			 
 end
addEvent('create:server', true)
addEventHandler('create:server', resourceRoot,createScada)
 
function escadaserver (player)
if getElementData(player, "job") == "Eletrecista" then

        if isElement(escada1[player]) then
        	     destroyElement(escada1[player])
	     end
	     if isElement(escada2[player]) then
	         destroyElement(escada2[player])
	 end
			 
		     triggerClientEvent(player, 'create:escada', resourceRoot)
			 
			-- triggerClientEvent(player, "bgo>info", player, "Eletricista", "pressione E para alterar a posição da escada")
			 
			 			
triggerClientEvent(player, "bgo>info", player,"Eletricista", "pressione E para alterar a posição da escada", "info")
end 
end

addEvent('create:escada:server', true)
addEventHandler('create:escada:server', resourceRoot,
function (player, x,y,z,rz)
--[[
     	     if not escada[player] then 
    		     escada[player] = {}
     		 end
     	     escada[player][1] = createObject(1437, x,y,z, 337, 0, rz)
         	 escada[player][2] = createObject(1437, x,y,z + 4.3, 337, 0, rz)
    		 attachElements (escada[player][1], player, 0, 2.7, 0, 337, 0, 0)
    	     attachElements (escada[player][2], player, 0, 5.5, 4.3, 337, 0, 0)
    		 detachElements (escada[player][1], player )
    	     detachElements (escada[player][2], player )
    		 setElementCollisionsEnabled(escada[player][1], false)
    		 setElementCollisionsEnabled(escada[player][2], false)
    		 triggerClientEvent(player, 'set:colision', resourceRoot, escada[player][1], escada[player][2])
			 ]]--
			 
			 
     	     escada1[player] = createObject(1437, x,y,z, 337, 0, rz)
         	 escada2[player] = createObject(1437, x,y,z + 4.3, 337, 0, rz)
    		 attachElements (escada1[player], player, 0, 2.7, 0, 337, 0, 0)
    	     attachElements (escada2[player], player, 0, 5.5, 4.3, 337, 0, 0)
    		 detachElements (escada1[player], player )
    	     detachElements (escada2[player], player )
    		 setElementCollisionsEnabled(escada1[player], false)
    		 setElementCollisionsEnabled(escada2[player], false)
    		 triggerClientEvent(player, 'set:colision', resourceRoot, escada1[player], escada2[player])
end)

function removeComponent (player)
     unbindKey( player, "e", "down", removeComponent )

         if isElement(escada1[player]) then
        	     destroyElement(escada1[player])
	     end
	     if isElement(escada2[player]) then
	         destroyElement(escada2[player])
	 end
end



function repairPoste (player)

		 if not isTimer(timerFre[player]) then
    	     setElementFrozen(player, true)
    		 setPedAnimation(player, "bd_fire", "wash_up", -1, true, false, false, false)
    		 local x,y,z = getElementPosition(player)
             local nearPlayer = getElementsWithinRange(x, y, z, 500, "player")
    	     for i=1, #nearPlayer do 
    		     triggerClientEvent(nearPlayer[i], "eletrecista:effect", resourceRoot, nearPlayer[i], player, player)
    		 end	
			 
			 unbindKey( player, "e", "down", escadaserver )	
			 
             timerFre[player] = setTimer(function(player)
                 setElementFrozen(player, false)
                 setPedAnimation(player)	
			 
			 
			 triggerClientEvent(player, "InniciarOutro", resourceRoot)
			 exports.bgo_admin:setPlayerPagamento(player)
	      		 bindKey( player, "e", "down", removeComponent )		 
             end, 27000, 1, player)		 
	end
end
addEvent('repararP:server', true)
addEventHandler('repararP:server', resourceRoot,repairPoste)

function enterMec (player, seat, jacked)
     if (getElementModel(source) == 552) then
	   --if escada[player] then
	    	 if isElement(escada1[player]) then
		      cancelEvent()
		     -- outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê não pode embarcar no veiculo com a escada no poste, pressione E para a escada ser guardada!.", player, 255,255,255, true)
			  
			 -- triggerClientEvent(player, "bgo>info", player, "Eletricista", "Você não pode embarcar no veiculo com a escada no poste, pressione E para a escada ser guardada!")
			  
triggerClientEvent(player, "bgo>info", player,"Eletricista", "Você não pode embarcar no veiculo com a escada no poste, pressione E para a escada ser guardada!", "aviso")
		      else
			  end
		-- end
	 end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterMec)


addEventHandler("onPlayerQuit", root,
function()
        if isElement(escada1[source]) then
        	     destroyElement(escada1[source])
	     end
	     if isElement(escada2[source]) then
	         destroyElement(escada2[source])
	 end
end
)




-- Terminate Job
----------------->>

function terminateJob(player)
	if (not client) then client = player end
	if (packages[client]) then
		destroyElement(packages[client])
		packages[client] = nil
		exports.bgo_anims:setJobAnimation(client)
		toggleControl(client, "enter_passenger", true)
		toggleAllControls(client, true, true, false)
		
        if isElement(escada1[player]) then
        	     destroyElement(escada1[player])
	     end
	     if isElement(escada2[player]) then
	         destroyElement(escada2[player])
	 end
	 
	 
	 
	end
end
addEvent("Eletrecista.terminateJob", true)
addEventHandler("Eletrecista.terminateJob", root, terminateJob)

addEventHandler("onPlayerQuit", root, function()
	terminateJob(source)
end)

addEvent("onPlayerArrested", true)
addEventHandler("onPlayerArrested", root, function()
	terminateJob(source)
end)
