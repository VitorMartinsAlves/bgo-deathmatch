addEvent("BGO.onPortaMalasAlgemado", true)
addEvent("BGO.onClosePortaMalasAlgemado", true)

local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}}

function startPanel()
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 300, 300, "Porta Malas", false)
	

	
	
	centerWindow(painel.window[1])
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	dgs:dgsSetProperty(painel.window[1], "font", "arial")
	dgs:dgsCreateLabel(56, 255, 0, 0, "Pressione ' backspace ' para fechar", false, painel.window[1], tocolor(255, 255, 255, 200))
	--dgs:dgsWindowSetCloseButtonEnabled(painel.window[1], false)

	painel.tab[1] = dgs:dgsCreateTabPanel(2, 2, 296, 250, false, painel.window[1])
	painel.tab[2] = dgs:dgsCreateTab("Algemados Por Perto", painel.tab[1])
	painel.tab[3] = dgs:dgsCreateTab("Algemados No Veículo", painel.tab[1])

	addEventHandler("onDgsTabSelect", painel.tab[1],
		function(_, _, select)
			if select == painel.tab[3] then
				if isElement(veh) then
					dgs:dgsGridListClear(painel.grid[2])
					local preso1 = getElementData(veh, "PresoMalas1")
					local preso2 = getElementData(veh, "PresoMalas2")
					if preso1 and isElement(preso1) and getElementType(preso1) == "player" then
						local row = dgs:dgsGridListAddRow(painel.grid[2])
						dgs:dgsGridListSetItemText(painel.grid[2], row, painel.column[2], removeHex(getPlayerName(preso1)))
					end
					if preso2 and isElement(preso2) and getElementType(preso2) == "player" then
						local row = dgs:dgsGridListAddRow(painel.grid[2])
						dgs:dgsGridListSetItemText(painel.grid[2], row, painel.column[2], removeHex(getPlayerName(preso2)))
					end
				end
			end
		end
	)

	painel.grid[1] = dgs:dgsCreateGridList(2, 2, 292, 170, false, painel.tab[2])
	painel.column[1] = dgs:dgsGridListAddColumn(painel.grid[1], "Jogadores", 1)
	painel.button[1] = dgs:dgsCreateButton(98, 184, 110, 35, "Colocar", false, painel.tab[2])

	painel.grid[2] = dgs:dgsCreateGridList(2, 2, 292, 170, false, painel.tab[3])
	painel.column[2] = dgs:dgsGridListAddColumn(painel.grid[2], "Jogadores", 1)
	painel.button[2] = dgs:dgsCreateButton(98, 184, 110, 35, "Retirar", false, painel.tab[3])
end

setElementData(localPlayer, "navtr", nil)

addEventHandler("BGO.onPortaMalasAlgemado", root,
	function(players, vehicle)
		if not isElement(painel.window[1]) then
		startPanel()
		addEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
		end
		showCursor(true)
		playSoundFrontEnd(20)
		veh = vehicle
		if players ~= nil and type(players) == "table" then
			for _, v in ipairs(players) do
				if v ~= localPlayer and getElementData(v, "algemado") and not getElementData(v, "navtr") and not isPedInVehicle(v) then
					local row = dgs:dgsGridListAddRow(painel.grid[1])
					dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], removeHex(getPlayerName(v)))
				end
			end
		end
	end
)

addEventHandler("onDgsMouseClick", root,
	function(button, state)
		if button == "left" and state == "down" then
			if source == painel.button[1] then
				local selected = dgs:dgsGridListGetSelectedItem(painel.grid[1])
				if selected ~= -1 then
					local name = dgs:dgsGridListGetItemText(painel.grid[1], selected, painel.column[1])
					if isElement(veh) then
						local preso1 = getElementData(veh, "PresoMalas1")
						local preso2 = getElementData(veh, "PresoMalas2")
						if preso1 and preso2 then
							return outputChatBox("O Veículo já Possuí 2 Jogadores no Porta Malas!", 255,0,0)
						end
						triggerServerEvent("BGO.onButtonPortaMalas", localPlayer, name, veh, 1)
					else
						outputChatBox("O Veículo não foi Identificado!", 255,0,0)
					end
				else
					outputChatBox("Selecione um Jogador!", 255,0,0)
				end
			elseif source == painel.button[2] then
				local selected = dgs:dgsGridListGetSelectedItem(painel.grid[2])
				if selected ~= -1 then
					local name = dgs:dgsGridListGetItemText(painel.grid[2], selected, painel.column[2])
					if isElement(veh) then
						triggerServerEvent("BGO.onButtonPortaMalas", localPlayer, name, veh, 2)
					else
						outputChatBox("O Veículo não foi Identificado!", 255,0,0)
					end
				else
					outputChatBox("Selecione um Jogador!", 255,0,0)
				end
			end
		end
	end
)

addEventHandler("onClientClick", root,
	function(button, state, _, _, _, _, _, click)
	if not isElement(painel.window[1]) then
		if button == "left" and state == "down" then
			if not isPedInVehicle(localPlayer) then
				if isElement(click) and getElementType(click) == "vehicle" then
					local x, y, z = getElementPosition(localPlayer)
					local vx, vy, vz = getElementPosition(click)
					if getDistanceBetweenPoints3D(x, y, z, vx, vy, vz) <= 5 then
						for _, v in ipairs(config.veh) do
							if getElementModel(click) == v then
								triggerServerEvent("BGO.onRequestACLAlgemado", localPlayer, click)
								break
							end
						end
					end
				end
			end
		end
	end
	end
)

addEventHandler("onClientKey", root,
	function(button)
		if button == "backspace" then
			fecharPainel()
		end
	end
)

function fecharPainel()
		--cancelEvent()
	if isElement(painel.window[1]) then
		playSoundFrontEnd(20)
		destroyElement(painel.window[1])
		showCursor(false)
		if players then
			players = nil
		end
		if veh then
			veh = nil
		end
	end
end
addEventHandler("BGO.onClosePortaMalasAlgemado", root, fecharPainel)


function RemoveCol(fogger)
	setElementCollisionsEnabled(fogger, false)
end
addEvent("ClientRemoveCol",true)
addEventHandler("ClientRemoveCol", getRootElement(), RemoveCol)


function AddCol(fogger)
	setElementCollisionsEnabled(fogger, true)
end
addEvent("ClientAddCol",true)
addEventHandler("ClientAddCol", getRootElement(), AddCol)



function removeHex(s)
	if type(s) == "string" then
		while (s ~= s:gsub("#%x%x%x%x%x%x", "")) do
			s = s:gsub("#%x%x%x%x%x%x", "")
		end
	end
	return s or false
end

function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end