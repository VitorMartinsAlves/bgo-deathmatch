local dgs = exports.dgs
--local painel = {window={}, tab={}, button={}, grid={}, column={}, edit={}}


local painel = {}

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)


function painelChamada(text, reason )
if not isElement(painel.tab)  then

	     nome = text or "N/A"
		 motivo = reason or "Sem Motivo"
		 
		 
	painel.tab = dgs:dgsCreateTabPanel(sx*752, sy*152,sx*425, sy*60, false, false)
	painel.tab2 = dgs:dgsCreateTabPanel(sx*756, sy*156, sx*35, sy*50, false, false)
	dgs:dgsSetProperty(painel.tab2,"bgColor",tocolor(0, 250, 33, 155))
	
	painel.grid3 = dgs:dgsCreateLabel( sx*772.5,sy*186.5,sx*0.94,sy*0.2, "E", false,false, tocolor(255,255,255,255), 2, 2, 1, 1, tocolor(0, 0, 0,255), "center", "center")
	dgs:dgsSetFont ( painel.grid3, "default-bold" )
	
	painel.tab3 = dgs:dgsCreateTabPanel(sx*795, sy*156, sx*35, sy*50, false, false)
	dgs:dgsSetProperty(painel.tab3,"bgColor",tocolor(255, 0, 0, 155))
	painel.grid4 = dgs:dgsCreateLabel( sx*810,sy*186.5, sx*0.94,sy*0.2, "Q", false,false, tocolor(255,255,255,255), 2, 2, 1, 1, tocolor(0, 0, 0,255), "center", "center")
	dgs:dgsSetFont ( painel.grid4, "default-bold" )
	
	painel.tab4 = dgs:dgsCreateTabPanel(sx*1135, sy*156, sx*35, sy*50, false, false)
	dgs:dgsSetProperty(painel.tab4,"bgColor",tocolor(99, 99, 99, 155))
	
	
	painel.grid2 = dgs:dgsCreateLabel( sx*1150.9,sy*186.5,sx*0.94,sy*0.2, "10", false,false, tocolor(255,255,255,255), 2, 2, 1, 1, tocolor(0, 0, 0,255), "center", "center")
	dgs:dgsSetFont ( painel.grid2, "default-bold" )
	

	painel.tab5 = dgs:dgsCreateTabPanel(sx*752, sy*200,sx*425, sy*40, false, false)
	painel.grid1 = dgs:dgsCreateLabel( sx*970,sy*186.5,sx/2, 0, nome, false,false, tocolor(255,255,255,255), 1.3, 1.3, 1, 1, tocolor(0, 0, 0,255), "center", "center")
	dgs:dgsSetFont ( painel.grid1, "default-bold" )


	painel.grid5 = dgs:dgsCreateLabel( sx*965,sy*226.5,sx/2, 0, motivo, false,false, tocolor(255,255,255,255), 1.2, 1.2, 1, 1, tocolor(0, 0, 0,255), "center", "center")
	dgs:dgsSetFont ( painel.grid5, "default-bold" )
	

	end
end


function startTime ()
     if segundos then
	     segundos =  segundos - 1
		 dgs:dgsSetText ( painel.grid2, segundos )
	 end
	 if segundos < 1 then
	     dxChamada = false
		 if isTimer(timerDx) then
		     killTimer(timerDx)
		 end
		 fecharChamada()
		 if isTimer(timerC) then
		     killTimer(timerC)
		 end
	 end
end



function startDxS (text, reason)
     if not text  then return end
     if not dxChamada then
	 painelChamada(text, reason)
	 		 sound = playSound("noti.mp3")
		 setSoundVolume(sound, 0.05)
	     dxChamada = true
		 segundos = 10
		 timerDx = setTimer(startTime, 1000, 0)
		 timerC = setTimer(function()
		     startDxS ()
		 end, 10000, 1)
	 else
	     dxChamada = false
		 if isTimer(timerDx) then
		     killTimer(timerDx)
		 end
		fecharChamada()
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
		  fecharChamada()
		 if isTimer(timerC) then
		     killTimer(timerC)
		 end
	 end
end
bindKey("q","down", cancelDxS) 
bindKey("e","down", cancelDxS) 



function fecharChamada()
	for _, element in pairs(painel) do
		if isElement(element) then destroyElement(element) end
	end
end



function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end
















