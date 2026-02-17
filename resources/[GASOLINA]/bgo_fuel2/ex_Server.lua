--local mysql = exports.bgo_mysql:getConnection()
local loadedPoints = 0
local fuelGun = {}


local sql = exports.bgo_mysql:getConnection()
local atm = {}
local marker = {}
local list = {}
local stoneTimer = {}
local pickATM = {}
local tabela = {}
local tabelaATM = {}
local recebido = 500000
local saldoRoubo = 35000
local ATM_PICKUPS = 1
local timer = { }

function playerAnimationToServer (thePlayer, animName, animtoName)
	setPedAnimation(thePlayer, animName, animtoName, -1, true, false, false, false)
end
addEvent("playerAnimationToServer", true)
addEventHandler("playerAnimationToServer", getRootElement(), playerAnimationToServer)


function syncPlayertoFuelGun(player, state)
	if not state then 
		fuelGun[player] = createObject(14463,0,0,0)
		exports.bone_attach:attachElementToBone(fuelGun[player],player,12,0,0,0.06,-180,0,0)
	else
		if isElement(fuelGun[player]) then 
			destroyElement(fuelGun[player])
		end
	end
end
addEvent("syncPlayertoFuelGun", true)
addEventHandler("syncPlayertoFuelGun", getRootElement(), syncPlayertoFuelGun)

function syncPlayereffect (player, state )
	triggerClientEvent(root, "createEffectstoClient", root, player , fuelGun[player], tostring(state) )
end
addEvent("syncPlayereffect", true)
addEventHandler("syncPlayereffect", getRootElement(), syncPlayereffect)

addEventHandler("onPlayerQuit",getRootElement(),function()
	if isElement(fuelGun[source]) then 
		destroyElement(fuelGun[source])
	end
end)

local recenteTable = {}
local dono = { }





function mudarlitro(thePlayer, litros)
		local v = getElementData(thePlayer, "fuel_element")
	if isElement(v) and getElementData(v, "isRefill") then
		if  tonumber(tabela[v][1] or 0) > 1 then	
			if tonumber(recenteTable[v] or 0) < 1 then
			recenteTable[v] = tabela[v][1]
			end
			tabela[v][1] = tabela[v][1] - litros
			setElementData(v, 'fuel >> quantidade',tabela[v][1])
			else
			triggerClientEvent(thePlayer, "cancelargasolinabomba", thePlayer)
		end
	end
end
addEvent("bgo:AttLitro", true)
addEventHandler("bgo:AttLitro", getRootElement(), mudarlitro)

function abasteceroComprou(p)
		local v = getElementData(p, "fuel_element")
		if getElementData(v, "isRefill") then
				setElementData(v, 'Dono >> bomba', false)
				setElementData(p,"donobomba", false)
				if isTimer(dono[p]) then
				killTimer(dono[p])
				end
					recenteTable[v] = nil
					setElementData(p, "fuel_element", false)
				end
			end
addEvent("bgo:ComprarLitro", true)
addEventHandler("bgo:ComprarLitro", getRootElement(), abasteceroComprou)



function abasteceroCancelamento(p, quantidade)
		local v = getElementData(p, "fuel_element")
		if getElementData(v, "isRefill") then
				if tonumber(recenteTable[v] or 0) > 1 then
				tabela[v][1] = recenteTable[v] 
				setElementData(v, 'fuel >> quantidade',tabela[v][1])
				end
				setElementData(v, 'Dono >> bomba', false)
				setElementData(p,"donobomba", false)
				if isTimer(dono[p]) then
				killTimer(dono[p])
				end
				recenteTable[v] = nil
				setElementData(p, "fuel_element", false)
				end
			end
addEvent("bgo:cancelarLitro", true)
addEventHandler("bgo:cancelarLitro", getRootElement(), abasteceroCancelamento)



function SellOre2(element)
		local v = getElementData(element, "fuel_element")
		if getElementData(v, "isRefill") then
				triggerClientEvent(element, "bgo>info", element,"Posto BGO", "Está bomba agora é de sua utilização", "aviso")
				setElementData(v, 'Dono >> bomba', getElementData(element, "char:id"))
				setElementData(element,"donobomba", true)
				dono[element] = setTimer(function()
				setElementData(v, 'Dono >> bomba', false)
				setElementData(element,"donobomba", false)
				end, 60000, 1)
		end
end
addEvent("bgoMTA->#DonoBomba", true)
addEventHandler("bgoMTA->#DonoBomba", root, SellOre2)


function abastecer(p, quantidade)
				--for k, v in ipairs(getElementsByType("object")) do
				local v = getElementData(p, "bombaabastecer")
					if getElementData(v, "isRefill") then
					local x, y, z = getElementPosition(v)
					local px, py, pz = getElementPosition(p)
					--if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= 3 then
					if tabela[v][1] + quantidade > 600000 then
					tabela[v][1] = 600000
					triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Bomba abastecido com "..quantidade.." litros", "sucesso")
					setElementData(v, 'fuel >> mensagem', true)
					setElementData(v, 'fuel >> quantidade',tabela[v][1])
					setElementData(p, "bombaabastecer", false)
					else
					tabela[v][1] = tabela[v][1] + quantidade
					triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Bomba abastecido com "..quantidade.." litros", "sucesso")
					setElementData(v, 'fuel >> mensagem', true)
					setElementData(v, 'fuel >> quantidade',tabela[v][1])
					setElementData(p, "bombaabastecer", false)
					end
					if tabela[v][2] + quantidade > 35000 then
					tabela[v][2] = 35000
					else
					tabela[v][2] = tabela[v][2] + quantidade/4
				--end
			end
		--end
	end
end

function buscartrajeto2(p)
		for randomc, v in ipairs(tabelaATM) do
		foi = false
		if tabela[tabelaATM[randomc]][1] < 600000 and not list[randomc] then 
			list[randomc] = true
			local x,y,z = getElementPosition(tabelaATM[randomc])
			setElementData(p, "bombaabastecer", tabelaATM[randomc])
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )
			triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Novidades, Novo trajeto encontrado para reabastecer, Local: " .. location .. " " .. city.."", "sucesso")
			exports.Script_futeis:setGPS(p, "Coordenada", x,y,z )
			triggerClientEvent(p, "pegartrajetoG", p, x,y,z)
			foi = true
			break
			end
		end
		if not foi then
			triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Nenhum trajeto encontrado, Buscando novo trajeto!", "erro")
			setTimer(buscartrajeto2,10000,1,p)
		end
end
--addEvent("buscartrajetoG", true)
--addEventHandler("buscartrajetoG", root, buscartrajeto2)


function buscartrajetoPainel(p)
	triggerClientEvent(p, "LimparTrajeto", p)
	for randomc, v in ipairs(tabelaATM) do
	if randomc ~= 37 and randomc ~= 38 and randomc ~= 48 and randomc ~= 50 and randomc ~= 49 then
	if tabela[tabelaATM[randomc]][1] < 600000 and not list[randomc] then 

	
				--list[randomc] = true
				local x,y,z = getElementPosition(tabelaATM[randomc])
				local location = getZoneName ( x, y, z )
				local city = getZoneName ( x, y, z, true )
				triggerClientEvent(p, "ColocarNoTrajeto", p, x,y,z, tabelaATM[randomc], location, city, randomc)
				foi = true
			end
		end
		--if not foi then
		----triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Nenhum trajeto encontrado, Buscando novo trajeto!", "erro")
		--setTimer(buscartrajetoPainel,10000,1,p)
	end
end
addEvent("buscartrajetoPainel", true)
addEventHandler("buscartrajetoPainel", root, buscartrajetoPainel)


function retirartrajetoPainel(bomba)
	list[bomba] = true
	for i,v in ipairs(getElementsByType("player")) do
	if getElementData(v,"job") == "Transporte de Gasolina" then
	buscartrajetoPainel(v)
	end
	end
end
addEvent("retirartrajetoPainel", true)
addEventHandler("retirartrajetoPainel", root, retirartrajetoPainel)



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

function attValorCaixa2 (caixa, take)
    if isElement(caixa) then
		
        if tabela[caixa] and tabela[caixa][1] then
            local valor = tonumber(getValorCaixa2 (caixa) - take)
            tabela[caixa][1] = valor
			
			setElementData(caixa, 'fuel >> quantidade',tabela[caixa][1])
			
        end
    end
end



local reabastecerCaixa = 100000
function reabastecer()
			while true do
				Wait(1000*60*50) 
					for k, v in ipairs(getElementsByType("object")) do
					if getElementData(v, "isRefill") then
					if tabela[v][1] + reabastecerCaixa < 600000 then
					tabela[v][1] = tabela[v][1] + reabastecerCaixa
					setElementData(v, 'fuel >> quantidade',tabela[v][1])
					else
					tabela[v][1] = 600000
					setElementData(v, 'fuel >> quantidade',tabela[v][1])
				end
			end
		end
	end
end



function abastecercaixa(p, cmd, quantidade)
				if getElementData(p, "acc:admin") >= 8 then
					for k, v in ipairs(getElementsByType("object")) do
					if getElementData(v, "isRefill") then
					local x, y, z = getElementPosition(v)
					local px, py, pz = getElementPosition(p)
					if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= 3 then
					if tabela[v][1] + quantidade > 600000 then
					tabela[v][1] = 600000
					triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Bomba abastecido com R$: "..quantidade.."!", "sucesso")
					setElementData(v, 'fuel >> mensagem', true)
					setElementData(v, 'fuel >> quantidade',tabela[v][1])
					setElementData(p, "bombaabastecer", false)
					return
					else
					tabela[v][1] = tabela[v][1] + quantidade
					triggerClientEvent(p, "bgo>info", p,"Transporte de Gasolina", "Bomba abastecido com R$: "..quantidade.."!", "sucesso")
					setElementData(v, 'fuel >> mensagem', true)
					setElementData(v, 'fuel >> quantidade',tabela[v][1])
					setElementData(p, "bombaabastecer", false)
					end
					if tabela[v][2] + quantidade > 35000 then
					tabela[v][2] = 35000
					else
					tabela[v][2] = tabela[v][2] + quantidade/4
					end
					return
					end
				end
			end
		end
	end
addCommandHandler("alitros", abastecercaixa)


function tirarvalorcaixa(p, cmd, quantidade)
				if getElementData(p, "acc:admin") >= 8 then
					for k, v in ipairs(getElementsByType("object")) do
						if getElementData(v, "isRefill") then
						local x, y, z = getElementPosition(v)
						local px, py, pz = getElementPosition(p)
						if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= 2 then
						if tabela[v][1] - quantidade < 1 then
						tabela[v][1] = 0
						triggerClientEvent(p, "bgo>info", p,"Transporte de Gasoline", "Bomba reduzido com R$: "..quantidade.." ID: "..k.." !", "aviso")
						setElementData(v, 'fuel >> quantidade',tabela[v][1])
						return
						else
						attValorCaixa2(v, quantidade)
						triggerClientEvent(p, "bgo>info", p,"Transporte de Gasoline", "Bomba reduzido com R$: "..quantidade.." ID: "..k.."!", "aviso")
						setElementData(v, 'fuel >> mensagem', true)
						setElementData(v, 'fuel >> quantidade',tabela[v][1])
						return
					end
				end
			end
			
		end
	end
end
addCommandHandler("rlitros", tirarvalorcaixa)



function tempo()
	while true do
		Wait(1000*60*7)
		list = {}
	end
end

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


function displayLoadedRes (  )
callFunctionWithSleeps(tempo) 
callFunctionWithSleeps(reabastecer) 
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )



--[[
function createFuelPoint(x,y,z,r,player)
	x = tonumber(x)
	y = tonumber(y)
	z = tonumber(z)
	r = tonumber(r)
	local insertQuery = dbQuery(mysql, "INSERT INTO fuels SET position = ?", toJSON({x, y, z, r}))
	local insertResult, insertNumber, insertID = dbPoll(insertQuery, -1)

	if insertResult then
		temp = createObject(3465, x, y, z, 0, 0, r)

		if isElement(temp) then
			setElementData(temp, "dbid", insertID)
			setElementData(temp, "isRefill", true)
			
			for k,v in ipairs(getElementsByType("player")) do
				if getElementData(v,"acc:admin") >= 1 then
					outputChatBox("#D64541[Admin]:#7cc576 "..getElementData(player, "char:anick").." #ffffffcriou um ponto de gasolina | ID:#7cc576 "..insertID.."",v,255,255,255,true)
				end
			end
		end
	end
end

addCommandHandler("createfuel", function(player)
	if getElementData(player, "acc:admin") >= 7 then
		x,y,z = getElementPosition(player)
		_,_,r = getElementRotation(player)
		createFuelPoint(x,y,z-1,r,player)
	end
end)

addCommandHandler("delfuel", function(player)
	if getElementData(player, "acc:admin") < 7 then return end
	
	local id = getNearestFuelPoint(player)
	if id ~= -1 and getElementData(id, "isRefill") then
		id = getElementData(id, "dbid")
	end
	if id == -1 then
		outputChatBox("#7cc576[btcMTA]: #ffffffNão há fonte perto de você", player, 0, 0, 0, true)
		return
	end
		
	local qh = dbQuery(mysql, "DELETE FROM fuels WHERE id = ?", id)
	local removeResult, _, removeID = dbPoll(qh, -1)
	
	if removeResult then
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"acc:admin") >= 1 then
				outputChatBox("#D64541[Admin]:#7cc576 "..getElementData(player, "char:anick").." #ffffffexcluiu um ponto de gasolina.",v,255,255,255,true)
			end
		end
		
		for k,v in ipairs(getElementsByType("object")) do
			if getElementData(v, "isRefill") and getElementData(v, "dbid") == id then
				destroyElement(v)
			end
		end
	end
end)

function getNearestFuelPoint(ep)
	local pe = {getElementPosition(ep)}
	local dis = 2
	local dis2 = 0
	local obj = -1

	local type = "object"
	for key, value in ipairs(getElementsByType(type)) do
		local p2 = {getElementPosition(value)}
		dis2 = getDistanceBetweenPoints3D (pe[1], pe[2], pe[3], p2[1], p2[2], p2[3])
			
		if tonumber(dis2) < tonumber(dis)  then
			dis = dis2
			obj = value
		end
	end
	return obj
end

function loadFuelPoints(resource)
	if resource ~= getThisResource() then return end
	loadedPoints = 0
	local loaderQuery = dbPoll(dbQuery(mysql, "SELECT * FROM fuels"), -1)
	if loaderQuery then
		for key, value in ipairs(loaderQuery) do
			local id = tonumber(value["id"])
			local position = fromJSON(value["position"])
			local loadedPoint = createObject(3465, position[1], position[2], position[3], 0, 0, position[4])
			setElementData(loadedPoint, "dbid", id)
			setElementData(loadedPoint, "isRefill", true)
			loadedPoints = loadedPoints + 1
		end
		outputDebugString(loadedPoints .. " Ponto de reabastecimento carregado")
	end
end
addEventHandler("onResourceStart", resourceRoot, loadFuelPoints)
]]--


function loadatm(id)
				local query = dbQuery(sql, "SELECT * FROM fuels WHERE id=?", id)
				local qh = dbPoll(query, -1)
				local quant = 0
				for k, v in ipairs(qh) do
				local position = fromJSON(v["position"])
				
					atm[tonumber(v["id"])] = createObject(3465, position[1], position[2], position[3], 0, 0, position[4])
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

					setElementData(atm[tonumber(v["id"])], "dbid", id)
					setElementData(atm[tonumber(v["id"])], "isRefill", true)
			
			
					setElementData(atm[tonumber(v["id"])], 'fuel >> quantidade',tabela[atm[tonumber(v["id"])]][1])
					setElementData(atm[tonumber(v["id"])], 'fuel >> Health', 1000)
					setElementData(atm[tonumber(v["id"])], 'fuel >> mensagem', true)
					--setElementDimension(atm[tonumber(v["id"])], v["dimension"])
					--setElementInterior(atm[tonumber(v["id"])], v["interior"])
					--setElementRotation(atm[tonumber(v["id"])], 0, 0, tonumber(v["rotation"]))
					--setElementData(atm[tonumber(v["id"])], "bankThing", true)
					--marker[tonumber(v["id"])] = createMarker ( v["x"], v["y"], v["z"] +0.2 , "cylinder", 1.5, 255, 255, 0, 0 )
					--setElementData(marker[tonumber(v["id"])],"informacao","Clique para acessar!")		
					--setElementData(atm[tonumber(v["id"])], "bankID", tonumber(v["id"]))
		end
end


function loadatms()
	local query = dbQuery(sql, "SELECT * FROM fuels")
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
	if getElementData(p, "acc:admin") >= 8 then
		local x, y, z = getElementPosition(p)
		local _, _, r = getElementRotation(p)
		local int, dim = getElementInterior(p), getElementDimension(p)
		
		toJSON({x, y, z, r})
		
		local query = dbQuery(sql, "INSERT INTO fuels SET position = ?", toJSON({x, y, z, r}))
		
		--local query = dbQuery(sql, "INSERT INTO atms SET x=?, y=?, z=?, dimension=?, interior=?, rotation=?", x, y, z-0.4, dim, int, r-180)
		local qh, _, id = dbPoll(query, -1)
		outputChatBox("#dc143c[BGO - Gasolina]: #ffffffVocê criou com sucesso uma bomba de gasolina! #dc143c(" .. id .. ")", p, 25, 152, 139, true)
		loadatm(id)
	end
end
addCommandHandler("criarbomba", createATM)

function delATM(p, cmd, id)
	if getElementData(p, "acc:admin") >= 8 then
		if tonumber(id) then
			id = tonumber(id)
			local query = dbQuery(sql, "SELECT * FROM fuels WHERE id=?", id)
			local qh = dbPoll(query, -1)
			local van = false
			for k, v in ipairs(qh) do
				van = true
				dbPoll(dbQuery(sql, "DELETE FROM fuels WHERE id=?", id), -1)
				tabelaATM[getTableATM(atm[id])] = nil
					--setElementData(atm[id], 'fuel >> Health', false)
				destroyElement(atm[id])
				
				
				
			
				
				
				outputChatBox("#dc143c[BGO - Banco]: #ffffffVocê excluiu com sucesso o caixa eletrônico!", p, 25, 152, 139, true)
			end
			if not van then outputChatBox("#dc143c[BGO - Banco]: #ffffffNão existe tal caixa eletrônico!", p, 25, 152, 139, true) return end
		end
	end
end
addCommandHandler("delbomba", delATM)


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
	if getElementData(p, "acc:admin") >= 8 then
		local van = false
		local px, py, pz = getElementPosition(p)
		outputChatBox("#dc143c[BGO - ATM]: #ffffffBomba de gasolina por perto:", p, 25, 152, 139, true)
		for k, v in ipairs(getElementsByType("object")) do
			if getElementData(v, "isRefill") then
				local x, y, z = getElementPosition(v)
				local distancia = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
				if distancia <= 2 then
					van = true
					outputChatBox("#dc143c[BGO - ATM]: #ffffffID: "..getElementData(v, "dbid").." distancia: "..math.floor(distancia).."", p, 25, 152, 139, true)
				end
			end
		end
		if not van then
			--outputChatBox("#dc143c[BGO - Banco]: #ffffffNão há caixa eletrônico perto de você", p, 25, 152, 139, true)
		end
	end
end
addCommandHandler("bomba", nearbyATMs)

