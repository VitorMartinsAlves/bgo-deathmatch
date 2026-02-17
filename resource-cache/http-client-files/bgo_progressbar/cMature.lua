--[[
local screenW, screenH   = guiGetScreenSize()
local resW2, resH2       = 1920,1080
local x, y               = (screenW/resW2), (screenH/resH2)

downloading = false
local start = {}
function dxDrawLoading ()
    local now = getTickCount()
    seconds = second or timer
	local color = color or tocolor(0,0,0,170)
	local color2 = color2 or tocolor(255,255,0,170)
	local size = size or x*1.00
    local with = interpolateBetween(0,0,0,0.2531,0,0, (now - start) / ((start + seconds) - start), "Linear")
    local text = interpolateBetween(0,0,0,100,0,0,(now - start) / ((start + seconds) - start),"Linear")
        dxDrawRectangle(screenW * 0.3792, screenH * 0.6907, screenW * 0.2635, screenH * 0.0407, tocolor(0, 0, 0, 193), false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.7000, screenW * with, screenH * 0.0222, tocolor(118, 190, 87, 211), false)
        dxDrawText(math.floor(text).."%", screenW * 0.3792, screenH * 0.6907, screenW * 0.6427, screenH * 0.7315, tocolor(255, 255, 255, 254), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
	if msgProgress then
	     dxDrawText("#7cc576"..msgProgress or "", screenW * 0.3203, screenH * 0.6546, screenW * 0.7000, screenH * 0.6880, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, true, false)
	end
 end

function progressServiceBar (timeP, msgP)
     if not (downloading == false) then
         removeEventHandler("onClientRender", root, dxDrawLoading)		
    	 downloading = false 
	 end
	 if msgP then
	     msgProgress = msgP
	 end
	     if timeP then
	         timer = timeP*1000
	         setTimer(progressServiceBar, timer, 1)
             addEventHandler("onClientRender", root, dxDrawLoading)
		     downloading = true
		     start = getTickCount()
             else
             removeEventHandler("onClientRender", root, dxDrawLoading)		
    		 downloading = false 
			 msgP = nil
			 msgProgress = nil
     end
end
addEvent("progressService", true)
addEventHandler("progressService", root, progressServiceBar)

local x,y = guiGetScreenSize()
 function isCursorOnElement(x,y,w,h)
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end
]]--

function progressServiceBar (timeP, msgP)
     if not (downloading == false) then
        -- removeEventHandler("onClientRender", root, dxDrawLoading)		
    	 downloading = false 
	 end
	 if msgP then
	     msgProgress = msgP
	 end
	     if timeP then
	         timer = timeP
	         --setTimer(progressServiceBar, timer, 1)
           --  addEventHandler("onClientRender", root, dxDrawLoading)
		   
		   createProgressBar(timer)
		     downloading = true
		     --start = getTickCount()
             else
           --  removeEventHandler("onClientRender", root, dxDrawLoading)		
    		 downloading = false 
			 msgP = nil
			 msgProgress = nil
     end
end
addEvent("progressService", true)
addEventHandler("progressService", root, progressServiceBar)

local qte = {}

local screenW, screenH   = guiGetScreenSize()
local resW2, resH2       = 1920,1080
local sx, sy               = (screenW/resW2), (screenH/resH2)

qte.balance = {}
qte.balance.state = false
qte.balance.difficulty = 1
qte.balance.rot = 0
qte.balance.keyType = nil
qte.balance.dir = nil
qte.balance.a = 0
qte.balance.accMult = 0.2
qte.balance.progressGui={}
qte.balance.progressTime = 100
qte.balance.beginTick = 0
qte.balance.tick = 0
qte.balance.timer = nil


function createProgressBar(progressTime)
	qte.balance.progressTime = progressTime*1000
	qte.balance.tick = getTickCount()
	qte.balance.progressGui.width = sx*512
	qte.balance.progressGui.height = sy*74
	qte.balance.progressGui.barStartX = 120
	qte.balance.progressGui.barWidth = 268



	
	addEventHandler("onClientRender",getRootElement(),renderProgressGui)
	qte.balance.timer = setTimer(function()
		removeEventHandler("onClientRender",getRootElement(),renderProgressGui)
		--setBalanceQTEState(false)
		--sucesso(true)
	end,progressTime*1000,1)
end

function renderProgressGui()
	local alpha = 255
	local currentX = sx*710 --sx/2-qte.balance.progressGui.width/2
	local currentY = sy*900
	local progress = (getTickCount()-qte.balance.tick)/qte.balance.progressTime
	local fuelFullWidth = interpolateBetween(qte.balance.progressGui.barStartX,0,0,qte.balance.progressGui.barStartX+qte.balance.progressGui.barWidth,0,0,progress,"Linear")
	local fuelEmptyWidth = qte.balance.progressGui.width - fuelFullWidth
	local fuelEmptyX = qte.balance.progressGui.width - fuelEmptyWidth
	dxDrawImageSection(currentX,currentY,fuelFullWidth,qte.balance.progressGui.height,0,0,fuelFullWidth,qte.balance.progressGui.height,"files/progresson.png",0,0,0,tocolor(255,255,255,alpha))
	dxDrawImageSection (currentX+fuelEmptyX,currentY,fuelEmptyWidth,qte.balance.progressGui.height,fuelEmptyX,0,fuelEmptyWidth,qte.balance.progressGui.height,"files/progressoff.png",0,0,0,tocolor(255,255,255,alpha))

	if msgProgress then
		dxDrawText("#7cc576"..msgProgress or "",sx*1925, sy*1800, sx/2, 0,tocolor(255,255,255,255),sy/0.7,"default-bold","center", "center",false,false,false,true)
	end
end