 --[[
 
 gate = createObject (16773, 1286.3621826172, -1652.2672119141, 16.546875 , 0, 0, 89 )
                                                
local marker = createMarker( 1286.8142089844, -1652.1851806641, 13.546875  - 1, "cylinder", 10, 255, 255, 255, 0)
 --createBlipAttachedTo (marker, 19 )
  --      local zone = createColCuboid(2011.81323, -1662.20300, 14.02172, 59.869140625, 39.875122070313, 15.975908660889)


function moveGate(thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
--if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("TAXI")) then

--if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 12) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

	if getElementData(thePlayer, "char:dutyfaction") == 12 then
           moveObject ( gate, 1000, 1286.3621826172, -1652.2672119141, 8.546875) 
end
end
end
addEventHandler("onMarkerHit", marker, moveGate)


function moveGate(thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			-- if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 12) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then


				if getElementData(thePlayer, "char:dutyfaction") == 12 then


          --setTimer(moveBack, 1000, 1)
		   moveObject ( gate, 1000, 1286.3621826172, -1652.2672119141, 16.546875 )
		   end
		end
end
addEventHandler("onMarkerLeave", marker, moveGate)
 
function moveBack()
 moveObject ( gate, 1000, 1286.3621826172, -1652.2672119141, 16.546875 )
end



]]--





--PORTÃO PM




--addEventHandler("onMarkerLeave", markerCabron2, movingMyGateBack)



telesubir = createPickup (1445.3905029297,-984.5146484375,30.949016571045, 3, 1318, 0 )

addEventHandler ( "onPickupUse", telesubir,
function( hitElement )
setElementPosition(hitElement, 1400.1625976563,-971.76507568359,46.9375)
end
)



telesubir2 = createPickup (1396.6800537109,-976.18157958984,46.9375, 3, 1318, 0 )

addEventHandler ( "onPickupUse", telesubir2,
function( hitElement )
setElementPosition(hitElement, 1443.2864990234,-984.51831054688,30.950559616089)
end
)




