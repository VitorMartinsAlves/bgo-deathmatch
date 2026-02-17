local vehicleTable = {}
local vehiclePlate = ''
local customFont = dxCreateFont('files/icons.ttf',30, false)
local renderVehDistance = 10
local showVehicle = true
local distance = 0

function isBike(veh)
	if getElementType(veh) == "vehicle" then
		if getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "BMX" or getVehicleType(veh) == "Boat" or getVehicleType(veh) == "Quad" then
			return true
		else
			return false
		end
	else
		return false
	end
end
--[[
function refresVehicleTable(element)
	if getElementType(element)=="vehicle" and not isBike(element) then
		vehicleTable[element] = {getVehiclePlateText(element)}
	end
end

addEventHandler("onClientElementStreamIn", root, function ()
	local type = getElementType (source)
	if showVehicle then 
		if type == "vehicle" then
			refresVehicleTable(source)
			--setPlayerNametagShowing (source,false)
		end
	end
end)

addEventHandler( "onClientElementStreamOut", root, function ()
	local type = getElementType (source)
	if showVehicle then 
		if type == "vehicle"then
			vehicleTable[source] = nil
			--setPlayerNametagShowing (source,false)
		end	
	end
end)

function streamAllVehicles()
	for k,v in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(v) then
			refresVehicleTable(v)
		end
	end

end
streamAllVehicles()
]]--

addEventHandler("onClientRender", root, function()
	if showVehicle then
		local px,py,pz = getElementPosition(localPlayer)
		--for k,value in pairs(getElementsByType("vehicle", root, true)) do
			local tabela = getElementsWithinRange( px,py,pz, 10, "vehicle" )
			local value = nil
			for i = 1, #tabela do
			value = tabela[i] 
			
			if isElement(value) and isElementOnScreen(value) and not isBike(value) then
				x,y,z = getElementPosition(value)
				distance = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
				
				if (distance <= renderVehDistance and not(getElementAlpha(value)==0) and isLineOfSightClear(px, py, pz, x, y, z, true, false, false, true, false, false, false) and getPedOccupiedVehicle(localPlayer) ~= value) then
					local progress = distance/renderVehDistance
					local size = interpolateBetween (0.8,0,0,0.2,0,0,progress,"OutQuad") * 0.9
					
					if size >= 3.5 then
						size = 3.5
					end
					
					if(tostring(getElementType(value))=="vehicle")then -- and vehicleTable[k] then
						vehiclePlate = getVehiclePlateText(value) --vehicleTable[k][1]
					else
						vehiclePlate = "#ffffffDesconhecido"
					end
					
					local vehpanel = { getScreenFromWorldPosition ( x, y, z+2 ) }
					if vehpanel[1] and vehpanel[2] then
						dxDrawText (vehiclePlate:gsub("#%x%x%x%x%x%x", "") , vehpanel[1]+1, vehpanel[2]+1, vehpanel[1]+1, vehpanel[2]+1, tocolor(0,0,0,255), size, customFont, "center","center",false,false,false,true )
						dxDrawText (vehiclePlate , vehpanel[1], vehpanel[2], vehpanel[1], vehpanel[2], tocolor(255,255,255,255), size, customFont, "center","center",false,false,false,true )
					end
				end
			end
		end
	end
end, true, "low-5")

function disabledVehicel()
	showVehicle = not showVehicle
end
addCommandHandler("offplate", disabledVehicel)