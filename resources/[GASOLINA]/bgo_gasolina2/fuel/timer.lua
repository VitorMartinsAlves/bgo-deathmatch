local warnings = {
	[20]=true,
	[15]=true,
	[10]=true,
	[7]=true,
	[5]=true,
	[2]=true,
}
--[[
setTimer ( function ( ) 
	for i, v in ipairs ( getElementsByType ("vehicle" )) do 
	--for i, v in ipairs ( getElementsByType ( 'vehicle' ) ) do 
		if (getVehicleType(v) == "train") then return end
		if (getVehicleType(v) == "Boat") then return end
		if (getVehicleType(v) == "BMX") then return end
		local fuel = tonumber(getElementData ( v, "veh:fuel" ) or 0)
		local speed = getVehicleSpeed ( v, "kph" )
		if ( fuel >= 1 and tonumber(speed) > 0 and getVehicleOccupant ( v ) ) then
			setElementData ( v, "veh:fuel", fuel - 1 )
			local fuel = fuel - 1
			if ( warnings[fuel] ) then
				exports.bgo_hud:dm("Atenção, seu combustível está ficando baixo, está em "..tostring(fuel).."%", getVehicleOccupant ( v ), 255, 125, 0)		
			end
		end


	end
end, 15000, 0 )
]]--


local tempovehGasoline = { }	
		
function addHelmetOnEnter ( theVehicle )	
	if isElement(theVehicle) then
	if getElementType ( source ) == "player" then
	if ( source:getOccupiedVehicleSeat() == 0  ) then
	if isTimer(tempovehGasoline[source]) then
	killTimer(tempovehGasoline[source])
	end
	tempovehGasoline[source] = setTimer(aplicarGasoline,20000,0,source, theVehicle, true)
	end
	end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), addHelmetOnEnter )


function removeHelmetOnExit ( theVehicle )
	if isElement(theVehicle) then
	if getElementType ( source ) == "player" then
	if isTimer(tempovehGasoline[source]) then
	aplicarGasoline(source, theVehicle, false)
	end
	end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), removeHelmetOnExit )


function aplicarGasoline (thePlayer, theVehicle, bool )
	if bool then
	if isElement(theVehicle) then
	if getElementType ( thePlayer ) == "player" then
	if ( thePlayer:getOccupiedVehicleSeat() == 0  ) then

		if (getVehicleType(theVehicle) == "train") then return end
		if (getVehicleType(theVehicle) == "Boat") then return end
		if (getVehicleType(theVehicle) == "BMX") then return end
			
		local fuel = tonumber(getElementData ( theVehicle, "veh:fuel" ) or 0)
		local speed = getVehicleSpeed ( theVehicle, "kph" )
		if ( fuel >= 1 and tonumber(speed) > 0 and getVehicleOccupant ( theVehicle ) ) then
			--local fuel = fuel - math.floor(speed)/fuel*0.5 --1

			if speed > 0 and speed < 150 then
			setElementData ( theVehicle, "veh:fuel", fuel - 1 )
			elseif speed > 150 and speed < 200 then
			setElementData ( theVehicle, "veh:fuel", fuel - 2 )
			elseif speed > 200 and speed < 300 then
			setElementData ( theVehicle, "veh:fuel", fuel - 3 )
			elseif speed > 300 and speed < 500 then
			setElementData ( theVehicle, "veh:fuel", fuel - 4 )
			end
			
			--print(""..getPlayerName(source).." gastou ")
			if ( warnings[fuel] ) then
				exports.bgo_hud:dm("Atenção, seu combustível está ficando baixo, está em "..tostring(fuel).."%", getVehicleOccupant ( theVehicle ), 255, 125, 0)		
			end
		end
		end
			end
	elseif not bool then

		if isTimer(tempovehGasoline[thePlayer]) then
		killTimer(tempovehGasoline[thePlayer])
		end
	end
	end
end





--local fuelPrice = math.random ( 1, 7 )
--exports.bgo_hud:dm("[Posto BGO]: O preço da gasolina foi alterado para R$: "..tostring(fuelPrice).." / Litro!", root, 255, 125, 0)

--[[
setTimer ( function ( )
	local _fuelPrice = math.random ( 1, 7 )
	while ( fuelPrice == _fulePrice ) do
		_fuelPrice = math.random ( 1, 7 )
	end
	fuelPrice = _fuelPrice
	exports.bgo_hud:dm("[Posto BGO]: O preço da gasolina foi alterado para R$: "..tostring(fuelPrice).." / Litro!", root, 255, 125, 0)
	triggerClientEvent ( root, "NGVehicles:Fuel:OnFuelPriceChange", root, fuelPrice )
end, 700000, 0 )

addEvent ( "NGFuel:takeMoney", true )
addEventHandler ( "NGFuel:takeMoney", root, function ( p )
	--takePlayerMoney ( source, p )
	setElementData(source,"char:money", tonumber(getElementData(source,"char:money") or 0) - p)
end )


addEvent ( "NGVehicles:Fuel:OnClientRequestFuelPrice", true )
addEventHandler ( "NGVehicles:Fuel:OnClientRequestFuelPrice", root, function ( )
	triggerClientEvent ( source, "NGVehicles:Fuel:OnFuelPriceChange", source, fuelPrice )
end )

]]--


function getVehicleSpeed ( tp, md )
	local md = md or "kph"
	local sx, sy, sz = getElementVelocity ( tp )
	local speed = math.ceil( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 )
	local speed1 = math.ceil( ( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 ) / 1.61 )
	if ( md == "kph" ) then
		return speed;
	else
		return speed1;
	end
end


function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end


function setElementSpeed(element, unit, speed)
    local unit    = unit or 0
    local speed   = tonumber(speed) or 0
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed) then -- if true - element is valid, no need to check again
		local diff = speed/acSpeed
		if diff ~= diff then return false end -- if the number is a 'NaN' return false.
        local x, y, z = getElementVelocity(element)
		return setElementVelocity(element, x*diff, y*diff, z*diff)
	end
	return false
end



local tempoveh = { }	
		
function addHelmetOnEnter ( theVehicle )	
	if isElement(theVehicle) then
	if getElementType ( source ) == "player" then
	if ( source:getOccupiedVehicleSeat() == 0  ) then
	if isTimer(tempoveh[source]) then
	killTimer(tempoveh[source])
	end
	tempoveh[source] = setTimer(aplicarlimite,200,0,source, theVehicle, true)
	end
	end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), addHelmetOnEnter )


function removeHelmetOnExit ( theVehicle )
	if isElement(theVehicle) then
	if getElementType ( source ) == "player" then
	if isTimer(tempovehGasoline[source]) then
	aplicarlimite(source, theVehicle, false)
	end
	end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), removeHelmetOnExit )


function aplicarlimite (thePlayer, theVehicle, bool )
	if bool then
	if isElement(theVehicle) then
	if getElementType ( thePlayer ) == "player" then
	if ( thePlayer:getOccupiedVehicleSeat() == 0  ) then
			if (getVehicleType(theVehicle) == "train") then return end
			local speed = getVehicleSpeed ( theVehicle, "kph" )
			if ( speed > 26 and getVehicleOccupant ( theVehicle ) ) then
				local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates ( theVehicle )
				if frontLeft == 1 or rearLeft == 1 or frontRight == 1 or rearRight == 1 then 
					setElementSpeed(theVehicle, "km/h", 30)
				end
			end
				end
			end
	elseif not bool then

		if isTimer(tempoveh[thePlayer]) then
		killTimer(tempoveh[thePlayer])
		end
	end
	end
end
 
function quit ( )
	if isTimer(tempoveh[source]) then
	killTimer(tempoveh[source])
	end	
	
		if isTimer(tempovehGasoline[source]) then
		killTimer(tempovehGasoline[source])
		end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quit )

