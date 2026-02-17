if fileExists("sourceC.lua") then 
	fileDelete("sourceC.lua")
end

addEventHandler("onClientVehicleCollision", root, function(collider, force, bodyPart, x, y, z, nx, ny, nz)
    if source == getPedOccupiedVehicle(localPlayer) then
		local fDamageMultiplier = getVehicleHandling(source).collisionDamageMultiplier
		local realDamage = (force*fDamageMultiplier)*0.1
		local damage = (force*fDamageMultiplier)
		
		if realDamage > 15 then
			realDamage = realDamage/3
			if getElementData(localPlayer, "ov") then
				setElementHealth(localPlayer, getElementHealth(localPlayer) - realDamage/2)
			else
				setElementHealth(localPlayer, getElementHealth(localPlayer) - realDamage)
			end
		end
		if damage > 220 then 
			if getOnlineFiremanPlayers() > 2 then  
				toggleAllControls(false)
				toggleControl("enter_exit", false)
				triggerEvent('wlsMTA->#loadHit', root)
				if tonumber(getElementHealth(localPlayer)) > 20 then
					setElementHealth(localPlayer, 20)
				end
				if getVehicleType(source) == 'Automobile' or getVehicleType(source) == 'Plane' or getVehicleType(source) == 'Helicopter' then 
					-- triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, "car", "flag_drop", 1, true)
					triggerServerEvent('wlsMTA->#messagetoFireman', localPlayer, localPlayer, 6)
					setElementData(localPlayer, 'char->stuck', true)
					setElementData(source, 'car->stuck', true)
					for i=2, 5 do 
						setElementData(source, 'car->stuckDoor' ..i, true)
					end 
				end
			end
		end
    end
end)

addEventHandler('onClientResourceStart', resourceRoot, function()
	if getElementData(localPlayer, 'char->stuck') and isPedInVehicle(localPlayer) then
		if getOnlineFiremanPlayers() > 1 then -- 1 
			local vehicles = getPedOccupiedVehicle(localPlayer)
			toggleAllControls(false)
			toggleControl("enter_exit", false)
			triggerEvent('wlsMTA->#loadHit', localPlayer)
			triggerServerEvent('wlsMTA->#messagetoFireman', localPlayer, localPlayer, 6)
			if tonumber(getElementHealth(localPlayer)) > 20 then
				if getVehicleType(vehicles) == 'Automobile' or getVehicleType(vehicles) == 'Plane' or getVehicleType(vehicles) == 'Helicopter' then 
					-- triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, "car", "flag_drop", 1, true)
					setElementData(localPlayer, 'char->stuck', true)
					setElementData(vehicles, 'car->stuck', true)
					for i=2, 5 do 
						setElementData(vehicles, 'car->stuckDoor' ..i, true)
					end
					setElementHealth(localPlayer, 20)
				end
			end
		end
	end
end)

local show = false
local panelX = 0
local panelY = 0 
local monitorScreen = {guiGetScreenSize()}
local panelSize = {140, 260}
local font = dxCreateFont('files/Calibri.ttf', 9)
local menu = {{'Remoção danificada', 89, 171, 227}, {'Manipulação de Portas', 235, 149, 50}, {'afunilar', 235, 149, 50}, {'corte de energia', 235, 149, 50}, {'encerramento', 210, 77, 87}}
local door = {{'Abrindo o capô', 0, ''}, {'Trecho da frente esquerda', 2, 'door_lf_dummy'}, {'Alongamento dianteiro direito', 3, 'door_rf_dummy'}, {'Estiramento traseiro esquerdo', 4, 'door_lr_dummy'}, {'Estiramento traseiro direito', 5, 'door_rr_dummy'}}
local seats = {
	[0] = {'Banco dianteiro esquerdo'},
	[1] = {'Banco dianteiro direito'},
	[2] = {'Banco traseiro esquerdo'},
	[3] = {'Assento traseiro direito'},
}
local vehicle = false
local occupants = false
local state = 1
local text = ''
local progress = 0
local plusProgres = 0
local playerValue = 0
local progresing = false
local progresTimer = false
local sound = false
local doorNumber = 0
local accident_Blips = {}
local accident_Marker = {}

local currentOperation = ''



addEventHandler('onClientClick', root, function(button, states, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if button == 'left' and states == 'down' and not show and clickedElement and not isPedInVehicle(localPlayer) and getElementType(clickedElement) == "vehicle" then 
		if exports['wls_groups']:isPlayerInFaction(localPlayer, 6) and getElementData(localPlayer, "char.inDuty") or 0 > 1 then
			if clickedElement and not getElementData(clickedElement, 'car->stuck') then return end
			local x, y, z = getElementPosition(getLocalPlayer())
			local playerx, playery, playerz = getElementPosition(clickedElement)
			if (getDistanceBetweenPoints3D(x, y, z, playerx, playery, playerz) <= 5) then
				panelX = absoluteX
				panelY = absoluteY
				vehicle = clickedElement
				show = true
				state = 1
				removeEventHandler("onClientRender", root, createRenderPanel)
				addEventHandler("onClientRender", root, createRenderPanel)
			end
		else
			--outputChatBox("#D24D57[bombeiros]:#ffffff Nem vagy frakcióba/dutyba!", 255, 255, 255, true)
		end
	elseif button == "left" and states == "down" and show then
		if isTimer(timer) then return end
		timer = setTimer(function() end, 1000, 1) --- spam védelem
		if state == 1 then 
			for index, value in ipairs (menu) do 
				if isMouseInPosition(panelX+10, panelY-10+index*45, panelSize[1]-20, 40) then
					if progress == 0 then 
						if index == 1 then 
							if getVehicleEngineState ( vehicle ) then outputChatBox("#D24D57[bombeiros]:#ffffff Você não pode iniciar o remoção técnico até tê-lo #F7CA18'Dasativado' #ffffffo veículo!", 255, 255, 255, true) return end
							state = 3
						elseif index == 2 then
							state = 2
						elseif index == 3 then
							if exports['wls_items']:hasItem(localPlayer, 74) then 
								if isElementFrozen (vehicle) then 
									playerValue = 0
									occupants = getVehicleOccupants(vehicle) or {} 
									for seat, occupant in pairs(occupants) do 
										if (occupant and getElementType(occupant) == "player") then
											playerValue = playerValue + 1
										end
									end
									if playerValue == 0 then 
										triggerServerEvent('wlsMTA->#setFrozen', vehicle, vehicle, false)
										progresTimer = setTimer(function ()
											progress = progress + plusProgres
										end, 100, 0)
										progress = 0
										plusProgres = 2
										progresing = true
										currentOperation = 'Removendo a lataria do veículo...'
										triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, "BOMBER", "BOM_Plant", -1, true)

									else
										outputChatBox('#D24D57[bombeiros]:#ffffff Você só pode remover a lataria se o veículo estiver completamente vazio!', 255, 255, 255, true)
									end
								else
									progresTimer = setTimer(function ()
										progress = progress + plusProgres
									end, 100, 0)
									triggerServerEvent('wlsMTA->#setFrozen', vehicle, vehicle, true)
									progress = 0
									plusProgres = 2
									progresing = true
									currentOperation = 'Quebrando o veículo...'
									triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, "BOMBER", "BOM_Plant", -1, true)
								end
							else
								outputChatBox("#D24D57[bombeiros]:#ffffff Não há ferramenta adequada para você realizar a operação! (#F7CA18'Alicate' #ffffff)", 255, 255, 255, true)
							end
						elseif index == 4 then
							if not isElementFrozen ( vehicle ) then outputChatBox("#D24D57[bombeiros]:#ffffff Você não pode iniciar o remoção técnico até tê-lo #F7CA18'com chave' #ffffffa jármű!", 255, 255, 255, true) return end
							if exports['wls_items']:hasItem(localPlayer, 75) then
								if (getVehicleDoorOpenRatio(vehicle, 0) == 1) or getElementModel(vehicle) == 431  or getElementModel(vehicle) == 578  or getElementModel(vehicle) == 437  or getElementModel(vehicle) == 407 then 
									triggerServerEvent('wlsMTA->#stopEngine', vehicle, vehicle)
									triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, "BOMBER", "BOM_Plant", -1, true)
									if isTimer(progresTimer) then 
										killTimer(progresTimer)
									end
									progresTimer = setTimer(function ()
										progress = progress + plusProgres
									end, 100, 0)
									progress = 0
									plusProgres = 2
									progresing = true
									currentOperation = 'Desconectando o veículo...'
									
								else
									outputChatBox('#D24D57[bombeiros]:#ffffff Primeiro você precisa abrir o capô!', 255, 255, 255, true)
								end
							else
								outputChatBox("#D24D57[bombeiros]:#ffffff Não há ferramenta adequada para você realizar a operação! (#F7CA18'chave' #ffffff)", 255, 255, 255, true)
							end
							
						elseif index == 5 then 
							show = false
							removeEventHandler("onClientRender", root, createRenderPanel)
							if isTimer(progresTimer) then 
								killTimer(progresTimer)
							end
						end
					end
				end
			end
		elseif state == 2 then 
			for index, value in ipairs (door) do 
				if isMouseInPosition(monitorScreen[1]-200, monitorScreen[2]/2-265/2-15+index*45, 180, 40) then 
					if not isElementFrozen ( vehicle ) then outputChatBox("#D24D57[bombeiros]:#ffffff Você não pode começar a mudança até que você a tenha #F7CA18'com chave' #ffffffa veículo!", 255, 255, 255, true) return end
					if value[2] == 0 then 
						triggerServerEvent('wlsMTA->#openDoor', vehicle, vehicle, value[2])
						state = 1
					else
						if exports['wls_items']:hasItem(localPlayer, 73) then 
							if progress == 0 then 
								if getVehicleEngineState ( vehicle ) then outputChatBox("#D24D57[bombeiros]:#ffffff Você não pode começar a mudança até que você a tenha #F7CA18'Desligado' #ffffffa veículo!", 255, 255, 255, true) return end
								triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, "SWORD", "sword_IDLE", -1, true)
								progresTimer = setTimer(function ()
									progress = progress + plusProgres
								end, 100, 0)
								-- show = false
								progress = 0
								plusProgres = 1
								currentOperation = 'Cortando a porta do veículo...'
								doorNumber = value[2]
								progresing = true
								triggerServerEvent('wlsMTA->#startPlaySound', vehicle, vehicle, true)
							end
						else
							outputChatBox("#D24D57[bombeiros]:#ffffff Não há ferramenta adequada para você realizar a operação! (#F7CA18'cortando tensão' #ffffff)", 255, 255, 255, true)
						end
					end
				end
			end
		elseif state == 3 then 
			occupants = getVehicleOccupants(vehicle) or {} 
			for seat, occupant in pairs(occupants) do 
				if (occupant and getElementType(occupant) == "player") then
					if not getElementData(vehicle, 'car->stuckDoor' ..seat+2) then 
						if isMouseInPosition(monitorScreen[1]-200, monitorScreen[2]/2-265/2-15+(seat+1)*45, 180, 40) then 
							triggerServerEvent('wlsMTA->#removePlayerVehicle', occupant, occupant, localPlayer)
							if isTimer(progresTimer) then 
								killTimer(progresTimer)
							end
							state = 1
						end
					else
						outputChatBox('#D24D57[bombeiros]:#ffffff A porta está apertada, então você não pode tirar o ferido!', 255, 255, 255, true)
					end
				end
			end
		end
	end
end)

function createRenderPanel()
	local jX, jY, jZ = getElementPosition(getLocalPlayer())
	local bX, bY, bZ = getElementPosition(vehicle)
	
	if (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then removeEventHandler("onClientRender", root, createRenderPanel) show = false end
	
	if progresing then 
		dxDrawRectangle(monitorScreen[1]/2-200/2, monitorScreen[2]-100, 200, 30, tocolor(0, 0, 0, 170))
		dxDrawRectangle(monitorScreen[1]/2-200/2+1, monitorScreen[2]-100+1, progress, 28, tocolor(89, 171, 227, 240)) -- currentOperation
		dxDrawText(currentOperation, monitorScreen[1]/2-200/2+200/2+1, monitorScreen[2]-100+30/2+1, monitorScreen[1]/2-200/2+200/2+1, monitorScreen[2]-100+30/2+1, tocolor(0, 0, 0, 240), 1, font, "center", "center", false, false, false, true)			
		dxDrawText(currentOperation, monitorScreen[1]/2-200/2+200/2, monitorScreen[2]-100+30/2, monitorScreen[1]/2-200/2+200/2, monitorScreen[2]-100+30/2, tocolor(255, 255, 255, 240), 1, font, "center", "center", false, false, false, true)			
		if progress >= 198 then
			if state == 2 then 
				triggerServerEvent('wlsMTA->#setVisible', vehicle, vehicle, tonumber(doorNumber))
				show = true
				if isTimer(progresTimer) then 
					killTimer(progresTimer)
				end
				triggerServerEvent('wlsMTA->#startPlaySound', vehicle, vehicle, false)
			end
			if isTimer(progresTimer) then 
				killTimer(progresTimer)
			end
			progress = 0
			progresing = false
			state = 1
			triggerServerEvent('wlsMTA->#setPlayerAnimation', localPlayer, localPlayer, nil, nil, -1, false)
		end
	end
	
	if show then 
		if state == 1 then 
			dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2], tocolor(0, 0, 0, 170))
			dxDrawRectangle(panelX, panelY, panelSize[1], 25, tocolor(0, 0, 0, 240))
			dxDrawText("BGO RP", panelX+panelSize[1]/2, panelY+25/2, panelX+panelSize[1]/2, panelY+25/2, tocolor(245, 245, 245, 240), 1, font, "center", "center", false, false, false, true)
			for index, value in ipairs(menu) do 
				dxDrawRectangle(panelX+10, panelY-10+index*45, panelSize[1]-20, 40, tocolor(0, 0, 0, 170))
				if isElementFrozen ( vehicle )  and (value[1] == 'afunilar' or value[1] == 'Retirar') then 
					text = 'Retirar'
				else
					text = value[1]
				end
				if isMouseInPosition(panelX+10, panelY-10+index*45, panelSize[1]-20, 40) then 
					dxDrawRectangle(panelX+15, panelY-10+index*45+5, panelSize[1]-30, 30, tocolor(value[2], value[3], value[4], 170))
					dxDrawText(text, panelX+panelSize[1]/2, panelY-10+index*45+40/2, panelX+panelSize[1]/2, panelY-10+index*45+40/2, tocolor(0, 0, 0, 240), 1, font, "center", "center", false, false, false, true)			
				else
					dxDrawText(text, panelX+panelSize[1]/2, panelY-10+index*45+40/2, panelX+panelSize[1]/2, panelY-10+index*45+40/2, tocolor(255, 255, 255, 240), 1, font, "center", "center", false, false, false, true)
				end
			end
		elseif state == 2 then 
			dxDrawRectangle(monitorScreen[1]-200-10, monitorScreen[2]/2-265/2, 200, 265, tocolor(0, 0, 0, 170))
			dxDrawRectangle(monitorScreen[1]-200-10, monitorScreen[2]/2-265/2, 200, 25, tocolor(0, 0, 0, 240))
			dxDrawText("BGORP - portas", monitorScreen[1]-200-10+200/2, monitorScreen[2]/2-265/2+25/2, monitorScreen[1]-200-10+200/2, monitorScreen[2]/2-265/2+25/2, tocolor(245, 245, 245, 240), 1, font, "center", "center", false, false, false, true)
			for index, value in ipairs(door) do 
				dxDrawRectangle(monitorScreen[1]-200, monitorScreen[2]/2-265/2-15+index*45, 180, 40, tocolor(0, 0, 0, 170))
				if isMouseInPosition(monitorScreen[1]-200, monitorScreen[2]/2-265/2-15+index*45, 180, 40) or (value[2] == 0 and getVehicleDoorOpenRatio(vehicle, value[2]) == 1) then 
					dxDrawRectangle(monitorScreen[1]-200+5, monitorScreen[2]/2-265/2-10+index*45, 170, 30, tocolor(235, 149, 50, 170))
					dxDrawText(value[1], monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+index*45+40/2, monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+index*45+40/2, tocolor(0, 0, 0, 240), 1, font, "center", "center", false, false, false, true)
				else
					dxDrawText(value[1], monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+index*45+40/2, monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+index*45+40/2, tocolor(255, 255, 255, 240), 1, font, "center", "center", false, false, false, true)
				end
			end
		elseif state == 3 then 
			dxDrawRectangle(monitorScreen[1]-200-10, monitorScreen[2]/2-265/2, 200, 265, tocolor(0, 0, 0, 170))
			dxDrawRectangle(monitorScreen[1]-200-10, monitorScreen[2]/2-265/2, 200, 25, tocolor(0, 0, 0, 240))
			dxDrawText("BGORP - recuperando", monitorScreen[1]-200-10+200/2, monitorScreen[2]/2-265/2+25/2, monitorScreen[1]-200-10+200/2, monitorScreen[2]/2-265/2+25/2, tocolor(245, 245, 245, 240), 1, font, "center", "center", false, false, false, true)
			occupants = getVehicleOccupants(vehicle) or {} 
			for seat, occupant in pairs(occupants) do 
				if (occupant and getElementType(occupant) == "player") then
					dxDrawRectangle(monitorScreen[1]-200, monitorScreen[2]/2-265/2-15+(seat+1)*45, 180, 40, tocolor(0, 0, 0, 170))
					if isMouseInPosition(monitorScreen[1]-200, monitorScreen[2]/2-265/2-15+(seat+1)*45, 180, 40) then 
						dxDrawRectangle(monitorScreen[1]-200+5, monitorScreen[2]/2-265/2-10+(seat+1)*45, 170, 30, tocolor(235, 149, 50, 170))
						dxDrawText(seats[seat][1], monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+(seat+1)*45+40/2, monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+(seat+1)*45+40/2, tocolor(0, 0, 0, 240), 1, font, "center", "center", false, false, false, true)
					else
						dxDrawText(seats[seat][1], monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+(seat+1)*45+40/2, monitorScreen[1]-200+180/2, monitorScreen[2]/2-265/2-15+(seat+1)*45+40/2, tocolor(255, 255, 255, 240), 1, font, "center", "center", false, false, false, true)
					end
				end
			end
		end
	end
end

addEvent('wlsMTA->#playSound', true)
addEventHandler('wlsMTA->#playSound', root, function(states)
	if states then 
		if isElement(sound) then 
			stopSound(sound)
		end
		local x, y, z = getElementPosition(source)
		sound = playSound3D('files/sound.mp3', x, y, z, true)
		setSoundMaxDistance( sound, 10 )
	else
		if isElement(sound) then 
			stopSound(sound)
		end
	end
end)


addEvent('wlsMTA->#createMarkerAndBlip', true)
addEventHandler('wlsMTA->#createMarkerAndBlip', root, function()
	local x, y, z = getElementPosition(source)
	if exports['wls_groups']:isPlayerInFaction(localPlayer, 6) and localPlayer ~= source then
		accident_Marker[source] = createMarker( x , y , z, "checkpoint", 4, 235, 149, 50, 255 )
		accident_Blips[source] = createBlip(x , y , z, 17)
		setElementData(accident_Marker[source], 'accident_called', source)
	end
end)

local target_Player 


addEventHandler ( "onClientMarkerHit", getRootElement(), function (player)
	if player ~= getLocalPlayer() then return end
	target_Player = getElementData(source, 'accident_called') or false
	triggerServerEvent('wlsMTA->#destroyBlipS', localPlayer, source, target_Player)
end)

addEvent('wlsMTA->#destroyBlip', true)
addEventHandler('wlsMTA->#destroyBlip', root, function(player)
	if target_Player and exports['wls_groups']:isPlayerInFaction(localPlayer, 6) then 
		if isElement(accident_Marker[target_Player]) then 
			destroyElement(accident_Marker[target_Player])
		end
		if isElement(accident_Blips[target_Player]) then 
			destroyElement(accident_Blips[target_Player])
		end
	end
end)

addEventHandler('onClientPlayerQuit', root, function ()
	if source then 
		if isElement(accident_Marker[source]) then 
			destroyElement(accident_Marker[source])
		end
		if isElement(accident_Blips[source]) then 
			destroyElement(accident_Blips[source])
		end
	end
end)

function getOnlineFiremanPlayers()
	local fireman = 0
	for k,v in ipairs (getElementsByType("player")) do
		if exports['wls_groups']:isPlayerInFaction(v, 6) then
			fireman = fireman + 1
		end
	end
	return tonumber(fireman)
end

function isMouseInPosition ( x, y, width, height ) 
    if ( not isCursorShowing ( ) ) then 
        return false 
    end 
  
    local sx, sy = guiGetScreenSize ( ) 
    local cx, cy = getCursorPosition ( ) 
    local cx, cy = ( cx * sx ), ( cy * sy ) 
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then 
        return true 
    else 
        return false 
    end 
end 