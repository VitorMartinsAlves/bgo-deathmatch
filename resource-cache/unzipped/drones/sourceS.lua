local createdDrones = {}

addEvent("controllDrone", true)
addEventHandler("controllDrone", root, function(control, state)
	triggerClientEvent("controllDrone", createdDrones[source].controller, control, state)
end)

function createDrone(player, droneId, x, y, z)
	if tonumber(droneId) then
		droneId = tonumber(droneId)

		triggerClientEvent(player, "toggleDrone", player, false)

		if createdDrones[player] then
			if isElement(createdDrones[player].drone) then
				destroyElement(createdDrones[player].drone)
			end

			if isElement(createdDrones[player].controller) then
				destroyElement(createdDrones[player].controller)
			end
		end

		createdDrones[player] = {}
		createdDrones[player].controller = createPed(0, 0, 0, 0)
		setElementAlpha(createdDrones[player].controller, 0)

		setTimer(function()
			createdDrones[player].drone = createVehicle(drones[droneId], x, y, z)
			triggerClientEvent("bladeOff", createdDrones[player].drone)
		
			setElementData(createdDrones[player].drone, "drone.battery", 100)
			setElementData(createdDrones[player].drone, "drone.owner", player)

			warpPedIntoVehicle(createdDrones[player].controller, createdDrones[player].drone)

			triggerClientEvent(player, "createdDrone", player, createdDrones[player].drone, createdDrones[player].controller)
		end, 1000, 1)
	end
end

addCommandHandler("createdrone", function(player, commandName, id)
	if tostring(id) then
		id = tonumber(id)
		if drones[id] then
			local x, y, z = getElementPosition(player)
			createDrone(player, id, x + 1, y + 1, z + 0.5)
		else
			outputChatBox("Incorrect drone type!", player, 255, 0, 0)
		end
	else
		outputChatBox("/" .. commandName .. " [Type (number)]", player, 255, 0, 0)
	end
end)

addCommandHandler("drone", function(player, commandName)
	if createdDrones[player] then
		if isElement(createdDrones[player].drone) then
			triggerClientEvent(player, "toggleDrone", player, true)
		end
	else
		outputChatBox("You dont have drone!", player, 255, 0, 0)
	end
end)

addEventHandler("onVehicleExplode", root, function()
	if getElementModel(source) == 501 then
		local owner = getElementData(source, "drone.owner")
		triggerClientEvent(owner, "toggleDrone", owner, false)
		outputChatBox("Your drone exploded!", owner, 255, 0, 0)

		if isElement(createdDrones[owner].drone) then
			destroyElement(createdDrones[owner].drone)
		end
		createdDrones[owner].drone = nil

		if isElement(createdDrones[owner].controller) then
			destroyElement(createdDrones[owner].controller)
		end
		createdDrones[owner].controller = nil
	end
end)

addEventHandler("onVehicleStartEnter", root, function(player)
	if createdDrones[player].drone then
		if source == createdDrones[player].drone then
			cancelEvent()
		end
	end
end)