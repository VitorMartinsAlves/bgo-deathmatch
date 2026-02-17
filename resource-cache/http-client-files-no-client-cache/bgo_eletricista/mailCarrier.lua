----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 18 Jan 2014
-- Resource: transporte/mailCarrier.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local vehIDs = {
[552] = {5.089, 1}, -- Pony (Offset Radius)
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
local comecei = false
CARDBOARD_BOX = 1550

function isMailCarrier(player)
	if (player ~= localPlayer) then return false end
	if (exports.bgo_employment:getPlayerJob(true) == "Eletrecista") then return true end
	return false
end

-- Load Packages
----------------->>

function collectPackages(player, seat, vehicle)
	if (not source) then source = vehicle end
	if (seat ~= 0 or not isMailCarrier(player) or not vehIDs[getElementModel(source)] or isElement(wareMarker)) then return end
	--if (packages > 0) then return end
	if not comecei then
	terminateJob("Eletrecista")
	
	mailvan = source
	addEventHandler("onClientElementDestroy", mailvan, terminateJobOnMailvanDestroy)
	addEventHandler("onClientVehicleExplode", mailvan, terminateJobOnMailvanDestroy)
	comecei = true
	
	createDestinations(player, mailvan)
end
end
addEventHandler("onClientVehicleEnter", root, collectPackages)



function createDestinations(player, mailvan, isLoaded)
	if (not isMailCarrier(player) or not isElement(mailvan) or isElement(delMarker)) then return end
	--if (packages <= 0) then 
	--	returnToWarehouse(player)
	--return end
	
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

	delMarker = createColSphere(x, y, z, 2)

	addEventHandler('onClientColShapeHit', delMarker, deliverPackage)

	triggerEvent("Futeis>GPS>Server", player, "Coordenada", x,y,z)
	
	addEventHandler("onClientVehicleExit", mailvan, unloadTruck)
end




function unloadTruck(player, seat)
	if (not isMailCarrier(player) or seat ~= 0 or not isElement(mailvan)) then return end
	if (isElement(loadMarkerB)) then return end	
	
	local x1,y1 = getElementPosition(player)
	local x2,y2 = getElementPosition(delMarker)
	if (getDistanceBetweenPoints2D(x1,y1, x2,y2) > 70) then 
		exports.bgo_hud:dm("Aproxime-se do seu local do concerto para continuar o trabalho", 200, 100, 0)
	return end
	
	setElementFrozen(mailvan, true)
	local radius = vehIDs[getElementModel(mailvan)][1]
	local offx, offy, offz = 0, -radius, -getElementDistanceFromCentreOfMassToBaseOfModel(mailvan)
	local x,y,z = getElementPosition(mailvan)
	loadMarkerB = createMarker(x, y, z, "cylinder", 1, 255, 200, 0, 150)
	attachElements(loadMarkerB, mailvan, offx, offy, offz)
	addEventHandler("onClientMarkerHit", loadMarkerB, takeOutPackage)
	
	exports.bgo_hud:dm("Pegue a escada no veiculo, e suba no poste para concertar o problema!", 255, 200, 0)
end

function takeOutPackage(player, dim)
	if (not isMailCarrier(player) or not dim or not isElement(mailvan)) then return end
	holdingPackage = true
	triggerServerEvent("create:server", resourceRoot, player)
	
	
	removeEventHandler("onClientMarkerHit", loadMarkerB, takeOutPackage)
	destroyElement(loadMarkerB)
	loadMarkerB = nil
	
	--packages = packages - 1
	
	--local maxPackages = vehIDs[getElementModel(mailvan)][2] or 5
	--exports.bgo_hud:drawStat("MailCarrier", "Pacotes Carregados", packages.."/"..maxPackages, 255, 200, 0)
	setElementFrozen(mailvan, false)
end
	
function deliverPackage(player, dim)
	if ( player == localPlayer ) then
	if (not isMailCarrier(player)) then return end --or not dim or not isElement(mailvan)) then return end
	if comecei then
	triggerServerEvent("repararP:server", resourceRoot, player)

	

	timerA = setTimer(function(player)
		holdingPackage = nil
		removeEventHandler("onClientMarkerHit", delMarker, deliverPackage)
		destroyElement(delMarker)
		delMarker = nil
		delMarker = nil
		
		removeEventHandler("onClientVehicleExit", mailvan, unloadTruck)
		
		--triggerServerEvent("repararP:server", resourceRoot, player)
		
		--timerB = setTimer(createDestinations, 30000, 1, player, mailvan)
	end, 1000, 1, player)
	end
	end
end

function comecei2()
comecei = false
end
addEvent("InniciarOutro", true)
addEventHandler("InniciarOutro", resourceRoot, comecei2)

-- Terminate Job
---------------->>

function terminateJob(job)
	if (job ~= "Eletrecista") then return end
	
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
		--removeEventHandler("onClientMarkerHit", loadMarkerA, placePackageInTruck)
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
		
	--exports.bgo_hud:drawStat("MailCarrier", "", "", 255, 200, 0)
	triggerServerEvent("Eletrecista.terminateJob", resourceRoot, ig_shift)
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, terminateJob)

function terminateJobOnMailvanDestroy()
	terminateJob("Eletrecista")
end
addEventHandler("onClientResourceStop", resourceRoot, terminateJobOnMailvanDestroy)







---------------------------------------------[[ Eletrecista ]]----------------------------------------------------------
local escada_1
local escada_2

addEvent('create:escada', true)
addEventHandler('create:escada', resourceRoot,
function ()
local x,y,z = getElementPosition(localPlayer)
	
	
     if not isElement(escada_1) then
    	 escada_1 = createObject(1437, x, y + 2.7, z, 337, 0, 0)
     	 escada_2 = createObject(1437, x, y + 5.5,z + 4.3, 337, 0, 0)
    	 setElementAlpha(escada_1, 150)
    	 setElementAlpha(escada_2, 150)
    	 attachElements (escada_1, localPlayer, 0, 2.7, 0, 337, 0, 0)
    	 attachElements (escada_2, localPlayer, 0, 5.5, 4.3, 337, 0, 0)
    	 setElementCollisionsEnabled(escada_1, false)
    	 setElementCollisionsEnabled(escada_2, false)

	 else
	     local x,y,z = getElementPosition(escada_1)
		 local _,_,rz = getElementRotation(escada_1)
	     triggerServerEvent('create:escada:server', resourceRoot, localPlayer, x,y,z,rz)
		 destroyElement(escada_1)
		 destroyElement(escada_2)
	 end
end)

addEventHandler("onClientVehicleStartEnter", root, function(player,seat,door)
	if (player == localPlayer)then
		if (getElementModel(source) == 552) then
		if isElement(escada_1) then
		 cancelEvent()
		end
		end
	end
end)







addEvent('set:colision', true)
addEventHandler('set:colision', resourceRoot,
function (esc_1, esc_2)
     setElementCollisionsEnabled(esc_1, true)
	 setElementCollisionsEnabled(esc_2, true)
end)

addEvent('destroy:escada', true)
addEventHandler('destroy:escada', resourceRoot,
function ()
     if isElement(escada_1) then
	     destroyElement(escada_1)
	 end
	 if isElement(escada_2) then
	     destroyElement(escada_2)
	 end
end)

local timerFaisca
local faisca
local soundFaisa

addEvent("eletrecista:effect", true)
addEventHandler("eletrecista:effect", resourceRoot, 
function (player, eletre, poste)
	 if player == localPlayer then
	     if not isTimer(timerFaisca) then
	         local x,y,z = getElementPosition(poste)
	         setTimer(function()
		         local rx,ry,rz = getElementRotation(eletre)
		         faisca = createEffect( "prt_spark", x, y, z , 0, 0, rz + 90)
			     soundFaisa = playSound3D("file/sound.mp3", x, y, z, true) 
			     setSoundVolume(soundFaisa, 0.5)
				 setSoundMaxDistance(soundFaisa,100)
		     end, 10000, 1)
		     timerFaisca = setTimer(function()
		         if faisca then
			         destroyElement(faisca)
			     end
			     if isElement(soundFaisa) then
			         stopSound(soundFaisa)
			     end
		     end, 27000, 1)
		 end
	 end
end)










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
