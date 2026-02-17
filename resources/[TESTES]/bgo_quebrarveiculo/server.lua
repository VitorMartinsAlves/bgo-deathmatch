addEvent("UpH", true)
addEventHandler("UpH",root,
function(thePlayer, veiculo)
--if getVehicleController(getPedOccupiedVehicle(source)) == source then
if getPedOccupiedVehicleSeat(thePlayer) == 0 then
	setElementHealth ( veiculo, 290 )
	end
end)
