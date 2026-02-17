
local loginPanelState = false
local panelX, panelY, panelWidth, rowHeight = 32*relX, 222*relY, 335*relX, 30*relY
local currentCategory = 1
local hoveredMenu = 1

local camisaCont = 0
local calcasCont = 0
local tenisCont = 0
local correnteCont = 0
local relogioCont = 0
local acessoriosCont = 0
local acessoriosCCont = 0
local camisaMax = 26
local calcasMax = 35
local tenisMax = 37
local correnteMax = 11
local relogiosMax = 11
local acessoriosMax = 16
local acessoriosCMax = 56
local previousModel = nil


local notificationData = {
	["text"] = false,
	["height"] = 0,
	["state"] = "",
	["tick"] = 0,
	["timer"] = nil
}
local loginPanelCategories = {
	[1] = {
		["categoryName"] = "Roupas",
		["subMenu"] = {
			[1] = {"camisa", "Camisas/Blusas", camisaCont,false},
			[2] = {"calcas", "Bermudas/Calças", calcasCont,false},
			[3] = {"tenis", "Tenis/Sapatos", tenisCont,false},
			[4] = {"correntes", "Correntes", correnteCont,false},
			[5] = {"relogios", "Relógios", relogiosMax,false},
			[6] = {"acessorios", "Acessórios", acessoriosCont,false},
			[7] = {"acessoriosC", "Chapéus", acessoriosCCCont,false},
			--[7] = {"check", "Limpar tudo?", false},
			[8] = {"button", "Limpar sessão", "limpar"},	
			[9] = {"button", "Aplicar", "comprar"},
			[10] = {"button", "Fechar", "fecharPainel"}, --"NFtoPage2"},
		}
	},
	
	--[[
	[2] = {
		["categoryName"] = "inscrever-se",
		["subMenu"] = {
			[1] = {"input", "nome do usuário", "", 20, false},
			[2] = {"input", "Senha", "", 30, true},
			[3] = {"input", "Senha (2x)", "", 30, true},
			[4] = {"input", "E-mail", "", 30, false},
			[5] = {"button", "inscrever-se", "registerPlayer"},
		}
	}]]--
}



local pricesModel = {}
local previousModel = nil
local pricesModelCalcas = {}
local pricesModelTenis = {}
local pricesModelCorrentes = {}
local pricesModelRelogios = {}
local pricesModelAcessorios = {}
local pricesModelAcessoriosC = {}

function playSoundEffect(soundName)
	if soundName then
		local soundElement = playSound("sounds/"..soundName..".mp3", false)
		
		setSoundVolume(soundElement, 0.5)
	end
end

function createNotification(text)
	if (notificationData["timer"]) then
		if (isTimer(notificationData["timer"])) then
			killTimer(notificationData["timer"])
		end
	end
	
	notificationData = {
		["text"] = text,
		["height"] = 0,
		["state"] = "show",
		["tick"] = getTickCount(),
		["timer"] = nil
	}
	
	playSoundEffect("notification")
end
addEvent("loginNotificationClient", true)
addEventHandler("loginNotificationClient", root, createNotification)




ambiMarkers = { 
	[1] = {1509.9605712891,-1823.1381835938,13.546875},
	[2] = {1668.8020019531,1734.9437255859,10.819000244141},
	[3] = {2869.7722167969,2470.58984375,10.066512107849},
}




for i = 1, #ambiMarkers, 1 do
marker = createMarker(ambiMarkers[i][1], ambiMarkers[i][2],ambiMarkers[i][3]-0.8, "cylinder",3, 255, 200, 0, 20)
local m = marker


local myBlip = createBlipAttachedTo ( m, 45 )
setElementData(myBlip ,"blipName", "Loja de Roupas")

function markers(hitElement, matchingDimension) 
    if ( matchingDimension ) then
        if (not isElement(hitElement)) then return end
        if (isPedInVehicle(hitElement)) then return end
        if ( hitElement == localPlayer ) then
        if ( getElementModel ( localPlayer ) == 0 ) then

	if loginPanelState then return end
	createNotification("Bem vindo a loja de roupas!")
	toggleAllControls ( false ) 
	loginPanelState = true
	

	previousModel = createClothesJSONString ( "table" )
	
	addEventHandler("onClientRender", root, render)
	addEventHandler("onClientKey", root, key)
	addEventHandler("onClientCursorMove", root, cursorMove)
	addEventHandler ("onClientClick", root, cursorClick)

end
end
end
end
addEventHandler("onClientMarkerHit",m,markers) 

function markers2(thePlayer)
if thePlayer == localPlayer then 
fecharPainel()
end 
end
--addEventHandler("onClientMarkerLeave",m,markers2) 


end




function fecharPainel()
	if not loginPanelState then return end
	loginPanelState = false
	removeEventHandler("onClientRender", root, render)
	removeEventHandler("onClientKey", root, key)
	removeEventHandler("onClientCursorMove", root, cursorMove)
	removeEventHandler ("onClientClick", root, cursorClick)
	toggleAllControls ( true ) 
	
		pricesModel = {}
		pricesModelAcessorios = {}
		pricesModelCalcas = {}
		pricesModelCorrentes = {}
		pricesModelRelogios = {}
		pricesModelTenis = {}
		pricesModelAcessoriosC = {}

		

		recountTotalPrice()
		recountTotalPrice2()
		recountTotalPrice3()
		recountTotalPrice4()
		recountTotalPrice5()
		recountTotalPrice6()
		recountTotalPrice7()
		 camisaCont = 0
		 calcasCont = 0
		 tenisCont = 0
		 correnteCont = 0
		 relogioCont = 0
		 acessoriosCont = 0
		 acessoriosCCont = 0
		 currentCategory = 1
		 hoveredMenu = 1
end





function render ()
	if (loginPanelState) then
		dxDrawRectangle(panelX, panelY, panelWidth, 80*relY, tocolor(255, 149, 0, 220))
		dxDrawText("Brasil Gaming Online", panelX+10*relX, panelY, panelWidth+panelX-10*relX, 80*relY+panelY, tocolor(255, 255, 255, 255), 0.7, signpainter, "center", "center")
		dxDrawRectangle(panelX, panelY+80*relY, panelWidth, rowHeight, tocolor(0, 0, 0, 255))

		if (notificationData["text"]) then
			if (notificationData["state"] == "show") then
				local animProgress = (getTickCount() - notificationData["tick"]) / 200
				local animState = interpolateBetween(0, 0, 0, 80*relY, 0, 0, animProgress, "Linear")
				
				notificationData["height"] = animState
				
				if (animProgress > 1) then
					notificationData["state"] = "fix"
					
					notificationData["timer"] = setTimer(function()
						notificationData["tick"] = getTickCount()
						notificationData["state"] = "hide"
					end, string.len(notificationData["text"]) * 45 + 5000, 1)
				end
			elseif (notificationData["state"] == "hide") then
				local animProgress = (getTickCount() - notificationData["tick"]) / 300
				local animState = interpolateBetween(80*relY, 0, 0, 0, 0, 0, animProgress, "Linear")
				
				notificationData["height"] = animState
				
				if (animProgress > 1) then
					notificationData["text"] = false
				end
			elseif (notificationData["state"] == "fix") then
				notificationData["height"] = (80*relY)
			end
			
			dxDrawRectangle(panelX, panelY, panelWidth, notificationData["height"], tocolor(0, 0, 0, 210))
			
			if (notificationData["height"] == (80*relY)) then
				dxDrawText(notificationData["text"], panelX, panelY, panelWidth+panelX, notificationData["height"]+panelY, tocolor(255, 255, 255, 255), 0.5, chaletlondon, "center", "center")
			end
		end
		local preco = recountTotalPrice()+recountTotalPrice2()+recountTotalPrice3()+recountTotalPrice4()+recountTotalPrice5()+recountTotalPrice6()+recountTotalPrice7()
		--dxDrawText(utf8.upper(loginPanelCategories[currentCategory]["categoryName"]).." Total: "..preco.."", panelX+10*relX, panelY+80*relY, panelWidth+panelX+10*relX, rowHeight+panelY+80*relY, tocolor(53, 76, 115, 255), 0.5, chaletlondon, "left", "center")
		dxDrawText("Preço Total: "..preco.."", panelX+10*relX, panelY+80*relY, panelWidth+panelX+10*relX, rowHeight+panelY+80*relY, tocolor(255, 149, 0, 255), 0.5, chaletlondon, "left", "center")



		dxDrawText(""..hoveredMenu.."/"..#loginPanelCategories[currentCategory]["subMenu"].."", panelX+10*relX, panelY+80*relY, panelWidth+panelX-10*relX, rowHeight+panelY+80*relY, tocolor(255, 149, 0, 255), 0.5, chaletlondon, "right", "center")

		currentY = panelY+80*relY+rowHeight
		for k, v in ipairs(loginPanelCategories[currentCategory]["subMenu"]) do
			bgColor = tocolor(0, 0, 0, 210)
			textColor = tocolor(255, 255, 255, 220)
			if (k ~= hoveredMenu) then
				bgColor = tocolor(0, 0, 0, 210)
				textColor = tocolor(255, 255, 255, 220)
			else
				bgColor = tocolor(255, 255, 255, 255)
				textColor = tocolor(0, 0, 0, 255)
			end
			dxDrawRectangle(panelX, currentY+(rowHeight*(k-1)), panelWidth, rowHeight, bgColor)
			dxDrawText(v[2], panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX+10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "left", "center")

			if (v[1] == "camisa") then
				if (v[5]) then
					text = "◀ "..camisaCont.."/"..camisaMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..camisaCont.."/"..camisaMax.." ▶ "  --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")
			elseif (v[1] == "calcas") then
				if (v[5]) then
					text = "◀ "..calcasCont.."/"..calcasMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..calcasCont.."/"..calcasMax.." ▶ " --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")


			elseif (v[1] == "tenis") then
				if (v[5]) then
					text = "◀ "..tenisCont.."/"..tenisMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..tenisCont.."/"..tenisMax.." ▶ " --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")


			elseif (v[1] == "correntes") then
				if (v[5]) then
					text = "◀ "..correnteCont.."/"..correnteMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..correnteCont.."/"..correnteMax.." ▶ " --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")

			elseif (v[1] == "relogios") then
				if (v[5]) then
					text = "◀ "..relogioCont.."/"..relogiosMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..relogioCont.."/"..relogiosMax.." ▶ " --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")


			elseif (v[1] == "acessorios") then
				if (v[5]) then
					text = "◀ "..acessoriosCont.."/"..acessoriosMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..acessoriosCont.."/"..acessoriosMax.." ▶ " --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")

			elseif (v[1] == "acessoriosC") then
				if (v[5]) then
					text = "◀ "..acessoriosCCont.."/"..acessoriosCMax.." ▶ " --passwordCode(v[3])
				else
					text = "◀ "..acessoriosCCont.."/"..acessoriosCMax.." ▶ " --v[3]
				end
				dxDrawText(text, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth+panelX-10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.45, chaletlondon, "right", "center")

			elseif (v[1] == "check") then
				textColor = tocolor(255, 255, 255, 255)
				if (k ~= hoveredMenu) then
					textColor = tocolor(255, 255, 255, 255)
				else
					textColor = tocolor(0, 0, 0, 255)
				end
				if (v[3]) then
					state = "✔"
				else
					state = "✘"
				end
				dxDrawText(state, panelX+10*relX, currentY+(rowHeight*(k-1)), panelWidth-20*relX+panelX+10*relX, rowHeight+currentY+(rowHeight*(k-1)), textColor, 0.55, chaletlondon, "right", "center")
			end
		end

		currentY = currentY+(rowHeight*#loginPanelCategories[currentCategory]["subMenu"])
		dxDrawRectangle(panelX, currentY+3*relY, panelWidth, rowHeight, tocolor(0, 0, 0, 210))
		dxDrawImage(panelX, currentY+3*relY, panelWidth, rowHeight, "images/menunav.png")
	end
end

function cursorMove (x, y)
	currentY = panelY+80*relY+rowHeight
	for k, v in ipairs(loginPanelCategories[currentCategory]["subMenu"]) do
		if (isMouseInPosition (panelX, currentY+(rowHeight*(k-1)), panelWidth, rowHeight)) then
			if (hoveredMenu ~= k) then
				hoveredMenu = k
				playSoundEffect("menunavigate")
			end
		end
	end
end

function key (key, state)
	if (loginPanelState) then
		if (state) then
			v = loginPanelCategories[currentCategory]["subMenu"][hoveredMenu]
			if (v) then
				if (v[1] == "input") then
					local keyAction = getKeyAction(key)
					if (keyAction) then
						if (keyAction == "backspace") then
							if (string.len(v[3]) == 0) then
								backFunction()
							end
							v[3] = backspace(v[3])
						elseif (keyAction == "enter") then
							hoveredMenu = hoveredMenu + 1
							playSoundEffect("menunavigate")
						else
							if (v[4] > string.len(v[3])) then
								v[3] = v[3] .. keyAction
								playSoundEffect("buttonpressed")
							end
						end
					end
				
				elseif (v[1] == "camisa") then
				if (key == "arrow_r") then
				if (camisaCont < camisaMax) then
				camisaCont = camisaCont + 1
				texture, model = getClothesByTypeIndex(0, Camisetas[camisaCont][1])
				addPedClothes(localPlayer, texture, model, 0)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 0 )
				pricesModel = {}
				pricesModel[camisaCont] = tonumber(Camisetas[camisaCont][2])
                recountTotalPrice ()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (camisaCont > 0) then
				camisaCont = camisaCont - 1
				texture, model = getClothesByTypeIndex(0, Camisetas[camisaCont][1])
				addPedClothes(localPlayer, texture, model, 0)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 0 )
				pricesModel = {}
				pricesModel[camisaCont] = tonumber(Camisetas[camisaCont][2])
                recountTotalPrice ()
				playSoundEffect("menunavigate")
				end
				end	
				

				elseif (v[1] == "calcas") then
				if (key == "arrow_r") then
				if (calcasCont < calcasMax) then
				calcasCont = calcasCont + 1
				texture, model = getClothesByTypeIndex(2, Calcas[calcasCont][1])
				addPedClothes(localPlayer, texture, model, 2)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 2 )
				pricesModelCalcas = {}
				pricesModelCalcas[calcasCont] = tonumber(Calcas[calcasCont][2])
                recountTotalPrice2()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (calcasCont > 0) then
				calcasCont = calcasCont - 1
				texture, model = getClothesByTypeIndex(2, Calcas[calcasCont][1])
				addPedClothes(localPlayer, texture, model, 2)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 2 )
				pricesModelCalcas = {}
				pricesModelCalcas[calcasCont] = tonumber(Calcas[calcasCont][2])
                recountTotalPrice2()
				playSoundEffect("menunavigate")
				end
				end	


				elseif (v[1] == "tenis") then
				if (key == "arrow_r") then
				if (tenisCont < tenisMax) then
				tenisCont = tenisCont + 1
				texture, model = getClothesByTypeIndex(3, tenis[tenisCont][1])
				addPedClothes(localPlayer, texture, model, 3)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 3 )
				pricesModelTenis = {}
				pricesModelTenis[tenisCont] = tonumber(tenis[tenisCont][2])
                recountTotalPrice3()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (tenisCont > 0) then
				tenisCont = tenisCont - 1
				texture, model = getClothesByTypeIndex(3, tenis[tenisCont][1])
				addPedClothes(localPlayer, texture, model, 3)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 3 )
				pricesModelTenis = {}
				pricesModelTenis[tenisCont] = tonumber(tenis[tenisCont][2])
                recountTotalPrice3()
				playSoundEffect("menunavigate")
				end
				end	
				
				elseif (v[1] == "correntes") then
				if (key == "arrow_r") then
				if (correnteCont < correnteMax) then
				correnteCont = correnteCont + 1
				texture, model = getClothesByTypeIndex(13, correntes[correnteCont][1])
				addPedClothes(localPlayer, texture, model, 13)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 13 )
				pricesModelCorrentes = {}
				pricesModelCorrentes[correnteCont] = tonumber(correntes[correnteCont][2])
                recountTotalPrice4()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (correnteCont > 0) then
				correnteCont = correnteCont - 1
				texture, model = getClothesByTypeIndex(13, correntes[correnteCont][1])
				addPedClothes(localPlayer, texture, model, 13)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 13 )
				pricesModelCorrentes = {}
				pricesModelCorrentes[correnteCont] = tonumber(correntes[correnteCont][2])
                recountTotalPrice4()
				playSoundEffect("menunavigate")
				end
				end	

				elseif (v[1] == "relogios") then
				if (key == "arrow_r") then
				if (relogioCont < relogiosMax) then
				relogioCont = relogioCont + 1
				texture, model = getClothesByTypeIndex(14, relogios[relogioCont][1])
				addPedClothes(localPlayer, texture, model, 14)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 14 )
				pricesModelRelogios = {}
				pricesModelRelogios[relogioCont] = tonumber(relogios[relogioCont][2])
                recountTotalPrice5()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (relogioCont > 0) then
				relogioCont = relogioCont - 1
				texture, model = getClothesByTypeIndex(14, relogios[relogioCont][1])
				addPedClothes(localPlayer, texture, model, 14)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 14 )
				pricesModelRelogios = {}
				pricesModelRelogios[relogioCont] = tonumber(relogios[relogioCont][2])
                recountTotalPrice5()
				playSoundEffect("menunavigate")
				end
				end	

				elseif (v[1] == "acessorios") then
				if (key == "arrow_r") then
				if (acessoriosCont < acessoriosMax) then
				acessoriosCont = acessoriosCont + 1
				texture, model = getClothesByTypeIndex(15, acessorios[acessoriosCont][1])
				addPedClothes(localPlayer, texture, model, 15)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 15 )
				pricesModelAcessorios = {}
				pricesModelAcessorios[acessoriosCont] = tonumber(acessorios[acessoriosCont][2])
                recountTotalPrice6()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (acessoriosCont > 0) then
				acessoriosCont = acessoriosCont - 1
				texture, model = getClothesByTypeIndex(15, acessorios[acessoriosCont][1])
				addPedClothes(localPlayer, texture, model, 15)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 15 )
				pricesModelAcessorios = {}
				pricesModelAcessorios[acessoriosCont] = tonumber(acessorios[acessoriosCont][2])
                recountTotalPrice6()
				playSoundEffect("menunavigate")
				end
				end

				
				elseif (v[1] == "acessoriosC") then
				if (key == "arrow_r") then
				if (acessoriosCCont < acessoriosCMax) then
				acessoriosCCont = acessoriosCCont + 1
				texture, model = getClothesByTypeIndex(16, acessoriosC[acessoriosCCont][1])
				addPedClothes(localPlayer, texture, model, 16)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 16 )
				pricesModelAcessoriosC = {}
				pricesModelAcessoriosC[acessoriosCCont] = tonumber(acessoriosC[acessoriosCCont][2])
                recountTotalPrice7()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (acessoriosCCont > 0) then
				acessoriosCCont = acessoriosCCont - 1
				texture, model = getClothesByTypeIndex(16, acessoriosC[acessoriosCCont][1])
				addPedClothes(localPlayer, texture, model, 16)
				triggerServerEvent( "AplicarRoupaS", localPlayer, localPlayer,  texture, model, 15 )
				pricesModelAcessoriosC = {}
				pricesModelAcessoriosC[acessoriosCCont] = tonumber(acessoriosC[acessoriosCCont][2])
                recountTotalPrice7()
				playSoundEffect("menunavigate")
				end
				end	
				
				elseif (v[1] == "button") then
					if (key == "enter") then
						enterFunction()
					end
				elseif (v[1] == "check") then
					if (key == "enter") then
						enterFunction()
					end
				end
				end
				
				
				
				
				if (key == "arrow_d") then
				if (hoveredMenu < #loginPanelCategories[currentCategory]["subMenu"]) then
					hoveredMenu = hoveredMenu + 1
				else
					hoveredMenu = 1
				end
				playSoundEffect("menunavigate")
				elseif (key == "arrow_u") then
				if (hoveredMenu > 1) then
					hoveredMenu = hoveredMenu - 1
				else
					hoveredMenu = #loginPanelCategories[currentCategory]["subMenu"]
				end
				playSoundEffect("menunavigate")
				
				
				

			--elseif (key == "backspace") then
			--	v = loginPanelCategories[currentCategory]["subMenu"][hoveredMenu]
			--	if (v[1] ~= "input") then
			--		backFunction()
			--	end
			end
		end
	end
end

function cursorClick (button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if (button == "left" and state == "down") then
		enterFunction(true)
	end
end

function recountTotalPrice ()
    local totalPrice = 0
    for i=0,67 do
        if ( pricesModel[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModel[i]) )
        end
    end 
    return totalPrice
end

function recountTotalPrice2 ()
    local totalPrice = 0
    for i=0,44 do
        if ( pricesModelCalcas[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModelCalcas[i]) )
        end
    end 
    return totalPrice
end

function recountTotalPrice3()
    local totalPrice = 0
    for i=0,37 do
        if ( pricesModelTenis[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModelTenis[i]) )
        end
    end 
    return totalPrice
end
function recountTotalPrice4()
    local totalPrice = 0
    for i=0,11 do
        if ( pricesModelCorrentes[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModelCorrentes[i]) )
        end
    end 
    return totalPrice
end

function recountTotalPrice5()
    local totalPrice = 0
    for i=0,11 do
        if ( pricesModelRelogios[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModelRelogios[i]) )
        end
    end 
    return totalPrice
end

function recountTotalPrice6()
    local totalPrice = 0
    for i=0,17 do
        if ( pricesModelAcessorios[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModelAcessorios[i]) )
        end
    end 
    return totalPrice
end

function recountTotalPrice7()
    local totalPrice = 0
    for i=0,16 do
        if ( pricesModelAcessoriosC[i] == nil ) then
            -- Nothing
        else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModelAcessoriosC[i]) )
        end
    end 
    return totalPrice
end

function enterFunction (cursorUsed)
	if not cursorUsed then cursorUsed = false end
	--loginMenu = loginPanelCategories[1]["subMenu"]
	--registerMenu = loginPanelCategories[2]["subMenu"]
	v = loginPanelCategories[currentCategory]["subMenu"][hoveredMenu]
	if (v[1] == "button") then
		if (string.find(v[3], "NF")) then
			local categoryID = string.gsub(v[3], "NFtoPage", "")
			currentCategory = tonumber(categoryID)
			hoveredMenu = 1
			playSoundEffect("menuenter")
		elseif (v[3] == "comprar") then
		local preco = recountTotalPrice()+recountTotalPrice2()+recountTotalPrice3()+recountTotalPrice4()+recountTotalPrice5()+recountTotalPrice6()+recountTotalPrice7()
		if preco > 1 then
		if ( getElementData(localPlayer,"char:money") >= tonumber( preco ) ) then
        updatePlayerCJSkin ( createClothesJSONString ( "table" ) )
        triggerServerEvent( "onPlayerBougtSkin", localPlayer, preco )
		exports.bgo_hud:dm( "Você comprou as roupas do CJ com sucesso!", 225, 0, 0 )
		fecharPainel()
		else
        exports.bgo_hud:dm( "Você não tem dinheiro suficiente para todos estes itens!", 225, 0, 0 )
		end
		else
		createNotification("Escolha o estilo!")
		end
	

		elseif (v[3] == "fecharPainel") then
		
		
		updatePlayerCJSkin ( previousModel )
		
		
		
		fecharPainel()
		elseif (v[3] == "limpar") then

		
		createNotification("Roupa Limpada com sucesso!")
		pricesModel = {}
		pricesModelAcessorios = {}
		pricesModelCalcas = {}
		pricesModelCorrentes = {}
		pricesModelRelogios = {}
		pricesModelTenis = {}
		pricesModelAcessoriosC = {}
		recountTotalPrice()
		recountTotalPrice2()
		recountTotalPrice3()
		recountTotalPrice4()
		recountTotalPrice5()
		recountTotalPrice6()
		recountTotalPrice7()
		 camisaCont = 0
		 calcasCont = 0
		 tenisCont = 0
		 correnteCont = 0
		 relogioCont = 0
		 acessoriosCont = 0
		  acessoriosCCont = 0
			previousModel = nil
		resetPlayerSkin(localPlayer)
		triggerServerEvent( "ResetRoupaS", localPlayer, localPlayer )
	
		end
	elseif (v[1] == "check") then
		if (not cursorUsed) or (cursorUsed and (isMouseInPosition (panelX+panelWidth-30*relX, panelY+80*relY+rowHeight+(rowHeight*2), 15*relX, rowHeight))) then
			v[3] = not v[3]
			playSoundEffect("menunavigate")
		end
	end
end

function backFunction ()
	if (currentCategory > 1) then
		currentCategory = currentCategory -1
		playSoundEffect("menuback")
		hoveredMenu = 1
	end
end

function setRememberCheck (state)
	loginPanelCategories[1]["subMenu"][3][3] = state
end

function getRememberCheck ()
	return loginPanelCategories[1]["subMenu"][3][3]
end


function createClothesJSONString ( returnType )
    local clothesTable = {}
    local smtn = false
    for i=0,17 do
        local texture, model = getPedClothes ( localPlayer, i )
        if ( texture ) then
            local theType, theIndex = getTypeIndexFromClothes ( texture, model )
            clothesTable[theType] = theIndex
            smtn = true
        end
    end
    if ( smtn ) then
        if ( returnType == "JSON" ) then
            return "" .. toJSON( clothesTable ):gsub( " ", "" ) .. ""
        else
            return clothesTable
        end
    else
        return "NULL"
    end
end 

function updatePlayerCJSkin ( CJClothesTable )
    if ( CJClothesTable ) then
        if (CJClothesTable == "NULL") then resetPlayerSkin(localPlayer) return end 
        for i=0,17 do
            local texture, model = getPedClothes ( localPlayer, i )
            if (texture) then
                removePedClothes(localPlayer, i)
                break
            else
                break    
            end
        end  
--[[		
        for int, index in pairs( CJClothesTable ) do
            local texture, model = getClothesByTypeIndex ( int, index )
            if ( texture ) then
                addPedClothes ( player, texture, model, int )
            end
        end]]--
    end
    triggerServerEvent( "onChangeClothesCJ", localPlayer, CJClothesTable, createClothesJSONString ( "JSON" ) )
end

function resetPlayerSkin(player)
    if (isElement(player)) then
        if (getPedClothes(player, 0)) then
            removePedClothes(player, 0)
        end 
        if (getPedClothes(player, 1)) then
            removePedClothes(player, 1)
        end
        if (getPedClothes(player, 2)) then
            removePedClothes(player, 2)
        end 
        if (getPedClothes(player, 3)) then
            removePedClothes(player, 3)
        end
        if (getPedClothes(player, 4)) then
            removePedClothes(player, 4)
        end
        if (getPedClothes(player, 5)) then
            removePedClothes(player, 5)
        end
        if (getPedClothes(player, 6)) then
            removePedClothes(player, 6)
        end
        if (getPedClothes(player, 7)) then
            removePedClothes(player, 7)
        end
        if (getPedClothes(player, 8)) then
            removePedClothes(player, 8)
        end
        if (getPedClothes(player, 9)) then
            removePedClothes(player, 9)
        end
        if (getPedClothes(player, 10)) then
            removePedClothes(player, 10)
        end
        if (getPedClothes(player, 11)) then
            removePedClothes(player, 11)
        end
        if (getPedClothes(player, 12)) then
            removePedClothes(player, 12)
        end
        if (getPedClothes(player, 13)) then
            removePedClothes(player, 13)
        end 
        if (getPedClothes(player, 14)) then
            removePedClothes(player, 14)
        end
        if (getPedClothes(player, 15)) then
            removePedClothes(player, 15)
        end
        if (getPedClothes(player, 16)) then
            removePedClothes(player, 16)
        end
        if (getPedClothes(player, 17)) then
            removePedClothes(player, 17)
        end
    end
end    
        
