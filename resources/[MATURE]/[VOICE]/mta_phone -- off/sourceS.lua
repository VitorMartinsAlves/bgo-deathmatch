connection = dbConnect("sqlite", "data.db")
addEventHandler("onResourceStart", resourceRoot,
function ()													
	local db = dbExec(connection, "CREATE TABLE IF NOT EXISTS `TELEFONE` (`id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `LOGIN` TEXT, `CONTATOS` TEXT, `name` TEXT)")  
	local db2 = dbExec(connection, "CREATE TABLE IF NOT EXISTS `TELEFONECONF` (`id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `LOGIN` TEXT, `wallpaper` TEXT, `music` TEXT)") 

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
	
end
)

function generatePhoneNumber()
	return math.random(1111111,9999999)
end
	
function getPhoneDataFromServer(playerSource, phoneID)
	if tonumber(phoneID) then
		--local checkID = dbPoll(dbQuery(connection, "SELECT * FROM phones WHERE number = ? LIMIT 1", tonumber(phoneID)), -1)
		--if (checkID) then
			--for k, v in ipairs(checkID) do

		local qh = dbQuery(connection, "SELECT * FROM TELEFONECONF WHERE LOGIN=?", tonumber(phoneID))
		local result = dbPoll(qh, -1)
		--if (#result > 0) then
		if (#result > 0) then
		
		--[[
		if (result[1]["wallpaper"]) then
		setElementData(playerSource, "wallpaper", result[1]["wallpaper"]) 
		--print("WALL TRUE "..result[1]["wallpaper"])
		end
		if (result[1]["music"]) then
		setElementData(playerSource, "musicID", result[1]["music"]) 
		--print("MUSIC TRUE "..result[1]["music"])
		end]]--
		
		triggerClientEvent(playerSource, "getPhoneDataToClient", playerSource,  result[1]["wallpaper"], result[1]["music"])
		--local wall = getElementData(playerSource, "wallpaper") or 3 
		--local music = getElementData(playerSource, "musicID") or 2 
		--triggerClientEvent(playerSource, "getPhoneDataToClient", playerSource, wall, music)
		else	

	local query = dbQuery(connection, "INSERT INTO TELEFONECONF ( wallpaper, music, LOGIN) VALUES ( '3', '2', '"..phoneID.."' )")
	local QueryEredmeny,_,insertID = dbPoll(query, -1)	
	if insertID then
	--print("CELULAR TRUE "..insertID)
	
		--dbExec(connection, 'UPDATE TELEFONECONF SET wallpaper=? WHERE LOGIN=?', 3, tonumber(phoneID))
		--dbExec(connection, 'UPDATE TELEFONECONF SET music=? WHERE LOGIN=?', 2, tonumber(phoneID))
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
		--print("Celular "..getPlayerName(playerSource).." limpo")
		else
		for k, v in ipairs(result) do
			phoneContacts[#phoneContacts + 1] = {v["name"], tonumber(v["CONTATOS"]),v["id"]}
			triggerClientEvent(playerSource, "getPhoneContactToClient", playerSource, phoneContacts)
		end
	end
end
addEvent("getPhoneContactFromServer", true)
addEventHandler("getPhoneContactFromServer", getRootElement(), getPhoneContactFromServer)

function removeFromContactS(playerSource, row, id)
	if (dbExec(connection, "DELETE FROM TELEFONE WHERE id = ?", id)) then
		outputChatBox("#D64541[Telefone] #ffffffContato: "..id.." deletado com sucesso", playerSource,255,255,255,true)
		--print("CONTATOS "..id.." DELETADO")
		triggerClientEvent(playerSource, "removeFromContactC", playerSource, row)
	end		
end
addEvent("removeFromContactS", true)
addEventHandler("removeFromContactS", getRootElement(), removeFromContactS)

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
		
		--setElementData(playerSource, "wallpaper", wallPaperID)
if dbExec(connection, 'UPDATE TELEFONECONF SET wallpaper=? WHERE LOGIN=?', wallPaperID, phoneID) then
outputChatBox("#D64541[Telefone] #ffffffWallpaper Alterado para: "..wallPaperID.." Numero do telefone: "..phoneID.." Salvo com sucesso", playerSource,255,255,255,true)
end
	--dbExec(connection, "UPDATE phones SET wallpaper = ? WHERE number = ? LIMIT 1",wallPaperID, phoneID)
end
addEvent("editWallpaperInServer", true)
addEventHandler("editWallpaperInServer", getRootElement(), editWallpaperInServer)

function editRingInServer(playerSource, phoneID, musicID)
--setElementData(playerSource, "musicID", musicID)
if dbExec(connection, 'UPDATE TELEFONECONF SET music=? WHERE LOGIN=?', musicID, phoneID) then
outputChatBox("#D64541[Telefone] #ffffffWallpaper Alterado para: "..musicID.." Numero do telefone: "..phoneID.." Salvo com sucesso", playerSource,255,255,255,true)
end
	--if dbExec(connection, "UPDATE phones SET music = ? WHERE number = ?",musicID, phoneID) then
		--outputChatBox("Alarme alterado para: " .. musicID .. " seu telefone: " .. phoneID)
	--end
end
addEvent("editRingInServer", true)
addEventHandler("editRingInServer", getRootElement(), editRingInServer)

function checkOnline(phoneNumber)
	for k, v in ipairs(getElementsByType("player")) do
		if v and tonumber(phoneNumber) and tonumber(getElementData(v, "char:telefone")) then --and exports.bgo_items:hasItemS(v, 16, phoneNumber) then
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
			triggerClientEvent(targetPlayer, "showMenu", targetPlayer, ""..getPlayerName(playerSource).." (".. playerNumber ..")", 6, playerSource, number)
			triggerClientEvent(playerSource, "showMenu", playerSource, ""..getPlayerName(targetPlayer).." (".. number ..")", 7, targetPlayer, playerNumber)
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
		
				end
			end
		end
		if tonumber(number) == 2 then
			if playerSource then
				if targetPlayerSource then
				triggerClientEvent(targetPlayerSource, "showMenu", targetPlayerSource, getPlayerName(playerSource), 7, playerSource, getPlayerName(playerSource))
				triggerClientEvent(playerSource, "showMenu", playerSource, getPlayerName(targetPlayerSource), 7, targetPlayerSource, getPlayerName(targetPlayerSource))
				setElementData(playerSource, "char:money", getElementData(playerSource, "char:money") - math.random(5, 10))
				setElementData(targetPlayerSource, "char:money", getElementData(targetPlayerSource, "char:money") - math.random(5, 10))
				setElementData(playerSource, "inCall", true) 
				setElementData(targetPlayerSource, "inCall", true) 
				setElementData(playerSource, "inCall2", true)
				setElementData(targetPlayerSource, "inCall2", true)
				setPlayerVoiceBroadcastTo( playerSource, targetPlayerSource )
				setPlayerVoiceBroadcastTo( targetPlayerSource, playerSource )
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
