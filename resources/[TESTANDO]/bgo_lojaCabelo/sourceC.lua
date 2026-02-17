
local loginPanelState = false
local panelX, panelY, panelWidth, rowHeight = 32*relX, 222*relY, 335*relX, 30*relY
local currentCategory = 1
local hoveredMenu = 1

local camisaCont = 0
local camisaMax = 32

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
			[1] = {"camisa", "Cabelo", camisaCont,false},
			--[7] = {"check", "Limpar tudo?", false},
			[2] = {"button", "Limpar sessão", "limpar"},	
			[3] = {"button", "Aplicar", "comprar"},
			[4] = {"button", "Fechar", "fecharPainel"}, --"NFtoPage2"},
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
addEvent("loginNotificationClientC", true)
addEventHandler("loginNotificationClientC", root, createNotification)




ambiMarkers = { 
	[1] = {2082.4291992188,2129.4680175781,10.826487541199},
}




for i = 1, #ambiMarkers, 1 do
marker = createMarker(ambiMarkers[i][1], ambiMarkers[i][2],ambiMarkers[i][3]-0.8, "cylinder",3, 255, 200, 0, 20)
local m = marker


local myBlip = createBlipAttachedTo ( m, 7 )
setElementData(myBlip ,"blipName", "Cabeleleiro!")

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


		

		recountTotalPrice()

		 camisaCont = 0

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
		local preco = recountTotalPrice()
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
				texture, model = getClothesByTypeIndex(1, cabelo[camisaCont][1])
				addPedClothes(localPlayer, texture, model, 1)
				triggerServerEvent( "AplicarRoupaSC", localPlayer, localPlayer,  texture, model, 1 )
				pricesModel = {}
				pricesModel[camisaCont] = tonumber(cabelo[camisaCont][2])
                recountTotalPrice ()
				playSoundEffect("menunavigate")
				end
				elseif (key == "arrow_l") then
				if (camisaCont > 0) then
				camisaCont = camisaCont - 1
				texture, model = getClothesByTypeIndex(1, cabelo[camisaCont][1])
				addPedClothes(localPlayer, texture, model, 1)
				triggerServerEvent( "AplicarRoupaSC", localPlayer, localPlayer,  texture, model, 1 )
				pricesModel = {}
				pricesModel[camisaCont] = tonumber(cabelo[camisaCont][2])
                recountTotalPrice ()
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

function recountTotalPrice (i)
    local totalPrice = 0
    for i=0,32 do
       if ( pricesModel[i] == nil ) then
            -- Nothing
       else
           totalPrice = ( tonumber(totalPrice) + tonumber(pricesModel[i]) )
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
		local preco = recountTotalPrice()
		if preco > 1 then
		if ( getElementData(localPlayer,"char:money") >= tonumber( preco ) ) then
        updatePlayerCJSkin ( createClothesJSONString ( "table" ) )
        triggerServerEvent( "onPlayerBougtSkinC", localPlayer, preco )
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
		recountTotalPrice()

		 camisaCont = 0

			previousModel = nil
		resetPlayerSkin(localPlayer)
		triggerServerEvent( "ResetRoupaSC", localPlayer, localPlayer )
	
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
    triggerServerEvent( "onChangeClothesCJC", localPlayer, CJClothesTable, createClothesJSONString ( "JSON" ) )
end

function resetPlayerSkin(player)
    if (isElement(player)) then
        if (getPedClothes(player, 1)) then
            removePedClothes(player, 1)
        end
    end
end    
        
