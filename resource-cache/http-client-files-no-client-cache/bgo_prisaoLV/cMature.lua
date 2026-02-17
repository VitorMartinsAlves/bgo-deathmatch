local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local x, y =  (screenW/resW), (screenH/resH)

addEventHandler("onClientKey", root, 
	function (button, press)
		if dxReason == true then
			if button == "F1" or button == "F2" or button == "F3" or button == "F4" or button == "F5" or button == "F6" or button == "F7" or button == "F9" or button == "F10" or button == "F11" or button == "F12" or button == "t" or button == "p" then
				cancelEvent()
			end
		end
	end
)


 local zone = createColCuboid(2237.88354, 2470.90747, 8.32966, 4.48095703125, 4.66650390625, 7.9)
 
local sx,sy = guiGetScreenSize()

local jobPed = {}
local roboto = dxCreateFont("Roboto.ttf",14)



local job_PedPos = {
	{283, 2249.523, 2462.006, 10.83, "Prisão LV",269.23583984375},
}
local startTick = getTickCount()
local progress = ""
local elements = ""

local maxElem = 6
local nextPage = 0
local show = false

function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)

		setPedRotation(jobPed[index], value[6])

		jobPed[index]:setData("ped:job3", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:job3") then
			cancelEvent ()
		end
	end
)

Boxtime = guiCreateEdit(x*595, y*430, 74, 24, "", false)
Boxreason = guiCreateEdit(x*700, y*430, 212, 25, "", false)  
guiSetVisible(Boxtime, false) 
guiSetVisible(Boxreason, false) 

function createPanel()

	local jX, jY, jZ = getElementPosition(getLocalPlayer())
	local bX, bY, bZ = getElementPosition(elements)
	if (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then removeEventHandler("onClientRender", root, createPanel) 
	removeEventHandler("onClientKey",root,keyControl) 
	show = false 
	return 
	end

	dxDrawRectangle(sx/2-200,sy/2-250,400,500,tocolor(0,0,0,240))
	dxDrawText("BGO#FC7100MTA #FFFFFF- Prisão",sx/2-195,sy/2-233,sx/2-195,sy/2-233,tocolor(255,255,255,255),1,roboto,"left","center",false,false,false,true)

	if isInSlot(sx/2+200-60,sy/2-280,60,20) then
		dxDrawRectangle(sx/2+200-60,sy/2-280,60,20,tocolor(205,92,92,255))
	else
		dxDrawRectangle(sx/2+200-60,sy/2-280,60,20,tocolor(205,92,82,100))
	end
	dxDrawText("Fechar",sx/2+149,sy/2-280,sx,sy,tocolor(0,0,0,255),0.7,roboto,"left")

	local elem = 0
	--for index, value in ipairs (jobs_Table) do 
		count = {}
		for i,v in pairs(getElementsWithinColShape(zone,"player")) do
			table.insert(count,v)
		end
		for index, value in ipairs(count) do
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			local text = ""
			local r, g, b = 252, 113, 0
				text = "Prender"
			dxDrawText(getPlayerName(value).."", sx/2-190, sy/2.7-100+elem*(60), sx/2, 0, tocolor(255, 255, 255, 255), 0.89, roboto, "left", "top", false, false, false, true)
			if isInSlot(sx/2+70, sy/2.8-95+elem*(60), 120, 40) then
				dxDrawRectangle(sx/2+70, sy/2.8-95+elem*(60), 120, 40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx/2+70, sy/2.8-95+elem*(60), 120, 40, tocolor(r, g, b, 150, 130, 0))
			end
			dxDrawText(text, sx/2+260, sy/2.7-100+elem*(60), sx/2, 0, tocolor(255, 255, 255, 255), 0.89, roboto, "center", "top", false, false, false, true)
		end
	end
end

local altura = 0
addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:job3") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 

				if getElementData(localPlayer, "char:adminduty") == 1 or exports.bgo_admin:isPlayerDuty(localPlayer) then
	

				startTick = getTickCount()
				progress = "OutBack"
				removeEventHandler("onClientRender", root, createPanel)
				addEventHandler("onClientRender", root, createPanel)
				removeEventHandler("onClientKey",root,keyControl)
				addEventHandler("onClientKey",root,keyControl)
				show = true
				elements = element
			end
		end
	end
	elseif state == "down" and button == "left" and show then 
	if isInSlot(sx/2+200-60,sy/2-280,60,20) then
	removeEventHandler("onClientRender", root, createPanel)
	removeEventHandler("onClientKey",root,keyControl)
	show = false
	elements = nil

	end
		elem = 0

		count = {}
		for i,v in pairs(getElementsWithinColShape(zone,"player")) do
			table.insert(count,v)
		end
		for index, value in ipairs(count) do

		--for index, value in ipairs (jobs_Table) do 
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1
				if dobozbaVan(sx/2+70, sy/2.8-95+elem*(60), 120, 40, x, y) then 

					 local tempo = 5
					 local motivo = "teste" 
					 presoPlayer = value
					 show = false
					 removeEventHandler("onClientRender", root, createPanel)
					 

					painel = exports.dgs:dgsCreateWindow(607, 619, 360, 100, "PRISÃO GAMING ONLINE", false)
					exports.dgs:dgsWindowSetSizable(painel, false)
					buttonc = exports.dgs:dgsCreateButton(10, 40, 108, 30, "CONCLUIR", false, painel)
					buttonf = exports.dgs:dgsCreateButton(118, 40, 108, 30, "FECHAR", false, painel)
					edittem = exports.dgs:dgsCreateEdit(10, 5, 120, 26, "TEMPO", false, painel)
					editmot = exports.dgs:dgsCreateEdit(135, 5, 212, 26, "MOTIVO", false, painel)
					exports.dgs:dgsAlphaTo(painel,0,false,"OutQuad",1000)
					exports.dgs:dgsAlphaTo(painel,100,false,"OutQuad",1000)
					exports.dgs:dgsSetVisible (painel, true )
					exports.dgs:dgsWindowSetMovable (painel, true)
					addEventHandler("onDgsWindowClose",painel,windowClosed)

					addEventHandler ( "onDgsMouseClick", root, buttons );



					 
				end
			end
		end
		end
		--triggerServerEvent("updateJobToServer", localPlayer, currentjob)
end)






function buttons ( button, state )
     if button == "left" and state == "down" then
		if ( source == buttonc ) then 
		    if (exports.dgs:dgsGetText(edittem) == "TEMPO" or exports.dgs:dgsGetText(editmot) == "MOTIVO") then
				 outputChatBox("#FFA000[BGO INFO]: #FFFFFFArgumtento inválido.", 255,255,255, true)
				 return
			end
            if not (exports.dgs:dgsGetText(edittem)) then
			     outputChatBox("#FFA000[BGO INFO]: #FFFFFFAdicione um tempo de prisão.", 255,255,255, true)
			else
			getTimer = math.floor(exports.dgs:dgsGetText(edittem))
			     if not ((getTimer or 0) > 1) then
				      outputChatBox("#FFA000[BGO INFO]: #FFFFFFO tempo de prisão deve ser maior do que 2 minutos.", 255,255,255, true)
				 else
				 if not (exports.dgs:dgsGetText(editmot)) then
				      outputChatBox("#FFA000[BGO INFO]: #FFFFFFAdicione um motivo para continuar com a prisão.", 255,255,255, true)
				 else 
				     getReason = exports.dgs:dgsGetText(editmot)
				     triggerServerEvent("prendendoLV", localPlayer, localPlayer, presoPlayer, getTimer, getReason)
					 removeEventHandler ( "onDgsMouseClick", root, buttons );
		    		 show = false
		    		 elements = nil
					 presoPlayer = nil
					 windowClosed()
					 end
				 end
			end
			elseif ( source == buttonf ) then 
					windowClosed()
					removeEventHandler ( "onDgsMouseClick", root, buttons );
		    		 show = false
		    		 elements = nil
					 presoPlayer = nil
			
		 end 
	 end
end 

function onDestroyed()
	--outputChatBox("A "..exports.dgs:dgsGetType(source).." has been destroyed")
end
addEventHandler("onDgsDestroy",getRootElement(),onDestroyed)

function windowClosed()
	cancelEvent()
	exports.dgs:dgsAlphaTo(painel,0,false,"OutQuad",1000)

	showCursor(false)
	setTimer(function()
	--exports.dgs:dgsSetVisible (painel, false)
	
	if isElement(painel) then 
	destroyElement(buttonc)
	destroyElement(buttonf)
	destroyElement(edittem)
	destroyElement(editmot)
	destroyElement(painel)
	removeEventHandler ( "onDgsMouseClick", root, buttons );
	end
	
	end,1100,1)
end

function keyControl(k, s)
	if k == "mouse_wheel_up" then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif k == "mouse_wheel_down" then
		count = {}
		for i,v in pairs(getElementsWithinColShape(zone,"player")) do
			table.insert(count,v)
		end
		for index, value in ipairs(count) do
		nextPage = nextPage + 1
		if(nextPage > index-maxElem)then
			nextPage = index-maxElem
		end

	end
	elseif k == "backspace" then
		removeEventHandler("onClientRender", root, createPanel)
		removeEventHandler("onClientKey",root,keyControl)
		show = false
	end
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
