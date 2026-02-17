local con = exports.bgo_mysql:getConnection()


Async:setPriority("high")
Async:setDebug(false)



--[[
function consultAcc (thePlayer, command, mode, idac)

     if mode == "id" then
	     resultAcc = dbQuery(con, "SELECT * FROM accounts WHERE id=?", idac)
	 end
	 if mode == "nome" then
	     resultAcc = dbQuery(con, "SELECT * FROM accounts WHERE username=?", idac)
	 end
	     if not mode then
		     outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFAdicione um nome.", thePlayer, 255,255,255, true)
		 else
	     if not idac then
		     outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFAdicione um ID.", thePlayer, 255,255,255, true)
		 else
		 if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 3 then
             local result = dbPoll(resultAcc, -1)  
			 if #result ~= 0 then
			     outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFID: #FFFFFF"..result[1]["id"].." #7cc576NOME: #FFFFFF"..result[1]["username"].." #7cc576SERIAL: #FFFFFF"..result[1]["mtaserial"], thePlayer, 255,255,255, true)
			     else
				 outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFNenhuma conta localizada.", thePlayer, 255,255,255, true)
				 end
			 end
		 end
     end
end
addCommandHandler("ca", consultAcc)

]]--

function consultAcc (thePlayer, command, mode, idac)
	     if not mode then
		     outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFUso correto: /"..command.." id [ID]", thePlayer, 255,255,255, true)
		 else
	     if not idac then
		     outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFAdicione um ID.", thePlayer, 255,255,255, true)
		 else
		 if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 3 then
		 

    dbQuery(
        function(query)
            local query = dbPoll(query, -1)
           if #query ~= 0 then
                Async:foreach(query, 
                function(row)
				outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFID: #FFFFFF"..query[1]["id"].." #7cc576NOME: #FFFFFF"..query[1]["username"].." #7cc576SERIAL: #FFFFFF"..query[1]["mtaserial"], thePlayer, 255,255,255, true)
				print("[BGO ACCOUNT]: ID: "..query[1]["id"].." NOME: "..query[1]["username"].." SERIAL: "..query[1]["mtaserial"])
                end
                )
				else
				outputChatBox("#7cc576[BGO ACCOUNT]: #FFFFFFNenhuma conta localizada.", thePlayer, 255,255,255, true)
            end
        end, 
    con, "SELECT * FROM accounts WHERE id=?", idac)
				 
				 
			 end
		 end
     end
end
addCommandHandler("ca", consultAcc)


