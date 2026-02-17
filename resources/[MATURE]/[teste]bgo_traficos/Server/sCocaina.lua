local Czone =  createColCuboid(-570.69714, 2582.91772, 52.65536, 16.498352050781, 3.140869140625, 3.2000068664551)
local Czone2 = createColCuboid(-570.78955, 2586.07666, 52.65536, 3.5642700195313, 8.771240234375, 3.8000053405762)
local CExzone =  createColCuboid(-590.61676, 2564.60742, 51.55540, 87.295745849609, 76.49755859375, 22.799951934814)


local cocaina = createBlip(-556.115, 2592.925, 86.655, 37)
setElementData(cocaina ,"blipName", "Campo Cocaina")

local processcocaina = createBlip(835.049, -2054.897, 22.523, 37)
setElementData(processcocaina ,"blipName", "Process... cocaina")

local policia = 3



local zPos = 53
local Droga = "Cocaina"
local Object = 1578
local timeR = 4

daysemana = {
     {1, "segunda"},
	 {2, "terça"},
	 {3, "quarta"},
	 {4, "quinta"},
	 {5, "sexta"},
	 {6, "sábado"},
	 {0, "domingo"},
}

CObject = {}
timerC = {}
day = {}

local gang = 10

addEventHandler("onColShapeHit", Czone,function (thePlayer)
	local prTeam = getTeamFromName ( "Policia" )
	local prCount = countPlayersInTeam ( prTeam )
    if prCount >= policia then
	if getElementData(thePlayer, "char:dutyfaction") == gang then
    exports.bgo_hud:dm("Campo de "..Droga..".",thePlayer, 255, 255, 255)
	exports.bgo_hud:dm("Pressione [E] Para iniciar a fabricação.",thePlayer, 255, 50, 70)
	bindKey(thePlayer, "e", "down", startTheFunction)
	end
	 else
	 exports.bgo_hud:dm("Para iniciar o serviço necessita de 10 Policias Rodoviários.",thePlayer, 255, 255, 255)
	end
end)

local originalGetPlayerCount = getPlayerCount
function getPlayerCount()
    return originalGetPlayerCount and originalGetPlayerCount() or #getElementsByType("player")
end

addEventHandler("onColShapeHit", Czone2,function (thePlayer)
 if getElementData(thePlayer, "char:dutyfaction") == gang then
	local prTeam = getTeamFromName ( "Policia" )
	local prCount = countPlayersInTeam ( prTeam )
     if prCount >= policia then
     exports.bgo_hud:dm("Campo de "..Droga..".",thePlayer, 255, 255, 255)
	 exports.bgo_hud:dm("Pressione [E] Para iniciar a fabricação.",thePlayer, 255, 50, 70)
	 bindKey(thePlayer, "e", "down", startTheFunction)
	 else
	 exports.bgo_hud:dm("Para iniciar o serviço necessita de 10 Policias Rodoviários.",thePlayer, 255, 255, 255)
	 end
	 end
end)

function removeBindKey (thePlayer)
     unbindKey(thePlayer, "e", "down", startTheFunction)
end
addEventHandler("onColShapeLeave", Czone2, removeBindKey)
addEventHandler("onColShapeLeave", Czone, removeBindKey)

function startTheFunction (thePlayer)  
     local xS,yS,zS = getElementPosition(thePlayer)
	 if (zS) then
	     local zX = math.floor(zS)
		 if (zX ~= zPos) then
		     exports.bgo_hud:dm("Desça da mesa para processar a droga.",thePlayer, 255, 255, 255)
		     return
		 end
	 end

	 if isElement(CObject[thePlayer]) then exports.bgo_hud:dm("Leve a droga que esta na sua mão para o caminhãoa para pegar outra.",thePlayer, 255, 255, 255) return end

	 unbindKey(thePlayer, "e", "down", startTheFunction)
	 setElementData(thePlayer, "Object:Jobs", true)
	 setElementFrozen(thePlayer, true)
	 setPedAnimation(thePlayer, "casino", "cards_pick_01", -1, false, true, false, true)
	 triggerClientEvent(thePlayer, "progressService", thePlayer, timeR)
	 setTimer(function(thePlayer)
		setPedAnimation(thePlayer)
         local x,y,z = getElementPosition(thePlayer)
         CObject[thePlayer] = createObject(Object, x, y, z + 0.5 )
         setObjectScale(CObject[thePlayer],0.75)
         setElementCollisionsEnabled(CObject[thePlayer],false)
         attachElements(CObject[thePlayer],thePlayer,0,0.45,0.27,1,0,0)
		 setPedAnimation(thePlayer, "CARRY", "crry_prtial", 50, false, true, false, true)
		 timerC[thePlayer] = setTimer(deletObject, 2000, 100, thePlayer)
		 if not exports['bgo_items']:hasItemS(thePlayer, 234) then
		     exports['bgo_items']:giveItem(thePlayer, 234, 1, 1, 0, true)
		 end
		 setElementFrozen(thePlayer, false)
		 setElementData(thePlayer, "Object:Jobs", true)
	 end, timeR*1000, 1, thePlayer)		
end
function enterTruckCoca (player, seat, jacked)
     if exports['bgo_items']:hasItemS(player,  234) then
	     cancelEvent()
		 exports.bgo_hud:dm("Você não pode embarcar no carro com cocaina na mão.",player, 255, 255, 255)
	 end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterTruckCoca)

function exitObject (thePlayer)
     if isElement(CObject[thePlayer]) then
	     if exports['bgo_items']:hasItemS(thePlayer, 234) then
			 exports.bgo_hud:dm("Sua droga foi removida Motivo: (Saiu da area).",thePlayer, 255, 0, 0)
			 setPedAnimation(thePlayer)
			 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 234, false)
			 destroyElement(CObject[thePlayer])
			 setElementData(thePlayer, "Object:Jobs", false)
    		 if isTimer(timerC[thePlayer]) then
                 killTimer(timerC[thePlayer])	 
			 end
	   	 end
     end
end
addEventHandler("onColShapeLeave", CExzone, exitObject)

function deletObject (thePlayer)
     if not thePlayer then return end
     if not exports['bgo_items']:hasItemS(thePlayer, 234) then
		 if isTimer(timerC[thePlayer]) then
			 killTimer(timerC[thePlayer])	 
			 setPedAnimation(thePlayer)
			 setElementData(thePlayer, "Object:Jobs", false)
		 end
		 if isElement(CObject[thePlayer]) then
			 destroyElement(CObject[thePlayer])
			 setElementData(thePlayer, "Object:Jobs", false)
		 end			 
	 end
end

addEventHandler("onPlayerQuit", root,
function ()
		 if isTimer(timerC[source]) then
             killTimer(timerC[source])	 
		 end
		 if isElement(CObject[source]) then
			 destroyElement(CObject[source])
			 setElementData(thePlayer, "Object:Jobs", false)
		 end
end)

------------------------------------------- PROCESSADORES COCAINA

local processCocaina = createColSphere (840.019, -2050.933, 12.826, 3)
local processOpCocaina = false
local contagem = {}
local CObejct = {}
local markC = {}
local timerFC = {}
local loopC = {}
local loopCN = {}
local loopCTC = {}

addEventHandler("onColShapeHit", processCocaina, function (thePlayer)
	local prTeam = getTeamFromName ( "Policia" )
	local prCount = countPlayersInTeam ( prTeam )
     if prCount >= policia then
     if exports['bgo_items']:hasItemS(thePlayer, 234) then
	     exports.bgo_hud:dm("Pressione [E] Para iniciar o processamento.",thePlayer, 255, 50, 70)
		 bindKey(thePlayer, "e", "down", startTheProcess)
	     else
		 exports.bgo_hud:dm("Você não possui a droga indicada 'Cocaina'.",thePlayer, 255, 0, 0)
	 end
	 else
	 exports.bgo_hud:dm("Para iniciar o serviço necessita de 10 Policias Rodoviários.",thePlayer, 255, 255, 255)
	 end
end)

addEventHandler("onColShapeLeave", processCocaina, function (thePlayer)
	 unbindKey(thePlayer, "e", "down", startTheProcess)
end)

function startTheProcess (thePlayer)
     if isElementWithinColShape ( thePlayer, processCocaina) then
	 
     local xS,yS,zS = getElementPosition(thePlayer)
	 if (zS) then
	     local zX = math.floor(zS)
		 if (zX ~= 12) then
		     exports.bgo_hud:dm("Desça da mesa para processar a droga.",thePlayer, 255, 255, 255)
		     return
		 end
	 end
	 
	     if exports['bgo_items']:hasItemS(thePlayer, 234) then
		     unbindKey(thePlayer, "e", "down", startTheProcess)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setElementFrozen(thePlayer, true)
		     exports.bgo_hud:dm("Processamento iniciando em breve, Aguarda.",thePlayer, 255, 255, 255)
			 contagem[thePlayer] = 0
			 --setTimer(execProcessCoca, 2000, 1, thePlayer)
			 contagemDeCocaina (thePlayer)
		 end
	 end
end

function contagemDeCocaina (thePlayer)
     if exports['bgo_items']:hasItemS(thePlayer, 234) then 
	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 234, false)
		 contagem[thePlayer] = contagem[thePlayer] + 1
		 --contagemDeCocaina (thePlayer)
		 setTimer(contagemDeCocaina, 1000, 1, thePlayer)
         else
		 execProcessCoca (thePlayer)
         return		 
	 end
end

function execProcessCoca (thePlayer)
setElementData(thePlayer, "setCocain", contagem[thePlayer])
 loopC[thePlayer] = getElementData(thePlayer, "setCocain") or 0
     loopCN[thePlayer] = tonumber(loopC[thePlayer])
	 outputDebugString("O valor de cocaina foi de "..loopC[thePlayer])
	 exports['bgo_items']:giveItem(thePlayer, 234, 1, loopCN[thePlayer], 0, true)
     if contagem[thePlayer] then
		 setTimer(function(thePlayer)
             if not exports['bgo_items']:hasItemS(thePlayer, 234) then			 
				     setElementData(thePlayer, "Object:Jobs", false)
					 setElementFrozen(thePlayer, false)
				     exports.bgo_hud:dm("Processamento encerrado... Vá até o outro lado da maquina para pegar a droga refinada.",thePlayer, 255, 255, 255)	
                     return								 
			 end
	         exports.bgo_hud:dm("Processamento iniciando, Não saia do local.",thePlayer, 255, 255, 255)
			 setElementData(thePlayer, "Object:Jobs", true)
		     triggerClientEvent(thePlayer, "progressService", thePlayer, 5)
		     CObejct[thePlayer] = createObject(1578, 839.876, -2051.453, 12.847)
	         moveObject(CObejct[thePlayer], 5000, 839.961, -2056.094, 12.847)
		     if isElement(CObejct[thePlayer]) then
			     setTimer(destroyElement, 4900, 1,CObejct[thePlayer])
				 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 234, false)
			 end
		 end, 5100, loopCN[thePlayer] + 1, thePlayer)
	 end
end

markC = createMarker(838.74, -2060.165, 11.955, "cylinder", 1.1, 255, 0, 0, 100)

function takeDroga3 (thePlayer)
     if (getElementData(thePlayer, "setCocain")) then
	 loopCTC[thePlayer] = getElementData(thePlayer, "setCocain") or 0
	     if not exports['bgo_items']:hasItemS(thePlayer, 234) then
             timerFC[thePlayer] = 0
		     exports.bgo_hud:dm("Droga refinada com sucesso "..(getElementData(thePlayer, "setCocain") or 0)..".",thePlayer, 255, 255, 255)
			 exports.bgo_hud:dm("Você pode perder suas drogas caso a conexão com o servidor seja perdida.",thePlayer, 255, 0, 0)
			 setElementFrozen(thePlayer, true)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setTimer(function(thePlayer)
			     timerFC[thePlayer] = timerFC[thePlayer] + 1
			     exports['bgo_items']:giveItem(thePlayer, 233, 1, 1, 0, true)
				 setElementData(thePlayer, "setCocain", false)
				 if exports['bgo_items']:hasItemS(thePlayer, 233) then
                     if (loopCTC[thePlayer] == timerFC[thePlayer]) then
					     exports.bgo_hud:dm("Finalziado com sucesso pode se retirar.",thePlayer, 255, 255, 255)
					     timerFC[thePlayer] = 0
			             setElementFrozen(thePlayer, false)
			             setElementData(thePlayer, "Object:Jobs", false)
					 end
				 end
			 end, 1000, loopCTC[thePlayer], thePlayer)
		 end
	 end
end
addEventHandler("onMarkerHit", markC, takeDroga3)






local processCocaina2 = createColSphere (845.047, -2051.809, 12.826, 3)
local processOpCocaina2 = false
local contagem2 = {}
local CObejct2 = {}
local markC2 = {}
local timerFC2 = {}
local loopC2 = {}
local loopCN2 = {}
local loopCTC2 = {}

addEventHandler("onColShapeHit", processCocaina2, function (thePlayer)
	local prTeam = getTeamFromName ( "Policia" )
	local prCount = countPlayersInTeam ( prTeam )
     if prCount >= policia then
     if exports['bgo_items']:hasItemS(thePlayer, 233) then
	     exports.bgo_hud:dm("Pressione [E] Para iniciar o processamento.",thePlayer, 255, 50, 70)
		 bindKey(thePlayer, "e", "down", startTheProcess2)
	     else
		 exports.bgo_hud:dm("Você não possui a droga indicada 'Pasta Base'.",thePlayer, 255, 0, 0)
	 end
	 else
	 exports.bgo_hud:dm("Para iniciar o serviço necessita de 10 Policias Rodoviários.",thePlayer, 255, 255, 255)
	 end
end)

addEventHandler("onColShapeLeave", processCocaina2, function (thePlayer)
	 unbindKey(thePlayer, "e", "down", startTheProcess2)
end)

function startTheProcess2 (thePlayer)
     if isElementWithinColShape ( thePlayer, processCocaina2) then
	 
     local xS,yS,zS = getElementPosition(thePlayer)
	 if (zS) then
	     local zX = math.floor(zS)
		 if (zX ~= 12) then
		     exports.bgo_hud:dm("Desça da mesa para processar a droga.",thePlayer, 255, 255, 255)
		     return
		 end
	 end
	 
	     if exports['bgo_items']:hasItemS(thePlayer, 233) then
		     unbindKey(thePlayer, "e", "down", startTheProcess2)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setElementFrozen(thePlayer, true)
		     exports.bgo_hud:dm("Processamento iniciando em breve, Aguarda.",thePlayer, 255, 255, 255)
			 contagem2[thePlayer] = 0
			 --setTimer(execProcessCoca2, 2000, 1, thePlayer)
			 contagemDeCocaina2 (thePlayer)
		 end
	 end
end

function contagemDeCocaina2 (thePlayer)
     if exports['bgo_items']:hasItemS(thePlayer, 233) then 
	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 233, false)
		 contagem2[thePlayer] = contagem2[thePlayer] + 1
		 --contagemDeCocaina2 (thePlayer)
		 setTimer(contagemDeCocaina2, 1000, 1, thePlayer)
         else
		 execProcessCoca2 (thePlayer)
         return		 
	 end
end

function execProcessCoca2 (thePlayer)
setElementData(thePlayer, "setPaste", contagem2[thePlayer])
 loopC2[thePlayer] = getElementData(thePlayer, "setPaste") or 0
     loopCN2[thePlayer] = tonumber(loopC2[thePlayer])
	 outputDebugString("O valor de cocaina foi de "..loopC2[thePlayer])
	 exports['bgo_items']:giveItem(thePlayer, 233, 1, loopCN2[thePlayer], 0, true)
     if contagem2[thePlayer] then
		 setTimer(function(thePlayer)
             if not exports['bgo_items']:hasItemS(thePlayer, 233) then			 
				     setElementData(thePlayer, "Object:Jobs", false)
					 setElementFrozen(thePlayer, false)
				     exports.bgo_hud:dm("Processamento encerrado... Vá até o outro lado da maquina para pegar a droga refinada.",thePlayer, 255, 255, 255)	
                     return								 
			 end
			 setElementData(thePlayer, "Object:Jobs", true)
		     triggerClientEvent(thePlayer, "progressService", thePlayer, 5)

		         CObejct2[thePlayer] = createObject(1575 ,845.047, -2051.809, 12.826)
	             moveObject(CObejct2[thePlayer], 5000, 845.047, -2056.094, 12.847)
				 exports.bgo_hud:dm("Processamento iniciando, Não saia do local.",thePlayer, 255, 255, 255)
			 
		     if isElement(CObejct2[thePlayer]) then
				 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 233, false)
				 setTimer(destroyElement, 4900, 1,CObejct2[thePlayer])
			 end
		 end, 5100, loopCN2[thePlayer] + 1, thePlayer)
	 end
end

markC2 = createMarker(846.785, -2060.185, 11.955, "cylinder", 1.1, 255, 0, 0, 100)

function takeDroga2 (thePlayer)
     if (getElementData(thePlayer, "setPaste")) then
	  loopCTC2[thePlayer] = getElementData(thePlayer, "setPaste") or 0
	  loopCTC2[thePlayer] =  loopCTC2[thePlayer] * 5
	     if not exports['bgo_items']:hasItemS(thePlayer, 233) then
             timerFC2[thePlayer] = 0
		     exports.bgo_hud:dm("Droga refinada com sucesso "..(loopCTC2[thePlayer])..".",thePlayer, 255, 255, 255)
			 exports.bgo_hud:dm("Você pode perder suas drogas caso a conexão com o servidor seja perdida.",thePlayer, 255, 0, 0)
			 setElementFrozen(thePlayer, true)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setTimer(function(thePlayer)
			     timerFC2[thePlayer] = timerFC2[thePlayer] + 1
			     exports['bgo_items']:giveItem(thePlayer, 14, 1, loopCTC2[thePlayer], 0, false)
				 setElementData(thePlayer, "setPaste", false)
					     exports.bgo_hud:dm("Finalziado com sucesso pode se retirar.",thePlayer, 255, 255, 255)
					     timerFC2[thePlayer] = 0
			             setElementFrozen(thePlayer, false)
			             setElementData(thePlayer, "Object:Jobs", false)
			 end, 1000, 1, thePlayer)
		 end
	 end
end
addEventHandler("onMarkerHit", markC2, takeDroga2)