local screenW, screenH = guiGetScreenSize()
local x,y = (screenW/1360), (screenH/768)
local porteMen = false

        boxID = guiCreateEdit(x*542, y*358, 62, 29, "", false)
        boxDate = guiCreateEdit(x*702, y*358, 163, 29, "", false)
        boxTyp = guiCreateEdit(x*553, y*392, 62, 29, "", false)
        boxObs = guiCreateEdit(x*702, y*392, 163, 29, "", false)    
		guiSetVisible(boxID, false) 			
		guiSetVisible(boxDate, false) 			
		guiSetVisible(boxTyp, false) 			
		guiSetVisible(boxObs, false) 			

addEventHandler("onClientRender", root,
    function()
	-- if getElementData(localPlayer, "char:adminduty") == 1 then
	 if not porteMen then return end   
        dxDrawRectangle(503, 321, 367, 134, tocolor(0, 0, 0, 194), false)
        dxDrawRectangle(503, 321, 367, 27, tocolor(0, 0, 0, 194), false)
        dxDrawText("PORTE DE ARMAS - BGO", 523, 321, 870, 348, tocolor(254, 254, 254, 57), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawRectangle(503, 358, 367, 29, tocolor(0, 0, 0, 172), false)
        dxDrawRectangle(503, 392, 367, 29, tocolor(0, 0, 0, 172), false)
        dxDrawText("ID:", 518, 358, 549, 387, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("DIA: dd/mm/aa", 614, 358, 645, 387, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("TIPO:", 518, 392, 549, 421, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Observação:", 624, 392, 655, 421, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("BRASIL GAMING ONLINE", 503, 431, 870, 454, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
	--	end
    end
)

addEventHandler("onClientKey", root, 
	function (button, press)
		if porteMen == true then
			if button == "F1" or button == "F2" or button == "u" or button == "y" or button == "t" or button == "F3" or button == "F4" or button == "F5" or button == "F6" or button == "F7" or button == "F9" or button == "F10" or button == "F11" or button == "F12" or button == "t" or button == "i" or button == "b" then
				cancelEvent()
			end
		end
	end
)

bindKey("enter", "down",
function(button, state, x, y, elementx, elementy, elementz, element) 
     if exports.bgo_dashboard:isPlayerInFaction(localPlayer, 9) or getElementData(localPlayer,"char:id") == 1 then
	 if porteMen then
         getID = guiGetText (boxID)
         if (getID == "") then
	         outputChatBox("#FFA000*BGO ERROR #FFFFFFAdicione um ID.", 255,255,255, true)
	         return
	     end
         getDate = guiGetText (boxDate)
         if (getDate == "") then
	         outputChatBox("#FFA000*BGO ERROR #FFFFFFAdicione uma Data.", 255,255,255, true)
	         return
	     end
         getTyp = guiGetText (boxTyp)
         if (getTyp == "") then
	         outputChatBox("#FFA000*BGO ERROR #FFFFFFAdicione um Tipo de carta.", 255,255,255, true)
	         return
	     end
         getObs = guiGetText (boxObs)
         if (getObs == "") then
	         outputChatBox("#FFA000*BGO ERROR #FFFFFFAdicione uma Observação.", 255,255,255, true)
	         return
	     end
		 outputChatBox("#FFA000*BGO #FFFFFFPorte de arma efetuado com sucesso.", 255,255,255, true)
		 triggerServerEvent("setCard", localPlayer, localPlayer, getID, getDate, getTyp, getObs)	
         end		 
     end		 
end)

addCommandHandler("prt", 
function(button, state, x, y, elementx, elementy, elementz, element)
     --if (getElementData(localPlayer, "char:dutyfaction") == 9 or getElementData(localPlayer,"char:id") == 1 ) then
	 if exports.bgo_dashboard:isPlayerInFaction(localPlayer, 9) or getElementData(localPlayer,"char:id") == 1 then
         if porteMen then  
             porteMen = false	
     		 guiSetVisible(boxID, false) 			
    		 guiSetVisible(boxDate, false) 			
     		 guiSetVisible(boxTyp, false) 			
    		 guiSetVisible(boxObs, false) 
         else		
     		 guiSetVisible(boxID, true) 			
     	 	 guiSetVisible(boxDate, true) 			
    		 guiSetVisible(boxTyp, true) 			
     		 guiSetVisible(boxObs, true) 
             porteMen = true	
         end			 
	 end
end)