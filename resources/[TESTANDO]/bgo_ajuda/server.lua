
function teste()
if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
bgoadmin = true --exports.bgo_admin:AntiComandTempo(player) --or (getElementData(localPlayer,"acc:id") == 1)
else	
bgoadmin = false
end
end
setTimer(teste, 200, 0)	
		

function howtouse ( player, _, arg )
if not bgoadmin then return end
dance = tonumber(arg)
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)

if dance == 1 then 
setPedWalkingStyle(player,119)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 1 ativado!", "info")
elseif dance == 2 then 
setPedWalkingStyle(player,121)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 2 ativado!", "info")
elseif dance == 3 then 
setPedWalkingStyle(player,122)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 3 ativado!", "info")
elseif dance == 4 then 
setPedWalkingStyle(player,123)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 4 ativado!", "info")
elseif dance == 5 then 
setPedWalkingStyle(player,124)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 5 ativado!", "info")
elseif dance == 6 then 
setPedWalkingStyle(player,125)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 6 ativado!", "info")
elseif dance == 7 then
setPedWalkingStyle(player,126)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar bebado ativado!", "info")
else
setPedWalkingStyle(player,118) 
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar padrão ativado!", "info")
end
	else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "homem", howtouse )


function howtouseF ( player, _, arg )
if not bgoadmin then return end
dance = tonumber(arg)
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)

if dance == 1 then 
setPedWalkingStyle(player,131)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 1 ativado!", "info")
elseif dance == 2 then 
setPedWalkingStyle(player,132)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 2 ativado!", "info")
elseif dance == 3 then 
setPedWalkingStyle(player,133)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 3 ativado!", "info")
elseif dance == 4 then 
setPedWalkingStyle(player,134)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 4 ativado!", "info")
elseif dance == 5 then 
setPedWalkingStyle(player,135)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 5 ativado!", "info")
elseif dance == 6 then 
setPedWalkingStyle(player,136)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 6 ativado!", "info")
elseif dance == 7 then
setPedWalkingStyle(player,137)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar 7 ativado!", "info")
elseif dance == 8 then
setPedWalkingStyle(player,126)
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar bebado ativado!", "info")
else
setPedWalkingStyle(player,130) 
triggerClientEvent(player, "bgo>info", player,"Modo de andar!", "Modo de andar padrão ativado!", "info")
end
	else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "mulher", howtouseF )

			
			function drawNote(id, text, player, r, g, b, time)
				exports.bgo_hud:drawNote(id, text, player, r, g, b, time)
			end


