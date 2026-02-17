function vfPhone (thePlayer, vplayer, valor)
     if (vplayer) then
		  if exports['bgo_items']:hasItemS(vplayer, 16) then
	      	 --outputChatBox("#7cc576#FFFFFFPossui celular no bolso: #7cc576Sim", thePlayer, 255, 255, 255, true)
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Revistando", "Esta pessoa possui R$" .. valor .. " em seu bolso!", "info")
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Revistando", "Esta pessoa possui celular!", "info")
			 
			 
     	 else
		 triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Revistando", "Esta pessoa não possui celular!", "info")
 	     	 --outputChatBox("#FFFFFFPossui celular no bolso: #7cc576Não", thePlayer, 255, 255, 255, true)
		 end
	 end
end
addEvent("vPhone",true)
addEventHandler("vPhone",root,vfPhone)