addEvent("ColocarNoTrajeto", true)
addEvent("BGO.onClosePainelG", true)
addEvent("LimparTrajeto", true)
local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}}

function startPanel()
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 300, 325, "Transporte de Gasolina", false)
	centerWindow(painel.window[1])
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	dgs:dgsSetProperty(painel.window[1], "font", "arial")
	painel.tab[1] = dgs:dgsCreateTabPanel(2, 2, 296, 295, false, painel.window[1])
	painel.tab[2] = dgs:dgsCreateTab("Trajetos", painel.tab[1])
	painel.grid[1] = dgs:dgsCreateGridList(2, 2, 292, 170, false, painel.tab[2])
	painel.column[1] = dgs:dgsGridListAddColumn(painel.grid[1], "Região", 0.6)
	painel.column[2] = dgs:dgsGridListAddColumn(painel.grid[1], "Valor", 0.5)
	--painel.column[3] = dgs:dgsGridListAddColumn(painel.grid[1], "Valor", 0.5)	
	painel.button[1] = dgs:dgsCreateButton(98, 184, 110, 35, "Pegar", false, painel.tab[2])
	painel.button[2] = dgs:dgsCreateButton(98, 234, 110, 35, "Atualizar", false, painel.tab[2])
end

local tabela = {}

addEventHandler("LimparTrajeto", root,
	function()
		if isElement(painel.window[1]) then
		dgs:dgsGridListClear(painel.grid[1])
		end
	end
)



addEventHandler("ColocarNoTrajeto", root,
	function(x,y,z, bomba, location, city, randomc)
		if isElement(painel.window[1]) then
		tabela[location] = {x,y,z, bomba, location, city, randomc}			
		local row = dgs:dgsGridListAddRow(painel.grid[1])
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], tabela[location][5])

		local xx,yy,zz = getElementPosition(localPlayer)
		local distance2 = getDistanceBetweenPoints3D(tabela[location][1], tabela[location][2],tabela[location][3], xx, yy, zz)


		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[2], math.floor(distance2/3))
		
		--dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[3], tabela[location][7])
		
		end
	end
)



addEventHandler("onDgsMouseClick", root,
	function(button, state)
		if button == "left" and state == "down" then
		if isTimer(tempo) then outputChatBox("Aguarde um pouco para atualizar novamente!", 255,0,0) return end
			if source == painel.button[1] then
			if isPedInVehicle(localPlayer) then
				local selected = dgs:dgsGridListGetSelectedItem(painel.grid[1])
				if selected ~= -1 then
					local name = dgs:dgsGridListGetItemText(painel.grid[1], selected, painel.column[1])
					tempo = setTimer(function() end,2000,1)
						triggerServerEvent("BGO.ClickGasolina", localPlayer, localPlayer, tabela[name])
						triggerServerEvent("retirartrajetoPainel", localPlayer, tabela[name][7])
						tabela[name] = nil
				else
					outputChatBox("Nada selecionado!", 255,0,0)
				end
				else
				outputChatBox("Entre no veiculo para começar a trabalhar!", 255,0,0)
				end
			elseif source == painel.button[2] then
			tempo = setTimer(function() end,2000,1)
			triggerServerEvent("buscartrajetoPainel", localPlayer, localPlayer)
			end
		end
	end
)


--[[
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
local open = false
addEventHandler("onClientKey", root,
	function(button)
		if button == "backspace" then
			fecharPainel()
		end
	end
)
]]--
local open = false
function fecharPainel()
		--cancelEvent()
	if isElement(painel.window[1]) then
	removeEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
		playSoundFrontEnd(20)
		destroyElement(painel.window[1])
		showCursor(false)
		open = false
	end
end
addEventHandler("BGO.onClosePainelG", root, fecharPainel)


function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end



function OpenWin()
	if open == false then
	open = true
	if not isElement(painel.window[1]) then
	startPanel()
	end
	addEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
	showCursor(true)
	--triggerServerEvent("buscartrajetoPainel", localPlayer, localPlayer)
	playSoundFrontEnd(20)
	end
end
addEvent("AbrirPainelG", true)
addEventHandler("AbrirPainelG", root, OpenWin)