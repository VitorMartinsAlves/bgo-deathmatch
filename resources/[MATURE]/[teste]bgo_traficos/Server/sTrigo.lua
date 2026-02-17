local farmTrigo = createColCuboid(-374.52991, -1438.51367, 23.52661, 12.186553955078, 6.836669921875, 7.9)
local zone = createColCuboid(-416.28134, -1473.95154, 23.09867, 54.827545166016, 64.978515625, 28.9)

local Trigo = {}
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

     if isElement(Trigo[thePlayer]) then
	     exports.bgo_hud:dm("Leve a Trigo até o caminhão.",thePlayer, 255, 255, 255)
	 else
	     exports.bgo_hud:dm("Pressione [E] para iniciar a colheita.",thePlayer, 255, 255, 255)
	     bindKey(thePlayer, "e", "down", startTheFunctionCTrigo)
	 end
end
addEventHandler("onColShapeHit", farmTrigo, enterZone)

function startTheFunctionCTrigo (thePlayer)

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
	 
     if not isElement(Trigo[thePlayer]) then
	     unbindKey(thePlayer, "e", "down", startTheFunctionCTrigo)
	     setElementFrozen(thePlayer, true)
	     setPedAnimation( thePlayer, "bomber", "bom_plant_loop", 50, false, true, false, true)
		 triggerClientEvent(thePlayer, "progressService", thePlayer, 10)
		 if not exports['bgo_items']:hasItemS(thePlayer, 237) then
			 exports['bgo_items']:giveItem(thePlayer, 237, 1, 1, 0, false)
		 end
		 timerex[thePlayer] = setTimer(
		 function ()
		     local x,y,z = getElementPosition(thePlayer)
		     setPedAnimation( thePlayer )
			 Trigo[thePlayer] = createObject(3374,x,y,z)
			 setElementCollisionsEnabled(Trigo[thePlayer],false)
			 setObjectScale(Trigo[thePlayer],0.13)
			 attachElements(Trigo[thePlayer],thePlayer,0,0.45,0.45,1,0,0)
			 setElementFrozen(thePlayer, false)
			 setElementData(thePlayer, "Object:Jobs", true)
			 setPedAnimation(thePlayer, "CARRY", "crry_prtial", 50, false, true, false, true)
			 exports.bgo_hud:dm("Leve a Trigo até o seu caminhão.",thePlayer, 255, 255, 255)
			 timerde[thePlayer] = setTimer(deletObj, 1000, 100, thePlayer)
		 end, 10000, 1)
	 end
end

function exitObjectCTrigo (thePlayer)
	 if isElement(Trigo[thePlayer]) then
	     if exports['bgo_items']:hasItemS(thePlayer, 237) then
		     if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end		
             if isElement(Trigo[thePlayer]) then
			     destroyElement(Trigo[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
				 exports.bgo_hud:dm("Trigo removida pelo motivo que você saiu da zona.",thePlayer, 255, 255, 255)
				 if exports['bgo_items']:hasItemS(thePlayer, 237) then
				     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 237, false)
				 end
				 unbindKey(thePlayer, "e", "down", startTheFunctionCTrigo)
             end	
		 end
     end
end
addEventHandler("onColShapeLeave", zone, exitObjectCTrigo)

function deletObj (thePlayer)
     if thePlayer then
	     if not isElementWithinColShape ( thePlayer, zone) then
		     if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end		
             if isElement(Trigo[thePlayer]) then
			     destroyElement(Trigo[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
				 if exports['bgo_items']:hasItemS(thePlayer, 237) then
				     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 237, false)
				 end
             end	
		 end
	     if not exports['bgo_items']:hasItemS(thePlayer, 237) then
		     if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end
			 if isTimer(timerex[thePlayer]) then
			     killTimer(timerex[thePlayer])
			 end
			 if isTimer(timerde[thePlayer]) then
			     killTimer(timerde[thePlayer])
			 end		
             if isElement(Trigo[thePlayer]) then
			     destroyElement(Trigo[thePlayer])
				 setElementData(thePlayer, "Object:Jobs", false)
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
             if isElement(Trigo[source]) then
			     destroyElement(Trigo[source])
				 setElementData(source, "Object:Jobs", false)
             end	
end)