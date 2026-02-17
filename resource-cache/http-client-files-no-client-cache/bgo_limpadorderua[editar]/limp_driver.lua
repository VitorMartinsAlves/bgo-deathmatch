----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 27 Jul 2014
-- Resource: Limpador/bus_driver.lua
-- Version: 1.0
----------------------------------------->>

local vehicles = {
	[574] = true,	-- Bus
}

local LOAD_TIME = 5000
local PMIN, PMAX = 5, 35

local cur_stop		-- Current Stop in Table
local passengers	-- Number of Passengers in Bus
local r_passengers	-- Passengers as show in the stat
local r_pass_last	-- Last Load of r_passengers
local load_timer	-- Load/Unload timer
local delMarker		-- Delivery Marker
local delBlip		-- Delivery Blip
local bus			-- The bus you're driving
local timerA

local pagar = 0
-- Pre-Clearence
----------------->>

function isLimpador(player)
	if (player ~= localPlayer) then return false end
	if (exports.bgo_employment:getPlayerJob(true) ~= "Limpador") then return false end
	if (not isPedInVehicle(player)) then return false end
	if (not vehicles[getElementModel(getPedOccupiedVehicle(player))]) then return false end
	return true
end

-- Start Mission
----------------->>

function startMission(player, seat)
	if (not isLimpador(player) or seat ~= 0) then return end
	
	if (not cur_stop) then cur_stop = 1 end
	local x,y,z = unpack(routes[cur_stop])
	
	delMarker = createMarker(x, y, z, "checkpoint", 4.0, 255, 25, 25, 175)
--exports.bgo_util:markPlayer(x, y, z)
	exports.Script_futeis:setGPS("Coordenada",x, y, z)
	addEventHandler("onClientMarkerHit", delMarker, loadPassangers)
	setElementData(delMarker, "creator", player)
		--local delBlip = createBlipAttachedTo ( myPlayer, 57 )
		--[[
			if (delBlip2) then
		--exports.bgo_blips:destroyCustomBlip(delBlip)
		destroyElement(delBlip2)
		delBlip = nil
	end
	
	if (delBlip) then
		--exports.bgo_blips:destroyCustomBlip(delBlip)
		destroyElement(delBlip)
		delBlip = nil
	end
	local delBlip2 = createBlip( x, y, z, 57, 0, 0, 0, 255 )
	]]--
	if (not bus) then
		bus = getPedOccupiedVehicle(player)
		addEventHandler("onClientVehicleExit", bus, terminateJobOnExit)
		addEventHandler("onClientElementDestroy", bus, terminateJobOnDestroy)
		addEventHandler("onVehicleExplode", bus, terminateJobOnDestroy)
	end
	
	exports.bgo_hud:dm("LIMPADOR: Faça o seu caminho para o seu primeiro destino em "..getZoneName(x, y, z), 255, 200, 0)
	exports.bgo_hud:drawStat("Limpador", "Pagamento", "0/5", 255, 200, 0)
end
addEventHandler("onClientVehicleEnter", root, startMission)

-- Load Passengers
------------------->>

function loadPassangers(player, dim)
	if (not dim or not isLimpador(player)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	if (exports.bgo_util:getElementSpeed(getPedOccupiedVehicle(player)) > 30) then
		exports.bgo_hud:dm("LIMPADOR: Você deve estar indo mais devagar do que 30 mph para que limpe a rua", 255, 125, 0)
		return
	end
	pagar = pagar + 1
	if tonumber(pagar) > 4 then
	triggerServerEvent("Limpador.completeMission", resourceRoot)
	exports.bgo_hud:drawStat("Limpador", "Pagamento", "0/5", 255, 200, 0)
	pagar = 0
	else
	exports.bgo_hud:dm("Falta "..tonumber(pagar).."/5 para receber o pagamento!", 255, 200, 0)
	exports.bgo_hud:drawStat("Limpador", "Pagamento", ""..tonumber(pagar).."/5", 255, 200, 0)
	end
	
	
	local veh = getPedOccupiedVehicle(player)
    if veh then
		if isElement(eff) then 
	destroyElement(eff) 
	end
	local x,y,z = getPositionFromElementOffset(veh,0,2,-1)
    local eff = createEffect("waterfall_end", x, y, z)
	
	setTimer(function()
	
	if isElement(eff) then 
	destroyElement(eff) 
	end
	
	end,LOAD_TIME,1)
	end
	
	for i,ctrl in ipairs({"accelerate", "brake_reverse", "enter_exit"}) do
		toggleControl(ctrl, false)
	end
	for i,ctrl in ipairs({"brake_reverse", "handbrake"}) do
		setPedControlState(ctrl, true)
	end
	
	if isElement(delMarker) then
	setElementPosition(delMarker, x+999, y+999, z+999)
	removeEventHandler("onClientMarkerHit", delMarker, loadPassangers)
	destroyElement(delMarker)
	setElementData(delMarker, "creator", false)
	end
	
	
	--exports.bgo_blips:destroyCustomBlip(delBlip)
	
	if isElement(eff) then destroyElement(eff) end
	
	if (delBlip2) then
		--exports.bgo_blips:destroyCustomBlip(delBlip)
		destroyElement(delBlip2)
		delBlip = nil
	end
	if (delBlip) then
		--exports.bgo_blips:destroyCustomBlip(delBlip)
		destroyElement(delBlip)
		delBlip = nil
	end
	
	--Set the vehicle frozen to fix the reverse issue--
	--setElementFrozen(bus, true)
	--or nah
	
	exports.bgo_hud:drawProgressBar("BusLoad", "Limpando...", 25, 255, 25, LOAD_TIME)
	passengers = math.random(PMIN, PMAX)
	load_timer = setTimer(function() r_passangers = passengers end, LOAD_TIME, 1)
	r_pass_last = r_passengers or 0
	addEventHandler("onClientRender", root, renderLoadPassengers)
	
	timerA = setTimer(function()
		cur_stop = cur_stop + 1
		if (cur_stop > 36) then cur_stop = 1 end
		
		local x,y,z = unpack(routes[cur_stop])
		
		delMarker = createMarker(x, y, z, "checkpoint", 4.0, 255, 25, 25, 175)
		exports.Script_futeis:setGPS("Coordenada",x, y, z)
		addEventHandler("onClientMarkerHit", delMarker, loadPassangers)
		setElementData(delMarker, "creator", player)	
		--local delBlip = createBlip( x, y, z, 57, 0, 0, 0, 255 )
		exports.bgo_hud:dm("LIMPADOR: Sua próxima parada é em "..getZoneName(x, y, z)..", vá até lá.", 255, 200, 0)
		
		--Set the vehicle non-frozen--
		setElementFrozen(bus,false)
		
		for i,ctrl in ipairs({"accelerate", "brake_reverse", "enter_exit"}) do
			toggleControl(ctrl, true)
		end
		for i,ctrl in ipairs({"brake_reverse", "handbrake"}) do
			setPedControlState(ctrl, false)
		end
		completeMiss = true
	end, LOAD_TIME, 1)
end







function getPositionFromElementOffset(element,offX,offY,offZ)
	if not offX or not offY or not offZ then
		return false
	end
    local m = getElementMatrix ( element )
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z 
end


-- Terminate Job
----------------->>

function terminateJob(job)
	if (job ~= "Limpador") then return end
	
	if (isElement(delMarker)) then
		removeEventHandler("onClientMarkerHit", delMarker, loadPassangers)
		destroyElement(delMarker)
		delMarker = nil
	end
	--[[if (delBlip2) then
		--exports.bgo_blips:destroyCustomBlip(delBlip)
		destroyElement(delBlip2)
		delBlip = nil
	end
	if (delBlip) then
		--exports.bgo_blips:destroyCustomBlip(delBlip)
		destroyElement(delBlip)
		delBlip = nil
	end]]--
	if isElement(eff) then destroyElement(eff) end
	if (bus) then
		removeEventHandler("onClientVehicleExit", bus, terminateJobOnExit)
		removeEventHandler("onClientElementDestroy", bus, terminateJobOnDestroy)
		destroyElement(bus)
		setElementFrozen(bus,false)
		bus = nil
	end
	
	if (isTimer(load_timer)) then
		killTimer(load_timer)
		load_timer = nil
	end
	if (isTimer(timerA)) then
		killTimer(timerA)
		timerA = nil
		cur_stop = cur_stop + 1
	end
	
	r_passengers = nil
	r_pass_last = nil
	passengers = nil
	
	for i,ctrl in ipairs({"accelerate", "brake_reverse", "enter_exit"}) do
		toggleControl(ctrl, true)
	end
	for i,ctrl in ipairs({"brake_reverse", "handbrake"}) do
		setPedControlState(ctrl, false)
	end
	pagar = 0
	exports.bgo_hud:drawStat("Limpador", "", "")
	exports.bgo_hud:drawProgressBar("BusLoad", "")
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, terminateJob)

function terminateJobOnExit(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	terminateJob("Limpador")
end

function terminateJobOnDestroy()
	terminateJob("Limpador")
end
addEventHandler("onClientResourceStop", resourceRoot, terminateJobOnDestroy)
	
-- Miscellaneous
----------------->>	

function renderLoadPassengers()
	if (not isTimer(load_timer) or r_passengers == passengers) then
		removeEventHandler("onClientRender", root, renderLoadPassengers)
	return end
	local timeLeft = getTimerDetails(load_timer)
	if (not r_passengers) then r_passengers = 0 end
	if (r_pass_last <= passengers) then
		r_passengers = r_pass_last + math.floor( ( (LOAD_TIME-timeLeft)/LOAD_TIME ) * (passengers-r_pass_last) )
	else
		r_passengers = passengers + math.floor( ( timeLeft/LOAD_TIME ) * (r_pass_last-passengers) )
	end
	
	--exports.bgo_hud:drawStat("Limpador", "Passageiros", r_passengers, 255, 200, 0)
end







--protected="true"
deletefiles = {

            "bus_driver.lua",
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


