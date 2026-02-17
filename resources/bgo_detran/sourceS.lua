

addEvent("giveJogsi",true)
addEventHandler("giveJogsi",getRootElement(),function(player,name,azon,kep,erv)
	exports["bgo_items"]:giveItem(player,28,toJSON({name,azon,kep,erv}),1)
end)


local marker = createMarker (2533.993, -2117.574, 12.538, "cylinder", 1.5, 248,248,255 )

addEventHandler('onMarkerHit', marker,
function (vehicle)
     if getElementType (vehicle) == "vehicle" then
         setVehicleColor(vehicle, 7, 168, 254)
     end
end)