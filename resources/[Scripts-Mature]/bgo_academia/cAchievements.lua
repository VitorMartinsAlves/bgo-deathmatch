local screenW2,screenH2  = guiGetScreenSize()
local resW2, resH2       = 1280,720
local achx, achy         = (screenW2/resW2), (screenH2/resH2)

keyTable = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
 "l", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "num_enter", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "escape", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=" }

addEventHandler("onClientKey", root, function(button, press) 
     if (getElementData(localPlayer, "Exercicio")) then
	     for i,bindsK in ipairs(keyTable) do
             if (button == bindsK) then
                 cancelEvent() 
			 end
		 end
     end 
end)  

function clickMaquina ( button, state, _, _, _, _, _, click)
     if button == "left" and state == "down" then
	     if ( click ) then
		 
	      	 local cx, cy, cz = getElementPosition ( click )
	     	 local px, py, pz = getElementPosition ( localPlayer )
	     	 local distance	= getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz )
          	     if ( distance <= 5 ) then
				     if (getElementModel(click) == 2627) then
			            triggerServerEvent ( "Academia:Esteira", localPlayer, localPlayer, click)
					 end
					 if (getElementModel(click) == 2630) then
			            triggerServerEvent ( "Academia:Bike", localPlayer, localPlayer, click)
					 end
					 if (getElementModel(click) == 2629) then
			             triggerServerEvent ( "Academia:Peso", localPlayer, localPlayer, click)
					 end
					 if (getElementModel(click) == 2631) then
			             triggerServerEvent ( "Academia:Malhar", localPlayer, localPlayer, click)
	  	         end
	         end
         end
     end
end
addEventHandler ( "onClientClick", root, clickMaquina)

setElementData(localPlayer, "Exercicio", false)





downloading = false
local start = {}
function dxDrawLoading ()
    local now = getTickCount()
    seconds = second or 60000
	local color = color or tocolor(0,0,0,170)
	local color2 = color2 or tocolor(255,255,0,170)
	local size = size or 1.00
    local with = interpolateBetween(0,0,0,486,0,0, (now - start) / ((start + seconds) - start), "Linear")
    local text = interpolateBetween(0,0,0,100,0,0,(now - start) / ((start + seconds) - start),"Linear")
	dxDrawRectangle(achx*406, achy*569, achx*486, achy*24, tocolor(0, 0, 0, 100), false)
	dxDrawRectangle(achx*406, achy*569, achx*with, achy*24, tocolor(254, 161, 0, 255), false)
    dxDrawText ( "PROGRESSO DE EXERCICIO "..math.floor(text).."%", achx*406, achy*568, achx*892, achy*593, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
 end

function openProgressBar ()
    if (downloading == false) then
        addEventHandler("onClientRender", root, dxDrawLoading)
		downloading = true
		start = getTickCount()
        else
        removeEventHandler("onClientRender", root, dxDrawLoading)		
		downloading = false
		end
end
addEvent("openProgress", true)
addEventHandler("openProgress", root, openProgressBar)


addEventHandler("onClientPedDamage",  getRootElement(), function ()
	if (getElementData(source, "BGO:Academia")) then
		cancelEvent()
	end
end)
