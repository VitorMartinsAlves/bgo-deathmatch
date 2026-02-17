--[[
						                                     
						`7MM"""Yp,    .g8"""bgd     .g8""8q.   
						  MM    Yb  .dP'     `M   .dP'    `YM. 
						  MM    dP  dM'       `   dM'      `MM 
						  MM"""bg.  MM            MM        MM 
						  MM    `Y  MM.    `7MMF 'MM.      ,MP 
						  MM    ,9  `Mb.     MM   `Mb.    ,dP' 
						.JMMmmmd9     `"bmmmdPY     `"bmmd"'  
						B R A S I L  G A M I N G  O N L I N E  

]]


local sql = exports.bgo_mysql:getConnection()
local obj = 2942
local obj2 = 2943
local atm = {}
local marker = {}
local list = {}
local stoneTimer = {}
local pickATM = {}
local tabela = {}
local tabelaATM = {}
local recebido = 150000
local saldoRoubo = 10000
local ATM_PICKUPS = 1
local timer = { }
 
function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

    function getTime(Timetype)
        local time = getRealTime()
        local horas = time.hour
        local minutos = time.minute
        local segundos = time.second
        local dias = time.monthday
        local meses = time.month
        local anos = time.year
        -- Make sure to add a 0 to the front of single digits.
        if (horas < 10) then
            horas = "0"..horas
        end
        if (minutos < 10) then
            minutos = "0"..minutos
        end
        if (segundos < 10) then
            segundos = "0"..segundos
        end
        if (dias < 10) then
            dias = "0"..dias
        end
        if (meses < 10) then
            meses = "0"..(meses +1)
        end
        if (anos < 10) then
            anos = "0"..anos
        end
        if Timetype == 'clock' then
            return horas..':'..minutos
        elseif Timetype == 'calendar' then
            return dias..'/'..(meses)..'/'..(anos - 100) 
        end
    end



addCommandHandler('showatm', function(p, cmd, ...)
    if p:getData('showatm') == false then
        if p:getData('acc:admin') >= 8 then
            p:setData('showatm', true)
            outputChatBox('#dc143c[BGOMTA - Banco]: #ffffffVocê ativou a visibilidade de IDs dos ATMs', p, 255, 255, 255, true)
        end
    else
        p:setData('showatm', false)
        outputChatBox('#dc143c[BGOMTA - Banco]: #ffffffVocê desativou a visibilidade de IDs dos ATMs', p, 255, 255, 255, true)
    end
end)


function onDepositMoney(thePlayer, money)
		if isTimer(timer[thePlayer]) then
			exports.bgo_infobox:addNotification(thePlayer,"Aguarde 15 segundos!","error")
			return
		end
		timer[thePlayer] = setTimer(function() end, 15000, 1)
		
		
		--local x,y,z = getElementPosition(thePlayer)
		--local tabela2 = getElementsWithinRange( x, y, z, 3.5, "object" )
		--local v = nil
		--for i = 1, #tabela2 do
		--v = tabela2[i] 
		--if v and getElementModel(v) == obj and (tonumber(getElementData(v, 'bankID') or 0)) > 0 then 
		
		local v = getElementData(thePlayer, "Click:atm")
		
		
		if money <= getElementData(thePlayer, "char:money") or money == getElementData(thePlayer, "char:money") then
			setElementData(thePlayer, "char:bankmoney", getElementData(thePlayer, "char:bankmoney") + money)
			setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - money)
			triggerClientEvent(thePlayer, 'UPDATE:TRANS', thePlayer, 'deposit', 'Depositou R$'..convertNumber(money), getTime('calendar'))
			exports.bgo_hud:dm("Você depositou R$: "..money.."",thePlayer, 200, 100, 0)
			tabela[v][1] = tabela[v][1] + money
			setElementData(v, 'atm >> quantidade',tabela[v][1])
			
			setElementData(thePlayer, "Click:atm", false)
			exports.bgo_discordlogs:sendDiscordMessage(3, false, "[DEPÓSITO]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." depositou R$: "..money.." no banco! Total: "..getElementData(thePlayer, "char:bankmoney").."")
		else
		outputChatBox('#0071fe[TRANSFERIDOR] #FFFFFFVocê está sem dinheiro', thePlayer,255,255,255,true) 
		end	
			--end
		--break
	--end
end
addEvent("BGO:DEPOSIT", true)
addEventHandler("BGO:DEPOSIT", root, onDepositMoney)


function transMoney(p, target, value)
	if isTimer(timer[p]) then
		exports.bgo_infobox:addNotification(p,"Aguarde 15 segundos!","error")
		return
	end
	timer[p] = setTimer(function() end, 15000, 1)	
		local targetPlayer2, targetPlayerName = exports.bgo_core:findPlayer(p, target)
	if not targetPlayer2 then
		outputChatBox('#0071fe[TRANSFERIDOR] #FFFFFFJOGADOR OFFLINE!', p,255,255,255,true) 
		return 
	end
	if value == tonumber(getElementData(p, "char:bankmoney")) or value < tonumber(getElementData(p, "char:bankmoney")) then
		setElementData(p, "char:bankmoney", (getElementData(p, "char:bankmoney") or 0) - tonumber(value))
		setElementData(targetPlayer2, "char:bankmoney", (getElementData(targetPlayer2, "char:bankmoney") or 0 ) + tonumber(value))
		exports.bgo_hud:dm("Você enviou R$: "..value.." para " .. getPlayerName(targetPlayer2),p, 200, 100, 0)
		exports.bgo_hud:dm(""..getPlayerName(p).." Fez uma transferência R$ "..value.." para você!",targetPlayer2, 200, 100, 0)
		
		triggerClientEvent(p, 'UPDATE:TRANS', p, 'transfer', 'Enviou R$'..convertNumber(value)..' para '..targetPlayer2:getData('acc:name')..'.', getTime('calendar'))
		triggerClientEvent(targetPlayer2, 'UPDATE:TRANS', targetPlayer2, 'transfer', 'Recebeu R$'..convertNumber(value)..' de '..p:getData('acc:name')..'.', getTime('calendar'))
				
				
		exports.bgo_discordlogs:sendDiscordMessage(3, false, "[TRANSFERENCIA]: "..getPlayerName(p).." ID: "..getElementData(p, "acc:id").." Fez uma transferência de R$: "..value.." para "..getPlayerName(targetPlayer2).." ID: "..getElementData(targetPlayer2, "acc:id").." ")
		outputChatBox("#dc143c[BGO - Banco]: #ffffff "..getPlayerName(p).." Fez uma transferência R$ "..value.." para você!", targetPlayer2, 25, 152, 139, true)
	else
		outputChatBox('#0071fe[TRANSFERIDOR] #FFFFFFVocê está sem dinheiro', p,255,255,255,true) 
	end								
end
addEvent("BGO:TRANSFER", true)
addEventHandler("BGO:TRANSFER", root, transMoney)


function saqueBankMoney(thePlayer, money)
		if tonumber(getElementData(thePlayer, "char:money") or 0) + money > 100000 then
			outputChatBox('#FFFFFF R$:'..format(money)..' + R$:'..format(tonumber(getElementData(thePlayer, "char:money") or 0))..' do jogador, ultrapassa mais de 100 mil e o maximo que você pode ter em suas mãos é a baixo de 100 mil', thePlayer,255,255,255,true) 
			setElementData(thePlayer, "Notification:S", false)
			setElementData(thePlayer, "Notification", " ( R$:"..format(money).." + R$:"..format(tonumber(getElementData(thePlayer, "char:money") or 0)).." ) O maximo que você pode ter em suas mãos é a baixo de 100 mil")
			setTimer(setElementData, 7000, 1, thePlayer, "Notification", false)
			return
		end
			
		if isTimer(timer[thePlayer]) then
			exports.bgo_infobox:addNotification(thePlayer,"Aguarde 15 segundos!","error")
			return
		end

		if money == getElementData(thePlayer, "char:bankmoney") or money <= getElementData(thePlayer, "char:bankmoney") then
		
		
		
		--local px, py, pz = getElementPosition(thePlayer)
		--for k, v in ipairs(getElementsByType("object")) do
		--if getElementData(v, "bankThing") then
		--	local x, y, z = getElementPosition(v)
		--if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 3 then
		local v = getElementData(thePlayer, "Click:atm")
		
		if  tabela[v][1] > 1 then	
		
		
		if tonumber(tabela[v][1]) >= money then
			tabela[v][1] = tabela[v][1] - money
			setElementData(v, 'atm >> quantidade',tabela[v][1])
			setElementData(thePlayer, "Click:atm", false)
			else
			exports.bgo_infobox:addNotification(thePlayer,"Limite do caixa extendido só tem disponivel para retirar: R$: "..tabela[v][1]..",00 ","error")
			return
		end
		
		
		
			timer[thePlayer] = setTimer(function() end, 15000, 1)
			setElementData(thePlayer, "char:bankmoney", getElementData(thePlayer, "char:bankmoney") - money)
			setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") + money)
			triggerClientEvent(thePlayer, 'UPDATE:TRANS', thePlayer, 'withdraw', 'Sacou R$'..convertNumber(money), getTime('calendar'))
			
			
			exports.bgo_discordlogs:sendDiscordMessage(3, false, "[SAQUE]: "..getPlayerName(thePlayer).." ID: "..getElementData(thePlayer, "acc:id").." sacou R$: "..money.." no banco Total: "..getElementData(thePlayer, "char:bankmoney").."")
		--break
		else
			exports.bgo_infobox:addNotification(thePlayer,"Este caixa está sem dinheiro!","error")
			end
		--end
	--end
--end
	else
		outputChatBox('#0071fe[TRANSFERIDOR] #FFFFFFVocê está sem dinheiro', thePlayer,255,255,255,true) 
	end	
end
addEvent("BGO:WITHDRAW", true)
addEventHandler("BGO:WITHDRAW", root, saqueBankMoney)


function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 





function loadatm(id)
				local query = dbQuery(sql, "SELECT * FROM atms WHERE id=?", id)
				local qh = dbPoll(query, -1)
				local quant = 0
				for k, v in ipairs(qh) do
					atm[tonumber(v["id"])] = createObject(obj, v["x"], v["y"], v["z"])
				if not tabela then
					tabela = {}
				end
				if not tabela[atm[tonumber(v["id"])]]then
					tabela[atm[tonumber(v["id"])]] = {}
				end
				if not tabela[atm[tonumber(v["id"])]][1] then
					tabela[atm[tonumber(v["id"])]][1] = {}
			end		
				if tabela[atm[tonumber(v["id"])]][1] then
					tabela[atm[tonumber(v["id"])]][1] = recebido
		end
				if not tabela[atm[tonumber(v["id"])]][2] then
					tabela[atm[tonumber(v["id"])]][2] = {}
	end		
				if tabela[atm[tonumber(v["id"])]][2] then
					tabela[atm[tonumber(v["id"])]][2] = saldoRoubo
end
					setElementData(atm[tonumber(v["id"])], 'atm >> quantidade',tabela[atm[tonumber(v["id"])]][1])
					setElementData(atm[tonumber(v["id"])], 'atm >> Health', 1000)
					setElementData(atm[tonumber(v["id"])], 'atm >> mensagem', true)
					setElementDimension(atm[tonumber(v["id"])], v["dimension"])
					setElementInterior(atm[tonumber(v["id"])], v["interior"])
					setElementRotation(atm[tonumber(v["id"])], 0, 0, tonumber(v["rotation"]))
					setElementData(atm[tonumber(v["id"])], "bankThing", true)
					marker[tonumber(v["id"])] = createMarker ( v["x"], v["y"], v["z"] +0.2 , "cylinder", 1.5, 255, 255, 0, 0 )
					setElementData(marker[tonumber(v["id"])],"informacao","Clique para acessar!")		
					setElementData(atm[tonumber(v["id"])], "bankID", tonumber(v["id"]))
		end
end


local reabastecerCaixa = 50000
function reabastecer()
					for k, v in ipairs(getElementsByType("object")) do
					if getElementData(v, "bankThing") then
					if tabela[v][1] + reabastecerCaixa < 150000 then
					tabela[v][1] = tabela[v][1] + reabastecerCaixa
					setElementData(v, 'atm >> quantidade',tabela[v][1])
					else
					tabela[v][1] = 150000
					setElementData(v, 'atm >> quantidade',tabela[v][1])
				--end
			end
		end
	end
end
setTimer(reabastecer,1000*60*30,0)

function abastecer(p, quantidade)
				for k, v in ipairs(getElementsByType("object")) do
					if getElementData(v, "bankThing") then
					local x, y, z = getElementPosition(v)
					local px, py, pz = getElementPosition(p)
					if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= 3 then
					if tabela[v][1] + quantidade > 150000 then
					tabela[v][1] = 150000
					triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Caixa abastecido com R$: "..quantidade.."!", "sucesso")
					setElementData(v, 'atm >> mensagem', true)
					setElementData(v, 'atm >> quantidade',tabela[v][1])
					else
					tabela[v][1] = tabela[v][1] + quantidade
					triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Caixa abastecido com R$: "..quantidade.."!", "sucesso")
					setElementData(v, 'atm >> mensagem', true)
					setElementData(v, 'atm >> quantidade',tabela[v][1])
					end
					if tabela[v][2] + quantidade > 35000 then
					tabela[v][2] = 35000
					else
					tabela[v][2] = tabela[v][2] + quantidade/4
				end
			end
		end
	end
end


function abastecercaixa(p, cmd, quantidade)
				if getElementData(p, "acc:admin") >= 8 then
					for k, v in ipairs(getElementsByType("object")) do
						if getElementData(v, "bankThing") then
						local x, y, z = getElementPosition(v)
						local px, py, pz = getElementPosition(p)
						if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= 3 then
						if tabela[v][1] + quantidade > 150000 then
						tabela[v][1] = 150000
						triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Caixa abastecido com R$: "..quantidade.."!", "sucesso")
						setElementData(v, 'atm >> mensagem', true)
						setElementData(v, 'atm >> quantidade',tabela[v][1])
						else
						tabela[v][1] = tabela[v][1] + quantidade
						triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Caixa abastecido com R$: "..quantidade.."!", "sucesso")
						setElementData(v, 'atm >> mensagem', true)
						setElementData(v, 'atm >> quantidade',tabela[v][1])
						end
						if tabela[v][2] + quantidade > 35000 then
						tabela[v][2] = 35000
						else
						tabela[v][2] = tabela[v][2] + quantidade/4
					end
				end
			end
		end
	end
end
addCommandHandler("abastecer", abastecercaixa)


function tirarvalorcaixa(p, cmd, quantidade)
				if getElementData(p, "acc:admin") >= 8 then
					for k, v in ipairs(getElementsByType("object")) do
						if getElementData(v, "bankThing") then
						local x, y, z = getElementPosition(v)
						local px, py, pz = getElementPosition(p)
						if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= 2 then
						if tabela[v][1] - quantidade < 1 then
						tabela[v][1] = 0
						triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Caixa reduzido com R$: "..quantidade.."!", "aviso")
						setElementData(v, 'atm >> quantidade',tabela[v][1])
						else
						attValorCaixa2(v, quantidade)
						triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Caixa reduzido com R$: "..quantidade.."!", "aviso")
						setElementData(v, 'atm >> mensagem', true)
						setElementData(v, 'atm >> quantidade',tabela[v][1])
					end
				end
			end
		end
	end
end
addCommandHandler("tirarvalor", tirarvalorcaixa)

local tempotrajeto = {}
function buscartrajeto2(p)
		for randomc, v in ipairs(tabelaATM) do
		foi = false
		if tabela[tabelaATM[randomc]][1] < 150000 and not list[randomc] then 
			list[randomc] = true
			local x,y,z = getElementPosition(tabelaATM[randomc])
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )
			triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Novidades, Novo trajeto encontrado para reabastecer, Local: " .. location .. " " .. city.."", "sucesso")
			exports.Script_futeis:setGPS(p, "Coordenada", x,y,z )
			triggerClientEvent(p, "pegartrajeto", p, x,y,z)
			foi = true
			break
			end
		end
		if not foi then
		triggerClientEvent(p, "bgo>info", p,"Transporte de Valores", "Nenhum trajeto encontrado, Buscando novo trajeto!", "erro")
		tempotrajeto[p] = setTimer(buscartrajeto2,10000,1,p)
	end
end
addEvent("buscartrajeto", true)
addEventHandler("buscartrajeto", root, buscartrajeto2)



function quitou()
if isTimer(tempotrajeto[source]) then
killTimer(tempotrajeto[source])
end
end
addEventHandler("onPlayerQuit", root, quitou)



function getValorCaixa2 (caixa)
    if isElement(caixa) then
        if tabela[caixa] and tabela[caixa][1] then
            return tonumber(tabela[caixa][1])
        end
    end
end




function getValorCaixa (caixa)
    if isElement(caixa) then
        if tabela[caixa] and tabela[caixa][2] then
            return tonumber(tabela[caixa][2])
        end
    end
end

local myBlip = {}
local tempoo = {}


addEventHandler('onElementDataChange', root, function(dataName)
    if source and getElementType(source) == 'object' and (tonumber(getElementData(source, 'bankID') or 0)) > 0 then 
        if tostring(dataName) == 'atm >> Health' then 
            if getElementData(source, dataName) <= 0 then 
                setElementModel(source, obj2)
                stoneTimer[source] = setTimer(function(source)
                setElementData(source, 'atm >> Health', 1000)
				setElementData(source, 'atm >> quantidade',tabela[source][2])
                end, 1000*60*60, 1, source)
				
			if not isElement(pickATM[source]) then
				setElementData(source, 'atm >> quantidade',0)
				local dinheiro = getValorCaixa (source) --getElementData(source, 'atm >> quantidade')
			if ( tonumber(dinheiro) or 0) > 50 then
				
				local x, y, z = getElementPosition( source )
				local offset = 1*0.2
				local randomNumber = math.random(0.1, 0.6)
				pickATM[source] = createPickup(x+offset, y+randomNumber, z-0.9, 3, 1212, 1)
				
				local dim = getElementDimension(source)
				local int = getElementInterior(source)
				setElementDimension(pickATM[source], dim)
				setElementInterior(pickATM[source], int)
		
				attachElements ( pickATM[source], source, 0+offset, -1+randomNumber, 0 )
				addEventHandler("onPickupHit", pickATM[source], onATMPickupHit)
			end
		end
            elseif getElementData(source, dataName) == 1000 then 
                setElementModel(source, obj)
				setElementData(source, 'atm >> quantidade',tabela[source][2])
            end
        end
    end
end)

function generateRandom (valor)
    local valor = tonumber(valor)
    local minvalor = valor/2
    if minvalor <= 0 then
        minvalor = 1 
    end
    local randomMoney = math.random(minvalor, valor)
	
	return randomMoney
end


function attValorCaixa2 (caixa, take)
    if isElement(caixa) then
		
        if tabela[caixa] and tabela[caixa][1] then
            local valor = tonumber(getValorCaixa2 (caixa) - take)
            tabela[caixa][1] = valor
			
			setElementData(caixa, 'atm >> quantidade',tabela[caixa][1])
			
        end
    end
end


function attValorCaixa (caixa, take)
    if isElement(caixa) then
		
        if tabela[caixa] and tabela[caixa][2] then
            local valor = tonumber(getValorCaixa (caixa) - take)
            tabela[caixa][2] = valor
        end
    end
end




function onATMPickupHit ( element )
	if ( isPedInVehicle(element) ) then return end		
		setTimer(
			function (pickup)
			local x,y,z = getElementPosition(element)
	local tabela2 = getElementsWithinRange( x, y, z, 10, "object" )
    local v = nil
    for i = 1, #tabela2 do
         v = tabela2[i] 
	if v and getElementModel(v) == obj2 and (tonumber(getElementData(v, 'bankID') or 0)) > 0 then 

		local dinheiro = getValorCaixa (v)
		local quantidade = generateRandom (dinheiro)
		attValorCaixa(v, quantidade)
		if isElement(pickATM[v]) then
		destroyElement(pickATM[v])
	end
		if exports.bgo_items:giveItem(element, 22, 1, quantidade, 0, true) then 
        tabela[v][1] = tabela[v][1] - quantidade
		setElementData(v, 'atm >> quantidade',tabela[v][1])
		triggerClientEvent(element, "bgo>info", element,"Assalto ao caixa eletronico", "Você pegou "..quantidade.." de dinheiro sujo fuga do local", "sucesso")
		--outputChatBox("#dc143c[BGO - ATM]: #ffffffVocê pegou: "..quantidade, element, 25, 152, 139, true)
		end
		
		triggerClientEvent(element, "bgo->#darfuga", element)
		local x,y,z = getElementPosition(element)

		local location = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		
		if isTimer(tempoo[element]) then
		killTimer(tempoo[element])
		end
		
		if isElement(myBlip[element]) then
		destroyElement(myBlip[element])
		end
		myBlip[element] = createBlipAttachedTo (element, 1 )
		setElementData(myBlip[element] ,"blipName", "Assaltante em fuga!!!")
		setBlipColor ( myBlip[element], 255, 0, 0, 255 )
		setBlipSize ( myBlip[element], 2 )
		setBlipVisibleDistance(myBlip[element], 2000)
		setElementVisibleTo ( myBlip[element], root, false )
		tempoo[element] = setTimer(destroyElement, 300000, 1, myBlip[element])
		
		local players2 = getPlayersInTeam(getTeamFromName ( "Policia" ))
		for i,players in pairs(players2) do
		triggerClientEvent(players, "bgo>info", players,"Explosão ao caixa!", "Uma explosão ao caixa eletronico foi iniciado em " .. location .. " " .. city .." ", "sucesso")
		setElementVisibleTo ( myBlip[element], players, true )
		end
		
		local players2 = getPlayersInTeam(getTeamFromName ( "Admin" ))
		for i,players in pairs(players2) do
		setElementVisibleTo ( myBlip[element], players, true )
		triggerClientEvent(players, "bgo>info", players,"Explosão ao caixa!", "Explosão ao caixa eletronico em " .. location .. " " .. city .." | ID: "..getElementData(element, "acc:id").." ", "sucesso")

		end
		
		break
			end
		end
	end, 50, 1, source)

end



function tempo()
		list = {}
end
setTimer(tempo,1000*60*7,0)

function displayLoadedRes (  )
callFunctionWithSleeps(tempo) 
callFunctionWithSleeps(reabastecer) 
end
--addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )

function callFunctionWithSleeps(calledFunction, ...) 
    local co = coroutine.create(calledFunction) 
    coroutine.resume(co, ...) 
end 
  
function Wait(time) 
    local co = coroutine.running() 
    local function resumeThisCoroutine()  
        coroutine.resume(co) 
    end 
    setTimer(resumeThisCoroutine, getTime() + time, 1) 
    coroutine.yield()
end 



function loadatms()
	local query = dbQuery(sql, "SELECT * FROM atms")
	local qh = dbPoll(query, -1)
	for k, v in ipairs(qh) do
		loadatm(tonumber(v["id"]))
		if not tabelaATM then
		tabelaATM = {}
		end
		if not tabelaATM[k] then
		tabelaATM[k] = {}
		end
		tabelaATM[k] = atm[tonumber(v["id"])] -- BANCO
	end
end
loadatms()

function createATM(p)
	if tonumber(getElementData(p, "acc:admin") or 0) >= 6 then
		local x, y, z = getElementPosition(p)
		local _, _, r = getElementRotation(p)
		local int, dim = getElementInterior(p), getElementDimension(p)
		local query = dbQuery(sql, "INSERT INTO atms SET x=?, y=?, z=?, dimension=?, interior=?, rotation=?", x, y, z-0.4, dim, int, r-180)
		local qh, _, id = dbPoll(query, -1)
		outputChatBox("#dc143c[BGO - Bank]: #ffffffVocê criou com sucesso um caixa eletrônico! #dc143c(" .. id .. ")", p, 25, 152, 139, true)
		loadatm(id)
	end
end
addCommandHandler("createatm", createATM)

function delATM(p, cmd, id)
	if tonumber(getElementData(p, "acc:admin") or 0) >= 6 then
		if tonumber(id) then
			id = tonumber(id)
			--local query = dbQuery(sql, "SELECT * FROM atms WHERE id=?", id)
			--local qh = dbPoll(query, -1)
				local van = false
			--for k, v in ipairs(qh) do
				--dbPoll(dbQuery(sql, "DELETE FROM atms WHERE id=?", id), -1)
				
				delQuery = dbExec(sql, "DELETE FROM atms WHERE id=?", id)
				if delQuery then
				van = true
				tabelaATM[getTableATM(atm[id])] = nil
				destroyElement(atm[id])
				outputChatBox("#dc143c[BGO - Banco]: #ffffffVocê excluiu com sucesso o caixa eletrônico!", p, 25, 152, 139, true)
				end
				
			--end
			if not van then outputChatBox("#dc143c[BGO - Banco]: #ffffffNão existe tal caixa eletrônico!", p, 25, 152, 139, true) return end
		end
	end
end
addCommandHandler("delatm", delATM)


function getTableATM(caixa)
if isElement(caixa) then
for i = 1, #tabelaATM do
if tabelaATM[i] == caixa then
return i
end
end
end
end

function nearbyATMs(p)
	if tonumber(getElementData(p, "acc:admin") or 0) >= 6 then
		local van = false
		local px, py, pz = getElementPosition(p)
		outputChatBox("#dc143c[BGO - ATM]: #ffffffCaixas eletrônicos por perto:", p, 25, 152, 139, true)
		for k, v in ipairs(getElementsByType("object")) do
			if getElementData(v, "bankThing") then
				local x, y, z = getElementPosition(v)
				local distancia = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
				if distancia <= 2 then
					van = true
					outputChatBox("#dc143c[BGO - ATM]: #ffffffID: "..getElementData(v, "bankID").." distancia: "..math.floor(distancia).."", p, 25, 152, 139, true)
				end
			end
		end
		if not van then
			outputChatBox("#dc143c[BGO - Banco]: #ffffffNão há caixa eletrônico perto de você", p, 25, 152, 139, true)
		end
	end
end
addCommandHandler("atm", nearbyATMs)


