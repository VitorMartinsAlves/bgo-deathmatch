local screenW,screenH = guiGetScreenSize()
local resW, resH = 1024, 768
local x, y =  (screenW/resW), (screenH/resH)
local alphaState = true
local cromus = dxCreateFont("font.ttf", 30)
alpha = 0

function chat()
	local movertexto1, movertexto2 = interpolateBetween (-320, 0, 0, 0, 0, 0, ((getTickCount() - tick3) / 2000), "Linear")		
	local movertexto6, movertexto7 = interpolateBetween (-309, 0, 0, 0, 0, 0, ((getTickCount() - tick3) / 5000), "OutBounce")	
	
	    dxDrawRectangle(x*0, y*208, x*movertexto1+240, y*36, tocolor(0, 0, 0, 180), false)
        dxDrawText(""..nome.." #C1C1C1limpou o chat.", x*movertexto6-0, y*208, x*180, y*243, tocolor(255, 255, 255, 255), 0.28, cromus, "center", "center", false, false, false, true, false)
end

function dx(limpador)
    nome = limpador;
	tick3 = getTickCount()
    addEventHandler ("onClientRender", root, chat)
    setTimer(function()
        removeEventHandler ("onClientRender", root, chat)
		tick4 = getTickCount()
    end, 9000, 1 )
end
addEvent ("limparchat", true)
addEventHandler ("limparchat", root, dx)

function dxDrawEmptyRec(absX, absY, sizeX, sizeY, color, ancho)
	dxDrawRectangle(absX, absY, sizeX, ancho, color)
	dxDrawRectangle(absX, absY + ancho, ancho, sizeY - ancho, color)
	dxDrawRectangle(absX + ancho, absY + sizeY - ancho, sizeX - ancho, ancho, color)
	dxDrawRectangle(absX + sizeX - ancho, absY + ancho, ancho, sizeY - ancho * 2, color)
end

function alphaFunction()
	if alphaState == true then	 alpha = alpha + 30
	   if alpha >= 255 then alphaState = false
	   end
	end
	if alphaState == false then alpha = alpha - 30
	    if alpha <= 5 then alphaState = true
		end
	end
end
addEventHandler("onClientRender", getRootElement(), alphaFunction)