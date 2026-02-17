local con = exports.bgo_mysql:getConnection()

-- 1º BPM RADIO PTR RIO
local pdDutyPlace = createColSphere(2558.052, -2593.58, 13.794, 3)

-- Mecanico
local szereloDuty = createColSphere(2661.1433105469,-1430.2841796875,30.484001159668, 3)

-- SAMU
local mentoDuty = createColSphere(2495.1, 919.935, 11.023,3)

-- PMERJ NOVA				
--local navDuty = createColSphere(2493.376, -2517.004, 13.658,3)

-- MARINHA  RIO
local tekDuty = createColSphere(2839.614, -2484.526, 11.806,3)

-- Taxi
local TAXI = createColSphere(1267.7454833984,-1675.8754882813,13.88413143158,3)

-- FORÇA NACIONA RIO
local cabron = createColSphere(2779.419, -2346.947, 13.694,3)

-- OsCria
local oscria = createColSphere(2321.8664550781,-1245.2320556641,27.9765625,2)


-- DETRAN
local DETRAN = createColSphere(2468.072265625,-2105.4484863281,13.546875,3) --JUIZ

-- BOPE RIO
local PMPE = createColSphere(2661.274, -2363.808, 13.694,3)


--PCC RIO
local ODR = createColSphere(1132.292, -2037.284, 69.008,3) --ODR

-- CHOQUE RIO
local civil = createColSphere(2434.521, -2373.803, 13.694,3)


-- CV
--local comandovermelho = createColSphere(2418.4567871094,-830.74926757813,115.16874694824,3) 
local comandovermelho = createColSphere(2458.892, -941.773, 80.655,3)

-- RECOM RIO
local PMERJ = createColSphere(2554.975, -2434.175, 13.694,3)

--RODO RIO
local SKS = createColSphere(2396.827, -1703.095, 13.455,3)

--MLC RIO
local Milicia = createColSphere(760.315, -574.645, 20.613,3)

--FDN RIO   MOVER AINDA
local ada = createColSphere(2791.056, -1319.958, 34.8,3)


-- JUIZ
--local JUIZ = createColSphere(211.32188415527,188.91668701172,1003.03125,3)
--setElementDimension(JUIZ, 1)
--setElementInterior(JUIZ, 3)


--ADA RIO  
local PCC = createColSphere(-164.739, -1710.206, 2.855, 3)



-- POLICIA FEDERAL RIO
local PF = createColSphere(1579.615, -1635.507, 13.561, 3)


-- 7 BATALHÃO DE RADIO PATRULHA
local FN = createColSphere(2380.409, -2519.211, 13.694, 3)

-- BDM RIO
local TCP = createColSphere(953.296, -870.195, 95.455, 3)



-- 6  BATALHÃO DE RADIO PATRULHA
local ROTAM = createColSphere(2404.934, -2636.789, 13.694, 3)

--local PC = createColSphere(2487.677, -2658.344, 13.653, 3)


--UPP RIO
local ForcaNacional = createColSphere(615.482, -610.617, 17.227, 3)


-- policia civil rio CORE
local PMMG = createColSphere(2745.515, -2471.671, 13.694, 3)


-- erado
--local grovestreet = createColSphere(297.096, -1151.345, 81.055, 3)

-- ODR RIO MOVER
local osballas = createColSphere(297.096, -1151.345, 81.055, 3)

--MOTO CLUB RIO
local losG = createColSphere(1264.665, 308.042, 19.655, 3)


-- EXERCITO RIO
local PMMG2 = createColSphere(2795.793, -2560.16, 13.694, 3)

local factionNames = {
	[1]="D.R.V.V",
	[2]="PC",
	[3]="Mecanico",
	[4]="Samu",
	[5]="Rota Comando",
	[6]="Pmerj",
	[7]="ODR",
	[8]="Comando vermelho",
	[9]="JUIZ",
	[10]="Primeiro Comando da Capital",
	[11]="Policia Federal",
	[12]="Taxi",
	[13]="Grove Street",
	[16]="PMERJ",
	[17]="BAEP",
	[18]="OS BALLAS",
	[19]="Força Tática",
	[20]="Policia Militar",
	[21]="Policia Civil",
	[22]="ROTAM",
}


function sendGroupMessage(factionid, msg)
	for k, v in ipairs(getElementsByType("player")) do
	
		if exports.bgo_dashboard:isPlayerInFaction(v, tonumber(factionid))  then
			outputChatBox("#F9BF3B[" .. factionNames[factionid] .. "]#ffffff " .. msg, v, 255, 255, 255, true)
		end
	end
end
addEvent("sendGroupMessage", true)
addEventHandler("sendGroupMessage", root, sendGroupMessage)

function sendGroupMessageWithoutPlayer(player, factionid, msg)
	for k, v in ipairs(getElementsByType("player")) do
	
		--if exports.bgo_dashboard:isPlayerInFaction(v, factionid)  and getPlayerName(v) ~= getPlayerName(player) then
			outputChatBox("#F9BF3B[" .. factionNames[factionid] .. "]#ffffff " .. msg, v, 255, 255, 255, true)
		--end
	end
end

---------------------------------------------------------------------------------------------------------------

atmCooldown = {}
local atmBag = {}
local atmBagColShape = {}
local atmTimer = {}
local atmSerial = {}
ATM_TIMEOUT = 600000*1

function atmSetTimeOut2 ( player, time )
    atmCooldown[player] = setTimer( 
    function (player) 
    atmCooldown[player] = nil 
    end, time, 1, player)
end

addEventHandler("onPlayerQuit", root,
    function ()
        if ( atmGetTimeOut2(source) ) then
            atmSerial[getPlayerSerial(source)] = atmGetTimeOut2(source)
        end
    end
)

addEventHandler("onPlayerJoin", root,
    function ()
        for serial, cooldown in pairs ( atmSerial ) do
            if ( getPlayerSerial(source) == serial ) then
                atmSetTimeOut2(source, cooldown*1000)
                atmSerial[serial] = nil
            end
        end
    end
)

function atmGetTimeOut2 ( player )
    if isTimer ( atmCooldown[player] ) then
        local miliseconds = getTimerDetails ( atmCooldown[player] )
        return math.ceil( miliseconds / 1000 )
    else
        return false
    end
end

function atmIsAbleToRob2 ( player )
    return not isTimer(atmCooldown[player])
end

---------------------------------------------------------------------------------------------------------------

local rootTable = {}

function dutyPlayers(player, commandName)

	if isTimer(timer) then 
		exports.bgo_infobox:addNotification(player,"Provavelmente você está usando o /trabalhar muitas vezes ( paciência amigo )","error")
		return end
	timer = setTimer(function() end, 3000, 1)


	local duty = getElementData(player, "char:duty") or false
	if isElementWithinColShape(player, JUIZ) and getElementDimension(player) == getElementDimension(JUIZ) then

		if exports.bgo_dashboard:isPlayerInFaction(player , 9) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("JUIZ")) then
			if getElementData(player, "char:dutyfaction") ~= 9 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 247
			if not duty then
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 9)
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)			
				setPedArmor(player, 100)

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar no PORTE DE ARMAS")

				else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, 0)
				setElementFrozen(player, false)
				setPedArmor(player, 0)

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair do PORTE DE ARMAS")

			end
		end
	end

	if isElementWithinColShape(player, ada) and getElementDimension(player) == getElementDimension(ada) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 15) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CDM")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 14) then


		if getElementData(player, "char:dutyfaction") ~= 14 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc153c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 105
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 14)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na FDN")
			--setElementData(player, "job", "cartel los manitos")
			--triggerClientEvent(player, "seurankG", player, tonumber(14))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 154, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da FDN")
			setElementData(player, "job", "SemEmprego")
		end
	end
end

	if isElementWithinColShape(player, Milicia) then --and getElementDimension(player) == getElementDimension(Milicia) then
		if exports.bgo_dashboard:isPlayerInFaction(player , 26) then
		if getElementData(player, "char:dutyfaction") ~= 26 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc153c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 106
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 26)
			setElementData(player, "duty:civilskin", getElementModel(player))
			if getElementData(player, "char:id") == 4 then
			setElementModel(player, 200)
			else
			setElementModel(player, dutySkin)
			end
			setElementFrozen(player, false)			
			setPedArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na MLC")
			--setElementData(player, "job", "cartel los manitos")
			--triggerClientEvent(player, "seurankG", player, tonumber(26))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 154, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da MLC")
			setElementData(player, "job", "SemEmprego")
		end
	end
end

	if isElementWithinColShape(player, SKS) and getElementDimension(player) == getElementDimension(SKS) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 15) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CDM")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 25) then


		if getElementData(player, "char:dutyfaction") ~= 25 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc153c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 109
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 25)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na RODO")
			--setElementData(player, "job", "cartel los manitos")
			--triggerClientEvent(player, "seurankG", player, tonumber(25))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 154, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da RODO")
			setElementData(player, "job", "SemEmprego")
		end
	end
end



	if isElementWithinColShape(player, oscria) and getElementDimension(player) == getElementDimension(oscria) then

		if exports.bgo_dashboard:isPlayerInFaction(player , 27) then


		if getElementData(player, "char:dutyfaction") ~= 27 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc153c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 195
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 27)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar no os cria")
			--setElementData(player, "job", "cartel los manitos")
			--triggerClientEvent(player, "seurankG", player, tonumber(25))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 154, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair do os cria")
			setElementData(player, "job", "SemEmprego")
		end
	end
end






	
	if isElementWithinColShape(player, grovestreet) and getElementDimension(player) == getElementDimension(grovestreet) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CV")) then
	
	
			if exports.bgo_dashboard:isPlayerInFaction(player , 13) then

			if getElementData(player, "char:dutyfaction") ~= 13 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 110




				if not duty then
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 13)
				setElementData(player, "duty:civilskin", getElementModel(player))
				--setElementModel(player, dutySkin)

				setElementModel(player, math.random(106,107))

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na TCP")


				setElementFrozen(player, false)			
				setPedArmor(player, 100)

				if ( atmIsAbleToRob2(player) ) then 
					atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end
					exports['bgo_items']:giveItem(player, 331, 1, 1, 1, true)
	
				--triggerClientEvent(player, "seurankG", player, tonumber(13))
				--setElementData(player, "job", "CoMando VerMelho")
	
			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, 0)
				setElementFrozen(player, false)
				setPedArmor(player, 100)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				takeAllWeapons(player)
				exports['bgo_items']:takePlayerItemToID(player, 84, false)
				exports['bgo_items']:takePlayerItemToID(player, 51, false)
				exports['bgo_items']:takePlayerItemToID(player, 54, false)
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da TCP")
				setElementData(player, "job", "SemEmprego")
			end
		end
	end
	
	--[[
	if isElementWithinColShape(player, AZT) and getElementDimension(player) == getElementDimension(AZT) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CV")) then
	
	
			if exports.bgo_dashboard:isPlayerInFaction(player , 24) then

			if getElementData(player, "char:dutyfaction") ~= 24 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			--local dutySkin = 107




				if not duty then
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 24)
				setElementData(player, "duty:civilskin", getElementModel(player))
				--setElementModel(player, dutySkin)
				 if (getElementData(player, "char:id") ~= 4) then
				     setElementModel(player, math.random(114, 115))
				 else
				     setElementModel(player, 116)
				 end
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar nos Aztecas")


				setElementFrozen(player, false)			
				setPlayerArmor(player, 100)

				if ( atmIsAbleToRob2(player) ) then 
					atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 44, 1, 1, 1, true)
					-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 39, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end
	
				--triggerClientEvent(player, "seurankG", player, tonumber(24))
				--setElementData(player, "job", "CoMando VerMelho")
	
			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, 0)
				setElementFrozen(player, false)
				setPlayerArmor(player, 100)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				takeAllWeapons(player)
				exports['bgo_items']:takePlayerItemToID(player, 84, 0)
				exports['bgo_items']:takePlayerItemToID(player, 44, 0)
				exports['bgo_items']:takePlayerItemToID(player, 54, 0)
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair dos Aztecas")
				setElementData(player, "job", "SemEmprego")
			end
		end
	end	
	
	]]--
	if isElementWithinColShape(player, osballas) and getElementDimension(player) == getElementDimension(osballas) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 18) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CV")) then
	
	
			if exports.bgo_dashboard:isPlayerInFaction(player , 18) then

			if getElementData(player, "char:dutyfaction") ~= 18 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 107




				if not duty then
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 18)
				setElementData(player, "duty:civilskin", getElementModel(player))
				--setElementModel(player, dutySkin)


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar Nos ODR")

 
                 setElementModel(player, math.random(107,107))

				setElementFrozen(player, false)			
				setPedArmor(player, 100)

				if ( atmIsAbleToRob2(player) ) then 
					atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
					-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end
	
				--triggerClientEvent(player, "seurankG", player, tonumber(13))
				--setElementData(player, "job", "CoMando VerMelho")
	
			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, 0)
				setElementFrozen(player, false)
				setPedArmor(player, 100)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				takeAllWeapons(player)
				exports['bgo_items']:takePlayerItemToID(player, 84, false)
				exports['bgo_items']:takePlayerItemToID(player, 51, false)
				exports['bgo_items']:takePlayerItemToID(player, 54, false)
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair dos ODR")
				setElementData(player, "job", "SemEmprego")
			end
		end
	end
	

	if isElementWithinColShape(player, DETRAN) and getElementDimension(player) == getElementDimension(DETRAN) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 1) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("DETRAN")) then

			if exports.bgo_dashboard:isPlayerInFaction(player , 1) then

			if getElementData(player, "char:dutyfaction") ~= 1 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 26
			if not duty then
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 1)
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)			
				setPedArmor(player, 100)

				exports['bgo_items']:giveItem(player, 37, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na DRVV")
				setElementData(player, "job", "GuaRda de traNsito - D.r.v.v")
				setPlayerTeam(player, getTeamFromName ( "DRVV" ))

			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, 0)
				setElementFrozen(player, false)
				setPedArmor(player, 100)

				setPlayerTeam(player, nil)
				setElementData(player, "job", "SemEmprego")
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da DRVV")
				exports['bgo_items']:RemovePlayerDutyItems(player)
				takeAllWeapons(player)
				exports['bgo_items']:takePlayerItemToID(player, 37, false)
				exports['bgo_items']:takePlayerItemToID(player, 45, false)




			end
		end
	end


	

	if isElementWithinColShape(player, TAXI) and getElementDimension(player) == getElementDimension(TAXI) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("TAXI")) then

			if exports.bgo_dashboard:isPlayerInFaction(player , 12) then

			if getElementData(player, "char:dutyfaction") ~= 12 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 235
				if not duty then
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 12)
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)	
				
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar no TAXI")

				setElementData(player, "job", "Taxi - Motorista")

			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, 0)
				setElementFrozen(player, false)
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair do TAXI")
				setElementData(player, "job", "SemEmprego")
			end
		end
	end


--[[
	if isElementWithinColShape(player, comandovermelho) and getElementDimension(player) == getElementDimension(comandovermelho) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CV")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 8) then


		if getElementData(player, "char:dutyfaction") ~= 8 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 158
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 8)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPlayerArmor(player, 100)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na CV")
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 44, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


			--setElementData(player, "job", "CoMando VerMelho")
			--triggerClientEvent(player, "seurankG", player, tonumber(8))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPlayerArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 44, 0)
			exports['bgo_items']:takePlayerItemToID(player, 54, 0)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da CV")
			setElementData(player, "job", "SemEmprego")
		end
	end
end

]]--



if isElementWithinColShape(player, PCC) and getElementDimension(player) == getElementDimension(PCC) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PCC")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 10) then


		if getElementData(player, "char:dutyfaction") ~= 10 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 102
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 10)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na ADA")
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end

			--setElementData(player, "job", "PriMeiro CoMando da Capital")
			--triggerClientEvent(player, "seurankG", player, tonumber(10))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 84, false)

			exports['bgo_items']:takePlayerItemToID(player, 54, false)

			setElementData(player, "job", "SemEmprego")
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da ADA")
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
		end
	end
end




if isElementWithinColShape(player, ODR) and getElementDimension(player) == getElementDimension(ODR) then
--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("ODR")) then

	if exports.bgo_dashboard:isPlayerInFaction(player , 7) then


	if getElementData(player, "char:dutyfaction") ~= 7 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
	local dutySkin = 108
		if not duty then
		exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
		setElementData(player, "char:duty", true)
		setElementData(player, "char:dutyfaction", 7)
		setElementData(player, "duty:civilskin", getElementModel(player))
		setElementModel(player, dutySkin)
		setElementFrozen(player, false)			
		setPedArmor(player, 100)

		exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na PCC")
		if ( atmIsAbleToRob2(player) ) then 
			atmSetTimeOut2(player, ATM_TIMEOUT)
		exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
		-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
		--setElementData(player, "balas-pistola", 200)
		exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
		else
		exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
		end





		--triggerClientEvent(player, "seurankG", player, tonumber(7))


	else
		exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
		setElementData(player, "char:duty", false)
		setElementData(player, "char:dutyfaction", false)
		--sendGroupMessage(7, getPlayerName(player):gsub("_"," ") .. " saiu do serviço.")
		setElementModel(player, getElementData(player, "duty:civilskin"))
		setElementFrozen(player, false)
		setPedArmor(player, 100)
		exports['bgo_items']:RemovePlayerDutyItems(player)
		takeAllWeapons(player)
		exports['bgo_items']:takePlayerItemToID(player, 84, false)
		exports['bgo_items']:takePlayerItemToID(player, 51, false)

		setElementData(player, "job", "SemEmprego")
		exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da PCC")
		exports['bgo_items']:takePlayerItemToID(player, 54, false)
	end
end
end

if isElementWithinColShape(player, PC) and getElementDimension(player) == getElementDimension(PC) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PF")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 2) then


		if getElementData(player, "char:dutyfaction") ~= 2 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 265
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 2)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)


			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 1º Batalhao Radio Patrulha")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end

				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)

				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 56, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				--setElementData(player, "balas-fuzil", 200)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(2))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 49, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 1º Batalhao Radio Patrulha")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end
	
if isElementWithinColShape(player, FN) and getElementDimension(player) == getElementDimension(FN) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PF")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 24) then


		if getElementData(player, "char:dutyfaction") ~= 24 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 266
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 24)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 7º Batalhao Radio Patrulha")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)

				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				--setElementData(player, "balas-fuzil", 200)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(24))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 49, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 7º Batalhao Radio Patrulha")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end	
	
	
	
	
	if isElementWithinColShape(player, PMMG2) and getElementDimension(player) == getElementDimension(PMMG2) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PF")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 28) then


		if getElementData(player, "char:dutyfaction") ~= 28 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 287
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 28)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na Exercito Brasileiro")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)
				
				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 37, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				setElementData(player, "balas-fuzil", 500)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(24))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 52, 0)
			exports['bgo_items']:takePlayerItemToID(player, 37, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da Exercito Brasileiro")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end	
	
	
	
if isElementWithinColShape(player, PMMG) and getElementDimension(player) == getElementDimension(PMMG) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PF")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 21) then


		if getElementData(player, "char:dutyfaction") ~= 21 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 280
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 21)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na Policia Civil")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 53, 1, 1, 1, true)	
                exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				-- end
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 56, 1, 1, 1, true)
				
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)


				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(21))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da Policia Civil")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end
	
if isElementWithinColShape(player, ROTAM) and getElementDimension(player) == getElementDimension(ROTAM) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PF")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 22) then


		if getElementData(player, "char:dutyfaction") ~= 22 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 281
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 22)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)


			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 6º Batalhao Radio Patrulha")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end
				
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				
				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				--setElementData(player, "balas-fuzil", 200)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(22))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 49, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 6º Batalhao Radio Patrulha")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end

if isElementWithinColShape(player, PF) and getElementDimension(player) == getElementDimension(PF) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PF")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 11) then


		if getElementData(player, "char:dutyfaction") ~= 11 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 286
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 11)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)


			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na Policia Federal")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end
				
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)

				
				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 56, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				--setElementData(player, "balas-fuzil", 200)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(11))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 49, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da Policia Federal")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end

if isElementWithinColShape(player, cabron) and getElementDimension(player) == getElementDimension(cabron) then
--if exports.bgo_dashboard:isPlayerInFaction(player, 19)  then
--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("FT")) then
	
	
	if exports.bgo_dashboard:isPlayerInFaction(player , 19) then


	if getElementData(player, "char:dutyfaction") ~= 19 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
	local dutySkin = 282
	if not duty then
		setElementData(player, "char:duty", true)
		setElementData(player, "char:dutyfaction", 19)
		exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
		setElementData(player, "duty:civilskin", getElementModel(player))
		setElementModel(player, dutySkin)
		setElementFrozen(player, false)
		setPedArmor(player, 100)
		if ( atmIsAbleToRob2(player) ) then 
			atmSetTimeOut2(player, ATM_TIMEOUT)
			exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
			-- if exports['bgo_items']:hasItemS(player, 112) then
			exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
			-- end
			

			exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)

				
				
			exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
			--setElementData(player, "balas-pistola", 200)
			--setElementData(player, "balas-shotgun", 200)
			--setElementData(player, "balas-submetralhadora", 200)
			--setElementData(player, "balas-fuzil", 200)

			else
			exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
			end

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na Forca Nacional")
		--triggerClientEvent(player, "seurankPolicia", player, tonumber(19))

		setPlayerTeam(player, getTeamFromName ( "Policia" ))
	else
		exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
		setElementData(player, "char:duty", false)
		setElementData(player, "char:dutyfaction", false)
		setElementModel(player, getElementData(player, "duty:civilskin"))
		setElementFrozen(player, false)
		setPedArmor(player, 0)
		exports['bgo_items']:RemovePlayerDutyItems(player)
		exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da Forca Nacional")
		setPlayerTeam(player, nil)
		setElementData(player, "job", "SemEmprego")

		--[[
		exports['bgo_items']:takePlayerItemToID(player, 32, 0)
		exports['bgo_items']:takePlayerItemToID(player, 64, 0)
		exports['bgo_items']:takePlayerItemToID(player, 84, 0)
		exports['bgo_items']:takePlayerItemToID(player, 125, 0)
		exports['bgo_items']:takePlayerItemToID(player, 50, 0)
		exports['bgo_items']:takePlayerItemToID(player, 49, 0)
		exports['bgo_items']:takePlayerItemToID(player, 45, 0)
		]]--
		takeAllWeapons(player)
		--setElementData(player, "balas-pistola", 0)
		--setElementData(player, "balas-shotgun", 0)
		--setElementData(player, "balas-submetralhadora", 0)
		--setElementData(player, "balas-fuzil", 0)
	end
end
end

if isElementWithinColShape(player, civil) and getElementDimension(player) == getElementDimension(civil) then
--if exports.bgo_dashboard:isPlayerInFaction(player, 2) then
--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PMERJ")) then

	if exports.bgo_dashboard:isPlayerInFaction(player , 6) then


	if getElementData(player, "char:dutyfaction") ~= 6 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
	local dutySkin = 283
	if not duty then
		setElementData(player, "char:duty", true)
		setElementData(player, "char:dutyfaction", 6)
		--sendGroupMessage(6, getPlayerName(player):gsub("_"," ") .. " Está em serviço.")
		exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
		setElementData(player, "duty:civilskin", getElementModel(player))
		setElementModel(player, dutySkin)
		setElementFrozen(player, false)


		exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 3º Batalhao CHOQUE")


		if ( atmIsAbleToRob2(player) ) then 
			atmSetTimeOut2(player, ATM_TIMEOUT)
			exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
			-- if exports['bgo_items']:hasItemS(player, 112) then
			exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
			-- end


				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)


				
				
			exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
			exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
			--setElementData(player, "balas-pistola", 200)
			--setElementData(player, "balas-shotgun", 200)
			--setElementData(player, "balas-submetralhadora", 200)
			--setElementData(player, "balas-fuzil", 200)

			else
			exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
			end

		setElementData(player, "char.inDuty", 1)
		---------------
		setPedArmor(player, 100)

		--triggerClientEvent(player, "seurankPolicia", player, tonumber(6))
		setPlayerTeam(player, getTeamFromName ( "Policia" ))

		else
		exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
		setElementData(player, "char:duty", false)
		setElementData(player, "char:dutyfaction", false)
		setElementModel(player, 0)
		setElementFrozen(player, false)
		setPedArmor(player, 0)
		exports['bgo_items']:RemovePlayerDutyItems(player)

		exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 3º Batalhao CHOQUE")


		setPlayerTeam(player, nil)
		setElementData(player, "job", "SemEmprego")
		--[[
		exports['bgo_items']:takePlayerItemToID(player, 32, 0)
		exports['bgo_items']:takePlayerItemToID(player, 64, 0)
		exports['bgo_items']:takePlayerItemToID(player, 84, 0)
		exports['bgo_items']:takePlayerItemToID(player, 125, 0)
		exports['bgo_items']:takePlayerItemToID(player, 50, 0)
		exports['bgo_items']:takePlayerItemToID(player, 49, 0)
		exports['bgo_items']:takePlayerItemToID(player, 45, 0)
		]]--
		takeAllWeapons(player)
		--setElementData(player, "balas-pistola", 0)
		--setElementData(player, "balas-shotgun", 0)
		--setElementData(player, "balas-submetralhadora", 0)
		--setElementData(player, "balas-fuzil", 0)
		setElementData(player, "char.inDuty", 0)

	end
end
end

		if isElementWithinColShape(player, pdDutyPlace) and getElementDimension(player) == getElementDimension(pdDutyPlace) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 2) then
	--	if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("PMDF")) then

			if exports.bgo_dashboard:isPlayerInFaction(player , 2) then


			if getElementData(player, "char:dutyfaction") ~= 2 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			
			local dutySkin = getElementData(player, "group_2_dutyskin") or 265
			if not duty then
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 2)
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 1º Batalhao Radio Patrulha")


				if ( atmIsAbleToRob2(player) ) then 
					atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				 --	if exports['bgo_items']:hasItemS(player, 112) then
					exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				 --	end


				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)


                	                exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					--setElementData(player, "balas-shotgun", 200)
					--setElementData(player, "balas-submetralhadora", 200)
					--setElementData(player, "balas-fuzil", 200)
	
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end

				setElementData(player, "char.inDuty", 1)

				--triggerClientEvent(player, "seurankPolicia", player, tonumber(2))
				setPlayerTeam(player, getTeamFromName ( "Policia" ))

				---------------
				setPedArmor(player, 100)
				else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				setPedArmor(player, 0)
				exports['bgo_items']:RemovePlayerDutyItems(player)

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 1º Batalhao Radio Patrulha")

				setElementData(player, "job", "SemEmprego")
				setPlayerTeam(player, nil)
				--[[
				exports['bgo_items']:takePlayerItemToID(player, 32, 0)
				exports['bgo_items']:takePlayerItemToID(player, 64, 0)
				exports['bgo_items']:takePlayerItemToID(player, 84, 0)
				exports['bgo_items']:takePlayerItemToID(player, 125, 0)
				exports['bgo_items']:takePlayerItemToID(player, 50, 0)
				exports['bgo_items']:takePlayerItemToID(player, 49, 0)
				exports['bgo_items']:takePlayerItemToID(player, 45, 0)
				]]--
				takeAllWeapons(player)
				--setElementData(player, "balas-pistola", 0)
				--setElementData(player, "balas-shotgun", 0)
				--setElementData(player, "balas-submetralhadora", 0)
				--setElementData(player, "balas-fuzil", 0)
				setElementData(player, "char.inDuty", 0)

			end
		end
	end
		if isElementWithinColShape(player, PMPE) and getElementDimension(player) == getElementDimension(PMPE) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 5) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("ROTA")) then


			if exports.bgo_dashboard:isPlayerInFaction(player , 5) then

			

			if getElementData(player, "char:dutyfaction") ~= 5 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 285
			if not duty then
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 5)
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)
				
				setPlayerTeam(player, getTeamFromName ( "Policia" ))
				--exports.bgo_dashboard:seurankROTA(5)

				--triggerClientEvent(player, "seurankPolicia", player, tonumber(5))
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 2º Batalhao BOPE")

				--setElementData(player, "job", " "..getElementData(player, "grouprank") )


				--setElementData(localPlayer, "jelveny:text", "MentőszolosGálat | "..orgRankName.." | #"..itemData["value"])

				
				if ( atmIsAbleToRob2(player) ) then 
					atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				 --	if exports['bgo_items']:hasItemS(player, 112) then
					exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				 --	end
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)
				
					exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					--setElementData(player, "balas-shotgun", 200)
					--setElementData(player, "balas-submetralhadora", 200)
					--setElementData(player, "balas-fuzil", 200)
	
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end

				setElementData(player, "char.inDuty", 1)
				setPedArmor(player, 100)
else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				setPedArmor(player, 0)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				setPlayerTeam(player, nil)
				setElementData(player, "job", "SemEmprego")
				--[[
				exports['bgo_items']:takePlayerItemToID(player, 32, 0)
				exports['bgo_items']:takePlayerItemToID(player, 64, 0)
				exports['bgo_items']:takePlayerItemToID(player, 84, 0)
				exports['bgo_items']:takePlayerItemToID(player, 125, 0)
				exports['bgo_items']:takePlayerItemToID(player, 50, 0)
				exports['bgo_items']:takePlayerItemToID(player, 49, 0)
				exports['bgo_items']:takePlayerItemToID(player, 45, 0)
				]]--

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 2º Batalhao BOPE")
				takeAllWeapons(player)
				--setElementData(player, "balas-pistola", 0)
				--setElementData(player, "balas-shotgun", 0)
				--setElementData(player, "balas-submetralhadora", 0)
				--setElementData(player, "balas-fuzil", 0)
				setElementData(player, "char.inDuty", 0)
			end
		end
	end

		if isElementWithinColShape(player, PMERJ) and getElementDimension(player) == getElementDimension(PMERJ) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 5) then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("ROTA")) then


			if exports.bgo_dashboard:isPlayerInFaction(player , 16) then

			

			if getElementData(player, "char:dutyfaction") ~= 16 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 288
			if not duty then
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 16)
				exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)
				
				setPlayerTeam(player, getTeamFromName ( "Policia" ))
				--exports.bgo_dashboard:seurankROTA(5)

				--triggerClientEvent(player, "seurankPolicia", player, tonumber(5))
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 4º Batalhao RECoM")

				--setElementData(player, "job", " "..getElementData(player, "grouprank") )


				--setElementData(localPlayer, "jelveny:text", "MentőszolosGálat | "..orgRankName.." | #"..itemData["value"])

				
				if ( atmIsAbleToRob2(player) ) then 
					atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				 --	if exports['bgo_items']:hasItemS(player, 112) then
					exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				 --	end


				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)


				
					exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					--setElementData(player, "balas-shotgun", 200)
					--setElementData(player, "balas-submetralhadora", 200)
					--setElementData(player, "balas-fuzil", 200)
	
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end

				setElementData(player, "char.inDuty", 1)
				setPedArmor(player, 100)
else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				setPedArmor(player, 0)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				setPlayerTeam(player, nil)
				setElementData(player, "job", "SemEmprego")
				--[[
				exports['bgo_items']:takePlayerItemToID(player, 32, 0)
				exports['bgo_items']:takePlayerItemToID(player, 64, 0)
				exports['bgo_items']:takePlayerItemToID(player, 84, 0)
				exports['bgo_items']:takePlayerItemToID(player, 125, 0)
				exports['bgo_items']:takePlayerItemToID(player, 50, 0)
				exports['bgo_items']:takePlayerItemToID(player, 49, 0)
				exports['bgo_items']:takePlayerItemToID(player, 45, 0)
				]]--

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 4º Batalhao RECoM")
				takeAllWeapons(player)
				--setElementData(player, "balas-pistola", 0)
				--setElementData(player, "balas-shotgun", 0)
				--setElementData(player, "balas-submetralhadora", 0)
				--setElementData(player, "balas-fuzil", 0)
				setElementData(player, "char.inDuty", 0)
			end
		end
	end

if isElementWithinColShape(player, ForcaNacional) and getElementDimension(player) == getElementDimension(ForcaNacional) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 17)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("ForcaNacional")) then
		
		
		if exports.bgo_dashboard:isPlayerInFaction(player , 17) then


		if getElementData(player, "char:dutyfaction") ~= 17 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 277
		if not duty then
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 17)
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)
			setPedArmor(player, 100)


			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na 5º Batalhao UPP")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end
			
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)

				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				--setElementData(player, "balas-fuzil", 200)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


			setPlayerTeam(player, getTeamFromName ( "Policia" ))

			--triggerClientEvent(player, "seurankPolicia", player, tonumber(11))


		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, getElementData(player, "duty:civilskin"))
			setElementFrozen(player, false)
			setPedArmor(player, 0)
			exports['bgo_items']:RemovePlayerDutyItems(player)
	
			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")

			--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 49, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da 5º Batalhao UPP")


			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)
		end
	end
	end


	if isElementWithinColShape(player, tekDuty) and getElementDimension(player) == getElementDimension(tekDuty) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 20)  then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("FN")) then	


		if exports.bgo_dashboard:isPlayerInFaction(player , 20) then



		if getElementData(player, "char:dutyfaction") ~= 20 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - Erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 278
		if not duty then
			exports.bgo_infobox:addNotification(player,"Você Está em serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 20)
			--sendGroupMessage(20, getPlayerName(player):gsub("_"," ") .. " Está em serviço.")
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)


			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na Marinha - Fuzileiro")


			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				-- if exports['bgo_items']:hasItemS(player, 112) then
				exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				-- end
				
				exports['bgo_items']:giveItem(player, 52, 1, 1, 1, true)

				
				
				exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				--setElementData(player, "balas-shotgun", 200)
				--setElementData(player, "balas-submetralhadora", 200)
				--setElementData(player, "balas-fuzil", 200)

				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end
	
		setPlayerTeam(player, getTeamFromName ( "Policia" ))
		--triggerClientEvent(player, "seurankPolicia", player, tonumber(20))

			setElementData(player, "char.inDuty", 1)
			setPedArmor(player, 100)
		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			--sendGroupMessage(25, getPlayerName(player):gsub("_"," ") .. " saiu do serviço.")
			
			setElementModel(player, getElementData(player, "duty:civilskin"))

			setPlayerTeam(player, nil)
			setElementData(player, "job", "SemEmprego")
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da Marinha - Fuzileiro")
			setElementFrozen(player, false)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			setPlayerTeam(player, nil)
--[[
			exports['bgo_items']:takePlayerItemToID(player, 32, 0)
			exports['bgo_items']:takePlayerItemToID(player, 64, 0)
			exports['bgo_items']:takePlayerItemToID(player, 84, 0)
			exports['bgo_items']:takePlayerItemToID(player, 125, 0)
			exports['bgo_items']:takePlayerItemToID(player, 50, 0)
			exports['bgo_items']:takePlayerItemToID(player, 49, 0)
			exports['bgo_items']:takePlayerItemToID(player, 45, 0)
			]]--
			takeAllWeapons(player)
			--setElementData(player, "balas-pistola", 0)
			--setElementData(player, "balas-shotgun", 0)
			--setElementData(player, "balas-submetralhadora", 0)
			--setElementData(player, "balas-fuzil", 0)

			setElementData(player, "char.inDuty", 0)
		end
	end
end

--[[
	
	if isElementWithinColShape(player, navDuty) and getElementDimension(player) == getElementDimension(navDuty) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 16)  then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("BAEP")) then

			if exports.bgo_dashboard:isPlayerInFaction(player , 16) then



			if getElementData(player, "char:dutyfaction") ~= 16 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - Erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = 285
			if not duty then
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 16)
				--sendGroupMessage(16, getPlayerName(player):gsub("_"," ") .. " Está em serviço.")

				exports.bgo_infobox:addNotification(player,"Você entrou em serviço!","success")

				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na EB")


					if ( atmIsAbleToRob2(player) ) then 
						atmSetTimeOut2(player, ATM_TIMEOUT)
					exports['bgo_items']:giveItem(player, 32, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 64, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)					
				 	--if exports['bgo_items']:hasItemS(player, 112) then
					exports['bgo_items']:giveItem(player, 125, 1, 1, 1, true)
				 	--end
					exports['bgo_items']:giveItem(player, 50, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 49, 1, 1, 1, true)
					exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
					--setElementData(player, "balas-pistola", 200)
					--setElementData(player, "balas-shotgun", 200)
					--setElementData(player, "balas-submetralhadora", 200)
					--setElementData(player, "balas-fuzil", 200)
	
					else
					exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
					end




				--triggerClientEvent(player, "seurankPolicia", player, tonumber(16))
				setPlayerTeam(player, getTeamFromName ( "Policia" ))

				setElementData(player, "char.inDuty", 1)
				setPlayerArmor(player, 100)
			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				--sendGroupMessage(16, getPlayerName(player):gsub("_"," ") .. " saiu do serviço.")
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				setPlayerArmor(player, 0)
				exports['bgo_items']:RemovePlayerDutyItems(player)

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da EB")

			--	triggerClientEvent(player, "seurankPolicia", player, tonumber(16))
				setPlayerTeam(player, nil)
				setElementData(player, "job", "SemEmprego")

				exports['bgo_items']:takePlayerItemToID(player, 32, 0)
				exports['bgo_items']:takePlayerItemToID(player, 64, 0)
				exports['bgo_items']:takePlayerItemToID(player, 84, 0)
				exports['bgo_items']:takePlayerItemToID(player, 125, 0)
				exports['bgo_items']:takePlayerItemToID(player, 50, 0)
				exports['bgo_items']:takePlayerItemToID(player, 49, 0)
				exports['bgo_items']:takePlayerItemToID(player, 45, 0)


				takeAllWeapons(player)
				--setElementData(player, "balas-pistola", 0)
				--setElementData(player, "balas-shotgun", 0)
				--setElementData(player, "balas-submetralhadora", 0)
				--setElementData(player, "balas-fuzil", 0)

				setElementData(player, "char.inDuty", 0)
			end
		end
	end
	
--]]
	
	if isElementWithinColShape(player, szereloDuty) and getElementDimension(player) == getElementDimension(szereloDuty) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 3)  then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("MECANICO")) then


			if exports.bgo_dashboard:isPlayerInFaction(player , 3) then


			if getElementData(player, "char:dutyfaction") ~= 3 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - Erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = getElementData(player, "group_3_dutyskin") or 50
			if not duty then
				exports.bgo_infobox:addNotification(player,"Você Está em serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 3)
				--sendGroupMessage(3, getPlayerName(player):gsub("_"," ") .. " Está em serviço.")
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar no mecanico")


				setElementData(player, "job", "GuaRda de traNsito - MecâNico")

				setPlayerTeam(player, getTeamFromName ( "Mecanico" ))

			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				--sendGroupMessage(3, getPlayerName(player):gsub("_"," ") .. " saiu do serviço.")
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				setPlayerTeam(player, nil)
				setElementData(player, "job", "SemEmprego")
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair do mecanico")
			end
		end
	end
	if isElementWithinColShape(player, mentoDuty) and getElementDimension(player) == getElementDimension(mentoDuty) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 4)  then
		--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("SAMU")) then

			if exports.bgo_dashboard:isPlayerInFaction(player , 4) then



			if getElementData(player, "char:dutyfaction") ~= 4 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - Erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			
			local dutySkin = getElementData(player, "group_3_dutyskin") or 274
			
			if not duty then
				
				exports.bgo_infobox:addNotification(player,"Você Está em serviço!","success")
				
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 4)
				--sendGroupMessage(4, getPlayerName(player):gsub("_"," ") .. " Esta em serviço.")
				
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar no SAMU")

				--exports['bgo_items']:giveItem(player, 45, 1, 1, 1, true)
				----setElementData(player, "balas-pistola", 200)

				exports['bgo_items']:giveItem(player, 64, 1, 10, 1, true)
				exports['bgo_items']:giveItem(player, 56, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 80, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 81, 1, 1, 1, true)
				setElementData(player, "char.inDuty", 1)

				setElementData(player, "job", "ParaMedico")
				setPlayerTeam(player, getTeamFromName ( "Samu" ))

				else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				--sendGroupMessage(4, getPlayerName(player):gsub("_"," ") .. " saiu do serviço.")
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				exports['bgo_items']:RemovePlayerDutyItems(player)
				setElementData(player, "char.inDuty", 0)
				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair do SAMU")
				setPlayerTeam(player, nil)
				setElementData(player, "job", "SemEmprego")
			end
		end
	end

	--[[
	if isElementWithinColShape(player, taxi) and getElementDimension(player) == getElementDimension(taxi) then
		--if exports.bgo_dashboard:isPlayerInFaction(player, 12)  then
		if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("TAXI")) then
			if getElementData(player, "char:dutyfaction") ~= 12 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - Erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
			local dutySkin = getElementData(player, "group_25_dutyskin") or 180
			if not duty then
				exports.bgo_infobox:addNotification(player,"Você Está em serviço!","success")
				setElementData(player, "char:duty", true)
				setElementData(player, "char:dutyfaction", 12)
				--sendGroupMessage(12, getPlayerName(player):gsub("_"," ") .. " Está em serviço.")
				setElementData(player, "duty:civilskin", getElementModel(player))
				setElementModel(player, dutySkin)
				setElementFrozen(player, false)
				setPlayerArmor(player, 100)
			else
				exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
				setElementData(player, "char:duty", false)
				setElementData(player, "char:dutyfaction", false)
				--sendGroupMessage(12, getPlayerName(player):gsub("_"," ") .. " saiu do serviço.")
				setElementModel(player, getElementData(player, "duty:civilskin"))
				setElementFrozen(player, false)
				exports['bgo_items']:RemovePlayerDutyItems(player)
			end
		end
	end]]--

	if isElementWithinColShape(player, comandovermelho) and getElementDimension(player) == getElementDimension(comandovermelho) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 7) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CV")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 8) then


		if getElementData(player, "char:dutyfaction") ~= 8 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 104
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 8)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)

			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na CV")


		if ( atmIsAbleToRob2(player) ) then 
			atmSetTimeOut2(player, ATM_TIMEOUT)
		exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
		-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
		--setElementData(player, "balas-pistola", 200)
		exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
		else
		exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
		end



			--setElementData(player, "job", "CoMando VerMelho")
			--triggerClientEvent(player, "seurankG", player, tonumber(8))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 84, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da CV")
			setElementData(player, "job", "SemEmprego")
		end
	end
end


	if isElementWithinColShape(player, losG) and getElementDimension(player) == getElementDimension(losG) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 14) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("ADA")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 23) then


		if getElementData(player, "char:dutyfaction") ~= 23 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc143c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 247
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 23)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				exports['bgo_items']:giveItem(player, 39, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end

				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na MOTO CLUB")
			--setElementData(player, "job", "a.d.a Amigo dos Amigos")
			--triggerClientEvent(player, "seurankG", player, tonumber(23))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 144, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da MOTO CLUB")
			setElementData(player, "job", "SemEmprego")
		end
	end
end

	if isElementWithinColShape(player, TCP) and getElementDimension(player) == getElementDimension(TCP) then
	--if exports.bgo_dashboard:isPlayerInFaction(player, 15) then
	--if isObjectInAClosGroup("user."..getAccountName(getPlayerAccount(player)), aclosGetGroup("CDM")) then


		if exports.bgo_dashboard:isPlayerInFaction(player , 15) then


		if getElementData(player, "char:dutyfaction") ~= 15 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc153c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 103
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 15)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPedArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 51, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na BDM")
			--setElementData(player, "job", "cartel los manitos")
			--triggerClientEvent(player, "seurankG", player, tonumber(15))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPedArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 154, false)
			exports['bgo_items']:takePlayerItemToID(player, 51, false)
			exports['bgo_items']:takePlayerItemToID(player, 54, false)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da BDM")
			setElementData(player, "job", "SemEmprego")
		end
	end
end

--[[

	if isElementWithinColShape(player, ada) and getElementDimension(player) == getElementDimension(ada) then
		if exports.bgo_dashboard:isPlayerInFaction(player , 14) then
		if getElementData(player, "char:dutyfaction") ~= 14 and getElementData(player, "char:dutyfaction") then outputChatBox("#dc153c[btc - erro]:#ffffff Você já Está em serviço em outro lugar.", player, 255, 255, 255, true) return end
		local dutySkin = 304
			if not duty then
			exports.bgo_infobox:addNotification(player,"Você entrou do serviço!","success")
			setElementData(player, "char:duty", true)
			setElementData(player, "char:dutyfaction", 14)
			setElementData(player, "duty:civilskin", getElementModel(player))
			setElementModel(player, dutySkin)
			setElementFrozen(player, false)			
			setPlayerArmor(player, 100)
			if ( atmIsAbleToRob2(player) ) then 
				atmSetTimeOut2(player, ATM_TIMEOUT)
				exports['bgo_items']:giveItem(player, 44, 1, 1, 1, true)
				-- exports['bgo_items']:giveItem(player, 54, 1, 1, 1, true)
				--setElementData(player, "balas-pistola", 200)
				exports['bgo_items']:giveItem(player, 84, 1, 1, 1, true)
				else
				exports.bgo_hud:dm("Você só pode pegar o kit de armas novamente em  ".. atmGetTimeOut2 ( player ) .. " segundos", player, 255, 0, 0) 
				end


				exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para entrar na ADA")
			--setElementData(player, "job", "cartel los manitos")
			--triggerClientEvent(player, "seurankG", player, tonumber(14))

		else
			exports.bgo_infobox:addNotification(player,"Você saiu do serviço!","success")
			setElementData(player, "char:duty", false)
			setElementData(player, "char:dutyfaction", false)
			setElementModel(player, 0)
			setElementFrozen(player, false)
			setPlayerArmor(player, 100)
			exports['bgo_items']:RemovePlayerDutyItems(player)
			takeAllWeapons(player)
			exports['bgo_items']:takePlayerItemToID(player, 154, 0)
			exports['bgo_items']:takePlayerItemToID(player, 44, 0)
			exports['bgo_items']:takePlayerItemToID(player, 54, 0)
			exports.bgo_admin:outputAdminMessage(" "..getPlayerName(player).." ID: #7cc576(" .. getElementData(player, "playerid")..") Utilizou o /trabalhar para sair da ADA")
			setElementData(player, "job", "SemEmprego")
		end
	end
end]]--

end
addCommandHandler("trabalhar", dutyPlayers)

--[[

function ticketPlayer(thePlayer, commandName, targetPlayer, cost, ...)

	if getElementData(thePlayer, "char:dutyfaction") == 1  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 2 
	elseif getElementData(thePlayer, "char:dutyfaction") == 2  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 2 
	elseif getElementData(thePlayer, "char:dutyfaction") == 5 then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 5
	elseif getElementData(thePlayer, "char:dutyfaction") == 6  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 6 
	elseif getElementData(thePlayer, "char:dutyfaction") == 16  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 3000
		factionid = 16
	elseif getElementData(thePlayer, "char:dutyfaction") == 20  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 20
	elseif getElementData(thePlayer, "char:dutyfaction") == 19  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 20
	elseif getElementData(thePlayer, "char:dutyfaction") == 11  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 20
			elseif getElementData(thePlayer, "char:dutyfaction") == 21  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 21
	else
		factionid = false
		before = false
		between = false
		maxCost = false
	end
	
	if (factionid) then
		if not (targetPlayer) or not (cost) or not (...) then 
			outputChatBox("#7cc576Use:#ffffff /" ..commandName .. " [Nome / ID] [Quantidade] [Motivo]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if targetPlayer == thePlayer then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você nâo pode pagar por si mesmo.", thePlayer, 255, 255, 255, true) return end
			local cost = tonumber(cost)
			local reason = table.concat({...}, " ")
			
			local x, y, z = getElementPosition(thePlayer)
			local tx, ty, tz = getElementPosition(targetPlayer)
			local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
			local tint, tdim = getElementInterior(targetPlayer), getElementDimension(targetPlayer)
			local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
			
			if cost <= 0 then outputChatBox("#dc143c[btcMTA - Erro]:#ffffffVocê deve inserir uma quantidade maior que 0.", thePlayer, 255, 255, 255, true) return end
			if maxCost < cost then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você bateu o limite máximo. (" .. maxCost .. ")", thePlayer, 255, 255, 255, true) return end
			
			if distance <= 4 and int == tint and dim == tdim then



				outputChatBox(before .. " #7cc576" .. getPlayerName(thePlayer):gsub("_"," ") .. "#ffffff emitiu uma " .. between .. ". Quantidade: #7cc576" .. cost .. "", targetPlayer, 255, 255, 255, true)
				outputChatBox(before .. " Motivo: #7cc576" .. reason, targetPlayer, 255, 255, 255, true)
				
				--exports.exg_dashboard:giveGroupBalance(factionid, cost)
				setElementData(targetPlayer, "char:money", getElementData(targetPlayer, "char:money")-cost)
				
				outputChatBox(before .. " Você Emitiu uma " .. between .. " para #7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. "#ffffff Quantidade: #7cc576" .. cost .. "", thePlayer, 255, 255, 255, true)
				outputChatBox(before .. " Motivo: #7cc576" .. reason, thePlayer, 255, 255, 255, true)
			else
				outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você Está muito longe do jogador.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("multar", ticketPlayer, false, false)

]]--


function ticketPlayer(thePlayer, commandName, cost, ...)
		--[[
	if getElementData(thePlayer, "char:dutyfaction") == 1  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 2 
	elseif getElementData(thePlayer, "char:dutyfaction") == 2  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 2 
	elseif getElementData(thePlayer, "char:dutyfaction") == 5 then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 5
	elseif getElementData(thePlayer, "char:dutyfaction") == 6  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 6 
	elseif getElementData(thePlayer, "char:dutyfaction") == 16  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 3000
		factionid = 16
	elseif getElementData(thePlayer, "char:dutyfaction") == 20  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 20
	elseif getElementData(thePlayer, "char:dutyfaction") == 19  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 20
	elseif getElementData(thePlayer, "char:dutyfaction") == 17  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 17	
	elseif getElementData(thePlayer, "char:dutyfaction") == 11  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 4000
		factionid = 20
		elseif getElementData(thePlayer, "char:dutyfaction") == 21  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 200000
		factionid = 21
		elseif getElementData(thePlayer, "char:dutyfaction") == 22  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 2000
		factionid = 22
		elseif getElementData(thePlayer, "char:dutyfaction") == 24  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 100000
		factionid = 24
		elseif getElementData(thePlayer, "char:dutyfaction") == 28  then
		before = "#7cc576[Castigo]:#ffffff"
		between = "Multa"
		maxCost = 99999999
		factionid = 28
	else
		factionid = false
		before = false
		between = false
		maxCost = false
	end
	
	--]]
		--if (factionid) then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 1  then
		before = "#7cc576[Multa]:#ffffff"
		between = "Multa"
		maxCost = 4000
		if not (cost) or not (...) then 
			outputChatBox("#7cc576Use:#ffffff /" ..commandName .. " [Quantidade] [Motivo] - Fique perto da pessoa a ser multada!", thePlayer, 255, 255, 255, true)
		else
			local cost = tonumber(cost)
			local reason = table.concat({...}, " ")
			if cost <= 0 then outputChatBox("#dc143c[btcMTA - Erro]:#ffffffVocê deve inserir uma quantidade maior que 0.", thePlayer, 255, 255, 255, true) return end
			if maxCost < cost then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você bateu o limite máximo. (" .. maxCost .. ")", thePlayer, 255, 255, 255, true) return end
			local posX1, posY1, posZ1 = getElementPosition(thePlayer)
			for _, player in ipairs(getElementsByType("player")) do
				local posX2, posY2, posZ2 = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
				if distance <= 1 then
					--if player then
					if player ~= thePlayer then
                    outputChatBox(before .. " Você Emitiu uma " .. between .. " para #7cc576" .. getPlayerName(player):gsub("_"," ") .. "#ffffff Quantidade: #7cc576" .. cost .. "", thePlayer, 255, 255, 255, true)
					outputChatBox(before .. " Motivo: #7cc576" .. reason, thePlayer, 255, 255, 255, true)
					outputChatBox(before .. " #7cc576" .. getPlayerName(thePlayer):gsub("_"," ") .. "#ffffff emitiu uma " .. between .. ". Quantidade: #7cc576" .. cost .. "", player, 255, 255, 255, true)
					outputChatBox(before .. " Motivo: #7cc576" .. reason, player, 255, 255, 255, true)
					takeChar (player, cost)
					return
					end
				--end
				end
			end
		end
	end
end
--addCommandHandler("multar", ticketPlayer, false, false)

function takeChar (thePlayer, cost)
 setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money")-cost)
end



function government(thePlayer, commandName, ...)
	local faction = false
	
	local mess = "chamada"
    if getElementData(thePlayer, "char:dutyfaction") == 1  then 
	faction = "DRVV"
	color = "#444CB3"	
	elseif getElementData(thePlayer, "char:dutyfaction") == 2 then -- Megy a PD-nek
		faction = "1º Batalhão Radio Patrulha"
		color = "#444CB3"		
	elseif getElementData(thePlayer, "char:dutyfaction") == 16  then 
		faction = "4º Batalhão RECoM"
		color = "#444CB3"
	elseif getElementData(thePlayer, "char:dutyfaction") == 5  then 
		faction = "2º Batalhão BOPE!"
		color = "#444CB3"	
	elseif getElementData(thePlayer, "char:dutyfaction") == 6  then 
	faction = "3º Batalhão CHOQUE"
	color = "#444CB3"
	elseif getElementData(thePlayer, "char:dutyfaction") == 24  then 
	faction = "7º Batalhão Radio Patrulha"
	color = "#444CB3"	
elseif getElementData(thePlayer, "char:dutyfaction") == 11  then 
	faction = "Policia Federal"
	color = "#444CB3"
	--elseif getElementData(thePlayer, "char:dutyfaction") == 15  then 
		--faction = "BDM BONDE DAS MARAVILHAS"
		--color = "#444CB3"

	elseif getElementData(thePlayer, "char:dutyfaction") == 17  then 
		faction = "5º Batalhão UPP"
		color = "#444CB3"


		elseif getElementData(thePlayer, "char:dutyfaction") == 19  then 
		faction = "Forca Nacional"
		color = "#444CB3"
		elseif getElementData(thePlayer, "char:dutyfaction") == 20 then 
		faction = "Marinha - Fuzileiro"
		color = "#444CB3"		
	elseif getElementData(thePlayer, "char:dutyfaction") == 4 then
		faction = "Serviço de Atendimento Móvel de Urgência"
		color = "#F89406"


	elseif getElementData(thePlayer, "char:dutyfaction") == 21 then
		faction = "Policia Civil"
		color = "#F89406"

	elseif getElementData(thePlayer, "char:dutyfaction") == 28 then
		faction = "Exército Brasileiro"
		color = "#F89406"

	elseif getElementData(thePlayer, "char:dutyfaction") == 22 then
		faction = "6º Batalhão Radio Patrulha"
		color = "#F89406"
	end
	if (faction) then
		if not (...) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [mensagem]", thePlayer, 255, 255, 255, true)
		else
			
			local msg = table.concat({...}," ")
			if (msg) then
				--outputChatBox(" ", root, 255, 255, 255, true)
				--outputChatBox(color .. "[" .. faction .. " " .. mess .. "]:#ffffff " .. msg, root, 255, 255, 255, true)
				
				outputChatBox("#D64541■■■■■■■■■■■■■■■ [#fbff00" .. faction .. "#D64541]■■■■■■■■■■■■■■■", root, 255, 255, 255, true)
							    outputChatBox(" ", root, 255, 255, 255, true)
				outputChatBox("#0079ff" .. msg, root, 255, 255, 255, true)
			    outputChatBox(" ", root, 255, 255, 255, true)
				outputChatBox("#D64541■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■", root, 255, 255, 255, true)				
				exports.bgo_admin:outputAdminMessage("[GOV] #7cc576" .. getPlayerName(thePlayer) .. " (" .. getElementData(thePlayer, "playerid") .. ") #ffffff usou o #0094ff/" .. commandName .. "#ffffff.")
				triggerClientEvent(root, "playGovSound", root)
			end
		end
	end
end
addCommandHandler("gov", government, false, false)




function government(thePlayer, commandName)

	if isTimer(timer) then
	exports.bgo_infobox:addNotification(thePlayer,"Já tem uma informação de patrulhamento, aguarde um pouco!","error")
	return
	end
	
	if getElementData(thePlayer, "char:dutyfaction") then 
	
	timer = setTimer(function() end, 20000, 1)
	
	local corp = getElementData(thePlayer, "char:dutyfaction")
	local faction = false
    if getElementData(thePlayer, "char:dutyfaction") == 2 then 
	faction = "choque"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 5 then
	faction = "rota"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 6 then
	faction = "bope"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 11 then
	faction = "pf"	
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 28 then
	faction = "eb"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 17 then
	faction = "pmerj"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 19 then
	faction = "ft"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 20 then
	faction = "baep"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 21 then
	faction = "pc"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 22 then
	faction = "pmce"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 24 then
	faction = "pmesp"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	elseif getElementData(thePlayer, "char:dutyfaction") == 16 then
	faction = "pmmg"
	triggerClientEvent(root, "ShowPatrulhar", root, faction)
	end
end
	end
addCommandHandler("ptr", government, false, false)



function hasItem(element, itemID, itemValue)
	local lekerd = exports.bgo_item:hasItem(element, itemID, itemValue)
	return lekerd
end

--[[
function adminJail(thePlayer, commandName, targetPlayer, ido, ...)
	--if getElementData(thePlayer, "acc:admin") >= 1 then
		--if exports.bgo_dash:isInGroup(16) then  
			--if getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 then

				if not (targetPlayer) or not (ido) or not (...) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [minuto] [Motivo]", thePlayer, 255, 255, 255, true)
		else

			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local ido = tonumber(ido)
			local reason = table.concat({...}, " ")
			local x, y, z = getElementPosition(thePlayer)
			local tx, ty, tz = getElementPosition(targetPlayer)
			local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
		 --	if thePlayer == targetPlayer then outputChatBox("#dc143c[btcMTA - Erro]:#ffffffVocê nâo pode se curar.", thePlayer, 255, 255, 255, true) return end
		
			if distance <= 4 then
				if not (targetPlayer) then outputChatBox("nâo existe tal jogador.", thePlayer, 255, 255, 255, true) return end
				if not getElementData(targetPlayer, "loggedin") then return end			
			if not (targetPlayer) then
				return
			end
				if getElementData(targetPlayer, "adminjail") == 1 then
					outputChatBox("O jogador já Está preso.", thePlayer, 255, 255, 255, true)
					return
				end
			    setElementData(targetPlayer, "player:preso", true)
				outputChatBox("#dc143c[Departamento de policia]:#7cc576 " .. getPlayerName(thePlayer) .. "#ffffff Prendeu #7cc576" .. targetPlayerName:gsub("_"," ") .. " #ffffffpor #1a75ff" .. ido .. "#ffffff minutos.", root ,255, 255, 255, true)
				outputChatBox("#dc143c[Departamento de policia]:#7cc576 Motivo:#ffffff " .. reason, root ,255, 255, 255, true)
				prisionSerialTimeOut(targetPlayer, PRISION_TIMEOUT)
				takeAllWeapons(targetPlayer)
				if exports['bgo_items']:hasItemS(targetPlayer, 38) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 38, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 32) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 32, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 64) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 64, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 84) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 84, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 52) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 52, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 50) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 50, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 49) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 49, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 44) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 44, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 51) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 51, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 53) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 53, 0)
				end
				if exports['bgo_items']:hasItemS(targetPlayer, 44) then 
				exports['bgo_items']:takePlayerItemToID(targetPlayer, 44, 0)
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
				setTimer(function()
					triggerClientEvent(targetPlayer, "triggerAdminjail", targetPlayer, thePlayer, reason, ido, 1, false)
				end, 500, 1)
				setTimer( function()
					local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
					local theTimer = setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
					local idoTelikMentes = setElementData(targetPlayer, "idoTelik", ido)
					local idoLetelt = setElementData(targetPlayer, "idoLetelt", 0)
					setElementPosition(targetPlayer, 1571.6392822266, -1692.9930419922, 13.589937210083)
					setElementInterior(targetPlayer, 0)
					setElementDimension(targetPlayer, 0)
					local adminjailed = setElementData(targetPlayer, "adminjail", 1)
					local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", reason)
					local alapido = setElementData(targetPlayer, "adminjail:ido", ido)
					local admin = setElementData(targetPlayer, "adminjail:admin", getPlayerName(thePlayer))
					local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", getPlayerSerial(thePlayer))
				end, 1500, 1)
								
				setTimer(function()
					fadeCamera(targetPlayer, true, 2.5)
					setElementFrozen(targetPlayer, false)
					toggleAllControls(targetPlayer, true, true, true)
				end, 7500, 1)
	
			else
			outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você Está muito longe do jogador.", thePlayer, 255, 255, 255, true)
			end
		--end
	end
end
addCommandHandler("prender1564978", adminJail)

]]--


----------------------------------------------------------------------------------------------------------------



--[[
function adminJail(thePlayer, commandName, ido, ...)
	if getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 then
	if not (ido) or not (...) then 
		outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [minuto] [Motivo]", thePlayer, 255, 255, 255, true)
		else
			local ido = tonumber(ido)
			local reason = table.concat({...}, " ")

			local posX1, posY1, posZ1 = getElementPosition(thePlayer)
			for _, player in ipairs(getElementsByType("player")) do
				local posX2, posY2, posZ2 = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
				if distance <= 1 then
					--if player then
					if player ~= thePlayer then

						if getElementData(player, "adminjail") == 1 then
							outputChatBox("O jogador já Está preso.", thePlayer, 255, 255, 255, true)
							return
						end
						outputChatBox("#dc143c[Departamento de policia]:#7cc576 " .. getPlayerName(thePlayer) .. "#ffffff Prendeu #7cc576" .. getPlayerName(player):gsub("_"," ") .. " #ffffffpor #1a75ff" .. ido .. "#ffffff minutos.", root ,255, 255, 255, true)
						outputChatBox("#dc143c[Departamento de policia]:#7cc576 Motivo:#ffffff " .. reason, root ,255, 255, 255, true)
						setTimer(function()
						triggerClientEvent(player, "triggerAdminjail", player, thePlayer, reason, ido, 1, false)
						end, 500, 1)
						local admin = setElementData(player, "adminjail:admin", getPlayerName(thePlayer))
						local adminSerial = setElementData(player, "adminjail:adminSerial", getPlayerSerial(thePlayer))
						local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(player, "char:id") .. "'", 1, reason, ido, ido, getPlayerName(thePlayer), getPlayerSerial(thePlayer))

						takeChar3 (player, reason, ido)
					return
				end
			end
		end
	end
end
end
addCommandHandler("prender", adminJail, false, false)

function takeChar3 (targetPlayer, reason, ido)
	prisionSerialTimeOut(targetPlayer, PRISION_TIMEOUT)
	takeAllWeapons(targetPlayer)
	if exports['bgo_items']:hasItemS(targetPlayer, 38) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 38, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 32) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 32, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 64) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 64, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 84) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 84, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 52) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 52, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 50) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 50, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 49) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 49, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 44) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 44, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 51) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 51, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 53) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 53, 0)
	end
	if exports['bgo_items']:hasItemS(targetPlayer, 44) then 
	exports['bgo_items']:takePlayerItemToID(targetPlayer, 44, 0)
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

	setTimer( function()
		local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
		local theTimer = setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
		local idoTelikMentes = setElementData(targetPlayer, "idoTelik", ido)
		local idoLetelt = setElementData(targetPlayer, "idoLetelt", 0)
		setElementPosition(targetPlayer, 1571.6392822266, -1692.9930419922, 13.589937210083)
		setElementInterior(targetPlayer, 0)
		setElementDimension(targetPlayer, 0)
		local adminjailed = setElementData(targetPlayer, "adminjail", 1)
		local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", reason)
		local alapido = setElementData(targetPlayer, "adminjail:ido", ido)
	end, 1500, 1)			
	setTimer(function()
		fadeCamera(targetPlayer, true, 2.5)
		setElementFrozen(targetPlayer, false)
		toggleAllControls(targetPlayer, true, true, true)
	end, 7500, 1)
end

]]--













prisionCollDown = {}
local prisionSerial = {}
PRISION_TIMEOUT = 600000*2

function prisionSerialTimeOut ( player, time )
    prisionCollDown[player] = setTimer( 
    function (player) 
    prisionCollDown[player] = nil 
    end, time, 1, player)
end

addEventHandler("onPlayerQuit", root,
    function ()
        if ( prisionGetTimeOut(source) ) then
            prisionSerial[getPlayerSerial(source)] = prisionGetTimeOut(source)
        end
    end
)

addEventHandler("onPlayerJoin", root,
    function ()
        for serial, cooldown in pairs ( prisionSerial ) do
            if ( getPlayerSerial(source) == serial ) then
                prisionSerialTimeOut(source, cooldown*1000)
                prisionSerial[serial] = nil
            end
        end
    end
)

function prisionGetTimeOut ( player )
    if isTimer ( prisionCollDown[player] ) then
        local miliseconds = getTimerDetails ( prisionCollDown[player] )
        return math.ceil( miliseconds / 1000 )
    else
        return false
    end
end

function verificationPrision ( player )
    return not isTimer(prisionCollDown[player])
end

----------------------------------------------------------------------------------------------------------------

function release(thePlayer, commandName, targetPlayer)
			--if getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 5  or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 18 or getElementData(thePlayer, "char:dutyfaction") == 20 then
	

				if exports.bgo_admin:isPlayerDuty(thePlayer) then




		if not (targetPlayer) then
			outputChatBox("#7cc576Use#ffffff /" .. commandName .. " [Nome / ID]", thePlayer, 255, 255, 255, true)
		else
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			
			if getElementData(targetPlayer, "adminjail") == 1 then
			
				local theTimerCheck = getElementData(targetPlayer, "adminjail:timer")
				local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)
				local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
				local tint, tdim = getElementInterior(targetPlayer), getElementDimension(targetPlayer)
				local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
				if distance <= 4 and int == tint and dim == tdim then
						--[[
							if (theTimerCheck) then
								killTimer(theTimerCheck)
								setElementData(targetPlayer, "adminjail:timer", false)
							end
							if (theTimerCheck2) then
								killTimer(theTimerCheck2)
								setElementData(targetPlayer, "adminjail:theTimerAccounts", false)
							end]]--
							outputChatBox("#7cc576[Punição]:#ffffff Você foi liberado da cadeia. ", targetPlayer ,255, 255, 255, true)
							local adminjailed = setElementData(targetPlayer, "adminjail", false)
							local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", false)
							local alapido = setElementData(targetPlayer, "adminjail:ido", false)
							local admin = setElementData(targetPlayer, "adminjail:player", false)
							
							
							--sql
							local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, jailed_player = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)
							
							local idoTelikVege = setElementData(targetPlayer, "adminjail:idoTelik", false)
							local idoLeteltVege = setElementData(targetPlayer, "adminjail:idoLetelt", false)
							
							--pos
							setElementPosition(targetPlayer, 1580.8721923828, -1683.6528320313, 14.996187210083)
							setElementInterior(targetPlayer, 0)
							setElementDimension(targetPlayer, 0)
							
							--idoTelikLe(targetPlayer)
							
				else
					outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você Está muito longe do jogador.", thePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("#7cc576[Punição]:#ffffff " .. targetPlayerName:gsub("_"," ") .. " nâo Está sob custódia.", thePlayer ,255, 255, 255, true)
			end
		end
	end
end
--addCommandHandler("soltar", release, false, false)

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
				local setPosition = setTimer(setElementPosition, 2000, 1,targetPlayer, 1580.5162353516, -1683.5106201172, 14.996187210083)
				local setInterior = setElementInterior(targetPlayer, 0)
				local setDimension = setElementDimension(targetPlayer, 0)
			end
		end
	end
end
--[[
local zone = createColCuboid(1569.38818, -1695.95154, 12.03388, 13.1005859375, 5.673095703125, 4.3000072479248)

addEventHandler("onColShapeLeave", zone,
function (hitElement)
     if (getElementData(hitElement, "player:preso")) then
	     setElementPosition(hitElement, 1571.34, -1692.791, 13.59)
		 outputChatBox("#dc143c[BTCMTA - Erro]:#ffffff Você ainda esta preso! Aguarde.", hitElement, 255, 255, 255, true)
		 if ( verificationPrision(hitElement) ) then exports.bgo_hud:dm("Você está preso por:  ".. tonumber(prisionGetTimeOut ( hitElement )) .. " segundos", hitElement, 255, 0, 0) return end
		 else
	 end
end)
--]]

---- /visz ---- (Ha kocsiba �l automat�n berakja a playert)

--[[
local timer = {}

function endVisz(thePlayer)
	if getElementData(thePlayer, "visz:viszi") then
			local x, y, z = getElementPosition(thePlayer)
			

			if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
				killTimer(timer[getElementData(thePlayer, "acc:id")])
			end

			if isTimer(rotz[getElementData(thePlayer, "acc:id")]) then
				killTimer(rotz[getElementData(thePlayer, "acc:id")])
			end
			
			toggleAllControls(getElementData(thePlayer, "visz:viszi"), true)
			setElementFrozen(getElementData(thePlayer, "visz:viszi"), false)
			setElementFrozen(getElementData(thePlayer, "viszi:viszi"), true)
			setElementData(thePlayer, "visz:status", false)
			setElementData(getElementData(thePlayer, "visz:viszi"), "visz:status", false)
			setElementData(getElementData(thePlayer, "visz:viszi"), "visz:vive", false)
			setElementData(thePlayer, "visz:viszi", false)
	end
end

function endVisz2(thePlayer, target)
	if getElementData(thePlayer, "visz:vive") then
			local x, y, z = getElementPosition(thePlayer)

			if isTimer(timer[getElementData(target, "acc:id")]) then
				killTimer(timer[getElementData(target, "acc:id")])
			end

			if isTimer(rotz[getElementData(thePlayer, "acc:id")]) then
				killTimer(rotz[getElementData(thePlayer, "acc:id")])
			end

			toggleAllControls(thePlayer, true)
			setElementFrozen(thePlayer, false)
			setElementData(thePlayer, "visz:status", false)
			setElementData(thePlayer, "visz:vive", false)
	end
end

rotz = {}

rotz = {}

function movePlayer(thePlayer, commandName)
	if getElementData(thePlayer, "loggedin") then
	if exports.bgo_admin:isPlayerDuty(thePlayer) then
		if getElementData(thePlayer, "visz:viszi") then
			
			local x, y, z = getElementPosition(thePlayer)
			setElementPosition(getElementData(thePlayer, "visz:viszi"), x, y+0.5, z)
			
			exports.bgo_chat:sendLocalMeAction(thePlayer, "Soltou " .. getPlayerName(getElementData(thePlayer, "visz:viszi")):gsub("_"," ") .. " -t.")
			
			if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
				killTimer(timer[getElementData(thePlayer, "acc:id")])
			end

			if isTimer(rotz[getElementData(thePlayer, "acc:id")]) then
				killTimer(rotz[getElementData(thePlayer, "acc:id")])
			end			
			toggleAllControls(getElementData(thePlayer, "visz:viszi"), true)
			setElementFrozen(getElementData(thePlayer, "visz:viszi"), false)
			detachElements (getElementData(thePlayer, "visz:viszi"))
			setElementData(thePlayer, "visz:status", false)
			setElementData(getElementData(thePlayer, "visz:viszi"), "visz:status", false)
			setElementData(getElementData(thePlayer, "visz:viszi"), "visz:vive", false)
			setElementData(thePlayer, "visz:viszi", false)

		else

			local posX1, posY1, posZ1 = getElementPosition(thePlayer)
			for _, player in ipairs(getElementsByType("player")) do
				local posX2, posY2, posZ2 = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
				if distance <= 1 then
					if player ~= thePlayer then

						local playerVisz = getElementData(thePlayer, "visz:viszi")
						local player2 = getElementData(thePlayer, "visz:status")
						local target = getElementData(player, "visz:status")
					
						if isPedInVehicle(player) then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff O jogador Está em um veículo.", thePlayer, 255, 255, 255, true) return end
						if player2 then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você já Está carregando um jogador.", thePlayer, 255, 255, 255, true) return end
						if target then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Eles já Estáo levando o jogador.", thePlayer, 255, 255, 255, true) return end
						if getElementData(player, "char.Cuffed") ~= 1 then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você tem que alosGemar primeiro.", thePlayer, 255, 255, 255, true) return end
						attachElements (player, thePlayer, 0, 0.5, 0)
						exports.bgo_chat:sendLocalMeAction(thePlayer, "Esta carregando Você " .. getPlayerName(player):gsub("_"," ") ..".")
						setElementData(thePlayer, "visz:viszi", player)
						setElementData(player, "visz:vive", thePlayer)
						setElementData(thePlayer, "visz:status", 1)
						setElementData(player, "visz:status", 2)
						toggleAllControls(player, false)
						setElementFrozen(player, true)
						toggleControl(player, "chatbox", true)
						toggleControl(player, "screenshot", true)
rotz[getElementData(thePlayer, "acc:id")] = setTimer(function()
	if isElement(thePlayer) then
	if not player then return end
	if tonumber(getElementData(player, "adminjail") or 0) == 1 then
	endVisz(thePlayer)
	outputChatBox("#7cc576[btcMTA]:#ffffff " .. getPlayerName(player) .. " admin ficou preso, então Você foi solto.", thePlayer, 255, 255, 255, true)
	killTimer(rotz[getElementData(thePlayer, "acc:id")])

	if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
		killTimer(timer[getElementData(thePlayer, "acc:id")])
   end

	return
	end
	x, y, z = getElementPosition(thePlayer)
	int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
	setElementPosition(player, x, y+0.5, z)
	setElementInterior(player, int)
	setElementDimension(player, dim)
	if not isElement(player) then
		endVisz(thePlayer)
	end
	end
	end, 500, 0)




					return
				end
			end
		end
	end
end
end
end
--addCommandHandler("puxar", movePlayer, false, false)


function onQuit()
	if getElementData(source, "visz:status") == 2 then
		for k, v in ipairs(getElementsByType("player")) do
			if getElementData(v, "visz:viszi") == source then
				endVisz(v)
				outputChatBox("#7cc576[btcMTA]:#ffffff " .. getPlayerName(source):gsub("_"," ") .. " foi desconectado, então Você foi liberado.", v, 255, 255, 255, true)
			end
		end
	elseif getElementData(source, "visz:status") == 1 then
		for k, v in ipairs(getElementsByType("player")) do
			if getElementData(v, "visz:vive") == source then
				endVisz2(v, source)
				outputChatBox("#7cc576[btcMTA]:#ffffff " .. getPlayerName(source):gsub("_"," ") .. " foi desconectado, então Você foi liberado.", v, 255, 255, 255, true)
			end
		end
	end
end
addEventHandler("onPlayerQuit", getRootElement(), onQuit)

function vehicleEnter(thePlayer, seat, jacked)
	if isElement(thePlayer) and getElementData(thePlayer, "visz:status") == 1 then
		if isElement(getElementData(thePlayer, "visz:viszi")) then
			local veh = getPedOccupiedVehicle(thePlayer)
				if (warpPedIntoVehicle(getElementData(thePlayer, "visz:viszi"), veh, 3)) then
					exports.bgo_chat:sendLocalMeAction(thePlayer, "implantando o homem no veículo.")
					detachElements(getElementData(thePlayer, "visz:viszi"))
					if isTimer(rotz[getElementData(thePlayer, "acc:id")]) then
					     killTimer(rotz[getElementData(thePlayer, "acc:id")])
					end
					if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
						killTimer(timer[getElementData(thePlayer, "acc:id")])
				   end
				end
			end

		end
	end
addEventHandler("onVehicleEnter", getRootElement(), vehicleEnter)

function vehicleExit(thePlayer)
	if isElement(thePlayer) and getElementData(thePlayer, "visz:status") == 1 then
		if isElement(getElementData(thePlayer, "visz:viszi")) then
			local veh = source
			if (veh) then
				if (removePedFromVehicle(getElementData(thePlayer, "visz:viszi"))) then
					exports.bgo_chat:sendLocalMeAction(thePlayer, "removendo o homem do veículo.")
					setElementFrozen(getElementData(thePlayer, "viszi:viszi"), true)
					attachElements (getElementData(thePlayer, "visz:viszi"), thePlayer, 0, 0.5, 0 )

					timer[getElementData(thePlayer, "acc:id")] = setTimer(function()
					  if not thePlayer then killTimer(timer[getElementData(thePlayer, "acc:id")]) else
						 rx,ry,rz = getElementRotation ( thePlayer )
						 setElementRotation(getElementData(thePlayer, "visz:viszi"), rx,ry,rz)
						 end
					 end, 500, 0)
				end
			end
		end
	end
end
addEventHandler("onVehicleExit", getRootElement(), vehicleExit)


]]--


function removeDutyItemOnQuit()
	exports['bgo_items']:RemovePlayerDutyItems(source)
	setElementData(source, "char.inDuty", 0)
end
addEventHandler("onPlayerQuit",getRootElement(),removeDutyItemOnQuit)








--[[
local prodel = createColCuboid(1566.37756, -1681.55640, 13.09150, 5.1129150390625, 9.270263671875, 8.2000059127808)
addEventHandler ("onColShapeHit", prodel,
function(hitElement)
  if (getElementType (hitElement) == "player") then
	if  getElementData(hitElement, "char:dutyfaction") == 17 
	or getElementData(hitElement, "char:dutyfaction") == 11 
	or getElementData(hitElement, "char:dutyfaction") == 24 
	or getElementData(hitElement, "char:dutyfaction") == 22 
	or getElementData(hitElement, "char:dutyfaction") == 4  
	or getElementData(hitElement, "char:dutyfaction") == 16 
	or getElementData(hitElement, "acc:admin") >= 1 
	or getElementData(hitElement, "char:dutyfaction") == 19 
	or getElementData(hitElement, "char:dutyfaction") == 5 
	or getElementData(hitElement, "char:dutyfaction") == 6 
	or getElementData(hitElement, "char:dutyfaction") == 21 
	or getElementData(hitElement, "char:dutyfaction") == 2 
	or getElementData(hitElement, "char:dutyfaction") == 20 then



	else
	exports.bgo_infobox:addNotification(hitElement,"PROIBIDO ENTRAR NESTE LOCAL!","success")
    setElementPosition(hitElement, 1557.6169433594,-1672.3117675781,16.191499710083)
end
end
end)
]]--



local hospital2 = createColCuboid(1555.21033, -1679.29089, 15.19531, 3.34033203125, 7.6549072265625, 4.9)
addEventHandler ("onColShapeHit", hospital2,
function(hitElement)
 	if getElementType ( hitElement ) == "vehicle" then
    setElementPosition(hitElement, 1515.4484863281,-1655.3739013672,13.539175033569  )
 	setElementVelocity(hitElement, 0, 0, 0)
	setElementRotation(hitElement,0,0,89.549522399902)
end
end)

function getAlivePlayersInTeam(theTeam)
    local theTable = { }
    local players = getPlayersInTeam(theTeam)

    for i,v in pairs(players) do
        if not isPedDead(v) and exports.bgo_items:atmIsAbleToRob(v) then
            theTable[#theTable+1]=v
        end
    end

    return theTable
end


function policiaon(thePlayer)
    local policiaTeam = getTeamFromName ( "Policia" )
    local groveCount = #getAlivePlayersInTeam(policiaTeam) --countPlayersInTeam ( policiaTeam )
    if groveCount >= 1 then
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente estamos com "..tonumber(groveCount).." policais em ptr na cidade",thePlayer,  255, 255, 255, true)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then return end
		if getElementData(thePlayer, "acc:admin") >= 1 then
		outputChatBox(" ",thePlayer,  255, 255, 255, true)
		local prCount2 = countPlayersInTeam ( policiaTeam )
		if prCount2 >= 1 then
		 outputChatBox("#dc143c[STAFF]: #ffffff Atualmente no total estamos com #00ff00"..tonumber(prCount2).." #ffffffpolicais na cidade!",thePlayer,  255, 255, 255, true)
		 end
		end
else
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente não temos nenhuma policia online na cidade",thePlayer,  255, 255, 255, true)
end
end
addCommandHandler("policia", policiaon )



function mecanicoon(thePlayer)
    local mecTeam = getTeamFromName ( "Mecanico" )
    local mecCount = countPlayersInTeam ( mecTeam )
    if mecCount >= 1 then
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente estamos com "..tonumber(mecCount).." mecanicos na cidade",thePlayer,  255, 255, 255, true)
else
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente não temos nenhum mecanico online na cidade",thePlayer,  255, 255, 255, true)
end
end
--addCommandHandler("mecanico", mecanicoon )


function samuon(thePlayer)
    local samuTeam = getTeamFromName ( "Samu" )
    local samuCount = countPlayersInTeam ( samuTeam )
    if samuCount >= 1 then
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente estamos com "..tonumber(samuCount).." samu na cidade",thePlayer,  255, 255, 255, true)
else
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente não temos ninguem da samu online na cidade",thePlayer,  255, 255, 255, true)
end
end
addCommandHandler("samu", samuon )

function drvvon(thePlayer)
    local drvvTeam = getTeamFromName ( "DRVV" )
    local drvvCount = countPlayersInTeam ( drvvTeam )
    if drvvCount >= 1 then
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente estamos com "..tonumber(drvvCount).." D.R.V.V na cidade",thePlayer,  255, 255, 255, true)
else
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente não temos ninguem da D.R.V.V online na cidade",thePlayer,  255, 255, 255, true)
end
end
addCommandHandler("drvv", drvvon )

createTeam("PR")

function pron(thePlayer)
    local prTeam = getTeamFromName ( "PR" )
    local prCount = countPlayersInTeam ( prTeam )
    if prCount >= 1 then
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente estamos com "..tonumber(prCount).." Políciais Rodoviários.",thePlayer,  255, 255, 255, true)
else
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer, 255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox(" ",thePlayer,  255, 255, 255, true)
    outputChatBox("#dc143c[AVISO]:#ffffff Atualmente não temos nenhuma viatura da Policia Rodoviária na cidade",thePlayer,  255, 255, 255, true)
end
end
addCommandHandler("pr", pron )









    local prision = createColCuboid(2275.15405, 2434.29443, 8.83912, 3.580322265625, 33.649658203125, 5.9)
	
	
	function exitZ (thePlayer)
     --if (getElementData(thePlayer, "player:preso")) then
	 if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then 
	 --outputChatBox("#FFA000[BGO INFO] #FFFFFFVocê entrou nas celas da prisão", thePlayer, 255,255,255, true)
	 return 
	 end

		 setElementPosition(thePlayer, 2294.9057617188,2439.8840332031,10.830962181091)
		setElementInterior(thePlayer, 0)
		setElementDimension(thePlayer, 0)

end
addEventHandler("onColShapeLeave", prision, exitZ)

addEventHandler("onColShapeHit", prision, exitZ)