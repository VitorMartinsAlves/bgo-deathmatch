local rName = getResourceName ( getThisResource ( ) )
function sendClientMessage ( msg, who, r, g, b, pos, time )
	if ( msg and who ) then
		if ( isElement ( who ) ) then
			triggerClientEvent ( who, rName..":sendClientMessage", who, msg, r, g, b, pos, time )
			return true
		else return false end
	else return false end
end

addEventHandler ( 'onPlayerWasted', root, function ( ammo, k, w, bodyparty, stealth)
    if isObjectInACLGroup ( "user." .. getAccountName (getPlayerAccount(source)), aclGetGroup ( "VIP" ) ) then	
		if k then
			sendClientMessage ( "#CDCDCD"..getPlayerName(k).." #FFFFFFmatou #CDCDCDVocê.",  source, 255, 255, 255, false )
		else
			sendClientMessage ( "#CDCDCDVocê #FFFFFFcometeu suícidio.",  source, 255, 255, 255, false )
		end
	end
	if k then
    	if isObjectInACLGroup ( "user." .. getAccountName (getPlayerAccount(k)), aclGetGroup ( "VIP" ) ) then	
			sendClientMessage ( "#CDCDCD Você #FFFFFFmatou #CDCDCD"..getPlayerName(source)..'.',  k, 255, 255, 255, false )
		end
    end
end)
