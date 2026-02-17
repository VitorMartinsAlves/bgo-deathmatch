local monitorSize = {guiGetScreenSize()}
local imageSize = {250, 50}
local show = false
local font = dxCreateFont("files/myriadproregular.ttf",9) --<[ Font ]>--
local font2 = dxCreateFont("files/myriadproregular.ttf",11) --<[ Font ]>--
local NextPage = 0
local imageAlpha = 0 
local panelX, PanelY = monitorSize[1]/2-1000/2, monitorSize[2]/2-50/2
local current = -1
local maxDraw = 10
local elem = 0
local allnotifications = {}

local shopActioveMenu = {
	{"Menu de compras"}
}

function openPeremiumPanel()
	if not show then 
		removeEventHandler("onClientRender", root, createPremiumShopPanel)
		addEventHandler("onClientRender", root, createPremiumShopPanel)
		removeEventHandler("onClientClick", getRootElement(), premiumClick)
		addEventHandler("onClientClick", getRootElement(), premiumClick)
		exports["bgo_blur"]:createBlur("dashboard", 6)
		show = true
		showChat(false)

		elem = 0
		NextPage = 0
		current = 1
		startTick = getTickCount()
		progress = "OutBack"

	else
		removeEventHandler("onClientClick", getRootElement(), premiumClick)
		removeEventHandler("onClientRender", root, createPremiumShopPanel)
		current = -1
		show = false
		showChat(true)
		imageAlpha = 0 
		NextPage = 0
		elem = 0
		exports["bgo_blur"]:removeBlur("dashboard")
	end
end
bindKey("F6", "down", openPeremiumPanel)
local klikkTimer= false

function premiumClick(button, status, x, y)
	if not show then return end
	if(button == "left" and status == "down") then
		if (dobozbaVan(panelX+1000-100, PanelY-200-20, 100, 15, x, y)) then 
			removeEventHandler("onClientClick", getRootElement(), premiumClick)
			removeEventHandler("onClientRender", root, createPremiumShopPanel)
			current = -1
			show = false
			imageAlpha = 0 
			NextPage = 0
			showChat(true)
			exports["bgo_blur"]:removeBlur("dashboard")
		end
		for index, value in ipairs (shopActioveMenu) do 
			if (dobozbaVan(panelX-225+index*(250), PanelY-200+5, 200, 20, x, y)) then 
				elem = 0
				NextPage = 0
				current = index
				startTick = getTickCount()
				progress = "OutBack"
			end
		end
		if current > 0 then 
			elem = 0
			for index, value in ipairs (premiumShop[current][1])  do 
				if (index > NextPage and elem < maxDraw) then
					if klikkTimer then addNotification("Espere #c0392b5#ffffff segundos.", "red") return end
					elem = elem + 1
					if (dobozbaVan(panelX+1000-200-10,  monitorSize[2]/2-50+elem*105/2-170+10, 200, 30, x, y) and current ~= 3 and current ~= 2) then 
						if localPlayer:getData("char:pp") >= value[4] then 
							triggerServerEvent("PremiumPontbuyItem", localPlayer, localPlayer, value[1], value[2], value[4])
							--localPlayer:setData("char:pp", localPlayer:getData("char:pp") - value[4])

							--outputChatBox("Sikeresen megvásároltad a #19B5FE".. exports.bgo_items:getItemName(value[1]).. "#ffffff-t.", 255, 255, 255, true)
							--addNotification("Você comprou com sucesso #19B5FE".. exports.bgo_items:getItemName(value[1]).. "#ffffff.", "green")
--[[
							if isTimer(klikkTimerRun) then return end
							klikkTimer = false
							klikkTimerRun = setTimer(function()
								klikkTimer = false
							end,10,1)]]--
						else
							--outputChatBox("Nincs elég #19B5FE'Dinheiro Vipod'#ffffff a vásárláshoz.", 255, 255, 255, true)
							addNotification("Você não tem #19B5FE'Dinheiro Vip'#ffffff o suficiente para comprar!.", "red")
						end
					elseif (dobozbaVan(panelX+1000-200-10,  monitorSize[2]/2-50+elem*105/2-170+10, 200, 30, x, y) and current == 3) then
						if localPlayer:getData("char:pp") >= value[4] then 
							--localPlayer:setData("char:money", localPlayer:getData("char:money") + value[1])
							--localPlayer:setData("char:pp", localPlayer:getData("char:pp") - value[4])
							--outputChatBox("Sikeresen megvásároltad a #19B5FE".. value[3].. "#ffffff-t.", 255, 255, 255, true)
							addNotification("Você comprou com sucesso #eb6503".. value[3].. "#ffffff.", "green")
							if isTimer(klikkTimerRun) then return end
							klikkTimer = false
							klikkTimerRun = setTimer(function()
								klikkTimer = false
							end,10,1)
						else
							addNotification("Você não tem #FE8100'Dinheiro Vip'#ffffff o suficiente para comprar!.", "red")
						end					
					elseif (dobozbaVan(panelX+1000-200-10,  monitorSize[2]/2-50+elem*105/2-170+10, 200, 30, x, y) and current == 2) then
						if localPlayer:getData("char:pp") >= value[2] then 
							triggerServerEvent("PremiumPontbuyItem", localPlayer, localPlayer, value[1], value[2], value[3], value[4])

							


							
							--localPlayer:setData("char:pp", localPlayer:getData("char:pp") - value[4])
							--outputChatBox("Sikeresen megvásároltad a #19B5FE".. value[3].. "#ffffff-t.", 255, 255, 255, true)
							--addNotification("Você comprou com sucesso #19B5FE".. exports.bgo_items:getItemName(value[1]).. "#ffffff.", "green")
							if isTimer(klikkTimerRun) then return end
							klikkTimer = false
							klikkTimerRun = setTimer(function()
								klikkTimer = false
							end,10,1)
						else
							addNotification("Você não tem #FE8100'Dinheiro Vip'#ffffff o suficiente para comprar!.", "red")
						end
					end
				end
			end
		end
	end
end

function createPremiumShopPanel ()
	dxDrawRectangle(panelX, PanelY-200-30, 200, 30, tocolor(0, 0, 0, 170))
	if isInSlot(panelX+1000-100, PanelY-200-20, 100, 20)  then 
		dxDrawRectangle(panelX+1000-100, PanelY-200-20, 100, 20, tocolor(210, 77, 87, 170))
		dxDrawText("Fechar", panelX+1000-100+100/2, PanelY-200-20+20/2, panelX+1000-100+100/2, PanelY-200-20+20/2, tocolor(0, 0, 0, 230), 1, font, "center", "center", false, false, false, true)
	else
		dxDrawRectangle(panelX+1000-100, PanelY-200-20, 100, 20, tocolor(0, 0, 0, 170))
		dxDrawText("Fechar", panelX+1000-100+100/2, PanelY-200-20+20/2, panelX+1000-100+100/2, PanelY-200-20+20/2, tocolor(255, 255, 255, 230), 1, font, "center", "center", false, false, false, true)
	end
	
	dxDrawText("Dinheiro Vip: "..money_chopping(localPlayer:getData("char:pp")), panelX+201/2, PanelY-200-30+31/2, panelX+201/2, PanelY-200-30+31/2, tocolor(0, 0, 0, 230), 1, font2, "center", "center", false, false, false, true)
	dxDrawText("Dinheiro Vip: #FE8100"..money_chopping(localPlayer:getData("char:pp")), panelX+200/2, PanelY-200-30+30/2, panelX+200/2, PanelY-200-30+30/2, tocolor(255, 255, 255, 230), 1, font2, "center", "center", false, false, false, true)
	imageAlpha = imageAlpha + 2.5
	if imageAlpha >= 255 then 
		imageAlpha = 0
	end
	dxDrawRectangle(panelX, PanelY-200, 1000, 30, tocolor(0, 0, 0, 170))
	dxDrawRectangle(panelX, PanelY-200+30, 1000, 3, tocolor(254, 129, 0, 170))
	--dxDrawImage(panelX+800/2, PanelY-250, 200, 50, "files/logo.png",0 , 0, 0 ,tocolor(255, 255, 255, imageAlpha))
	
	for index, value in ipairs (shopActioveMenu) do 
		if isInSlot(panelX-225+index*(250), PanelY-200+5, 200, 20) or current == index then 
			dxDrawRectangle(panelX-225+index*(250), PanelY-200+5, 200, 20, tocolor(254, 129, 0, 230))
			dxDrawText(value[1], panelX-225+index*(250)+200/2, PanelY-200+20/2+5, panelX-225+index*(250)+200/2, PanelY-200+20/2+5, tocolor(0, 0, 0, 230), 1, font, "center", "center")
		else
			dxDrawRectangle(panelX-225+index*(250), PanelY-200+5, 200, 20, tocolor(0, 0, 0, 230))
			dxDrawText(value[1], panelX-225+index*(250)+200/2, PanelY-200+20/2+5, panelX-225+index*(250)+200/2, PanelY-200+20/2+5, tocolor(255, 255, 255, 230), 1, font, "center", "center")
		end
	end
	if current > 0 then 
		elem = 0
		for index, value in ipairs (premiumShop[current][1])  do 
			if (index > NextPage and elem < maxDraw) then
				elem = elem + 1
				local color = ""
				local Text = ""
				local r, g, b = 255, 255, 255
				if localPlayer:getData("char:pp") >= value[2] then 
					Text = "Comprar"
					color = "#FE8100"
					r, g, b = 254, 129, 0
				else
					Text = "Não há PP suficiente"
					color = "#dc143c"
					r, g, b = 210, 77, 87
				end
				
				Time = (getTickCount() - startTick) / 1300
				Size1 = interpolateBetween(0,0,0,50,0,0,Time,progress)
				
				dxDrawRectangle(panelX,  monitorSize[2]/2-50+elem*105/2-170, 1000, Size1, tocolor(0, 0, 0, 170))
				
				if isInSlot(panelX+1000-200-10,  monitorSize[2]/2-50+elem*105/2-170+10, 200, Size1-20) then 
					dxDrawRectangle(panelX+1000-200-10,  monitorSize[2]/2-50+elem*105/2-170+10, 200, Size1-20, tocolor(r, g, b, 170))
					dxDrawText(Text, panelX+1000-200-10+200/2,  monitorSize[2]/2-50+elem*105/2-170+10+30/2, panelX+1000-200-10+200/2, monitorSize[2]/2-50+elem*105/2-170+10+30/2, tocolor(0, 0, 0, 230), 1, font, "center", "center", false, false, false, true)
				else
					dxDrawRectangle(panelX+1000-200-10,  monitorSize[2]/2-50+elem*105/2-170+10, 200, Size1-20, tocolor(0, 0, 0, 170))
					dxDrawText(Text, panelX+1000-200-10+200/2,  monitorSize[2]/2-50+elem*105/2-170+10+30/2, panelX+1000-200-10+200/2, monitorSize[2]/2-50+elem*105/2-170+10+30/2, tocolor(255, 255, 255, 230), 1, font, "center", "center", false, false, false, true)
				end
				if current ~= 3 and current ~= 2  then 
					dxDrawImage(panelX+3,  monitorSize[2]/2-50+elem*105/2-167, 45, Size1-6, ":bgo_items/files/items/"..value[1]..".png")
					dxDrawText("Nome: "..value[5], panelX+1000/2+1,  monitorSize[2]/2-50+elem*105/2-170+Size1/2+1, panelX+1000/2+1, monitorSize[2]/2-50+elem*105/2-170+Size1/2+1, tocolor(0, 0, 0, 230), 1, font2, "center", "center", false, false, false, true)
					dxDrawText("Nome: #FE8100"..value[5], panelX+1000/2,  monitorSize[2]/2-50+elem*105/2-170+Size1/2, panelX+1000/2, monitorSize[2]/2-50+elem*105/2-170+Size1/2, tocolor(255, 255, 255, 230), 1, font2, "center", "center", false, false, false, true)
					
					dxDrawText("descrição: "..exports['bgo_items']:getItemDescription(value[1]), panelX+65+1,  monitorSize[2]/2-50+elem*105/2-164+1, 50, Size1, tocolor(0, 0, 0, 230), 1, font2, "left", "top", false, false, false, true)
					dxDrawText("descrição: #FE8100"..exports['bgo_items']:getItemDescription(value[1]), panelX+65,  monitorSize[2]/2-50+elem*105/2-164, 50, Size1, tocolor(255, 255, 255, 230), 1, font2, "left", "top", false, false, false, true)

					dxDrawText("Dinheiro Vip: "..money_chopping(value[4]), panelX+66,  monitorSize[2]/2-50+elem*105/2-146, 50, Size1, tocolor(0, 0, 0, 230), 1, font2, "left", "top", false, false, false, true)
					dxDrawText("Dinheiro Vip: ".. color ..money_chopping(value[4]), panelX+65,  monitorSize[2]/2-50+elem*105/2-145, 50, Size1, tocolor(255, 255, 255, 230), 1, font2, "left", "top", false, false, false, true)
				
				elseif current == 3 then 
					dxDrawImage(panelX+3,  monitorSize[2]/2-50+elem*105/2-167, 45, Size1-6, "files/change.png")
					dxDrawText("Nome: "..value[3], panelX+1000/2+1,  monitorSize[2]/2-50+elem*105/2-170+Size1/2+1, panelX+1000/2+1, monitorSize[2]/2-50+elem*105/2-170+Size1/2+1, tocolor(0, 0, 0, 230), 1, font2, "center", "center", false, false, false, true)
					dxDrawText("Nome: #FE8100"..value[3], panelX+1000/2,  monitorSize[2]/2-50+elem*105/2-170+Size1/2, panelX+1000/2, monitorSize[2]/2-50+elem*105/2-170+Size1/2, tocolor(255, 255, 255, 230), 1, font2, "center", "center", false, false, false, true)
					--dxDrawText("Preço: $"..money_chopping(value[4]), panelX+65+1,  monitorSize[2]/2-50+elem*105/2-164+1, 50, Size1, tocolor(0, 0, 0, 230), 1, font2, "left", "top", false, false, false, true)
					--dxDrawText("Preço: #FE8100$"..money_chopping(value[4]), panelX+65,  monitorSize[2]/2-50+elem*105/2-164, 50, Size1, tocolor(255, 255, 255, 230), 1, font2, "left", "top", false, false, false, true)
					
					dxDrawText("Dinheiro Vip: "..money_chopping(value[4]), panelX+66,  monitorSize[2]/2-50+elem*105/2-146, 50, Size1, tocolor(0, 0, 0, 230), 1, font2, "left", "top", false, false, false, true)
					dxDrawText("Dinheiro Vip: ".. color ..money_chopping(value[4]), panelX+65,  monitorSize[2]/2-50+elem*105/2-145, 50, Size1, tocolor(255, 255, 255, 230), 1, font2, "left", "top", false, false, false, true)					
				elseif current == 2 then 
					dxDrawText("Nome: ".. value[5] .."DB: "..value[3], panelX+1000/2+1,  monitorSize[2]/2-50+elem*105/2-170+Size1/2+1, panelX+1000/2+1, monitorSize[2]/2-50+elem*105/2-170+Size1/2+1, tocolor(0, 0, 0, 230), 1, font2, "center", "center", false, false, false, true)
					dxDrawText("Nome: #FE8100".. value[5] .." #ffffffDB: #FE8100"..value[3], panelX+1000/2,  monitorSize[2]/2-50+elem*105/2-170+Size1/2, panelX+1000/2, monitorSize[2]/2-50+elem*105/2-170+Size1/2, tocolor(255, 255, 255, 230), 1, font2, "center", "center", false, false, false, true)
					dxDrawText("descrição: "..exports['bgo_items']:getItemDescription(value[1]), panelX+65+1,  monitorSize[2]/2-50+elem*105/2-164+1, 50, Size1, tocolor(0, 0, 0, 230), 1, font2, "left", "top", false, false, false, true)

					

					dxDrawText("descrição: #FE8100"..exports['bgo_items']:getItemDescription(value[1]), panelX+65,  monitorSize[2]/2-50+elem*105/2-164, 50, Size1, tocolor(255, 255, 255, 230), 1, font2, "left", "top", false, false, false, true)
					
					dxDrawText("Dinheiro Vip: "..money_chopping(value[4]), panelX+66,  monitorSize[2]/2-50+elem*105/2-146, 50, Size1, tocolor(0, 0, 0, 230), 1, font2, "left", "top", false, false, false, true)
					dxDrawText("Dinheiro Vip: ".. color ..money_chopping(value[4]), panelX+65,  monitorSize[2]/2-50+elem*105/2-145, 50, Size1, tocolor(255, 255, 255, 230), 1, font2, "left", "top", false, false, false, true)
					dxDrawImage(panelX+3,  monitorSize[2]/2-50+elem*105/2-167, 45, Size1-6, ":bgo_items/files/items/"..value[1]..".png")
				
				end
			end
		end
	end
end

--<[ Görgetés ]>--
bindKey("mouse_wheel_down", "down", 
	function() 
		if show then
			if NextPage < #premiumShop[current][1] - maxDraw then
				NextPage = NextPage + 1	
			end
		end
	end
)

bindKey("mouse_wheel_up", "down", 
	function() 
		if show then
			if NextPage > 0 then
				NextPage = NextPage - 1		
			end
		end
	end
)
--<[ Görgetés vége ]>--

function money_chopping(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

local sx, sy = guiGetScreenSize()
local scaleX, scaleY = 250, 25 
local waitTime = 1 

-- választható színek

local colors = {
	red = {225,0,0,145},
	green = {0,135,255,230}, 
	black = {0,0,0,255},
	white = {222,222,222,222} 
}

local notifications = {}

addEventHandler("onClientRender", getRootElement(),
	function()
		for i,v in pairs(notifications) do
			scaleX = dxGetTextWidth(v.text, 1, font, true) + 40
			dxDrawRectangle(v.posX, v.posY, scaleX, scaleY, tocolor(0, 0, 0, 180),true,true,true)
			dxDrawRectangle(v.posX, v.posY+scaleY, scaleX, scaleY-23, tocolor(colors[v.color][1], colors[v.color][2], colors[v.color][3], colors[v.color][4]),true,true,true, true)
			dxDrawText(v.text, v.posX, v.posY, v.posX+scaleX, v.posY+scaleY, tocolor(230, 230, 230, 255), 1, font, "center", "center",false,true,true, true)
			
			if (v.delete == true) then
				v.posX = v.posX+5
				if (v.posX >= sx) then
					notifications[i] = nil
				end
			else
				if (v.posY ~= scaleY*(i)) and (v.finish == false) then
					v.posY = v.posY+1
				else
					if (v.finish == false) then
						v.finish = true
					end
				end
			end
		end
	end
)

function addNotification(string, color)
	if (not string) then return end
	local string = tostring(string)
	scaleX = dxGetTextWidth(string, 1, font, true) + 40
	table.insert(notifications, {
		text 	= string,
		posX 	= sx/2-(scaleX)/2,
		posY 	= 0,
		color 	= color,
		finish	= false,
		delete	= false,
		timer	= nil
	})	
	notifications[#notifications].timer = setTimer(function(id)
		deleteNotification(id)
	end, waitTime+(#notifications*1000), 1, #notifications)
end
addEvent("showNotifications", true)
addEventHandler("showNotifications", getRootElement(), addNotification)

function deleteNotification(id)
	if (not tonumber(id)) then return end
	local id = tonumber(id)
	if (not notifications[id]) then return end
	if (notifications[#notifications].timer) and (isElement(notifications[#notifications].timer)) and (isTimer(notifications[#notifications].timer)) then
		killTimer(notifications[#notifications].timer)
	end
	notifications[id].delete = true
end



function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end