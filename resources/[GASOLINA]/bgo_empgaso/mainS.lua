addEvent("ColocarNoTrajeto", true)
addEvent("BGO.ClickGasolina", true)
local tempo = {}

local vehIDs = {
[403] = true, -- Pony (Offset Radius)
--[440] = {3.668, 8}, -- Boxville (Offset Radius)
}



addEventHandler("ColocarNoTrajeto", root,
    function(x,y,z, bomba, location, city)
            triggerClientEvent(source, "BGO.colocarnopainel", resourceRoot, x,y,z, bomba, location, city)
    end
)
local tabelaT = {}
addEventHandler("BGO.ClickGasolina", root,
    function(thePlayer, tabela)
        if isPedInVehicle(thePlayer) then
	local v = getPedOccupiedVehicle ( thePlayer )
	if v then
	if not vehIDs[getElementModel(v)] then 
	triggerEvent("bgo>info", localPlayer,"Transporte de Gasolina", "Somente o veiculo adequado pode fazer este trabalho!", "info")
	return 
	end
	
			if getElementData(thePlayer, "bombaabastecer") == false then
                triggerClientEvent(thePlayer, "BGO.onClosePainelG", resourceRoot)
				triggerClientEvent(thePlayer, "pegartrajetoG", thePlayer, tabela[1],tabela[2],tabela[3])
				setElementData(thePlayer, "bombaabastecer", tabela[4])
				triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Transporte de Gasolina", "Novidades, Novo trajeto encontrado para reabastecer, Local: " .. tabela[5] .. " " .. tabela[6].."", "sucesso")
			else
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Transporte de Gasolina", "Você ja tem uma rota para ser feita!", "erro")
			end
			else
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Transporte de Gasolina", "Entre no veiculo para iniciar o trabalho!", "erro")
        end
		end
    end
)

local zone = createColCuboid(647.13885, -1385.10303, 9.34987, 140.17321777344, 55.706420898438, 9.5000356674194)


 function painel(thePlayer)
	if getElementData(thePlayer, "loggedin") == false then return end
	if getElementData(thePlayer, "bombaabastecer") == true then triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Transporte de Gasolina", "Você ja tem uma rota para ser feita!", "erro") return end
	if getElementData(thePlayer,"job") == "Transporte de Gasolina" then
	local detection = isElementWithinColShape ( thePlayer, zone )
	if detection then
	local v = getPedOccupiedVehicle ( thePlayer )
	if v then
	if not vehIDs[getElementModel(v)] then 
	triggerClientEvent(thePlayer,"bgo>info", thePlayer,"Transporte de Gasolina", "Somente o veiculo adequado pode fazer este trabalho!", "info")
	return 
	end
	triggerClientEvent(thePlayer, "AbrirPainelG", thePlayer)
	else
	triggerClientEvent(thePlayer,"bgo>info", thePlayer,"Transporte de Gasolina", "só pode usar esta função dentro do veiculo de trabalho!", "info")
	end
	else
		local v = getPedOccupiedVehicle ( thePlayer )
	if v then
	if not vehIDs[getElementModel(v)] then 
	triggerClientEvent(thePlayer,"bgo>info", thePlayer,"Transporte de Gasolina", "Somente o veiculo adequado pode fazer este trabalho!", "info")
	return 
	end
	triggerClientEvent(thePlayer,"bgo>info", thePlayer,"Transporte de Gasolina", "Volte ao QG dos caminhoneiros para pegar as rotas!", "info")
	exports.Script_futeis:setGPS(thePlayer, "Coordenada", 721.96075439453, -1355.6065673828, 13.748157501221 )
	end
	end
	end
end


function restart()
	for index, player in ipairs(getElementsByType("player")) do
		bindKey(player, "F4", "down", painel) -- Bind Para Abrir/Fechar Painel
		setElementData(player, "bombaabastecer", false)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)

function entrar()
	bindKey(source, "F4", "down", painel) -- Bind Para Abrir/Fechar Painel
end
addEventHandler("onPlayerJoin", getRootElement(), entrar)

function fechar(player)
	for index, player in ipairs(getElementsByType("player")) do
		unbindKey(player, "F4", "down", painel) -- Bind Para Abrir/Fechar Painel
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), fechar)