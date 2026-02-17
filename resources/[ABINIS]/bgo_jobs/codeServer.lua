addEvent("trabalho", true)
addEventHandler("trabalho", root, function (thePlayer, a,b)

if exports.bgo_admin:isPlayerDuty(thePlayer) or exports.bgo_admin:isPlayerFaccao(thePlayer) then
exports.bgo_infobox:addNotification(thePlayer, "Você esta utilizando /trabalhar e não pode pegar emprego aqui! ","error")
return
end

demitir(thePlayer)
if a == "Pedreiro" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)

exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 2714.827, 844.629, 10.898)
return
elseif a == "Lixeiro" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)

exports.Script_futeis:setGPS(thePlayer, "Coordenada", -1110.495, -1663.382, 76.864)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
return
elseif a == "Limpador" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1769.4239501953,2071.6862792969,10.8203125)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")

return
elseif a == "Sedex" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1665.1602783203,-1426.4910888672,13.677488327026)

exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
return
elseif a == "Entregador de Gas" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 2265.3068847656,-1026.6203613281,59.285461425781)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")

return
elseif a == "Motorista" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1234.9768066406,-1823.9078369141,13.590934753418)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")

return
elseif a == "MotoristaR" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1920.4012451172,703.07214355469,11.1328125)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")

return
elseif a == "Maquinista" then
exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1706.4353027344,-1939.625,13.572628974915)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")

return
elseif a == "ifood" then

exports.bgo_employment:setPlayerJob(thePlayer, a, a, b,true)
exports.Script_futeis:setGPS(thePlayer, "Coordenada", 2389.658, 2089.615, 10.842)
exports.bgo_infobox:addNotification(thePlayer, "Você pegou com sucesso o emprego de "..a.."!","success")
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
	exports.bgo_admin:setarskinP(thePlayer)
	--local genero = getElementData(thePlayer, "char:genero")
	--	if genero == "homem" then 
	--setElementModel(thePlayer, skin)
	--end
end
--addCommandHandler("demitir",demitir)
addEvent("demitir", true)
addEventHandler("demitir", root, demitir)



function demitir2222(player)
exports.bgo_infobox:addNotification(player, "O /demitir foi desativado agora tem que ir na prefeitura para se demitir","error")
end
addCommandHandler("demitir",demitir2222)
