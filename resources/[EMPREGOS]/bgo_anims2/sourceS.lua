function stopAnimBindKey()
	bindKey(source, "space", "down", animationStopCommand)
	bindKey(source, "w", "down", animationStopCommand)
	bindKey(source, "a", "down", animationStopCommand)
	bindKey(source, "s", "down", animationStopCommand)
	bindKey(source, "d", "down", animationStopCommand)
	bindKey(source, "lshift", "down", animationStopCommand)
end
addEvent("stopAnimBindKey", false)
addEventHandler("stopAnimBindKey", getRootElement(), stopAnimBindKey)

function animLoop()
	setElementData(source, "animLoopA", 1)
end
addEvent("animLoopA", true)
addEventHandler("animLoopA", getRootElement(), animLoop)

function nonAnimLoop()
	setElementData(source, "animLoopA", 0)
end
addEvent("nonAnimLoop", true)
addEventHandler("nonAnimLoop", getRootElement(), nonAnimLoop)

function unbindStopAnimation()
	unbindKey(source, "space", "down", animationStopCommand)
	unbindKey(source, "w", "down", animationStopCommand)
	unbindKey(source, "a", "down", animationStopCommand)
	unbindKey(source, "s", "down", animationStopCommand)
	unbindKey(source, "d", "down", animationStopCommand)
	unbindKey(source, "lshift", "down", animationStopCommand)
end
addEvent("unbindStopAnimation", false)
addEventHandler("unbindStopAnimation", getRootElement(), unbindStopAnimation)


local jogador = {}




			
			function drawNote(id, text, player, r, g, b, time)
				exports.bgo_hud:drawNote(id, text, player, r, g, b, time)
			end
			
			
function animationStopCommand(player)
	if not getControlState(player, "sprint") then
	
		--if ( exports.bgo_admin:AntiComandTempo(player) ) then
		--exports.bgo_admin:AntiComandoTime(player, 500)
			
		local animLoop = getElementData(player, "animLoopA")
		setElementData(player, "handsup", false)
		if not (animLoop==1) then
			stopAnimation(player)
			triggerEvent("unbindStopAnimation", player)
			setElementData(player, "teste", nil)
			if isTimer(jogador[player]) then
				killTimer(jogador[player])
			end
		end
		--else
		--drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		--end
	end
end
addCommandHandler("stopanim", animationStopCommand, false, false)

function animationsList(player)
	outputChatBox("[#7cc576Brasil Top City - Anim]: #ffffffAnimações", player, 124, 197, 118, true)
	outputChatBox("/piss /wank /slapass /fixcar /handsup /hailtaxi /scratch /fu /carchat /tired", player, 255, 255, 255)
	outputChatBox("/strip 1-2 /lightup /drink /beg /mourn /cheer 1-3 /dance 1-4 /crack 1-2", player, 255, 255, 255)
	outputChatBox("/gsign 1-5 /puke /rap 1-3 /sit 1-3 /smoke 1-3 /smokelean /laugh /startrace", player, 255, 255, 255)
	outputChatBox("/daps 1-2 /shove /bitchslap /shocked /dive /what /fall /fallfront /cpr", player, 255, 255, 255)
	outputChatBox("/copcome /copleft /copstop /wait /think /shake /idle /lay /cry /aim /drag", player, 255, 255, 255)
	outputChatBox("/walk 1-37 /bat 1-3 /copaway /win 1-2", player, 255, 255, 255)
end
addCommandHandler("animlist", animationsList, false, false)
addCommandHandler("anims", animationsList, false, false)

function resetAnimation(player)
	stopAnimation(player)
end





function teste()
if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
bgoadmin = true --exports.bgo_admin:AntiComandTempo(player) --or (getElementData(localPlayer,"acc:id") == 1)
else	
bgoadmin = false
end
end
setTimer(teste, 200, 0)

	

function coverAnimation(player)
		
	local logged = true if not bgoadmin then return end 
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "ped", "duck_cower", -1, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("cover", coverAnimation, false, false)

function vem(player)
	local logged = true if not bgoadmin then return end
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing") and not getElementData(player, "player->repairing")) then
		setPedAnimation(player, "FINALE", "FIN_Let_Go", -1, false, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("vem", vem, false, false)

function bug(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing") and not getElementData(player, "player->repairing")) then
		--setPedAnimation(player, "FINALE", "FIN_Let_Go", -1, false, false, false, false)

		setPedAnimation(player , "parachute", "para_steerl_o", 1, false, false, false)

		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
--addCommandHandler("bugadododo", bug)







function cprAnimation(player)
	local logged = true if not bgoadmin then return end
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "medic", "cpr", 8000, false, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("cpr", cprAnimation, false, false)

function copawayAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "police", "coptraf_away", 1300, true, false, false)
		setElementData(player, "handsup", false)
	end
				else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("copaway", copawayAnimation, false, false)

function copcomeAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "POLICE", "CopTraf_Come", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("copcome", copcomeAnimation, false, false)

function copleftAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "POLICE", "CopTraf_Left", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("copleft", copleftAnimation, false, false)

function copanimationStopCommand(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "POLICE", "CopTraf_Stop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("copstop", copanimationStopCommand, false, false)

function pedWait(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "COP_AMBIENT", "Coplook_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "wait", pedWait, false, false )

function bye(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player , "kissing", "gfwave2", -1, true, false, false)

		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("bye", bye)

function pedThink(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "COP_AMBIENT", "Coplook_think", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "think", pedThink, false, false )

function pedShake(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "COP_AMBIENT", "Coplook_shake", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "shake", pedShake, false, false )

function pedLean(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "GANGS", "leanIDLE", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "aguardar", pedLean, false, false )

function idleAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "DEALER", "DEALER_IDLE_01", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("idle", idleAnimation, false, false)

function pedPiss(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "PAULNMAC", "Piss_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "piss", pedPiss, false, false )

function pedWank(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
			if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "PAULNMAC", "wank_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "wank", pedWank, false, false )

function pedSlapAss(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "SWEET", "sweet_ass_slap", 2000, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
--addCommandHandler ( "slapass", pedSlapAss, false, false )

function pedCarFix(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "CAR", "Fixn_Car_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "fixcar", pedCarFix, false, false )




function beijar(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "KISSING", "Playa_Kiss_03", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "beijar", beijar, false, false )



function pedHandsup(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "ped", "handsup", -1, false, false, false)
		setElementData(player, "handsup", true)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "handsup", pedHandsup, false, false )

function pedTaxiHail(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "MISC", "Hiker_Pose", -1, false, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ("hailtaxi", pedTaxiHail, false, false )

function pedScratch(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "MISC", "Scratchballs_01", -1, true, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "scratch", pedScratch, false, false )

function pedFU(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "RIOT", "RIOT_FUKU", 800, false, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "fu", pedFU, false, false )

function pedStrip( player, _, arg )
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "STRIP", "STR_Loop_C", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "STRIP", "strip_D", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "strip", pedStrip, false, false )

function pedLightup (player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "SMOKING", "M_smk_in", 4000, true, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "lightup", pedLightup, false, false )

function pedHeil (player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "ON_LOOKERS", "Pointup_in", 999999, false, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "apontar", pedHeil, false, false )

function pedDrink( player )
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "BAR", "dnk_stndM_loop", 2300, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "drink", pedDrink, false, false )

function pedLay( player, _, arg )
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "BEACH", "sitnwait_Loop_W", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "BEACH", "Lay_Bac_Loop", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "lay", pedLay, false, false )

function begAnimation( player )
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "SHOP", "SHP_Rob_React", 4000, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "beg", begAnimation, false, false )

function pedMourn( player )
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "GRAVEYARD", "mrnM_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "mourn", pedMourn, false, false )

function pedCry( player )
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "GRAVEYARD", "mrnF_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "cry", pedCry, false, false )

function pedCheer(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "OTB", "wtchrace_win", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer( player, "RIOT", "RIOT_shout", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "STRIP", "PUN_HOLLER", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "cheer", pedCheer, false, false )

local teste = {}
local animacao = true

function danceAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if isTimer(jogador[player]) then killTimer(jogador[player]) end
		if arg == 2 then
			setAnimationForPlayer( player, "DANCING", "DAN_Down_A", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer( player, "DANCING", "dnce_M_d", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 4 then
			setAnimationForPlayer(player, "GFUNK", "Dance_G3", -1, false, false, false)
			--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
			setElementData(player, "handsup", false)
			setElementData(player, "teste", true)
			jogador[player] = setTimer(function(player)
				if getElementData(player, "teste") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G2", -1, false, false, false)
				animacao = false
				setElementData(player, "teste", false)
				else
					setAnimationForPlayer(player, "GFUNK", "Dance_G3", -1, false, false, false)
				animacao = true
				setElementData(player, "teste", true)
				end
			end, 1100, 0, player)
		elseif arg == 5 then
			setAnimationForPlayer(player, "GFUNK", "Dance_B2", -1, false, false, false)
			--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
			setElementData(player, "handsup", false)
			setElementData(player, "teste", true)
			jogador[player] = setTimer(function(player)
				if getElementData(player, "teste") then
					setAnimationForPlayer(player, "GFUNK", "Dance_B3", -1, false, false, false)
				animacao = false
				setElementData(player, "teste", false)
				else
					setAnimationForPlayer(player, "GFUNK", "Dance_B2", -1, false, false, false)
				animacao = true
				setElementData(player, "teste", true)
				end
			end, 1100, 0, player)		

		elseif arg == 6 then
			setAnimationForPlayer(player, "GFUNK", "Dance_G15", -1, false, false, false)
			--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
			setElementData(player, "handsup", false)
			setElementData(player, "teste", true)
			jogador[player] = setTimer(function(player)
				if getElementData(player, "teste") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G14", -1, false, false, false)
				animacao = false
				setElementData(player, "teste", false)
				else
					setAnimationForPlayer(player, "GFUNK", "Dance_G15", -1, false, false, false)
				animacao = true
				setElementData(player, "teste", true)
				end
			end, 1100, 0, player)

		elseif arg == 7 then
			setAnimationForPlayer(player, "GFUNK", "Dance_G6", -1, false, false, false)
			--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
			setElementData(player, "handsup", false)
			setElementData(player, "teste", true)
			jogador[player] = setTimer(function(player)
				if getElementData(player, "teste") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G5", -1, false, false, false)
	
				setElementData(player, "teste", false)
				setElementData(player, "teste2", true)

				elseif getElementData(player, "teste2") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G6", -1, false, false, false)
					setElementData(player, "teste2", false)
					setElementData(player, "teste3", true)

				elseif getElementData(player, "teste3") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G7", -1, false, false, false)
					setElementData(player, "teste3", false)
					setElementData(player, "teste4", true)
				elseif getElementData(player, "teste4") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G8", -1, false, false, false)
					setElementData(player, "teste4", false)
					setElementData(player, "teste", true)
				end
			end, 1100, 0, player)


		elseif arg == 8 then
			setAnimationForPlayer(player, "GFUNK", "Dance_G1", -1, false, false, false)
			--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
			setElementData(player, "handsup", false)
			setElementData(player, "teste", true)
			jogador[player] = setTimer(function(player)
				if getElementData(player, "teste") then
				setAnimationForPlayer(player, "GFUNK", "Dance_G2", -1, false, false, false)

				setElementData(player, "teste", false)
				setElementData(player, "teste2", true)

				elseif getElementData(player, "teste2") then
				setAnimationForPlayer(player, "GFUNK", "Dance_G3", -1, false, false, false)
				setElementData(player, "teste2", false)
				setElementData(player, "teste3", true)

				elseif getElementData(player, "teste3") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G4", -1, false, false, false)
					setElementData(player, "teste3", false)
					setElementData(player, "teste4", true)
				elseif getElementData(player, "teste4") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G5", -1, false, false, false)
					setElementData(player, "teste4", false)
					setElementData(player, "teste5", true)

				elseif getElementData(player, "teste5") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G6", -1, false, false, false)
					setElementData(player, "teste5", false)
					setElementData(player, "teste6", true)
				elseif getElementData(player, "teste6") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G7", -1, false, false, false)
					setElementData(player, "teste6", false)
					setElementData(player, "teste7", true)

				elseif getElementData(player, "teste7") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G8", -1, false, false, false)
					setElementData(player, "teste7", false)
					setElementData(player, "teste8", true)

				elseif getElementData(player, "teste8") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G9", -1, false, false, false)
					setElementData(player, "teste8", false)
					setElementData(player, "teste9", true)

				elseif getElementData(player, "teste9") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G10", -1, false, false, false)
					setElementData(player, "teste9", false)
					setElementData(player, "teste10", true)

				elseif getElementData(player, "teste10") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G11", -1, false, false, false)
					setElementData(player, "teste10", false)
					setElementData(player, "teste11", true)

				elseif getElementData(player, "teste11") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G12", -1, false, false, false)
					setElementData(player, "teste11", false)
					setElementData(player, "teste12", true)

				elseif getElementData(player, "teste12") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G13", -1, false, false, false)
					setElementData(player, "teste12", false)
					setElementData(player, "teste13", true)

				elseif getElementData(player, "teste13") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G14", -1, false, false, false)
					setElementData(player, "teste13", false)
					setElementData(player, "teste14", true)

				elseif getElementData(player, "teste14") then
					setAnimationForPlayer(player, "GFUNK", "Dance_G15", -1, false, false, false)
					setElementData(player, "teste14", false)
					setElementData(player, "teste", true)
				end
			end, 1100, 0, player)



				elseif arg == 9 then
					setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B1", -1, false, false, false)
					--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
					setElementData(player, "handsup", false)
					setElementData(player, "teste", true)
					jogador[player] = setTimer(function(player)
						if getElementData(player, "teste") then
						setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B2", -1, false, false, false)
		
						setElementData(player, "teste", false)
						setElementData(player, "teste2", true)
		
						elseif getElementData(player, "teste2") then
						setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B3", -1, false, false, false)
						setElementData(player, "teste2", false)
						setElementData(player, "teste3", true)
		
						elseif getElementData(player, "teste3") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B4", -1, false, false, false)
							setElementData(player, "teste3", false)
							setElementData(player, "teste4", true)
						elseif getElementData(player, "teste4") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B5", -1, false, false, false)
							setElementData(player, "teste4", false)
							setElementData(player, "teste5", true)
		
						elseif getElementData(player, "teste5") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B6", -1, false, false, false)
							setElementData(player, "teste5", false)
							setElementData(player, "teste6", true)
						elseif getElementData(player, "teste6") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B7", -1, false, false, false)
							setElementData(player, "teste6", false)
							setElementData(player, "teste7", true)
		
						elseif getElementData(player, "teste7") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B8", -1, false, false, false)
							setElementData(player, "teste7", false)
							setElementData(player, "teste8", true)
		
						elseif getElementData(player, "teste8") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B9", -1, false, false, false)
							setElementData(player, "teste8", false)
							setElementData(player, "teste9", true)
		
						elseif getElementData(player, "teste9") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B10", -1, false, false, false)
							setElementData(player, "teste9", false)
							setElementData(player, "teste10", true)
		
						elseif getElementData(player, "teste10") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B11", -1, false, false, false)
							setElementData(player, "teste10", false)
							setElementData(player, "teste11", true)
		
						elseif getElementData(player, "teste11") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B12", -1, false, false, false)
							setElementData(player, "teste11", false)
							setElementData(player, "teste12", true)
		
						elseif getElementData(player, "teste12") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B13", -1, false, false, false)
							setElementData(player, "teste12", false)
							setElementData(player, "teste13", true)
		
						elseif getElementData(player, "teste13") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B14", -1, false, false, false)
							setElementData(player, "teste13", false)
							setElementData(player, "teste14", true)
		
						elseif getElementData(player, "teste14") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B15", -1, false, false, false)
							setElementData(player, "teste14", false)
							setElementData(player, "teste15", true)
		
						elseif getElementData(player, "teste15") then
							setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B16", -1, false, false, false)
							setElementData(player, "teste15", false)
							setElementData(player, "teste", true)
				end
			end, 400, 0, player)



		elseif arg == 10 then
			setAnimationForPlayer(player, "WOP", "Dance_G1", -1, false, false, false)
			--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
			setElementData(player, "handsup", false)
			setElementData(player, "teste", true)
			jogador[player] = setTimer(function(player)
				if getElementData(player, "teste") then
				setAnimationForPlayer(player, "WOP", "Dance_G2", -1, false, false, false)

				setElementData(player, "teste", false)
				setElementData(player, "teste2", true)

				elseif getElementData(player, "teste2") then
				setAnimationForPlayer(player, "WOP", "Dance_G3", -1, false, false, false)
				setElementData(player, "teste2", false)
				setElementData(player, "teste3", true)

				elseif getElementData(player, "teste3") then
					setAnimationForPlayer(player, "WOP", "Dance_G4", -1, false, false, false)
					setElementData(player, "teste3", false)
					setElementData(player, "teste4", true)
				elseif getElementData(player, "teste4") then
					setAnimationForPlayer(player, "WOP", "Dance_G5", -1, false, false, false)
					setElementData(player, "teste4", false)
					setElementData(player, "teste5", true)

				elseif getElementData(player, "teste5") then
					setAnimationForPlayer(player, "WOP", "Dance_G6", -1, false, false, false)
					setElementData(player, "teste5", false)
					setElementData(player, "teste6", true)
				elseif getElementData(player, "teste6") then
					setAnimationForPlayer(player, "WOP", "Dance_G7", -1, false, false, false)
					setElementData(player, "teste6", false)
					setElementData(player, "teste7", true)

				elseif getElementData(player, "teste7") then
					setAnimationForPlayer(player, "WOP", "Dance_G8", -1, false, false, false)
					setElementData(player, "teste7", false)
					setElementData(player, "teste8", true)

				elseif getElementData(player, "teste8") then
					setAnimationForPlayer(player, "WOP", "Dance_G9", -1, false, false, false)
					setElementData(player, "teste8", false)
					setElementData(player, "teste9", true)

				elseif getElementData(player, "teste9") then
					setAnimationForPlayer(player, "WOP", "Dance_G10", -1, false, false, false)
					setElementData(player, "teste9", false)
					setElementData(player, "teste10", true)

				elseif getElementData(player, "teste10") then
					setAnimationForPlayer(player, "WOP", "Dance_G11", -1, false, false, false)
					setElementData(player, "teste10", false)
					setElementData(player, "teste11", true)

				elseif getElementData(player, "teste11") then
					setAnimationForPlayer(player, "WOP", "Dance_G12", -1, false, false, false)
					setElementData(player, "teste11", false)
					setElementData(player, "teste12", true)

				elseif getElementData(player, "teste12") then
					setAnimationForPlayer(player, "WOP", "Dance_G13", -1, false, false, false)
					setElementData(player, "teste12", false)
					setElementData(player, "teste13", true)

				elseif getElementData(player, "teste13") then
					setAnimationForPlayer(player, "WOP", "Dance_G14", -1, false, false, false)
					setElementData(player, "teste13", false)
					setElementData(player, "teste14", true)

				elseif getElementData(player, "teste14") then
					setAnimationForPlayer(player, "WOP", "Dance_G15", -1, false, false, false)
					setElementData(player, "teste14", false)
					setElementData(player, "teste15", true)

				elseif getElementData(player, "teste15") then
					setAnimationForPlayer(player, "WOP", "Dance_G16", -1, false, false, false)
					setElementData(player, "teste15", false)
					setElementData(player, "teste", true)
		end
	end, 1000, 0, player)


elseif arg == 11 then

	setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B10", -1, false, false, false)
	--jogador[player] = setTimer ( dancando2, 1100, 0, teste[player])
	setElementData(player, "handsup", false)
	setElementData(player, "teste", true)
	jogador[player] = setTimer(function(player)
		if getElementData(player, "teste") then
			setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B9", -1, false, false, false)
		animacao = false
		setElementData(player, "teste", false)
		else
			setAnimationForPlayer(player, "RUNNINGMAN", "Dance_B10", -1, false, false, false)
		animacao = true
		setElementData(player, "teste", true)
		end
	end, 450, 0, player)

		else
			setAnimationForPlayer( player, "DANCING", "DAN_Right_A", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "dance", danceAnimation, false, false )

function quit()
	if isTimer(jogador[source]) then
	 killTimer(jogador[source]) 
	end
end
addEventHandler("onPlayerQuit", root, quit)


function crackAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	--if not arg then 
	--	outputChatBox("[#7cc576Brasil Top City - Anim]: #ffffffUso correto #7cc576/".. _ .." #ffffffnumero da animação", player, 124, 197, 118, true)
	--	return 
	--end
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	setPedAnimation(player)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "CRACK", "crckidle1", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer( player, "CRACK", "crckidle3", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 4 then
			setAnimationForPlayer( player, "CRACK", "crckidle4", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "CRACK", "crckidle4", -1, true, false, false)
			--setAnimationForPlayer( player, "CRACK", "crckidle2", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "crack", crackAnimation, false, false )

function gsignAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer(player, "GHANDS", "gsign2", 4000, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer(player, "GHANDS", "gsign3", 4000, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 4 then
			setAnimationForPlayer(player, "GHANDS", "gsign4", 4000, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 5 then
			setAnimationForPlayer(player, "GHANDS", "gsign5", 4000, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer(player, "GHANDS", "gsign1", 4000, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("gsign", gsignAnimation, false, false)

function pukeAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "FOOD", "EAT_Vomit_P", 8000, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("puke", pukeAnimation, false, false)

function rapAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "LOWRIDER", "RAP_B_Loop", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer( player, "LOWRIDER", "RAP_C_Loop", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "LOWRIDER", "RAP_A_Loop", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("rap", rapAnimation, false, false)

function aimAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "SHOP", "ROB_Loop_Threat", -1, false, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("aim", aimAnimation, false, false)

function sitAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
	--[[
		if isPedInVehicle( player ) then
			if arg == 2 then
				setPedAnimation( player, "CAR", "Sit_relaxed" )
				setElementData(player, "handsup", false)
			else
				setPedAnimation( player, "CAR", "Tap_hand" )
				setElementData(player, "handsup", false)
			end
			source = player
			stopAnimBindKey()
		else
		]]--
			if arg == 2 then
				setAnimationForPlayer( player, "FOOD", "FF_Sit_Look", -1, true, false, false)
				setElementData(player, "handsup", false)
			elseif arg == 3 then
				setAnimationForPlayer( player, "Attractors", "Stepsit_loop", -1, true, false, false)
				setElementData(player, "handsup", false)
			elseif arg == 4 then
				setAnimationForPlayer( player, "BEACH", "ParkSit_W_loop", 1, true, false, false)
				setElementData(player, "handsup", false)
			elseif arg == 5 then
				setAnimationForPlayer( player, "BEACH", "ParkSit_M_loop", 1, true, false, false)
				setElementData(player, "handsup", false)
			else
				setAnimationForPlayer( player, "ped", "SEAT_idle", -1, true, false, false)
				setElementData(player, "handsup", false)
			--end
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("sit", sitAnimation, false, false)

function smokeAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "SMOKING", "M_smkstnd_loop", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer( player, "LOWRIDER", "M_smkstnd_loop", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "GANGS", "smkcig_prtl", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end	
	else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("smoke", smokeAnimation, false, false)

function smokeleanAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "LOWRIDER", "M_smklean_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("smokelean", smokeleanAnimation, false, false)

function smokedragAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "SMOKING", "M_smk_drag", 4000, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("drag", smokedragAnimation, false, false)

function laughAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "RAPPING", "Laugh_01", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("laugh", laughAnimation, false, false)

function startraceAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "CAR", "flag_drop", 4200, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("startrace", startraceAnimation, false, false)

function carchatAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "CAR_CHAT", "car_talkm_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("carchat", carchatAnimation, false, false)

function tiredAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "FAT", "idle_tired", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("tired", tiredAnimation, false, false)

function handshakeAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "GANGS", "hndshkca", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "GANGS", "hndshkfa", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("daps", handshakeAnimation, false, false)

function shoveAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "GANGS", "shake_carSH", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("shove", shoveAnimation, false, false)

function bitchslapAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "MISC", "bitchslap", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("bitchslap", bitchslapAnimation, false, false)

function shockedAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer(player, "ON_LOOKERS", "panic_loop", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("shocked", shockedAnimation, false, false)

function diveAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		
		setAnimationForPlayer(player, "ped", "EV_dive", -1, false, true, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("dive", diveAnimation, false, false)

function whatAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "RIOT", "RIOT_ANGRY", -1, true, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "what", whatAnimation, false, false )

function fallfrontAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "ped", "FLOOR_hit_f", -1, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "fallfront", fallfrontAnimation, false, false )

function fallAnimation(player)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "ped", "FLOOR_hit", -1, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "fall", fallAnimation, false, false )


function batAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "CRACK", "Bbalbat_Idle_02", -1, true, false, false)
			setElementData(player, "handsup", false)
		elseif arg == 3 then
			setAnimationForPlayer( player, "Baseball", "Bat_IDLE", -1, true, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "CRACK", "Bbalbat_Idle_01", -1, true, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler("bat", batAnimation, false, false)

function winAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	arg = tonumber(arg)
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		if arg == 2 then
			setAnimationForPlayer( player, "CASINO", "manwinb", 2000, false, false, false)
			setElementData(player, "handsup", false)
		else
			setAnimationForPlayer( player, "CASINO", "manwind", 2000, false, false, false)
			setElementData(player, "handsup", false)
		end
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "win", winAnimation, false, false )

function kickballsAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "FIGHT_E", "FightKick_B", 1, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "kickballs", kickballsAnimation, false, false )

function grabbAnimation(player, _, arg)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	if (logged and not getElementData(player, "bodypart") and not getElementData(player, "player->repairing")) then
		setAnimationForPlayer( player, "BAR", "Barserve_bottle", 2000, false, false, false)
		setElementData(player, "handsup", false)
	end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "grabbottle", grabbAnimation, false, false )

function setAnimationForPlayer(player, animblokk, nev, animTime, loop, posUpdate, perm)
	if animTime==nil then animTime=-1 end
	if loop==nil then loop=true end
	if posUpdate==nil then posUpdate=true end
	if perm==nil then perm=true end
	
	local animLoop = getElementData(player, "animLoopA")
	if (animLoop==1) then return end
	if isElementInWater ( player ) then return end

	if isElement(player) and getElementType(player)=="player" and not getPedOccupiedVehicle(player) and getElementData(player, "freeze") ~= 1 then
		if getElementData(player, "injuriedanimation") or ( not perm and not getElementData(player, "animLoopA")==1 ) then
			return false
		end
	
		triggerEvent("stopAnimBindKey", player)
		--toggleAllControls(player, false, true, false)
		
		if (perm) then
			setElementData(player, "animLoopA", 1)
		else
			setElementData(player, "animLoopA", 0)
		end
		
		local setanim = setPedAnimation(player, animblokk, nev, animTime, loop, posUpdate, false)
		if animTime > 100 then
			setTimer(setPedAnimation, 50, 2, player, animblokk, nev, animTime, loop, posUpdate, false)
		end
		if animTime > 50 then
			setElementData(player, "animTimer", setTimer(stopAnimation, animTime, 1, player), false)
		end
		return setanim
	else
		return false
	end
end

function playerSpawn()
	setPedAnimation(source)
	toggleAllControls(source, true, true, false)
	setElementData(source, "animLoopA", 0)
end
addEventHandler("onPlayerSpawn", getRootElement(), playerSpawn)
addEvent( "onPlayeranimationStopCommand", true )

function stopAnimation(player)
	if isElement(player) and getElementType(player)=="player" and getElementData(player, "freeze") ~= 1 and not getElementData(player, "injuriedanimation") and not getElementData(player, "player->repairing") then
		if isTimer( getElementData( player, "animTimer" ) ) then
			killTimer( getElementData( player, "animTimer" ) )
		end
		local updateCurrentAnimation = setPedAnimation(player)
		setElementData(player, "animLoopA", 0)
		setElementData(player, "animTimer", 0)
		--toggleAllControls(player, true, true, false)
		setPedAnimation(player)
		--setElementFrozen(player, true)
		setTimer(setPedAnimation, 50, 2, player)
		--setTimer(setElementFrozen, 100, 2, player, false)
		setTimer(triggerEvent, 100, 1, "onPlayeranimationStopCommand", player)
		return updateCurrentAnimation
	else
		return false
	end
end




 

			
addEvent("checkAnim", true)
addEventHandler("checkAnim", root, function(thePlayer)
			if(getPlayerIdleTime(thePlayer) > 10000) then
					local anim = math.random(1, 5)
					if(anim == 1) then
						--setAnimationForPlayer(thePlayer, "playidles", "stretch", -1, false, false, false, false)
						setAnimationForPlayer(thePlayer, "playidles", "stretch", 5000, false, false, false)
						
					elseif(anim == 2) then
						setAnimationForPlayer(thePlayer, "playidles", "strleg", 4000, false, false, false)
					elseif(anim == 3) then
						setAnimationForPlayer(thePlayer, "playidles", "time", 4300, false, false, false)
					elseif(anim == 4) then
						setAnimationForPlayer(thePlayer, "playidles", "shldr", 3000, false, false, false)
					elseif(anim == 5) then
						setAnimationForPlayer(thePlayer, "playidles", "shift", 4000, false, false, false)
			end
	end
end
)
	
addEvent("sejogar", true)
addEventHandler("sejogar", root, function(thePlayer)
setAnimationForPlayer(thePlayer, "ped", "EV_dive", 2000, false, true, false)
end
)



function taichiAnimation(thePlayer, cmd)
	local logged = true if not bgoadmin then return end --getElementData(player, "loggedin")
	
	if (logged and not getElementData(thePlayer, "bodypart") and not getElementData(thePlayer, "player->repairing")) then
	if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)
	setElementData(thePlayer, "handsup", false)
	setAnimationForPlayer( thePlayer, "PARK", "Tai_Chi_Loop", -1, true, false, false)
	end
		else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end	
end
addCommandHandler("shape", taichiAnimation, false, false)


local timerPM = {}		
					 
			 	

local Whitelist = { 
    ["DF749DAC120194E1221E619D133288F4"]=true, --abinis
	["ACAD704885FD08CC5475FE0F159949A4"]=true, --TONHAO DA SILVA!
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --CrohsGM
	["F9C641CF778442C2653846BFE3F886E3"]=true, --RUUD
	["47AED752073A8FC35AE98D9A74435BA2"]=true, --MORAIS MTA
	["81C485138B43E2C75D27EF7500A72642"]=true, --ANGEL
	["F07D405DD62F8ACDC2E5859D56107CA3"]=true, -- zoio
	["E672055C01AB812B5484416A1F80CE42"]= true, -- baiano
	["A91BCE9109DC30B95BB970827D541F02"]=true, --VOID
	["E53674AAAC2B1D0619D4C80FA77D53F2"]=true, --PANDOX
	["68A4631CEE43B67D29F63368B0F8C1C3"]=true, --EDU_BROTHERS
	["D1C72A4976E2B72C9F00B381BC000052"]=true, --johnny
	["310625919CB0BF4D5225F76119A72C53"]=true, -- SRPAULO
	["0F13CFD7C59F365338826014A019AB42"]=true,

} 


function tapadequalidade(thePlayer, cmd)
if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 4 
	or  exports.bgo_admin:beneficiario(thePlayer) then
	
			if isTimer(timerPM[thePlayer]) then return end
			local x,y,z = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x, y, z, 1, "player" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i]
			if v then
			if v ~= thePlayer then
			timerPM[thePlayer] = setTimer(function () end, 10000, 1)
			setAnimationForPlayer(thePlayer, "SHOP", "ROB_Loop_Threat", 1000, false, true, false)
			setAnimationForPlayer(v, "PED", "hit_l", 1000, false, true, false)
			local xp, yp, zp = getElementPosition(v)
			local int = getElementInterior(v)
			local dim = getElementDimension(v)
			triggerClientEvent(root, "syncSongtapa", resourceRoot, xp, yp, zp, int, dim)
			end
			end
			break
			end
			end
end
addCommandHandler("tapao", tapadequalidade, false, false)

