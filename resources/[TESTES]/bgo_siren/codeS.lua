sirenTables = {}
vehicleLampColor = {}

funct = {}

function SirenSinc(station)
	local vehicle = getPedOccupiedVehicle(source)
	setElementData(vehicle, "vehicle:siren", station)
	setElementData(vehicle, "vehicle:siren:sound", 1)
end
addEvent("SirenSinc", true)
addEventHandler("SirenSinc", getRootElement(), SirenSinc)

function SirenHorn(station)
	local vehicle = getPedOccupiedVehicle(source)
	setElementData(vehicle, "vehicle:horn", station)
	setElementData(vehicle, "vehicle:siren:sound", 1)
end
addEvent("SirenHorn", true)
addEventHandler("SirenHorn", getRootElement(), SirenHorn)


addEventHandler("onVehicleEnter",root,function(player,seat)
    if(player)and(seat==0)then
		local veh = getPedOccupiedVehicle(player)
		local model = getElementModel(veh)
		
		if getElementModel(source) == 416 then
			addVehicleSirens(source, 8, 4, false, false, false, true)
			setVehicleSirens(source, 1, 0.0, 0.70, 1.9, 255, 0, 0, 255, 255.0)	
			setVehicleSirens(source, 2, 0.3, 0.70, 1.9, 0, 0, 255, 255, 255.0)
			setVehicleSirens(source, 3, 0.6, 0.70, 1.9, 255, 0, 0, 255, 255.0)
			setVehicleSirens(source, 4, -0.3, 0.70, 1.9, 0, 0, 255, 255, 255.0)
			setVehicleSirens(source, 5, -0.6, 0.70, 1.9, 255, 0, 0, 255, 255.0)
			setVehicleSirens(source, 6, 0.0, 0.70, 1.9, 255, 255, 255, 255, 255.0)
			setVehicleSirens(source, 7, -0.63, -2.75, 2.0, 0, 0, 255, 255, 255.0)
			setVehicleSirens(source, 8, 0.63, -2.75, 2.0, 0, 0, 255, 255, 255.0)
			
			
		elseif getElementModel(source) == 490		then
		addVehicleSirens(source, 8, 1, false, false, false, true)
		setVehicleSirens(source, 1, 0.45, -0.10, 1.2, 255, 0, 0, 255, 255.0)
		setVehicleSirens(source, 2, -0.45, -0.10, 1.2, 255, 0, 0, 255, 255.0)
		setVehicleSirens(source, 3, 0.01, 0.10, 1.2, 255, 0, 0, 255, 255.0)
		setVehicleSirens(source, 4, 0.45, -0.10, 1.2, 255, 0, 0, 255, 255.0)
		setVehicleSirens(source, 5, -0.45, -0.10, 1.2, 255, 0, 0, 255, 255.0)
		setVehicleSirens(source, 6, 0.01, 0.10, 1.2, 255, 0, 0, 255, 255.0)	
		setVehicleSirens(source, 7, 0.90, -2.99, 0.1, 255, 255, 255, 255, 255.0)
		setVehicleSirens(source, 8, -0.90, -2.99, 0.1, 255, 255, 255, 255, 255.0)		
		
		
        elseif getElementModel(source) == 574 then
            addVehicleSirens(source,8,4, true, false, true, true)

            setVehicleSirens(source, 1, 0.45, 0.55, 1.4, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 2, 0.45, 0.55, 1.4, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 3, 0.3, 0.55, 1.4, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 4, 0.1, 0.55, 1.4, 255, 165, 250, 250, 250.0)
            setVehicleSirens(source, 5, -0.3, 0.55, 1.4, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 6, -0.45, 0.55, 1.4, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 7, -0.6, 0.55, 1.4, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 8, -0.1, 0.55, 1.4, 255, 165, 0, 255, 255.0)
			
			
		    elseif getElementModel(source) == 525 then
            addVehicleSirens(source,8,4, true, false, true, true)
            setVehicleSirens(source, 1, 0.45, -0.10, 1.1, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 2, 0.45, -0.10, 1.1, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 3, 0.3, -0.10, 1.1, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 4, 0.1, -0.10, 1.1, 255, 255, 255, 250, 250.0)
            setVehicleSirens(source, 5, -0.3, -0.10, 1.1, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 6, -0.45, -0.10, 1.1, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 7, 0.87, -2.75, 0.1, 255, 255, 255, 255, 255.0)
			setVehicleSirens(source, 8, -0.87, -2.75, 0.1, 255, 255, 255, 255, 255.0)
			
 
 	    elseif getElementModel(source) == 408 then
            addVehicleSirens(source,8,4, true, false, true, true)
            setVehicleSirens(source, 1, 0.92, -4.35, 2.0, 255, 165, 0, 255, 255.0) --laranja
            setVehicleSirens(source, 2, -0.95, 2.28, 1.9, 255, 255, 0, 255, 255.0)
            setVehicleSirens(source, 3, -0.95, 2.28, 1.9, 255, 255, 0, 255, 255.0)
            setVehicleSirens(source, 4, -0.95, 2.28, 1.9, 255, 255, 255, 250, 250.0) --branco
            setVehicleSirens(source, 5, -0.92, -4.35, 2.0, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 6, 0.92, -4.35, 2.0, 255, 165, 0, 255, 255.0)
            setVehicleSirens(source, 7, -0.92, -4.35, 2.0, 255, 165, 0, 255, 255.0)
	    setVehicleSirens(source, 8, -0.00, -4.01, 2.2, 255, 255, 255, 255, 255.0)
 
 
 
 		    elseif getElementModel(source) == 443 then
            addVehicleSirens(source,8,4, true, false, true, true)
            setVehicleSirens(source, 1, 0.45, 1.90, 2.2, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 2, 0.45, 1.90, 2.2, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 3, 0.3, 1.90, 2.2, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 4, 0.1, 1.90, 2.2, 255, 255, 255, 250, 250.0)
            setVehicleSirens(source, 5, -0.3, 1.90, 2.2, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 6, -0.45, 1.90, 2.2, 255, 140, 0, 255, 255.0)
            setVehicleSirens(source, 7, 0.22, -4.75, 0.01, 255, 255, 255, 255, 255.0)
			setVehicleSirens(source, 8, -0.22, -4.75, 0.01, 255, 255, 255, 255, 255.0)
 
 
		end
	end
end)

Vehicles = { [490]=true, [550]=true, [479]=true,[409]=true, [445]=true, [418]=true, [26]=true, [416]=true, [550]=true, [427]=true, [426]=true, [528]=true, [407]=true, [544]=true, [523]=true, [596]=true, [597]=true, [585]=true, [598]=true, [599]=true, [601]=true, [586]=true, [479]=true }

local lights = {}

function toggleFlasherState()
	if not (client) then
		return false
	end
	local theVehicle = getPedOccupiedVehicle(client)
	if not theVehicle then
		return false
	end
	
	if (theVehicle) then
		local vehicleModelID = getElementModel(theVehicle)
		local currentFlasherState = getElementData(theVehicle, "lspd:flashers") or 0

		if currentFlasherState == 1 or currentFlasherState == 2 then
			setTimer(function()
				red = vehicleLampColor[theVehicle][1]
				green = vehicleLampColor[theVehicle][2]
				blue = vehicleLampColor[theVehicle][3]
				setVehicleHeadLightColor(theVehicle, red, green, blue)
			end, 60, 20)
		else
			vehicleLampColor[theVehicle] = {getVehicleHeadLightColor(theVehicle)}
		end

		if (Vehicles[vehicleModelID]) or getElementData(theVehicle, "villogo:kek") then

			setElementData(theVehicle, "lspd:flashers", 1 - currentFlasherState, true)

		elseif getElementData(theVehicle, "villogo:sarga") then
			if currentFlasherState == 2 then
				setElementData(theVehicle, "lspd:flashers", 0, true)
			else
				setElementData(theVehicle, "lspd:flashers", 2, true)
			end
		else
			setElementData(theVehicle, "lspd:flashers", 0, true)
		end
	end
end
addEvent( "lspd:toggleFlashers", true )
addEventHandler( "lspd:toggleFlashers", getRootElement(), toggleFlasherState )

function findEmptyEntry(inTable)
	for index,value in ipairs(inTable) do
		if not value.enabled then
			return index
		end
	end
	return #inTable + 1
end


function vehicleSirenspls(playerSource)
	local veh = getPedOccupiedVehicle(playerSource)
	if isElement(veh) then
		local seat = getPedOccupiedVehicleSeat(playerSource)
		if seat == 0 or seat == 1 then
			--if exports["dm_inventory"]:hasItem(veh,177,1) then
				local sirenState = (getElementData(veh,"sirenState") or 0)
				if sirenState == 0 then
					setElementData(veh,"sirenState",1)
					if isElement(getElementData(veh,"sirenMarker")) then
						local markerObject = getElementData(veh,"sirenMarker")
						local r,g,b,a = 0,0,0,0

						if r == 0 and g == 0 and b == 0 and a == 0 then
							setMarkerColor(markerObject,255,0,0,80)
							sirenTables[veh] = setTimer(function()

								local r1,g1,b1,a1 = 255, 0, 0, 80
								if r1 == 255 and g1 == 0 and b1 == 0 and a1 == 80 then
									setMarkerColor(markerObject,0,0,255,80)
								else
									setMarkerColor(markerObject,255,0,0,80)
								end
							end,200,0)
						end
					end
				else
					setElementData(veh,"sirenState",0)
					if isElement(getElementData(veh,"sirenMarker")) then
						local markerObject = getElementData(veh,"sirenMarker")
						setMarkerColor(markerObject,0,0,0,0)

						if isTimer(sirenTables[veh]) then
							killTimer(sirenTables[veh])
						end
					end
				end
			--end
		end
	end
end
addCommandHandler("vehiclesiren", vehicleSirenspls)
addEvent("createLPSDSirens", true)
addEventHandler("createLPSDSirens", getRootElement(), vehicleSirenspls)

funct["triggerVehicleSirens"] = function (thePlayer)
	theVehicle = getPedOccupiedVehicle(thePlayer)
	if (theVehicle) then
		if not getVehicleSirensOn(theVehicle) then
			setVehicleSirensOn(theVehicle, true)
		else
			setVehicleSirensOn(theVehicle, false)
		end
	end
end
addEvent("triggerTheLPSDSirens", true)
addEventHandler("triggerTheLPSDSirens", getRootElement(), funct["triggerVehicleSirens"])
