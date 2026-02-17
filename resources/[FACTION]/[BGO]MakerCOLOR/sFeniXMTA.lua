
--BDM
 local marker = createMarker (920.497, -847.604, 94.455, "cylinder", 1.5, 0, 255, 255, 255 )

addEventHandler('onMarkerHit', marker,
function (vehicle)
     if getElementType (vehicle) == "vehicle" then
         setVehicleColor(vehicle, 255, 255, 255)
     end
end)