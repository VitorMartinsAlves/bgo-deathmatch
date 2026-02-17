------------------------- PORTÃO ----------------------------------

local gate = createObject  ( 980 , 2467.2, 942.59998, 12.5, 0, 0, 0)
local marker = createMarker(2467.2, 942.59998, 12.5, "cylinder", 6, 255, 255, 255, 0)

function moveGate(thePlayer)
	if getElementType(thePlayer) == "player" then 
		 local accName = getAccountName(getPlayerAccount(thePlayer))
		 --if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ALQ" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

           moveObject(gate,  2000, 2477.2, 942.59998, 12.5)
	 end
	end
end
addEventHandler("onMarkerHit", marker, moveGate)
 
function moveBack(thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ALQ" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) )  ) then

          moveObject(gate, 2000, 2467.2, 942.59998, 12.5)
		end
	end
end
addEventHandler("onMarkerLeave", marker, moveBack)

