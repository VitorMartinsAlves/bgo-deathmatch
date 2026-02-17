function pickupskin2 ( thePlayer )
 setPedSkin ( thePlayer, 266 )
end
addEventHandler ( "onPickupUse", skin2, pickupskin2 )




local markerPM = createMarker( 1553.4058837891,-1627.8562011719,15.1828125  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate1 = createObject ( 980, 1553.4058837891,-1627.9992011719,15.3828125, 0, 0, 90 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate1, 1500, 1553.4058837891,-1627.9992011719,9.3828125 )
end
end
 end
addEventHandler("onMarkerHit", markerPM, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 11) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate1, 1500, 1553.4058837891,-1627.9992011719,15.1828125 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM, movingMyGateBack)





thePed = createPed(267, 1544.1572265625,-1632.0162353516,13.3828125, 86.935211181641) -- Creates a ped
function cancelPedDamage()
	cancelEvent() -- Cancels the onClientPedDamage event
end
addEventHandler("onClientPedDamage", thePed, cancelPedDamage)


--skin2 = createPickup (1582.5556640625,-1616.0224609375,17.455364227295, 3, 1275, 0 )


--function pickupskin2 ( thePlayer )
 --setPedSkin ( thePlayer, 135 )
--end
--addEventHandler ( "onPickupUse", skin2, pickupskin2 )
