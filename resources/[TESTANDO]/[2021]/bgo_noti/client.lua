local screenH, screenW = guiGetScreenSize()
local x, y = (screenH/1920), (screenW/1080)
local tableInfoBox = {}
local tableServido = {}
local timerBarra
local servidorInfo = false
local progress01   = false
local states       = false
local cor          = {}
local dxtext  
local sound

local components = { "ammo", "area_name", "armour", "breath", "clock", "health", "money", "radar", "vehicle_name", "weapon", "radio", "wanted" }

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	for _, component in ipairs( components ) do
		setPlayerHudComponentVisible( component, false )
	end
end)

function infoboxtecla ()
     local doRemove = { top = { }, bottom = { } }
     for i, v in pairs ( tableInfoBox ) do
	 local width = dxGetTextWidth(v.message:gsub("#%x%x%x%x%x%x", ""), x*1.20, "default-bold")
         if ( v.rTick <= getTickCount ( ) ) then
			 table.remove ( tableInfoBox, i )
		 end
		 local theVehicle = getPedOccupiedVehicle (localPlayer)
		 if tostring(v.infotyp) == "teclas" then
	         if theVehicle then
		         if servidorInfo then
				     if tostring(v.tc) == "BEsquerdo" then
    		             dxDrawImage (74*x, screenW-(420+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(416+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Clique #FFFFFFno:\n#00AAFF"..tostring(v.message), 148*x, screenW-(535+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 else
					     dxDrawImage (78*x, screenW-(416+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Pressione #00AAFF'"..tostring(v.tc).."' #FFFFFFpara:\n#00AAFF"..tostring(v.message), 148*x, screenW-(535+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 end
				 else
				     if tostring(v.tc) == "BEsquerdo" then
			    		 dxDrawImage (74*x, screenW-(240+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(236+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Clique #FFFFFFno:\n#00AAFF"..tostring(v.message), 148*x, screenW-(180+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 else
					     dxDrawImage (74*x, screenW-(240+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(236+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Pressione #00AAFF'"..tostring(v.tc).."' #FFFFFFpara:\n#00AAFF"..tostring(v.message), 148*x, screenW-(180+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 end
			     end
			     else
			     if servidorInfo then 
				     if tostring(v.tc) == "BEsquerdo" then
		 	             dxDrawImage (74*x, screenW-(220+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(216+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Clique #FFFFFFno:\n#00AAFF"..tostring(v.message), 148*x, screenW-(140+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 else
					     dxDrawImage (74*x, screenW-(220+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(216+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Pressione #00AAFF'"..tostring(v.tc).."' #FFFFFFpara:\n#00AAFF"..tostring(v.message), 148*x, screenW-(140+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 end
					 else
					 if tostring(v.tc) == "BEsquerdo" then
     					 dxDrawImage (74*x, screenW-(80+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(76+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Clique #FFFFFFno:\n#00AAFF"..tostring(v.message), 148*x, screenW-(-140+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 else
					     dxDrawImage (74*x, screenW-(80+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawImage (78*x, screenW-(76+(i*60))*y, 58*x, 50*y, "files/teclas/"..tostring(v.tc)..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                         dxDrawText("Pressione #00AAFF'"..tostring(v.tc).."' #FFFFFFpara:\n#00AAFF"..tostring(v.message), 148*x, screenW-(-140+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 end
		     	 end
		     end
		 end
		 if tostring(v.infotyp) == "info" then
		 if i >= (v.mxc or 5) then return end
	             if theVehicle then
	      	         if servidorInfo then
		                 dxDrawImage (74*x, screenW-(420+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawText(tostring(v.tc).."\n#FFFFFF"..tostring(v.message), 100*x, screenW-(535+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
			    		 else
			    		 dxDrawImage (74*x, screenW-(240+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawText(tostring(v.tc).."\n#FFFFFF"..tostring(v.message), 100*x, screenW-(180+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
		    	     end
			         else
		     	     if servidorInfo then
		     	         dxDrawImage (74*x, screenW-(220+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawText(tostring(v.tc).."\n#FFFFFF"..tostring(v.message), 100*x, screenW-(140+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
		    			 else
		    			 dxDrawImage (74*x, screenW-(80+(i*60))*y, width+120*x, 59*y, "files/walpaper.png", 0, 0, 0, tocolor(0, 0, 0, 180))
                         dxDrawText(tostring(v.tc).."\n#FFFFFF"..tostring(v.message), 100*x, screenW-(-140+(i*120))*y, 426*x, 835*y, tocolor(254, 254, 254, 244), x*1.20, "default-bold", "left", "center", false, false, false, true, false)
					 end
		     	 end
		 end
		 if #tableInfoBox == 0 then
		     removeEventHandler("onClientRender", getRootElement(), infoboxtecla)
		 end
     end
end
 
function serverNotificationTeclas (tecla, text, tim)
     if tecla and text then
	     removeEventHandler("onClientRender", getRootElement(), infoboxtecla)
		 addEventHandler("onClientRender", getRootElement(), infoboxtecla)
		 local time = tim or 10
         local data = { 
		 infotyp = "teclas",
		 message = text,
		 tc      = tecla,
		 rTick = getTickCount ( ) + (time*1000)
	     }		
         table.insert(tableInfoBox, data)	
		 if not isElement(sound) then	 
                 local sound = playSound("files/sound.wav")
                 setSoundVolume(sound, 0.1)	 
         end			 
	 end
end
addEvent("info:tecla", true)
addEventHandler("info:tecla", resourceRoot, serverNotificationTeclas)
 
function serverNotification (info, text, tim, max)
     if info and text then
	     removeEventHandler("onClientRender", getRootElement(), infoboxtecla)
		 addEventHandler("onClientRender", getRootElement(), infoboxtecla)
		 local time = tim or 10
         if info == "info" then
		     info = "#00AAFFINFO:"
		 end
		 if info == "error" then
		     info = "#FF0000ERRO:"
		 end
         local data = { 
		 mxc     = max,
		 infotyp = "info",
		 message = text,
		 tc      = info,
		 rTick = getTickCount ( ) + (time*1000)
	     }		
         table.insert(tableInfoBox, data)	
		 if not isElement(sound) then 
                 local sound = playSound("files/sound.wav")
                 setSoundVolume(sound, 0.1)	 
         end			 
	 end
end
addEvent("info:box", true)
addEventHandler("info:box", resourceRoot, serverNotification)

function infoServidor ()
     for i, v in pairs ( tableServido ) do
         if ( v.srTick <= getTickCount ( ) ) then
			 table.remove ( tableServido, i )
			 if #tableServido ~= 0 then	 
                     local sound = playSound("files/sound.wav")
                     setSoundVolume(sound, 0.1)	 
			 end
		 end
		 local theVehicle = getPedOccupiedVehicle (localPlayer)
		 if i == 1 then
	         if theVehicle then
                 dxDrawRectangle(x*75, y*661, x*351, y*180, tocolor(0, 0, 0, 170), false)
                 dxDrawRectangle(x*85, y*671, x*55, y*50, tocolor(0, 0, 0, 170), false)
                 dxDrawText(tostring(v.emp), x*150, y*676, x*358, y*695, tocolor(255, 255, 255, 255), 1.10, "default-bold", "left", "top", false, false, false, true, false)
                 dxDrawText(tostring(v.type), x*150, y*695, x*358, y*714, tocolor(254, 254, 254, 170), 1.00, "default-bold", "left", "top", false, false, false, true, false)
                 dxDrawText(tostring(v.info), x*85, y*724, x*407, y*811, tocolor(254, 254, 254, 204), 1.20, "default-bold", "left", "top", false, false, false, true, false)
		    	 else
                 dxDrawRectangle(x*75, y*861, x*351, y*180, tocolor(0, 0, 0, 170), false)
                 dxDrawRectangle(x*85, y*871, x*55, y*50, tocolor(0, 0, 0, 170), false)
                 dxDrawText(tostring(v.emp), x*150, y*876, x*358, y*695, tocolor(255, 255, 255, 255), 1.10, "default-bold", "left", "top", false, false, false, true, false)
                 dxDrawText(tostring(v.type), x*150, y*895, x*358, y*714, tocolor(254, 254, 254, 170), 1.00, "default-bold", "left", "top", false, false, false, true, false)
                 dxDrawText(tostring(v.info), x*85, y*924, x*407, y*811, tocolor(254, 254, 254, 204), 1.20, "default-bold", "left", "top", false, false, false, true, false)
		     end
		 end
		 if #tableServido == 0 then
		     removeEventHandler("onClientRender", getRootElement(), infoServidor)
			 servidorInfo = false
		 end
     end
end

addEvent("info:servido", true)
addEventHandler("info:servido", resourceRoot, 
function(empresa, typ, text)
     if empresa and typ and text then
	     removeEventHandler("onClientRender", getRootElement(), infoServidor)
		 addEventHandler("onClientRender", getRootElement(), infoServidor)
		 local time = tim or 10
         local data = { 
		 info  = text,
		 emp   = empresa,
		 type  = typ,
		 srTick = getTickCount ( ) + (time*1000)
	     }	
         if #tableServido == 0 then		 
                 local sound = playSound("files/sound.wav")
                 setSoundVolume(sound, 0.5)	 
			 servidorInfo = true
         end
         table.insert(tableServido, data)		 
	 end
end)

local floor = math.floor
function fromColor(col)
	local r,g,b,a
	b = col%256
	g = floor(col/0x100)%256
	r = floor(col/0x10000)%256
	a = floor(col/0x1000000)%256
	return r,g,b,a
end
	
screenX,screenY = guiGetScreenSize()

function renderAlert ()
     if dxtext then
	     local width = dxGetTextWidth( dxtext:gsub("#%x%x%x%x%x%x", ""), x*1.20, "default-bold" ) + 20
	 
	     cor[1] = tocolor(0, 170, 255, 103)
         if isCursorOnElement(x*923, y*628, x*93, y*25) then cor[1] = tocolor(0, 170, 255, 200) end 
	 
         dxDrawRectangle(screenH-width-700*x, y*513, x*width+100*x, y*150, tocolor(255, 249, 249, 240), false)
         dxDrawText(dxtext, x*810, y*523, x*1130, y*618, tocolor(0, 0, 0, 103), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
         dxDrawRectangle(x*923, y*628, x*93, y*25, cor[1], false)
         dxDrawText("Entendi", x*923, y*628, x*1016, y*653, tocolor(255, 255, 255, 216), x*1.20, "default-bold", "center", "center", false, false, false, false, false)
	 else
	     removeEventHandler("onClientRender", root, renderAlert)
		 states = false
	 end
end

function alertNotification (text)
     if text then
	     removeEventHandler("onClientRender", root, renderAlert)
	     addEventHandler("onClientRender", root, renderAlert)
		 dxtext = text
         states = true
	 end
end
addEvent("info:alert", true)
addEventHandler("info:alert", resourceRoot, alertNotification)

addEventHandler('onClientClick', root,
function ( button,state )
     if state and button == "left" and states then
	     if isCursorOnElement(x*923, y*628, x*93, y*25) then
		     removeEventHandler("onClientRender", root, renderAlert)
		     states = false
		 end
	 end
end)

local font = "default-bold"

local mensagem

function dxInfo ()
     dxDrawText((mensagem or "..."), x*685, y*965, x*1221, y*996, tocolor(255, 255, 255, 255), x*1.00, font, "center", "center", false, false, true, true, false)
end

function notificationLegend (message, states)
     if states then
	     removeEventHandler('onClientRender', root, dxInfo)
		 addEventHandler('onClientRender', root, dxInfo)
		 setElementData(localPlayer, 'show:hud', true)
	     setElementData(localPlayer, 'show:chat', true)
    	 setElementData(localPlayer, 'show:bar', true)
		 mensagem = message
	 else
	     removeEventHandler('onClientRender', root, dxInfo)
		 setElementData(localPlayer, 'show:hud', false)
	     setElementData(localPlayer, 'show:chat', false)
    	 setElementData(localPlayer, 'show:bar', false)
		 mensagem = nil
	 end
end
addEvent('rzk:info:fivem', true)
addEventHandler('rzk:info:fivem', resourceRoot, notificationLegend)

local x,y = guiGetScreenSize()
 function isCursorOnElement(x,y,w,h)
     if isCursorShowing () then
	     local mx,my = getCursorPosition ()
     	 local fullx,fully = guiGetScreenSize()
	     cursorx,cursory = mx*fullx,my*fully
	     if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
	    	 return true
	     else
		     return false
		 end
	end
end