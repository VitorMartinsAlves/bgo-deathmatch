----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 18 Jan 2014
-- Resource: transporte/mailCarrier.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local vehIDs = {
[403] = 0.881, -- Pony (Pay Offset)
}

CARDBOARD_BOX = 1550

--local dist = {}			-- Table of Player Distances (Debug Only)
local packages = {}		-- Box Objects
local lastPay = {}
	
	
function deliverPackage(vehicle, distance, finishMission)
	if (lastPay[client]) then return end
	lastPay[client] = true
	setTimer(function(client) lastPay[client] = nil end, 15000, 1, client)
	local vehOffset = vehIDs[getElementModel(vehicle)]
	local progress = 1
	exports.bgo_admin:setPlayerPagamento(client)
	exports.bgo_fuel2:abastecer(client, 40000)
	
	--if (not finishMission) then
	--	exports.bgo_hud:dm("Pacote entregue!", client, 255, 200, 0)
	--else
	--	exports.bgo_hud:dm("Entrega Completada! Aqui está um bônus.", client, 255, 200, 0)
	--end
end
addEvent("transporteG.deliverPackage", true)
addEventHandler("transporteG.deliverPackage", root, deliverPackage)


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
addEvent("transporteG.terminateJob", true)
addEventHandler("transporteG.terminateJob", root, terminateJob)

addEventHandler("onPlayerQuit", root, function()
	terminateJob(source)
end)

addEvent("onPlayerArrested", true)
addEventHandler("onPlayerArrested", root, function()
	terminateJob(source)
end)
