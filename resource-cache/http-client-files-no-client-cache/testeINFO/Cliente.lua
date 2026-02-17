dxChamada = false

local screenW, screenH = guiGetScreenSize()

local SAFEZONE_Y = screenH*0.1367


 
function testeinfo()
	     if dxChamada then
		 	local dY = 170
			local dY = dY+SAFEZONE_Y
	
		     dxDrawImage (screenW * 0.7325, dY, screenW * 0.2475, screenH * 0.0578, "fundo.png", 0, 0, 0, tocolor(0, 0, 0, 220))
             dxDrawImage (screenW * 0.7388, dY+12, screenW * 0.0213, screenH * 0.0356, "button2.png", 0, 0, 0, tocolor(0, 245, 0, 170))
			 dxDrawImage (screenW * 0.7631, dY+12, screenW * 0.0213, screenH * 0.0356, "button1.png", 0, 0, 0, tocolor(244, 0, 5, 170))
			 dxDrawImage (screenW * 0.9525, dY+12, screenW * 0.0213, screenH * 0.0356, "button3.png", 0, 0, 0, tocolor(122, 122, 122, 170))
			 
			 	local dY = 365
				local dY = dY+SAFEZONE_Y
	
             dxDrawText(reason, screenW * 0.7837, dY, screenW * 0.9525, screenH * 0.1722, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
             dxDrawText("E", screenW * 0.7381, dY, screenW * 0.7600, screenH * 0.1722, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
             dxDrawText("Q", screenW * 0.7625, dY, screenW * 0.7844, screenH * 0.1711, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
             dxDrawText(segundos, screenW * 0.9519, dY , screenW * 0.9738, screenH * 0.1722, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
		 end
    end


function startTime ()
     if segundos then
	     segundos =  segundos - 1
	 end
	 if segundos < 0 then
	     dxChamada = false
		 if isTimer(timerDx) then
		     killTimer(timerDx)
		 end
		 if isTimer(timerC) then
		     killTimer(timerC)
		 end
	 end
end

function startDxS (text)
     if not text  then return end
     if not dxChamada then
	 addEventHandler("onClientRender", root, testeinfo)
	     reason = text
	     dxChamada = true
		 segundos = 10
		 sound = playSound("noti.mp3")
		 setSoundVolume(sound, 0.05)
		 timerDx = setTimer(startTime, 1000, 0)
		 timerC = setTimer(function()
		     startDxS ()
		 end, 10000, 1)
	 else
	     dxChamada = false
		 if isTimer(timerDx) then
		     killTimer(timerDx)
		 end
		 removeEventHandler("onClientRender", root, testeinfo)
	 end
end
addEvent("chamada:dx", true)
addEventHandler("chamada:dx", root, startDxS)

function cancelDxS ()
     if dxChamada then
	     dxChamada = false
		 if isTimer(timerDx) then
		     killTimer(timerDx)
		 end
		 removeEventHandler("onClientRender", root, testeinfo)
		 if isTimer(timerC) then
		     killTimer(timerC)
		 end
	 end
end
bindKey("q","down", cancelDxS) 
bindKey("e","down", cancelDxS) 