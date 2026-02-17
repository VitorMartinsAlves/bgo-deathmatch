addEvent("trabalhoLS", true)
addEventHandler("trabalhoLS", root, function (thePlayer, a,b)

if exports.bgo_admin:isPlayerDuty(thePlayer) or exports.bgo_admin:isPlayerFaccao(thePlayer) then
exports.bgo_infobox:addNotification(thePlayer, "Você esta utilizando /trabalhar e não pode pegar emprego aqui! ","error")
return
end

demitir(thePlayer)
if a == "Transporte de Valores" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)

exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1527.9039306641,-1018.5792236328,23.954305648804)
return
elseif a == "Eletrecista" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)

exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1515.6806640625,-1472.0296630859,9.5640621185303)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
return
elseif a == "ifood" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)

exports.Script_futeis:setGPS(thePlayer, "Coordenada", 2098.041015625,-1806.4180908203,13.554109573364)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
return
elseif a == "Transporte de Gasolina" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)

exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1769.0413818359, -1903.9248046875, 13.559499740601)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Posto BGO", "Lembrando: Para iniciar as rotas utilize F4!", "aviso")
return
end
end)
	
--[[
function outputChange(dataName,oldValue) 
if dataName == "job" then 
		
if getElementData(source, dataName) == "Pedreiro" then
		local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 260)
end
elseif getElementData(source, dataName) == "ifood" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 155)
end
elseif getElementData(source, dataName) == "Lixeiro" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 128)
end
elseif getElementData(source, dataName) == "Limpador" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 259)
end
elseif getElementData(source, dataName) == "Sedex" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 124)
end
elseif getElementData(source, dataName) == "Entregador de Gas" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 59)
end
elseif getElementData(source, dataName) == "Motorista" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 127)
end
elseif getElementData(source, dataName) == "MotoristaR" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 147)
end
elseif getElementData(source, dataName) == "Maquinista" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 120)
end
elseif getElementData(source, dataName) == "SemEmprego" then
local genero = getElementData(source, "char:genero")
		if genero == "homem" then 
setElementModel(source, 0)
end
end
end 
end 
addEventHandler("onElementDataChange",root,outputChange) 
]]--

function demitir(thePlayer)
	if getElementData(thePlayer, "job") == "Mecânico" then return end
	exports.bgo_employment:setPlayerJob(thePlayer, "SemEmprego", "0",true)
	local x,y,z = getElementPosition(thePlayer)
	exports.Script_futeis:setGPS(thePlayer, "Coordenada", x,y,z)
	exports.bgo_infobox:addNotification(thePlayer, "Você foi demitido!","success")
	triggerClientEvent(thePlayer,"hudids",thePlayer)
	--local genero = getElementData(thePlayer, "char:genero")
	--	if genero == "homem" then 
	--setElementModel(thePlayer, 0)
	--end
	exports.bgo_admin:setarskinP(thePlayer)
end
--addCommandHandler("demitir",demitir)
addEvent("demitirLS", true)
addEventHandler("demitirLS", root, demitir)



function demitir2222(player)
exports.bgo_infobox:addNotification(player, "O /demitir foi desativado agora tem que ir na prefeitura para se demitir","error")
end
addCommandHandler("demitir",demitir2222)
