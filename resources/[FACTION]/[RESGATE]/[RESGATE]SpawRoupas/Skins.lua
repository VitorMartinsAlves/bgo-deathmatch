
--[[
skin = createPickup (1168.977, -1369.309, 15.386, 3, 1275, 0 )


function pickupskin ( thePlayer )
    local accName = getAccountName(getPlayerAccount(thePlayer))
    if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
     
 setPedSkin ( thePlayer, 274 )
    end
end
addEventHandler ( "onPickupUse", skin, pickupskin )

skin2 = createPickup (1168.94, -1371.569, 15.386, 3, 1275, 0 )


function pickupskin2 ( thePlayer )
    local accName = getAccountName(getPlayerAccount(thePlayer))
    if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
     
 setPedSkin ( thePlayer, 277 )
end
end
addEventHandler ( "onPickupUse", skin2, pickupskin2 )


skin3 = createPickup (1169.015, -1374.384, 15.386, 3, 1275, 0 )


function pickupskin3 ( thePlayer )
    local accName = getAccountName(getPlayerAccount(thePlayer))
    if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
     
 setPedSkin ( thePlayer, 56 )
end
end
addEventHandler ( "onPickupUse", skin3, pickupskin3 )


skin4 = createPickup (1166.267, -1373.571, 15.386, 3, 1275, 0 )


function pickupskin4 ( thePlayer )
    local accName = getAccountName(getPlayerAccount(thePlayer))
    if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
     
 setPedSkin ( thePlayer, 70 )
end
end
addEventHandler ( "onPickupUse", skin4, pickupskin4 )


skin = createPickup (1164.112, -1374.51, 15.386, 3, 1275, 0 )


function pickupskin ( thePlayer )
 setPedSkin ( thePlayer, 71 )
end
addEventHandler ( "onPickupUse", skin, pickupskin )


skin6 = createPickup (1163.829, -1372.329, 15.386, 3, 1275, 0 )


function pickupskin ( thePlayer )
    local accName = getAccountName(getPlayerAccount(thePlayer))
    if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
         setPedSkin ( thePlayer, 0 )
	 end
end
addEventHandler ( "onPickupUse", skin6, pickupskin )
--]]







vidaEnter = createPickup(415.163, 2535.283, 10, 3, 1240, 1)
setElementDimension(vidaEnter, 2)
setElementInterior(vidaEnter, 10)

function vidaEnterHouse (thePlayer)
     if (getElementData(thePlayer, "char:dutyfaction") == 4) then
         outputChatBox("#7cc576[RESGATE] #FFFFFFVocê curou seus #FFFFFF Ferimentos.", thePlayer, 255,255,255, true)
         setElementHealth(thePlayer, 100)
     end
end
addEventHandler("onPickupHit", vidaEnter, vidaEnterHouse)

coleteEnter = createPickup(421.40771484375,2542.7309570313,10, 3, 1242, 1)
setElementDimension(coleteEnter, 2)
setElementInterior(coleteEnter, 10)

function coleteEnterHouse (thePlayer)
     if (getElementData(thePlayer, "char:dutyfaction") == 4) then
         outputChatBox("#7cc576[RESGATE] #FFFFFFVocê pegou um colete #FFFFFFdo RESGATE.", thePlayer, 255,255,255, true)
         setPedArmor(thePlayer, 100 )
     end
end
addEventHandler("onPickupHit", coleteEnter, coleteEnterHouse)


local marker = createMarker(2518.578, 923.991, 11.023-1, "cylinder", 3, 255,255,255, 0)



inf = createPickup (2518.578, 923.991, 11.023, 3, 1275, 0 )

function infoMedic (thePlayer)
     if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) then
	     outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
		-- outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
		-- outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
	     outputChatBox("#FFA000**PARAMÉDICO #FFFFFFID: #FFA0001", thePlayer, 255,255,255, true)
		 outputChatBox("#FFA000**PARAMÉDICA #FFFFFFID: #FFA0002", thePlayer, 255,255,255, true)
		 outputChatBox("#FFA000**MÉDICO #FFFFFFID: #FFA0003", thePlayer, 255,255,255, true)
		-- outputChatBox("#FFA000**MÉDICO #FFFFFFID: #FFA0004", thePlayer, 255,255,255, true)
		 outputChatBox("#FFA000**SEGURANÇA #FFFFFFID: #FFA0005", thePlayer, 255,255,255, true)
		-- outputChatBox("#FFA000**CJ #FFFFFFID: #FFA0006", thePlayer, 255,255,255, true)
		 outputChatBox("#FFA000Syntax: /skin #FFFFFFID", thePlayer, 255,255,255, true)
	 end
end
addEventHandler ( "onPickupUse", inf, infoMedic)

function setS (thePlayer, commandName, setSkin)
     if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) then
	      if isElementWithinMarker(thePlayer, marker) then
	         if (setSkin == "1") then
			     setPedSkin ( thePlayer, 274 )
	       	 end
	         if (setSkin == "2") then
			     setPedSkin ( thePlayer, 233 )
		     end
	         if (setSkin == "3") then
			     setPedSkin ( thePlayer, 70 )
		     end
	         if (setSkin == "4") then
			     setPedSkin ( thePlayer, 71 )
		     end
	        -- if (setSkin == "5") then
			--     setPedSkin ( thePlayer, 0 )
			-- end
		 end
	 end
end
addCommandHandler("skin", setS)






local markerPM = createMarker( 1340.8770751953,-917.51348876953,35.670322418213  - 1, "cylinder", 10, 255, 255, 255, 0)

myGate1 = createObject ( 980, 1337.4720458984,-916.10000000000,36.493955230713, 0, 0, 338.998 )

 function openMyGate (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate1, 200, 1337.4720458984,-916.10000000000,31.593955230713 )
end
end
 end
addEventHandler("onMarkerHit", markerPM, openMyGate)
 
 
 function movingMyGateBack (thePlayer)
	if getElementType(thePlayer) == "player" then 
		local accName = getAccountName(getPlayerAccount(thePlayer))
		--if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "ROTA" ) ) ) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then

			 if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 4) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
 moveObject ( myGate1, 10000, 1337.4720458984,-916.10000000000,36.493955230713 )
end
 end
end
addEventHandler("onMarkerLeave", markerPM, movingMyGateBack)
