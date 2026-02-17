local farmMadeira = createColSphere (-2043.786, -2385.561, 30.632, 25)

local Madeira = {}
local timerex = {}
local timerdes = {}
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

     if isElement(Madeira[thePlayer]) then
	     exports.bgo_hud:dm("Leve a Madeira até o caminhão.",thePlayer, 255, 255, 255)
	 else
	     exports.bgo_hud:dm("Pressione [E] para iniciar a colheita.",thePlayer, 255, 255, 255)
	     bindKey(thePlayer, "e", "down", startTheFunctionCMadeira)
	 end
end
addEventHandler("onColShapeHit", farmMadeira, enterZone)

function startTheFunctionCMadeira (thePlayer)

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
	 
     if not isElement(Madeira[thePlayer]) then
	     unbindKey(thePlayer, "e", "down", startTheFunctionCMadeira)
	     setElementFrozen(thePlayer, true)
	     setPedAnimation( thePlayer, "bomber", "bom_plant_loop", 50, false, true, false, true)
		 triggerClientEvent(thePlayer, "progressService", thePlayer, 10)
		 if not exports['bgo_items']:hasItemS(thePlayer, 236) then
			 exports['bgo_items']:giveItem(thePlayer, 236, 1, 1, 0, false)
		 end
		 timerex[thePlayer] = setTimer(
		 function ()
		     local x,y,z = getElementPosition(thePlayer)
		     setPedAnimation( thePlayer )
			 Madeira[thePlayer] = createObject(1224,x,y,z)
			 setElementCollisionsEnabled(Madeira[thePlayer],false)
			 setObjectScale(Madeira[thePlayer],0.4)
			 attachElements(Madeira[thePlayer],thePlayer,0,0.45,0.45,1,0,0)
			 setElementFrozen(thePlayer, false)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setPedAnimation(thePlayer, "CARRY", "crry_prtial", 50, false, true, false, true)
			 exports.bgo_hud:dm("Leve a Madeira até o seu caminhão.",thePlayer, 255, 255, 255)
			 timerdes[thePlayer] = setTimer(deletobjs, 1000, 100, thePlayer)
		 end, 10000, 1)
	 end
end

function exitObjectCMadeira (thePlayer)
	 if isElement(Madeira[thePlayer]) then
	     if exports['bgo_items']:hasItemS(thePlayer, 236) then
		     if isTimer(timerdes[thePlayer]) then
			     killTimer(timerdes[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerdes[thePlayer]) then
			     killTimer(timerdes[thePlayer])
			 end		
             if isElement(Madeira[thePlayer]) then
			     destroyElement(Madeira[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
				 exports.bgo_hud:dm("Madeira removida pelo motivo que você saiu da zona.",thePlayer, 255, 255, 255)
				 if exports['bgo_items']:hasItemS(thePlayer, 236) then
				     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 236, false)
				 end
				 unbindKey(thePlayer, "e", "down", startTheFunctionCMadeira)
             end	
		 end
     end
end
addEventHandler("onColShapeLeave", farmMadeira, exitObjectCMadeira)

function deletobjs (thePlayer)
	     if not exports['bgo_items']:hasItemS(thePlayer, 236) then
		     if isTimer(timerdes[thePlayer]) then
			     killTimer(timerdes[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerdes[thePlayer]) then
			     killTimer(timerdes[thePlayer])
			 end		
             if isElement(Madeira[thePlayer]) then
			     destroyElement(Madeira[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)	 
		 end
	 end
	     if not isElementWithinColShape ( thePlayer, farmMadeira) then
		     if isTimer(timerdes[thePlayer]) then
			     killTimer(timerdes[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerdes[thePlayer]) then
			     killTimer(timerdes[thePlayer])
			 end		
             if isElement(Madeira[thePlayer]) then
			     destroyElement(Madeira[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
				 if exports['bgo_items']:hasItemS(thePlayer, 236) then
				     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 236, false)
				 end
             end	
		 end
end

addEventHandler("onPlayerQuit", root,
function ()
		     if isTimer(timerdes[source]) then
			     killTimer(timerdes[source])
			 end
			 if isTimer(timerex[source]) then
			     killTimer(timerex[source])
			 end
			 if isTimer(timerdes[source]) then
			     killTimer(timerdes[source])
			 end		
             if isElement(Madeira[source]) then
			     destroyElement(Madeira[source])
				 setElementData(source, "Object:Jobs", false)	 
		 end
end)