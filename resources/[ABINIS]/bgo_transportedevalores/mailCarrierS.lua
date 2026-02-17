----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 18 Jan 2014
-- Resource: transporte/mailCarrier.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local vehIDs = {
[428] = 0.881, -- Pony (Pay Offset)
}

CARDBOARD_BOX = 1550

--local dist = {}			-- Table of Player Distances (Debug Only)
local packages = {}		-- Box Objects
local lastPay = {}

-- Payment Function
-------------------->>


	
	
	--local blip = createBlip (1657.4078369141,-1428.4007568359,13.073083877563, 42)
	--setElementData(blip,"blipName", "Trabalho de Sedex")
	
	
function deliverPackage(vehicle, distance, finishMission)
	if (lastPay[client]) then return end
	lastPay[client] = true
	setTimer(function(client) lastPay[client] = nil end, 15000, 1, client)
	
	local vehOffset = vehIDs[getElementModel(vehicle)]

	local progress = 1


	exports.bgo_admin:setPlayerPagamento(client)
	
	exports.bgo_bank:abastecer(client, 40000)
	
	if (not finishMission) then
		exports.bgo_hud:dm("Pacote entregue!", client, 255, 200, 0)
	else
		exports.bgo_hud:dm("Entrega Completada! Aqui está um bônus.", client, 255, 200, 0)
	end
	
	--if (not dist[client]) then dist[client] = 0 end
	--dist[client] = dist[client] + distance
	--outputChatBox("* Total Distance: "..dist[client].." meters ("..string.format("%.3f", (dist[client]/1609)).." miles)", client, 25, 255, 25)
end
addEvent("transporte.deliverPackage", true)
addEventHandler("transporte.deliverPackage", root, deliverPackage)

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
	--toggleAllControls(client, false, true, false)
	toggleControl(client, "enter_passenger", false)
	
	--for i,ctrl in ipairs({"forwards", "backwards", "left", "right", "walk"}) do
	--	toggleControl(client, ctrl, true)
	--end
	
	setVehicleDoorOpenRatio(vehicle, 4, 1, 500)
	setVehicleDoorOpenRatio(vehicle, 5, 1, 500)
end
addEvent("transporte.carryPackage", true)
addEventHandler("transporte.carryPackage", root, carryPackage)

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
		
		setVehicleDoorOpenRatio(vehicle, 4, 0, 500)
		setVehicleDoorOpenRatio(vehicle, 5, 0, 500)
	end, 1000, 1, client, vehicle)
end
addEvent("transporte.dropPackage", true)
addEventHandler("transporte.dropPackage", root, dropPackage)

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
	end
end
addEvent("transporte.terminateJob", true)
addEventHandler("transporte.terminateJob", root, terminateJob)

addEventHandler("onPlayerQuit", root, function()
	terminateJob(source)
end)

addEvent("onPlayerArrested", true)
addEventHandler("onPlayerArrested", root, function()
	terminateJob(source)
end)
