

local markerPM8 = createMarker( 2411.305, -2427.624, 13.375  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate8 = createObject ( 16775, 2411.8999023438, -2427.6999511719, 16.39999961853, 0,0,44.519348144531 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate8, 1500, 2411.8999023438, -2427.6999511719, 8.39999961853 )
end
end
 end
addEventHandler("onMarkerHit", markerPM8, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate8, 1500, 2411.8999023438, -2427.6999511719, 16.39999961853 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM8, movingMyGateBack)





local markerPM1 = createMarker( 2534.59, -2331.482, 22.402  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate2 = createObject ( 16775, 2533.3000488281, -2330.3999023438, 25.799999237061, 0, 0, 42.269348144531 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate2, 1500, 2533.3000488281, -2330.3999023438, 17.539999237061 )
end
end
 end
addEventHandler("onMarkerHit", markerPM1, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate2, 1500, 2533.3000488281, -2330.3999023438, 25.799999237061 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM1, movingMyGateBack)






local markerPM4 = createMarker( 2627.33, -2456.918, 13.633  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate3 = createObject ( 16775, 2627.6000976563, -2458.5, 16.39999961853,0,0,359.25 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate3, 1500, 2627.6000976563, -2458.5, 8.39999961853 )
end
end
 end
addEventHandler("onMarkerHit", markerPM4, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate3, 1500, 2627.6000976563, -2458.5, 16.39999961853 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM4, movingMyGateBack)





local markerPM3 = createMarker( 2373.972, -2663.539, 13.499  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate4 = createObject ( 16775, 2373.8000488281, -2663.3000488281, 16.5,0,0,268.41638183594 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate4, 1500, 2373.8000488281, -2663.3000488281, 8.52 )
end
end
 end
addEventHandler("onMarkerHit", markerPM3, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 2) 
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 5)  
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 6)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 16)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 19)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 20)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 21)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 22)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 24)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 28)
			 or exports.bgo_dashboard:isPlayerInFaction(thePlayer , 1)
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate4, 1500, 2373.8000488281, -2663.3000488281, 16.5 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM3, movingMyGateBack)








local markerPM5 = createMarker( 632.729, -593.985, 16.336  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate5 = createObject ( 980, 632.34637451172,-594.46411132813,18.1359375,0,0,91.151107788086 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate5, 1500, 632.34637451172,-594.46411132813,12.5359375 )
end
end
 end
addEventHandler("onMarkerHit", markerPM5, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 17) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate5, 1500, 632.34637451172,-594.46411132813,18.1359375 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM5, movingMyGateBack)