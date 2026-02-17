
local connection = exports.bgo_mysql:getConnection()

Async:setPriority("high")
Async:setDebug(false)



function restart()
	for index, player in ipairs(getElementsByType("player")) do
		getData(player)
		setElementData(player, "call:multas", false)
--triggerClientEvent(player, "bgo>info", player,"DRVV Transito | Informa", "Consulte suas multas pendentes em /multas", "info")
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)


function outputLicensePlate ( thePlayer, command, texto, valor, ... )
		if getElementData(thePlayer, "char:dutyfaction") == 1 or tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7 then --exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 1 then 
		if not texto then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff use: /"..command.." [Plca do veiculo] [Valor da multa] [Motivo]", thePlayer, 255, 255, 255, true) return end
		if not valor then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff use: /"..command.." [Plca do veiculo] [Valor da multa] [Motivo]", thePlayer, 255, 255, 255, true) return end
		if not (...) then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff use: /"..command.." [Plca do veiculo] [Valor da multa] [Motivo]", thePlayer, 255, 255, 255, true) return end
		local x,y,z = getElementPosition(thePlayer)
		local tabela = getElementsWithinRange( x, y, z, 6, "vehicle" )
		local value = nil
		local valor = tonumber(valor)
		local motivo = table.concat({...}, " ")
		for i = 1, #tabela do
		value = tabela[i]
        local plateText = getVehiclePlateText ( value )
		if plateText == texto then
			if tonumber(getElementData(value, "veh:owner") or 0) > 0 or getElementData(value, "veh:owner") or (getElementData(value, "owner")) then
			local owner = getElementData(value,"veh:owner") --""
				if not owner then
					owner = getElementData(value, "owner")
			end
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, owner)
			if targetPlayer then
				local sucesso = dbExec(connection, "INSERT INTO multas SET drvv = ?, dono = ?, motivo = ?, placa = ?, valor = ?, nome = ?", getPlayerName(thePlayer), owner, motivo, plateText, valor, getPlayerName(targetPlayer))
				if sucesso then
					getData(targetPlayer)
					outputChatBox (" #ffffffPlaca do veiculo: #7cc576"..plateText.." | #ffffffDono: #7cc576".. owner .. " #ffffff| Multado por #7cc576"..getPlayerName(thePlayer).." #ffffff| Valor da multa: #7cc576"..valor.." #ffffff| Motivo: #7cc576"..motivo.." ", thePlayer, 255, 0, 0, true )
					triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito", "Placa do veiculo: "..plateText.." | Multado por "..getPlayerName(thePlayer).." | Valor da multa: "..valor.." | Motivo: "..motivo.." ", "sucesso")
					outputChatBox (" #ffffffVocê foi multado!! | Placa do veiculo: #7cc576"..plateText.." #ffffff| Multado por #7cc576"..getPlayerName(thePlayer).." #ffffff| Valor da multa: #7cc576"..valor.." #ffffff| Motivo: #7cc576"..motivo.." ", targetPlayer, 255, 0, 0, true )
					triggerClientEvent(targetPlayer, "bgo>info", targetPlayer,"DRVV Transito | Você foi multado!!", "Placa do veiculo: "..plateText.." | Multado por "..getPlayerName(thePlayer).." | Valor da multa: "..valor.." | Motivo: "..motivo.." ", "erro")
					
					triggerClientEvent(targetPlayer, "bgo>info", targetPlayer,"DRVV Transito | Informa", "Para pagar suas multas pendentes é preciso ir até o departamento do DRVV", "info")
					end
					end
				end
				break
			end
		end	
    end
end
addCommandHandler( "multar", outputLicensePlate )
	
	
function getData(player)
	local dono = getElementData(player, "acc:id")
    dbQuery(
        function(query)
            local query, query_lines = dbPoll(query, -1)
            if query_lines > 0 then
            Async:foreach(query, 
			function(row)
            triggerClientEvent(player,"setListDataMulta",player,query)
            end
            )
            else
            triggerClientEvent(player,"setListDataMulta",player,nil)
            end
        end, 
    connection, "SELECT * FROM multas WHERE dono = ? ", dono)
end
addEvent("getListDataMultas",true)
addEventHandler("getListDataMultas",root,getData)



addEventHandler("onPlayerLogin", root,
  function()
    getData(source)
  end
)



function PagarMulta(thePlayer, id, valor)
if getElementData(thePlayer, "call:multasPagou") then return end
	local money = getElementData(thePlayer, "char:money")
	if (tonumber(money) or 0) >= tonumber(valor) then
		delQuery = dbExec(connection, "DELETE FROM multas WHERE id=?", id)
		if delQuery then
		
		setElementData(thePlayer, "call:multasPagou", true)
		setTimer ( setElementData, 3000, 1, thePlayer, "call:multasPagou", false)
		setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - tonumber(valor))
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | Pagamento", "Você pagou "..valor.." por uma multa! Obrigado!", "sucesso")
		getData(thePlayer)
		end
	else
	triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | Pagamento", "Você precisa ter "..valor.." para pagar esta multa!", "erro")
	end
end
addEvent("PagarMultas",true)
addEventHandler("PagarMultas",root,PagarMulta)



function recebermultas(thePlayer, multas)
	if getElementData(thePlayer, "call:multas") then outputChatBox("#dc143c[BGOMTA - ERRO]:#ffffff AGUARDE UM POUCO!", thePlayer, 255, 255, 255, true) return end

	if tonumber(multas) == 0 then
	triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | Consulta", "Você não tem multas pendentes, mantenha sempre assim!", "info")
	else
	triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | Consulta", "Você tem "..tonumber(multas).." multas pendentes, precisa ir no DRVV para paga-las", "info")
	end

	--local x,y,z = getElementPosition(thePlayer)
	--local tabela = getElementsWithinRange( x, y, z, 10, "player" )
	--local targetPlayer = nil
	--for i = 1, #tabela do
	--targetPlayer = tabela[i] 
	--if targetPlayer ~= thePlayer then
	
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	if tonumber(multas) == 0 then
	exports.bgo_chat:sendLocalMeAction(thePlayer, "#00ff00Senhor #ffffffNão #00ff00tenho #ffffffMultas pendentes ( Hora da informação: "..hours..":"..minutes.." ) ")
	else
	exports.bgo_chat:sendLocalMeAction(thePlayer, "#00ff00Senhor #ffffffEu tenho #00ff00"..tonumber(multas).." #ffffffMultas pendentes ( Hora da informação: "..hours..":"..minutes.." ) ")
	end
	
	setElementData(thePlayer, "call:multas", true)
	setTimer ( setElementData, 6000, 1, thePlayer, "call:multas", false)
	
	--end
	--break
	--end
end
addEvent("consultarMultas", true)
addEventHandler("consultarMultas", root, recebermultas)
