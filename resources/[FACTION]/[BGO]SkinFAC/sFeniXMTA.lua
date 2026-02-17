skin = createPickup (971.411, -862.296, 95.755, 3, 1275, 100 )
name="Patrão"	
setElementData(skin, "name:pickup", name)
function pickupskin ( thePlayer )
local accName = getAccountName(getPlayerAccount(thePlayer))
			if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 15) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) )  ) then

 setElementModel ( thePlayer, 190 )
 end
end
--addEventHandler ( "onPickupUse", skin, pickupskin )
addEventHandler( "onPickupHit", skin, pickupskin )



skin2 = createPickup (744.759, -574.68, 20.613, 3, 1275, 100 )
name="Patrão"	
setElementData(skin2, "name:pickup", name)
function pickupskin ( thePlayer )
local accName = getAccountName(getPlayerAccount(thePlayer))
			if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 26) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) )  ) then

 setElementModel ( thePlayer, 55 )
 end
end
--addEventHandler ( "onPickupUse", skin, pickupskin )
addEventHandler( "onPickupHit", skin2, pickupskin )