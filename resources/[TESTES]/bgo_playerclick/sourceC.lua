local monitorScreen = {guiGetScreenSize()}
local panelSize = {200, 260}
local panelX 
local panelY  
local Player
local Marker
local Font = dxCreateFont("files/myriadproregular.ttf", 9)
local Font2 = dxCreateFont("files/myriadproregular.ttf", 12)
local active_Menu = {{"Algemar"}, {"Revistar"}, {"Carregar"}, {"Fechar"},}

local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}, edit={}}



function renderAnimation()
    for k, v in ipairs(getElementsByType("player")) do             
        if getElementData(v, "algemado") then
            local theVehicle = getElementData(v, "navtr") --getPedOccupiedVehicle ( v )
            if not theVehicle then
                local block, animation = getPedAnimation(v)
                if animation ~= "pass_Smoke_in_car" then
				setPedAnimation(v, "ped", "pass_Smoke_in_car", 0, true, false, false)
				setPedAnimationSpeed(v,"pass_Smoke_in_car", 0)
				--setPedAnimationProgress(v, 'pass_Smoke_in_car', 0)
                end
            end
        end
    end
end
setTimer(renderAnimation,70,0)

local show = false

addEventHandler("onClientClick", root, function(button, state, absX, absY, elementX, elementY, elementZ, element)
	if button == "right" and state == "down" and element and element ~= localPlayer and getElementType(element)=="player" then 
		local x, y, z = getElementPosition(getLocalPlayer())
		local playerx, playery, playerz = getElementPosition(element)
		if (getDistanceBetweenPoints3D(x, y, z, playerx, playery, playerz) <= 3) then
		--if exports.bgo_admin:isPlayerDuty(getLocalPlayer())  or getElementData(getLocalPlayer(),"char:id") == 1 then
		if exports['bgo_items']:hasItem(localPlayer, 32) then 
		if not isElement(painel.window[1]) then
			panelX = absX
			panelY = absY
			Player = element	
			local x2,y2,z2 = getElementPosition(Player)
			PainelGeral(x2,y2,z2)
			addEventHandler("onDgsWindowClose",painel.window[1],closer)
			addEventHandler('onClientRender', root, attFaceTo)
				end
			end
		end
	end
end)

function createMarkerFunction(PlayerX,PlayerY,PlayerZ)
	if isElement(Marker) then 
		destroyElement(Marker)
	end
	Marker = createMarker ( PlayerX,PlayerY,PlayerZ+1.7, "arrow", 0.4, 25, 181, 254, 170 )
end


addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()), function()
	txd = engineLoadTXD('cuff.txd',364)
	engineImportTXD(txd,364)
	dff = engineLoadDFF('cuff.dff',364)
	engineReplaceModel(dff,364)
end)

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)
	
	
function PainelGeral(x,y,z)
	if not isElement(painel.window[1])  then
	x1,y2,z3 = x,y,z
	--panel = dgs:dgsCreate3DInterface(x1,y2+1,z3,6, 6,screenW,screenH,tocolor(255,255,255,255))
	painel.window[1] = dgs:dgsCreateWindow(1100, 500, 250, 250, "BGO MTA", false, 0xFFFFFFFF)	
	
	--dgs:dgsSetParent(painel.window[1], panel)
	--dgs:dgsWindowSetMovable ( painel.window[1], false )
	centerWindow(painel.window[1])
	for index, value in ipairs (active_Menu) do 
	if Player:getData("char.Cuffed") == 1 and value[1] == "Algemar" or value[1] == "Remover algemas" then 
		Text = "Remover algemas"
	else
		Text = "Algemar"
	end	
	if Player:getData("char.Carregado") == 1 and value[1] == "Carregar" or value[1] == "Liberar" then 
		Text2 = "Liberar"
	else
		Text2 = "Carregar"
	end
	if value[1] == "Algemar" then 
	painel.button[index] = dgs:dgsCreateButton(0, -0.1+index*0.2, 1, 0.15, Text, true, painel.window[1], tocolor(255, 255, 255, 255), false, false, false, false, false, tocolor(40, 40, 40, 255))
	dgs:dgsSetFont ( painel.button[index], "default-bold" )
	elseif value[1] == "Carregar" then
	painel.button[index] = dgs:dgsCreateButton(0, -0.1+index*0.2, 1, 0.15, Text2, true, painel.window[1], tocolor(255, 255, 255, 255), false, false, false, false, false, tocolor(40, 40, 40, 255))
	dgs:dgsSetFont ( painel.button[index], "default-bold" )
	else
	painel.button[index] = dgs:dgsCreateButton(0, -0.1+index*0.2, 1, 0.15, value[1], true, painel.window[1], tocolor(255, 255, 255, 255), false, false, false, false, false, tocolor(40, 40, 40, 255))
	dgs:dgsSetFont ( painel.button[index], "default-bold" )
	end
	end
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	end
end

function attFaceTo()
			if painel.window[1] then
			local PlayerX,PlayerY,PlayerZ = getElementPosition(Player)
			createMarkerFunction(PlayerX,PlayerY,PlayerZ)
			local px, py, pz = getElementPosition(localPlayer)
			distance = getDistanceBetweenPoints3D(px, py, pz, PlayerX,PlayerY,PlayerZ)
			if distance >= 3 then
			closer()
			if isElement(painel.window[1]) then
			destroyElement(painel.window[1])
			end
		end
	end
end





addEventHandler ( "onDgsMouseClick", root, function(b, s)
    if s == 'down' then
        if source == painel.button[4] then
				closer()
				if isElement(painel.window[1]) then
				destroyElement(painel.window[1])
				end
				elseif source == painel.button[1] then
				--if Player:getData("char.Carregado") == 0 then 
				if exports['bgo_items']:hasItem(localPlayer, 32) then 
				triggerServerEvent("onServerCuff", localPlayer, localPlayer, Player)
				if Player:getData("char.Cuffed") == 1 then 
					dgs:dgsSetText ( painel.button[1], "Algemar" )
				else
					dgs:dgsSetText ( painel.button[1], "Remover algemas" )
				end
				else
				outputChatBox("#4286f4[Erro]: #ffffffVocê não tem algemas!", 255, 255, 255, true)
				end	
				--else
				--outputChatBox("#4286f4[Erro]: #ffffffPrimeiro pare de carregar a pessoa!!", 255, 255, 255, true)
				--end
				elseif source == painel.button[2] then
				if Player:getData("handsup") then 
				if localPlayer:getData("char:genero") == "homem" and Player:getData("char:genero") == "mulher" then
				exports.bgo_chat:sendLocalMeMessage(localPlayer, "Está revistando a bolsa da jogadora" )
				exports['bgo_items']:abririnv(Player)
				triggerServerEvent("revistarmANIM", localPlayer, localPlayer)
				return
				end
				triggerServerEvent("revistarANIM", localPlayer, localPlayer)
				exports['bgo_items']:abririnv(Player)
				exports.bgo_chat:sendLocalMeMessage(localPlayer, "Está revistando o jogador." )
				else
				outputChatBox("#4286f4[Erro]: #ffffffVocê só pode revistar se o jogador estiver com a mão pra cima!!", 255, 255, 255, true)
				end	
				elseif source == painel.button[3] then
				if Player:getData("char.Cuffed") == 1 then
				triggerServerEvent("onServerCarregar", localPlayer, localPlayer, Player)
				if Player:getData("char.Carregado") == 1 then 
				dgs:dgsSetText ( painel.button[3], "Carregar" )
				else
				dgs:dgsSetText ( painel.button[3], "Liberar" )
				end
			end
        end
    end
end )



function closer()
	if isElement(painel.window[1]) then
	removeEventHandler('onClientRender', root, attFaceTo)
	removeEventHandler("onDgsWindowClose",painel.window[1],closer)
	playSoundFrontEnd(20)
	if isElement(Marker) then 
	destroyElement(Marker) 
	end 
	Player = nil
	end
end





function startPanel(veiculo, x,y,z)
	if not isElement(painel.window[1])  then
	x1,y2,z3 = x,y,z+2
	--panel = dgs:dgsCreate3DInterface(x1,y2,z3,2,2,500, 300,tocolor(255,255,255,255))
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 500, 300, "Analizando lista de veiculo", false)
	--dgs:dgsSetParent(painel.window[1], panel)
	--dgs:dgsSetProperties(panel, {1,1,tocolor(255,255,255,255)})
	centerWindow(painel.window[1])
	--dgs:dgsWindowSetMovable ( painel.window[1], false )
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	dgs:dgsSetProperty(painel.window[1], "font", "arial")
	painel.tab[1] = dgs:dgsCreateTabPanel(2, 2, 496, 269, false, painel.window[1])
	painel.tab[2] = dgs:dgsCreateTab("Lista", painel.tab[1])
	painel.grid[1] = dgs:dgsCreateGridList(2, 2, 492, 245, false, painel.tab[2])
	painel.column[1] = dgs:dgsGridListAddColumn(painel.grid[1], "Veiculo", 0.4)
	painel.column[2] = dgs:dgsGridListAddColumn(painel.grid[1], "Detido", 0.2)
	painel.column[3] = dgs:dgsGridListAddColumn(painel.grid[1], "Dono", 0.2)
	painel.column[4] = dgs:dgsGridListAddColumn(painel.grid[1], "Telefone", 0.2)
	end
end




local open = false
function fecharPainel()
		--cancelEvent()
	if isElement(painel.window[1]) then
		removeEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
		playSoundFrontEnd(20)
		--destroyElement(painel.window[1])
		--showCursor(false)
		open = false
	end
end



function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end




function getMyVehicles(target, value, dono, x,y,z)	
	if not isElement(painel.window[1]) then
	startPanel(value, x,y,z)
	end
	addEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
	playSoundFrontEnd(20)
	myVehicles = {}

	table.insert(myVehicles, value)

	if myVehicles then
	if isElement(painel.window[1]) then
		dgs:dgsGridListClear(painel.grid[1])
		
		for key, value in ipairs(myVehicles) do
		local row = dgs:dgsGridListAddRow(painel.grid[1])
		valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
		id = getElementData(value, "veh:id")
		condicao = getElementData(value, "detranAP") --getElementData(value, "veh:oname") or ""
		if condicao then
		detido = "Sim"
		else
		detido = "Não"
		end
		numero = getElementData(target, "char:playedTime")
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], valor)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[2], detido)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[3], dono)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[4], numero)
		end
	end
	end
end
addEvent("checkCarsPolicia", true)
addEventHandler("checkCarsPolicia", root,getMyVehicles)
