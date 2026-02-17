

addEvent("onClientSyncVOZ", true )
addEventHandler("onClientSyncVOZ", root,
    function(thePlayer)
	setElementData(thePlayer, "handsup", true)
	setPedAnimation(thePlayer, "GHANDS", "gsign1", 0, true, false, false)
	setTimer ( setPedAnimationProgress, 100, 1, thePlayer, "gsign1", 1.46)
	setTimer ( setPedAnimationSpeed, 100, 1, thePlayer, "gsign1", 0)	
    end
)


addEvent("onClientSyncVOZparar", true )
addEventHandler("onClientSyncVOZparar", root,
    function(thePlayer)
		--setTimer ( setPedAnimationSpeed, 50, 1, source, "gsign2LH", 1.0)
		--setTimer ( setPedAnimationProgress, 100, 1, source, "gsign2LH", 0.5)
		setElementData(thePlayer, "handsup", false)
		setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, thePlayer)
		
    end
)



addEvent("onClientDesmaiarON", true )
addEventHandler("onClientDesmaiarON", root,
    function(thePlayer)
		setPedAnimation(thePlayer, "KNIFE", "KILL_Knife_Ped_Die", -1, false, true, false)
    end
)



addEvent("onClientAssobiarON", true )
addEventHandler("onClientAssobiarON", root,
	function(thePlayer)
		

		local xp, yp, zp = getElementPosition(thePlayer)
		local int = getElementInterior(thePlayer)
		local dim = getElementDimension(thePlayer)
		local tabela = getElementsWithinRange( xp, yp, zp, 20, "player" )
		local v = nil
		for i = 1, #tabela do
		v = tabela[i] 
		triggerClientEvent(v, "syncSongassobiar", thePlayer, xp, yp, zp, int, dim)
		setPedAnimation(thePlayer, "GANGS", "smkcig_prtl", 0, true, false, false)
		setTimer ( setPedAnimationSpeed, 100, 1, thePlayer, "smkcig_prtl", 0)
		setTimer ( setPedAnimationProgress, 100, 1, thePlayer, "smkcig_prtl", 1.36)
		setTimer ( setPedAnimation, 700, 1, thePlayer, "GhANDS", "gsign2LH", 5000, false, false, false)
		setTimer ( setPedAnimation, 2500, 1, thePlayer)
		end

    end
)




addEvent("onClientPesadaON", true )
addEventHandler("onClientPesadaON", root,
	function(thePlayer)
		local xp, yp, zp = getElementPosition(thePlayer)
		setPedAnimation(thePlayer, "GANGS", "shake_cark", -1, false, false, false)
		setTimer ( setPedAnimation, 1500, 1, thePlayer)
		setTimer ( setElementFrozen, 1600, 1, thePlayer, false)
    end
)

addEvent("onClientAnimCall", true )
addEventHandler("onClientAnimCall", root,
	function(thePlayer)
		setPedAnimation(thePlayer, "GANGS", "smkcig_prtl", 0, true, false, false)
		setTimer ( setPedAnimationSpeed, 100, 1, thePlayer, "smkcig_prtl", 0)
		setTimer ( setPedAnimationProgress, 100, 1, thePlayer, "smkcig_prtl", 1.36)
    end
)



addEventHandler("onElementDataChange", root, function(dataName)
	if source and getElementType(source) == 'player' then 
		if tostring(dataName) == 'VoiceCorCall' then 
			if getElementData(source, dataName) then 
			
			setPedAnimation(source, "GANGS", "smkcig_prtl", 0, true, false, false)
			setTimer ( setPedAnimationSpeed, 100, 1, source, "smkcig_prtl", 0)
			setTimer ( setPedAnimationProgress, 100, 1, source, "smkcig_prtl", 1.36)
			
		elseif not getElementData(source, dataName) then 

			setElementData(source, "handsup", false)
			setTimer ( setPedAnimation, 100, 1, source,  "GHANDS", "gsign2", 5000, false, false, false)
			setTimer ( setPedAnimation, 250, 1, source)
			
			end
		end	
		
		if tostring(dataName) == 'apontar' then 
		if getElementData(source, dataName) then 
			
		setElementData(source, "handsup", true)
		setPedAnimation(source, "GHANDS", "gsign1", 0, true, false, false)
		setTimer ( setPedAnimationProgress, 100, 1, source, "gsign1", 1.46)
		setTimer ( setPedAnimationSpeed, 100, 1, source, "gsign1", 0)	
		
		elseif not getElementData(source, dataName) then 

		setElementData(source, "handsup", false)
		setTimer ( setPedAnimation, 100, 1, source,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, source)
			
			end
		end	
		
		
		
				if tostring(dataName) == 'assobiar' then 
				if getElementData(source, dataName) then 
				local xp, yp, zp = getElementPosition(source)
				local int = getElementInterior(source)
				local dim = getElementDimension(source)
				local tabela = getElementsWithinRange( xp, yp, zp, 100, "player" )
				local v = nil
				for i = 1, #tabela do
				v = tabela[i] 
				triggerClientEvent(v, "syncSongassobiar", source, source, xp, yp, zp, int, dim)
				setPedAnimation(source, "GANGS", "smkcig_prtl", 0, true, false, false)
				setTimer ( setPedAnimationSpeed, 100, 1, source, "smkcig_prtl", 0)
				setTimer ( setPedAnimationProgress, 100, 1, source, "smkcig_prtl", 1.36)
				
				setTimer ( setPedAnimation, 700, 1, source, "GhANDS", "gsign2LH", 0, true, false, false)
				setTimer ( stopanim, 2500, 1, source)

				end
			end
		end	
	end
end
)

function stopanim(thePlayer)	
		setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, thePlayer)
	setPedAnimation(thePlayer)
end


addEvent("removerarma", true )
addEventHandler("removerarma", root,
    function(thePlayer)
		takeWeapon( thePlayer, 22 )
		toggleControl (thePlayer, "fire", true )
		toggleControl (thePlayer, "action", true ) 
	--	triggerClientEvent(getRootElement(), "removeWeaponStickerC", getRootElement(), source)
    end
)

addEvent("dararma", true )
addEventHandler("dararma", root,
	function(thePlayer)
		giveWeapon (thePlayer,22,1, true )
		toggleControl (thePlayer, "action", false ) 
		toggleControl (thePlayer, "fire", false )
		--triggerClientEvent(getRootElement(), "setWeaponStickerC", getRootElement(), source, colt45, glock1)
		--local weapon = givePedWeapon (source,22,1, true )
		--setElementAlpha(weapon, 0) 
    end
)



local vehicles = getElementsByType("player")
for i,v in ipairs(vehicles) do
	setElementData(v, "call:selling", false)
end




function adasVeteli(thePlayer, commandName, targetPlayer)
	if not (targetPlayer) then
		outputChatBox("#7cc576[btcMTA]:#ffffff /" .. commandName .." [Nome / ID]", thePlayer, 255, 255, 255, true)
	else
		if getElementData(thePlayer, "call:selling") then outputChatBox("#dc143c[btcMTA]:#ffffffEste jogador ja tem uma localização para ser aceita.", thePlayer, 255, 255, 255, true) return end
		
		local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
		if targetPlayer then
		if thePlayer == targetPlayer then outputChatBox("#dc143c[btcMTA]:#ffffffVocê não pode fazer chamada para si mesmo", thePlayer, 255, 255, 255, true) return end

		if getElementData(targetPlayer, "call:LOC") == true then 
			outputChatBox(" ", thePlayer, 255, 255, 255, true)
			outputChatBox(" ", thePlayer, 255, 255, 255, true)
			outputChatBox(" ", thePlayer, 255, 255, 255, true)
			outputChatBox(" ", thePlayer, 255, 255, 255, true)
			outputChatBox("#1E8BC3[Localização]:#ffffffEstá pessoa ja esta com uma localização pendente!", thePlayer, 255, 255, 255, true)
		return 
		end


		sendAjanlat(thePlayer, targetPlayer)
		
		else
		outputChatBox("#1E8BC3[Localização]:#ffffffEste jogador não está na cidade", thePlayer, 255, 255, 255, true)
		end
		end
end
addCommandHandler("loca", adasVeteli, false, false)

function sendAjanlat(thePlayer, targetPlayer)
if isElement(thePlayer) and isElement(targetPlayer) then
	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	outputChatBox(" ", thePlayer, 255, 255, 255, true)
	outputChatBox("#1E8BC3[Localização]:#ffffff Você enviou a localização para " .. getPlayerName(targetPlayer):gsub("_"," ") .. "", thePlayer, 255, 255, 255, true)

	outputChatBox(" ", targetPlayer, 255, 255, 255, true)
	outputChatBox(" ", targetPlayer, 255, 255, 255, true)
	outputChatBox(" ", targetPlayer, 255, 255, 255, true)
	outputChatBox(" ", targetPlayer, 255, 255, 255, true)
	outputChatBox("#1E8BC3[Localização]:#ffffff " .. getPlayerName(thePlayer):gsub("_"," ") .. " enviou uma localização para você", targetPlayer, 255, 255, 255, true)
	outputChatBox("#1E8BC3[Localização]:#ffffff Para aceitar digite: #7cc576/aceitar#ffffff.", targetPlayer, 255, 255, 255, true)
	outputChatBox("#1E8BC3[Localização]:#ffffff Para recusar digite: #dc143c/recusar#ffffff.", targetPlayer, 255, 255, 255, true)

	setElementData(targetPlayer, "call:LOC", true)

	setElementData(targetPlayer, "call:accept", 1)
	setElementData(thePlayer, "call:selling", 1)
	setElementData(targetPlayer, "call:tplayer", thePlayer)	
	

end
end

function elfogad(source, cmd)
if getElementData(source, "call:accept") == 1 then

		local tplayer = getElementData(source, "call:tplayer")
		outputChatBox(" ", source, 255, 255, 255, true)
		outputChatBox(" ", source, 255, 255, 255, true)
		outputChatBox(" ", source, 255, 255, 255, true)
		outputChatBox(" ", source, 255, 255, 255, true)
		outputChatBox("#1e8bc3[Localização]:#ffffff Você aceitou a localização", source, 255, 255, 255, true)


		outputChatBox(" ", getElementData(source, "call:tplayer"), 255, 255, 255, true)
		outputChatBox(" ", getElementData(source, "call:tplayer"), 255, 255, 255, true)
		outputChatBox(" ", getElementData(source, "call:tplayer"), 255, 255, 255, true)
		outputChatBox(" ", getElementData(source, "call:tplayer"), 255, 255, 255, true)
		outputChatBox("#1e8bc3[Localização]:#ffffff Aceitaram sua localização", getElementData(source, "call:tplayer"), 255, 255, 255, true)

		setElementData(source, "call:accept", false)
		local oldCash = getElementData(source, "char:money") or 0
		setElementData(source, "char:money", oldCash - math.random(100,500))
		setElementData(tplayer, "call:selling", false)


		setElementData(source, "call:accept", false)
		setElementData(source, "call:tplayer", false)
		setElementData(source, "call:selling", false)
		setElementData(source, "call:tplayer", false)
		setElementData(source, "call:LOC", false)

		local x, y, z = getElementPosition(tplayer)
		--triggerClientEvent(source, "localizar", source, x, y, z)
		exports.Script_futeis:setGPS(source, "Coordenada", x, y, z)


			
			
			
end
end
addCommandHandler("aceitar", elfogad, false, false)

function decline(source, cmd)
	local tplayer = getElementData(source, "call:tplayer")
if getElementData(source, "call:accept") == 1 then
setElementData(source, "call:accept", false)
setElementData(tplayer, "call:selling", false)
setElementData(source, "call:tplayer", false)

setElementData(source, "call:LOC", false)

outputChatBox(" ", source, 255, 255, 255, true)
outputChatBox(" ", source, 255, 255, 255, true)
outputChatBox(" ", source, 255, 255, 255, true)
outputChatBox(" ", source, 255, 255, 255, true)

outputChatBox("#1e8bc3[Localização]:#ffffff Você rejeitou a localização", source, 255, 255, 255, true)

outputChatBox(" ", tplayer, 255, 255, 255, true)
outputChatBox(" ", tplayer, 255, 255, 255, true)
outputChatBox(" ", tplayer, 255, 255, 255, true)
outputChatBox(" ", tplayer, 255, 255, 255, true)
outputChatBox("#1e8bc3[Localização]:#ffffff Recusaram a sua localização.", tplayer, 255, 255, 255, true)
end
end
addCommandHandler("recusar", decline, false, false)



addEvent('syncLookAt', true)
addEventHandler('syncLookAt', root, function(x,y,z)
	setElementData(source, "lookAtOffsetX", x)
	setElementData(source, "lookAtOffsetY", y)
	setElementData(source, "lookAtOffsetZ", z)
end)

function onResourceStart ( )
    local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
    for key, player in ipairs ( players ) do       -- for all the players in the table
        setPlayerNametagShowing ( player, false )  -- turn off their nametag
    end
end
addEventHandler ( "onResourceStart", resourceRoot, onResourceStart )

function onPlayerJoin ( )
      -- Whoever joins the server should also have their nametags deactivated
	setPlayerNametagShowing ( source, false )
end
addEventHandler ( "onPlayerJoin", root, onPlayerJoin )


function teste()
if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
bgoadmin = true --exports.bgo_admin:AntiComandTempo(player) --or (getElementData(localPlayer,"acc:id") == 1)
else	
bgoadmin = false
end
end
setTimer(teste, 200, 0)	


local elements = {}
addEvent('copomativo', true)
addEventHandler('copomativo', root, function(thePlayer)
		if not bgoadmin then return end
			if radioon(thePlayer) then
			local theTeam = getPlayerTeam(thePlayer)
			if countPlayersInTeam ( theTeam ) > 1 then

			if ( isPedDead ( thePlayer ) ) then 
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"RADINHO!", "Morto não fala!", "info")
			return 
			end
				if not elements then
					elements = {}
				end
				if not elements[thePlayer] then
					elements[thePlayer] = {}
				end
				setPedAnimation(thePlayer, "GANGS", "smkcig_prtl", 0, true, false, false)
				setTimer ( setPedAnimationSpeed, 100, 1, thePlayer, "smkcig_prtl", 0)
				setTimer ( setPedAnimationProgress, 100, 1, thePlayer, "smkcig_prtl", 1.36)
				local theTeam = getPlayerTeam(thePlayer)
				if ( theTeam ) then
				
				
				if getPlayerTeam ( thePlayer ) == getTeamFromName ( "Policia" ) then
	
				print(""..getPlayerName(thePlayer).." falando na frequencia: POLICIA ")
				elseif getPlayerTeam ( thePlayer ) == getTeamFromName ( "Admin" ) then
				print(""..getPlayerName(thePlayer).." falando na frequencia: ADMIN ")

				elseif getPlayerTeam ( thePlayer ) == getTeamFromName ( "Samu" ) then
				print(""..getPlayerName(thePlayer).." falando na frequencia: SAMU ")

				elseif getPlayerTeam ( thePlayer ) == getTeamFromName ( "DRVV" ) then
				print(""..getPlayerName(thePlayer).." falando na frequencia: DRVV ")

				else
				print(""..getPlayerName(thePlayer).." falando na frequencia: "..getTeamName(theTeam).." ")
				end
				
				setElementData(thePlayer, "inCall", true)
				triggerClientEvent(thePlayer, "SomRadinhoInicio", thePlayer)



				local players = getPlayersInTeam ( theTeam )
				local playerValue = nil
				for playerKey = 1, #players do
				playerValue = players[playerKey]
				if playerValue ~= thePlayer then
				if not isPedDead ( playerValue ) or exports['bgo_items']:hasItemS(playerValue, 20) or exports.bgo_admin:isPlayerDuty(playerValue) or (tonumber(getElementData(playerValue, "acc:admin") or 0) >= 0) then 
				--if not getElementData(source,"grupo:Radio") then
				table.insert( elements[thePlayer], playerValue );
				setElementData(playerValue, "inCall", false)
				setElementData(playerValue, "status:RadioAtivo", true )
				
				
						if exports.bgo_admin:isPlayerDuty(playerValue) then
						local x, y, z = getElementPosition ( playerValue )
						local veiculo = getElementsWithinRange(x, y, z, 30, "vehicle")
						local veh = nil
						for i = 1, #veiculo do
						veh = veiculo[i]
						local id = getElementModel ( veh )
						if id == 490 
						or id == 523
						or id == 497
						or id == 548 then
						if getElementDimension(veh) == 0 then
						local x2, y2, z2 = getElementPosition ( veh )
						triggerClientEvent(playerValue, "SomRadinhoInicio", playerValue, true, x2, y2, z2)
						--print("aaaa")
						local x, y, z = getElementPosition ( playerValue )
						local x1, y1, z1 = getElementPosition ( veh )
						distance = getDistanceBetweenPoints3D ( x1, y1, z1, x, y, z )
						if distance < 6 then
						outputChatBox ( "#7cc576[RADINHO]:#ffffff"..getPlayerName(thePlayer)..": Falando no radinho", playerValue, 255, 0, 0, true )
						end
						
						end
						end
						end
						else
						triggerClientEvent(playerValue, "SomRadinhoInicio", playerValue)
						outputChatBox ( "#7cc576[RADINHO]:#ffffff"..getPlayerName(thePlayer)..": Falando no radinho", playerValue, 255, 0, 0, true )
						end

				--	end
				end
				--for i, v in ipairs ( elements[thePlayer] ) do 
				setPlayerVoiceBroadcastTo( thePlayer, elements[thePlayer]);
				--print('aaaa')
				end
				
				end
			end
			else
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"RADINHO!", "Não tem ninguem na frequencia!", "info")
			end
	end
end
)





function puxarValorTabela(elemento)
    if isElement(elemento) then
        if elements[caixa] and elements[elemento] then
            return elements[elemento]
        end
    end
end


function radioon(player)
if getElementData(player, "status:RadioAtivo") == false then
return true
else
return false
end
end

addEvent('copomoff', true)
addEventHandler('copomoff', root, function(thePlayer)
if not bgoadmin then return end
				local theTeam = getPlayerTeam(thePlayer)
				if ( theTeam ) then
	

			if countPlayersInTeam ( theTeam ) > 1 then
			
				setPedAnimation ( thePlayer, "ped", "phone_out", 50, false, false, false, false)
			
			
			if ( isPedDead ( thePlayer ) ) then 
			return 
			end
				local players = getPlayersInTeam ( theTeam )
				triggerClientEvent(thePlayer, "SomRadinho", thePlayer)
				local playerValue = nil
				for playerKey = 1, #players do
				playerValue = players[playerKey]
				if playerValue ~= thePlayer then
				if exports['bgo_items']:hasItemS(playerValue, 20) or exports.bgo_admin:isPlayerDuty(playerValue) or (tonumber(getElementData(playerValue, "acc:admin") or 0) >= 0) then 
				if getElementData(playerValue, "status:Radio") == false then
				setElementData(playerValue, "status:RadioAtivo", false )
				--triggerClientEvent(playerValue, "SomRadinho", playerValue)
				
						if exports.bgo_admin:isPlayerDuty(playerValue) then
						local x, y, z = getElementPosition ( playerValue )
						local veiculo = getElementsWithinRange(x, y, z, 30, "vehicle")
						local veh = nil
						for i = 1, #veiculo do
						veh = veiculo[i]
						local id = getElementModel ( veh )
						if id == 490 
						or id == 523
						or id == 497
						or id == 548 then
						if getElementDimension(veh) == 0 then
						local x2, y2, z2 = getElementPosition ( veh )
						triggerClientEvent(playerValue, "SomRadinho", playerValue, true, x2, y2, z2)
						end
						end
						end
						else
						triggerClientEvent(playerValue, "SomRadinho", playerValue)
						end
				
				
				end
				end
			end
		end
				elements[thePlayer] = nil
				setElementData(thePlayer, "inCall", false)
				setPlayerVoiceBroadcastTo( thePlayer, nil)
			end
	end
end
)




function criarGang ( source, commandName, teamName )
if not bgoadmin then return end
		local value = getElementData(source,"char:adminduty")
		if value == 1 and not (tonumber(getElementData(source, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não pode usar esta função no modo admin",source, 255, 194, 14, true) return end
		
		if exports.bgo_admin:isPlayerDuty(source) then
		outputChatBox ( "#F4A460[Frequência]#F08080 Policiais em serviço não utilizam está função!", source, 255, 255, 255, true ) 
		return
		end
		
		if getElementData(source,"grupo:Radio") then
		outputChatBox ( "#F4A460[Frequência]#F08080 Você está com a frequência do radio mutada! não pode utilizar esta função!", source, 255, 255, 255, true ) 
		return
		end
		

		
		
		
			if exports['bgo_items']:hasItemS(source, 20) then 
 
			if ( teamName == tonumber(teamName) ) then
			outputChatBox ( "#F4A460[GANG]#F08080 Uso correto: /radiof [Frequência]", source, 255, 255, 255, true ) 
			return 
			end
			if not tonumber(teamName) then 
				outputChatBox ( "#F4A460[GANG]#F08080 Uso correto: /radiof [Frequência]", source, 255, 255, 255, true ) 
			return 
			end
				
				if string.find(teamName, "%p+") then
				outputChatBox ( "#F4A460[RADINHO]#F08080 APENAS NUMEROS NA FREQUENCIA!", source, 255, 255, 255, true ) 
					return
				end
				if string.find(teamName,"-") or string.find(teamName,"_") then
				outputChatBox ( "#F4A460[RADINHO]#F08080 APENAS NUMEROS NA FREQUENCIA!", source, 255, 255, 255, true ) 
				return
				end
				
			if ( tonumber(teamName) == 0 ) then 
			if ( getPlayerTeam ( source ) ~= false ) and ( countPlayersInTeam ( getPlayerTeam ( source ) ) == 1 ) then 
                destroyElement ( getPlayerTeam ( source ) ) 
            end 
			outputChatBox ( "#F4A460[Frequência]#F08080 Você não está mais em nenhuma frequência ", source, 255, 255, 255, true ) 
			setPlayerTeam ( source, nil )	
		setElementData(source, "status:RadioAtivo", false )			
			return 
			end
			if ( tonumber(teamName) ) then 		
            if ( getPlayerTeam ( source ) ~= false ) and ( countPlayersInTeam ( getPlayerTeam ( source ) ) == 1 ) then 
                destroyElement ( getPlayerTeam ( source ) ) 
            end 
            local newTeam = createTeam ( teamName ) 
            if ( newTeam ) then 
				setTeamColor ( newTeam, math.random ( 0, 255 ), math.random ( 0, 255 ), math.random ( 0, 255 ) ) 
                setPlayerTeam ( source, newTeam ) 
                outputChatBox ( "#F4A460[Frequência]#F08080 Você entrou na Frequência ".. tonumber(teamName) .." ", source, 255, 255, 255, true ) 
				else
				setPlayerTeam(source, getTeamFromName ( teamName ))
				outputChatBox ( "#F4A460[Frequência]#F08080 Você entrou na Frequência ".. tonumber(teamName) .." ", source, 255, 255, 255, true ) 
            end 
		else 
			outputChatBox ( "#F4A460[GANG]#F08080 Uso correto: /radiof [Frequência]", source, 255, 255, 255, true ) 
		end 
	else
	outputChatBox ( "#F4A460[GANG]#F08080 Você precisa ter o Radio Frequência na mochila para utilizar esta função", source, 255, 255, 255, true ) 
	end
end 
addCommandHandler ( "radiof", criarGang ) 


function save ( ) 
    local account = getPlayerAccount ( source ) 
    if ( not isGuestAccount ( account ) ) then 
		if ( getPlayerTeam ( source ) ~= false ) 		
		and ( countPlayersInTeam ( getPlayerTeam ( source ) ) == 1 ) then 
		if getPlayerTeam ( source ) == getTeamFromName ( "Policia" ) 
		or getPlayerTeam ( source ) == getTeamFromName ( "DRVV" )
		or getPlayerTeam ( source ) == getTeamFromName ( "Admin" )
		or getPlayerTeam ( source ) == getTeamFromName ( "Samu" ) then
		return 
		end
                destroyElement ( getPlayerTeam ( source ) ) 
        end 
    end
end	
 
addEventHandler ( "onPlayerLogout", root, save ) 
addEventHandler ( "onPlayerQuit", root, save ) 



function mutarradio(thePlayer, commandName)
if not bgoadmin then return end
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 1 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não pode usar esta função no modo admin",thePlayer, 255, 194, 14, true) return end
		
		
		if exports.bgo_admin:isPlayerDuty(thePlayer) then
		outputChatBox ( "#F4A460[Frequência]#F08080 Policiais em serviço não utilizam está função!", thePlayer, 255, 255, 255, true ) 
		return
		end
		
		local allapot = getElementData(thePlayer, "status:Radio")
		if allapot == false then			
				local theTeam = getPlayerTeam(thePlayer)
				setElementData(thePlayer, "grupo:Radio", getTeamName(theTeam))
				if ( theTeam ) then
				outputChatBox("Você mutou o Radio Frequência", thePlayer, 255, 255, 255, true)
				setElementData(thePlayer, "status:Radio", true)
				setElementData(thePlayer, "status:RadioAtivo", true )
				setElementData(thePlayer, "grupo:Radio", getTeamName(theTeam))
				setPlayerTeam ( thePlayer, nil )
				end
				
		else
			if getElementData(thePlayer,"grupo:Radio") then
			outputChatBox("Você ligou o Radio Frequência", thePlayer, 255, 255, 255, true)
			setElementData(thePlayer, "status:Radio", false)
			setElementData(thePlayer, "status:RadioAtivo", false )
			
			setPlayerTeam ( thePlayer, getTeamFromName ( getElementData(thePlayer,"grupo:Radio") ) )
			setElementData(thePlayer, "grupo:Radio", false)
			end
			
			
		end
end
addCommandHandler("radiom", mutarradio, false, false)

