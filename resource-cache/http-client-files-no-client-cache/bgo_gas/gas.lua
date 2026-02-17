----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 18 Jan 2014
-- Resource: gas/gasr.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local vehIDs = {
[478] = {3.089, 5}, -- Pony (Offset Radius)
--[440] = {3.668, 8}, -- Boxville (Offset Radius)
}

local delMarker			-- Delivery Marker
local delBlip			-- Delivery Blip
local distance			-- Distance Between yourself and delMarker (for payment purposes)
local holdingPackage	-- Bool if Player is Holding Package
local loadMarkerA		-- Load/Unload Marker on Mailvan (Depot)
local loadMarkerB		-- Load/Unload Marker on Mailvan (Delivery)
local mailvan			-- The vehicle you're using for the job
local oldLoc = 0		-- Last Delivery Location
local packages = 0		-- Record of Packages in Truck
local pickups = {} 		-- Box Pickups @ Warehouse
local totalPickups = 0	-- Record of Total Boxes to be Picked up
local wareMarker		-- Final Warehouse Marker
local wareBlip			-- Final Warehouse Blip
local timerA
local timerB

CARDBOARD_BOX = 918

function isgasr(player)
	if (player ~= localPlayer) then return false end
	if (exports.bgo_employment:getPlayerJob(true) == "Entregador de Gas") then return true end
	return false
end

-- Load Packages
----------------->>

function collectPackages(player, seat, vehicle)
	if (not source) then source = vehicle end
	if (seat ~= 0 or not isgasr(player) or not vehIDs[getElementModel(source)] or isElement(wareMarker)) then return end
	if (packages > 0) then return end
	
	terminateJob("Entregador de Gas")
	
	mailvan = source
	addEventHandler("onClientElementDestroy", mailvan, terminateJobOnMailvanDestroy)
	addEventHandler("onClientVehicleExplode", mailvan, terminateJobOnMailvanDestroy)
	
	local x,y,z = getElementPosition(player)
	local zone = "Los Santos" --getZoneName(x,y,z, true)
	if (not deposito[zone]) then
		exports.bgo_hud:dm("Você está muito longe de um depósito. Dirija mais perto de uma cidade e entre novamente em seu veículo.", 200, 100, 0)
		return
	end
	
	local maxPackages = 10 --vehIDs[getElementModel(mailvan)][2]
	
	local loc
	local usedLocs = {}
	local pickupLoc = {}
	for i=1,maxPackages do
		loc = math.random(#deposito[zone])
		while usedLocs[loc] do
			loc = math.random(#deposito[zone])
		end
		pickupLoc[i] = deposito[zone][loc]
		usedLocs[loc] = true
		totalPickups = totalPickups + 1
	end
		-- Destroy any Duplicates
	for pickup,blip in pairs(pickups) do
		destroyElement(blip)
		removeEventHandler("onClientPickupHit", pickup, pickupPackage)
		destroyElement(pickup)
	end
	pickups = {}
	
	for i,v in ipairs(pickupLoc) do
		local pickup = createPickup(v[1], v[2], v[3]+0.5, 3, CARDBOARD_BOX, 0)
			exports.bgo_util:markPlayer(v[1], v[2], v[3])
		pickups[pickup] = createBlipAttachedTo(pickup, 0, 1, 25, 255, 25)
		addEventHandler("onClientPickupHit", pickup, pickupPackage)
	end
	exports.bgo_hud:dm("tem "..maxPackages.." gas no armazém que precisam ser entregues. Pegue-os e coloque-os em seu veiculo.", 255, 200, 0)
	exports.bgo_hud:drawStat("gas", "gas carregados", "0/"..maxPackages, 255, 200, 0)
end
addEventHandler("onClientVehicleEnter", root, collectPackages)

function pickupPackage(player, dim)
	if (not isgasr(player) or not dim or isPedInVehicle(player)) then return end
	if (holdingPackage) then return end
	if (not isElement(mailvan)) then
		exports.bgo_hud:dm("Você deve ter um veiculo spawnado para carregar um gas nele.", 200, 100, 0)
		return
	end
		-- Attach Box to Player
	holdingPackage = true
	triggerServerEvent("gas.carryPackage", resourceRoot, mailvan)
		-- Attach Load Marker to Vehicle
	local radius = vehIDs[getElementModel(mailvan)][1]
	local offx, offy, offz = 0, -radius, -getElementDistanceFromCentreOfMassToBaseOfModel(mailvan)
	local x,y,z = getElementPosition(mailvan)
	loadMarkerA = createMarker(x, y, z, "cylinder", 1, 255, 200, 0, 150)
	exports.bgo_util:markPlayer(x, y, z)
	attachElements(loadMarkerA, mailvan, offx, offy, offz)
	addEventHandler("onClientMarkerHit", loadMarkerA, placePackageInTruck)
	
	destroyElement(pickups[source])
	removeEventHandler("onClientPickupHit", source, pickupPackage)
	destroyElement(source)
	pickups[source] = nil
	totalPickups = totalPickups - 1
	exports.bgo_hud:dm("Agora que você tem o gas, coloque-o na parte de trás de seu veiculo.", 255, 200, 0)
end

function placePackageInTruck(player, dim)
	if (not isgasr(player) or not dim) then return end
	triggerServerEvent("gas.dropPackage", resourceRoot, mailvan)
	timerA = setTimer(function(player)
		holdingPackage = nil
		removeEventHandler("onClientMarkerHit", loadMarkerA, placePackageInTruck)
		destroyElement(loadMarkerA)
		loadMarkerA = nil
		
		packages = packages + 1
		
		if (totalPickups > 0) then
			exports.bgo_hud:dm("gas carregado no veículo. tem "..totalPickups.." gas deixados para serem carregados.", 255, 200, 0)
			exports.bgo_hud:drawStat("gas", "Gas Carregados", (packages).."/"..(totalPickups+packages), 255, 200, 0)
		else
			createDestinations(player, mailvan, true)
		end
	end, 1000, 1, player)
end

-- Deliver Packages
-------------------->>

function createDestinations(player, mailvan, isLoaded)
	if (not isgasr(player) or not isElement(mailvan) or isElement(delMarker)) then return end
	if (packages <= 0) then 
		returnToWarehouse(player)
	return end
	
	local x1,y1,z1 = getElementPosition(player)
	local zone = "Los Santos" --getZoneName(x1, y1, z1, true)
	local locTable = delivery[zone]
	if (not locTable) then return end
	
	local loc = math.random(#locTable)
	while (oldLoc == loc) do
		loc = math.random(#locTable)
	end
	oldLoc = loc
	
	local x, y, z = locTable[loc][1], locTable[loc][2], locTable[loc][3]
	delMarker = createMarker(x, y, z, "cylinder", 1, 255, 200, 0, 150)
		exports.bgo_util:markPlayer(x, y, z)
	delBlip = createBlipAttachedTo(delMarker, 51)
	
	distance = getDistanceBetweenPoints3D(x1, y1, z1, x, y, z)
	
	local zone = getZoneName(x, y, z)
	if (isLoaded) then
		exports.bgo_hud:dm("Todos os Gas foram carregados. Seu primeiro gas deve ser entregue a "..zone, 255, 200, 0)
		local maxPackages = 10 --vehIDs[getElementModel(mailvan)][2] or 5
		exports.bgo_hud:drawStat("gas", "Gas Carregados", (maxPackages).."/"..(maxPackages), 255, 200, 0)
	else
		exports.bgo_hud:dm("Entregar um gas para o próximo local de entrega em "..zone, 255, 200, 0)
	end
	addEventHandler("onClientVehicleExit", mailvan, unloadTruck)
	addEventHandler("onClientMarkerHit", delMarker, deliverPackage)
end

function unloadTruck(player, seat)
	if (not isgasr(player) or seat ~= 0 or not isElement(mailvan)) then return end
	if (isElement(loadMarkerB)) then return end	
	
	local x1,y1 = getElementPosition(player)
	local x2,y2 = getElementPosition(delMarker)
	if (getDistanceBetweenPoints2D(x1,y1, x2,y2) > 40) then 
		exports.bgo_hud:dm("Aproxime-se do seu local de entrega antes de descarregar o gas.", 200, 100, 0)
	return end
	
	setElementFrozen(mailvan, true)
	local radius = vehIDs[getElementModel(mailvan)][1]
	local offx, offy, offz = 0, -radius, -getElementDistanceFromCentreOfMassToBaseOfModel(mailvan)
	local x,y,z = getElementPosition(mailvan)
	loadMarkerB = createMarker(x, y, z, "cylinder", 1, 255, 200, 0, 150)
		exports.bgo_util:markPlayer(x, y, z)
	attachElements(loadMarkerB, mailvan, offx, offy, offz)
	addEventHandler("onClientMarkerHit", loadMarkerB, takeOutPackage)
	
	exports.bgo_hud:dm("Pegue um gas e deixe-o no ponto de entrega.", 255, 200, 0)
end

function takeOutPackage(player, dim)
	if (not isgasr(player) or not dim or not isElement(mailvan)) then return end
	holdingPackage = true
	triggerServerEvent("gas.carryPackage", resourceRoot, mailvan)
	removeEventHandler("onClientMarkerHit", loadMarkerB, takeOutPackage)
	destroyElement(loadMarkerB)
	loadMarkerB = nil
	
	packages = packages - 1
	
	local maxPackages = 10 --vehIDs[getElementModel(mailvan)][2] or 5
	exports.bgo_hud:drawStat("gas", "Gas Carregados", packages.."/"..maxPackages, 255, 200, 0)
	setElementFrozen(mailvan, false)
end
	
function deliverPackage(player, dim)
	if (not isgasr(player) or not dim or not isElement(mailvan)) then return end
	local x1,y1,z1 = getElementPosition(player)
	local x2,y2,z2 = getElementPosition(source)
	if (z1 > z2+1.5 or z1 < z2-0.5) then return end
	if (not holdingPackage) then
		exports.bgo_hud:dm("Você precisa estar carregando um gas para fazer uma entrega", 200, 100, 0)
		return
	end
	
	triggerServerEvent("gas.dropPackage", resourceRoot, mailvan)
	timerA = setTimer(function(player)
		holdingPackage = nil
		removeEventHandler("onClientMarkerHit", delMarker, deliverPackage)
		destroyElement(delMarker)
		delMarker = nil
		destroyElement(delBlip)
		delMarker = nil
		
		removeEventHandler("onClientVehicleExit", mailvan, unloadTruck)
		
		triggerServerEvent("gas.deliverPackage", resourceRoot, mailvan, distance)
		
		timerB = setTimer(createDestinations, 5000, 1, player, mailvan)
	end, 1000, 1, player)
end

-- Return to Warehouse
----------------------->>

function returnToWarehouse(player)
	if (not isgasr(player)) then return end
	
	local x1,y1,z1 = getElementPosition(player)
	local zone = "Los Santos" --getZoneName(x1, y1, z1, true)

	local locTable = warehouseReturn[zone]
	if (not locTable) then return end
	local x, y, z = locTable[1], locTable[2], locTable[3]
	wareMarker = createMarker(x, y, z, "cylinder", 4, 255, 200, 0, 150)
		exports.bgo_util:markPlayer(x, y, z)
	addEventHandler("onClientMarkerHit", wareMarker, onWarehouseReturn)
	wareBlip = createBlipAttachedTo(wareMarker, 51)
	
	local exp = getElementData(player,"LSys:EXP") or 0
	setElementData(player,"LSys:EXP",tonumber(exp)+5)
	exports.Scripts_Dxmessages:outputDx(player,"#ffffff[ UP #FFFFFF] - Você Ganhou +1 De Experiência #FFFFFF( ".. tonumber(exp)+5 .."/20 #ffffff)",player,0,255,0,true)
	playSoundFrontEnd (101 )

	distance = getDistanceBetweenPoints3D(x1, y1, z1, x, y, z)
	exports.bgo_hud:dm("Todos os gas entregues! Retornar ao armazém para mais trabalho.", 255, 200, 0)
end

function onWarehouseReturn(player, dim)
	if (not isgasr(player) or not dim or not isPedInVehicle(player)) then return end
	local vehicle = getPedOccupiedVehicle(player)
	if (vehicle ~= mailvan) then return end
	
	removeEventHandler("onClientMarkerHit", wareMarker, onWarehouseReturn)
	destroyElement(wareMarker)
	destroyElement(wareBlip)
	wareMarker = nil
	wareBlip = nil
	
	triggerServerEvent("gas.deliverPackage", resourceRoot, mailvan, distance, true)
	timerB = setTimer(collectPackages, 4000, 1, player, 0, vehicle)
end

-- Terminate Job
---------------->>

function terminateJob(job)
	if (job ~= "Entregador de Gas") then return end
	
	for pickup,blip in pairs(pickups) do
		destroyElement(blip)
		removeEventHandler("onClientPickupHit", pickup, pickupPackage)
		destroyElement(pickup)
	end
	
	pickups = {}
	totalPickups = 0
	packages = 0
	
	if (mailvan) then
		removeEventHandler("onClientElementDestroy", mailvan, terminateJobOnMailvanDestroy)
		removeEventHandler("onClientVehicleExplode", mailvan, terminateJobOnMailvanDestroy)
		mailvan = nil
	end
	
	holdingPackage = nil
	
	if (isElement(loadMarkerA)) then
		removeEventHandler("onClientMarkerHit", loadMarkerA, placePackageInTruck)
		destroyElement(loadMarkerA)
	end
	loadMarkerA = nil
	
	if (isElement(loadMarkerB)) then
		removeEventHandler("onClientMarkerHit", loadMarkerB, takeOutPackage)
		destroyElement(loadMarkerB)
	end
	loadMarkerB = nil
	
	oldLoc = 0
	
	if (isElement(delMarker)) then
		removeEventHandler("onClientMarkerHit", delMarker, deliverPackage)
		destroyElement(delMarker)
	end
	delMarker = nil
	
	if (isElement(delBlip)) then
		destroyElement(delBlip)
	end
	delBlip = nil
	
	distance = nil
	
	if (isElement(wareMarker)) then
		removeEventHandler("onClientMarkerHit", wareMarker, onWarehouseReturn)
		destroyElement(wareMarker)
	end
	wareMarker = nil
	
	if (isElement(wareBlip)) then
		destroyElement(wareBlip)
	end
	wareBlip = nil
	
	if (isTimer(timerA)) then
		killTimer(timerA)
		timerA = nil
	end
	if (isTimer(timerB)) then
		killTimer(timerB)
		timerB = nil
	end
		
	exports.bgo_hud:drawStat("gas", "", "", 255, 200, 0)
	triggerServerEvent("gas.terminateJob", resourceRoot, ig_shift)
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, terminateJob)

function terminateJobOnMailvanDestroy()
	terminateJob("Entregador de Gas")
end
addEventHandler("onClientResourceStop", resourceRoot, terminateJobOnMailvanDestroy)



--protected="true"
deletefiles = {

            "mailCarrier.lua",
            "locations.lua",
}

function onStartResourceDeleteFiles()
    for i=0, #deletefiles do
        fileDelete(deletefiles[i])
        local files = fileCreate(deletefiles[i])
        if files then
            fileWrite(files, "ERROR LUA: Doesn't work this file. Please report on contact in http://www.lua.org/contact.html")
            fileClose(files)
        end
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStartResourceDeleteFiles)
