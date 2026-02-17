--local farmMaconha = createColCuboid(1008.48456, -369.02823, 70.56422, 112.55340576172, 77.538848876953, 38.9)

local Droga = "Ferro e Plástico"



plantsColL = {}
LockPick = {}
timerLockPick = {}
local gang = 27
local policia = 3


--[[
local maconha = createBlip(1063.986, -330.112, 73.992, 37)
setElementData(maconha ,"blipName", "Campo Maconha")


local processLockPick = createBlip(-1496.003, 1198.892, 13.179, 37)
setElementData(processLockPick ,"blipName", "Process... Maconha")

]]--


--local plants = createObject(3409, 1101.0242919922,-315.90603637695,72.9921875)
local plantsColL = createColSphere (832.87921142578,818.57855224609,-42.96700668335, 4)

--[[
function exitObjectMaco (thePlayer)
	 if isElement(LockPick[thePlayer]) then
	     if exports['bgo_items']:hasItemS(thePlayer, 21) then
             destroyElement(LockPick[thePlayer])
			 exports.bgo_hud:dm("Sua maconha foi removida Motivo: (Saiu da area).",thePlayer, 255, 0, 0)
			 setElementData(thePlayer, "Object:Jobs", false)
			 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 21, false)
			 verificationMaco (thePlayer)
			 exports.bgo_anims:setJobAnimation(thePlayer)
    		 if isTimer(timerLockPick[thePlayer]) then
                 killTimer(timerLockPick[thePlayer])	 
	    	 end
		 end
     end
end
addEventHandler("onColShapeLeave", farmMaconha, exitObjectMaco)

function verificationMaco (thePlayer)
     if exports['bgo_items']:hasItemS(thePlayer, 21) then
	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 21, false)
		 verificationMaco (thePlayer)
	 else
	     return
	 end
end
]]--

function addBindKeyLock (thePlayer)
	local prTeam = getTeamFromName ( "Policia" )
	local prCount = countPlayersInTeam ( prTeam )
	 if prCount >= policia then
    if getElementData(thePlayer, "char:dutyfaction") == gang then
    exports.bgo_hud:dm("Campo de "..Droga..".",thePlayer, 255, 255, 255)
	exports.bgo_hud:dm("Pressione [E] Para iniciar a coleta.",thePlayer, 255, 50, 70)
    bindKey(thePlayer, "e", "down", startTheFunctionLock)
	setElementData(thePlayer, "enterZone:LockPick", true)
	end
	else
		exports.bgo_hud:dm("Precisa de 10 policia na cidade para fazer o farm!",thePlayer, 255, 255, 255)
	end
end
addEventHandler("onColShapeHit", plantsColL, addBindKeyLock)


local originalGetPlayerCount = getPlayerCount
function getPlayerCount()
    return originalGetPlayerCount and originalGetPlayerCount() or #getElementsByType("player")
end

function removeBindKeyLock (thePlayer)
     unbindKey(thePlayer, "e", "down", startTheFunctionLock)
	 setElementData(thePlayer, "enterZone:LockPick", false)
end
addEventHandler("onColShapeLeave", plantsColL, removeBindKeyLock)

function startTheFunctionLock (thePlayer)
	 --if isElement(LockPick[thePlayer]) then return end
	 if exports['bgo_items']:hasItemS(thePlayer, 21) then return end
     if (getElementData(thePlayer, "enterZone:LockPick")) then
		 unbindKey(thePlayer, "e", "down", startTheFunctionLock)
		 setElementFrozen(thePlayer, true)
		 setPedAnimation(thePlayer, "bomber", "bom_plant_loop", -1, false, true, false, true)
		 triggerClientEvent(thePlayer, "progressService", thePlayer, 4)
		 setTimer(function(thePlayer)
			setPedAnimation(thePlayer)
			setElementData(thePlayer, "Object:Jobs", true)
			setElementFrozen(thePlayer, false)
		     if (getElementData(thePlayer, "enterZone:LockPick")) then
				setPedAnimation(thePlayer)
				
				--local x,y,z = getElementPosition(thePlayer)
				--if isElement(LockPick[thePlayer]) then
				--	destroyElement(LockPick[thePlayer])			 
				--end
	            -- LockPick[thePlayer] = createObject(2901, x, y, z)
	            -- setObjectScale(LockPick[thePlayer],0.75)
	            -- setElementCollisionsEnabled(LockPick[thePlayer],false)
				 --attachElements(LockPick[thePlayer],thePlayer,0,0.45,0.37,1,0,0)
				 
				 
				 setElementData(thePlayer, "Object:Jobs", true)
				 setElementFrozen(thePlayer, false)
			    -- setPedAnimation(thePlayer, "CARRY", "crry_prtial", 50, false, true, false, true)
				 
				 
				 if not exports['bgo_items']:hasItemS(thePlayer, 21) then
				    -- exports['bgo_items']:giveItem(thePlayer, 21, 1, 1, 0, false)
					 exports.bgo_items:giveItem(thePlayer, 21, 1, 1, 0, true)
				 end

				 exports.bgo_hud:dm("Leve o Ferro e Plastico até o seu caminhão.",thePlayer, 255, 255, 255)
				 --timerLockPick[thePlayer] = setTimer(deletObjectMaco, 2000, 100, thePlayer)
			 end
		 end, 4000, 1, thePlayer)
	 end
end

function deletObjectMaco (thePlayer)
     if not thePlayer then return end
     if not exports['bgo_items']:hasItemS(thePlayer, 21) then
		 if isTimer(timerLockPick[thePlayer]) then
			 killTimer(timerLockPick[thePlayer])	
			 setPedAnimation(thePlayer)
			 setElementData(thePlayer, "Object:Jobs", false) 
		 end
		 if isElement(LockPick[thePlayer]) then
			 destroyElement(LockPick[thePlayer])			 
	 	end
	end
end

function enterTruckMaco (player, seat, jacked)
     if exports['bgo_items']:hasItemS(player, 21) then
	     cancelEvent()
		 exports.bgo_hud:dm("Você não pode embarcar no carro com 'Ferro e Plástico' na mão.",player, 255, 255, 255)
	 end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterTruckMaco)

addEventHandler("onPlayerQuit", root,
function ()
		 if isTimer(timerLockPick[source]) then
             killTimer(timerLockPick[source])	 
		 end
		 if isElement(LockPick[source]) then
			 destroyElement(LockPick[source])
		 end
end)

------------------------------------

local processLockPick = createColSphere (2588.6525878906,2811.2922363281,10.8203125, 2)
local processOpLockPick = false
local contagemL = {}
local LObejct = {}
local markL = {}
local timerLPFC = {}
local loopL = {}
local loopLN = {}
local loopLTC = {}

addEventHandler("onColShapeHit", processLockPick, function (thePlayer)
	local prTeam = getTeamFromName ( "Policia" )
	local prCount = countPlayersInTeam ( prTeam )
	 if prCount >= policia then
     if exports['bgo_items']:hasItemS(thePlayer, 21) then
	     exports.bgo_hud:dm("Pressione [E] Para iniciar o processamento.",thePlayer, 255, 50, 70)
		 bindKey(thePlayer, "e", "down", startTheProcessLockPick)
	     else
		 exports.bgo_hud:dm("Você não possui o item indicado 'Ferro e Plástico'.",thePlayer, 255, 0, 0)
	 end
	 else
		exports.bgo_hud:dm("Precisa de 10 policia na cidade para fazer o farm!",thePlayer, 255, 255, 255)
	end
end)

addEventHandler("onColShapeLeave", processLockPick, function (thePlayer)
	 unbindKey(thePlayer, "e", "down", startTheProcessLockPick)
end)

function startTheProcessLockPick (thePlayer)
     if isElementWithinColShape ( thePlayer, processLockPick) then
	 --[[
     local xS,yS,zS = getElementPosition(thePlayer)
	 if (zS) then
	     local zX = math.floor(zS)
		 if (zX ~= 7) then
		     exports.bgo_hud:dm("Desça da mesa para processar.",thePlayer, 255, 255, 255)
		     return
		 end
	 end
	 ]]--
	 
	     if exports['bgo_items']:hasItemS(thePlayer, 21) then
		     unbindKey(thePlayer, "e", "down", startTheProcessLockPick)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setElementFrozen(thePlayer, true)
		     exports.bgo_hud:dm("Processamento iniciando em breve, Aguarde.",thePlayer, 255, 255, 255)
			 contagemL[thePlayer] = 0
			 --setTimer(execProcessLockPick, 2000, 1, thePlayer)
			 contagemLDeLockPick (thePlayer)
		 end
	 end
end

function contagemLDeLockPick (thePlayer)
     if exports['bgo_items']:hasItemS(thePlayer, 21) then 
	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 21, false)
		 contagemL[thePlayer] = contagemL[thePlayer] + 1
		 outputDebugString("O valor de Contagem da Ferro e plastico foi de "..contagemL[thePlayer])
		 --contagemLDeLockPick (thePlayer)
		 setTimer(contagemLDeLockPick, 1000, 1, thePlayer)
         else
		 execProcessLockPick (thePlayer)
         return		 
	 end
end

function execProcessLockPick (thePlayer)
setElementData(thePlayer, "setLockPick", contagemL[thePlayer])
loopL[thePlayer] = getElementData(thePlayer, "setLockPick") or 0
     loopLN[thePlayer] = tonumber(loopL[thePlayer])
	 outputDebugString("O valor do processo lock pick foi de "..loopL[thePlayer])
	 
	exports['bgo_items']:giveItem(thePlayer, 21, 1, loopLN[thePlayer], 0, false)
	
	
     if contagemL[thePlayer] then
		 setTimer(function(thePlayer)
             if not exports['bgo_items']:hasItemS(thePlayer, 21) then			 
				     setElementData(thePlayer, "Object:Jobs", false)
					 setElementFrozen(thePlayer, false)
				     exports.bgo_hud:dm("Processamento encerrado... Vá até o outro lado da maquina para pegar a droga refinada.",thePlayer, 255, 255, 255)	
                     return								 
			 end
	         exports.bgo_hud:dm("Processamento iniciando, Não saia do local.",thePlayer, 255, 255, 255)
			 setElementData(thePlayer, "Object:Jobs", true)
		     triggerClientEvent(thePlayer, "progressService", thePlayer, 5)
		     LObejct[thePlayer] = createObject(2060, 2589.5959472656,2811.3215332031,10.8203125)
			 setElementData(LObejct[thePlayer], "Object:Jobs", true)
	         setObjectScale(LObejct[thePlayer],0.75)
	         setElementCollisionsEnabled(LObejct[thePlayer],false)
	         moveObject(LObejct[thePlayer], 5000, 2606.2399902344,2811.3984375,10.8203125)
		     if isElement(LObejct[thePlayer]) then
				 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 21, false)
				 setTimer(destroyElement, 5500, 1, LObejct[thePlayer])
			 end
		 end, 5100, loopLN[thePlayer] + 1, thePlayer)
	 end
end

markL = createMarker(2608.1408691406,2811.3251953125,10.8203125-0.9, "cylinder", 1.1, 255, 0, 0, 100)
local tempoLockPick = { }
function takeLockPick (thePlayer)
     if (getElementData(thePlayer, "setLockPick")) then
	 local loopLTC = getElementData(thePlayer, "setLockPick") or 0
	     if not exports['bgo_items']:hasItemS(thePlayer, 21) then
             timerLPFC[thePlayer] = 0
		     exports.bgo_hud:dm("Droga refinada com sucesso "..(getElementData(thePlayer, "setLockPick") or 0)..".",thePlayer, 255, 255, 255)
			 exports.bgo_hud:dm("Você pode perder suas drogas caso a conexão com o servidor seja perdida.",thePlayer, 255, 0, 0)
			 setElementFrozen(thePlayer, true)
			 setElementData(thePlayer, "Object:Jobs", true)
			 
			tempoLockPick[thePlayer] = setTimer(function(thePlayer)
			    if exports['bgo_items']:giveItem(thePlayer, 18, 1, 1, 0, false) then
				timerLPFC[thePlayer] = timerLPFC[thePlayer] + 1
				 if exports['bgo_items']:hasItemS(thePlayer, 18) then
                     if (loopLTC == timerLPFC[thePlayer]) then
						setElementData(thePlayer, "setLockPick", false)
					     exports.bgo_hud:dm("Finalziado com sucesso pode se retirar.",thePlayer, 255, 255, 255)
					     timerLPFC[thePlayer] = 0
						 loopLN[thePlayer] = 0
						 loopL[thePlayer] = 0
			             setElementFrozen(thePlayer, false)
			             setElementData(thePlayer, "Object:Jobs", false)
					 end
				 end
				 
				else
				if isTimer(tempoLockPick[thePlayer]) then
				killTimer(tempoLockPick[thePlayer])
				end
				setElementFrozen(thePlayer, false)
				setElementData(thePlayer, "Object:Jobs", false)
				exports.bgo_hud:dm("PROBLEMA!! VOCÊ ESTÁ COM A MOCHILA CHEIA! ESVAZIE E TENTE NOVAMENTE!.",thePlayer, 255, 255, 255)
				end
				 
				 
				 
				 
			 end, 1000, loopLTC, thePlayer)
		 end
	 end
end
addEventHandler("onMarkerHit", markL, takeLockPick)