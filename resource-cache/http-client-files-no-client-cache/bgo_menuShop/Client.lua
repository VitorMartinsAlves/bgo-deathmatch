local screenW, screenH = guiGetScreenSize()
local x,y = (screenW/1600), (screenH/900)

panelState = false

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
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

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end

-- # example 


function dx( ) 
if panelState then
local hover = isMouseInPosition ( screenW * 0.4500, screenH * 0.3264, screenW * 0.16, screenH * 0.05) ; 
--dxDrawRoundedRectangle(screenW * 0.4500, screenH * 0.3264, screenW * 0.16, screenH * 0.05, hover and tocolor(200,200,200,200) or tocolor(0,0,0,200), 10)

        dxDrawLine((screenW * 0.3700) - 1, (screenH * 0.8978) - 1, (screenW * 0.3700) - 1, screenH * 0.9211, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6250, (screenH * 0.8978) - 1, (screenW * 0.3700) - 1, (screenH * 0.8978) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3700) - 1, screenH * 0.9211, screenW * 0.6250, screenH * 0.9211, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6250, screenH * 0.9211, screenW * 0.6250, (screenH * 0.8978) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3700, screenH * 0.8978, screenW * 0.2550, screenH * 0.0233, tocolor(0, 0, 0, 170), false)
        dxDrawText("#FFA000FOOD: #FFFFFFProduto: #FFA000"..(food or "Nenhum").." #FFFFFFValor: #FFA000"..(valor or 0), screenW * 0.3700, screenH * 0.8967, screenW * 0.6250, screenH * 0.9211, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, true, false)
        dxDrawRectangle(screenW * 0.4437, screenH * 0.8389, screenW * 0.1075, screenH * 0.0467, tocolor(0, 0, 0, 187), false)
        dxDrawText("QUANT.", screenW * 0.4437, screenH * 0.8389, screenW * 0.4969, screenH * 0.8867, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawRectangle(screenW * 0.5012, screenH * 0.8478, screenW * 0.0444, screenH * 0.0289, tocolor(127, 127, 127, 237), false)
		createEditBox("1", 0.502, 0.850, 0.04, 0.03, true, "0", false, 7, "default", false, 1, {0, 0, 0, 255 }, true, {127, 127, 127, 0, 255 }, y/2, true, 60, true, "", { 0, 0, 0, 255 }, true, y/2, "default", true, true, {0, 0, 0}, false)
	 if food == "Celular" then
	     changeVisibility("1", false)
	 else
	     changeVisibility("1", true)
	 end
 
     local hover = isMouseInPosition (screenW * 0.4813, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) ; 		
	 if isMouseInPosition (screenW * 0.4813, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	     food = "Hamburguer"
		 valor = tonumber(getText("1") * 15)
	 end		
        dxDrawLine((screenW * 0.4813) - 1, (screenH * 0.7711) - 1, (screenW * 0.4813) - 1, screenH * 0.8233, hover and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.5125, (screenH * 0.7711) - 1, (screenW * 0.4813) - 1, (screenH * 0.7711) - 1, hover and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine((screenW * 0.4813) - 1, screenH * 0.8233, screenW * 0.5125, screenH * 0.8233, hover and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.5125, screenH * 0.8233, screenW * 0.5125, (screenH * 0.7711) - 1, hover and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
		dxDrawImage (screenW * 0.4813, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522, '1.png')
	
	 local hover2 = isMouseInPosition (screenW * 0.5188, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) ; 
	 if isMouseInPosition (screenW * 0.5188, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	     food = "Tacos"
		 valor = tonumber(getText("1") * 15)
	 end
        dxDrawLine((screenW * 0.5188) - 1, (screenH * 0.7711) - 1, (screenW * 0.5188) - 1, screenH * 0.8233, hover2 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.5500, (screenH * 0.7711) - 1, (screenW * 0.5188) - 1, (screenH * 0.7711) - 1, hover2 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine((screenW * 0.5188) - 1, screenH * 0.8233, screenW * 0.5500, screenH * 0.8233, hover2 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.5500, screenH * 0.8233, screenW * 0.5500, (screenH * 0.7711) - 1, hover2 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
		dxDrawImage (screenW * 0.5188, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522, '2.png')
	 
	 local hover3 = isMouseInPosition (screenW * 0.4437, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) ; 
	 if isMouseInPosition (screenW * 0.4437, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	     food = "Suco"
		 valor = tonumber(getText("1") * 15)
	 end	 
        dxDrawLine((screenW * 0.4437) - 1, (screenH * 0.7711) - 1, (screenW * 0.4437) - 1, screenH * 0.8233, hover3 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.4750, (screenH * 0.7711) - 1, (screenW * 0.4437) - 1, (screenH * 0.7711) - 1, hover3 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine((screenW * 0.4437) - 1, screenH * 0.8233, screenW * 0.4750, screenH * 0.8233, hover3 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.4750, screenH * 0.8233, screenW * 0.4750, (screenH * 0.7711) - 1, hover3 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
		dxDrawImage (screenW * 0.4437, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522, '3.png')
	
     local hover4 = isMouseInPosition (screenW * 0.4063, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) ; 
	 if isMouseInPosition (screenW * 0.4063, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	     food = "Pizza"
		 valor = tonumber(getText("1") * 15)
	 end	
        dxDrawLine((screenW * 0.4063) - 1, (screenH * 0.7711) - 1, (screenW * 0.4063) - 1, screenH * 0.8233, hover4 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.4375, (screenH * 0.7711) - 1, (screenW * 0.4063) - 1, (screenH * 0.7711) - 1, hover4 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine((screenW * 0.4063) - 1, screenH * 0.8233, screenW * 0.4375, screenH * 0.8233, hover4 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.4375, screenH * 0.8233, screenW * 0.4375, (screenH * 0.7711) - 1, hover4 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
		dxDrawImage (screenW * 0.4063, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522, '4.png')
	 
	 local hover5 = isMouseInPosition (screenW * 0.5575, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) ; 
	 if isMouseInPosition (screenW * 0.5575, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	     food = "Celular"
		 valor = 1500 --tonumber(1 * 1500)
	 end
        dxDrawLine((screenW * 0.5575) - 1, (screenH * 0.7711) - 1, (screenW * 0.5575) - 1, screenH * 0.8233, hover5 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.5887, (screenH * 0.7711) - 1, (screenW * 0.5575) - 1, (screenH * 0.7711) - 1, hover5 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine((screenW * 0.5575) - 1, screenH * 0.8233, screenW * 0.5887, screenH * 0.8233, hover5 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
        dxDrawLine(screenW * 0.5887, screenH * 0.8233, screenW * 0.5887, (screenH * 0.7711) - 1, hover5 and tocolor(155, 252, 2, 255) or tocolor(0,0,0,200), 1, false)
		dxDrawImage (screenW * 0.5575, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522, '16.png')

end 
end


function onClick(button, state, cursorx, cursory) 
    if panelState then
        if button == "left" and state == "down" then
    if isMouseInPosition (screenW * 0.4813, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then 
    if tonumber(getText("1")) <= 10 then
	if tonumber(getText("1")) <= 0 then outputChatBox("#FFA000[BGO ERROR] #FFFFFFValor invalido.", 255,255,255, true) return end
        -- triggerServerEvent("Hamburguer",localPlayer , 1)
		 
		 triggerServerEvent("Hamburguer",localPlayer , tonumber(getText("1")))
		 
		 
		 else
		 outputChatBox("#FFA000[BGO ERROR] #FFFFFFSão permitida apenas 10 vendas do mesmo produto.", 255,255,255, true)
	 end
    elseif isMouseInPosition (screenW * 0.5188, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	if tonumber(getText("1")) <= 10 then
	if tonumber(getText("1")) <= 0 then outputChatBox("#FFA000[BGO ERROR] #FFFFFFValor invalido.", 255,255,255, true) return end
       triggerServerEvent("Tacos",localPlayer, tonumber(getText("1")))
		
		--triggerServerEvent("Tacos",localPlayer, 1)
		
		
		else
		 outputChatBox("#FFA000[BGO ERROR] #FFFFFFSão permitida apenas 10 vendas do mesmo produto.", 255,255,255, true)
	 end
    elseif isMouseInPosition (screenW * 0.4437, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
     if tonumber(getText("1")) <= 10 then
	 if tonumber(getText("1")) <= 0 then outputChatBox("#FFA000[BGO ERROR] #FFFFFFValor invalido.", 255,255,255, true) return end
        --triggerServerEvent("Suco",localPlayer, 1)
		 triggerServerEvent("Suco",localPlayer, tonumber(getText("1")))
		else
		outputChatBox("#FFA000[BGO ERROR] #FFFFFFSão permitida apenas 10 vendas do mesmo produto.", 255,255,255, true)
	 end
    elseif isMouseInPosition (screenW * 0.4063, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
    if tonumber(getText("1")) <= 10 then
	if tonumber(getText("1")) <= 0 then outputChatBox("#FFA000[BGO ERROR] #FFFFFFValor invalido.", 255,255,255, true) return end
        triggerServerEvent("Pizza",localPlayer, tonumber(getText("1")))
		
		--triggerServerEvent("Pizza",localPlayer, 1)
		
		else
		 outputChatBox("#FFA000[BGO ERROR] #FFFFFFSão permitida apenas 10 vendas do mesmo produto.", 255,255,255, true)
	 end
    elseif isMouseInPosition (screenW * 0.5575, screenH * 0.7711, screenW * 0.0313, screenH * 0.0522) then
	

        triggerServerEvent("Celular",localPlayer, 1)

    end 
  end 
end
end



addEvent("LOJAMIDAON",true)
addEventHandler("LOJAMIDAON",localPlayer,
function()

	addEventHandler( "onClientPreRender", root, renderEditBoxow )
	addEventHandler( "onClientClick", root, klikniecieEditBoxa )
	addEventHandler( "onClientCharacter", root, zmienWartoscEditBoxa ) 
	addEventHandler('onClientPreRender', root, usunString)
	
	
    panelState = true    
	changeVisibility("1", true)
    addEventHandler("onClientClick",getRootElement(),onClick)    
    addEventHandler("onClientRender", getRootElement(), dx)

end)


addEvent("LOJAMIDAOFF",true)
addEventHandler("LOJAMIDAOFF",localPlayer,
function()

	removeEventHandler( "onClientPreRender", root, renderEditBoxow )
	removeEventHandler( "onClientClick", root, klikniecieEditBoxa )
	removeEventHandler( "onClientCharacter", root, zmienWartoscEditBoxa ) 
	removeEventHandler('onClientPreRender', root, usunString)
	
	
    panelState = false 
	changeVisibility("1", false)
    removeEventHandler("onClientClick",getRootElement(),onClick)   
    removeEventHandler("onClientRender", getRootElement(), dx)    
end)


--[[

function handleMinimize()
    panelState = false 
	changeVisibility("1", false)
end
addEventHandler( "onClientMinimize", root, handleMinimize )
]]--


