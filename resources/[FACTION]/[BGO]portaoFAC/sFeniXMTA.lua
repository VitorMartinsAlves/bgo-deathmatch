--------------------------------------------------------------------------------------------------------

marker = createMarker(935.71539, -835.74774, 95.45537  - 1, "cylinder", 10, 255, 255, 255, 0)
myGate = createObject ( 16775, 935.71539, -835.74774, 95.45537, 0,0,27)

function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 15) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
			moveObject ( myGate, 1500, 935.71539, -835.74774, 94.45537-5 )
		end
	end
end
addEventHandler("onMarkerHit", marker, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 15) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
			moveObject ( myGate, 1500, 935.71539, -835.74774, 95.45537 )
		end
	end
end
addEventHandler("onMarkerLeave", marker, movingMyGateBack)

--------------------------------------------------------------------------------------------------------

marker2 = createMarker(2457.875, -970.361, 80.078  - 1, "cylinder", 10, 255, 255, 255, 0)
myGate2 = createObject ( 16775, 2457.50635, -967.82715, 80.65536, 0,0,0)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 8) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 			moveObject ( myGate2, 1500, 2457.50635, -967.82715, 80.65536-5 )
		end
	end
end
addEventHandler("onMarkerHit", marker2, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 8) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
			moveObject ( myGate2, 1500, 2457.50635, -967.82715, 80.65536 )
		end
	end
end
addEventHandler("onMarkerLeave", marker2, movingMyGateBack)

--------------------------------------------------------------------------------------------------------

marker3 = createMarker(-194.11795, -1681.98767, 2.85537 - 1, "cylinder", 10, 255, 255, 255, 0)
myGate3 = createObject ( 16775, -194.11795, -1681.98767, 2.85537, 0,0,48)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 10) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
			moveObject ( myGate3, 1500, -194.11795, -1681.98767, 2.85537-5 )
		end
	end
end
addEventHandler("onMarkerHit", marker3, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 10) 

			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate3, 1500, -194.11795, -1681.98767, 2.85537 )
end
 end
end
addEventHandler("onMarkerLeave", marker3, movingMyGateBack)

--------------------------------------------------------------------------------------------------------

local marker4 = createMarker(2367.94780, -1695.77625, 13.45537 - 1, "cylinder", 10, 255, 255, 255, 0)

myGate4 = createObject ( 16775, 2367.94780, -1695.77625, 13.45537, 0,0,89)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 25) 
			 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate4, 1500, 2367.94780, -1695.77625, 13.45537-5 )
end
end
 end
addEventHandler("onMarkerHit", marker4, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 25) 

			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate4, 1500, 2367.94780, -1695.77625, 13.45537 )
end
 end
end
addEventHandler("onMarkerLeave", marker4, movingMyGateBack)

--------------------------------------------------------------------------------------------------------

local marker4_2 = createMarker(2398.84717, -1683.63928, 17.63100 - 1, "cylinder", 10, 255, 255, 255, 0)

myGate4_2 = createObject ( 16775, 2398.84717, -1683.63928, 16.83100, 0,0,0)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 25) 
			 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate4_2, 1500, 2398.84717, -1683.63928, 16.83100-10 )
end
end
 end
addEventHandler("onMarkerHit", marker4_2, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 25) 

			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate4_2, 1500, 2398.84717, -1683.63928, 16.83100 )
end
 end
end
addEventHandler("onMarkerLeave", marker4_2, movingMyGateBack)
--------------------------------------------------------------------------------------------------------

local marker5 = createMarker(1247.51303, 278.46204, 20.65536 - 1, "cylinder", 10, 255, 255, 255, 0)

myGate5 = createObject ( 16775, 1248.631, 277.511, 21.655, 0,0,155)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 23) 
			 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate5, 1500, 1248.631, 277.511, 14.655 )
end
end
 end
addEventHandler("onMarkerHit", marker5, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 23) 

			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate5, 1500, 1248.631, 277.511, 21.655 )
end
 end
end
addEventHandler("onMarkerLeave", marker5, movingMyGateBack)

--------------------------------------------------------------------------------------------------------

local marker6 = createMarker(1165.97510, -2037.22583, 70 - 1, "cylinder", 10, 255, 255, 255, 0)

myGate6 = createObject ( 16775, 1165.97510, -2037.22583, 70, 0,0,90)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 7) 
			 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate6, 1500, 1165.97510, -2037.22583, 70-6 )
end
end
 end
addEventHandler("onMarkerHit", marker6, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 7) 

			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate6, 1500, 1165.97510, -2037.22583, 70 )
end
 end
end
addEventHandler("onMarkerLeave", marker6, movingMyGateBack)

--------------------------------------------------------------------------------------------------------

local marker7 = createMarker(311.01587, -1177.05701, 84.05537 - 1, "cylinder", 10, 255, 255, 255, 0)

myGate7 = createObject ( 16775, 311.01587, -1177.05701, 84.05537, 0,0,225)

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 18) 
			 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate7, 1500, 311.01587, -1177.05701, 84.05537-8 )
end
end
 end
addEventHandler("onMarkerHit", marker7, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 18) 

			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate7, 1500, 311.01587, -1177.05701, 84.05537 )
end
 end
end
addEventHandler("onMarkerLeave", marker7, movingMyGateBack)





local markerPM9 = createMarker( 756.019, -540.052, 16.4  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate9 = createObject ( 16775, 756.269, -540.052, 17.4,0,0,180.41638183594 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 26) 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate9, 1500, 756.269, -540.052, 11.3 )
end
end
 end
addEventHandler("onMarkerHit", markerPM9, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 26) 
			 or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate9, 1500, 756.269, -540.052, 17.4 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM9, movingMyGateBack)