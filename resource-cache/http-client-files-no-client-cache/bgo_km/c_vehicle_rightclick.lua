
--setElementData(localPlayer, "veh:ov", false)

local types = {
	["Automobile"] = true,
	["Bike"] = true,
	["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Monster Truck"] = true,
	["Quad"] = true
}

 



local beltVehicles = {
	["Automobile"] = true,
	["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Monster Truck"] = true
}


function playSounds(sounds, bool)
	if not bool then bool = false end
	if sounds == "ov" then
		beltSound = playSound("files/".. sounds ..".mp3", bool)
	else
	    playSound("files/".. sounds ..".mp3", bool)
	end
end

local motos = {
	["Bike"] = true

}


addEventHandler("onClientVehicleEnter", root, function(player)
	if player == localPlayer and beltVehicles[getVehicleType(getPedOccupiedVehicle(localPlayer))] then
		setElementData(localPlayer, "veh:ov", false)
		--playSounds("ov", true)
	end
end)


addEventHandler("onClientVehicleExit", root, function(player)
	if player == localPlayer then
		setElementData(localPlayer, "veh:ov", false)
		--playSounds("ov", true)

	end
end)


addEventHandler("onClientKey", root, function(key, pressed)
	if isChatBoxInputActive() or isConsoleActive() then return end
	if key == "x" and pressed and getPedOccupiedVehicle(localPlayer) and beltVehicles[getVehicleType(getPedOccupiedVehicle(localPlayer))] then
		if not getElementData(localPlayer, "veh:ov") then
			setElementData(localPlayer, "veh:ov", true)
			--stopSound(beltSound)
			playSound("files/ovbe.mp3", false)
			exports.bgo_chat:sendLocalMeMessage(localPlayer, "Colocou o cinto de segurança.")
		else
			setElementData(localPlayer, "veh:ov", false)
			playSound("files/ovki.mp3", false)
			--playSounds("ov", true)

			exports.bgo_chat:sendLocalMeMessage(localPlayer, "tirou o cinto de segurança.")
		end
	end
end)


addEventHandler("onClientVehicleCollision", root, function(collider, force, bodyPart, x, y, z, nx, ny, nz)
    if source == getPedOccupiedVehicle(localPlayer) then
	if beltVehicles[getVehicleType(getPedOccupiedVehicle(localPlayer))] then
		local fDamageMultiplier = getVehicleHandling(source).collisionDamageMultiplier
		local realDamage = (force*fDamageMultiplier)*0.1
		if realDamage > 10 then
			local a = math.random(5,10)
			local randomok = math.random(1,a)
			if randomok == 1 then
			triggerServerEvent ( "removerdoveiculo", localPlayer, localPlayer, seat )
			end
			end
		end
		
		if motos[getVehicleType(getPedOccupiedVehicle(localPlayer))] then
			local fDamageMultiplier = getVehicleHandling(source).collisionDamageMultiplier
			local realDamage = (force*fDamageMultiplier)*0.1
			if tonumber(realDamage) > 3 then
			--local randomok = math.random(1,6)
			--print(randomok)
			--if tonumber(randomok) > 3 then
			triggerServerEvent ( "removerdoveiculoMoto", localPlayer, localPlayer, seat )
			--end
			end
			
		end
    end
end)


--[[

addEventHandler("onClientPlayerWasted", root, function()
	if isPedInVehicle(localPlayer) then
		triggerServerEvent ( "removerdoveiculo", localPlayer, localPlayer )
	end
end)
]]--
