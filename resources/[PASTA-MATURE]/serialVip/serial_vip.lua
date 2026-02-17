db = dbConnect("sqlite", "database.db") or 0
local con = exports.bgo_mysql:getConnection()

function getConnection ()
	return db 
end

addEventHandler("onResourceStart", resourceRoot,
function()
    dbExec(db, "CREATE TABLE IF NOT EXISTS SERIAL_VIP ( ID INT, SERIAL TEXT, POR TEXT )") 
end)

function setSerial (thePlayer, command, idP)
      if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 9 then
         local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, idP)
	     if targetPlayer then 
		 vipSID = tonumber(getElementData(targetPlayer, "char:id"))
		 adminS = tonumber(getElementData(thePlayer, "char:id"))
             local sevip = dbQuery(db, "SELECT * FROM SERIAL_VIP WHERE ID=?", vipSID)
             local result = dbPoll(sevip, -1)  
             if #result == 0 then  
			     local vipSerial = getPlayerSerial(targetPlayer)
				 outputChatBox("#7cc576[BGO INFO] #FFFFFFVocê adicionou com sucesso o jogador " .. targetPlayerName:gsub("_"," ") .. " serial "..vipSerial.." como vip.", thePlayer, 255,255,255, true)
				 dbFree(dbQuery(db, "INSERT INTO SERIAL_VIP ( ID, SERIAL, POR ) VALUES ( '"..vipSID.."', '"..vipSerial.."', '"..adminS.."')"))
				 exports.logs:logMessage("[SET VIP]: " .. getPlayerName(thePlayer) .. " setou o jogador " .. targetPlayerName:gsub("_"," ") .. " como VIP", 3)
				 else
				 outputChatBox("#7cc576[BGO ERROR] #FFFFFFO serial do jogador já esta setado como VIP", thePlayer, 255,255,255, true)
		     end
			 else
			 --resuldSerial = dbQuery(con, "SELECT * FROM accounts WHERE id=?", idP)
             --local resultSB = dbPoll(resuldSerial, -1) 
			 
			 resuldSerialB = dbQuery(db, "SELECT * FROM SERIAL_VIP WHERE ID=?", idP)
             local resultS = dbPoll(resuldSerialB, -1) 
			 if #resultS == 0 then
			 --[[
			     local SBANK = resultSB[1]["mtaserial"]
				 local IDBAN = resultSB[1]["id"]
				 adminS = tonumber(getElementData(thePlayer, "char:id"))
				 dbFree(dbQuery(db, "INSERT INTO SERIAL_VIP ( ID, SERIAL, POR ) VALUES ( '"..IDBAN.."', '"..SBANK.."', '"..adminS.."')"))
				 outputChatBox("#7cc576[BGO INFO] #FFFFFFO jogador está offline, dados retirado do banco de dados.", thePlayer, 255,255,255, true)
				 outputChatBox("#7cc576[BGO INFO] #FFFFFFVocê adicionou com sucesso o serial "..SBANK.." como vip.", thePlayer, 255,255,255, true)
				 ]]--
				 
    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
            if query_lines > 0 then
                Async:foreach(query, 
                    function(row)
			     local SBANK = row["mtaserial"]
				 local IDBAN = row["id"]
				 local NOME = row["username"]
				 adminS = tonumber(getElementData(thePlayer, "char:id"))
				 dbFree(dbQuery(db, "INSERT INTO SERIAL_VIP ( ID, SERIAL, POR ) VALUES ( '"..IDBAN.."', '"..SBANK.."', '"..adminS.."')"))
				 outputChatBox("#7cc576[BGO INFO] #FFFFFFO jogador está offline, dados retirado do banco de dados.", thePlayer, 255,255,255, true)
				 outputChatBox("#7cc576[BGO INFO] #FFFFFFVocê adicionou com sucesso o jogador "..NOME.." serial "..SBANK.." como vip.", thePlayer, 255,255,255, true)
                    end
                )
            end
        end, 
    con, "SELECT * FROM accounts WHERE id=?", idP)
	
	
				 else
				 outputChatBox("#7cc576[BGO ERROR] #FFFFFFO serial do jogador já esta setado como VIP", thePlayer, 255,255,255, true)
			 end
		 end
	 end
end
addCommandHandler("svip", setSerial)




function remSerial (thePlayer, command, idR)
 if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 9 then
     local Vvip = dbQuery(db, "SELECT * FROM SERIAL_VIP WHERE ID=?", idR)
     local gresult = dbPoll(Vvip, -1)  
         if #gresult ~= 0 then  
		 local vipSerial = gresult[1]["SERIAL"]
		 outputChatBox("#7cc576[BGO INFO] #FFFFFFVocê removeu com sucesso o serial "..vipSerial.." como vip.", thePlayer, 255,255,255, true)
		 dbExec(db, "DELETE FROM SERIAL_VIP WHERE ID=?", idR) 
		 exports.logs:logMessage("[SET VIP]: " .. getPlayerName(thePlayer) .. " removeu o jogador ID:[" .. idR .. "] como VIP", 3)
		 else
		 outputChatBox("#7cc576[BGO ERROR] #FFFFFFNada localizado no banco de dados.", thePlayer, 255,255,255, true)
	 end
end
end
addCommandHandler("rvip", remSerial)

function isPlayerVip (isVip)
     if isVip then
	     vipVID = tonumber(getElementData(isVip, "char:id"))
         local Vvip = dbQuery(db, "SELECT * FROM SERIAL_VIP WHERE ID=?", vipVID)
         local resultV = dbPoll(Vvip, -1)  
         if #resultV ~= 0 then 
		     return true
		 end
	 end
end




function sabervip (thePlayer, command)
if  isPlayerVip (thePlayer) then
outputChatBox("#7cc576[BGO INFO] #FFFFFFVOCÊ ESTÁ APLICADO NO SISTEMA DA TEMPORADA.", thePlayer, 255,255,255, true)
end
end
addCommandHandler("doador", sabervip)