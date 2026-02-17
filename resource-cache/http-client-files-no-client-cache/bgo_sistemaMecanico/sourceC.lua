local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)

local monitorScreen = {guiGetScreenSize()}
local panelSize = {200, 230}
local panelX 
local panelY  
local Player
local Marker
local Font = dxCreateFont("files/myriadproregular.ttf", 9)
local Font2 = dxCreateFont("files/myriadproregular.ttf", 12)
local active_Menu = {
{"Pegar/Guardar Maleta"}, 
{"Fechar"}
}


local show = false

addEventHandler("onClientClick", root, function(button, state, absX, absY, elementX, elementY, elementZ, element)
	if button == "right" and state == "down" and element and getElementType(element)=="vehicle" then 
		local x, y, z = getElementPosition(getLocalPlayer())
		local playerx, playery, playerz = getElementPosition(element)
		if (getDistanceBetweenPoints3D(x, y, z, playerx, playery, playerz) <= 5) then
		if getElementModel(element) == 525 then 
		if getElementData(getLocalPlayer(), "char:dutyfaction") == 3 then
		
		if getElementData(element, "owner") == getElementData(getLocalPlayer(), "acc:id") then
		local theVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
		if theVehicle then return end
		panelX = sx*970
		panelY = sy*250
		Player = element	
		show = true
		removeEventHandler("onClientRender", root, createPlayerPanel)
		addEventHandler("onClientRender", root, createPlayerPanel)
		else
		outputChatBox ("#ffffffVocê só pode pegar a maleta do seu próprio veiculo de mecânico", 255, 0, 0, true )
		end
		end
		end
	end
	elseif button == "left" and state == "down" and show then 
		for index, value in ipairs (active_Menu) do 
			if dobozbaVan(panelX+10, panelY-20+index*55, panelSize[1]-20, 50, absX, absY) then 
				if value[1] == "Pegar/Guardar Maleta" then  
					triggerServerEvent("GiveMaleta", localPlayer, localPlayer)
					elseif value[1] == "Fechar" then 
					removeEventHandler("onClientRender", root, createPlayerPanel) 
					show = false
					if isElement(Marker) then destroyElement(Marker) end
				end
			end
		end
	end
end)

function createMarkerFunction(PlayerX,PlayerY,PlayerZ)
	if isElement(Marker) then 
		destroyElement(Marker)
	end

	Marker = createMarker ( PlayerX,PlayerY,PlayerZ+1.7, "arrow", 0.4, 25, 181, 254, 170 )
end

function createPlayerPanel()
	if not show then return end
	local PlayerX,PlayerY,PlayerZ = getElementPosition(Player)
	createMarkerFunction(PlayerX,PlayerY,PlayerZ)
	local jX, jY, jZ = getElementPosition(getLocalPlayer())
	local bX, bY, bZ = getElementPosition(Player)
	if (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then removeEventHandler("onClientRender", root, createPlayerPanel) show = false if isElement(Marker) then destroyElement(Marker) end return end
	

	--dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2]-20+index*55, tocolor(0, 0, 0, 170))
	--dxDrawRectangle(panelX, panelY, panelSize[1], 25, tocolor(0, 0, 0, 230))
	dxDrawText("Painel Mecanico", panelX+panelSize[1]/2, panelY+25/2, panelX+panelSize[1]/2, panelY+25/2, tocolor(255, 255, 255, 230), 2, "default", "center", "center", false, false, false, true)
	
	for index, value in ipairs (active_Menu) do 
		if isInSlot(panelX+10, panelY-20+index*55, panelSize[1]-20, 50) then 
				dxDrawRectangle(panelX+10, panelY-20+index*55, panelSize[1]-20, 50, tocolor(166, 134, 244, 170))
				dxDrawText(value[1], panelX+192/2, panelY-20+index*55+50/2, panelX+192/2, panelY-20+index*55+50/2, tocolor(0, 0, 0, 230), 1, "default-bold", "center", "center", false, false, false, true)		
		else
			dxDrawRectangle(panelX+10, panelY-20+index*55, panelSize[1]-20, 50, tocolor(0, 0, 0, 170))
				dxDrawText(value[1], panelX+192/2, panelY-20+index*55+50/2, panelX+192/2, panelY-20+index*55+50/2, tocolor(255, 255, 255, 230), 1, "default-bold", "center", "center", false, false, false, true)
			end
			
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
