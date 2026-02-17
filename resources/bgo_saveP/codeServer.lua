
local connection = exports["bgo_mysql"]:getConnection()

Async:setPriority("high")
Async:setDebug(true)

local randomPos2 = {
     {566.754, -3202.246, 843.152},
     {566.524, -3210.961, 843.152},
     {574.272, -3211.497, 843.152},
     {574.76, -3201.989, 843.152},
     {570.531, -3203.142, 843.152},
	 {570.589, -3211.178, 843.152},
}


local randomPos3 = {
     {2411.4348144531,2354.3347167969,10.8203125},
     {2411.3947753906,2350.9194335938,10.8203125},
     {2413.19140625,2352.7133789063,10.8203125},
     {2407.2114257813,2356.4479980469,10.8203125},
     {2402.4157714844,2352.751953125,10.8203125},
}

function loadCharacter(player)
		setElementData(player, "loggedin", true)
	--triggerClientEvent ( player, "ShowNovidade", player, true, "halloween")

		local playeraccount = getPlayerAccount ( player )
		local pos = getElementData(player, "spawnPos")
		local hp = getElementData(player, "spawnedHp")
		local armor = getElementData(player, "spawnedArmor")
		local hunger = getElementData(player, "spawnedHunger")
		local drink = getElementData(player,"spawnedDrink")
		local menina = getAccountData(playeraccount, "skin:femi") or 0
		local homem = 0
		local nome = getElementData(player, "char:name"):gsub(" ", "_") or "Desconhecido"..math.random(11111,999999)..""
		setPlayerName(player, nome)
		setElementData(player, "char:hunger", hunger)
		setElementData(player, "char:thirst", drink)
		setCameraTarget(player)
		
		if getElementData(player, "adminjail") == 0 then

		--local lv = tonumber(getElementData(player, "Sys:Level" ) or 0)
		--if lv < 4 then
		--[[
		exports.bgo_hud:dm("Para entrar em Los Santos você precisa emitir o passaporte na prefeitura",player, 255, 255, 255)
		exports.bgo_hud:dm("Você está com level abaixo de 4 e foi transferido para las venturas!", player, 255, 255, 255)
		
		pos3 = math.random(#randomPos3)
		local genero = getElementData(player, "char:genero")
		if genero == "mulher" then 
		
		spawnPlayer(player, randomPos3[pos3][1], randomPos3[pos3][2], randomPos3[pos3][3], 0, skin, 0, 0)
		
		
		spawnPlayer(player, 2416.981, 2352.757, 10.82, 0, skin, 0, 0)
		end
		if genero == "homem" then 
		
		spawnPlayer(player, randomPos3[pos3][1], randomPos3[pos3][2], randomPos3[pos3][3], 0, 0, 0, 0)
		
		--spawnPlayer(player, 2416.981, 2352.757, 10.82, 0, 0, 0, 0)
		end
		
		if tonumber(hp or 0) <= 1 then
		killPed(player, player)
		end
		setElementHealth(player, hp)
		setPedArmor(player, armor)
]]--
		
		--else
		
		local genero = getElementData(player, "char:genero")
		if genero == "mulher" then 
		spawnPlayer(player, pos[1], pos[2], pos[3], 0, menina, pos[4], pos[5])
		end
		if genero == "homem" then 
		spawnPlayer(player, pos[1], pos[2], pos[3], 0, homem, pos[4], pos[5])
		end
		
		
		setElementHealth(player, hp)
		
		if tonumber(hp or 0) <= 1 then
		killPed(player, player)
		end
		
		setPedArmor(player, armor)
		
		--end
		end
		
		local numerotelefone = getElementData(player, "char:playedTime")
		local telefone = getElementData(player,"char:telefone")
		
		if (tonumber(numerotelefone) or 0) > 0 and (tonumber(numerotelefone) or 0) then
		setElementData(player,"char:telefone", numerotelefone)
		--print(""..getPlayerName(player).." Ja tem um numero de telefone")
		else
		--print(""..getPlayerName(player).." Acaba de gerar um numero de telefone")
		setElementData(player,"char:playedTime", math.random(1111111,9999999))
		end
		
		--for k, v in ipairs(getElementsByType("player")) do
		--	exports.bgo_downloadcompac:download(player)
		--end
		
		-------------------------
		-- ITEMS GRATIS ABAIXO --
		-------------------------
		
		--if not exports['bgo_items']:hasItemS(player, 341) then 
		--exports.bgo_items:giveItem(player, 341, 1, 1, 0, true)
		--triggerClientEvent ( player, "ShowNovidade", player, true, "pascoa")
		--end
		
		--setElementModel(player, skin)
		
	--[[
		local accId = getElementData(player, "acc:id")
		local spawnQuery = dbPoll(dbQuery(connection, "SELECT * FROM characters WHERE id = ? LIMIT 1", accId), -1)
		if (tonumber(#spawnQuery) or 0) > 0 then
		for _, cRow in ipairs(spawnQuery) do
		genero = cRow["gender"]
		if genero == "no" then 
		setElementModel(player, skin)
		
		setElementData(player, "char:genero", "mulher")
		
		else
		setElementModel(player, 0)
		
		setElementData(player, "char:genero", "homem")
		end
		end
		end
		
		]]--
		
		if tonumber(getElementData (player,"balas-pistola") or 0) >= 1000 then
		setElementData (player,"balas-pistola", 1000)
		end
		if tonumber(getElementData (player,"balas-shotgun") or 0) >= 1000 then
		setElementData (player,"balas-shotgun", 1000)
		end
		if tonumber(getElementData (player,"balas-fuzil") or 0) >= 1000 then
		setElementData (player,"balas-fuzil", 1000)
		end
		if tonumber(getElementData (player,"balas-submetralhadora") or 0) >= 1000 then
		setElementData (player,"balas-submetralhadora", 1000)
		end
		if tonumber(getElementData (player,"balas-sniper") or 0) >= 1000 then
		setElementData (player,"balas-sniper", 1000)
		end
		if tonumber(getElementData (player,"balas-shotgun") or 0) >= 1000 then
		setElementData (player,"balas-shotgun", 1000)
		end
		

	
		
		local account = getPlayerAccount(player)	
		local textureString = getAccountData(account, "Clothessaver:Texture") 
		local modelString = getAccountData(account, "Clothessaver:Model")
		local textures = split(textureString, 44)
		local models = split(modelString, 44)
		for i=0, 17, 1 do
			if ( textures[i+1] ~= " " ) then
				addPedClothes(player, textures[i+1], models[i+1], i)
			end
		end
		textures = {}
		models = {}
		
		
		
		setTimer(function()
		outputChatBox("#dc143c[BGO SISTEMA]:#ffffffCARREGANDO TODOS OS MODS DA CIDADE, AGUARDE!", player, 255, 255, 255, true)
		triggerClientEvent ( player, "Carregar-mods", player )		
		end, 10000,1, player)
		
		
		
		
		--[[
		
		local accId = getElementData(player, "acc:id")
		local check = dbQuery(connection, "SELECT * FROM characters WHERE id = ?", accId)
		local spawnQuery = dbPoll(check, -1)
		if (#spawnQuery > 0) then
		for _, cRow in ipairs(spawnQuery) do
		textureString = cRow["cj"]
		modelString = cRow["cjm"]
		textures = {}
		models = {}
		local textures = split(textureString, 44)
		local models = split(modelString, 44)
		for i=0, 17, 1 do
		if ( textures[i+1] ~= " " ) then
		addPedClothes(player, textures[i+1], models[i+1], i)
		end
		end
		textures = {}
		models = {}
		end
		end]]--
		
				
		--local genero = getElementData(player, "char:genero")
		--if genero == "mulher" then 
		--setElementModel(player, menina)
		--end
		--if genero == "homem" then 
		--setElementModel(player, homem)
		--end
		

		if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
		exports.bgo_admin:setarskinP(player)
		end
		
		if getElementData(player, "job") == "Pedreiro" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 27)
		end
		elseif getElementData(player, "job") == "ifood" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 155)
		end
		elseif getElementData(player, "job") == "Lixeiro" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 128)
		end
		elseif getElementData(player, "job") == "Limpador" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 259)
		end
		elseif getElementData(player, "job") == "Sedex" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 124)
		end
		elseif getElementData(player, "job") == "Entregador de Gas" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 59)
		end
		elseif getElementData(player, "job") == "Motorista" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 127)
		end
		elseif getElementData(player, "job") == "MotoristaR" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 147)
		end
		elseif getElementData(player, "job") == "Maquinista" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 120)
		end
		elseif getElementData(player, "job") == "Transporte de Valores" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 71)
		end
		elseif getElementData(player, "job") == "Eletrecista" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 260)
		end
		elseif getElementData(player, "job") == "Transporte de Gasolina" then
		local genero = getElementData(player, "char:genero")
		if genero == "homem" then 
		setElementModel(player, 182)
		end
		end


		setPlayerName(player, nome)

	


		
		local adminL = getElementData(player, "acc:admin")
		--if adminL == 0 then
		
		if tonumber(adminL) >= 1 then
		executeCommandHandler ( "adminduty159753", player )
		end
		
		
		--local empty = exports.bgo_voice:getNextEmptyChannel() 
		--exports.bgo_voice:setPlayerChannel(player, empty)
		--setPlayerVoiceBroadcastTo(player,root)
		--setPlayerVoiceIgnoreFrom ( player, player ) 
		
		if getElementData(player, "adminjail") == 1 then
		checkAdminjail(player)
		setElementFrozen(player, true)
		fadeCamera(player, false, 1.0)
		showChat(player, false)
		setTimer(function()
		triggerClientEvent(player, "triggerAdminjail", player, getElementData(player, "adminjail:admin"), getElementData(player, "adminjail:reason"), getElementData(player, "adminjail:alapIdo"), 2, getElementData(player, "adminjail:ido"))
		end, 500, 1)
		
		setTimer(function()
		fadeCamera(player, true, 2.5)
		setElementFrozen(player, false)
		toggleAllControls(player, true, true, true)
		showChat(player, true)
		setElementData(player, "player:preso", true)
		pos2 = math.random(#randomPos2)
		
		--[[
		local genero = getElementData(player, "char:genero")
		if genero == "mulher" then 
		spawnPlayer(player, randomPos2[pos2][1], randomPos2[pos2][2], randomPos2[pos2][3], 0, menina, 3, 1)
		end
		if genero == "homem" then 
		spawnPlayer(player, randomPos2[pos2][1], randomPos2[pos2][2], randomPos2[pos2][3], 0, homem, 3, 1)
		end]]--
		
		--print(""..getPlayerName(player).." Logou e foi preso automaticamente")
		--setElementPosition(player, randomPos2[pos2][1], randomPos2[pos2][2], randomPos2[pos2][3])
		--setElementInterior(player, 3)
		--setElementDimension(player, 1)
		
		exports.bgo_admin:setarskinP(player)
		
		setElementHealth(player, hp)
		
		if tonumber(hp or 0) <= 1 then
		killPed(player, player)
		end
		
		setPedArmor(player, armor)
		
		--loadClothes(player)
		
		end, 7500, 1, player)
		
		end
		

end
addEvent("loadCharacter", true)
addEventHandler("loadCharacter", root, loadCharacter)


local randomPos = {
     {3053.8581542969,-1972.6236572266,11.06875038147},
     {3052.5766601563,-1960.96875,11.06875038147},
     {3050.4875488281,-1993.8082275391,11.06875038147},
}

function checkAdminjail(player)
	if getElementData(player, "adminjail") == 1 then
	
		 pos = math.random(#randomPos)
		setElementPosition(player, randomPos[pos][1], randomPos[pos][2], randomPos[pos][3])
		setElementInterior(player, 0)
		setElementDimension(player, 0)
		
		
		--local idoTelikTimer = setTimer(idoTelikLe, 60000, getElementData(player, "idoTelik"), player)
		--local theTimer = setElementData(player, "adminjail:theTimerAccounts", idoTelikTimer)
		outputChatBox("#dc143c[Cadeia Administrativa]:#ffffffVocê foi detido depois de entrar. para mais detalhes, use o comando #7cc576/tempo", player, 255, 255, 255, true)
	end
end

--[[
function idoTelikLe(targetPlayer)
	if isElement(targetPlayer) then
		local idoTelik = tonumber(getElementData(targetPlayer, "idoTelik")) or 0
		local idoLetelt = tonumber(getElementData(targetPlayer, "idoLetelt")) or 0
		if (idoTelik) and (idoLetelt) then
			setElementData(targetPlayer, "idoTelik", idoTelik-1)
			setElementData(targetPlayer, "idoLetelt", idoLetelt+1)
			local sql = dbExec(connection, "UPDATE characters SET adminjail_idoTelik = ?, adminjail_alapIdo = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", idoTelik, idoLetelt)
		end
		if (idoTelik) <= 1 then
			outputChatBox("#0094ff[informação]: #ffffffSua sentença expirou.", targetPlayer, 255, 255, 255, true)
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
			local setPosition = setElementPosition(targetPlayer, 2336.669, 2479.397, 14.979)
			local setInterior = setElementInterior(targetPlayer, 0)
			local setDimension = setElementDimension(targetPlayer, 0)
		end
	end
end
]]--

function _call(_called, ...)
	local co = coroutine.create(_called);
	coroutine.resume(co, ...);
end

function sleep(time)
	local co = coroutine.running();
	local function resumeThisCoroutine()
		coroutine.resume(co);
	end
	setTimer(resumeThisCoroutine, time, 1);
	coroutine.yield();
end

function UpdateStates()
	_call(saveAllPlayer); 
end
--addEventHandler("onResourceStart", resourceRoot, UpdateStates)

function saveAllPlayer()
	outputDebugString("[BGO SYSTEM]: INICIANDO SALVAMENTO DE CONTAS!")
	for _, player in ipairs(getElementsByType("player")) do
		saveOnePlayer(player)
		sleep(300);
		--if getElementData(player, "loggedin") then
		--outputDebugString("[Conta]: salvamento da conta "..getElementData(player,"acc:id").." salva com sucesso!")
		--end
	end
		outputDebugString("[BGO SYSTEM]: TODAS AS CONTAS SALVAS COM SUCESSO!!")
end
--addEventHandler("onResourceStop", resourceRoot, saveAllPlayer)
--setTimer(saveAllPlayer, 1000*60*30, 0)

setTimer(UpdateStates, 1000*60*30, 0)


--[[
function aa()
	for _, player in ipairs(getElementsByType("player")) do
	if isElement(player) and getElementData(player, "loggedin") then
		if not exports['bgo_items']:hasItemS(player, 341) then 
		exports.bgo_items:giveItem(player, 341, 1, 1, 0, true)
		triggerClientEvent ( player, "ShowNovidade", player, true, "pascoa")
		end
	end
	end
end
addEventHandler("onResourceStart", resourceRoot, aa)
]]--


function saveAllPlayerCmd(p)
	if tonumber(getElementData(p, "acc:admin") or 0) >= 8 then
		for _, player in ipairs(getElementsByType("player")) do
			saveOnePlayer(player)
		--_call(UpdateStates);
		end
		outputDebugString("[BGO SYSTEM]: TODAS AS CONTAS FORAM SALVAS COM SUCESSO")
	end
end
addCommandHandler("saveall", saveAllPlayerCmd, false, false)



function saveOnePlayer(player)
	if isElement(player) and getElementData(player, "loggedin") then
		local x,y,z = getElementPosition(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
		local position = toJSON({x,y,z,int,dim})
		local money = getElementData(player, "char:money")or 0
		local bmoney = getElementData(player, "char:bankmoney")or 0
		local aduty = getElementData(player, "char:adminduty")or 0
		local admin = getElementData(player, "acc:admin") or 0
		local adutyTime = getElementData(player, "aduty:time") or 0
		local played = getElementData(player, "char:playedTime") --getElementData(player, "char:playedTime") or 0
		local job = getElementData(player, "job") or "SemEmprego"
		local hp = getElementHealth(player)
		local armor = getPedArmor(player)
		local hunger = getElementData(player, "char:hunger") or 0
		local drink = getElementData(player, "char:thirst") or 0
		local premium = getElementData(player, "char:pp") or 0
		local level = getElementData(player,"Sys:Level") or 0
		local exp = getElementData(player,"LSys:EXP") or 0
		
--[[
		local texture = {}
		local model = {}
		for i=0, 17 do
			local clothesTexture, clothesModel = getPedClothes(player, i)
			if ( clothesTexture ~= false ) then
				table.insert(texture, clothesTexture)
				table.insert(model, clothesModel)
			else
				table.insert(texture, " ")
				table.insert(model, " ")
			end	
		end
		local allTextures = table.concat(texture, ",")
		local allModels = table.concat(model, ",")
]]--
		
		
	
		local account = getPlayerAccount(player)
		local texture = {}
		local model = {}
		for i=0, 17 do
			local clothesTexture, clothesModel = getPedClothes(player, i)
			if ( clothesTexture ~= false ) then
				table.insert(texture, clothesTexture)
				table.insert(model, clothesModel)
			else
				table.insert(texture, " ")
				table.insert(model, " ")
			end	
		end
		local allTextures = table.concat(texture, ",")
		local allModels = table.concat(model, ",")
		setAccountData(account, "Clothessaver:Texture", allTextures)
		setAccountData(account, "Clothessaver:Model", allModels)
		texture = {}
		model = {}

		
		
		--local allTextures = 0
		--local allModels = 0

		local playeraccount = getPlayerAccount ( player )

		
		
		local genero = getElementData(player, "char:genero")
		if genero == "mulher" then 
		if ( playeraccount ) and not isGuestAccount ( playeraccount ) then 
			setAccountData ( playeraccount, "skin:femi", getElementModel(player))
		end
		end

		--end
		--outputDebugString("[Conta]: salvamento da conta "..getElementData(player,"acc:id").." salva com sucesso!")
		
		
		dbExec(connection, "UPDATE accounts SET admin = ? WHERE id = ?", admin, getElementData(player,"acc:id"))
		local r = getRealTime()
		local tempo = ("%04d-%02d-%02d %02d:%02d"):format(r.year+1900, r.month + 1, r.monthday, r.hour,r.minute)
		dbExec(connection, "UPDATE accounts SET lastlogin = ? WHERE id = ?", tempo, getElementData(player,"acc:id"))
		dbExec(connection, "UPDATE characters SET data = ? WHERE id = ?", tempo, getElementData(player,"acc:id"))
		
		
		dbExec(connection, "UPDATE characters SET pos = ?, money = ?,bankmoney = ?, adminduty = ?, playedTime = ?, job = ?,Level = ?,LevelEXP = ?, cj = ?, cjm = ?, hp = ?, armor = ?, hunger = ?, drink = ?, premiumpont = ?, adutyTime = ? WHERE id = ?",position, money, bmoney, aduty, played, job, level, exp, allTextures , allModels, hp, armor, hunger, drink, premium, adutyTime, getElementData(player, "acc:id"))


		--local idoTelik = tonumber(getElementData(player, "idoTelik")) or 0
		--local idoLetelt = tonumber(getElementData(player, "idoLetelt")) or 0
		--local sql = dbExec(connection, "UPDATE characters SET adminjail_idoTelik = ?, adminjail_alapIdo = ? WHERE id = '" .. getElementData(player, "char:id") .. "'", idoTelik, idoLetelt)


	end
end

function leavePlayer()
	if isElement(source) then
		local accid = getElementData(source, "acc:id")
		if not tonumber(accid) then return end
		
		if isElement(source) and getElementData(source, "loggedin") then
		dbExec(connection, "UPDATE accounts SET online = 0 WHERE id = ?", accid)
		outputDebugString(getPlayerName(source) .. " Ele saiu da cidade e sua conta foi guardada!")
		saveOnePlayer(source)
	end
	end
end
addEventHandler("onPlayerQuit", root, leavePlayer)




function saveVehicle(veh)
	local dbid = tonumber(getElementData(veh, "veh:id") or 0)
	
	if isElement(veh) and tostring(getElementType(veh)) == "vehicle" and dbid >= 0 then	
		local fuel = getElementData(veh, "veh:status")
		local engine = getElementData(veh, "veh:motor") or false
		local locked = isVehicleLocked(veh)
		local fuel = getElementData(veh, "veh:fuel")
		local neon = tonumber(getElementData(veh, "veh:neon") or 0)
		local lights = getVehicleOverrideLights(veh)
		local health = getElementHealth(veh)
		local wheel1, wheel2, wheel3, wheel4 = getVehicleWheelStates(veh)
		local wheelState = toJSON( { wheel1, wheel2, wheel3, wheel4 } )	
		local panel0 = getVehiclePanelState(veh, 0)
		local panel1 = getVehiclePanelState(veh, 1)
		local panel2 = getVehiclePanelState(veh, 2)
		local panel3 = getVehiclePanelState(veh, 3)
		local panel4 = getVehiclePanelState(veh, 4)
		local panel5 = getVehiclePanelState(veh, 5)
		local panel6 = getVehiclePanelState(veh, 6)
		local panelState = toJSON( { panel0, panel1, panel2, panel3, panel4, panel5, panel6 } )
			
		local door0 = getVehicleDoorState(veh, 0)
		local door1 = getVehicleDoorState(veh, 1)
		local door2 = getVehicleDoorState(veh, 2)
		local door3 = getVehicleDoorState(veh, 3)
		local door4 = getVehicleDoorState(veh, 4)
		local door5 = getVehicleDoorState(veh, 5)
		local doorState = toJSON( { door0, door1, door2, door3, door4, door5 } )
		
		local x,y,z = getElementPosition(veh)
		local int = getElementInterior(veh)
		local dim = getElementDimension(veh)
		local pos = toJSON({x,y,z,int,dim})

		--if dbPoll ( dbQuery( connection, "UPDATE vehicle SET panel=?,  pos=? , wheel=?, door=?, fuel=?, motor=?, status=?, lampa=?, hp=? WHERE id='?'", panelState, pos, wheelState, doorState, fuel, engine, locked, lights, health,dbid), -1 ) then

		dbExec(connection, "UPDATE vehicle SET panel=?,  pos=? , wheel=?, door=?, fuel=?, motor=?, status=?, lampa=?, hp=? WHERE id=?", panelState, pos, wheelState, doorState, fuel, engine, locked, lights, health, dbid)

	end
end

function saveAllVeh()
	local count = 0
	for i, p in ipairs(getElementsByType("vehicle")) do
		if (tonumber(getElementData(p, "veh:owner") or 0) >= 1) then
			saveVehicle(p)
			count = count + 1
		end
	end
	outputDebugString("[Veiculo]: Foi Salvado: "..count.." veiculos da cidade!!")
end
addCommandHandler("saveallveh",saveAllVeh)



--[[
function salvamento()
_call(vehicleForDimension, source); 
end
addEventHandler("onPlayerQuit",getRootElement(),salvamento)

]]--

function vehicleForDimension()
	if not getElementData(source, "loggedin") then return end
	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "veh:owner") == getElementData(source, "acc:id") then
			local r = getRealTime()
			local tempo = ("%04d-%02d-%02d %02d:%02d"):format(r.year+1900, r.month + 1, r.monthday, r.hour,r.minute)
			dbExec(connection, "UPDATE vehicle SET data = ? WHERE owner = ?", tempo, getElementData(source,"acc:id"))
			if getElementDimension(v) == 0 then
			
			if not getElementData(v, "veh:detran") then
			if not getElementData(v, "veh:desmanche") then 
			for index, value in ipairs(getElementsByType("player")) do
					inVehicle = getPedOccupiedVehicle(value)
					if inVehicle and inVehicle == v then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end
			local teste = math.random(1,65535)
			setElementData(v, "veh:oldInterior", teste)
			setElementData(v, "veh:oldDimension", teste)
    		setElementDimension(v, teste)
    		setElementInterior(v, teste)
			setVehicleEngineState(v,false)
			v:setData("veh:motor",false)
			saveVehicle(v)
			setVehicleLocked(v,true)
			v:setData("veh:status",true)
			end
			end
		end
		end
	end
end
addEventHandler("onPlayerQuit",getRootElement(),vehicleForDimension)






-----------------------------------------------------------------------------------
----------------------------------SALVAMENTO DA ROUPA CJ---------------------------
-----------------------------------------------------------------------------------

function saveClothes()
	local account = getPlayerAccount(source)
	if ( not isGuestAccount(account) )then
		local texture = {}
		local model = {}
		for i=0, 17, 1 do
			local clothesTexture, clothesModel = getPedClothes(source, i)
			if ( clothesTexture ~= false ) then
				table.insert(texture, clothesTexture)
				table.insert(model, clothesModel)
			else
				table.insert(texture, " ")
				table.insert(model, " ")
			end	
		end
		local allTextures = table.concat(texture, ",")
		local allModels = table.concat(model, ",")
		setAccountData(account, "Clothessaver:Texture", allTextures)
		setAccountData(account, "Clothessaver:Model", allModels)
		texture = {}
		model = {}
	end
end
--addEventHandler("onPlayerQuit", getRootElement(), saveClothes)

function setClothes()
	local account = getPlayerAccount(source)
	if ( not isGuestAccount(account) ) then
	
	
		local textureString = getAccountData(account, "Clothessaver:Texture") 
		local modelString = getAccountData(account, "Clothessaver:Model")
		local textures = split(textureString, 44)
		local models = split(modelString, 44)
		--setElementModel(source,0)
		for i=0, 17, 1 do
			if ( textures[i+1] ~= " " ) then
				addPedClothes(source, textures[i+1], models[i+1], i)
			end
		end
		textures = {}
		models = {}
	end
end
--addEventHandler("onPlayerLogin", getRootElement(), setClothes)

function loadClothes(player)
	local account = getPlayerAccount(player)
	if ( not isGuestAccount(account) ) then
		local textureString = getAccountData(account, "Clothessaver:Texture")
		local modelString = getAccountData(account, "Clothessaver:Model")
		local textures = split(textureString, 44)
		local models = split(modelString, 44)
		--setElementModel(player,0)
		for i=0, 17 do
			if ( textures[i+1] ~= " " ) then
				addPedClothes(player, textures[i+1], models[i+1], i)
			end
		end
		--outputDebugString(" "..getPlayerName(player).." carregou")
		--outputChatBox("Clothes were added by clothessaver", player, 0, 255, 0)
		textures = {}
		models = {}
	else
		outputChatBox("Please login!", player, 255, 0, 0)
	end
end
addCommandHandler("loadClothes", loadClothes)

function saveClothes(player)
	local account = getPlayerAccount(player)
	if ( not isGuestAccount(account) ) then
		if ( getElementModel(player) == 0 ) then
			local texture = {}
			local model = {}
			for i=0, 17 do
				local clothesTexture, clothesModel = getPedClothes(player, i)
				if ( clothesTexture ~= false ) then
					table.insert(texture, clothesTexture)
					table.insert(model, clothesModel)
				else
					table.insert(texture, " ")
					table.insert(model, " ")
				end
			end
			local allTextures = table.concat(texture, ",")
			local allModels = table.concat(model, ",")
			outputDebugString("Clothessaver: Saved clothes")
			setAccountData(account, "Clothessaver:Texture", allTextures)
			setAccountData(account, "Clothessaver:Model", allModels)
			texture = {}
			model = {}
		else
			outputChatBox("Your skin must be skin 0 (CJ Skin)", player, 255, 0, 0)
		end
	else
		outputChatBox("Please login!", player, 255, 0, 0)
	end
end
addCommandHandler("saveClothes", saveClothes)

--[[

function checagem(thePlayer)
	if isTimer(tempoo) then
	print("Tente novamente...")
	return 
	end
	print("Iniciando...")	
	local accId = 60253
	check = dbPoll(dbQuery(connection, "SELECT * FROM accounts WHERE id = "..accId..""), -1)
	if #check > 0 then

	for _, cRow in ipairs(check) do

			print(cRow["id"])
			print(cRow["username"])

			--tempoo = setTimer(function() end, 8000, 1)
			--break
		end
end
end
addCommandHandler("checar", checagem)]]--