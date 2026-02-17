local box = {}
function setCuffPlayer(player)
	if isElement(box[player]) then
		destroyElement(box[player])
	end
    setElementData(player, "algemado", true)
	toggleControl(player,'next_weapon',false)
	toggleControl(player,'previous_weapon',false)
	toggleControl(player,'fire',false)
	toggleControl(player,'aim_weapon',false)
	toggleControl(player, 'jump', false)
	toggleControl(player, 'crouch', false)
	
	local x, y, z = getElementPosition(player)
	box[player] = createObject(364, x, y, z)
	setElementData(player, "algemado", true)
	exports.bone_attach:attachElementToBone( box[player], player, 12, 0,0,0,   0,40,-10)
	setElementCollisionsEnabled(box[player], false)
end

addEvent("onServerCuff", true)
addEventHandler("onServerCuff", root, function (player, element)
	if element:getData("char.Cuffed") == 1 then 
		if getElementData(element, "visz:status") == 2 then return end
		setElementData(element, "char.Cuffed", 0)
		setElementFrozen(element, false)
		toggleControl(element,'next_weapon',true)
		toggleControl(element,'previous_weapon',true)
		toggleControl(element,'fire',true)
		toggleControl(element,'aim_weapon',true)
        setElementData(element, "algemado", false)
		toggleControl(element,'forwards',true)
		toggleControl(element,'backwards',true)
		toggleControl(element,'left',true)
		toggleControl(element,'right',true)
		toggleControl(element, 'jump', true)
		toggleControl(element, 'crouch', true)
		if isElement(box[element]) then
		destroyElement(box[element])
		end
		triggerClientEvent(player, "bgo>info", player,"Você liberou o jogador das algemas.", "info")
		setPedAnimation(element, 'ped', 'pass_Smoke_in_car', 0, false, false, false, false)
	else
		setElementData(element, "char.Cuffed", 1)
		triggerClientEvent(player, "bgo>info", player,"Você algemou o jogador", "info")
		triggerClientEvent(element, "bgo>info", element,"Você foi algemado", "info")
		
		setCuffPlayer(element)
	end
end)


addEvent("onServerDesalgemar", true)
addEventHandler("onServerDesalgemar", root, function (player)
		setElementData(player, "char.Cuffed", 0)
		setElementFrozen(player, false)
		toggleControl(player,'next_weapon',true)
		toggleControl(player,'previous_weapon',true)
		toggleControl(player,'fire',true)
		toggleControl(player,'aim_weapon',true)
        setElementData(player, "algemado", false)
		toggleControl(player,'forwards',true)
		toggleControl(player,'backwards',true)
		toggleControl(player,'left',true)
		toggleControl(player,'right',true)
		toggleControl(player, 'jump', true)
		toggleControl(player, 'crouch', true)
		if isElement(box[player]) then
		destroyElement(box[player])
		end
		setPedAnimation(player, 'ped', 'pass_Smoke_in_car', 0, false, false, false, false)
end)

addEvent("revistarANIM", true)
addEventHandler("revistarANIM", root, function (player)
	setPedAnimation(player, "POLICE", "plc_drgbst_01", 3100, true, false, false, false)
end)

addEvent("revistarmANIM", true)
addEventHandler("revistarmANIM", root, function (player)
	setPedAnimation( player, "COP_AMBIENT", "Coplook_think", 3100, true, false, false, false)
end)


addEventHandler('onPlayerQuit', root,function()
		if isElement(box[source]) then
		destroyElement(box[source])
		end
end)

addEventHandler('onPlayerWasted',root,function()
		if isElement(box[source]) then
		destroyElement(box[source])
		end
end)

addEventHandler('onVehicleStartEnter', getRootElement(),
function(player, seat)
	if isElement(box[player]) then
		if seat ~= 0 then
		if isElement(box[player]) then
		destroyElement(box[player])
		end
		else
			cancelEvent()
		end
	end
end)

addEventHandler('onVehicleExit', getRootElement(),
function(player, seat)
	if player:getData("char.Cuffed") == 1 then 
		setCuffPlayer(player)
	end
end)

function ticketPlayer(thePlayer, commandName, ...)
		if exports.bgo_admin:isPlayerDuty(thePlayer) then
		if not (...) then 
			outputChatBox("#7cc576Use:#ffffff /" ..commandName .. " [Motivo] - Fique perto da pessoa para limpar as coisas ilegais!", thePlayer, 255, 255, 255, true)
		else
			local reason = table.concat({...}, " ")
			local posX1, posY1, posZ1 = getElementPosition(thePlayer)
			for _, player in ipairs(getElementsByType("player")) do
				local posX2, posY2, posZ2 = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
				if distance <= 1 then
					if player ~= thePlayer then
                    outputChatBox(" Você limpou as coisas ilegais do jogador #7cc576" .. getPlayerName(player):gsub("_"," ") .. "", thePlayer, 255, 255, 255, true)
					outputChatBox(" Motivo: #7cc576" .. reason, thePlayer, 255, 255, 255, true)
					outputChatBox(" o Policial #7cc576" .. getPlayerName(thePlayer):gsub("_"," ") .. "#ffffff limpou sua mochila ilegal ", player, 255, 255, 255, true)
					outputChatBox(" Motivo: #7cc576" .. reason, player, 255, 255, 255, true)
					takeChar (player)
					return
				end
			end
		end
	end
end
end
addCommandHandler("limpar", ticketPlayer, false, false)

function takeChar (thePlayer)
	 if exports['bgo_items']:hasItemS(thePlayer, 22) then	
	 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 22, true)
	 end
	 if exports['bgo_items']:hasItemS(thePlayer, 230) then	
	 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 230, true)
	 end
end


local timer = {}
rotz = {}
rotz = {}


function carregar(player, element)
if element:getData("char.Cuffed") == 0 then outputChatBox("#dc143c[Erro]:#ffffffAlgeme primeiro a pessoa que deseja carregar!", player, 255, 255, 255, true) return end
	if element:getData("char.Carregado") == 1 then 
		setElementData(element, "char.Carregado", 0)
		if getElementData(player, "visz:viszi") then
			local x, y, z = getElementPosition(player)
			setElementPosition(getElementData(player, "visz:viszi"), x, y+0.5, z)
			exports.bgo_chat:sendLocalMeAction(player, "Soltou " .. getPlayerName(getElementData(player, "visz:viszi")):gsub("_"," ") .. " -t.")
			if isTimer(timer[getElementData(player, "acc:id")]) then
				killTimer(timer[getElementData(player, "acc:id")])
			end
			if isTimer(rotz[getElementData(player, "acc:id")]) then
				killTimer(rotz[getElementData(player, "acc:id")])
			end
			toggleAllControls(getElementData(player, "visz:viszi"), true)
			setElementFrozen(getElementData(player, "visz:viszi"), false)
			detachElements (getElementData(player, "visz:viszi"))
			setElementData(player, "visz:status", false)
			setElementData(getElementData(player, "visz:viszi"), "visz:status", false)
			setElementData(getElementData(player, "visz:viszi"), "visz:vive", false)
			setElementData(player, "visz:viszi", false)
			end
	else
	setElementData(element, "char.Carregado", 1)
	local playerVisz = getElementData(player, "visz:viszi")
	local player2 = getElementData(player, "visz:status")
	local target = getElementData(element, "visz:status")
	if isPedInVehicle(element) then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff O jogador Está em um veículo.", player, 255, 255, 255, true) return end
	if player2 then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você já Está carregando um jogador.", player, 255, 255, 255, true) return end
	if target then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Eles já Estáo levando o jogador.", player, 255, 255, 255, true) return end
	if getElementData(element, "char.Carregado") ~= 1 then outputChatBox("#dc143c[btcMTA - Erro]:#ffffff Você tem que algemar primeiro.", player, 255, 255, 255, true) return end
	attachElements (element, player, 0, 0.5, 0)
	triggerClientEvent(player, "bgo>info", player,"Você está carregando uma pessoa!", "info")
	setElementData(player, "visz:viszi", element)
	setElementData(element, "visz:vive", player)
	setElementData(player, "visz:status", 1)
	setElementData(element, "visz:status", 2)
	toggleAllControls(element, false)
	setElementFrozen(element, true)
	toggleControl(element, "chatbox", true)
	toggleControl(element, "screenshot", true)
	rotz[getElementData(player, "acc:id")] = setTimer(function()
	if isElement(player) then
	if not element then return end
	if tonumber(getElementData(element, "adminjail") or 0) == 1 then
	endVisz(player)
	killTimer(rotz[getElementData(player, "acc:id")])
	if isTimer(timer[getElementData(player, "acc:id")]) then
		killTimer(timer[getElementData(player, "acc:id")])
	end
	return
	end
	x, y, z = getElementPosition(player)
	int, dim = getElementInterior(player), getElementDimension(player)
	setElementPosition(element, x, y+0.5, z)
	setElementInterior(element, int)
	setElementDimension(element, dim)
	rx,ry,rz = getElementRotation ( player )
	setElementRotation(getElementData(player, "visz:viszi"), rx,ry,rz)
	if not isElement(element) then
	endVisz(player)
	end
	end
	end, 500, 0)
	end
end
addEvent("onServerCarregar", true)
addEventHandler("onServerCarregar", root, carregar)











function movePlayer(thePlayer, commandName)
	if getElementData(thePlayer, "loggedin") then
	if exports.bgo_admin:isPlayerDuty(thePlayer) then
		if getElementData(thePlayer, "visz:viszi") then
			local x, y, z = getElementPosition(thePlayer)
			setElementPosition(getElementData(thePlayer, "visz:viszi"), x, y+0.5, z)
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Você soltou a pessoa que estava carregando!", "info")
			
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
				end
			end
		end
	end
addCommandHandler("soltar", movePlayer, false, false)






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

function onQuit()
	if getElementData(source, "visz:status") == 2 then
		for k, v in ipairs(getElementsByType("player")) do
			if getElementData(v, "visz:viszi") == source then
				endVisz(v)
				triggerClientEvent(v, "bgo>info", v,"O policial foi desconectado, então Você e liberado.", "info")
			end
		end
	elseif getElementData(source, "visz:status") == 1 then
		for k, v in ipairs(getElementsByType("player")) do
			if getElementData(v, "visz:vive") == source then
				endVisz2(v, source)
				triggerClientEvent(v, "bgo>info", v,"O policial foi desconectado, então Você e liberado.", "info")
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
					triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Colocando a pessoa no veiculo.", "info")
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
					triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Removendo a pessoa no veiculo.", "info")
					setElementFrozen(getElementData(thePlayer, "viszi:viszi"), true)
					attachElements (getElementData(thePlayer, "visz:viszi"), thePlayer, 0, 0.5, 0 )
					timer[getElementData(thePlayer, "acc:id")] = setTimer(function()
					  if not thePlayer then killTimer(timer[getElementData(thePlayer, "acc:id")]) else
					  	x, y, z = getElementPosition(thePlayer)
						int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
						setElementPosition(getElementData(thePlayer, "visz:viszi"), x, y+0.5, z)
						setElementInterior(getElementData(thePlayer, "visz:viszi"), int)
						setElementDimension(getElementData(thePlayer, "visz:viszi"), dim)
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


function outputLicensePlate ( thePlayer, command, texto )
		if getElementData(thePlayer, "char:dutyfaction") == 1 or tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7 or exports.bgo_admin:isPlayerDuty(thePlayer) then 
		if not texto then 
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Uso correto", "/"..command.." [Plca do veiculo]", "info")
		return 
		end
		
		
		local x,y,z = getElementPosition(thePlayer)
		local tabela = getElementsWithinRange( x, y, z, 6, "vehicle" )
		local value = nil
		for i = 1, #tabela do
		value = tabela[i]
        local plateText = getVehiclePlateText ( value )
		if plateText == texto then
			if tonumber(getElementData(value, "veh:owner") or 0) > 0 or getElementData(value, "veh:owner") or (getElementData(value, "owner")) then
			local owner = getElementData(value,"veh:owner") --""
				if not owner then
					owner = getElementData(value, "owner")
			end
			local x,y,z = getElementPosition(value)
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, owner)
			if targetPlayer then
					triggerClientEvent(thePlayer, "checkCarsPolicia", thePlayer, targetPlayer, value, targetPlayerName, x,y,z)
					triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Analisando veiculo", "Puxano dados do veiculo!", "info")
					
					if getElementData(thePlayer, "char:dutyfaction") == 1 then
					triggerClientEvent(targetPlayer, "bgo>info", targetPlayer,"Analisando veiculo", "Um DRVV está puxando os dados do seu veiculo!  Placa do veiculo: "..plateText.."", "info")
					else
					triggerClientEvent(targetPlayer, "bgo>info", targetPlayer,"Analisando veiculo", "Um policial está puxando os dados do seu veiculo!  Placa do veiculo: "..plateText.."", "info")
					end
					
					end
				end
				break
			end
		end	
    end
end
addCommandHandler( "analisar", outputLicensePlate )




