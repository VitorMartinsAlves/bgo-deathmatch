local con = exports.bgo_mysql:getConnection()

function getMembers () 
	return #getElementsByType ( "player" )
end

function sendMessage (author, ...)
	local tablemen = {...}
    local message = tablemen[1] 
	--outputChatBox(' ', root, 255,255,255, true)
	--outputChatBox(' ', root, 255,255,255, true)
	--outputChatBox(' ', root, 255,255,255, true)
	--outputChatBox(' ', root, 255,255,255, true)
	--outputChatBox(' ', root, 255,255,255, true)
	outputChatBox(' ', root, 255,255,255, true)
	outputChatBox(' ', root, 255,255,255, true)
	outputChatBox('#00AAFF[VIA DISCORD:] '..author..' Diz: #FFFFFF'..message, root, 255,255,255, true)
	--outputChatBox('#00AAFF[INFO] #FFFFFFEssa é uma mensagem enviada do Discord do BGO', root, 255,255,255, true)
	return "1"
end

function getPlayerFromSerial ( serial )
    assert ( type ( serial ) == "string" and #serial == 32, "getPlayerFromSerial - invalid serial" )
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        if ( getPlayerSerial ( player ) == serial ) then
            return player
        end
    end
    return false
end

function setpp (idaccount, status, pp)
	if idaccount and status and pp then
		local idaccount = tonumber(idaccount) 
		local pp = tonumber(pp)
		local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(_, idaccount)
		if targetPlayer then 
			local status = tonumber(status) 
			local oldPP = getElementData(targetPlayer, "char:pp") or 0
			if (status) == 1 then
				local sql = dbExec(con, "UPDATE characters SET premiumpont='" .. pp .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					setElementData(targetPlayer, "char:pp", pp)	
					return "2"
				else 
					print('Erro')
				end
			elseif (status) == 2 then
				local sql = dbExec(con, "UPDATE characters SET premiumpont='".. getElementData(targetPlayer, "char:pp") + pp .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					setElementData(targetPlayer, "char:pp", oldPP + pp)	
					return "2"
				else 
					print('Erro')
				end
			elseif (status) == 3 then
				local sql = dbExec(con, "UPDATE characters SET premiumpont='".. getElementData(targetPlayer, "char:pp") - pp .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					setElementData(targetPlayer, "char:pp", oldPP - pp)			
					return "2"
				else 
					print('Erro')
				end
			else 
				return "na"
			end
		else 
			return "0"
		end
	else 
		return "na" 
	end
end

function banP (serial, times, arg)
	if serial and times and arg then
		local player = getPlayerFromSerial (serial)
		local seconds = 0
		if arg == 'd' then 
			seconds = times * 24 * 60 * 60000
		elseif arg == 'h' then 
			seconds = times * 60 * 60000
		else 
			return "0"
		end
		if player then
			addBan (_, _, serial, player, _, seconds)
			return "1"
		else 
			addBan (_, _, serial, _, _, seconds)
			return "1"
		end
	else 
		return "0"
	end
end

function getSeriaisBanidos (serial) 
	for _,ban in ipairs(getBans())do
		if getBanSerial(ban) == serial then
			removeBan(ban)
			return true 
		end
	end return false
end

function unbanP (serial)
	if serial then
		if getSeriaisBanidos (serial)  then 
			return "1"
		else 
			return "0"
		end
	end
end

local db = exports.serialVip:getConnection()

function svipP (idP)
	local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(_, idP)
	if targetPlayer then 
		local sevip = dbQuery(db, "SELECT * FROM SERIAL_VIP WHERE ID=?", vipSID)
		local result = dbPoll(sevip, -1)  
        if #result == 0 then  
			dbFree(dbQuery(db, "INSERT INTO SERIAL_VIP ( ID, SERIAL, POR ) VALUES ( '"..idP.."', '"..getPlayerSerial(targetPlayer).."', 'DISCORD')"))
			return "1"
		else 
			return "2"
		end
	else 
		return "0"
	end
end

function rvipP (idP)
	local sevip = dbQuery(db, "SELECT * FROM SERIAL_VIP WHERE ID=?", vipSID)
	local result = dbPoll(sevip, -1)  
	if #result ~= 0 then  
		dbExec(db, "DELETE FROM SERIAL_VIP WHERE ID=?", idP) 
		return "1"
	else 
		return "2"
	end
end