connection = dbConnect("sqlite", "data.db")

--local connection2 = exports["bgo_mysql"]:getConnection()
local phoneContacts = {}

if fileExists("databgozap.db") then
	fileDelete("databgozap.db")
end	

connection2 = dbConnect("sqlite", "databgozap.db")

addEventHandler("onResourceStart", resourceRoot,
function ()													
	local db = dbExec(connection, "CREATE TABLE IF NOT EXISTS `TELEFONE` (`id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `LOGIN` TEXT, `CONTATOS` TEXT, `name` TEXT)")  
	local db2 = dbExec(connection, "CREATE TABLE IF NOT EXISTS `TELEFONECONF` (`id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `LOGIN` TEXT, `wallpaper` TEXT, `music` TEXT)") 

	local db3 = dbExec(connection2, "CREATE TABLE IF NOT EXISTS `TELEFONEWP` (`id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `msg` TEXT, `celular` TEXT)") 


	if db then
	outputDebugString("Banco de dados do celular ligado com sucesso")
	else
	outputDebugString("Ocorreu algum problema com o Banco de dados do celular")
	end
	
	if db2 then
	outputDebugString("Banco de dados 2 do celular ligado com sucesso")
	else
	outputDebugString("Ocorreu algum problema com o Banco de dados 2 do celular")
	end

	if db3 then
	outputDebugString("Banco de dados do BGOZAP ligado com sucesso")
	else
	outputDebugString("Ocorreu algum problema com o Banco de dados do BGOZAP")
	end
	
end
)

function generatePhoneNumber()
	return math.random(1111111,9999999)
end
	
function getPhoneDataFromServer(playerSource, phoneID)
	if tonumber(phoneID) then
		local qh = dbQuery(connection, "SELECT * FROM TELEFONECONF WHERE LOGIN=?", tonumber(phoneID))
		local result = dbPoll(qh, -1)
		if (#result > 0) then
		triggerClientEvent(playerSource, "getPhoneDataToClient", playerSource,  result[1]["wallpaper"], result[1]["music"])
		else	
		local query = dbQuery(connection, "INSERT INTO TELEFONECONF ( wallpaper, music, LOGIN) VALUES ( '3', '2', '"..phoneID.."' )")
		local QueryEredmeny,_,insertID = dbPoll(query, -1)	
		if insertID then
		triggerClientEvent(playerSource, "getPhoneDataToClient", playerSource, 3, 2)
		end
		end
	end
end
addEvent("getPhoneDataFromServer", true)
addEventHandler("getPhoneDataFromServer", getRootElement(), getPhoneDataFromServer)




function getPhoneContactFromServer(playerSource, ownerPhone)
	local phoneContacts = {}
	phoneContacts = {}
		local qh = dbQuery(connection, "SELECT * FROM TELEFONE WHERE LOGIN=?", ownerPhone)
		local result = dbPoll(qh, -1)
		if (#result < 0) then	
		triggerClientEvent(playerSource, "getPhoneContactToClient", playerSource, {})
		else
		for k, v in ipairs(result) do
			phoneContacts[#phoneContacts + 1] = {v["name"], tonumber(v["CONTATOS"]),v["id"]}
			triggerClientEvent(playerSource, "getPhoneContactToClient", playerSource, phoneContacts)
		end
	end
end
addEvent("getPhoneContactFromServer", true)
addEventHandler("getPhoneContactFromServer", getRootElement(), getPhoneContactFromServer)



function nocontato(phoneNumber)
		for k, v in ipairs(phoneContacts) do		
			if (tonumber(v[2]) == tonumber(phoneNumber)) then
				return true --v[1]
			end
		end
		return false
end


function removeFromContactS(playerSource, row, id)
	if (dbExec(connection, "DELETE FROM TELEFONE WHERE id = ?", id)) then
		outputChatBox("#D64541[Telefone] #ffffffContato: "..id.." deletado com sucesso", playerSource,255,255,255,true)
		triggerClientEvent(playerSource, "removeFromContactC", playerSource, row)
	end		
end
addEvent("removeFromContactS", true)
addEventHandler("removeFromContactS", getRootElement(), removeFromContactS)


function getChatFromServer(playerSource, phoneID)
	local chatS = {}
	-- chatS = {}
	if (tonumber(phoneID)) then
		if (tonumber(phoneID) > 0) then	
			local checkID = dbPoll(dbQuery(connection2, "SELECT * FROM chat WHERE owner = ?", tonumber(phoneID)), -1)
			if (checkID) then
				for k, v in ipairs(checkID) do
					chatS[#chatS + 1] = {v["targetid"]}
				end
			end				
		end
		triggerClientEvent(playerSource, "getChatToClient", playerSource, chatS)
	end
end
addEvent("getChatFromServer", true)
addEventHandler("getChatFromServer", getRootElement(), getChatFromServer)


function loadMessages(playerSource, phoneID)
	local messagesTable = {}
	messagesTable = {}
	local QueryEredmeny = dbQuery( connection2, "SELECT * FROM TELEFONEWP WHERE celular=?", tonumber(phoneID))
	local result = dbPoll(QueryEredmeny, -1)
	if (#result > 0) then
		for k, v in ipairs(result) do
			tableData = fromJSON(v["msg"])
			if tonumber(tableData[3]) == tonumber(phoneID) then
				if not messagesTable[tonumber(tableData[7])] then
					messagesTable[tonumber(tableData[7])] = {}
				end
				messagesTable[tonumber(tableData[7])][#messagesTable[tonumber(tableData[7])] + 1] = {tableData[1], tableData[2], tableData[3], tableData[4], tableData[5], tableData[6]}
			end
		end
		triggerClientEvent(playerSource, "loadMessagesInClient", playerSource, messagesTable)
	end
end
addEvent("loadMessages", true)
addEventHandler("loadMessages", getRootElement(), loadMessages)


function sendMessagesInServer(playerSource, fromID, toID, msg, when, date)
	if playerSource and fromID and toID and msg then
	
		if (checkOnline(toID)) then
			insertMsg(fromID, toID, fromID, msg, date, when, toID) 
			insertMsg(fromID, toID, toID, msg, date, when, fromID)
			
			local targetPlayer = checkOnline(toID)
			if targetPlayer then
			--if nocontato( tonumber(getElementData(targetPlayer, "char:telefone"))) then
			
			loadMessages(playerSource, tonumber(getElementData(playerSource, "char:telefone")))
			loadMessages(targetPlayer, tonumber(getElementData(targetPlayer, "char:telefone")))

			--else
			--outputChatBox("#D64541[Erro] #ffffffJogador não está na lista de contatos", playerSource,255,255,255,true)
			--end
	
			--exports.bgo_noti:serverNotification (targetPlayer, "info", "Nova mensagem de " ", 10, 20)
			
			
			--triggerClientEvent(playerSource, "sendMessagesInClient", playerSource, fromID, toID, toID, msg, date, when, toID, fromID)
			--triggerClientEvent(targetPlayer, "sendMessagesInClient", targetPlayer, fromID, toID, fromID, msg, date, when, fromID, toID)
			end
		else
			outputChatBox("#D64541[Erro] #ffffffJogador não esta na cidade!", playerSource,255,255,255,true)
		end		
	end

end
addEvent("sendMessagesInServer", true)
addEventHandler("sendMessagesInServer", getRootElement(), sendMessagesInServer)


function insertMsg(from, to, number, msg, date, when, fasz)

local insert = dbExec(connection2, "INSERT INTO TELEFONEWP ( msg, celular ) VALUES ( '"..toJSON({from, to, number, msg, date, when, fasz}).."', '"..number.."' )")

end

function insertChat(playerSource, fromID, toID, phoneID)
	local checkID = dbPoll(dbQuery(connection2, "SELECT * FROM chat"), -1)
	if (checkID) then
		for k, v in ipairs(checkID) do
			if (tonumber(v["owner"]) == tonumber(fromID)) then
				if (tonumber(toID) == tonumber(v["targetid"])) then
					return false
				end
			end
		end
		local insterT = dbQuery(connection2, "INSERT INTO chat SET owner = ?, targetid = ?", fromID, toID)
		local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)
		if QueryEredmeny then
			return true
		end
	end
end





function editContactS(playerSource, number, name, ownerPhone, row, id)
	if (name) and (number) and (ownerPhone) then
			if not tonumber(number) then
			--print(""..number.."Apenas numeros")
			--triggerClientEvent(playerSource, "answerPhone", playerSource, 1)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox("#D64541[Telefone] #ffffffContato: só pode adicionar apenas numeros na parte do telefone!", playerSource,255,255,255,true)
			
			
			return
			end
			--local qh = dbQuery(connection, "SELECT * FROM TELEFONE WHERE LOGIN=?", ownerPhone)
			--local result = dbPoll(qh, -1)
			--if (#result > 0) then
			
			if dbExec(connection, 'UPDATE TELEFONE SET name=?, CONTATOS=? WHERE id=?', name, tonumber(number), id) then
			outputChatBox("#D64541[Telefone] #ffffffContato "..id.." Alterado para: Nome: "..name.."  Numero: "..number.." com sucesso", playerSource,255,255,255,true)
			triggerClientEvent(playerSource, "editContactC", playerSource, name, number, row, id)
			--end	
		end		
	end
end
addEvent("editContactS", true)
addEventHandler("editContactS", getRootElement(), editContactS)

function addContactMemberS(playerSource, number, name, ownerPhone)
	if not tonumber(number) then
outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox(" ", playerSource,255,255,255,true)
			outputChatBox("#D64541[Telefone] #ffffffContato: só pode adicionar apenas numeros na parte do telefone!", playerSource,255,255,255,true)
	return
	end
	local query = dbQuery(connection, "INSERT INTO TELEFONE ( name, CONTATOS, LOGIN) VALUES ( '"..name.."', '"..number.."', '"..ownerPhone.."' )")
	local QueryEredmeny,_,insertID = dbPoll(query, -1)	
	if insertID then
	--print("CONTATOS "..insertID..", "..name..", "..number.."  ADICIONADO")
	outputChatBox("#D64541[Telefone] #ffffffContato: "..name..", "..number.." Salvo com sucesso", playerSource,255,255,255,true)
	triggerClientEvent(playerSource, "addContactMemberC", playerSource, name, number, insertID)
	end

end
addEvent("addContactMemberS", true)
addEventHandler("addContactMemberS", getRootElement(), addContactMemberS)

function editWallpaperInServer(playerSource, phoneID, wallPaperID)
if dbExec(connection, 'UPDATE TELEFONECONF SET wallpaper=? WHERE LOGIN=?', wallPaperID, phoneID) then
outputChatBox("#D64541[Telefone] #ffffffWallpaper Alterado para: "..wallPaperID.." Numero do telefone: "..phoneID.." Salvo com sucesso", playerSource,255,255,255,true)
end
end
addEvent("editWallpaperInServer", true)
addEventHandler("editWallpaperInServer", getRootElement(), editWallpaperInServer)

function editRingInServer(playerSource, phoneID, musicID)
if dbExec(connection, 'UPDATE TELEFONECONF SET music=? WHERE LOGIN=?', musicID, phoneID) then
setElementData(playerSource, "musicID", musicID)
outputChatBox("#D64541[Telefone] #ffffffAlarme Alterado para: "..musicID.." Numero do telefone: "..phoneID.." Salvo com sucesso", playerSource,255,255,255,true)
end
end
addEvent("editRingInServer", true)
addEventHandler("editRingInServer", getRootElement(), editRingInServer)

function checkOnline(phoneNumber)
	for k, v in ipairs(getElementsByType("player")) do
		if v and tonumber(getElementData(v, "char:telefone")) == tonumber(phoneNumber) then --and exports.bgo_items:hasItemS(v, 16, phoneNumber) then
			return v
		end
	end
	return false
end

for k, player in ipairs(getElementsByType("player")) do
	setElementData(player, "inCallON", false)
	setElementData(player, "inCall2", false)
end

function callMember(number)
	for k, v in ipairs(getElementsByType("player")) do
		if v and tonumber(number) and tonumber(getElementData(v, "char:telefone")) == number then --tonumber(number) and exports.bgo_items:hasItemS(v, 16, number) then
		return v
		end
	end
	return false
end

function callTargetInServer(playerSource, number, playerNumber)
	if number then
		local targetPlayer = callMember(number)
		if targetPlayer ~= false then --and targetPlayer ~= "inCall2" then
			if targetPlayer == playerSource then
				outputChatBox("#D64541[Erro] #ffffffEsta pessoa não pode atender no momento!", playerSource,255,255,255,true)
				return 
			end
			if getElementData(targetPlayer, "inCall2") == true then
				outputChatBox("#D64541[Erro] #ffffffEste número já está em chamada!", playerSource,255,255,255,true)
				return 
			end
			if getElementData(targetPlayer, "inCallON") == true then
				outputChatBox("#D64541[Erro] #ffffffEste número já está em chamada!", playerSource,255,255,255,true)
				return 
			end
			setElementData(playerSource, "inCallON", true)
			setElementData(targetPlayer, "inCallON", true)

			triggerClientEvent(targetPlayer, "showMenu", targetPlayer, playerNumber, 6, playerSource, number)
			
			triggerClientEvent(playerSource, "showMenu", playerSource, number, 7, targetPlayer, playerNumber)
			
			
			triggerClientEvent(targetPlayer, "showSound", targetPlayer)
			
			else
			outputChatBox("#D64541[Erro] #ffffffNão é possível ligar para este número no momento!", playerSource,255,255,255,true)
		end
	end
end
addEvent("callTargetInServer", true)
addEventHandler("callTargetInServer", getRootElement(), callTargetInServer)


function onClientCallAd(player, ad, ara, numberCall)
	local amout = math.ceil(ara)
	setElementData(player, "char:check", true) 
	local money = getElementData(player,"char:money")
	if(money<amout)then
		outputChatBox("Você não tem dinheiro suficiente para anunciar!", player, 255,0,0)
		return
	end
	setElementData(player,"char:money",getElementData(player,"char:money") - amout)
	for index , value in ipairs (getElementsByType("player")) do  
		if (getElementData(value, "loggedin")) then --and not getElementData(value, "char:check")) or player == value   then
			outputChatBox ("#66ff66 ANUNCIO: #ffcc00" ..ad.. " ((" ..getPlayerName(player):gsub("_", " ") .. "))",value,0, 233, 58,true)
			outputChatBox ("#66ff66 Número de telefone: #ffcc00" .. numberCall,value,0, 233, 58,true)
		end
	end
end
addEvent("onClientCallForAdData", true )
addEventHandler("onClientCallForAdData", getRootElement(), onClientCallAd)

addCommandHandler("toggleh",
	function(playerSource, cmd)
		if not ( getElementData(playerSource, "char:check")) then
			setElementData(playerSource, "char:check", true) 
			outputChatBox("Você desativou os anúncios.", playerSource, 255, 255, 255, true)
		elseif (getElementData(playerSource, "char:check")) then 
			setElementData(playerSource, "char:check", false) 
			outputChatBox("Você tem anúncios desbloqueados.",playerSource, 255, 255, 255, true)
		end
	end
)

local tempoSource = {}
local tempotargetPlayerSource = {}
function answerPhoneS(playerSource, targetPlayerSource, number)
	if tonumber(number) then
		if tonumber(number) == 1 then
			if playerSource then
				if targetPlayerSource then
				triggerClientEvent(playerSource, "answerPhone", playerSource, 1)
				triggerClientEvent(targetPlayerSource, "answerPhone", targetPlayerSource, 1)
				setElementData(playerSource, "inCallON", false)
				setElementData(targetPlayerSource, "inCallON", false)
				setElementData(playerSource, "inCall", false) 
				setElementData(playerSource, "inCall2", false)
				setElementData(playerSource, "inCallON", false)
				--setPlayerVoiceBroadcastTo(playerSource, root)
				setElementData(targetPlayerSource, "inCall", false) 
				setElementData(targetPlayerSource, "inCall2", false)
				setElementData(targetPlayerSource, "inCallON", false)
				setPlayerVoiceIgnoreFrom(playerSource, nil)
				setPlayerVoiceBroadcastTo(playerSource, nil)
				
				setPlayerVoiceIgnoreFrom(targetPlayerSource, nil)
				setPlayerVoiceBroadcastTo(targetPlayerSource, nil)
				
				removePhone(playerSource)
				removePhone(targetPlayerSource)
				
				setPedAnimation ( playerSource, "ped", "phone_out", 50, false, false, false, false)
				setPedAnimation ( targetPlayerSource, "ped", "phone_out", 50, false, false, false, false)
		
				end
			end
		end
		if tonumber(number) == 2 then
			if playerSource then
				if targetPlayerSource then
				
				triggerClientEvent(targetPlayerSource, "showMenu", targetPlayerSource, tonumber(getElementData(playerSource, "char:telefone")), 7, playerSource, tonumber(getElementData(targetPlayerSource, "char:telefone")))
				triggerClientEvent(playerSource, "showMenu", playerSource, tonumber(getElementData(targetPlayerSource, "char:telefone")), 7, targetPlayerSource, tonumber(getElementData(playerSource, "char:telefone")))

				triggerClientEvent(targetPlayerSource, "Emchamada", targetPlayerSource)
				triggerClientEvent(playerSource, "Emchamada", playerSource)


				setElementData(playerSource, "char:money", getElementData(playerSource, "char:money") - math.random(5, 10))
				setElementData(targetPlayerSource, "char:money", getElementData(targetPlayerSource, "char:money") - math.random(5, 10))
				setElementData(playerSource, "inCall", true) 
				setElementData(targetPlayerSource, "inCall", true) 
				setElementData(playerSource, "inCall2", true)
				setElementData(targetPlayerSource, "inCall2", true)
				setPlayerVoiceBroadcastTo( playerSource, targetPlayerSource )
				setPlayerVoiceBroadcastTo( targetPlayerSource, playerSource )
				
				ligando(playerSource)
				ligando(targetPlayerSource)
				end
			end
		end		
	end
end
addEvent("answerPhoneS", true)
addEventHandler("answerPhoneS", getRootElement(), answerPhoneS)





function criarGang ( thePlayer, teamName )
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 1 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não pode usar esta função no modo admin",thePlayer, 255, 194, 14, true) return end
		
		if exports.bgo_admin:isPlayerDuty(thePlayer) then
		outputChatBox ( "#F4A460[Frequência]#F08080 Policiais em serviço não utilizam está função!", thePlayer, 255, 255, 255, true ) 
		return
		end
		
		if getElementData(thePlayer,"grupo:Radio") then
		outputChatBox ( "#F4A460[Frequência]#F08080 Você está com a frequência do radio mutada! não pode utilizar esta função!", thePlayer, 255, 255, 255, true ) 
		return
		end

			if exports['bgo_items']:hasItemS(thePlayer, 16) then 
 

			if ( tonumber(teamName) ) then 		
            if ( getPlayerTeam ( thePlayer ) ~= false ) and ( countPlayersInTeam ( getPlayerTeam ( thePlayer ) ) == 1 ) then 
                destroyElement ( getPlayerTeam ( thePlayer ) ) 
            end 
			
            local newTeam = createTeam ( teamName ) 
            if ( newTeam ) then 
				setTeamColor ( newTeam, math.random ( 0, 255 ), math.random ( 0, 255 ), math.random ( 0, 255 ) ) 
                setPlayerTeam ( thePlayer, newTeam ) 
                outputChatBox ( "#F4A460[Frequência]#F08080 Você entrou na Frequência ".. tonumber(teamName) .." ", thePlayer, 255, 255, 255, true ) 
				else
				setPlayerTeam(thePlayer, getTeamFromName ( teamName ))
				outputChatBox ( "#F4A460[Frequência]#F08080 Você entrou na Frequência ".. tonumber(teamName) .." ", thePlayer, 255, 255, 255, true ) 
            end 
		end 
	else
	outputChatBox ( "#F4A460[GANG]#F08080 Você precisa ter um celular para efetuar a ligação!", thePlayer, 255, 255, 255, true ) 
	end
end 




 function painel(thePlayer)
	if getElementData(thePlayer, "loggedin") == false then return end
	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
		triggerClientEvent(thePlayer, "CelularOFF", thePlayer)
	return
   	end

	if getElementData(thePlayer, "adminjail") == 1 then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você está preso e não pode abrir o celular!!", thePlayer, 255, 255, 255, true)
		triggerClientEvent(thePlayer, "CelularOFF", thePlayer)
	return
   	end

	if exports.bgo_items:hasItemS(thePlayer, 16) then 
		if tonumber(getElementData(thePlayer,"char:telefone") or 0) > 0 then
			triggerClientEvent(thePlayer, "Celular", thePlayer, getElementData(thePlayer,"char:telefone"))
			else
			outputChatBox("#7cc576Você não tem um numero de telefone registrado para registrar um numero digite /reconnect e reloga na cidade!",thePlayer, 255, 255, 255, true)
		end
		else
		outputChatBox("#7cc576Você não tem celular, precisa comprar em alguma loja!",thePlayer,  255, 255, 255, true)
end
end

function restart()
	for index, player in ipairs(getElementsByType("player")) do
		bindKey(player, "b", "down", painel) -- Bind Para Abrir/Fechar Painel
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)

function entrar()
	bindKey(source, "b", "down", painel) -- Bind Para Abrir/Fechar Painel
end
addEventHandler("onPlayerJoin", getRootElement(), entrar)

function fechar(player)
	for index, player in ipairs(getElementsByType("player")) do
		unbindKey(player, "b", "down", painel) -- Bind Para Abrir/Fechar Painel
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), fechar)











local BLIP_VISIBLE_DISTANCE = 750

local blips2 = {}
local blips3 = {}
local blips4 = {}

local BLIP_VISIBLE_DISTANCE = 750
local blips = {}

player_blips = {} 


local medicoCall = {}
local medicoCallCount = 0
addEvent( "SendMsgToTeammedic", true )
addEventHandler( "SendMsgToTeammedic", root,
function (thePlayer, menCopom)
	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
	return
   	end

	local pX,pY,pZ = getElementPosition(thePlayer)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= thePlayer then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", thePlayer, 255, 255, 255, true)
				return
			end
		end
	end
end


	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)

        --if (medicoCallCount > 0) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff já está uma chamada em andamento, Por favor aguarde e tente novamente.", thePlayer, 255, 255, 255, true) return end
		if getElementData(thePlayer, "call:medico") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", thePlayer, 255, 255, 255, true) return end

		outputChatBox("#bebebeVocê chamou o medico, aguarde.", thePlayer, 255, 255, 255, true)
		exports.bgo_hud:dm(" "..getPlayerName(thePlayer).." Você chamou o médico, aguarde.", thePlayer, 255, 200, 0)
		medicoCallCount = medicoCallCount + 1
		medicoCall[medicoCallCount] = thePlayer
		setElementData(thePlayer, "call:medico", medicoCallCount)

		setTimer ( setElementData, 60000, 1, thePlayer, "call:medico", false)
		tirarchamadomedicoCall = setTimer(function()
			medicoCall[medicoCallCount] = nil
			if medicoCallCount > 0 then
		     	medicoCallCount = medicoCallCount - 1
			end
		end, 10000, 1 )




		local x, y, z = getElementPosition(thePlayer)
		setElementData(thePlayer, "call:medicoposx", x)
		setElementData(thePlayer, "call:medicoposy", y)
		setElementData(thePlayer, "call:medicoposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 4  then
			     --triggerClientEvent(player, "chamada:dx", player, ""..getPlayerName(thePlayer)..", "..(menCopom).." ")
				 triggerClientEvent(player, "chamada:dx", player, ""..getPlayerName(thePlayer)..", "..(menCopom).." ")
                  bindKey(player, "e","down", attChamada)
				  idChamada[player] = medicoCallCount
			  end
		end
end )


local blipmedico = { }
function aceitarmedico(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 4  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if medicoCall[acceptID] then
				exports.bgo_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.bgo_hud:dm("O medico aceitou sua chamada e está a caminho", medicoCall[acceptID], 255, 200, 0)
				
				
				
				if isElement(blipmedico[thePlayer]) then
				destroyElement(blipmedico[thePlayer])
				end
				
				blipmedico[thePlayer] = createBlipAttachedTo (thePlayer, 21)
				setElementData(blipmedico[thePlayer],"blip >> blipOnScreen", true)
				setElementVisibleTo ( blipmedico[thePlayer], root, false )
				setElementVisibleTo ( blipmedico[thePlayer], medicoCall[acceptID], true )
				
				
				triggerClientEvent(thePlayer, "abrircelular", thePlayer)
				triggerClientEvent( medicoCall[acceptID], "abrircelular",  medicoCall[acceptID])
				triggerEvent("answerPhoneS",  medicoCall[acceptID],  medicoCall[acceptID], thePlayer, 2)
				
				source = blipmedico[thePlayer]
				setTimer(function()
				if isElement(blipmedico[thePlayer]) then
				destroyElement(blipmedico[thePlayer])
				end
				
				end,120000,1,blipmedico[thePlayer])
				
				
				if isTimer(tirarchamadomedicoCall) then
				killTimer(tirarchamadomedicoCall)
				end
				local x, y, z = getElementData(medicoCall[acceptID], "call:medicoposx"), getElementData(medicoCall[acceptID], "call:medicoposy"), getElementData(medicoCall[acceptID], "call:medicoposz")
				triggerClientEvent(thePlayer, "createMedicoMarker", thePlayer, thePlayer, acceptID, medicoCall[acceptID], x, y, z)
				medicoCall[acceptID] = nil
								exports.Script_futeis:setGPS(thePlayer, "Coordenada", x, y, z)
			  else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("ac", aceitarmedico)



local msCall = {}
local msCount = 0
addEvent( "SendMsgToTeamPolicia", true )
addEventHandler( "SendMsgToTeamPolicia", root,
function (thePlayer, menCopom)
	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
	return
   	end
	local pX,pY,pZ = getElementPosition(thePlayer)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= thePlayer then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", thePlayer, 255, 255, 255, true)
				return
			end
		end
	end
end

	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)

        --if (msCount > 0) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff já está uma chamada em andamento, Por favor aguarde e tente novamente.", thePlayer, 255, 255, 255, true) return end
		if getElementData(thePlayer, "call:policia") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", thePlayer, 255, 255, 255, true) return end
		msCount = msCount + 1
		msCall[msCount] = thePlayer
		setElementData(thePlayer, "call:policia", msCount)

		outputChatBox("#bebebeVocê chamou a policia, aguarde.", thePlayer, 255, 255, 255, true)
		exports.bgo_hud:dm(" "..getPlayerName(thePlayer).." Você chamou a policia, aguarde.", thePlayer, 255, 200, 0)

		setTimer ( setElementData, 60000, 1, thePlayer, "call:policia", false)
		tirarchamadomsCount = setTimer(function()
		msCall[msCount] = nil
			if msCount > 0 then
		     	msCount = msCount - 1
			end
		end, 10000, 1 )


		local x, y, z = getElementPosition(thePlayer)
		setElementData(thePlayer, "call:policiaposx", x)
		setElementData(thePlayer, "call:policiaposy", y)
		setElementData(thePlayer, "call:policiaposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			--if getElementData(player, "char:dutyfaction") == 17 or getElementData(player, "char:dutyfaction") == 6 or getElementData(player, "char:dutyfaction") == 24 or getElementData(player, "char:dutyfaction") == 19  or getElementData(player, "char:dutyfaction") == 2 or getElementData(player, "char:dutyfaction") == 5 or getElementData(player, "char:dutyfaction") == 19 or getElementData(player, "char:dutyfaction") == 16 or getElementData(player, "char:dutyfaction") == 11 or  getElementData(player, "char:dutyfaction") == 20 or getElementData(player, "char:dutyfaction") == 22  then



					if exports.bgo_admin:isPlayerDuty(player) then

				triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer), (menCopom))
				--triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer).." | "..(menCopom))
				 bindKey(player, "e","down", attChamada)
				 idChamada[player] = msCount
			  end
		end
end )


local blipPolicia = { }
function aceitarpolicia(thePlayer, commandName, acceptID)
	--if getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 24 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22  then
			if exports.bgo_admin:isPlayerDuty(thePlayer) then


			if (acceptID) then
			local acceptID = tonumber(acceptID)
			if msCall[acceptID] then
				exports.bgo_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.bgo_hud:dm("A Policia aceitou sua chamada e está a caminho", msCall[acceptID], 255, 200, 0)
				
				
				
				
				triggerClientEvent(thePlayer, "abrircelular", thePlayer)
				triggerClientEvent( msCall[acceptID], "abrircelular",  msCall[acceptID])
				triggerEvent("answerPhoneS",  msCall[acceptID],  msCall[acceptID], thePlayer, 2)
				



				if isElement(blipPolicia[thePlayer]) then
				destroyElement(blipPolicia[thePlayer])
				end
				
				blipPolicia[thePlayer] = createBlipAttachedTo (thePlayer, 30)
				
				setElementData(blipPolicia[thePlayer],"blip >> blipOnScreen", true)
				setElementVisibleTo ( blipPolicia[thePlayer], root, false )
				setElementVisibleTo ( blipPolicia[thePlayer], msCall[acceptID], true )
				
				source = blipPolicia[thePlayer]
				setTimer(function()
				if isElement(blipPolicia[thePlayer]) then
				destroyElement(blipPolicia[thePlayer])
				end
				
				end,120000,1,blipPolicia[thePlayer])
				
				
				
				

				if isTimer(tirarchamadomsCount) then
						killTimer(tirarchamadomsCount)
				end

				local x, y, z = getElementData(msCall[acceptID], "call:policiaposx"), getElementData(msCall[acceptID], "call:policiaposy"), getElementData(msCall[acceptID], "call:policiaposz")

				exports.Script_futeis:setGPS(thePlayer, "Coordenada", x, y, z)

				triggerClientEvent(thePlayer, "createPoliciaMarker", thePlayer, thePlayer, acceptID, msCall[acceptID], x, y, z)
				msCall[acceptID] = nil
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitarpolicia)

idChamada = {}
function attChamada (player)
		if idChamada[player] then
     if exports.bgo_admin:isPlayerDuty(player) then
	     executeCommandHandler("ac", player,  idChamada[player])
		 unbindKey(player, "e", "down", attChamada)
	     else
	     if getElementData(player, "char:dutyfaction") == 3  then
	         executeCommandHandler("ac", player, idChamada[player])
			 unbindKey(player, "e", "down", attChamada)
	         else
	         if getElementData(player, "char:dutyfaction") == 12  then
	             executeCommandHandler("ac", player,  idChamada[player])
				 unbindKey(player, "e", "down", attChamada)
		         else
	             if getElementData(player, "char:dutyfaction") == 4  then
	                 executeCommandHandler("ac", player,  idChamada[player])
					 unbindKey(player, "e", "down", attChamada)
		             else
	                 if getElementData(player, "char:dutyfaction") == 1  then
	                     executeCommandHandler("ac", player,  idChamada[player])
						 unbindKey(player, "e", "down", attChamada)
		                 else
	                     if getElementData(player, "char:adminduty") == 1  then
	                         executeCommandHandler("ac", player, idChamada[player])
							 unbindKey(player, "e", "down", attChamada)
						 end
					 end
				 end
			 end
		 end
	 end
end
end

local mecanicoCall = {}
mecCount = 0
addEvent( "SendMsgToTeamMecanico", true )
addEventHandler( "SendMsgToTeamMecanico", root,
function (thePlayer, menCopom)
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)
	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
	return
	   end
	   
	local pX,pY,pZ = getElementPosition(thePlayer)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= thePlayer then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", thePlayer, 255, 255, 255, true)
				return
			end
		end
	end
end
    mecCount = tonumber(mecCount)
    --if (mecCount > 0) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff("..mecCount..") já está uma chamada em andamento, Por favor aguarde e tente novamente.", thePlayer, 255, 255, 255, true) return end
	if getElementData(thePlayer, "call:mecanico") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", thePlayer, 255, 255, 255, true) return end
		outputChatBox("#bebebeVocê chamou o mecanico, aguarde.", thePlayer, 255, 255, 255, true)
		exports.bgo_hud:dm(" "..getPlayerName(thePlayer).." Você chamou o mecanico, aguarde.", thePlayer, 255, 200, 0)
		mecCount = mecCount + 1
		mecanicoCall[mecCount] = thePlayer
		setElementData(thePlayer, "call:mecanico", mecCount)

        setTimer(function ()
			if mecCount > 0 then
		     	mecCount = mecCount - 1
			end
		end, 10000, 1)
		setTimer ( setElementData, 60000, 1, thePlayer, "call:mecanico", false)

		tirarchamadomecCount = setTimer(function()
			mecanicoCall[mecCount] = nil
		end, 10000, 1 )



		local x, y, z = getElementPosition(thePlayer)
		setElementData(thePlayer, "call:mecanicoposx", x)
		setElementData(thePlayer, "call:mecanicoposy", y)
		setElementData(thePlayer, "call:mecanicoposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 3  then
			
			local x, y, z = getElementPosition(thePlayer)
			local tx, ty, tz = getElementPosition(player)
			local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)	
			if distance <= 2100 then

			--triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer).." | "..(menCopom or "Distancia: "..(math.floor(distance) or "Desconhecida").." "))
			triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer), (menCopom))
			bindKey(player, "e","down", attChamada)
			idChamada[player] = mecCount
			end
			
			  end
		end
end )

local blipMec = { }
function aceitarmecanico(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 3  then

		if getElementData(thePlayer, "emcall:mecanico") == true then
		exports.bgo_hud:dm("você ja tem uma chamada em andamento!", thePlayer, 255, 200, 0)
		return 
		end



		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if mecanicoCall[acceptID] then
				exports.bgo_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.bgo_hud:dm("O mecanico aceitou sua chamada e está a caminho", mecanicoCall[acceptID], 255, 200, 0)
				
				if isElement(blipMec[thePlayer]) then
				destroyElement(blipMec[thePlayer])
				end
				
				blipMec[thePlayer] = createBlipAttachedTo (thePlayer, 27)
				setElementData(blipMec[thePlayer],"blip >> blipOnScreen", true)
				setElementVisibleTo ( blipMec[thePlayer], root, false )
				setElementVisibleTo ( blipMec[thePlayer], mecanicoCall[acceptID], true )

				triggerClientEvent(thePlayer, "abrircelular", thePlayer)
				triggerClientEvent( mecanicoCall[acceptID], "abrircelular",  mecanicoCall[acceptID])
				triggerEvent("answerPhoneS",  mecanicoCall[acceptID],  mecanicoCall[acceptID], thePlayer, 2)


				source = blipMec[thePlayer]
				setTimer(function()
				if isElement(blipMec[thePlayer]) then
				destroyElement(blipMec[thePlayer])
				end
				
				end,120000,1,blipMec[thePlayer])
				

					if isTimer(tirarchamadomecCount) then
						killTimer(tirarchamadomecCount)
					end

					setElementData(thePlayer, "emcall:mecanico", true)
					
					setTimer ( setElementData, 60000, 1, thePlayer, "emcall:mecanico", false)

				local x, y, z = getElementData(mecanicoCall[acceptID], "call:mecanicoposx"), getElementData(mecanicoCall[acceptID], "call:mecanicoposy"), getElementData(mecanicoCall[acceptID], "call:mecanicoposz")
exports.Script_futeis:setGPS(thePlayer, "Coordenada", x, y, z)
				triggerClientEvent(thePlayer, "createMecanicoMarker", thePlayer, thePlayer, acceptID, mecanicoCall[acceptID], x, y, z)
				mecanicoCall[acceptID] = nil
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitarmecanico)



local taxiCall = {}
local taxiCount = 0
addEvent( "SendMsgToTeamtaxi", true )
addEventHandler( "SendMsgToTeamtaxi", root,
function ( thePlayer, menCopom )
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)
	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
	return
   	end

	local pX,pY,pZ = getElementPosition(thePlayer)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= thePlayer then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", thePlayer, 255, 255, 255, true)
				return
			end
		end
	end
end

    --if (taxiCount > 0) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff já está uma chamada em andamento, Por favor aguarde e tente novamente.", thePlayer, 255, 255, 255, true) return end
	if getElementData(thePlayer, "call:taxi") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", thePlayer, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o taxi, aguarde.", thePlayer, 255, 255, 255, true)
		exports.bgo_hud:dm(" "..getPlayerName(thePlayer).." Você chamou o taxi, aguarde.", thePlayer, 255, 200, 0)

--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[CHAMADA]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." Chamou taxi`")

		taxiCount = taxiCount + 1
		taxiCall[taxiCount] = thePlayer
		setElementData(thePlayer, "call:taxi", taxiCount)

		setTimer ( setElementData, 60000, 1, thePlayer, "call:taxi", false)
		tirarchamadotaxiCall = setTimer(function()
			taxiCall[taxiCount] = nil
			if taxiCount > 0 then
		     	taxiCount = taxiCount - 1
			end
		end, 10000, 1 )

		local x, y, z = getElementPosition(thePlayer)
		setElementData(thePlayer, "call:taxiposx", x)
		setElementData(thePlayer, "call:taxiposy", y)
		setElementData(thePlayer, "call:taxiposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 12  then
			---	outputChatBox("#bebebe"..getPlayerName(thePlayer).." chamou o taxi utilize /ac " .. taxiCount .. " para aceitar o pedido", player, 255, 255, 255, true)
			---	displayServerMessage(player, ""..getPlayerName(thePlayer).." chamou  o taxi utilize /ac " .. taxiCount .. " para aceitar o pedido", "warning")
			--triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer).." | "..(menCopom or "Chamada sem descrição"))
			triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer), (menCopom))
			bindKey(player, "e","down", attChamada)
			idChamada[player] = taxiCount
			  end
		end
end )




local bliptaxi = { }
function aceitartaxi(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 12  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if taxiCall[acceptID] then
				exports.bgo_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.bgo_hud:dm("O taxi aceitou sua chamada e está a caminho", taxiCall[acceptID], 255, 200, 0)
				
				if isElement(bliptaxi[thePlayer]) then
				destroyElement(bliptaxi[thePlayer])
				end
				
				bliptaxi[thePlayer] = createBlipAttachedTo (thePlayer, 19)
				setElementData(bliptaxi[thePlayer],"blip >> blipOnScreen", true)
				setElementVisibleTo ( bliptaxi[thePlayer], root, false )
				setElementVisibleTo ( bliptaxi[thePlayer], taxiCall[acceptID], true )
				
				triggerClientEvent(thePlayer, "abrircelular", thePlayer)
				triggerClientEvent( taxiCall[acceptID], "abrircelular",  taxiCall[acceptID])
				triggerEvent("answerPhoneS",  taxiCall[acceptID],  taxiCall[acceptID], thePlayer, 2)
				
				source = bliptaxi[thePlayer]
				setTimer(function()
				if isElement(bliptaxi[thePlayer]) then
				destroyElement(bliptaxi[thePlayer])
				end
				
				end,120000,1,bliptaxi[thePlayer])

				if isTimer(tirarchamadotaxiCall) then
						killTimer(tirarchamadotaxiCall)
				end

				local x, y, z = getElementData(taxiCall[acceptID], "call:taxiposx"), getElementData(taxiCall[acceptID], "call:taxiposy"), getElementData(taxiCall[acceptID], "call:taxiposz")
				triggerClientEvent(thePlayer, "createtaxiMarker", thePlayer, thePlayer, acceptID, taxiCall[acceptID], x, y, z)
				taxiCall[acceptID] = nil
				exports.Script_futeis:setGPS(thePlayer, "Coordenada", x, y, z)
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitartaxi)




local detranCall = {}
local detranCount = 0
addEvent( "SendMsgToTeamDetran", true )
addEventHandler( "SendMsgToTeamDetran", root,
function (thePlayer, menCopom)
	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
	return
   	end

	local pX,pY,pZ = getElementPosition(thePlayer)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= thePlayer then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", thePlayer, 255, 255, 255, true)
				return
			end
		end
	end
end


   -- if (detranCount > 0) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff já está uma chamada em andamento, Por favor aguarde e tente novamente.", thePlayer, 255, 255, 255, true) return end
	if getElementData(thePlayer, "call:detran") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", thePlayer, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o detran, aguarde.", thePlayer, 255, 255, 255, true)
		exports.bgo_hud:dm(" "..getPlayerName(thePlayer).." Você chamou o detran, aguarde.", thePlayer, 255, 200, 0)

--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[CHAMADA]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." Chamou detran`")
		detranCount = detranCount + 1
		detranCall[detranCount] = thePlayer
		setElementData(thePlayer, "call:detran", detranCount)


		setTimer ( setElementData, 60000, 1, thePlayer, "call:detran", false)
		tirarchamadodetranCall = setTimer(function()
			detranCall[detranCount] = nil
			if taxiCount > 0 then
		     	detranCount = detranCount - 1
			end
		end, 10000, 1 )


		local x, y, z = getElementPosition(thePlayer)
		setElementData(thePlayer, "call:detranposx", x)
		setElementData(thePlayer, "call:detranposy", y)
		setElementData(thePlayer, "call:detranposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:dutyfaction") == 1  then
			--	outputChatBox("#bebebe"..getPlayerName(thePlayer).." chamou o detran utilize /ac " .. detranCount .. " para aceitar o pedido", player, 255, 255, 255, true)
			--	displayServerMessage(player, ""..getPlayerName(thePlayer).." chamou  o detran utilize /ac " .. detranCount .. " para aceitar o pedido", "warning")
			--triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer).." | "..(menCopom or "Chamada sem descrição"))
			triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer), (menCopom))
			     bindKey(player, "e","down", attChamada)
				 idChamada[player] = detranCount
			  end
		end
end )
local blipdetran = { }
function aceitardetran(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:dutyfaction") == 1  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if detranCall[acceptID] then
				exports.bgo_hud:dm("Você aceitou o chamado " .. acceptID .. " desloque até o local.", thePlayer, 255, 200, 0)
				exports.bgo_hud:dm("O detran aceitou sua chamada e está a caminho", detranCall[acceptID], 255, 200, 0)

				if isTimer(tirarchamadodetranCall) then
						killTimer(tirarchamadodetranCall)
				end

				if isElement(blipdetran[thePlayer]) then
				destroyElement(blipdetran[thePlayer])
				end
				blipdetran[thePlayer] = createBlipAttachedTo (thePlayer, 24)
				setElementData(blipdetran[thePlayer],"blip >> blipOnScreen", true)
				setElementVisibleTo ( blipdetran[thePlayer], root, false )
				setElementVisibleTo ( blipdetran[thePlayer], detranCall[acceptID], true )
				
				
				triggerClientEvent(thePlayer, "abrircelular", thePlayer)
				triggerClientEvent( detranCall[acceptID], "abrircelular",  detranCall[acceptID])
				triggerEvent("answerPhoneS",  detranCall[acceptID],  detranCall[acceptID], thePlayer, 2)
				
				source = blipdetran[thePlayer]
				setTimer(function()
				if isElement(blipdetran[thePlayer]) then
				destroyElement(blipdetran[thePlayer])
				end
				end,120000,1,blipdetran[thePlayer])
				
				

				local x, y, z = getElementData(detranCall[acceptID], "call:detranposx"), getElementData(detranCall[acceptID], "call:detranposy"), getElementData(detranCall[acceptID], "call:detranposz")
				triggerClientEvent(thePlayer, "createdetranMarker", thePlayer, thePlayer, acceptID, detranCall[acceptID], x, y, z)

				detranCall[acceptID] = nil

				exports.Script_futeis:setGPS(thePlayer, "Coordenada", x, y, z)
				chamadodetranCount = setTimer(function()
					detranCount = detranCount - 1
				end, 30000, 1 )


			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitardetran)


local staffCall = {}
local staffCount = 0
addEvent( "SendMsgToTeamstaff", true )
addEventHandler( "SendMsgToTeamstaff", root,
function ( thePlayer, menCopom )
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 10000, 1)

	if ( isPedDead ( thePlayer ) ) then
		outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Morto não fala e não se mexe!", thePlayer, 255, 255, 255, true)
	return
   	end

	local pX,pY,pZ = getElementPosition(thePlayer)
	for k,v in ipairs(getElementsByType("player")) do
		vX,vY,vZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
		if dist <= 5 then
			if v ~= thePlayer then
			if getPedWeapon(v) > 0 then
				outputChatBox("#D24D57[btc~Items] #ffffffAlguem armado está proximo de você então não pode fazer chamada!", thePlayer, 255, 255, 255, true)
				return
			end
		end
	end
end

    --if tonumber(staffCount > 0) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff("..staffCount..") já está uma chamada em andamento, Por favor aguarde e tente novamente.", thePlayer, 255, 255, 255, true)
	--return 
	--end
	if getElementData(thePlayer, "call:staff") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Você já tem uma chamada em andamento aguarde 1 minuto para fazer novamente.", thePlayer, 255, 255, 255, true) return end


		outputChatBox("#bebebeVocê chamou o staff, aguarde.", thePlayer, 255, 255, 255, true)
		exports.bgo_hud:dm(" "..getPlayerName(thePlayer).." Você chamou o staff, aguarde.", thePlayer, 255, 200, 0)

--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[CHAMADA]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." Chamou staff`")
		staffCount = staffCount + 1
		staffCall[staffCount] = thePlayer
		setElementData(thePlayer, "call:staff", staffCount)


		setTimer ( setElementData, 60000, 1, thePlayer, "call:staff", nil)
		
		--removeElementData(thePlayer, "call:staff")
		tirarchamadostaffCall = setTimer(function()
			staffCall[staffCount] = nil
		    if staffCount > 0 then
		    	 staffCount = staffCount - 1
	        end
		end, 10000, 1 )


		local x, y, z = getElementPosition(thePlayer)
		setElementData(thePlayer, "call:staffposx", x)
		setElementData(thePlayer, "call:staffposy", y)
		setElementData(thePlayer, "call:staffposz", z)
		for theKey,player in ipairs (getElementsByType("player")) do
			if getElementData(player, "char:adminduty") == 1  then
			--triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer).." | "..((menCopom or "Chamada sem descrição")))
			triggerClientEvent(player, "chamada:dx", player, getPlayerName(thePlayer), (menCopom))
			    bindKey(player, "e","down", attChamada)
				idChamada[player] = staffCount
			  end
		end
end )

ChamadasS = {}



function aceitarstaff(thePlayer, commandName, acceptID)
	if getElementData(thePlayer, "char:adminduty") == 1  then
		if (acceptID) then
			local acceptID = tonumber(acceptID)
			if staffCall[acceptID] then
				exports.bgo_hud:dm("Você aceitou o chamado " .. acceptID .. "", thePlayer, 255, 200, 0)
				exports.bgo_hud:dm("O staff "..getPlayerName(thePlayer).." aceitou sua chamada", staffCall[acceptID], 255, 200, 0)

				--if isTimer(chamadostaffCall) then
				--	killTimer(chamadostaffCall)
				--end
				if isTimer(tirarchamadostaffCall) then
						killTimer(tirarchamadostaffCall)
				end

				for theKey,player in ipairs (getElementsByType("player")) do
					if getElementData(player, "char:adminduty") == 1  then
						outputChatBox(" ", player, 255, 255, 255, true)
						outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeStaff "..getPlayerName(thePlayer).." aceitou o chamado " .. staffCount .. "", player, 255, 255, 255, true)
						outputChatBox(" ", player, 255, 255, 255, true)
						--setChamada (thePlayer)
					  end
				end

				setChamada (thePlayer)

				local x, y, z = getElementData(staffCall[acceptID], "call:staffposx"), getElementData(staffCall[acceptID], "call:staffposy"), getElementData(staffCall[acceptID], "call:staffposz")
				setElementPosition(thePlayer, x, y, z)
				--setElementData(thePlayer, "call:staff", nil)
				removeElementData(thePlayer, "call:staff")
				--triggerClientEvent(thePlayer, "createstaffMarker", thePlayer, thePlayer, acceptID, staffCall[acceptID], x, y, z)
				staffCall[acceptID] = nil




				--staffCount = staffCount - 1
			else
				outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff Não existe essa chamada ou a chamada já foi aceita.", thePlayer, 255, 255, 255, true)
			end
		end
	
	end
end
addCommandHandler("ac", aceitarstaff)



for theKey,player in ipairs (getElementsByType("player")) do
	setElementData(player, "call:staff", nil)
	setElementData(player, "call:policia", nil)
	setElementData(player, "call:mecanico", nil)
	setElementData(player, "call:medico", nil)
	setElementData(player, "call:prf", nil)
	setElementData(player, "call:taxi", nil)
	setElementData(player, "call:detran", nil)
	 if getElementData(player, "emcall:mecanico") == true then
	     setElementData(player, "emcall:mecanico", false)
		 else
		 setElementData(player, "emcall:mecanico", false)
	 end
end



setTimer(function()
	if tonumber(staffCount) > 0 then
	staffCount = staffCount - 1
	end
	if tonumber(detranCount) > 0 then
		detranCount = detranCount - 1
	end
	if tonumber(taxiCount) > 0 then
		taxiCount = taxiCount - 1
	end
	if tonumber(mecCount) > 0 then
		mecCount = mecCount - 1
	end
	if tonumber(msCount) > 0 then
		msCount = msCount - 1
	end
	if tonumber(medicoCallCount) > 0 then
		medicoCallCount = medicoCallCount - 1
	end
end, 60000, 0 )



function setChamada (thePlayer)
local serial = getElementData(thePlayer, "char:id") --getPlayerSerial(thePlayer)
     if serial then
	     if not ChamadasS[serial] then
		     ChamadasS[serial] = 0
		 end
		 if ChamadasS[serial] then
		     ChamadasS[serial] = ChamadasS[serial] + 1
		 end
	 end
end


addCommandHandler("chamada",
	function(playerSource, cmd, player)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then
			if player then
				local targetPlayer,targetPlayerName = exports["bgo_core"]:findPlayer(playerSource, player)
				if targetPlayer then

					local serial = getElementData(targetPlayer, "char:id")  --getPlayerSerial(thePlayer)
					if ChamadasS[serial] then
						outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeO STAFF #dc143c"..getPlayerName(targetPlayer).." #bebebetem #dc143c"..ChamadasS[serial].." #bebebechamada acumuladas", playerSource, 255, 255, 255, true)
						else
						outputChatBox("#dc143c[BGOMTA - CHAMADA] #bebebeO STAFF #dc143c"..getPlayerName(targetPlayer).." #bebebenão tem chamada atendidas.", playerSource, 255, 255, 255, true)
					--end
					end

					
				else
					outputChatBox("Não existe tal jogador.", playerSource, 255, 255, 255, true)
				end
			else
				outputChatBox("#7cc576use:#ffffff /"..cmd.." [nome / ID] ", playerSource,166,196,103,true)			
			end
		end
	end
)





local objetolanche = { }
local objetosom = { }
local objetocaixa = { }
local objetoflor = { }
local objetoguardachuva = { }

addEvent( "objetomaosom", true )
addEventHandler( "objetomaosom", root,
function (thePlayer, object)

		if isElement(objetosom[thePlayer]) then


			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			setElementData(thePlayer,"Animando", false)
	--destroyElement(objetosom[thePlayer])
	outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else

			
			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			setElementData(thePlayer,"Animando", true)
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		objetosom[thePlayer] = createObject(2226,0,0,0) 
		setElementDimension(objetosom[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetosom[thePlayer], getElementInterior(thePlayer))
	exports.bone_attach:attachElementToBone(objetosom[thePlayer],thePlayer,12,0,0,0.4,0,180,0) 
	end
end
)


addEvent( "objetomaocaixa", true )
addEventHandler( "objetomaocaixa", root,
function (thePlayer, object)
		if isElement(objetocaixa[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end

			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			setElementData(thePlayer,"Animando", false)
		--destroyElement(objetocaixa[thePlayer])
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else
		

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		local rot = getElementRotation(thePlayer)
		objetocaixa[thePlayer] = createObject(3014, 0, 0, 0)

		setElementDimension(objetocaixa[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetocaixa[thePlayer], getElementInterior(thePlayer))

setElementData(thePlayer,"Animando", true)
		setObjectScale(objetocaixa[thePlayer], 0.9)		
		exports.bone_attach:attachElementToBone(objetocaixa[thePlayer],thePlayer,3,-0.1, 0.45, 0.19, 0, rot, 0) 
		exports.bgo_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)
	end
end
)


addEvent( "objetomaoflor", true )
addEventHandler( "objetomaoflor", root,
function (thePlayer, object)
		if isElement(objetoflor[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			setElementData(thePlayer,"Animando", false)
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			
			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		objetoflor[thePlayer] = createObject(325,0,0,0) 
setElementData(thePlayer,"Animando", true)
		setElementDimension(objetoflor[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetoflor[thePlayer], getElementInterior(thePlayer))
		exports.bone_attach:attachElementToBone(objetoflor[thePlayer],thePlayer,12,-0.02,0,0,0,-90,0) 
	end
end
)


addEvent( "objetgchuva", true )
addEventHandler( "objetgchuva", root,
function (thePlayer, object)
		if isElement(objetoguardachuva[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end
			
			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			setElementData(thePlayer,"Animando", false)
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else

			
			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		objetoguardachuva[thePlayer] = createObject(642,0,0,0) 
		setElementDimension(objetoguardachuva[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetoguardachuva[thePlayer], getElementInterior(thePlayer))
		setObjectScale(objetoguardachuva[thePlayer], 0.5)	

		exports.bone_attach:attachElementToBone(objetoguardachuva[thePlayer],thePlayer,12,-0.5,-0.21,-0.1,120,-60,0) 


		setPedAnimation ( thePlayer, "GANGS", "smkcig_prtl_f", -0, true, false, false )
		setTimer ( setPedAnimationProgress, 100, 1, thePlayer, "smkcig_prtl_f", 1.9)
		setTimer ( setPedAnimationSpeed, 100, 1, thePlayer, "smkcig_prtl_f", 0)
setElementData(thePlayer,"Animando", true)
		--exports.bgo_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)

	end
end
)



addEvent( "objetomaolanche", true )
addEventHandler( "objetomaolanche", root,
function (thePlayer, object)
		if isElement(objetolanche[thePlayer]) then

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end

			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			setElementData(thePlayer,"Animando", false)
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê tirou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		else
		

			if isElement(objetoguardachuva[thePlayer]) then
				destroyElement(objetoguardachuva[thePlayer])
			end
			
			if isElement(objetosom[thePlayer]) then
				destroyElement(objetosom[thePlayer])
			end

			if isElement(objetoflor[thePlayer]) then
				destroyElement(objetoflor[thePlayer])
			end

			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end

			if isElement(objetolanche[thePlayer]) then
				destroyElement(objetolanche[thePlayer])
			end
			
		outputChatBox("#dc143c[BGOMTA - OBJETOS] #bebebevocê pegou o objeto #dc143c"..object.."", thePlayer, 255, 255, 255, true)
		local rot = getElementRotation(thePlayer)
		objetolanche[thePlayer] = createObject(1341, 0, 0, 0)

		setElementDimension(objetolanche[thePlayer], getElementDimension(thePlayer))
		setElementInterior(objetolanche[thePlayer], getElementInterior(thePlayer))

		setElementCollisionsEnabled(objetolanche[thePlayer], false)
		setObjectScale(objetolanche[thePlayer], 0.9)		
		--exports.bone_attach:attachElementToBone(objetolanche[thePlayer],thePlayer,3,-0.18, 1, 0.19, 0, rot, 0) 
		
		attachElements ( objetolanche[thePlayer], thePlayer, -0.2, 1.1, -0.1 )
		
		setElementData(thePlayer,"Animando", true)
		exports.bgo_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)
	end
end
)





addEventHandler("onPlayerQuit", root, function()
	if isElement(objetosom[source]) then
		destroyElement(objetosom[source])
	end

	if isElement(objetoflor[source]) then
		destroyElement(objetoflor[source])
	end


	if isElement(objetocaixa[source]) then
		destroyElement(objetocaixa[source])
	end


	if isElement(objetoguardachuva[source]) then
		destroyElement(objetoguardachuva[source])
	end
	
	if isElement(objetosom[source]) then
		destroyElement(objetosom[source])
	end

	if isElement(objetoflor[source]) then
		destroyElement(objetoflor[source])
	end
	
	if isElement(objetolanche[source]) then
		destroyElement(objetolanche[source])
	end
			

end)




function removerobj (thePlayer, commandName)


	if isElement(objetosom[thePlayer]) then
		destroyElement(objetosom[thePlayer])
		
		setElementData(thePlayer,"Animando", false)
	end

	if isElement(objetoflor[thePlayer]) then
		destroyElement(objetoflor[thePlayer])
		setElementData(thePlayer,"Animando", false)
	end


	if isElement(objetocaixa[thePlayer]) then
		destroyElement(objetocaixa[thePlayer])
		setElementData(thePlayer,"Animando", false)
	end


	if isElement(objetoguardachuva[thePlayer]) then
		destroyElement(objetoguardachuva[thePlayer])
		setElementData(thePlayer,"Animando", false)
	end
	
	if isElement(objetosom[thePlayer]) then
		destroyElement(objetosom[thePlayer])
		setElementData(thePlayer,"Animando", false)
	end

	if isElement(objetoflor[thePlayer]) then
		destroyElement(objetoflor[thePlayer])
		setElementData(thePlayer,"Animando", false)
	end

	if isElement(objetolanche[thePlayer]) then
		destroyElement(objetolanche[thePlayer])
		setElementData(thePlayer,"Animando", false)
	end
end
addCommandHandler("removerobj", removerobj)

function restart()
	for index, player in ipairs(getElementsByType("player")) do
		bindKey(player, "x", "down", removerobj)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)

function entrar()
	bindKey(source, "x", "down", removerobj)
end
addEventHandler("onPlayerJoin", getRootElement(), entrar)

function fechar(player)
	for index, player in ipairs(getElementsByType("player")) do
		unbindKey(player, "x", "down", removerobj)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), fechar)







local timer = {}
function giveMoneyToPlayer(thePlayer, id,money)
	if not id then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Informe a conta da pessoa que deseja transferir" ) return end
	if not money then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Informe a quantidade para transferir" ) return end
	if not money == tonumber(money) then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Informe apenas numeros" ) return end
	if not money == math.floor(money) then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Não pode quebrar o numero com ponto!" ) return end

	if isTimer(timer[thePlayer]) then
	--triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Apressado!","Aguarde quinze segundos!" ) 
	exports.bgo_hud:dm("Aguarde 15 segundos!",thePlayer, 255, 255, 255)
	return
	end
	local player2 = exports.bgo_core:findPlayer(thePlayer, id)
	if player2 then
	if (thePlayer ~= player2) then
	local x, y, z = getElementPosition(thePlayer)
	local tx, ty, tz = getElementPosition(player2)
	local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)	
	if distance <= 3  then
	if getElementData(thePlayer, "char:money") >= money then 
	if tonumber(getElementData(player2, "char:money") or 0) + money > 100000 then
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Ocorreu algum problema com essa pessoa!!" )
	triggerClientEvent(player2, "inv:erro", player2,  "Urgente!","Você tem muito dinheiro em mãos!" )
	return
	end
	timer[thePlayer] = setTimer(function() end, 15000, 1)
	setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money")-money)
	setElementData(player2, "char:money", getElementData(player2, "char:money")+money)
	triggerClientEvent(thePlayer, "inv:sucess", thePlayer,  "Dinheiro enviado com sucesso!" )
	triggerClientEvent(player2, "inv:sucess", player2,  "Você recebeu uma quantia de dinheiro!" )
	exports.bgo_hud:dm("Você enviou R$: "..money.." para " .. getPlayerName(player2),thePlayer, 255, 255, 255)
	exports.bgo_hud:dm("*" .. getPlayerName(thePlayer) .." enviou R$: "..money.." para você",player2, 255, 255, 255)


	exports.bgo_discordlogs:sendDiscordMessage(3, false, "`[TRANSFERENCIA CELULAR]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." enviou via celular R$: "..money.." para "..getPlayerName(player2).." ID: "..getElementData(player2, "acc:id").."`")
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Você está sem dinheiro!!" )
	end
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Pessoa muito distante de você!" )
	end
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Bobinho(a) não pode fazer isso!" )
	end
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Pessoa não está na cidade no momento!" )
	end
end
addEvent("phone:enviarM",true)
addEventHandler("phone:enviarM",root,giveMoneyToPlayer)







local timer = {}
function CelulartransM(thePlayer, id,money)
	if not id then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Informe a conta da pessoa que deseja transferir" ) return end
	if not money then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Informe a quantidade para transferir" ) return end
	if not money == tonumber(money) then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Informe apenas numeros" ) return end
	if not money == math.floor(money) then triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Não pode quebrar o numero com ponto!" ) return end

	if isTimer(timer[thePlayer]) then
	--triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Apressado!","Aguarde quinze segundos!" ) 
	exports.bgo_hud:dm("Aguarde 15 segundos!",thePlayer, 255, 255, 255)
	return
	end
	local player2 = exports.bgo_core:findPlayer(thePlayer, id)
	if player2 then
	if (thePlayer ~= player2) then
	local x, y, z = getElementPosition(thePlayer)
	local tx, ty, tz = getElementPosition(player2)
	--local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)	
	--if distance <= 3  then
	if getElementData(thePlayer, "char:bankmoney") >= money then 
	timer[thePlayer] = setTimer(function() end, 15000, 1)
	setElementData(thePlayer, "char:bankmoney", getElementData(thePlayer, "char:bankmoney")-money)
	setElementData(player2, "char:bankmoney", getElementData(player2, "char:bankmoney")+money)
	triggerClientEvent(thePlayer, "inv:sucess", thePlayer,  "Transferencia feita com sucesso!" )
	triggerClientEvent(player2, "inv:sucess", player2,  "Você recebeu uma transferencia do jogador" )
	exports.bgo_hud:dm("Você enviou R$: "..money.." para " .. getPlayerName(player2),thePlayer, 255, 255, 255)
	exports.bgo_hud:dm("*" .. getPlayerName(thePlayer) .." enviou R$: "..money.." para você",player2, 255, 255, 255)


	
	exports.bgo_discordlogs:sendDiscordMessage(3, false, "`[TRANSFERENCIA CELULAR]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." enviou via celular R$: "..money.." para "..getPlayerName(player2).." ID: "..getElementData(player2, "acc:id").."`")
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Você está sem dinheiro!!" )
	end
	--else
	--triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Pessoa muito distante de você!" )
	--end
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Bobinho(a) não pode fazer isso!" )
	end
	else
	triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Pessoa não está na cidade no momento!" )
	end
end
addEvent("phone:transM",true)
addEventHandler("phone:transM",root,CelulartransM)




local animTimer = {}
local phone = {}
local abriuCelular = {}

addEvent("BTCdroid.startAnimation2", true)
addEventHandler("BTCdroid.startAnimation2", root, function()
	phone[client] = createObject(330, 0, 0, 0, 0, 0, 0)
	exports.bone_attach:attachElementToBone(phone[client], client, 12, 0, 0.01, 0.03, -15, 270, -15)
	setElementDimension(phone[client], getElementDimension(client))
	setElementInterior(phone[client], getElementInterior(client))
end)




function ligando(thePlayer)
	setPedAnimation ( thePlayer, "ped","phone_in", 1000, false, false, false, true)
	setTimer(setPedAnimationProgress, 500,2, thePlayer, "phone_in", 0.8)
	

--[[
	animTimer[thePlayer] = setTimer(function(player)
		if ( isElement(player) ) then
			setPedAnimationProgress(player, "phone_in", 0.8)
		end
	end, 1000, 1, thePlayer)
	]]--
end
addEvent("BTCdroid.startAnimation", true)
addEventHandler("BTCdroid.startAnimation", root, ligando)

addEvent("BTCdroid.stopAnimation", true)
addEventHandler("BTCdroid.stopAnimation", root, function(thePlayer)
	removePhone(thePlayer)
end)

addEvent("tiraranimacao", true)
addEventHandler("tiraranimacao", root, function(thePlayer)
		if (phone[thePlayer]) then
		removePhone(thePlayer)
		setPedAnimation ( thePlayer, "ped", "phone_out", 50, false, false, false, false)
		end
end)



addEventHandler("onPlayerQuit", root, function()
	removePhone(source)
end)

addEventHandler("onPlayerWasted", root, function()
	removePhone(source)
end)

addEvent("onPlayerArrested", true)
addEventHandler("onPlayerArrested", root, function()
	removePhone(source)
end)

function removePhone(player)
	if (phone[player]) then
		destroyElement(phone[player])
		phone[player] = nil
	end	
	--[[
	if (animTimer[player]) then
		killTimer(animTimer[player])
		--animTimer[player] = nil
	end	]]--
end

local flood2 = 0
counter = {}
ptimer = {}

function abrircelular()				
		if getElementData(source, "call:celular222") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff AGUARDE UM POUCO!", source, 255, 255, 255, true) return end

		setElementData(source, "call:celular222", true)
		setTimer ( setElementData, 6000, 1, source, "call:celular222", false)
		
	exports.bgo_chat:sendLocalMeAction(source, "Abriu o celular.")
end
addEvent("abrircelular", true)
addEventHandler("abrircelular", root, abrircelular)























