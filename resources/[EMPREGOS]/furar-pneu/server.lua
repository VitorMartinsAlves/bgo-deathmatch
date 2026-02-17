function teste (thePlayer, rde, rte, rdd, rtd)
	local vehicle = getPedOccupiedVehicle(thePlayer)
	if vehicle then
	thePlayer2 = getVehicleController ( vehicle ) 
	if ( thePlayer2 ) then

		controller = getVehicleController ( vehicle ) 
		if controller == thePlayer then 


  if getVehicleType(vehicle) == "Automobile" then
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox(" ", thePlayer, 255,255,255, true)
outputChatBox("#FFA000[SEGURO BGO] #FFFFFFInfelizmente seu pneu furou, chame um mecânico para te conciliar no reparo!!", thePlayer, 255,255,255, true)
playSoundFrontEnd ( thePlayer, 30)
		setVehicleWheelStates(vehicle, rde, rte, rdd, rtd)
		setVehicleEngineState(vehicle,false)
		setElementData(vehicle, "veh:motor",false)

end
end
end
end
end
addEvent ("furarS", true)
addEventHandler ("furarS", getRootElement(), teste)

