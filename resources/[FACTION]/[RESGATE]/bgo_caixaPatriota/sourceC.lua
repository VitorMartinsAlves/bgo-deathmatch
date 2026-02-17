local sx, sy = guiGetScreenSize()
local offset = sx / 1920
local height = 80 * offset
local imgO = 80 * offset
local width = 600
local left = sx/2-width/2
local top = sy/2 - height/2
local nwidth = 375 * offset
local nheight = 122 * offset
local max = 100
local startLeft = 0
local startTime = 0
local startTime2 = 0
local startTime3 = 0
local endTime = 0
local randI = 0
local minRand = math.ceil(sx / imgO + 0.5)
local startTime = getTickCount()
local startTime2 = getTickCount()
local startTime3 = getTickCount()
local showedPanel = false
--endTime = math.random(8000,25000)
local showImage = false
local showImage2 = false

local panelW,panelH = 660,200
local panelX,panelY = sx/2 - panelW/2,sy/2 - panelH/2
local itemRotates = {}
local objects = nil


local font = dxCreateFont("files/calibri.ttf",12)

	
	
function createEventPanel()
	local added = (sx - minRand*imgO) / 2
		dxDrawImage(0, 0,panelX+1290,panelY+638, "files/bg_case.png", 0, 0, 0, tocolor(255,255,255,155))
		dxDrawImage(panelX-400,panelY-400,panelW+950,panelH+700, "files/roll_bg.png", 0, 0, 0, tocolor(255,255,255,255))
		if not showImage2 and not showImage then
		local x, y, _ = interpolateBetween ( 
		panelX+190, panelY-10,0,
		panelX+190, panelY-100, 0,
		(getTickCount()-startTime2)/2000, "OutElastic")
		dxDrawImage(x,y,panelW-400,panelH-50, "files/case.jpg", 0, 0, 0, tocolor(255,255,255,255))
		if isMouseInPosition(panelX+215,panelY+150,210,40) then
		dxDrawButton("ABRIR", panelX+215,panelY+150,210,40,tocolor(0,0,0,150))
		else
		dxDrawButton("ABRIR", panelX+215,panelY+150,210,40,tocolor(0,0,0,100))
		end	
		end
		if showImage2 then
		local x, y, _ = interpolateBetween ( 
		panelX+190, panelY-100,0,
		panelX+190, panelY-700, 0,
		(getTickCount()-startTime2)/1000, "InBack")
		dxDrawImage(x,y,panelW-400,panelH-50, "files/case.jpg", 0, 0, 0, tocolor(255,255,255,255))
		end
		if showImage then
		local id = math.ceil((startLeft - imgO/2)/imgO + 0.5) + math.ceil(minRand/2 + 0.5) - 1		
		local data = itemRotates[id]
		if data then
			if(data[1]==1 or data[1]==2)then
				dxDrawText(""..exports["bgo_items"]:getItemName(data[2], data[3]), sx/2 - nwidth/2+1, top+85 - nheight - 5-50, sx/2 - nwidth/2 + nwidth, top - nheight - 5 + 90*offset, tocolor(0,0,0,255), 2,"default", "center", "center",false,false,false,true)
				dxDrawText("#D24D57"..exports["bgo_items"]:getItemName(data[2], data[3]), sx/2 - nwidth/2, top+80 - nheight - 5-50, sx/2 - nwidth/2 + nwidth, top - nheight - 5 + 90*offset, tocolor(255,255,255,255), 2,"default", "center", "center",false,false,false,true)

			end
		end
		for i, v in ipairs(itemRotates) do
			local color = tocolor(255,255,255,100)
			if id == i then
				color = tocolor(255,255,255,255)
			end
			if(data[1]==1 or data[1]==2)then
				local cx = imgO * (i-1) - startLeft
				if cx >= sx/2-1120 and cx <= sx/2+1080 then
				local x, y, _ = interpolateBetween ( 
				cx, top+500,0,
				cx, top, 0,
				(getTickCount()-startTime)/3000, "OutElastic")
					dxDrawImage(x, y, imgO, imgO, ":bgo_items/files/items/"..v[2]..".png", 0, 0, 0, color)
				end
			end
		end
		if(id~=lastSzam)then
			lastSzam = id
			playSound("files/_roll.mp3")
		end
		startLeft = interpolateBetween(0,0,0,(#itemRotates - randI)*imgO - added,0,0,(getTickCount()-startTime)/endTime,"OutQuad")
		lastSzam = id
	end
end


function ganhou()
		local data = itemRotates[lastSzam]
		dxDrawImage(0, 0,panelX+1290,panelY+638, "files/bg_case.png", 0, 0, 0, tocolor(255,255,255,155))
		local x, y, _ = interpolateBetween ( 
		panelX+260, panelY-10,0,
		panelX+260, panelY-60, 0,
		(getTickCount()-startTime3)/2000, "OutElastic")
		dxDrawImage(panelX-450,panelY-400, panelW+850,panelH+600, "files/reward_bg.png", 0, 0, 0, tocolor(255,255,255,255))
		dxDrawImage(x,y, 120 * offset, 120 * offset, ":bgo_items/files/items/"..data[2]..".png", 0, 0, 0, tocolor(255,255,255,255))	
		dxDrawText("Você ganhou: "..exports["bgo_items"]:getItemName(data[2], data[3]), sx/2 - nwidth/2, top+380 - nheight - 5-50, sx/2 - nwidth/2 + nwidth, top - nheight - 5 + 90*offset, tocolor(255,255,255,255), 2,"default", "center", "center",false,false,false,true)
end


function dxDrawButton(text, startX, startY, width, height, color)
	dxDrawRectangle(startX - 1, startY, 1, height, bgColor) --left
	dxDrawRectangle(startX + width, startY, 1, height, bgColor) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, bgColor) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, bgColor) --bottom
	dxDrawRectangle(startX, startY, width, height, color)
	dxDrawText(text, startX+1, startY+1, startX + width, startY + height, tocolor(0, 0, 0,255), 1, font, "center", "center", false, false, false, true)
	dxDrawText(text, startX, startY, startX + width, startY + height, tocolor(255, 255, 255,255), 1, font, "center", "center", false, false, false, true)

end



addEvent('btcMTA->destroyEventPatriota', true)
addEventHandler('btcMTA->destroyEventPatriota', root, function()
	removeEventHandler("onClientRender", getRootElement(), createEventPanel)
	setElementData(localPlayer,"btcMTA:Event", false)
	if objects then 
		setElementData(objects,"eventBox->Use",false)
	end
	setTimer(function()
		objects = nil
		endTime = 0
		showedPanel = false
		showImage = false
		endTime = 0
		randI = 0
		minRand = math.ceil(sx / imgO + 0.5)
		startTime = getTickCount()
		startTime2 = getTickCount()
		startTime3 = getTickCount()
	end,500,1)
end)

addEventHandler('onClientClick', root, function (button, state, _, _, _, _, _, element)
	if button == "left" and state == "down" and showedPanel then
		if isTimer(timer) then return end
		if(startTime+endTime>getTickCount())then return false end
		if isMouseInPosition(panelX+225,panelY+150,210,40) then
			
			startTime2 = getTickCount()
			showImage2 = true
			playSound("files/buy_effect.wav")
			setTimer(function()
			startTime = getTickCount()
			showImage = true
			showImage2 = false
			endTime = 22000 --math.random(8000,25000)

			if(isTimer(timer1))then killTimer(timer1) end
			timer1 = setTimer(function()
				local data = itemRotates[lastSzam]
				local text = "Desconhecido"
				-- if(data[1]==2 or data[1]==4)then
					text = exports["bgo_items"]:getItemName(data[2])
					triggerServerEvent("btcMTA->#giveItem3",localPlayer,localPlayer,data[2],objects, data[3])
				triggerServerEvent("btcMTA->#setPlayerMe", localPlayer, localPlayer, "Ganhou um item na caixa patriota: (" .. text .. ")")
 
 

					removeEventHandler("onClientRender",getRootElement(),createEventPanel)
					startTime3 = getTickCount()
					addEventHandler("onClientRender",getRootElement(),ganhou,true,"low-5")
					playSound("files/reward_big.wav")
					setTimer(function()
					removeEventHandler("onClientRender",getRootElement(),ganhou)
					end,10000,1)
					setElementData(localPlayer,"btcMTA:Event",true)
					setTimer(function()
						objects = nil
						endTime = 0
						showedPanel = false
						showImage = false
						endTime = 0
						randI = 0
						minRand = math.ceil(sx / imgO + 0.5)
						startTime = getTickCount()
					end,500,1)
				-- end
			end,endTime-500,1)
						end,2000,1)
		end
	end
end)

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

local cpString = ""
addCommandHandler("gencp", function()
	if getElementData(localPlayer,"adminlevel") >= 9 then
		outputChatBox("új")
		local x,y,z = getElementPosition(localPlayer)
		cpString = cpString.."\n".."{"..x..","..y..","..z.."},"
		outputChatBox(cpString)
		setClipboard(cpString)
	end
end)


function startEventFunction()
			itemRotates = {}
			for i=0, max do
				table.insert(itemRotates, items[math.random(#items)])
			end
			randI = math.random(minRand, minRand + 4)
			startTime = getTickCount()
			startTime2 = getTickCount()
			startTime3 = getTickCount()
			endTime = 0
			timer = setTimer(function() end, 200, 1)
			addEventHandler("onClientRender",getRootElement(),createEventPanel,true,"low-5")
			showImage = false
			showImage2 = false
			showedPanel = true
end
addEvent('btcMTA->iniciarEventPatriota', true)
addEventHandler('btcMTA->iniciarEventPatriota', root, startEventFunction)



