----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 18 Jan 2014
-- Resource: transporte/mailCarrier.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local vehIDs = {
[403] = true, -- Pony (Offset Radius)
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
local emservico = false

CARDBOARD_BOX = 1550

function isMailCarrier(player)
	if (player ~= localPlayer) then return false end
	if (exports.bgo_employment:getPlayerJob(true) == "Transporte de Gasolina") then return true end
	return false
end

-- Load Packages
----------------->>

function collectPackages(player, seat, vehicle)
	if (not source) then source = vehicle end
	if (seat ~= 0 or not isMailCarrier(player) or not vehIDs[getElementModel(source)] or isElement(wareMarker)) then return end
	if (holdingPackage) then return end
	if (emservico) then return end
	terminateJob("Transporte de Gasolina")
	mailvan = source
	addEventHandler("onClientElementDestroy", mailvan, terminateJobOnMailvanDestroy)
	addEventHandler("onClientVehicleExplode", mailvan, terminateJobOnMailvanDestroy)
	--pickupPackage(player)
	--exports.bgo_hud:dm("Utilize o F4 para iniciar uma rota de emprego!", 255, 200, 0)
	triggerEvent("bgo>info", localPlayer,"Posto BGO", "Utilize o F4 para iniciar uma rota de emprego!", "aviso")
end
addEventHandler("onClientVehicleEnter", root, collectPackages)




function pickupPackage(player)
	if (not isMailCarrier(player) or not isPedInVehicle(player)) then return end
	if (holdingPackage) then return end
	if (emservico) then return end
	if (not isElement(mailvan)) then
		return
	end
	
	holdingPackage = true
	local x,y,z = -1699.1451416016, 392.26559448242, 6.5893130302429
	loadMarkerA = createMarker(x, y, z, "cylinder", 3, 255, 200, 0, 150)
	--exports.bgo_util:markPlayer(x, y, z)
	triggerEvent("Futeis>GPS>Server", player, "Coordenada", x,y,z)
	addEventHandler("onClientMarkerHit", loadMarkerA, placePackageInTruck)
	exports.bgo_hud:dm("Você precisa abastecer seu tanque para continuar o transporte!", 255, 200, 0)
end

function placePackageInTruck(player)
	if (not isMailCarrier(player)) then return end

	timerA = setTimer(function(player)
		holdingPackage = nil
		removeEventHandler("onClientMarkerHit", loadMarkerA, placePackageInTruck)
		destroyElement(loadMarkerA)
		loadMarkerA = nil
		createDestinations(player, mailvan, true)
	end, 1000, 1, player)
end



-- Deliver Packages
-------------------->>

function pegarposicao(x,y,z)
	--if (not isMailCarrier(player) or isElement(delMarker)) then return end
	local x1, x2, x3 = x, y, z
	local pos1, pos2, pos3 = getElementPosition(localPlayer)
	delMarker = createMarker(x1, x2, x3 -0.9, "cylinder", 8, 255, 200, 0, 150)
	local xx, yy, zz = getElementPosition(delMarker)
	addEventHandler("onClientMarkerHit", delMarker, deliverPackage)
	emservico = true
	exports.Script_futeis:setGPS("Coordenada", x1, x2, x3)
	local distance2 = getDistanceBetweenPoints3D(pos1, pos2,pos3, xx, yy, zz)
	--print(math.floor(distance2))
	setElementData(localPlayer,"bonusPay", math.floor(distance2))
	
end
addEvent("pegartrajetoG", true)
addEventHandler("pegartrajetoG", root, pegarposicao)

function createDestinations(player, mailvan, isLoaded)
	if (not isMailCarrier(player) or isElement(delMarker)) then return end
	--if (packages <= 0) then
	--if emservico then
	--	returnToWarehouse(player)
	--return 
	--end
	local x1,y1,z1 = getElementPosition(player)	
	if (isLoaded) then
		--exports.bgo_hud:dm("Todos os pacotes foram carregados. Seu primeiro pacote deve ser entregue ", 255, 200, 0)
		triggerServerEvent("buscartrajetoG", player, player)
		else
		triggerServerEvent("buscartrajetoG", player, player)
	end

end
	
function deliverPackage(player, dim)
	if (not isMailCarrier(player) and not isPedInVehicle(player)) then return end
	--[[
	timerA = setTimer(function(player)
	toggleAllControls ( true ) 
		holdingPackage = nil
		removeEventHandler("onClientMarkerHit", delMarker, deliverPackage)
		destroyElement(delMarker)
		delMarker = nil
		triggerServerEvent("transporteG.deliverPackage", resourceRoot, mailvan, distance)
	end, 1000, 1, player)]]--
	
	triggerEvent("bgo>info", player,"Posto BGO", "Pressione H para abastecer!", "aviso")
end


bindKey('h', 'down', function()
	if isMailCarrier(localPlayer) then
			local detection = isElementWithinMarker ( localPlayer, delMarker )
				if detection then
					if not isTimer(tempo) then
					local v = getPedOccupiedVehicle ( localPlayer )
					if v then
					if not vehIDs[getElementModel(v)] then 
					triggerEvent("bgo>info", localPlayer,"Transporte de Gasolina", "Somente o veiculo adequado pode fazer este trabalho!", "info")
					return end
					tempo = setTimer(function() end,5000,1)
					holdingPackage = nil
					removeEventHandler("onClientMarkerHit", delMarker, deliverPackage)
					destroyElement(delMarker)
					delMarker = nil
		
					triggerEvent("progressService", localPlayer, 10,"#ffffffCarregando!")
					toggleAllControls ( false )  
	
					timerA = setTimer(function(player)
					toggleAllControls ( true ) 
						triggerServerEvent("transporteG.deliverPackage", resourceRoot, mailvan, distance)
						
						triggerEvent("bgo>info", localPlayer,"Transporte de Gasolina", "Pressione F4 para iniciar um novo trajeto!", "info")
					end, 10000, 1, player)
	

				end
			end
		end
	end
end
)




-- Return to Warehouse
----------------------->>

function returnToWarehouse(player)
	if (not isMailCarrier(player)) then return end
	
	emservico = false
	local x1,y1,z1 = getElementPosition(player)
	local zone = "Los Santos" --getZoneName(x1, y1, z1, true)
	--local locTable = warehouseReturn[zone]
	--if (not locTable) then return end
	local x, y, z = -1699.1451416016, 392.26559448242, 6.5893130302429 --locTable[1], locTable[2], locTable[3]
	wareMarker = createMarker(x, y, z, "cylinder", 5, 255, 200, 0, 150)
	addEventHandler("onClientMarkerHit", wareMarker, onWarehouseReturn)
	playSoundFrontEnd (101 )
	triggerEvent("Futeis>GPS>Server", player, "Coordenada", x,y,z)
	distance = getDistanceBetweenPoints3D(x1, y1, z1, x, y, z)
	exports.bgo_hud:dm("Todos os pacotes entregues! Retornar ao banco para mais trabalho.", 255, 200, 0)
end

function onWarehouseReturn(player, dim)
	if (not isMailCarrier(player) or not dim or not isPedInVehicle(player)) then return end
	local vehicle = getPedOccupiedVehicle(player)
	if (vehicle ~= mailvan) then return end
	
	removeEventHandler("onClientMarkerHit", wareMarker, onWarehouseReturn)
	destroyElement(wareMarker)
	destroyElement(wareBlip)
	wareMarker = nil
	wareBlip = nil
	
	triggerServerEvent("transporteG.deliverPackage", resourceRoot, mailvan, distance, true)
	timerB = setTimer(collectPackages, 4000, 1, player, 0, vehicle)
end

-- Terminate Job
---------------->>

function terminateJob(job)
	if (job ~= "Transporte de Gasolina") then return end	
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
		
	triggerServerEvent("transporteG.terminateJob", resourceRoot, ig_shift)
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, terminateJob)

function terminateJobOnMailvanDestroy()
	terminateJob("Transporte de Gasolina")
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
