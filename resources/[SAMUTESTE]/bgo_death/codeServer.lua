local deadPlayer = {}
local state = false
local AccidentBlip = {}
local createdeadPed = {}
local animTimer = {}

local weaponID = {

	1,
	2,
	--3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	--12,
	13,
	14,
	15,
	16,
	20,
	26,
	--28,
	--29,
	38,
	39,
	36,
	42,
	67,
	85,
	144,
	150,
	158,
	159,
	215,

	280,
	288,
	289,
	290,
	291,
	292,
	293,
	294,
	--295,
	

	-- minerios
	249,
	250,
	251,
	252,
	253,
	254,
	255,
	256,
	257,
	258,
	259,
	260,
	261,
	262,
	263,
	
	-- pecas
	160,
	161,
	162,
	163,
	164,
	165,
	166,
	167,
	168,
	169,
	170,
	171,
	172,
	173,
	174,
	175,
	176,
	177,
	178,
	179,
	180,
	181,
	182,
	183,
	184,
	185,
	186,
	187,
	188,
	189,
	190,
	191,
	192,
	193,
	194,
	195,
	196,
	197,
	198,
	199,
	200,
	201,
	202,
	203,
	204,
	205,
	206,
	207,
	208,
	209,
	210,
	211,
	212,
	213,
	214,
	
	-- peixes
	86,
	87,
	88,
	89,
	90,
	91,
	92,
	93,
	94,
	95,
	96,

	-- armas
	38,
	32,
	47,
	64,
	84,
	52,
	50,
	49,
	44,
	51,
	53,
	44,
	68,
	125,
	128,
	103,
	126,
	242,
}
 
local weaponVIP = {
	116,
	117,
	118,
	119,
	120,
	121,
	122,
	123,
	124,
	127,
	129,
	130,
	131,
	132,
	133,
	134,
	135,
	222,
	223,
	224,
	225,
	226,
	241,
	243,
	244,
	245,
	248,
	265,
	266,
	267,
	287,
	298,
	299,
	300,
	303,
	304,
	305,
	306,
	307,
	308,
	309,
	310,
	311,
	312,
	313,
	314,
	315,
	316,
	317,
	318,
	319,
	320,
	321,
	322,
	323,
	324,
	325,
	326,
	327,
	328,
	329,
	330,
	331,
	332,
	333,	
	343,
	344,
}

local youtubersEstreamers = { 
	["DF749DAC120194E1221E619D133288F4"]=true, --ABINIS
	["4990CE3DE114CFF02BEE6FB6CE54D4A3"]=true, --JOHNNY
	["5B36547F726E4BED8D22C3703C7EEFE4"]=true, --JOHNNY/Elias
	
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --CrohsGM
	["F9C641CF778442C2653846BFE3F886E3"]=true, --RUUD MTA
	["47AED752073A8FC35AE98D9A74435BA2"]=true, --MORAIS MTA
	
} 

			
function onPlayerQuit ( )
      local playeraccount = getPlayerAccount ( source )
      if ( playeraccount ) and not isGuestAccount ( playeraccount ) then
			local tironacabeca = getElementData(source, 'dead.info')
            setAccountData ( playeraccount, "acc:tironacabeca", tironacabeca ) 
      end
end
 
function onPlayerLogin (_, playeraccount )
      if ( playeraccount ) then
            local tironacabeca = getAccountData ( playeraccount, "acc:tironacabeca" )
            if ( tironacabeca ) then
                  setElementData(source, 'dead.info', tironacabeca )
            end
      end
end
 
addEventHandler ( "onPlayerQuit", getRootElement ( ), onPlayerQuit )
addEventHandler ( "onPlayerLogin", getRootElement ( ), onPlayerLogin )
  
  


			
addEventHandler('onPlayerWasted', root, function(ammo, attacker, weapon, bodypart)
	if bodypart == 9 then 
		if weapon ~= 23 then 
			setElementData(source, 'dead.info', 9 )
		end
	end
	 --if not isPedInVehicle(source) then
	--	 createPedToPlayer(source)
	 --end
end)


function getClothes(thePlayer)
	local texture = {}
	local model = {}
	for i=0, 17, 1 do
		local clothesTexture, clothesModel = getPedClothes(thePlayer, i)
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
	clothesallTextures = allTextures
	clothesallModels = allModels
	texture = {}
	model = {}	
	setPedClothes(thePlayer)
end


local tempo = { }
function createPedToPlayer(element)
	local player = element
	
		if exports.bgo_admin:beneficiario(player) then
		triggerClientEvent(player, 'bgoMTA->#tempomorte', player, 5, true, false)
		--print(""..getPlayerName(player).." Parceiro Morto!")
		else
		--triggerClientEvent(player, 'bgoMTA->#tempomorte', player, 30, false)
		
		if exports.bgo_admin:isPlayerDuty(player) then
		triggerClientEvent(player, 'bgoMTA->#tempomorte', player, 11, false, false)
		--print(""..getPlayerName(player).." Policial Morto!")
		else
		if getElementData (player,"VIP") == true then
		triggerClientEvent(player, 'bgoMTA->#tempomorte', player, 8, false, true) -- jogador vip
		print(""..getPlayerName(player).." Jogador VIP Morto!")
		else 
		triggerClientEvent(player, 'bgoMTA->#tempomorte', player, 15, false, false) --jogador normal
		print(""..getPlayerName(player).." Jogador normal Morto!")
		end
		end
		
		end
		
		
	if isElement(createdeadPed[player]) then 
		destroyElement(createdeadPed[player])
		createdeadPed[player] = false
	end
	
	-- if not createdeadPed[player] then 
	if not isElement(createdeadPed[player]) then 
	
		--outputDebugString(' '..getPlayerName(player)..' Morto Criado!!')
		local skin = getElementModel(player)
		local x, y, z = getElementPosition(player)

		local rot = getPedRotation(player)
		createdeadPed[player] = createPed(skin, x, y, z, rot)
		
		if (getElementModel(player) == 0) then
			getClothes(player)
		end
		
		
		--setElementCollisionsEnabled(createdeadPed[player], false)
		
		
		local x2, y2, z2 = getElementPosition(createdeadPed[player])
		setElementData(createdeadPed[player],"pos1", x2 )
		setElementData(createdeadPed[player],"pos2", y2 )
		setElementData(createdeadPed[player],"pos3", z2 )
		
		
		
		--setElementAlpha(player, 25)
		setElementAlpha(createdeadPed[player], 0)
		setElementData(createdeadPed[player], "Ped:NameMorto", getElementData(player,"acc:id"))
		setElementHealth(createdeadPed[player], 1)
		setElementData(createdeadPed[player], 'ammoInBody', getElementData(player, 'ammoInBody'))
		setElementData(createdeadPed[player], 'dead.info', getElementData(player, 'dead.info'))
		setElementData(createdeadPed[player], 'owner->element', player)
		setElementData(createdeadPed[player], 'deadped', true)
		setElementData(player, 'PlayerCaido', true)
		--exports.bgo_voice:setPlayerChannel ( player, math.random(1000,9999999) )
		--setPlayerVoiceIgnoreFrom ( player, root)
		
		--exports.bgo_voice:setPlayerVoiceMuted ( player, true )
		

		

		--setElementData(player, "BlockTecla", true)
		--attachElements(createdeadPed[player], player)
		attachElements(player, createdeadPed[player])
		--setPedAnimation(player, "ped", "FLOOR_hit", -1, false, false, false)
		--setPedAnimation(createdeadPed[player], "ped", "FLOOR_hit_f", -1, false, false, true)

		--tempo[player] = setTimer(function()
		--if createdeadPed[player] and player then
		--setPedAnimation(createdeadPed[player], "SWEET", "Sweet_injuredloop", 1000, false, false, false, true)
		--local x2 = getElementData(createdeadPed[player],"pos1" )
		--local y2 = getElementData(createdeadPed[player],"pos2" )
		--local z2 = getElementData(createdeadPed[player],"pos3" )
		--setElementPosition(player, x2, y2, z2) 
		--end
		 --end, 500,1, player)
		
	 end
end
addEvent('bgoMTA->#createPedToPlayer', true)
addEventHandler('bgoMTA->#createPedToPlayer', root, createPedToPlayer)



function setPedClothes(thePlayer)
	local textureString = clothesallTextures
	local modelString = clothesallModels
	local textures2 = split(textureString, 44)
	local models2 = split(modelString, 44)
	for i=0, 17, 1 do
		if ( textures2[i+1] ~= " " ) then
			if isElement(createdeadPed[thePlayer]) then
			addPedClothes(createdeadPed[thePlayer], textures2[i+1], models2[i+1], i)
			end
		end
	end
	textures2 = {}
	models2 = {}
end





function setPlayerAnimation(player, animName, animtoName, animTime, loop)
	setPedAnimation(player, animName, animtoName, animTime, loop, false, false)
end
addEvent('bgoMTA->#setPlayerAnimation', true)
addEventHandler('bgoMTA->#setPlayerAnimation', root, setPlayerAnimation)

addEvent('bgoMTA->#killPed', true)
addEventHandler('bgoMTA->#killPed', root, function(player)
	setElementHealth(player, 0)
end)

addEvent('bgoMTA->#destroyBlipS', true)
addEventHandler('bgoMTA->#destroyBlipS', root, function(marker)
	-- setElementHealth(player, 0)
	triggerClientEvent(root, 'bgoMTA->#destroyBlip', root)
end)


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



function removeritems(player)
	for a,b in ipairs(weaponID) do
	if exports['bgo_items']:hasItemS(player, b) then 
	exports['bgo_items']:takePlayerItemToID(player, b, true)	
	sleep(100)
	end
	end
	print("Items do usuário "..getPlayerName(player).." apagado com sucesso");
end


function removeritemsVIP(player)
	for a,b in ipairs(weaponVIP) do
	if exports['bgo_items']:hasItemS(player, b) then 
	exports['bgo_items']:takePlayerItemToID(player, b, true)	
	sleep(100)
	end
	end
	print("Items VIP do usuário "..getPlayerName(player).." apagado com sucesso");
end



addEvent('bgoMTA->#spawnPed', true)
addEventHandler('bgoMTA->#spawnPed', root, function(player)

		local lv = tonumber(getElementData(player, "Sys:Level" ) or 0)
		if lv < 4 then
		exports.bgo_hud:dm("Para entrar em Los Santos você precisa emitir o passaporte na prefeitura",player, 255, 255, 255)
		exports.bgo_hud:dm("Você está com level abaixo de 4 e foi transferido para las venturas!", player, 255, 255, 255)
		spawnPlayer(player, 2416.981, 2352.757, 10.82, 0, 0, 0, 0)
		else
		local skin = getElementModel(player)
		spawnPlayer(player, 815.71533203125,-1096.6566162109,25.790239334106, 0, skin, 0, 0)
		end
		
	--setElementDimension(player, math.random(1,9999))
	setElementDimension(player, 0)
	
	setElementAlpha(player, 255)
	--setTimer(setElementPosition,10000,1,player, 815.71533203125,-1096.6566162109,25.790239334106)
	--setTimer(setElementDimension,10000,1,player, 0)

	

	--_call(removeritems, player)
	
	
	exports.bgo_admin:iniciarRemocaoItems(player)
		
		
		
	setElementData(player , 'char:hunger' , 20)
	setElementData(player , 'char:thirst' , 20)
	setElementData(player, 'dead.info', false )
	
	if isTimer(tempo[player]) then
	killTimer(tempo[player])
	end
	
	setElementHealth ( player, 100 )
	setElementData(player,"char:moneysujo", 0)

	--setElementData(player, "BlockTecla", false)
	--setPlayerVoiceIgnoreFrom ( player, nil)

	--local empty = exports.bgo_voice:getNextEmptyChannel() 
	--exports.bgo_voice:setPlayerChannel(player, empty)  
	
	
	--exports.bgo_voice:setPlayerVoiceMuted ( player, false )
	
	setElementData(player, 'PlayerCaido', false)
	--setElementData(player, "char:money", tonumber(getElementData(player, "char:money") or 0) - (math.floor(getElementData(player, "char:money")/2)))

	if tonumber(getElementData(player, "char:money") or 0) > 500 then
	setElementData(player, "char:money", 0)
	end

	
	
	if not exports.serialVip:isPlayerVip(player) then
	--_call(removeritemsVIP, player)
	
	exports.bgo_admin:iniciarRemocaoItemsVIP(player)
	
	
	end




end)

addEvent('bgoMTA->#startPlaySound', true)
addEventHandler('bgoMTA->#startPlaySound', root, function(vehicle, state)
	triggerClientEvent(root, 'bgoMTA->#playSound', vehicle, state)
end)

addEvent("bgoMTA->#openDoor", true)
addEventHandler("bgoMTA->#openDoor", root, function(vehicle, door)
	if getVehicleDoorOpenRatio(vehicle, door) == 0 then
		setVehicleDoorOpenRatio(vehicle, door, 1, 800)
	else
		setVehicleDoorOpenRatio(vehicle, door, 0, 800)
	end
end)

addEvent("bgoMTA->#stopEngine", true)
addEventHandler("bgoMTA->#stopEngine", root, function(vehicle)
	setVehicleEngineState(vehicle, false)
	setElementData(vehicle, "engine", 0, false)
end)

addEvent("bgoMTA->#messagetoFireman", true)
addEventHandler("bgoMTA->#messagetoFireman", root, function(player, ID)
	if not state then 
		--exports["bgo_groups"]:SendMessageToTeam (ID, "#D75656[bombeiros]: #ffffffUm acidente aconteceu com urgência na Cidade! #F7CA18Enviamos as coordenadas no radar!", 231, 217, 176,true)
		triggerClientEvent(root, 'bgoMTA->#createMarkerAndBlip', player)
		state = true
		setTimer(function() state = false end, 300, 1)
	end
end)

addEvent("bgoMTA->#setFrozen", true)
addEventHandler("bgoMTA->#setFrozen", root, function(vehicle, state)
	setElementFrozen(vehicle, state)
	if not state then 
		setElementData(vehicle, 'car->stuck', false)
	end
end)

addEvent("bgoMTA->#setVisible", true)
addEventHandler("bgoMTA->#setVisible", root, function(vehicle, doorNumber)
	setVehicleLocked(vehicle, false)
	setVehicleDoorState (vehicle, doorNumber, 4)
	setElementData(vehicle, 'car->stuckDoor' ..doorNumber, false)
end)

addEvent("bgoMTA->#removePlayerVehicle", true)
addEventHandler("bgoMTA->#removePlayerVehicle", root, function(player, warpedPlayer)
	  local x,y,z = getElementPosition(warpedPlayer)
	  setElementPosition(player, x,y,z)
	  removePedFromVehicle(player)
	  setElementData(player, 'char->stuck', false)
	  setPlayerAnimation(player, "BEACH", "ParkSit_M_loop", 1, true)
	  createPedToPlayer(player)
end)

addEvent("bgoMTA->#removePlayerToVehicle", true)
addEventHandler("bgoMTA->#removePlayerToVehicle", root, function(player, warpedPlayer)
	removePedFromVehicle(player)
	setTimer(function()
		createPedToPlayer(player)
	end, 100, 1)
end)

addEventHandler( "onPlayerSpawn", getRootElement(), function()
	if isElement(createdeadPed[source]) then
		detachElements ( createdeadPed[source] )
		local x, y, z = getElementPosition(source)
		if isTimer(tempo[source]) then
		killTimer(tempo[source])
		end
		setElementData(source, 'dead.info', false )
		setElementAlpha(source, 255)
		--triggerClientEvent(source, 'btcMTA->#loadItemToClient', source, {})
		--setPlayerVoiceIgnoreFrom ( source, nil)
		--local empty = exports.bgo_voice:getNextEmptyChannel() 
		--exports.bgo_voice:setPlayerChannel(source, empty)  
		--exports.bgo_voice:setPlayerVoiceMuted ( source, false )
		setElementData(source, "BlockTecla", false)
		setPlayerVoiceIgnoreFrom ( source, source) 
		setElementData(source, 'PlayerCaido', false)
		setElementPosition(source, x, y, z+1)
		setTimer(function(source)
			destroyElement(createdeadPed[source])
		end, 100, 1, source)
	end	
end)

addEventHandler( "onPlayerQuit", getRootElement(), function()
	if isElement(createdeadPed[source]) then 
		setTimer(function(source)
			detachElements ( createdeadPed[source] )
			destroyElement(createdeadPed[source])
		end, 100, 1, source)
	end	
end)

function logMe( message )
	local logMeBuffer = getElementData(getRootElement(), "killog") or { }
	local r = getRealTime()
	exports.global:sendMessageToAdmins(message)
	table.insert(logMeBuffer,"["..("%02d:%02d"):format(r.hour,r.minute).. "] " ..  message)
	if #logMeBuffer > 30 then
		table.remove(logMeBuffer, 1)
	end
	setElementData(getRootElement(), "killog", logMeBuffer)
end

function startBleeding(attacker, weapon, bodypart)
	local health = getElementHealth(source)
	local bleeding = getElementData(source, "bleeding")
	if (health<=20) and (health>0) and (bleeding~=1) then
		setElementData(source, "bleeding", 1, false)
		--exports.global:sendLocalMeAction(source, "começou a sangrar.")
		setTimer(bleedPlayer, 3000, 1, source, getPlayerName(source))
	end
end
--addEventHandler("onPlayerDamage", getRootElement(), startBleeding)


function bleedPlayer(thePlayer, playerName)
	if (isElement(thePlayer)) then -- still logged in & playing
		if (playerName==getPlayerName(thePlayer)) then -- make sure they havent changed character
			local health = getElementHealth(thePlayer)
			if (health<=20) and (health>0) then
				setElementHealth(thePlayer, health-2)
				setTimer(bleedPlayer, 60000, 1, thePlayer, playerName)
			else
				setElementData(thePlayer, "bleeding", 0, false)
			end
		end
	end
end





local playerInjuries = {} -- create a table to save the injuries

function copy( t )
	local r = {}
	if type(t) == 'table' then
		for k, v in pairs( t ) do
			r[k] = v
		end
	end
	return r
end

function isMelee( weapon )
	return weapon and weapon <= 15
end

function killknockedout(source)
	setElementHealth(source, 0)
end


function animacao(source)
	--setElementHealth(source, 0)
			setPedAnimation( source, "CRACK", "crckidle2", -1, true, false, true)
end

local playerInjuries2 = {}

function knockout()
	if not isTimer( playerInjuries[source] ) then
		--exports['bgo_info']:createDebugNotification(source, "Você perdeu sua consciência!", "error")
		exports['bgo_info']:addNotification(source, "Você perdeu sua consciência!", "info")
		toggleAllControls(source, false, true, false)
		--fadeCamera(source, false, 120)
		--playerInjuries[source]['knockout'] = setTimer(killknockedout, 120000, 1, source)
		
		playerInjuries[source] = setTimer(animacao, 500, 20, source)
		
		--setTimer(setPedAnimation, 500, 20 source, "CRACK", "crckidle2", -1, true, false, true)
		
		--setPedAnimation( source, "CRACK", "crckidle2", -1, true, false, true)
		--setElementData(source, "injuriedanimation", true)
		

		

		setTimer(toggleAllControls, 11000, 1, source, true, true, true)
		
		setTimer(setElementFrozen, 11000, 1, source, true)
		setTimer(setElementFrozen, 12000, 1, source, false)
		
		
		
		playerInjuries2[source] = setTimer(function()
		
		if isTimer(playerInjuries[source]) then
		killTimer(playerInjuries[source])
		
		end
		--playerInjuries2[source] = nil
		--toggleAllControls(source, true, true, true)
		--setElementFrozen(source, true)
		--setTimer(setElementFrozen, 1000, 1, source, false)
		--setElementFrozen(source, false)
		--setElementData(source, "injuriedanimation", false)
		--setPedAnimation(source)
		end,10000,1, source)
		

	end
end



function injuries(attacker, weapon, bodypart, loss)
	if not loss or loss < 0.5 then
		return
	end
	-- if weapon == 23 then 
		-- setElementHealth(source, getElementHealth(source) + loss) 
	-- end
	-- drowning
	--[[
	if weapon == 53 then
		return
	end
	-- source = player who was hit
	if not bodypart and getPedOccupiedVehicle(source) then
		bodypart = 3
	end
	-- BODY ARMOR
	
	if ( bodypart == 3 or bodypart == 9 ) and getPedArmor(source) > 0 then -- GOT (torso/head) PROTECTION?
		cancelEvent()
		return
	end
	
	-- katana kill
	if weapon == 8 then
		setPedHeadless(source, true)
		killPed(source, attacker, weapon, bodypart)
		return
	end
	]]--
	-- 2% chance of melee knockout
	if isMelee( weapon ) then
		if math.random( 1, 20 ) == 1 then
		
			knockout()
			
		end
		return
	end
	--[[
	-- if we have injuries saved for the player, we add it to their table
	local injuredBefore = copy( playerInjuries[source] )
	if playerInjuries[source] then
		playerInjuries[source][bodypart] = true
	else
		-- create a new table for that player
		playerInjuries[source] = { [bodypart] = true } -- table
	end
	if ( bodypart == 3 and loss >= 15 ) or bodypart == 7 or bodypart == 8 then -- damaged either left or right leg
		if bodypart == 3 then
			bodypart = math.random( 7, 8 )
			if not injuredBefore[bodypart] then
			    exports['bgo_info']:createDebugNotification(source, "Você quebrou o pé " .. ( bodypart == 7 and "esquerda" or "direito" ) .. "!", "error")
				setElementData(source, 'injured', true)
			end
			playerInjuries[source][bodypart] = true
			
		elseif not injuredBefore[bodypart] then
			--exports['bgo_info']:createDebugNotification(source, "Você acertou o pé " .. ( bodypart == 7 and "esquerda" or "direito" ) .. "", 1)
			setElementData(source, 'injured', true)
		end
		
		if playerInjuries[source][7] and playerInjuries[source][8] then -- both were already hit
			toggleControl(source, 'forwards', false) -- disable walking forwards for the player who was hit
			toggleControl(source, 'left', false)
			toggleControl(source, 'right', false)
			toggleControl(source, 'backwards', false)
			toggleControl(source, 'enter_passenger', false)
			toggleControl(source, 'enter_exit', false)
			setElementData(source, 'injured', true)
		end
		-- we can be sure at least one of the legs was hit here, since we checked it above
		toggleControl(source, 'sprint', false) -- disable running forwards for the player who was hit
		toggleControl(source, 'jump', false) -- tried jumping with broken legs yet?
	elseif bodypart == 5 or bodypart == 6 then -- damaged either arm
		if playerInjuries[source][5] and playerInjuries[source][6] then -- both were already hit
			toggleControl(source, 'fire', false) -- disable firing weapons for the player who was hit
		end
		toggleControl(source, 'aim_weapon', false) -- disable aiming for the player who was hit (can still fire, but without crosshair)
		toggleControl(source, 'jump', false) -- can't climb over the wall with a broken arm
		setElementData(source, 'injured', true)
		exports['bgo_info']:createDebugNotification(source, "Você acertou o " .. ( bodypart == 5 and "esquerda" or "direito" ) .. " sua mão!", "error")

		elseif bodypart == 9 then -- headshot
		if not attacker or weapon ~= 23 or getElementData(attacker, "deaglemode") ~= 0 then
			setPedHeadless(source, true)
			killPed(source, attacker, weapon, bodypart)
			return
		end]]--
	--end	
	if ( getElementHealth(source) < 20 or ( isElement( attacker ) and getElementType( attacker ) == "vehicle" and getElementHealth(source) < 40 ) ) and math.random( 1, 3 ) <= 2 then
		knockout()
	end
end
addEventHandler( "onPlayerDamage", getRootElement(), injuries )


function getPlayerInjured(player)
	if playerInjuries[player] and (playerInjuries[player][5] or playerInjuries[player][6]) then 
		return true
	end
	return false
end
addEvent('bgoMTA->#getPlayerInjured', true)
addEventHandler('bgoMTA->#getPlayerInjured', root, getPlayerInjured)



--[[
addCommandHandler( "fakedesacordado",
	function(thePlayer, command, weapon, bodypart, loss)
		--if exports.global:isPlayerAdmin(thePlayer) then
			source = thePlayer
			loss = tonumber(loss)
			setElementHealth(thePlayer, math.max(0, getElementHealth(thePlayer) - loss))
			injuries(nil, tonumber(weapon), tonumber(bodypart), loss)
		--end
	end
)
]]--


function stabilize()
	if playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source]['knockout'] then
			setElementData(source, "injuriedanimation", false)
			if isTimer(playerInjuries[source]['knockout']) then
				killTimer(playerInjuries[source]['knockout'])
				playerInjuries[source]['knockout'] = nil
				fadeCamera(source, true, 2)
				setPedAnimation(source)
				--setPedAnimation(source)
				setPedAnimation(source)
				toggleControl(source, 'forwards', true)
				toggleControl(source, 'left', true)
				toggleControl(source, 'right', true)
				toggleControl(source, 'backwards', true)
				toggleControl(source, 'enter_passenger', true)
				setElementHealth(source, math.max( 20, getElementHealth(source) ) )
			end
		end
		if playerInjuries[source][7] and playerInjuries[source][8] then
			toggleControl(source, 'forwards', true)
			toggleControl(source, 'left', true)
			toggleControl(source, 'right', true)
			toggleControl(source, 'backwards', true)
			toggleControl(source, 'enter_passenger', true)
		end
	end
end
addEvent( "onPlayerStabilize", false )
addEventHandler( "onPlayerStabilize", getRootElement(), stabilize )

function examine(to)
	local name = getPlayerName(source):gsub("_", " ")
	if isPedDead(source) then
	--	outputChatBox(name .. " halott.", to, 255, 0, 0)
	elseif playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source]['knockout'] then
	--		outputChatBox(name.. " kiütve.", to, 255, 255, 0)
		end
		if playerInjuries[source][7] and playerInjuries[source][8] then
	--		outputChatBox("Mindkét lába " .. name .. "-nak/nek el van törve.", to, 255, 255, 0)
		elseif playerInjuries[source][7] then
	--		outputChatBox(name .. "bal lába el van törve.", to, 255, 255, 0)
		elseif playerInjuries[source][8] then
	--		outputChatBox(name .. " jobb lába el van törve.", to, 255, 255, 0)
		end
		if playerInjuries[source][5] and playerInjuries[source][6] then
	--		outputChatBox("Mindkét keze " .. name .. "-nak/nek el van törve.", to, 255, 255, 0)
		elseif playerInjuries[source][5] then
	--		outputChatBox(name .. " bal keze el van törve.", to, 255, 255, 0)
		elseif playerInjuries[source][6] then
	--		outputChatBox(name .. " jobb keze el van törve.", to, 255, 255, 0)
		end
	else
	--	outputChatBox(name .. " nincs megsérülve.", to, 255, 255, 0)
	end
end
addEvent( "onPlayerExamine", false )
addEventHandler( "onPlayerExamine", getRootElement(), examine )



function healInjuries(healed)
	if playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source]['knockout'] then
			setElementData(source, "injuriedanimation", false)
			if isTimer(playerInjuries[source]['knockout']) then
				killTimer(playerInjuries[source]['knockout'])
				playerInjuries[source]['knockout'] = nil
				if healed then
					fadeCamera(source, true, 2)
					setPedAnimation(source)
					setPedAnimation(source)
				end
			end
			toggleAllControls(source, true, true, false)
		else
			if playerInjuries[source][7] and playerInjuries[source][8] then
				toggleControl(source, 'forwards', true) -- disable walking forwards for the player who was hit
				toggleControl(source, 'left', true)
				toggleControl(source, 'right', true)
				toggleControl(source, 'backwards', true)
				toggleControl(source, 'enter_passenger', true)
				toggleControl(source, 'enter_exit', true)
			end
			if playerInjuries[source][7] or playerInjuries[source][8] then
				toggleControl(source, 'sprint', true)
				toggleControl(source, 'jump', true)
			end
			if playerInjuries[source][5] and playerInjuries[source][6] then
				toggleControl(source, 'fire', true)
			end
			if playerInjuries[source][5] or playerInjuries[source][6] then
				toggleControl(source, 'aim_weapon', true)
				toggleControl(source, 'jump', true)
			end
		end
		playerInjuries[source] = nil
	end
end
addEvent( "onPlayerHeal", false ) -- add a new event for it (called from /heal)
addEventHandler( "onPlayerHeal", getRootElement(), healInjuries)

function restoreInjuries( )
	if playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source][7] and playerInjuries[source][8] then
			toggleControl(source, 'forwards', false)
			toggleControl(source, 'left', false)
			toggleControl(source, 'right', false)
			toggleControl(source, 'backwards', false)
			toggleControl(source, 'enter_passenger', false)
			toggleControl(source, 'enter_exit', false)
		end
		if playerInjuries[source][7] or playerInjuries[source][8] then
			toggleControl(source, 'sprint', false)
			toggleControl(source, 'jump', false)
		end
		if playerInjuries[source][5] and playerInjuries[source][6] then
			toggleControl(source, 'fire', false)
		end
		if playerInjuries[source][5] or playerInjuries[source][6] then
			toggleControl(source, 'aim_weapon', false)
			toggleControl(source, 'jump', false)
		end
	end
end
addEventHandler( "onPlayerStopAnimation", getRootElement(), restoreInjuries )

function resetInjuries() -- it actually has some parameters, but we only need source right now - the wiki explains them though
	setPedHeadless(source, false)
	if playerInjuries[source] then
		-- reset injuries
		healInjuries()
	end
end

--addEventHandler( "onPlayerSpawn", getRootElement(), resetInjuries) -- make sure old injuries don't carry over
--addEventHandler( "onPlayerQuit", getRootElement(), resetInjuries) -- cleanup when the player quits
