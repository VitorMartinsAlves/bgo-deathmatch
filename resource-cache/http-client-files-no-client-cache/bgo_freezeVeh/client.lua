addEventHandler("onClientVehicleCollision", root,
    function (collider,force, bodyPart, x, y, z, nx, ny, nz) 
	
	if collider and isElement(collider) and getElementType(collider) == "player" then 
	
		--if getElementType(collider) == "player" then
			
			if not isElementFrozen(source) then
				if collider ~= source then
					--local veh = getPedOccupiedVehicle(collider)
					--if veh then return end
					if (getVehicleType(source) == "Automobile") then


					thePlayer = getVehicleController ( source ) 
					if not thePlayer then
					if getElementSpeed(source, "mph") < 3 then

					setElementFrozen(source, true)
					setTimer(setElementFrozen, 1000, 1, source, false)
					end
					end

					end
				end
			end
		end
    end
)




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

