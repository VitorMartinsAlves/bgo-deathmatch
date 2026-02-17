db = dbConnect("sqlite", "database.db") or 0

local trigo = createBlip(-374.889, -1442.811, 25.727, 37)
setElementData(trigo ,"blipName", "Campo de Trigo")

local laranja = createBlip(-2069.132, -2533.326, 36.427, 37)
setElementData(laranja ,"blipName", "Campo de Laranja")

local madeira = createBlip(-2042.498, -2383.607, 38.427, 37)
setElementData(madeira ,"blipName", "Campo de Madeira")

local D1zone = createColCuboid(2307.53467, 2775.40674, 8.62660, 9.524658203125, 7.590576171875, 9.9)
local D2zone = createColCuboid(2307.54932, 2755.75439, 9.12662, 9.77587890625, 10.417236328125, 9.9)
local D3zone = createColCuboid(2307.89014, 2738.33667, 8.82667, 9.233642578125, 11.0830078125, 10.500014686584)

local Value = {}	
local Merca = {}
local rotLZ = {}
local rotLS = {}
local timLR = {}
local timerContL = {}
local contagemLV = {}
local barTimeL = {}
local barTimeT = {}
local barTimeM2 = {}
local contagemTimer = {}
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




function removeBindKeyMaco (thePlayer)
     unbindKey(thePlayer, "e", "down", startTheFunctionMaco)
	 setElementData(thePlayer, "enterZone:Maconha", false)
end




function enterDZL (thePlayer)
if not thePlayer then return end
     if getElementType(thePlayer) == "player" then 
    local theVehicle = getPedOccupiedVehicle ( thePlayer )
	 if theVehicle then
		if getElementType (theVehicle) == "vehicle" then

			--local driver = getVehicleController ( theVehicle )
			controller = getVehicleController ( theVehicle ) 
			if controller == thePlayer then 


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


	 if not exports['bgo_items']:hasItemS(theVehicle, 235) then
	     exports.bgo_hud:dm("Esta vaga é reservada apenas para Laranja.",thePlayer, 255, 255, 255)
	     return
	 end
	 rotLZ[thePlayer] = getElementRotation(theVehicle)
	     if (rotLZ[thePlayer]) then
		     rotLS[thePlayer] = math.floor(rotLZ[thePlayer])
			-- if (rotLS[thePlayer] == 359 or rotLS[thePlayer] == 358 or rotLS[thePlayer]== 360 or rotLS[thePlayer] == 357 or rotLS[thePlayer] == 351) then
			 --    exports.bgo_hud:dm("O veiculo precisa estar estacionado de ré",thePlayer, 255, 255, 255)
			--	 return
			-- else
			         if exports['bgo_items']:hasItemS(theVehicle, 235) then
					     setElementData(thePlayer, "venderDrogas", true)
				         exports.bgo_hud:dm("Descarregamento iniciando, Aguarda um momento.",thePlayer, 255, 255, 255)
						 setElementFrozen(theVehicle, true)
						 contagemLV[thePlayer] = 0
						 setElementData(theVehicle, "vehFrozen", true)
						 setElementData(thePlayer, "infoContagem", true)
						 contagemDL (thePlayer, theVehicle)
				     else
					 end
				 end
				end
			 end
		 end
	 end
end
addEventHandler("onColShapeHit", D1zone, enterDZL)

function exitTruckHero (player, seat, jacked)
     if (getElementData(player, "venderDrogas") == true) then
	     cancelEvent()
		 exports.bgo_hud:dm("Aguarde a venda acabar para se retirar.",player, 255, 255, 255)
	 end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitTruckHero)

function contagemDL (thePlayer, theTruck)
if not thePlayer then return end
     if exports['bgo_items']:hasItemS(theTruck, 235) then 
	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 235, false)
		 contagemLV[thePlayer] = contagemLV[thePlayer] + 1
		 contagemTimer[thePlayer] = setTimer(contagemDL, 1000, 1,thePlayer, theTruck)
         else
		 setElementData(thePlayer, "infoContagem", false)
         setTimer(contagemVehicleL, 2000, 1, thePlayer, theTruck)
		 barTimeL[thePlayer] = contagemLV[thePlayer] * 1
		 if barTimeL[thePlayer] > 1 then
		 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeL[thePlayer] - 2)
		 else
		 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeL[thePlayer])
		 end
		 setTimer( outputDebugString, 2000, 1, "O valor de Carga é de "..contagemLV[thePlayer])
		 setTimer(finishServiceL, contagemLV[thePlayer] * 1000, 1, thePlayer, theTruck) 
		 if isTimer(contagemTimer[thePlayer]) then
		     killTimer(contagemTimer[thePlayer])
		 end
	 end
end

function contagemVehicleL (thePlayer, theTruck)
if not thePlayer then return end
     if exports['bgo_items']:hasItemS(theTruck, 235) then 
	 exports['bgo_items']:giveItem(theTruck, 235, 1, contagemLV[thePlayer], 0, false)
         timerContL[thePlayer] = setTimer(function (thePlayer, theTruck)
		 setElementFrozen(theTruck, true)
         triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 235, false)
		 contagemLV[thePlayer] = contagemLV[thePlayer] + 1
		 end, contagemLV[thePlayer]*1000, 1, thePlayer)
	 end
end


function finishServiceL (thePlayer, theTruck)
if not thePlayer then return end
if not getElementData(thePlayer, "loggedin") then return end
 	 if not exports['bgo_items']:hasItemS(theTruck, 235) then 
	     if getElementType (theTruck) == "vehicle" then
    		 exports.bgo_hud:dm("Descarregamento finalizado com sucesso.",thePlayer, 255, 255, 255)
    		 exports.bgo_hud:dm("Valor descarregado "..contagemLV[thePlayer]..".",thePlayer, 255, 255, 255)
     		 setElementFrozen(theTruck, false)
			 if isTimer(timerContL[thePlayer]) then
    		     killTimer(timerContL[thePlayer])
			 end
    		 Merca[thePlayer] = "LARANJA"
    		 -- buyCarga (thePlayer, theTruck)
    		 setElementData(thePlayer, "venderDrogas", false)
			 setElementData(thePlayer, "infoContagem", false)
             local BHcoc = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", "LARANJA")
             local BresultH = dbPoll(BHcoc, -1)  
             if #BresultH ~= 0 then
		     	 Value[thePlayer] = BresultH[1]["VALOR"] * contagemLV[thePlayer]
		    	 setElementData(thePlayer, "char:money", (getElementData(thePlayer, "char:money") or 0) + Value[thePlayer])
             end
		 end
	 end
end

local rotMZ = {}
local rotMS = {}
local timMR = {}
local timerContM = {}
local contagemMV2 = {}

function enterDZM (thePlayer)
if not thePlayer then return end
     if getElementType(thePlayer) == "player" then 
     local theVehicle = getPedOccupiedVehicle ( thePlayer )
	     if theVehicle then
		 if getElementType(theVehicle) == "vehicle" then 

			controller = getVehicleController ( theVehicle ) 
			if controller == thePlayer then 

			local driver = getVehicleOccupant ( theVehicle ) -- get the player sitting in seat 0
			if not driver == 0 then 
				exports.bgo_hud:dm("Só quem ta no volante pode vender a mercadoria!",thePlayer, 255, 255, 255)
			return 
			end
			
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
	 if hours < 16 then
	     outputChatBox("#7cc576[BGO ERROR]: #FFFFFFHorário disponivel: (16 Hrs ás 00 Hrs).", thePlayer, 255,255,255, true)	
		 return
     end



	     rotMZ[thePlayer] = getElementRotation(theVehicle)
	     if not exports['bgo_items']:hasItemS(theVehicle, 236) then
	         exports.bgo_hud:dm("Esta vaga é reservada apenas para Madeiras.",thePlayer, 255, 255, 255)
	         return
	     end
	     if (rotMZ[thePlayer]) then
		     rotMS[thePlayer] = math.floor(rotMZ[thePlayer])
			         if exports['bgo_items']:hasItemS(theVehicle, 236) then
					     setElementData(thePlayer, "venderDrogas", true)
				         exports.bgo_hud:dm("Descarregamento iniciando, Aguarda um momento.",thePlayer, 255, 255, 255)
						 setElementFrozen(theVehicle, true)
						 contagemMV2[thePlayer] = 0
						 setElementData(theVehicle, "vehFrozen", true)
						 contagemDM (thePlayer, theVehicle)
						 setElementData(thePlayer, "infoContagem", true)
				     else
					 end
				 end
				end
			 end
		 end
	 end
end
addEventHandler("onColShapeHit", D2zone, enterDZM)

function contagemDM (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 236) then 
     	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 236, false)
    		 contagemMV2[thePlayer] = contagemMV2[thePlayer] + 1
    		 contagemTimer[thePlayer] = setTimer(contagemDM, 1000, 1,thePlayer, theTruck)
             else
			 setElementData(thePlayer, "infoContagem", false)
             setTimer(contagemVehicleM, 2000, 1, thePlayer, theTruck)
   			 barTimeM2[thePlayer] = contagemMV2[thePlayer] * 1
			 if barTimeM2[thePlayer] > 1 then
			 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeM2[thePlayer]-2)
			 end
			 setTimer( outputDebugString, 2000, 1, "O valor de Carga é de "..contagemMV2[thePlayer])
			 setTimer(finishServiceM2, contagemMV2[thePlayer] * 1000, 1, thePlayer, theTruck)		
             if isTimer(contagemTimer[thePlayer]) then
			     killTimer(contagemTimer[thePlayer])
             end			 
		 end
	 end
end

function contagemVehicleM (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 236) then 
     	     exports['bgo_items']:giveItem(theTruck, 236, 1, contagemMV2[thePlayer], 0, false)
             timerContM[thePlayer] = setTimer(function (thePlayer, theTruck)
    		 setElementFrozen(theTruck, true)
             triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 236, false)
    		 contagemMV2[thePlayer] = contagemMV2[thePlayer] + 1
    		 end, contagemMV2[thePlayer]*1000, 1, thePlayer)
		 end
	 end
end

function finishServiceM2 (thePlayer, theTruck)
if not thePlayer then return end
if not getElementData(thePlayer, "loggedin") then return end
     if getElementType(theTruck) == "vehicle" then 
 	     if not exports['bgo_items']:hasItemS(theTruck, 236) then 
     		 exports.bgo_hud:dm("Descarregamento finalizado com sucesso.",thePlayer, 255, 255, 255)
      		 exports.bgo_hud:dm("Valor descarregado "..contagemMV2[thePlayer]..".",thePlayer, 255, 255, 255)
     		 setElementFrozen(theTruck, false)
    		 Merca[thePlayer] = "MADEIRA"
    		 -- buyCarga (thePlayer, theTruck)
     		 setElementData(thePlayer, "venderDrogas", false)
			 setElementData(thePlayer, "infoContagem", false)
             local MHcoc = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", "MADEIRA")
             local BresultM = dbPoll(MHcoc, -1)  
             if #BresultM ~= 0 then
		     	 Value[thePlayer] = BresultM[1]["VALOR"] * contagemMV2[thePlayer]
		    	 setElementData(thePlayer, "char:money", (getElementData(thePlayer, "char:money") or 0) + Value[thePlayer])
			 end
   		 end
	 end
end

local rotTZ = {}
local rotTS = {}
local timTR = {}
local timerContT = {}
local contagemTV = {}

function enterDZT (thePlayer)
if not thePlayer then return end
     if getElementType(thePlayer) == "player" then 
     local theVehicle = getPedOccupiedVehicle ( thePlayer )
	 if theVehicle then
	 if getElementType(theVehicle) == "vehicle" then 
		controller = getVehicleController ( theVehicle ) 
		if controller == thePlayer then 

		 local prTeam = getTeamFromName ( "PR" )
         local prCount = countPlayersInTeam ( prTeam )
    --         if prCount >= 6 then
	--		     exports.bgo_hud:dm("Este serviço só pode ser executado com 6 Policias Rodoviário.",thePlayer, 255, 255, 255)
	--	     return
	--	 end
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
	 if hours < 16 then
	     outputChatBox("#7cc576[BGO ERROR]: #FFFFFFHorário disponivel: (16 Hrs ás 00 Hrs).", thePlayer, 255,255,255, true)	
		 return
     end


	 if not exports['bgo_items']:hasItemS(theVehicle, 237) then
	     exports.bgo_hud:dm("Esta vaga é reservada apenas para Trigo.",thePlayer, 255, 255, 255)
	     return
	 end

			         if exports['bgo_items']:hasItemS(theVehicle, 237) then
				         exports.bgo_hud:dm("Descarregamento iniciando, Aguarda um momento.",thePlayer, 255, 255, 255)
						 setElementFrozen(theVehicle, true)
						 contagemTV[thePlayer] = 0
						 setElementData(theVehicle, "vehFrozen", true)
						 contagemTC (thePlayer, theVehicle)
						 setElementData(thePlayer, "infoContagem", true)
						 setElementData(thePlayer, "venderDrogas", true)
				     else
					end
				 end
			 end
		 end
	 end
end
addEventHandler("onColShapeHit", D3zone, enterDZT)

function contagemTC (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 237) then 
     	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 237, false)
			  contagemTV[thePlayer] = contagemTV[thePlayer] + 1
			  contagemTimer[thePlayer] = setTimer(contagemTC, 1000, 1, thePlayer, theTruck)
     		 --contagemTC (thePlayer, theTruck)
             else
             barTimeT[thePlayer] = contagemTV[thePlayer] * 1
			 if barTimeT[thePlayer] > 1 then
			 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeT[thePlayer] - 2)
			 end
			 setElementData(thePlayer, "infoContagem", false)
			 setTimer( outputDebugString, 2000, 1, "O valor de Carga é de "..contagemTV[thePlayer])
			 setTimer(finishServiceT, contagemTV[thePlayer] * 1000, 1, thePlayer, theTruck)
             setTimer(contagemVehicleT, 2000, 1, thePlayer, theTruck)	
             if isTimer(contagemTimer[thePlayer]) then
			     killTimer(contagemTimer[thePlayer])
             end			 
		 end
	 end
end

function contagemVehicleT (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 237) then 
         	 exports['bgo_items']:giveItem(theTruck, 237, 1, contagemTV[thePlayer], 0, false)
             timerContT[thePlayer] = setTimer(function (thePlayer, theTruck)
    		 setElementFrozen(theTruck, true)
             triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 237, false)
    		 contagemTV[thePlayer] = contagemTV[thePlayer] + 1
    		 end, contagemTV[thePlayer]*1000, 1, thePlayer)
		 end
	 end
end

function finishServiceT (thePlayer, theTruck) 
if not thePlayer then return end
if not getElementData(thePlayer, "loggedin") then return end
     if getElementType(theTruck) == "vehicle" then 
     	 if not exports['bgo_items']:hasItemS(theTruck, 237) then 
    		 exports.bgo_hud:dm("Descarregamento finalizado com sucesso.",thePlayer, 255, 255, 255)
    		 exports.bgo_hud:dm("Valor descarregado "..contagemTV[thePlayer]..".",thePlayer, 255, 255, 255)
     		 setElementFrozen(theTruck, false)
     		 Merca[thePlayer] = "TRIGO"
    		 -- buyCarga (thePlayer, theTruck)
     		 setElementData(thePlayer, "venderDrogas", false)
			 setElementData(thePlayer, "infoContagem", false)
             local Bcoc = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", "TRIGO")
             local BresultC = dbPoll(Bcoc, -1)  
			 if BresultC ~= 0 then
		     	 Value[thePlayer] = BresultC[1]["VALOR"] * contagemTV[thePlayer]
		    	 setElementData(thePlayer, "char:money", (getElementData(thePlayer, "char:money") or 0) + Value[thePlayer])	 
			 end
		 end
	 end
end