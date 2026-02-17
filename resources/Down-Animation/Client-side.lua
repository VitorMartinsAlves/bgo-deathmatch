----------------------------
---- Author: @MrDante ------
---- Update: 24/05/2016 ----
----------------------------


local x, y = guiGetScreenSize ()
local relposx = x/2
local medX = x/2
local ancho = -3780
local sizeX = ancho/3
local mitSize = sizeX*0.5
local botX = medX-mitSize
local relposx = y/2
local medX2 = y/2
local ancho2 = -2160
local sizeX2 = ancho2/3
local mitSize2 = sizeX2*0.5
local botX2 = medX2-mitSize2

animations = {}
painel = {
	[1] = false
}

function painelanim ()
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
		
	--dxDrawImage ( botX+sizeX+550, botX2+sizeX2+290, 120, 120,"Arquivos/Imagens/mouse.png", cursorx+cursory, 0, 0, tocolor ( 255, 255, 255) )
	dxDrawImage ( botX+sizeX+550, botX2+sizeX2+80, 120, 120,"Arquivos/Imagens/fuck.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+550, botX2+sizeX2+80, 120, 120) and 255 or 100 ))
	dxDrawImage ( botX+sizeX+440, botX2+sizeX2+140, 120, 120,"Arquivos/Imagens/chat.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+440, botX2+sizeX2+140, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+350, botX2+sizeX2+230, 120, 120,"Arquivos/Imagens/smile.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+350, botX2+sizeX2+230, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+360, botX2+sizeX2+350, 120, 120,"Arquivos/Imagens/handsup.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+360, botX2+sizeX2+350, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+440, botX2+sizeX2+450, 120, 120,"Arquivos/Imagens/sentar.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+440, botX2+sizeX2+450, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+550, botX2+sizeX2+490, 120, 120,"Arquivos/Imagens/cancel.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+550, botX2+sizeX2+490, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+665, botX2+sizeX2+150, 120, 120,"Arquivos/Imagens/smoke.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+665, botX2+sizeX2+150, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+760, botX2+sizeX2+230, 120, 120,"Arquivos/Imagens/sexy.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+760, botX2+sizeX2+230, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+750, botX2+sizeX2+350, 120, 120,"Arquivos/Imagens/dance.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+750, botX2+sizeX2+350, 120, 120) and 255 or 100))
	dxDrawImage ( botX+sizeX+665, botX2+sizeX2+450, 120, 120,"Arquivos/Imagens/espere.png", 0, 0, 0, tocolor ( 255, 255, 255, isCursorOnElement(botX+sizeX+665, botX2+sizeX2+450, 120, 120) and 255 or 100) )
end



function animations.click (_, estado)
	if painel[1] == true then
		if estado == "down" then
			if isCursorOnElement(botX+sizeX+550, botX2+sizeX2+80, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.fuck1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+440, botX2+sizeX2+140, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.chat1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+665, botX2+sizeX2+150, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				setTimer(stopSound, 40000, 1, sound)
				triggerServerEvent("anim.smoke1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+760, botX2+sizeX2+230, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.sexy1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+750, botX2+sizeX2+350, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.dance1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+665, botX2+sizeX2+450, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.espere1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+440, botX2+sizeX2+450, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.sentar1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+360, botX2+sizeX2+350, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.handsup1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+350, botX2+sizeX2+230, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				triggerServerEvent("anim.smile1", localPlayer)
			elseif isCursorOnElement(botX+sizeX+550, botX2+sizeX2+490, 120, 120) then
				playSound("Arquivos/Sons/click.mp3")
				stopSound(sound)
				triggerServerEvent("anim.cancel1", localPlayer)
			end
		end
	end
end
addEventHandler("onClientClick", root, animations.click )





function abrir ()
	if getElementData(localPlayer, "isJailed") == true then 
        outputChatBox ('#FFFFFF[#00ff00INFO#FFFFFF] #ccccccVOCE NAO PODE USAR ESTE COMANDO QUANDO ESTA PRESO', 255, 255, 255, true)
        return
        end
   -- if ( getElementDimension ( localPlayer ) == 0 ) then
	if not painel[1] then 
		addEventHandler("onClientRender", root, painelanim)
	else
		removeEventHandler("onClientRender", root, painelanim)
		showCursor(false)
	end

	painel[1] = not painel[1]
	showCursor(painel[1])
--end
end
bindKey("f2", "both", abrir)


function isCursorOnElement(x,y,w,h)
	if (not isCursorShowing()) then
		return false
	end
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end