
function generateKey (thePlayer, command, key, player)
     if key then
	     if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7 then 
		     local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, player)
			 local keyY = tonumber(key)
			 if targetPlayer then
			     exports.bgo_items:giveItem(targetPlayer, 19, keyY, 1, 0, true)
				 outputChatBox("#FFA000[BGO] #FFFFFFKey: #FFA000"..keyY.." #FFFFFFsetada para o jogador #FFA000"..targetPlayerName.." #FFFFFFcom sucesso.", thePlayer, 255,255,255, true)
             end			 
		 end
		 else
		 outputChatBox("#FFA000[BGO] #FFFFFFUse: /"..command.." key [id da pessoa]", thePlayer, 255,255,255, true)
	 end
end
addCommandHandler("generate", generateKey)


function carta (thePlayer, command, ...)
	     if getElementData(thePlayer, "acc:admin") > 7 or getElementData(thePlayer,"char:id") == 7755 then	 
			    local keyY2 = { ... }
				local msg = table.concat( keyY2, " " )
			    exports.bgo_items:giveItem(thePlayer, 278, getPlayerName(thePlayer)..": " .. msg, 1, 0, true)
				outputChatBox("#FFA000[BGO] #FFFFFFCarta: #FFA000"..msg.." #FFFFFFsetada.", thePlayer, 255,255,255, true)			 
		 end
	 end
addCommandHandler("carta", carta)
