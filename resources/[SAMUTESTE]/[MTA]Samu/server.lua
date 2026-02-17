hpMin = 30
Tempo = {}
ColMedic = {}

Tempo2 = {}
Tempo3 = {}
function ChecarVida(attacker)
	for i, player in pairs (getElementsByType("player")) do
		if not getElementData(player, "PlayerCaido") then
			local conta = getAccountName(getPlayerAccount(player))
				if getElementHealth(player) > 1 then
					if getElementHealth(player) < hpMin then 
						--if not getElementData(player, "loggedin") then return end
						removePedFromVehicle(player)
						setElementData(player, "PlayerCaido", true)
						setElementFrozen(player, true)
						exports.bgo_admin:outputAdminMessage("#7cc576" .. getPlayerName(player) .. " (" .. getElementData(player, "playerid") .. ") #ffffffAcabou de ser derrubado por "..(getElementData(player, "attackerD") or "(Desconhecido)"))
						exports.logs:logMessage("[LOG - MORTES] " .. getPlayerName(player) .. " (" .. getElementData(player, "playerid") .. ") Acabou de ser derrubado por "..(getElementData(player, "attackerD") or "(Desconhecido)"), 2)
						setElementData(player, "attackerD", "(Desconhecido)")
						--setElementHealth(player, 30)
						setPedAnimation( player, "CRACK", "crckidle2", -1, false, false, false, true)

						toggleAllControls ( player, false )
						--setPlayerMuted(player, true)

						--triggerClientEvent (player, "GTIstoreRob_CancelOnArrest", player )

						--Tempo2[player] = setTimer(function()
						if isPedDead(player) then
						local x, y, z = getElementPosition(player)
						--spawnPlayer (player, x, y, z, 0, getElementModel(player))
						setTimer ( spawnPlayer, 5000, 1, player, x, y, z, 0, getElementModel(player))
						setTimer ( setElementHealth, 5100, 1, player, 30)
						end

					--	setElementHealth(player, 30)
					--	Tempo2[player] = nil
					--	end, 5000, 1,Tempo2[player])



						Tempo3[player] = setTimer(function()
							if getElementData(player, "PlayerCaido") then	
								killPed(player)
							end
						end, 240000, 1,Tempo3[player])
					end
				end
		else
			--local x, y, z = getElementPosition(player)
			--spawnPlayer (player, x, y, z, 0, getElementModel(player))

			--setPedAnimation( player, "CRACK", "crckidle2", -1, false, false, false, true)

			setPedAnimation( player, "CRACK", "crckidle2", 1, true, true, true, true)
			setPedAnimationSpeed(player, "crckidle2", 0)


		end
	end
end
--setTimer(ChecarVida, 100, 0)

function playerDamage_text ( attacker, loss )
	 if not (getElementData(source, "attackerD")) then
	     setElementData(source, "attackerD", "(Desconhecido)")
	     return
	 end
	     if attacker then
             if (getElementData(source, "attackerD") == getElementData(attacker, "char:name")) then
		     else
		     setElementData(source, "attackerD", getElementData(attacker, "char:name"))
		 end
	end
end
--addEventHandler ( "onPlayerDamage", getRootElement (), playerDamage_text )

--addEvent("OnDano", true)
--addEventHandler("OnDano", getRootElement(), ChecarVida)



function ChecarVidaA()
	for i, player in pairs (getElementsByType("player")) do
		
		if  getElementData(player, "PlayerCaido") then
			if getElementHealth(player) > 31 then
				--if not getElementData(player, "loggedin") then return end
				setElementData(player, "PlayerCaido", false)
				setPedAnimation(player, false)
				setElementFrozen(player, false )
				--setPlayerMuted(player, false)
				toggleAllControls ( player, true )

				setTimer ( setPedAnimation, 100, 1, player,  "GHANDS", "gsign2", 5000, false, false, false)
				setTimer ( setPedAnimation, 250, 1, player, nil)

			end
		end
	end
end
--setTimer(ChecarVidaA, 200, 0)



--[[
function SetarCaidoComHS(attacker)
	player = source
	if not getElementData(player, "PlayerCaido") then
		removePedFromVehicle(player)
		setElementHealth(player, 30)
		setElementData(player, "PlayerCaido", true)
		--setPedAnimation(player, "SWEET", "Sweet_injuredloop", 1000, false, false, false, true)
		setPedAnimation( player, "CRACK", "crckidle2", -1, false, false, false, true)
		exports.bgo_admin:outputAdminMessage("#7cc576" .. getPlayerName(player) .. " (" .. getElementData(player, "playerid") .. ") #ffffffAcabou de ser derrubado pelo "..getPlayerName(attacker).."")
		exports.logs:logMessage("[LOG - MORTES] " .. getPlayerName(player) .. " (" .. getElementData(player, "playerid") .. ") Acabou de ser derrubado por "..(getElementData(player, "attackerD") or "(Desconhecido)"), 2)
		setTimer(function()
			if getElementData(player, "PlayerCaido") then	
				killPlayer(player)
			end
		end, 240000, 1)
	end
end
addEvent("OnHS", true)
addEventHandler("OnHS", getRootElement(), SetarCaidoComHS)
--]]

--local zone = createColCuboid(1161.37207, -1376.58325, 13.98417, 9.4462890625, 38.906982421875, 3.9)


function ticketPlayer(thePlayer)
     if not (getElementData(thePlayer, "maca:area") == true) then outputChatBox("#FF0000[AVISO]#FFFFFF: O /curar só é utilizavel do lado da maca!.", thePlayer, 255,255,255, true) return end
			if getElementData(thePlayer, "char:dutyfaction") == 4 or getElementData(thePlayer, "acc:admin") > 7 then 
			local posX1, posY1, posZ1 = getElementPosition(thePlayer)
			for _, player in ipairs(getElementsByType("player")) do
				local posX2, posY2, posZ2 = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
				if distance <= 1 then
					if player ~= thePlayer then
						--if isPedDead(player) then outputChatBox("#bebebeEsta pessoa foi morta, não é mais possivel cura-la!",thePlayer,255,255,255,true) return end
						local health = getElementHealth(player)
						if health >= 31 then outputChatBox("#bebebeVocê só pode ajudar pessoas caidas!",thePlayer,255,255,255,true) return end
						setPedAnimation( thePlayer, "MEDIC", "CPR", 4500, true, false, false, false)
						--randomLife(thePlayer, player)
						setTimer ( function()
							setTimer ( setPedAnimation, 100, 1, player,  "GHANDS", "gsign2", 5000, false, false, false)
							setTimer ( setPedAnimation, 250, 1, player, nil)

							--setElementHealth ( player, 35 )

							setElementHealth ( player, 39 )
							setPedAnimation(player, false)
							toggleAllControls ( player, true )
							setElementFrozen( player, false )
							setElementData(player,"PlayerCaido",false)


							--takeChar (player)
						end, 4500, 1 )
				return
				end
			end
		end
	end
end
--addCommandHandler("curar", ticketPlayer, false, false)


function takeChar (thePlayer)
	--if isPedDead(thePlayer) then return end
	setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
	setTimer ( setPedAnimation, 250, 1, thePlayer, nil)
	setElementHealth ( thePlayer, 39 )
	setPedAnimation(thePlayer, false)
	toggleAllControls ( thePlayer, true )
	setElementFrozen( thePlayer, false )
	setElementData(thePlayer,"PlayerCaido",false)
end

zone = createColSphere(292.45690917969,-1553.5559082031,71.46875,4)
zone2 = createColSphere(296.91534423828,-1540.890625,71.46875,4)
zone3 = createColSphere(302.48263549805,-1528.4738769531,71.46875,4)

function reanimar(thePlayer)
	if getElementData(thePlayer, "char:dutyfaction") == 4 or getElementData(thePlayer, "acc:admin") > 7 then 
	if not isElementWithinColShape(thePlayer,zone) then
	     if not isElementWithinColShape(thePlayer,zone2) then 
    		if not isElementWithinColShape(thePlayer, zone3) then 
			     outputChatBox("#FF0000[AVISO]#FFFFFF: O /reanimar só é utilizavel dentro das salas de atendimento!.", thePlayer, 255,255,255, true)
				 return
			 end
		 end
	 end
	local posX1, posY1, posZ1 = getElementPosition(thePlayer)
	for _, player in ipairs(getElementsByType("player")) do
		local posX2, posY2, posZ2 = getElementPosition(player)
		local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
		if distance <= 2 then
			if player ~= thePlayer then
				if not getElementData(thePlayer, "char:animando") then

				local health = getElementHealth(player)
				if health >= 98 then outputChatBox("#bebebeVocê só pode ajudar pessoas tristes!",thePlayer,255,255,255,true) return end

				--if not getElementData(player, "PlayerAnimo") then outputChatBox("#bebebeVocê só pode ajudar pessoas desanimadas!",thePlayer,255,255,255,true) return end

				setElementData(thePlayer, "char:animando", true)

				triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"animo", "Faça o melhor RP possivel com o paciente, seja criativo e mostre seu potencial, você será notificado quando o paciente for reanimado. ( duração: 1 minuto )", 50 )
				triggerClientEvent(player,"JoinQuitGtaV:notifications", player,"animo", "Faça o melhor RP possivel com o medico, seja criativo e mostre seu potencial, você será notificado quando terminar. ( duração: 1 minuto )", 50 )


				setPedAnimation( thePlayer, "POLICE", "CopTraf_Stop", -1, false, false, true, false)

				setTimer ( function()
					takeChar2 (player)

					triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"animo", "Agora leve para sala de recuperação ao lado!", 15 )
					triggerClientEvent(player,"JoinQuitGtaV:notifications", player,"animo", "Você será levado para a sala de recuperação aguarde!", 15 )

					setElementData(thePlayer, "char:animando", false)
				end, 60000, 1 )

			end
		return
		end
	end
end
end
end
addCommandHandler("reanimar", reanimar, false, false)






function takeChar2 (thePlayer)
--setElementHealth ( thePlayer, 100 )
--cadeira (thePlayer)

setElementData(thePlayer, "char:recuperacao", true)


setPedAnimation(thePlayer, false)
end


function takeChar22 (thePlayer)
	if getElementData(thePlayer, "char:dutyfaction") == 4 then 
	setElementData(thePlayer, "char:animando", false)
	outputChatBox("#bebebeDEBUG CORRIGIDO!",thePlayer,255,255,255,true) 
	setElementData(thePlayer,"PlayerCaido",false)
	setElementData(thePlayer,"PlayerAnimo",false)
		end 
	end 
addCommandHandler("mdebug", takeChar22)



--local myMarker = createMarker (1163.7233886719, -1352.5010986328, 15.385937690735, "cylinder", 0.9, 255, 255, 0, 0 )

local myMarker = createMarker (297.30352783203,-1541.0037841797,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )

function checkMedicals(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end

		if getElementData(hitplayer, "char:recuperacao") == true then return end


		local health = getElementHealth(hitplayer)
		if health >= 50 then return end
		setElementPosition(hitplayer, 296.28790283203,-1540.6199951172,72.55549621582)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
	end
end
addEventHandler( "onMarkerHit", myMarker, checkMedicals )

local myMarker2 = createMarker (292.82952880859,-1553.7631835938,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )

function checkMedicals2(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end

		if getElementData(hitplayer, "char:recuperacao") == true then return end


		local health = getElementHealth(hitplayer)
		if health >= 50 then return end
		setElementPosition(hitplayer, 291.78536987305,-1553.4147949219,72.55549621582)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
	end
end
addEventHandler( "onMarkerHit", myMarker2, checkMedicals2 )



local myMarker3 = createMarker (302.93807983398,-1528.6947021484,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )

function checkMedicals3(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end

		if getElementData(hitplayer, "char:recuperacao") == true then return end


		local health = getElementHealth(hitplayer)
		if health >= 50 then return end
		setElementPosition(hitplayer, 301.87582397461,-1528.1579589844,72.55549621582)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
	end
end
addEventHandler( "onMarkerHit", myMarker3, checkMedicals3 )




local timerRecuperacao = { }

local myMarkerRecuperar = createMarker (301.990234375,-1562.0318603516,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 304.59262084961,-1555.8778076172,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
			killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
			if isElement(hitplayer) then
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
			if getElementData(hitplayer, "char:recuperacao") == true then
			setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
			setElementPosition(hitplayer, 304.59262084961,-1555.8778076172,72.237915039063)
			setPedRotation(hitplayer, 249.903)
			setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
			triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
			
			
			triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )


			end
		else
		setElementHealth(hitplayer, 100)
			setElementPosition(hitplayer, 306.50570678711,-1553.2858886719,71.46875)
			--cadeira (hitplayer)
			if isTimer(timerRecuperacao[hitplayer]) then
				killTimer(timerRecuperacao[hitplayer])
			end
			setElementData(hitplayer, "char:recuperacao", false)
			setElementData(hitplayer, "Object:Jobs", false)
			setElementFrozen(hitplayer, false)
		end

		end

		end,10000,0)

		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar, checkRecuperar )




local myMarkerRecuperar2 = createMarker (305.58975219727,-1556.0444335938,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar2(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 306.39398193359,-1549.3824462891,72.237915039063)
		setPedRotation(hitplayer, 257.49737548828)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
			killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
			if getElementData(hitplayer, "char:recuperacao") == true then
			setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
			setElementPosition(hitplayer, 305.145, -1546.916, 72.238)
			setPedRotation(hitplayer, 249.903)
			setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
			triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
			
			triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
			
			
			end
		else
			setElementHealth(hitplayer, 100)
			setElementPosition(hitplayer, 304.772, -1543.784, 71.469)
			--cadeira (hitplayer)
			if isTimer(timerRecuperacao[hitplayer]) then
				killTimer(timerRecuperacao[hitplayer])
			end
			setElementData(hitplayer, "char:recuperacao", false)
			setElementData(hitplayer, "Object:Jobs", false)
			setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar2, checkRecuperar2 )



local myMarkerRecuperar3 = createMarker (305.29800415039,-1549.3529052734,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar3(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 306.44174194336,-1549.3267822266,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
			killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
			if getElementData(hitplayer, "char:recuperacao") == true then
			setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
			setElementPosition(hitplayer, 306.44174194336,-1549.3267822266,72.237915039063)
			setPedRotation(hitplayer, 249.903)
			setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
			triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox(" ",hitplayer,255,255,255,true)
			outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
			
			triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
			
			
			
			end
		else
			setElementHealth(hitplayer, 100)
			setElementPosition(hitplayer, 307.86114501953,-1547.3231201172,71.46875)
			--cadeira (hitplayer)
			if isTimer(timerRecuperacao[hitplayer]) then
				killTimer(timerRecuperacao[hitplayer])
			end
			setElementData(hitplayer, "char:recuperacao", false)
			setElementData(hitplayer, "Object:Jobs", false)
			setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar3, checkRecuperar3 )





local myMarkerRecuperar4 = createMarker (309.43423461914,-1544.1058349609,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar4(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 308.52627563477,-1543.8041992188,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 308.52627563477,-1543.8041992188,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementHealth(hitplayer, 100)
		setElementPosition(hitplayer, 310.74655151367,-1541.2065429688,71.46875)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar4, checkRecuperar4 )




local myMarkerRecuperar5 = createMarker (312.04537963867,-1538.0557861328,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar5(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 311.03289794922,-1537.7677001953,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 311.03289794922,-1537.7677001953,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementHealth(hitplayer, 100)
		setElementPosition(hitplayer, 313.42950439453,-1535.8524169922,71.46875)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar5, checkRecuperar5 )

local myMarkerRecuperar6 = createMarker (314.50296020508,-1532.7687988281,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar6(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 313.68862915039,-1532.3725585938,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 313.68862915039,-1532.3725585938,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementHealth(hitplayer, 100)
		setElementPosition(hitplayer, 316.11248779297,-1530.3051757813,71.46875)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar6, checkRecuperar6 )





local myMarkerRecuperar7 = createMarker (317.62408447266,-1527.5108642578,71.46875-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function checkRecuperar7(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 316.7802734375,-1527.1728515625,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health + 10 < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 316.7802734375,-1527.1728515625,72.237915039063)
		setPedRotation(hitplayer, 249.903)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementHealth(hitplayer, 100)
		setElementPosition(hitplayer, 319.28573608398,-1525.2001953125,71.46875)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperar7, checkRecuperar7 )


--[[

local myMarker2 = createMarker (1163.7410888672, -1342.5964355469, 15.385937690735, "cylinder", 0.9, 255, 255, 0, 0 )
function checkMedicals2(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end

		local health = getElementHealth(hitplayer)
		if health >= 50 then return end

		setElementPosition(hitplayer, 1162.8973388672, -1342.7130126953, 16.455495834351)
		setPedRotation(hitplayer, 89.360794067383)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
	end
end
addEventHandler( "onMarkerHit", myMarker2, checkMedicals2 )


local myMarker3 = createMarker (1163.6552734375, -1363.0581054688, 15.385937690735, "cylinder", 0.9, 255, 255, 0, 0 )
function myMarker32(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end

		local health = getElementHealth(hitplayer)
		if health >= 50 then return end

		setElementPosition(hitplayer, 1162.7974853516, -1363.0163574219, 16.45549583435)
		setPedRotation(hitplayer, 89.360794067383)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
	end
end
addEventHandler( "onMarkerHit", myMarker3, myMarker32 )
]]--





local myMarker4 = createMarker (323.037, -1502.784, 71.469-0.9, "cylinder", 1.5, 255, 255, 0, 100 )
function myMarker322(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		--if getElementData(hitplayer, "char:dutyfaction") == 4 then 
		
		if getElementData(hitplayer, "char:recuperacao") == true then return end
		
		
		fadeCamera ( hitplayer, false, 1.0 )

		setTimer(function()
		fadeCamera(hitplayer, true, 0.5)
		setElementPosition(hitplayer, 321.112, -1505.599, 36.039)
		end,2000,1)
		--setPedRotation(hitplayer, 89.360794067383)
		--setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		--end
	end
end
addEventHandler( "onMarkerHit", myMarker4, myMarker322 )




local myMarker5 = createMarker (322.831, -1503.121, 36.033-0.9, "cylinder", 1.5, 255, 255, 0, 100 )
function myMarker3222(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if exports.bgo_dashboard:isPlayerInFaction(hitplayer , 4) or exports.bgo_admin:isPlayerDuty(hitplayer) or (tonumber(getElementData(hitplayer, "acc:admin") or 0) >= 1) then 
if getElementData(hitplayer, "char:recuperacao") == true then return end
		fadeCamera ( hitplayer, false, 1.0 )
		setTimer(function()
		fadeCamera(hitplayer, true, 0.5)
		setElementPosition(hitplayer, 321.114, -1505.121, 71.469)
		end,2000,1)

		 end
	end
end
addEventHandler( "onMarkerHit", myMarker5, myMarker3222 )



local myMarkerestacionamento = createMarker (326.691, -1497.585, 36.039-0.9, "cylinder", 1.5, 255, 255, 0, 100 )
function myMarkerestacionament(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
if getElementData(hitplayer, "char:recuperacao") == true then return end
		--if getElementData(hitplayer, "char:dutyfaction") == 4 then 
		fadeCamera ( hitplayer, false, 1.0 )

		setTimer(function()
		fadeCamera(hitplayer, true, 0.5)
		setElementPosition(hitplayer, 324.347, -1494.236, 24.93)
		end,2000,1)
		--setPedRotation(hitplayer, 89.360794067383)
		--setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		--end
	end
end
addEventHandler( "onMarkerHit", myMarkerestacionamento, myMarkerestacionament )


local myMarkerestacionamento2 = createMarker (326.486, -1497.672, 24.93-0.9, "cylinder", 1.5, 255, 255, 0, 100 )
function myMarkerestacionament2(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
if getElementData(hitplayer, "char:recuperacao") == true then return end
		--if getElementData(hitplayer, "char:dutyfaction") == 4 then 
		fadeCamera ( hitplayer, false, 1.0 )

		setTimer(function()
		fadeCamera(hitplayer, true, 0.5)
		setElementPosition(hitplayer, 326.044, -1493.714, 36.039)
		end,2000,1)
		--setPedRotation(hitplayer, 89.360794067383)
		--setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		-- end
	end
end
addEventHandler( "onMarkerHit", myMarkerestacionamento2, myMarkerestacionament2 )
















local myMarkerHELI = createMarker (326.643, -1497.775, 71.469-0.9, "cylinder", 1.5, 255, 255, 0, 100 )
function myMarker1heli(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		if getElementData(hitplayer, "char:dutyfaction") == 4 then 

		fadeCamera ( hitplayer, false, 1.0 )

		setTimer(function()
		fadeCamera(hitplayer, true, 0.5)
		setElementPosition(hitplayer, 321.125, -1505.628, 76.563)
		end,2000,1)
		--setPedRotation(hitplayer, 89.360794067383)
		--setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		 end
	end
end
addEventHandler( "onMarkerHit", myMarkerHELI, myMarker1heli )




local myMarkerHELI2 = createMarker (322.846, -1503.099, 76.563-0.9, "cylinder", 1.5, 255, 255, 0, 100 )
function myMarker1heli2(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then

		--if getElementData(hitplayer, "char:dutyfaction") == 4 then 
		fadeCamera ( hitplayer, false, 1.0 )

		setTimer(function()
		fadeCamera(hitplayer, true, 0.5)
		setElementPosition(hitplayer, 328.013, -1495.427, 71.469)
		end,2000,1)
		--setPedRotation(hitplayer, 89.360794067383)
		--setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		 --end
	end
end
addEventHandler( "onMarkerHit", myMarkerHELI2, myMarker1heli2 )





local myMarker = createMarker (311.72323608398, -1512.6263427734, 36.0390625-0.9, "cylinder", 1, 255, 255, 0, 170 )



--local myMarker2 = createMarker (1168.7309570313,-1351.7958984375,15.385937690735-0.9, "cylinder", 1, 255, 255, 0, 170 )
--local myMarker3 = createMarker (1169.2474365234,-1341.5632324219,15.385937690735-0.9, "cylinder", 1, 255, 255, 0, 170 )
setElementData(myMarker,"informacao","RECUPERAR VIDA")
function checkMedicals(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
			triggerClientEvent(hitplayer, "showHealthPanel", hitplayer, hitplayer, 1)		
	end
end
addEventHandler( "onMarkerHit", myMarker, checkMedicals )
--addEventHandler( "onMarkerHit", myMarker2, checkMedicals )
--addEventHandler( "onMarkerHit", myMarker3, checkMedicals )


function stopMedicals(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" then
			triggerClientEvent(hitplayer, "showHealthPanel", hitplayer, hitplayer, 2)		
	end
end
addEventHandler( "onMarkerLeave", myMarker, stopMedicals )

--addEventHandler( "onMarkerLeave", myMarker2, stopMedicals )
--addEventHandler( "onMarkerLeave", myMarker3, stopMedicals )


local spawns = {
    {301.949, -1562.047, 71.469},
	{305.533, -1556.105, 71.469},
	{305.206, -1549.529, 71.469},
	{309.378, -1544.264, 71.469},
	{311.997, -1538.087, 71.469},
	{314.499, -1532.777, 71.469},
	{317.551, -1527.389, 71.469},
}

	

function gyogyitPlayer(player)
	if isElement(player) then
		if getElementHealth(player) == 100 then
			outputChatBox("#dc143c[Erro]:#ffffffVocê Está com 100% de vida seu ingrato!.", player, 255, 255, 255, true)
			return
		end
		
		--setElementHealth(player, 100)
		
		setPedHeadless(player, false)
		setElementData(player, "char:recuperacao", true)
		fadeCamera ( player, false, 1.0 )

		setTimer(function()
		fadeCamera(player, true, 0.5)		
		local rnd = math.random( 1, #spawns )
		setElementPosition( player, spawns[rnd][1], spawns[rnd][2], spawns[rnd][3] )

	
		end,2000,1)
		
		--exports.ex_infobox:addNotification(player, "Sikeresen meggy�gy�tottad magad.", 4)
		--outputChatBox("#1E8BC3[Informação]:#ffffff Você completou com sucesso seus ferimentos. Isso custou: #00aeefR$: 1000", player, 255, 255, 255, true)
		setElementData(player, "char:money", getElementData(player, "char:money")-1000)
		--exports["ex_dashboard"]:giveGroupBalance(8, 100)
		
	end
end
addEvent("gyogyitPlayer", true)
addEventHandler("gyogyitPlayer", getRootElement(), gyogyitPlayer)


--[[

function ChecarAnimo2(attacker)
	for i, player in pairs (getElementsByType("player")) do
		if getElementData(player, "PlayerAnimo") == false then
			if getElementData(player, "PlayerCaido") then return end
				if tonumber(getElementHealth(player)) > 1 then
					if tonumber(getElementHealth(player)) < 50 then 
						setElementData(player, "PlayerAnimo", true)
						triggerClientEvent(player,"JoinQuitGtaV:notifications", player,"animo", "Você está desanimado vá para o hospital e tome um remedio!", 15 )
						toggleControl (player, "sprint", false ) 
						toggleControl (player, "jump", false )
						toggleControl (player, "crouch", false )
						setPedWalkingStyle(player,120)
					end
				end
			else
			setPedWalkingStyle(player,120)
			toggleControl (player, "sprint", false ) 
			toggleControl (player, "jump", false )
			toggleControl (player, "crouch", false )
		end
	end
end
setTimer(ChecarAnimo2, 200, 0)

function ChecarAnimo()
	for i, player in pairs (getElementsByType("player")) do
		if  getElementData(player, "PlayerAnimo") == true then
			if tonumber(getElementHealth(player)) > 51 then
				setElementData(player, "PlayerAnimo", false)
				setElementData(player, "PlayerCaido", false)
				setPedAnimation(player, false)
				setPedWalkingStyle(player,0)
				toggleControl (player, "sprint", true ) 
				toggleControl (player, "crouch", true )
				toggleControl (player, "jump", true )
				setTimer ( setPedAnimation, 100, 1, player,  "GHANDS", "gsign2", 5000, false, false, false)
				setTimer ( setPedAnimation, 250, 1, player, nil)
			end
		end
	end
end
setTimer(ChecarAnimo, 200, 0)
]]--

function getClothes(thePlayer)
	local texture = {}
	local model = {}
	for i=0, 17, 1 do
		local clothesTexture, clothesModel = getPedClothes(thePlayer, i)
		if ( clothesTexture ~= false ) then
			table.insert(texture, clothesTexture)
			table.insert(model, clothesModel)
		else
			table.insert(texture, " ")
			table.insert(model, " ")
		end	
	end
	local allTextures = table.concat(texture, ",")
	local allModels = table.concat(model, ",")
	clothesallTextures = allTextures
	clothesallModels = allModels
	texture = {}
	model = {}	
	setPedClothes(thePlayer)
end



local object = { }
local ped = { }
local timer = { }
local timer2 = { }
function cadeira (thePlayer)
		local x,y,z = getElementPosition(thePlayer)
		object[thePlayer] = createObject(1369, x,y,z)
		setElementCollisionsEnabled(object[thePlayer], false)
		attachElements (object[thePlayer], thePlayer, 0, 0, -0.46, 0, 0, -180)
		local rotx,roty,rotz = getElementRotation(thePlayer)
		ped[thePlayer] = createPed ( getElementModel(thePlayer), x,y,z )

		if (getElementModel(thePlayer) == 0) then
			getClothes(thePlayer)
		end

		attachElements (ped[thePlayer], thePlayer, 0, 0, 0, rotx,roty,rotz)
		setElementRotation(ped[thePlayer], rotx,roty,rotz )
		setElementAlpha(thePlayer, 0)
		outputChatBox(" ", thePlayer, 255,255,255, true)
		outputChatBox(" ", thePlayer, 255,255,255, true)
		outputChatBox(" ", thePlayer, 255,255,255, true)
		outputChatBox(" ", thePlayer, 255,255,255, true)
		outputChatBox(" ", thePlayer, 255,255,255, true)
		outputChatBox("#FFA000[BGO HOSPITAL] #FFFFFFVOCÊ IRÁ FICAR DE CADEIRA DE RODAS POR 2 MINUTOS", thePlayer, 255,255,255, true)
		setElementData(thePlayer, "samu:cadeira", true)
		if isTimer(timer[thePlayer]) then
		killTimer(timer[thePlayer])
		end
		timer[thePlayer] = setTimer(function()
		if isElement(object[thePlayer]) then
		local x,y,z = getElementPosition ( thePlayer )
		local rotx,roty,rotz = getElementRotation(thePlayer)
		setElementPosition(ped[thePlayer], x,y,z)
		setElementRotation(ped[thePlayer], rotx,roty,rotz)
		setPedAnimation( ped[thePlayer], "ped", "SEAT_idle", 1, true, true, true, true)
		setPedAnimationProgress( ped[thePlayer], "SEAT_idle", 0.2 )
		setPedAnimationSpeed(ped[thePlayer], "SEAT_idle", 0)	
		else
		if isElement(object[thePlayer]) then
		destroyElement(object[thePlayer])
		end
		if isElement(ped[thePlayer]) then
		destroyElement(ped[thePlayer])
		end
		if isTimer(timer[thePlayer]) then
		killTimer(timer[thePlayer])
		end
		end	
		end, 200, 0)
		timer2[thePlayer] = setTimer(function()
		if isElement(object[thePlayer]) then
		destroyElement(object[thePlayer])
		end
		if isElement(ped[thePlayer]) then
		destroyElement(ped[thePlayer])
		end
		if isTimer(timer[thePlayer]) then
		killTimer(timer[thePlayer])
		end
		setElementData(thePlayer, "samu:cadeira", false)
		setElementAlpha(thePlayer, 255)
		end, 120000, 1)
end
--addCommandHandler("cadeiraabinis123", cadeira )
--[[
for i, player in pairs (getElementsByType("player")) do
	setElementAlpha(player, 255)
	setElementData(player, "samu:cadeira", false)
end]]--

function setPedClothes(thePlayer)
	local textureString = clothesallTextures
	local modelString = clothesallModels
	local textures2 = split(textureString, 44)
	local models2 = split(modelString, 44)
	for i=0, 17, 1 do
		if ( textures2[i+1] ~= " " ) then
			if isElement(ped[thePlayer]) then
			addPedClothes(ped[thePlayer], textures2[i+1], models2[i+1], i)
			end
		end
	end
	textures2 = {}
	models2 = {}
end



function enterMec (player, seat, jacked)
		if (getElementData(player, "samu:cadeira") == true) then
			 cancelEvent()
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê está de cadeira de rodas não pode entrar no veiculo, aguarde 2 minutos", player, 255,255,255, true)
			 else
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterMec)


addEventHandler("onPlayerQuit", root,
function ()
		if isTimer(timerRecuperacao[source]) then
			killTimer(timerRecuperacao[source])
		end
		if isElement(object[source]) then
		destroyElement(object[source])
		end
		if isElement(ped[source]) then
		destroyElement(ped[source])
		end
		if isTimer(timer[source]) then
		killTimer(timer[source])
		end
end
)


			
addEvent("anti-bugAnimacao", true)
addEventHandler("anti-bugAnimacao", root, function(thePlayer)
setPedAnimation(thePlayer, "CRACK", "crckidle2", -1, true, false, false)
end)
			
			
addEvent("anti-bugAnimacaoOFF", true)
addEventHandler("anti-bugAnimacaoOFF", root, function(thePlayer)
		setElementData(thePlayer, "handsup", false)
		setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, thePlayer)
end)

			
addEvent("andar-desanimado", true)
addEventHandler("andar-desanimado", root, function(thePlayer, id)
	if id == 1 then
	local modo = getPedWalkingStyle(thePlayer)
	setElementData(thePlayer,"modo:desanimado",modo )
	setPedWalkingStyle(thePlayer,120)
	elseif id == 2 then 
	local modo = getElementData(thePlayer,"modo:desanimado") or 128
	setPedWalkingStyle(thePlayer,modo)
	end
end )




















local myMarkerRecuperarLV = createMarker (1584.482, 1793.181, 10.873-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function myRecuperarLV(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 1584.585, 1791.788, 11.538)
		setPedRotation(hitplayer, 358.64047241211)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 1584.585, 1791.788, 11.538)
		setPedRotation(hitplayer, 358.64047241211)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementPosition(hitplayer, 1588.027, 1791.779, 10.873)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperarLV, myRecuperarLV )





local myMarkerRecuperarLV2 = createMarker (1584.412, 1784.384, 10.873-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function myRecuperarLV2(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 1584.528, 1783.174, 11.538)
		setPedRotation(hitplayer, 358.64047241211)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 1584.528, 1783.174, 11.538)
		setPedRotation(hitplayer, 358.64047241211)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementPosition(hitplayer, 1587.133, 1783.169, 10.873)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperarLV2, myRecuperarLV2 )






local myMarkerRecuperarLV3 = createMarker (1585.689, 1777.434, 10.873-0.8, "cylinder", 0.9, 255, 255, 0, 10 )
function myRecuperarLV3(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
		if getElementData(hitplayer, "char:dutyfaction") == 4 then return end
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementFrozen(hitplayer, true)
		setElementPosition(hitplayer, 1585.687, 1776.191, 11.538)
		setPedRotation(hitplayer, 358.64047241211)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		setElementData(hitplayer, "Object:Jobs", true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebeVocê está em recuperação aguarde!!",hitplayer,255,255,255,true)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		timerRecuperacao[hitplayer] = setTimer(function()
		local health = getElementHealth(hitplayer)
		if health < 100 then 
		if getElementData(hitplayer, "char:recuperacao") == true then
		setElementHealth(hitplayer, getElementHealth(hitplayer) + 10)
		setElementPosition(hitplayer, 1585.687, 1776.191, 11.538)
		setPedRotation(hitplayer, 358.64047241211)
		setPedAnimation( hitplayer, "CRACK", "crckidle2", -1, true, false, false)
		triggerClientEvent(hitplayer, "progressService", hitplayer, 10)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox(" ",hitplayer,255,255,255,true)
		outputChatBox("#bebebe+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!",hitplayer,255,255,255,true)
		triggerClientEvent(hitplayer,"JoinQuitGtaV:notifications", hitplayer,"animo", "+10 de "..math.floor(getElementHealth(hitplayer)) .." de vida, Com 100% você vai sair da recuperação!", 10 )
		end
		else
		setElementPosition(hitplayer, 1588.03, 1776.125, 10.873)
		--cadeira (hitplayer)
		if isTimer(timerRecuperacao[hitplayer]) then
		killTimer(timerRecuperacao[hitplayer])
		end
		setElementData(hitplayer, "char:recuperacao", false)
		setElementData(hitplayer, "Object:Jobs", false)
		setElementFrozen(hitplayer, false)
		end
		end,10000,0)
		end
	end
end
addEventHandler( "onMarkerHit", myMarkerRecuperarLV3, myRecuperarLV3 )









local myMarkerLV = createMarker (1611.437, 1800.959, 10.873-0.9, "cylinder", 1, 255, 255, 0, 50 )


function checkMedicals(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" and not isPedInVehicle(hitplayer) then
			triggerClientEvent(hitplayer, "showHealthPanelLV", hitplayer, hitplayer, 1)		
	end
end
addEventHandler( "onMarkerHit", myMarkerLV, checkMedicals )

function stopMedicals(hitplayer, dimension)
	if isElement(hitplayer) and getElementType(hitplayer) == "player" then
			triggerClientEvent(hitplayer, "showHealthPanelLV", hitplayer, hitplayer, 2)		
	end
end
addEventHandler( "onMarkerLeave", myMarkerLV, stopMedicals )



local spawns2 = {
    {1584.488, 1793.184, 10.873},
	{1584.387, 1784.395, 10.873},
	{1585.683, 1777.512, 10.873},
}

	

function gyogyitPlayerLV(player)
	if isElement(player) then
		if getElementHealth(player) == 100 then
			outputChatBox("#dc143c[Erro]:#ffffffVocê Está com 100% de vida seu ingrato!.", player, 255, 255, 255, true)
			return
		end
		
		--setElementHealth(player, 100)
		
		setPedHeadless(player, false)
		setElementData(player, "char:recuperacao", true)
		fadeCamera ( player, false, 1.0 )

		setTimer(function()
		fadeCamera(player, true, 0.5)		
		local rnd2 = math.random( 1, #spawns2 )
		setElementPosition( player, spawns2[rnd2][1], spawns2[rnd2][2], spawns2[rnd2][3] )

	
		end,2000,1)
		
		--exports.ex_infobox:addNotification(player, "Sikeresen meggy�gy�tottad magad.", 4)
		--outputChatBox("#1E8BC3[Informação]:#ffffff Você completou com sucesso seus ferimentos. Isso custou: #00aeefR$: 1000", player, 255, 255, 255, true)
		setElementData(player, "char:money", getElementData(player, "char:money")-500)
		--exports["ex_dashboard"]:giveGroupBalance(8, 100)
		
	end
end
addEvent("gyogyitPlayerLV", true)
addEventHandler("gyogyitPlayerLV", getRootElement(), gyogyitPlayerLV)