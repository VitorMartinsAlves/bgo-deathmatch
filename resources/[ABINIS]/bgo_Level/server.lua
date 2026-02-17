	--exports [ "scoreboard" ]:addScoreboardColumn ( "Level") 



function convertS(s)
	if type(tonumber(s)) == "number" then
		milisegundo = s
		local horas_seg=3600
		local hora = math.floor(milisegundo/horas_seg)
		local minuto = math.floor((milisegundo-(horas_seg*hora))/60)
		local segundo = math.floor((milisegundo-(horas_seg*hora)-(minuto*60)))	
		local tudo = string.format("%02d:%02d:%02d",hora,minuto,segundo)	
		local dia = math.floor(s/86400)

		return hora,minuto,segundo,tudo,dia
	else
		return 0,0,0,0,0		
	end
end


























--[[


function saveData(conta)
	if conta then
			local source = getAccountPlayer(conta)
			local level = getElementData(source,"Sys:Level") or 0
			local exp = getElementData(source,"LSys:EXP") or 0
			setAccountData (conta, "Sys:Level",level)
			setAccountData (conta, "LSys:EXP",exp)
	end	
end

function loaddata(conta)
	if not (isGuestAccount (conta)) then
		if (conta) then	
			local source = getAccountPlayer(conta)	
			local level = getAccountData(conta,"Sys:Level")
			if type(level) == "boolean" or level == nil then
				level = 0
			end
			setElementData (source, "Sys:Level", tonumber(level))
			setElementData (source, "LSys:EXP",tonumber(getAccountData(conta,"LSys:EXP")) or 0)
		end
	end	
end



addEventHandler("onPlayerLogin", root,
  function( _, acc )
	setTimer(loaddata,1000,1,acc)
  end
)

function startScript ( res )
	if res == getThisResource() then
		for i, player in ipairs(getElementsByType("player")) do
			local acc = getPlayerAccount(player)
			if not isGuestAccount(acc) then
				loaddata(acc)			
			end
		end
	end
end
addEventHandler ( "onResourceStart", getRootElement(), startScript )

function stopScript( res )
    if res == getThisResource() then
		for i, player in ipairs(getElementsByType("player")) do
			local acc = getPlayerAccount(player)
			if not isGuestAccount(acc) then
				saveData(acc)	
			end
		end
	end
end 
addEventHandler ( "onResourceStop", getRootElement(), stopScript )

function deslogar(acc)
	cancelEvent ()
end
addEventHandler("onPlayerLogout",getRootElement(),deslogar)

function sair ( quitType )
	local acc = getPlayerAccount(source)
	if not (isGuestAccount (acc)) then
		if acc then
			saveData(acc)
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), sair )]]--


local level_maximo = 23

local levelsTable = {
	[0] = 0,
	[1] = 1000,
	[2] = 5000, 
	[3] = 7000,
	[4] = 10000, 
	[5] = 15000, 
	[6] = 18000, 
	[7] = 20000, 
	[8] = 24000, 
	[9] = 26000, 
	[10] = 30000, 
	[11] = 33000, 
	[12] = 35000, 
	[13] = 38000, 
	[14] = 41000, 
	[15] = 45000, 
	[16] = 47000, 
	[17] = 52000, 
	[18] = 56000, 
	[19] = 61000, 
	[20] = 70000, 
	[21] = 80000, 
	[22] = 90000, 
	[23] = 100000 

}

function checkLevel( player )
	local player = player
	local playerExp = getElementData( player, "LSys:EXP" ) or 0
	local lv = getElementData( player, "Sys:Level" ) or 1 
	local ganhoXP = 1
	local expCheck = levelsTable[lv]-playerExp
	if expCheck <= 0 then
		local exp = (lv + ganhoXP) == level_maximo and 0 or playerExp - levelsTable[lv]
		exports.bgo_hud:dm("[ UP ] - Você obteve "..playerExp.." De Experiência e Subiu de Nível para o Nivel  ( "..(lv + ganhoXP).." )", player, 255, 255, 255)

		triggerClientEvent ( player, "PlayerLevelUp", player, (lv + ganhoXP) )
		setElementData(player, "Sys:Level", lv + ganhoXP ) 

		setElementData(player, "LSys:EXP", 0 )
		setElementData(player, "LSys:EXPF", 0 )
		playSoundFrontEnd ( player, 101 )
	end
end



function givePlayerExp(player, exp )
	if exp and tonumber(exp) and (getElementData(player , "Sys:Level" ) or 0) ~= level_maximo then
		local playerExp = getElementData(player , "LSys:EXP" ) or 0 
			local lv = getElementData( player, "Sys:Level" ) or 1 

			setElementData( player, "LSys:EXP", playerExp + tonumber(exp) ) 


		checkLevel( player ) 


		setElementData( player, "LSys:EXPF", levelsTable[lv] )
		exports.bgo_hud:dm("Precisa de "..(levelsTable[lv]-playerExp).." de expêriencia para subir de nivel", player, 255, 255, 255)	
		exports.bgo_hud:dm("[ UP ] - Você obteve "..tonumber(exp).." de expêriencia", player, 255, 255, 255)	
		
		return true
	end
	return false
end
--addCommandHandler("level", givePlayerExp)

--[[

addEventHandler( "onClientElementDataChange", root,
	function (dataName)
		if (dataName == "LSys:EXP") then
			checkLevel( source )
		end
	end
)







setTimer(
	function()
		for i, player in ipairs(getElementsByType("player")) do
		local playerExp = getElementData(player , "LSys:EXP" ) or 0 
		local ganho = math.random (100, 255)
		setElementData( player, "LSys:EXP", playerExp + ganho ) 
		checkLevel( player )

		exports.bgo_hud:dm("[ UP ] - O servidor te presenteou "..ganho.." de expêriencia", player, 255, 255, 255)
		end
end, 60000 * 60, 0)	
]]--





