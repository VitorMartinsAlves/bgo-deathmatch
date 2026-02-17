

local con = exports.bgo_mysql:getConnection()

--[[
local randomPos = {
     {2248.347, 2468.803, 10.83},
     {2244.01, 2469.02, 10.83},
     {2248.807, 2456.032, 10.836},
}
]]--

local randomPos = {
     {3053.8581542969,-1972.6236572266,11.06875038147},
     {3052.5766601563,-1960.96875,11.06875038147},
     {3050.4875488281,-1993.8082275391,11.06875038147},
}



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
	56,
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
}

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


function prendendo(thePlayer, targetPlayer, timerP, reason)
	local reason = table.concat({reason}, " ")
    if getElementData(targetPlayer, "VIP") then
	     ido = tonumber(timerP) / 2
		 ido = math.floor(ido)
	else
	     ido = tonumber(timerP)
	end
	setElementData(targetPlayer, "player:preso", true)
	setElementData(targetPlayer,"char:moneysujo", 0)
	if getElementData(targetPlayer, "VIP") then
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 " .. getPlayerName(thePlayer) .. "#ffffff Prendeu #7cc576" .. getPlayerName(targetPlayer) .. " #ffffffpor #1a75ff" .. ido .. "#ffffff anos.", root ,255, 255, 255, true)
	outputChatBox("#dc143c[Decreto]:#FFFFFF Pelo fato do preso ser VIP a sentença foi alterada: #dc143c"..tonumber(timerP).." anos #ffffffpara #dc143c" .. ido .. " anos", root ,255, 255, 255, true)
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 Motivo:#ffffff Os artigos do preso se encontram em sigilo.", root ,255, 255, 255, true)
	else
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 " .. getPlayerName(thePlayer) .. "#ffffff Prendeu #7cc576" .. getPlayerName(targetPlayer) .. " #ffffffpor #1a75ff" .. ido .. "#ffffff anos.", root ,255, 255, 255, true)
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 Motivo:#ffffff " .. reason, root ,255, 255, 255, true)
	end
    --if not exports.serialVip:isPlayerVip(targetPlayer) then
	--end
	takeAllWeapons(targetPlayer)
	
	--_call(removeritems, targetPlayer)
	
	exports.bgo_admin:iniciarRemocaoItems(targetPlayer)
	
	if not exports.serialVip:isPlayerVip(targetPlayer) then
	--_call(removeritemsVIP, targetPlayer)
	exports.bgo_admin:iniciarRemocaoItemsVIP(targetPlayer)
	end

	local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
	local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
	if isTimer(theTimerCheck) then
		killTimer(theTimerCheck)
	end
	if isTimer(theTimerCheck2) then
		killTimer(theTimerCheck2)
	end
	if isPedInVehicle(targetPlayer) then
		removePedFromVehicle(targetPlayer)
	end
	setElementData(targetPlayer, "player:preso", true)
	fadeCamera(targetPlayer, false, 1.0)
	setElementFrozen(targetPlayer, true)
	if isPedInVehicle(targetPlayer) then
		toggleAllControls(targetPlayer, false, false, false)
	end
	if (getElementData(targetPlayer, "algemado")) then
	     setElementData(targetPlayer, "algemado", false)
	end
	setTimer(function()
		triggerClientEvent(targetPlayer, "triggerAdminjail", targetPlayer, thePlayer, reason, ido, 1, false)
	end, 500, 1)
	setTimer( function()
	    pos = math.random(#randomPos)
		local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
		local theTimer = setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
		local idoTelikMentes = setElementData(targetPlayer, "idoTelik", ido)
		local idoLetelt = setElementData(targetPlayer, "idoLetelt", 0)
		setElementPosition(targetPlayer, randomPos[pos][1], randomPos[pos][2], randomPos[pos][3])
		setElementInterior(targetPlayer, 0)
		setElementDimension(targetPlayer, 0)
		local adminjailed = setElementData(targetPlayer, "adminjail", 1)
		local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", reason)
		local alapido = setElementData(targetPlayer, "adminjail:ido", ido)
		local admin = setElementData(targetPlayer, "adminjail:admin", getPlayerName(thePlayer))
		local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", getPlayerSerial(thePlayer))
	end, 1500, 1)
	local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 1, reason, ido, ido, getPlayerName(thePlayer), getPlayerSerial(thePlayer))

					
	setTimer(function()
		fadeCamera(targetPlayer, true, 2.5)
		setElementFrozen(targetPlayer, false)
		toggleAllControls(targetPlayer, true, true, true)
	end, 7500, 1)
end
addEvent ("prendendoLV",true)
addEventHandler ("prendendoLV", root,  prendendo)



function idoTelikLe(targetPlayer)
	if isElement(targetPlayer) and (getElementType(targetPlayer) == "player") then
		local idoTelik = tonumber(getElementData(targetPlayer, "idoTelik")) or false
		local idoLetelt = tonumber(getElementData(targetPlayer, "idoLetelt")) or false
		if (idoTelik) and (idoLetelt) then
			setElementData(targetPlayer, "idoTelik", idoTelik-1)
			setElementData(targetPlayer, "idoLetelt", idoLetelt+1)
			if (idoTelik) <= 1 then
				outputChatBox("Sua sentença expirou e Você foi solto!.", targetPlayer, 255, 255, 255, true)
				setElementData(targetPlayer, "player:preso", false)
 				setElementFrozen(targetPlayer, false)
				local theTimer = getElementData(targetPlayer, "adminjail:theTimer")
				if not (theTimer) then
					return false
				end
				--killTimer(theTimer)
							if (theTimerCheck) then
								killTimer(theTimerCheck)
								setElementData(targetPlayer, "adminjail:timer", false)
							end
							if (theTimerCheck2) then
								killTimer(theTimerCheck2)
								setElementData(targetPlayer, "adminjail:theTimerAccounts", false)
							end	
				setElementData(targetPlayer, "adminjail:theTimer", false)
				local adminjailed = setElementData(targetPlayer, "adminjail", false)
				local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", false)
				local alapido = setElementData(targetPlayer, "adminjail:ido", false)
				local admin = setElementData(targetPlayer, "adminjail:admin", false)
				local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", false)
				local idoTelikVege = setElementData(targetPlayer, "idoTelik", false)
				local idoLeteltVege = setElementData(targetPlayer, "idoLetelt", false)
				--local setPosition = setTimer(setElementPosition, 2000, 1,targetPlayer, 2335.993, 2479.078, 14.979)
				local setPosition = setTimer(setElementPosition, 2000, 1,targetPlayer, 2940.6088867188,-1964.1695556641,11.06875038147)
				
				
				local setInterior = setElementInterior(targetPlayer, 0)
				local setDimension = setElementDimension(targetPlayer, 0)

								--sql
								local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)

								
			end
		end
	end
end

--addEventHandler("onColShapeHit", prision, exitZ)

local randomPos2 = {
     {3053.8581542969,-1972.6236572266,11.06875038147},
     {3052.5766601563,-1960.96875,11.06875038147},
     {3050.4875488281,-1993.8082275391,11.06875038147},
}

         local prisionadmin = createColCuboid(2994.54248, -2053.73438, 7.39407, 82.7041015625, 159.36938476563, 32.900001907349)
		 
  --local prisionadmin = createColCuboid(2237.99146, 2454.12451, 7.37939, 12.681884765625, 16.994384765625, 8.1000150680542)
function exitZprisionadmin (thePlayer)

    	 if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then 
	 outputChatBox("#FFA000[BGO INFO] #FFFFFFVocê entrou nas celas da prisão", thePlayer, 255,255,255, true)
	 return end
	 
		if getElementData(thePlayer, "adminjail") == 1 then
	     pos2 = math.random(#randomPos2)
         outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê ainda está preso!, Aguarde.", thePlayer, 255,255,255, true)
		 setElementPosition(thePlayer, randomPos2[pos2][1], randomPos2[pos2][2], randomPos2[pos2][3])

		 else
		 setElementPosition(thePlayer, 2933.4831542969,-1964.9561767578,11.129687309265)
		 
		 
		setElementInterior(thePlayer, 0)
		setElementDimension(thePlayer, 0)
	 end
end
addEventHandler("onColShapeLeave", prisionadmin, exitZprisionadmin)

addEventHandler("onColShapeHit", prisionadmin, exitZ)