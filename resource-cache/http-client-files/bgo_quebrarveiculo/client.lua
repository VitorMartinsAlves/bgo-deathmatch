function flip()
    if isPedInVehicle ( localPlayer ) then
        theVehicle = getPedOccupiedVehicle ( localPlayer )
        if isVehicleOnGround ( theVehicle ) then
		if (getVehicleType(theVehicle) == "Automobile") then
            x,y,z = getElementRotation(theVehicle)
            if x>=150 and x <=220 or x>=-220 and x <=-150 or y>=150 and y <=220 or y>=-220 and y <=-150 and getElementHealth(theVehicle)~= 0 then
                if getElementHealth ( theVehicle ) > 300 then
                    triggerServerEvent("UpH",localPlayer,localPlayer, theVehicle)      
                end   
            end
			end
        end
    end
end
addEventHandler ( "onClientRender", root, flip ) 
