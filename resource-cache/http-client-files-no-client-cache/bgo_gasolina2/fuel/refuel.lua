local fuelPrice = nil
local createBlips = true
local BuyCan = { }
local sx, sy = guiGetScreenSize ( )
local MarkersTable = {}

--[[
setTimer ( function ( )
local fuelBlips = { }
for i, v in pairs ( fuelBlips2 ) do 
	--if ( blip and createBlips ) then
		local x, y, z, blip = unpack ( v )
		fuelBlips[i] = createBlip ( x, y, z, 0, 3, 255, 255, 255, 255, 0, 370 )
		setElementData(fuelBlips[i],"blipName", "Posto de gasolina")
	--end
end
end, 500, 1 )
]]--


--[[
setTimer ( function ( )

addEvent ( "NGVehicles:Fuel:OnFuelPriceChange", true )
addEventHandler ( "NGVehicles:Fuel:OnFuelPriceChange", root, function ( p )
	fuelPrice = p
end )



local isRendering = false
local fuelingMarker = nil
function onFuelMarkerHit ( p )
	if ( p == localPlayer ) then
		local x, y, z = getElementPosition ( source )
		local px, py, pz = getElementPosition ( p )
		if ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) < 5) then
			if ( eventName == 'onClientMarkerHit' ) then
				if ( isPedInVehicle ( p ) ) then
					isRendering = true
					fuelingMarker = source
					addEventHandler ( "onClientRender", root, onFuelTextRender )
					
					--for i, v in ipairs (MarkersTable) do -- Faz um loop com todos os marker na tabela MarkersTable
					--		if isElementWithinMarker(p, v) then -- Verifica se o veiculo está em algum posto
					--			setElementData(v, "Bomba", true) -- Adiciona a Bomba como desocupada	  
					--		end -- Fim
					--	end -- Fimm


				end
			elseif ( eventName == 'onClientMarkerLeave' ) then
				if ( isRendering ) then
					isRendering = false
					fuelingMarker = nil
					removeEventHandler ( "onClietnRender", root, onFuelTextRender )

					--for i, v in ipairs (MarkersTable) do -- Faz um loop com todos os marker na tabela MarkersTable
	
					--if not isElementWithinMarker(p, v) then -- Verifica se o veiculo está em algum posto
					--setElementData(v, "Bomba", false) -- Adiciona a Bomba como desocupada	
					--end -- Fim
					--end -- Fim


			
			
				
				
				end
				--closeBuyWindow ( )
			end
		end
	end
end

local tick = getTickCount ( )
function onFuelTextRender ( )
	if ( isRendering and isPedInVehicle ( localPlayer ) and getVehicleController ( getPedOccupiedVehicle ( localPlayer ) ) == localPlayer and isElementWithinMarker ( localPlayer, fuelingMarker ) ) then
		local car = getPedOccupiedVehicle ( localPlayer )
		local fuel = tonumber ( getElementData ( car, "veh:fuel" ) )
		if ( fuel < 100 ) then
			text = "Pressione \""..refuelKey:upper().."\" para abastecer (R$: "..tostring(fuelPrice).." / Litro)\nPreço total: R$: "..(100-fuel)*fuelPrice
			color = tocolor ( 255, 140, 0, 255 )
			if ( getKeyState ( refuelKey ) ) then
				if ( tonumber(getElementData(localPlayer,"char:money") or 0) >= fuelPrice ) then
					if ( getTickCount ( ) - tick >= fuelDelay ) then
						setElementData ( car, "veh:fuel", fuel + 1 )
						triggerServerEvent ( "NGFuel:takeMoney", localPlayer, fuelPrice )
						tick = getTickCount ( )
					end
				else
					text = "Você não tem dinheiro!"
					color = tocolor ( 255, 0, 0, 255 )
				end
			end
		else
			text = "Tanque Cheio!"
			color = tocolor ( 0, 255, 0, 255 )
		end
		dxDrawText ( text, 2, 2, sx, sy / 1.2, tocolor ( 0, 0, 0, 255 ), 2, "default-bold", "center", "bottom" )
		dxDrawText ( text, 0, 0, sx, sy / 1.2, color, 2, "default-bold", "center", "bottom" )
	else
		isRendering = false
		fuelingMarker = nil
		removeEventHandler ( 'onClientRender', root, onFuelTextRender )
	end
end

	local fuelBlips = { }

	for i, v in ipairs (fuelLocations) do
	local x, y, z, blip = unpack ( v )
	MarkersTable[i] = createMarker ( x, y, z -1, "cylinder", 3, 0, 255, 0, 50 )
	--setElementData(MarkersTable[i], "Posto:Gasolina", true)
	addEventHandler("onClientMarkerHit", MarkersTable[i], onFuelMarkerHit)
	addEventHandler("onClientMarkerLeave", MarkersTable[i], onFuelMarkerHit)
	end

	

setTimer ( triggerServerEvent, 500, 1, "NGVehicles:Fuel:OnClientRequestFuelPrice", localPlayer )


end, 500, 1 )



local x,y = guiGetScreenSize()
function isCursorOnElement(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end


--]]