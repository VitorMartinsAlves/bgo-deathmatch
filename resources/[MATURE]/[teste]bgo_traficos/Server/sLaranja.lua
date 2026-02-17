local farmLaranja = createColSphere (-2065.334, -2535.109, 30.396, 40)

local laranja = {}
local timerex = {}
local timerde = {}
local day = {}

daysemana = {
     {1, "segunda"},
	 {2, "terça"},
	 {3, "quarta"},
	 {4, "quinta"},
	 {5, "sexta"},
	 {6, "sábado"},
	 {0, "domingo"},
}

function enterZone (thePlayer)

     local time = getRealTime()
	 
     local monthday = time.monthday
	 local month = time.month
	 local year = time.year
	 
	 local hours = time.hour
	 
	 local yearday = time.yearday
	 local weekday = time.weekday
	 
     if weekday ~= 5 then
	     if weekday ~= 6 then
		     if weekday ~= 0 then
	             outputChatBox("#7cc576[BGO ERROR]: #FFFFFFServiço liberado apenas (Sexta - feira, Sábado e Domingo).", thePlayer, 255,255,255, true)	
                 return
			 end
		 end
	 end
	 if hours < 15 then
	     outputChatBox("#7cc576[BGO ERROR]: #FFFFFFHorário disponivel: (16 Hrs ás 00 Hrs).", thePlayer, 255,255,255, true)	
		 return
     end

     if isElement(laranja[thePlayer]) then
	     exports.bgo_hud:dm("Leve a Laranja até o caminhão.",thePlayer, 255, 255, 255)
	 else
	     exports.bgo_hud:dm("Pressione [E] para iniciar a colheita.",thePlayer, 255, 255, 255)
	     bindKey(thePlayer, "e", "down", startTheFunctionCLaranja)
	 end
end
addEventHandler("onColShapeHit", farmLaranja, enterZone)

function startTheFunctionCLaranja (thePlayer)
     local time = getRealTime()
	 
     local monthday = time.monthday
	 local month = time.month
	 local year = time.year
	 
	 local hours = time.hour
	 
	 local yearday = time.yearday
	 local weekday = time.weekday
	 
     for _,semana in pairs(daysemana) do
	     if weekday == semana[1] then
		     day = semana[2]
		 end
	 end
     
     if weekday ~= 5 then
	     if weekday ~= 6 then
		     if weekday ~= 0 then
	             outputChatBox("#7cc576[BGO ERROR]: #FFFFFFServiço liberado apenas (Sexta - feira, Sábado e Domingo).", thePlayer, 255,255,255, true)	
                 return
			 end
		 end
	 end
	 if hours < 15 then
	     outputChatBox("#7cc576[BGO ERROR]: #FFFFFFHorário disponivel: (16 Hrs ás 00 Hrs).", thePlayer, 255,255,255, true)	
		 return
     end
	 
     if not isElement(laranja[thePlayer]) then
	     unbindKey(thePlayer, "e", "down", startTheFunctionCLaranja)
	     setElementFrozen(thePlayer, true)
	     setPedAnimation( thePlayer, "bomber", "bom_plant_loop", 50, false, true, false, true)
		 triggerClientEvent(thePlayer, "progressService", thePlayer, 10)
		 if not exports['bgo_items']:hasItemS(thePlayer, 235) then
			 exports['bgo_items']:giveItem(thePlayer, 235, 1, 1, 0, false)
		 end
		 timerex[thePlayer] = setTimer(
		 function ()
		     local x,y,z = getElementPosition(thePlayer)
		     setPedAnimation( thePlayer )
			 laranja[thePlayer] = createObject(2060,x,y,z)
			 setElementCollisionsEnabled(laranja[thePlayer],false)
			 setObjectScale(laranja[thePlayer],1)
			 attachElements(laranja[thePlayer],thePlayer,0,0.45,0.37,1,0,0)
			 setElementFrozen(thePlayer, false)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setPedAnimation(thePlayer, "CARRY", "crry_prtial", 50, false, true, false, true)
			 exports.bgo_hud:dm("Leve a laranja até o seu caminhão.",thePlayer, 255, 255, 255)
			 timerde[thePlayer] = setTimer(deletlaranjaobj, 1000, 100, thePlayer)
		 end, 10000, 1)
	 end
end

function exitObjectCLaranja (thePlayer)
	 if isElement(laranja[thePlayer]) then
	     if exports['bgo_items']:hasItemS(thePlayer, 235) then
		     if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end		
             if isElement(laranja[thePlayer]) then
			     destroyElement(laranja[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
				 exports.bgo_hud:dm("Laranja removida pelo motivo que você saiu da zona.",thePlayer, 255, 255, 255)
				 triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 235, false)
				 unbindKey(thePlayer, "e", "down", startTheFunctionCLaranja)
             end	
		 end
     end
end
addEventHandler("onColShapeLeave", farmLaranja, exitObjectCLaranja)

function enterTruckHero (player, seat, jacked)
     if exports['bgo_items']:hasItemS(player, 235) or exports['bgo_items']:hasItemS(player, 236) or exports['bgo_items']:hasItemS(player, 237) then
	     cancelEvent()
		 exports.bgo_hud:dm("Você não pode embarcar no carro com esse item na mão.",player, 255, 255, 255)
	 end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterTruckHero)

function deletlaranjaobj (thePlayer)
	     if not exports['bgo_items']:hasItemS(thePlayer, 235) then
             if isElement(laranja[thePlayer]) then
			     destroyElement(laranja[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)	 
		     end
		     if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end		
	 end
	     if not isElementWithinColShape ( thePlayer, farmLaranja) then
		     if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end		
             if isElement(laranja[thePlayer]) then
			     destroyElement(laranja[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
				 if exports['bgo_items']:hasItemS(thePlayer, 235) then
				     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 235, false)
				 end
             end	
		 end
end

addEventHandler("onPlayerQuit", root,
function ()
		     if isTimer(timerde[source]) then
			     killTimer(timerde[source])
			 end
			 if isTimer(timerex[source]) then
			     killTimer(timerex[source])
			 end
			 if isTimer(timerde[source]) then
			     killTimer(timerde[source])
			 end		
             if isElement(laranja[source]) then
			     destroyElement(laranja[source])
				 setElementData(source, "Object:Jobs", false)	 
		 end
end)