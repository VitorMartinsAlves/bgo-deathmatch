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

status1 = "abrir"
status2 = "abrir"

status3 = "abrir"


function texto ()
   	 if ( getDistanceBetweenPoints3D ( 1583.458, -1702.877, 13.598 + 0.5, getElementPosition ( localPlayer ) ) ) < 20 then
   	 local coords = { getScreenFromWorldPosition ( 1583.458, -1702.877, 13.598 + 0.5 ) }
   	     if coords[1] and coords[2] then
		     if (getElementData(localPlayer, "zoneInfo1")) then
	   	         dxDrawText("Pressione [E] Para "..status2, coords[1], coords[2], coords[1], coords[2], tocolor(255, 255, 255, 255), x*1.20, "default-bold", "center", "center", false, false, false,  true, false)
		     end
	     end
	end 
end
addEventHandler("onClientRender",root,texto)

function texto2 ()
   	 if ( getDistanceBetweenPoints3D ( 1582.487, -1699.11, 13.598 + 0.5, getElementPosition ( localPlayer ) ) ) < 20 then
   	 local coords = { getScreenFromWorldPosition ( 1582.487, -1699.11, 13.598 + 0.5 ) }
   	     if coords[1] and coords[2] then
		     if (getElementData(localPlayer, "zoneInfo2")) then
	   	         dxDrawText("Pressione [E] Para "..status1, coords[1], coords[2], coords[1], coords[2], tocolor(255, 255, 255, 255), x*1.20, "default-bold", "center", "center", false, false, false,  true, false)
		     end
		end
	end 
end
addEventHandler("onClientRender",root,texto2)


function texto3 ()
	if ( getDistanceBetweenPoints3D ( 1566.635, -1675.172, 16.199 + 0.5, getElementPosition ( localPlayer ) ) ) < 20 then
	local coords = { getScreenFromWorldPosition ( 1566.635, -1675.172, 16.199 + 0.5 ) }
		if coords[1] and coords[2] then
		 if (getElementData(localPlayer, "zoneInfo3")) then
				dxDrawText("Pressione [E] Para "..status3, coords[1], coords[2], coords[1], coords[2], tocolor(255, 255, 255, 255), x*1.20, "default-bold", "center", "center", false, false, false,  true, false)
		 end
	end
end 
end
addEventHandler("onClientRender",root,texto3)



function info (mode, number)
     if number == 1 then
	     status1 = mode 
	 end
     if number == 2 then
	     status2 = mode 
	 end
	 if number == 3 then
		status3 = mode 
	end
end
addEvent("gateStatus", true)
addEventHandler("gateStatus", root, info)



--[[

local cela2 = createColCuboid(1573.48291, -1694.99792, 12.58994, 4.896484375, 3.873291015625, 3.4000476837158)
function ColShapeHit2 ( )	
	count = {}
for i,v in pairs(getElementsWithinColShape(cela2,"player")) do
	table.insert(count,v)
end
for theKey,player in ipairs(count) do
	if getElementData(player, "adminjail") == 1 then
	outputChatBox ( getPlayerName(player).." Está na cela numero 2 Preso: SIM", 255,255,255, true)
	end
	if getElementData(player, "adminjail") == 0 then
	outputChatBox ( getPlayerName(player).." Está na cela numero 2 Preso: NÃO", 255,255,255, true)
	end
end
--ID: "..getElementData(player, "char:id").."
end
addCommandHandler("cela2", ColShapeHit2)




local zone = createColCuboid(1578.56604, -1694.82373, 12.58994, 4.164794921875, 4.400634765625, 3.7000440597534)
function ColShapeHit ()	
	count = {}
for i,v in pairs(getElementsWithinColShape(zone,"player")) do
	table.insert(count,v)
end
for theKey,player in ipairs(count) do
	if getElementData(player, "adminjail") == 1 then
	outputChatBox ( getPlayerName(player).." Está na cela numero 1 Preso: SIM", 255,255,255, true)
	end
	if getElementData(player, "adminjail") == 0 then
	outputChatBox ( getPlayerName(player).." Está na cela numero 1 Preso: NÃO", 255,255,255, true)
	end
end
--ID: "..getElementData(player, "char:id").."
end
addCommandHandler("cela1", ColShapeHit)


]]--
local zone = createColCuboid(1582.58411, -1707.51721, 11.09775, 4.9117431640625, 4.2969970703125, 5.2999996185303)

local sx,sy = guiGetScreenSize()

local jobPed = {}
local roboto = dxCreateFont("Roboto.ttf",14)



local job_PedPos = {
	{283, 1566.3446044922, -1667.3103027344, 17.589937210083, "Prisão",267.76580810547},
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

		jobPed[index]:setData("ped:job2", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:job2") then
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
	if element and element:getData("ped:job2") and not show then 
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
				     triggerServerEvent("prendendo", localPlayer, localPlayer, presoPlayer, getTimer, getReason)
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



local caixas = {
     {3011.1516113281,-2041.1715087891,11.176562309265},
     {3073.1904296875,-1965.1372070313,11.06875038147},
     {3073.1904296875,-1965.1372070313,11.06875038147},
}

local tempCol = createColSphere (2996.2282714844,-1965.4440917969,11.06875038147, 2 )
local peguei = false
function onClientColShapeHit( theElement, matchingDimension )
    if ( theElement == localPlayer ) then  -- Checks whether the entering element is the local player

if getElementData(theElement, "adminjail") == 1 and not peguei then
peguei = true
triggerServerEvent("caixanamao", theElement, theElement)
pos = math.random(#caixas)
marcacao = createColSphere (caixas[pos][1], caixas[pos][2], caixas[pos][3], 2 )
exports.Script_futeis:setGPS("Coordenada",caixas[pos][1], caixas[pos][2], caixas[pos][3])
addEventHandler("onClientColShapeHit", marcacao, entregarcaixa)

end


    end
end
addEventHandler("onClientColShapeHit", tempCol, onClientColShapeHit)


function entregarcaixa( theElement, matchingDimension)
  if ( theElement == localPlayer ) then
if getElementData(theElement, "adminjail") == 1 and peguei then	
peguei = false
if isElement(marcacao) then
destroyElement(marcacao)
end
triggerServerEvent("entregarCaixa", theElement, theElement)
end
end
end



function destroyCaixa ()
peguei = false
if isElement(marcacao) then
destroyElement(marcacao)
end
end
addEvent("destruirCaixaMarca", true)
addEventHandler("destruirCaixaMarca", root, destroyCaixa)




