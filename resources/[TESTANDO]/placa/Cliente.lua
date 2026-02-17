function getMinhasMultas(tab)
		if tab == nil then
		myVehicles = {}
			else
		myVehicles = {}
		for key = 1,#tab do
			table.insert(myVehicles, {
				tab[key]['id'], 
				tab[key]['Drvv'], 
				tab[key]['dono'],
				tab[key]["motivo"],
				tab[key]["placa"],
				tab[key]["valor"],
			tab[key]["nome"]
		} )
		end
	end
end
addEvent("setListDataMulta",true)
addEventHandler("setListDataMulta",root,getMinhasMultas)

local antispam = false
local valor = 0
function checkvalores(player)
		if antispam then return end
		if myVehicles then
		valor = 0
		local v = nil
		for index = 1, #myVehicles do
		v = myVehicles[index]
		valor = valor + v[6]
		end
		antispam = true
		
		setTimer(function()
		antispam = false
		end,3000,1)
		
		print(valor)
		
		if (tonumber(valor) or 0) <= 2000 then
		return true
		else
		outputChatBox("#7cc576[DRVV TRANSITO] #ffffffVocê tem R$:"..tonumber(valor).." em multas com a DRVV você precisa ter menos de 2 mil para poder pegar um veiculo na garagem!",0,0,0,true)
		return false
		end
	end
end	
		
		
function checkMultas()
	triggerServerEvent("consultarMultas", localPlayer, localPlayer, #myVehicles)
end
addCommandHandler("multas", checkMultas)

local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local sx,sy =  (screenW/resW), (screenH/resH)
addEventHandler("onClientKey", root, 
	function (button, press)
		if dxReason == true then
			if button == "F1" or button == "F2" or button == "F3" or button == "F4" or button == "F5" or button == "F6" or button == "F7" or button == "F9" or button == "F10" or button == "F11" or button == "F12" or button == "t" or button == "p" then
				cancelEvent()
			end
		end
	end
)

local jobPed = {}
local roboto = "default"--dxCreateFont("Roboto.ttf",14)

local job_PedPos = {
	{28, 2458.7644042969,-2092.7019042969,13.546875, "DRVV: Multas",88.625061035156},
}
local startTick = getTickCount()
local progress = ""
local elements = ""

local maxElem = 5
local nextPage = 0
local show = false

function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:jobMultas", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:jobMultas") then
			cancelEvent ()
		end
	end
)

function createPanel()
		local jX, jY, jZ = getElementPosition(getLocalPlayer())
		local bX, bY, bZ = getElementPosition(elements)
		if (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then removeEventHandler("onClientRender", root, createPanel) 
		removeEventHandler("onClientKey",root,keyControl) 
		show = false 
		return 
		end
		dxDrawRectangle(sx*300,sx*90,sx*700,sx*596,tocolor(0,0,0,240))
		dxDrawRectangle(sx*300,sx*150,sx*700,sx*535,tocolor(255,255,255,200))
		dxDrawText("BGO#FC7100MTA #FFFFFF- Multas",sx*315,sy*233,sx,sy,tocolor(255,255,255,255),sx*2,roboto,"left","center",false,false,false,true)
		if isInSlot(sx*900,sx*105,sx*70,sx*30) then
		dxDrawRectangle(sx*900,sx*105,sx*70,sx*30,tocolor(205,92,92,255))
		else
		dxDrawRectangle(sx*900,sx*105,sx*70,sx*30,tocolor(205,92,82,100))
		end
		dxDrawText("Fechar",sx*917,sy*236,sx,sy,tocolor(255,255,255,255),sx*1,roboto,"left","center",false,false,false,true)
		local elem = 0
		if myVehicles then
		local v = nil
		for index = 1, #myVehicles do
		v = myVehicles[index]
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			local text = ""
			local r, g, b = 252, 113, 0
			text = "Pagar"
			dxDrawRectangle(sx*305,sy*55+elem*(sx*104),sx*689,sx*100,tocolor(0,0,0,240))
			dxDrawText("Placa: "..v[5].."\nDRVV: "..v[2].."\nMotivo: "..v[4].."\nValor: "..v[6].."", sx*315,sy*60+elem*(sx*105),sx,sy, tocolor(255, 255, 255, 255), sx*1.3, roboto, "left", "top", false, false, false, true)
			if isInSlot(sx*885,sy*80+elem*(sx*105),sx*100,sy*40) then
				dxDrawRectangle(sx*885,sy*80+elem*(sx*105),sx*100,sy*40, tocolor(r, g, b, 255))
			else
				dxDrawRectangle(sx*885,sy*80+elem*(sx*105),sx*100,sy*40, tocolor(r, g, b, 150, 130, 0))
			end
			dxDrawText(text,sx*1870,sy*90+elem*(sx*105),sx,sy, tocolor(255, 255, 255, 255), sx*1.2, roboto, "center", "top", false, false, false, true)
			end
		end
	end
end

local altura = 0
addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:jobMultas") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
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
	elseif state == "down" and button == "left" and show then 
	if isInSlot(sx*900,sx*105,sx*70,sx*30) then
	removeEventHandler("onClientRender", root, createPanel)
	removeEventHandler("onClientKey",root,keyControl)
	show = false
	elements = nil
	end
		elem = 0
		if myVehicles then
		local v = nil
		for index = 1, #myVehicles do
		value = myVehicles[index] 
			if (index > nextPage and elem < maxElem) then
					elem = elem + 1
					if isInSlot(sx*885,sy*80+elem*(sx*105),sx*100,sy*40) then
					nextPage = 0
					triggerServerEvent("PagarMultas", localPlayer, localPlayer, value[1], value[6])
					end
				end
			end
		end
	end
end)




function keyControl(k, s)
	if k == "mouse_wheel_up" then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif k == "mouse_wheel_down" then
	if myVehicles then
		local v = nil
		for index = 1, #myVehicles do
		value = myVehicles[i]
		nextPage = nextPage + 1
		if(nextPage > index-maxElem)then
			nextPage = index-maxElem
		end
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
