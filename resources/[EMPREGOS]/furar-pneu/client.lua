function getElementSpeed(element, unit)
	if (unit == nil) then
		unit = 0
	end
	if (isElement(element)) then
		local x, y, z = getElementVelocity(element)

		if (unit == "mph" or unit == 1 or unit == '1') then
			return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100)
		else
			return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100 * 1.609344)
		end
	else
		return false
	end
end


				

function teste()
  local veh = getPedOccupiedVehicle(localPlayer)
  --if getVehicleOccupant(veh, 0) ~= localPlayer then
  if veh then
	if getElementSpeed(veh, "mph") > 0 then
  
		local spawn = math.random(1, 130)
		if spawn == 4 then
				--setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, -1, -1, 1)
				triggerServerEvent("furarS",localPlayer,localPlayer, -1, -1, -1, 1)
		elseif spawn == 18 then
				--setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, 1, -1, -1)
				triggerServerEvent("furarS",localPlayer,localPlayer, -1, 1, -1, -1)
		elseif spawn == 46 then
				--setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, -1, 1, -1)
				triggerServerEvent("furarS",localPlayer,localPlayer, -1, -1, 1, -1)
		elseif spawn == 68 then
				triggerServerEvent("furarS",localPlayer,localPlayer, 1, -1, -1, -1)
		end
	end
end
end
setTimer ( teste, 130000, 0)
teste()

