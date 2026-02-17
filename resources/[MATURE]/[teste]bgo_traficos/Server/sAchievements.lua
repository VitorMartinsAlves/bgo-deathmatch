db = dbConnect("sqlite", "database.db") or 0

addEventHandler("onResourceStart", resourceRoot,
function()
    dbExec(db, "CREATE TABLE IF NOT EXISTS BOLSA ( ID INT, DROGA_NAME TEXT, VALOR INT, BOLSA INT)") 
	dbExec(db, "CREATE TABLE IF NOT EXISTS CBOLSA ( ID INT, CARGA_NAME TEXT, VALOR INT, BOLSA INT)") 
	dbExec(db, "CREATE TABLE IF NOT EXISTS UND ( NDROGA TEXT, UNIDADE INT, MAX INT)") 
end)

addEventHandler("onResourceStart", resourceRoot,
function()
	 if (db) then
			outputDebugString("* Banco de dados conectado dos tráficos conectado.")
		 else
     end
end)

function isTransporteService ()
--[[
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
				 return false
			 end
		 end	
	 end
	 if hours < 15 then
         return false
	 end
	 ]]--
	 return true
end


addEventHandler("onResourceStart", resourceRoot,
function()
	 if (db) then
         local mc = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", "MACONHA")
         local resultM = dbPoll(mc, -1)  
         if #resultM == 0 then    
             dbFree(dbQuery(db, "INSERT INTO BOLSA ( ID, DROGA_NAME, VALOR, BOLSA ) VALUES ( '1', 'MACONHA', '0', '200')"))
			 outputDebugString("* Banco de dados grupo da maconha criado com sucesso.")
         end     
         local he = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", "HEROINA")
         local resultH = dbPoll(he, -1)  
         if #resultH == 0 then    
             dbFree(dbQuery(db, "INSERT INTO BOLSA ( ID, DROGA_NAME, VALOR, BOLSA ) VALUES ( '2', 'HEROINA', '0', '200')"))
			 outputDebugString("* Banco de dados grupo da heroinaa criado com sucesso.")
         end  	
         local co = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", "COCAINA")
         local resultC = dbPoll(co, -1)  
         if #resultC == 0 then    
             dbFree(dbQuery(db, "INSERT INTO BOLSA ( ID, CARGA_NAME, VALOR, BOLSA ) VALUES ('3', 'COCAINA', '0', '200')"))
			 outputDebugString("* Banco de dados grupo da cocaina criado com sucesso.")
         end  
		 --[[
         local cto = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", "TRIGO")
         local resultCC = dbPoll(cto, -1)  
         if #resultCC == 0 then    
             dbFree(dbQuery(db, "INSERT INTO CBOLSA ( ID, CARGA_NAME, VALOR, BOLSA ) VALUES ('1', 'TRIGO', '0', '200')"))
			 outputDebugString("* Banco de dados grupo da TRIGO criado com sucesso.")
         end  
         local cmo = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", "MADEIRA")
         local resultCM = dbPoll(cmo, -1)  
         if #resultCM == 0 then    
             dbFree(dbQuery(db, "INSERT INTO CBOLSA ( ID, CARGA_NAME, VALOR, BOLSA ) VALUES ('2', 'MADEIRA', '0', '200')"))
			 outputDebugString("* Banco de dados grupo da MADEIRA criado com sucesso.")
         end  	
         local cao = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", "LARANJA")
         local resultCA = dbPoll(cao, -1)  
         if #resultCA == 0 then    
             dbFree(dbQuery(db, "INSERT INTO CBOLSA ( ID, CARGA_NAME, VALOR, BOLSA ) VALUES ('3', 'LARANJA', '0', '200')"))
			 outputDebugString("* Banco de dados grupo da LARANJA criado com sucesso.")
         end 


]]-- 		 
     end
end)

function getSQLConnection()
	if (db) then
		return db
	end
end


----------------------------------------------------------------------------------------------------------------------------------------------

local merca2 = createBlip(2307.297, 2757.511, 31.2, 51)
setElementData(merca2 ,"blipName", "Venda de Produtos")

local cocaina = createBlip(-556.115, 2592.925, 86.655, 37)
setElementData(cocaina ,"blipName", "Campo Cocaina")

local processcocaina = createBlip(835.049, -2054.897, 22.523, 37)
setElementData(processcocaina ,"blipName", "Process... cocaina")




local maconha = createBlip(1063.986, -330.112, 73.992, 37)
setElementData(maconha ,"blipName", "Campo Maconha")


local processmaconha = createBlip(-1496.003, 1198.892, 13.179, 37)
setElementData(processmaconha ,"blipName", "Process... Maconha")

local processmaconha = createBlip(-552.339, -494.831, 53.134, 37)
setElementData(processmaconha ,"blipName", "Mercado de Drogas")

local D1zone = createColCuboid(-559.85413, -506.69934, 23.62296, 4.6536254882813, 13.502563476563, 9.8999980926514)
local D2zone = createColCuboid(-531.94470, -506.95132, 23.42297, 4.7101440429688, 14.387268066406, 10.300001525879)
local D3zone = createColCuboid(-522.66760, -507.01102, 22.92304, 4.4502563476563, 14.759368896484, 10.400011444092)

local Value = {}
local Merca = {}
local rotHZ = {}
local rotHS = {}
local timHR = {}
local timerContH = {}
local contagemHV = {}
local barTimeH = {}
local barTimeC = {}
local barTimeM = {}
local contagemTimer = {}


daysemana = {
     {1, "segunda"},
	 {2, "terça"},
	 {3, "quarta"},
	 {4, "quinta"},
	 {5, "sexta"},
	 {6, "sábado"},
	 {0, "domingo"},
}


day = {}


function removeBindKeyMaco (thePlayer)
     unbindKey(thePlayer, "e", "down", startTheFunctionMaco)
	 setElementData(thePlayer, "enterZone:Maconha", false)
end



function enterDZH (thePlayer)
if not thePlayer then return end
     if getElementType(thePlayer) == "player" then 
    local theVehicle = getPedOccupiedVehicle ( thePlayer )
	 if theVehicle then
		if getElementType (theVehicle) == "vehicle" then

			--local driver = getVehicleController ( theVehicle )
			controller = getVehicleController ( theVehicle ) 
			if controller == thePlayer then 


		 local prTeam = getTeamFromName ( "PR" )
         local prCount = countPlayersInTeam ( prTeam )
         --    if prCount >= 6 then
		--	     exports.bgo_hud:dm("Este serviço só pode ser executado com 6 Policias Rodoviário.",thePlayer, 255, 255, 255)
		 --    return
		-- end

		if not exports.bgo_dashboard:isPlayerInFaction(thePlayer , 13) then return end

--[[
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
]]--


	 if not exports['bgo_items']:hasItemS(theVehicle, 15) then
	     exports.bgo_hud:dm("Esta vaga é reservada apenas para Heroina.",thePlayer, 255, 255, 255)
	     return
	 end
	 rotHZ[thePlayer] = getElementRotation(theVehicle)
	     if (rotHZ[thePlayer]) then
		     rotHS[thePlayer] = math.floor(rotHZ[thePlayer])
			-- if (rotHS[thePlayer] == 359 or rotHS[thePlayer] == 358 or rotHS[thePlayer]== 360 or rotHS[thePlayer] == 357 or rotHS[thePlayer] == 351) then
			 --    exports.bgo_hud:dm("O veiculo precisa estar estacionado de ré",thePlayer, 255, 255, 255)
			--	 return
			-- else
			         if exports['bgo_items']:hasItemS(theVehicle, 15) then
					     setElementData(thePlayer, "venderDrogas", true)
				         exports.bgo_hud:dm("Descarregamento iniciando, Aguarda um momento.",thePlayer, 255, 255, 255)
						 setElementFrozen(theVehicle, true)
						 contagemHV[thePlayer] = 0
						 setElementData(theVehicle, "vehFrozen", true)
						 setElementData(thePlayer, "infoContagem", true)
						 contagemDH (thePlayer, theVehicle)
				     else
					 end
				 end
				end
			 end
		 end
	 end
end
addEventHandler("onColShapeHit", D1zone, enterDZH)

function exitTruckHero (player, seat, jacked)
     if (getElementData(player, "venderDrogas") == true) then
	     cancelEvent()
		 exports.bgo_hud:dm("Aguarde a venda acabar para se retirar.",player, 255, 255, 255)
	 end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitTruckHero)

function contagemDH (thePlayer, theTruck)
if not thePlayer then return end
     if exports['bgo_items']:hasItemS(theTruck, 15) then 
	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 15, false)
		 contagemHV[thePlayer] = contagemHV[thePlayer] + 1
		 contagemTimer[thePlayer] = setTimer(contagemDH, 1000, 1,thePlayer, theTruck)
         else
		 setElementData(thePlayer, "infoContagem", false)
         setTimer(contagemVehicleH, 2000, 1, thePlayer, theTruck)
		 barTimeH[thePlayer] = contagemHV[thePlayer] * 1
		 if barTimeH[thePlayer] > 1 then
		 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeH[thePlayer] - 2)
		 else
		 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeH[thePlayer])
		 end
		 setTimer( outputDebugString, 2000, 1, "O valor de Carga é de "..contagemHV[thePlayer])
		 setTimer(finishServiceH, contagemHV[thePlayer] * 1000, 1, thePlayer, theTruck) 
		 if isTimer(contagemTimer[thePlayer]) then
		     killTimer(contagemTimer[thePlayer])
		 end
	 end
end

function contagemVehicleH (thePlayer, theTruck)
if not thePlayer then return end
     if exports['bgo_items']:hasItemS(theTruck, 15) then 
		exports['bgo_items']:giveItem(theTruck, 15, 1, contagemHV[thePlayer], 0, false)
         timerContH[thePlayer] = setTimer(function (thePlayer, theTruck)
		 setElementFrozen(theTruck, true)
         triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 15, false)
		 contagemHV[thePlayer] = contagemHV[thePlayer] + 1
		 end, contagemHV[thePlayer]*1000, 1, thePlayer)
	 end
end


function finishServiceH (thePlayer, theTruck)
if not thePlayer then return end
if not getElementData(thePlayer, "loggedin") then return end
 	 if not exports['bgo_items']:hasItemS(theTruck, 15) then 
	     if getElementType (theTruck) == "vehicle" then
    		 exports.bgo_hud:dm("Descarregamento finalizado com sucesso.",thePlayer, 255, 255, 255)
    		 exports.bgo_hud:dm("Valor descarregado "..contagemHV[thePlayer]..".",thePlayer, 255, 255, 255)
     		 setElementFrozen(theTruck, false)
			 if isTimer(timerContH[thePlayer]) then
        		 killTimer(timerContH[thePlayer])
			 end
    		 Merca[thePlayer] = "HEROINA"
    		 setElementData(thePlayer, "venderDrogas", false)
			 setElementData(thePlayer, "infoContagem", false)
             local BHcoc = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", "HEROINA")
             local BresultH = dbPoll(BHcoc, -1)  
             if #BresultH ~= 0 then
			     Value[thePlayer] = BresultH[1]["VALOR"] * contagemHV[thePlayer]
			     setElementData(thePlayer, "char:moneysujo", (getElementData(thePlayer, "char:moneysujo") or 0) + Value[thePlayer])
             end
		 end
	 end
end

local rotMZ = {}
local rotMS = {}
local timMR = {}
local timerContM = {}
local contagemMV = {}

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
			
			if exports.bgo_dashboard:isPlayerInFaction(thePlayer, 13) then 

			
		 --local prTeam = getTeamFromName ( "PR" )
         --local prCount = countPlayersInTeam ( prTeam )
     --        if prCount >= 6 then
		--	     exports.bgo_hud:dm("Este serviço só pode ser executado com 6 Policias Rodoviário.",thePlayer, 255, 255, 255)
		--     return
	--	 end
	
	--[[
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
]]--


	     rotMZ[thePlayer] = getElementRotation(theVehicle)
	     if not exports['bgo_items']:hasItemS(theVehicle, 144) then
	         exports.bgo_hud:dm("Esta vaga é reservada apenas para Maconha.",thePlayer, 255, 255, 255)
	         return
	     end
	     if (rotMZ[thePlayer]) then
		     rotMS[thePlayer] = math.floor(rotMZ[thePlayer])
			         if exports['bgo_items']:hasItemS(theVehicle, 144) then
					     setElementData(thePlayer, "venderDrogas", true)
				         exports.bgo_hud:dm("Descarregamento iniciando, Aguarda um momento.",thePlayer, 255, 255, 255)
						 setElementFrozen(theVehicle, true)
						 contagemMV[thePlayer] = 0
						 setElementData(theVehicle, "vehFrozen", true)
						 contagemDM2 (thePlayer, theVehicle)
						 setElementData(thePlayer, "infoContagem", true)
				     else
						end
					end
				end
			 end
		 end
	 end
end
end
addEventHandler("onColShapeHit", D2zone, enterDZM)

function contagemDM2 (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 144) then 
     	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 144, false)
    		 contagemMV[thePlayer] = contagemMV[thePlayer] + 1
    		 contagemTimer[thePlayer] = setTimer(contagemDM2, 1000, 1,thePlayer, theTruck)
			 

			 
             else
			 setElementData(thePlayer, "infoContagem", false)
             setTimer(contagemVehicleM, 2000, 1, thePlayer, theTruck)
			 barTimeM[thePlayer] = contagemMV[thePlayer] * 1
			 if barTimeM[thePlayer] > 1 then
			 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeM[thePlayer]-2)
			 end
			 setTimer( outputDebugString, 2000, 1, "O valor de Carga é de "..contagemMV[thePlayer])
			 setTimer(finishServiceM, contagemMV[thePlayer] * 1000, 1, thePlayer, theTruck)		
             if isTimer(contagemTimer[thePlayer]) then
			     killTimer(contagemTimer[thePlayer])
             end			 
		 end
	 end
end

function contagemVehicleM (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 144) then 
     	     exports['bgo_items']:giveItem(theTruck, 144, 1, contagemMV[thePlayer], 0, false)
             timerContM[thePlayer] = setTimer(function (thePlayer, theTruck)
    		 setElementFrozen(theTruck, true)
             triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 144, false)
    		 contagemMV[thePlayer] = contagemMV[thePlayer] + 1
    		 end, contagemMV[thePlayer]*1000, 1, thePlayer)
		 end
	 end
end

function finishServiceM (thePlayer, theTruck)
if not thePlayer then return end
if not getElementData(thePlayer, "loggedin") then return end
     if getElementType(theTruck) == "vehicle" then 
 	     if not exports['bgo_items']:hasItemS(theTruck, 144) then 
     		 exports.bgo_hud:dm("Descarregamento finalizado com sucesso.",thePlayer, 255, 255, 255)
      		 exports.bgo_hud:dm("Valor descarregado "..contagemMV[thePlayer]..".",thePlayer, 255, 255, 255)
     		 setElementFrozen(theTruck, false)
    		 Merca[thePlayer] = "MACONHA"
    		 -- buyCarga (thePlayer, theTruck)
     		 setElementData(thePlayer, "venderDrogas", false)
			 setElementData(thePlayer, "infoContagem", false)
             local MHcoc = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", "MACONHA")
             local BresultM = dbPoll(MHcoc, -1) 	
             if #BresultM ~= 0 then
			     Value[thePlayer] = BresultM[1]["VALOR"] * contagemMV[thePlayer]
			     setElementData(thePlayer, "char:moneysujo", (getElementData(thePlayer, "char:moneysujo") or 0) + Value[thePlayer])
             end			 
   		 end
	 end
end

local rotCZ = {}
local rotCS = {}
local timCR = {}
local timerContC = {}
local contagemCV = {}

function enterDZC (thePlayer)
if not thePlayer then return end
     if getElementType(thePlayer) == "player" then 
     local theVehicle = getPedOccupiedVehicle ( thePlayer )
	 if theVehicle then
	 if getElementType(theVehicle) == "vehicle" then 
		controller = getVehicleController ( theVehicle ) 
		if controller == thePlayer then 


		if not exports.bgo_dashboard:isPlayerInFaction(thePlayer , 13) then return end




		 local prTeam = getTeamFromName ( "PR" )
         local prCount = countPlayersInTeam ( prTeam )
    --         if prCount >= 6 then
	--		     exports.bgo_hud:dm("Este serviço só pode ser executado com 6 Policias Rodoviário.",thePlayer, 255, 255, 255)
	--	     return
	--	 end
	
	
	
	--[[
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
]]--

	 if not exports['bgo_items']:hasItemS(theVehicle, 14) then
	     exports.bgo_hud:dm("Esta vaga é reservada apenas para Cocaina.",thePlayer, 255, 255, 255)
	     return
	 end

			         if exports['bgo_items']:hasItemS(theVehicle, 14) then
				         exports.bgo_hud:dm("Descarregamento iniciando, Aguarda um momento.",thePlayer, 255, 255, 255)
						 setElementFrozen(theVehicle, true)
						 contagemCV[thePlayer] = 0
						 setElementData(theVehicle, "vehFrozen", true)
						 contagemDC (thePlayer, theVehicle)
						 setElementData(thePlayer, "infoContagem", true)
						 setElementData(thePlayer, "venderDrogas", true)
				     else
					end
				 end
			 end
		 end
	 end
end
addEventHandler("onColShapeHit", D3zone, enterDZC)

function contagemDC (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 14) then 
     	     triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 14, false)
			  contagemCV[thePlayer] = contagemCV[thePlayer] + 1
			  contagemTimer[thePlayer] = setTimer(contagemDC, 1000, 1, thePlayer, theTruck)
     		 --contagemDC (thePlayer, theTruck)
             else
             barTimeC[thePlayer] = contagemCV[thePlayer] * 1
			 if barTimeC[thePlayer] > 1 then
			 setTimer(triggerClientEvent, 2000, 1, thePlayer, "progressService", thePlayer, barTimeC[thePlayer] - 2)
			 end
			 setTimer( outputDebugString, 2000, 1, "O valor de Carga é de "..contagemCV[thePlayer])
			 setTimer(finishServiceC, contagemCV[thePlayer] * 1000, 1, thePlayer, theTruck)
             setTimer(contagemVehicleC, 2000, 1, thePlayer, theTruck)	
             if isTimer(contagemTimer[thePlayer]) then
			     killTimer(contagemTimer[thePlayer])
             end			 
		 end
	 end
end

function contagemVehicleC (thePlayer, theTruck)
if not thePlayer then return end
     if getElementType(theTruck) == "vehicle" then 
         if exports['bgo_items']:hasItemS(theTruck, 14) then 
         	 exports['bgo_items']:giveItem(theTruck, 14, 1, contagemCV[thePlayer], 0, false)
             timerContC[thePlayer] = setTimer(function (thePlayer, theTruck)
    		 setElementFrozen(theTruck, true)
             triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, theTruck, 14, false)
    		 contagemCV[thePlayer] = contagemCV[thePlayer] + 1
    		 end, contagemCV[thePlayer]*1000, 1, thePlayer)
		 end
	 end
end

function finishServiceC (thePlayer, theTruck) 
if not thePlayer then return end
if not getElementData(thePlayer, "loggedin") then return end
     if getElementType(theTruck) == "vehicle" then 
     	 if not exports['bgo_items']:hasItemS(theTruck, 14) then 
    		 exports.bgo_hud:dm("Descarregamento finalizado com sucesso.",thePlayer, 255, 255, 255)
    		 exports.bgo_hud:dm("Valor descarregado "..contagemCV[thePlayer]..".",thePlayer, 255, 255, 255)
     		 setElementFrozen(theTruck, false)
     		 Merca[thePlayer] = "COCAINA"

     		 setElementData(thePlayer, "venderDrogas", false)
			 setElementData(thePlayer, "infoContagem", false)
			 
             local Bcoc = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", "COCAINA")
             local BresultC = dbPoll(Bcoc, -1)	 	
             if #BresultC ~= 0 then
		    	 Value[thePlayer] = BresultC[1]["VALOR"] * contagemCV[thePlayer]
			     setElementData(thePlayer, "char:moneysujo", (getElementData(thePlayer, "char:moneysujo") or 0) + Value[thePlayer])
             end			 
		 end
	 end
end

function attb (thePlayer, command, element)
     if (element == "bolsa") then
	     if getElementData(thePlayer, "acc:admin") > 7 then
		     outputChatBox("#7cc576[BOLSA DE VALORES] Você alterou a bolsa de valores com sucesso.", thePlayer, 255,255,255, true)	
			 outputChatBox(" ", root, 255,255,255, true)	
			 outputChatBox(" ", root, 255,255,255, true)	
			 outputChatBox(" ", root, 255,255,255, true)	
			 outputChatBox(" ", root, 255,255,255, true)	
			 outputChatBox(" ", root, 255,255,255, true)	
			 outputChatBox(" ", root, 255,255,255, true)	
			 outputChatBox("#7cc576[BOLSA DE VALORES] #FFFFFFValores da bolsa: Ilegal, Alterada.", root, 255,255,255, true)	
			 outputChatBox("#7cc576[BOLSA DE VALORES] #FFFFFFValores da bolsa: Legal, Alterada.", root, 255,255,255, true)	
			 randomList ()
		 end
	 end
end
addCommandHandler("att", attb)

function randomList ()
	     NewLis = math.random(1, 10)
		 --NewCLis = math.random(11, 20)
		 if (NewLis) then
		     if (NewLis == 1) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "HEROINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 2) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "HEROINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 3) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "HEROINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "COCAINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 4) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "HEROINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "MACONHA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 5) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "HEROINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 6) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "HEROINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "COCAINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 7) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "HEROINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "MACONHA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 8) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "HEROINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 9) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "MACONHA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "HEROINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "COCAINA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewLis == 10) then
			     dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 300, "COCAINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 200, "HEROINA")
				 dbExec(db, "UPDATE BOLSA SET VALOR=? WHERE DROGA_NAME=?", 100, "MACONHA")
				 attBolsa ("MACONHA", 1)
				 attBolsa ("HEROINA", 1)
				 attBolsa ("COCAINA", 1)
	        	 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
			 
			 --[[
			 if (NewCLis == 11) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "LARANJA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 12) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "AREIA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("AREIA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 13) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "LARANJA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "MADEIRA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 14) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "LARANJA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "TRIGO")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 15) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "LARANJA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 16) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "LARANJA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "MADEIRA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 17) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "LARANJA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "TRIGO")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 18) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "LARANJA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 19) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "TRIGO")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "LARANJA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "MADEIRA")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
				 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
		     if (NewCLis == 20) then
			     dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 250, "MADEIRA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 100, "LARANJA")
				 dbExec(db, "UPDATE CBOLSA SET VALOR=? WHERE CARGA_NAME=?", 50, "TRIGO")
				 attBolsa ("TRIGO", 2)
				 attBolsa ("LARANJA", 2)
				 attBolsa ("MADEIRA", 2)
	        	 outputChatBox(" ", root, 255,255,255, true)
	         	 outputChatBox(" ", root, 255,255,255, true)
	        	 outputChatBox(" ", root, 255,255,255, true)
			 end
			  ]]--
	 end
end

function attBolsa (thePlayer, carga, typ)
     if typ == 1 then
	     if isTransporteService() then
         local BATTcoc = dbQuery(db, "SELECT * FROM BOLSA WHERE DROGA_NAME=?", carga)
         local BATTresultC = dbPoll(BATTcoc, -1)  
    	 if #BATTresultC ~= 0 then
    	     	 triggerClientEvent(thePlayer, "attPag", thePlayer, BATTresultC[1]["DROGA_NAME"], BATTresultC[1]["VALOR"], BATTresultC[1]["BOLSA"])
				 outputDebugString("*[BOLSA TRAFICO] Load: Unidade da "..(BATTresultC[1]["DROGA_NAME"]).." "..(BATTresultC[1]["VALOR"]).." .")
				 setElementData(thePlayer, "load:"..(BATTresultC[1]["DROGA_NAME"]).."", (BATTresultC[1]["VALOR"]))
			 end
		 end
	end
	--[[
     if typ == 2 then
         local BATTccc = dbQuery(db, "SELECT * FROM CBOLSA WHERE CARGA_NAME=?", carga)
         local BATTresultCC = dbPoll(BATTccc, -1)  
    	 if #BATTresultCC ~= 0 then
		     if isTransporteService() then
    	     	 triggerClientEvent(thePlayer, "attPagC", thePlayer, BATTresultCC[1]["CARGA_NAME"], BATTresultCC[1]["VALOR"], BATTresultCC[1]["BOLSA"])
				 outputDebugString("*[BOLSA TRAFICO] Load: Unidade da "..(BATTresultCC[1]["CARGA_NAME"]).." "..(BATTresultCC[1]["VALOR"]).." .")
				 setElementData(thePlayer, "load:"..(BATTresultCC[1]["CARGA_NAME"]).."", (BATTresultCC[1]["VALOR"]))
			 end
		 end
  	 end
	 ]]--
	 if not typ then
         outputChatBox("#7cc576[BOLSA DE VALORES] #FFFFFFOs valores da bolsa foram alterados.", root, 255,255,255, true)
	 end
end

function reloadD (thePlayer)
     if isTransporteService() then
         setTimer(attBolsa, 100, 1, thePlayer, "MACONHA", 1)
         setTimer(attBolsa, 25, 1, thePlayer, "HEROINA", 1)
         setTimer(attBolsa, 3000, 1, thePlayer, "COCAINA", 1)
	     outputChatBox("#7cc576[BGO ERROR] #FFFFFFVerificamos que está com o painel bugado!.", thePlayer , 255,255,255, true)
		 outputChatBox("#7cc576[BGO ERROR] #FFFFFFRecarregando a Bolsa de Drogas.", thePlayer , 255,255,255, true)
	 end
end
addEvent("reload:droga", true)
addEventHandler("reload:droga", root, reloadD)
--[[
function reloadC (thePlayer)
     if isTransporteService() then
         setTimer(attBolsa, 100, 1, thePlayer, "TRIGO", 2)
         setTimer(attBolsa, 25, 1, thePlayer, "MADEIRA", 2)
         setTimer(attBolsa, 3000, 1, thePlayer, "LARANJA", 2)
	     outputChatBox("#7cc576[BGO ERROR] #FFFFFFVerificamos que está com o painel bugado!.", thePlayer , 255,255,255, true)
		 outputChatBox("#7cc576[BGO ERROR] #FFFFFFRecarregando a Bolsa de Cargas.", thePlayer , 255,255,255, true)
     end
end
addEvent("reload:carga", true)
addEventHandler("reload:carga", root, reloadC)]]--

timer = {}
bolsa = {}
antBUG = {}

function painel(thePlayer)
if exports.bgo_dashboard:isPlayerInFaction(thePlayer , 13) then
if not thePlayer then return end
     if not bolsa[thePlayer] then
	     bolsa[thePlayer] = false
	 end
	     if bolsa[thePlayer] == false then
		     if isTransporteService() then
	             if isTimer(timer[thePlayer]) then
			         exports.bgo_infobox:addNotification(thePlayer,"Aguarde 5 segundos para abrir o painel novamente","error")
	         	 return end
        	     timer[thePlayer] = setTimer(function() end, 5000, 1)
			     if not (getElementData(thePlayer, "load:MACONHA")) then
                 setTimer(attBolsa, 100, 1, thePlayer, "MACONHA", 1)
		     	 end
		     	 if not (getElementData(thePlayer, "load:HEROINA")) then
                  	 setTimer(attBolsa, 25, 1, thePlayer, "HEROINA", 1)
		    	 end
		    	 if not (getElementData(thePlayer, "load:COCAINA")) then
		        	 setTimer(attBolsa, 3000, 1, thePlayer, "COCAINA", 1)
		    	 end
				 --[[
		    	 if not (getElementData(thePlayer, "load:TRIGO")) then
                      setTimer(attBolsa, 4000, 1, thePlayer, "TRIGO", 2)
    		 	 end
	    		 if not (getElementData(thePlayer, "load:MADEIRA")) then
                 	 setTimer(attBolsa, 500, 1, thePlayer, "MADEIRA", 2)
    			 end
    			 if not (getElementData(thePlayer, "load:LARANJA")) then
                 	 setTimer(attBolsa, 6000, 1, thePlayer, "LARANJA", 2)
     			 end
				 ]]--
				 
             	 triggerClientEvent(thePlayer, "startDxB", thePlayer)
	         	 bolsa[thePlayer] = true
	    		 --exports.bgo_admin:outputAdminMessage(" "..getPlayerName(thePlayer).." ID: #7cc576(" .. getElementData(thePlayer, "playerid")..") Abriu o painel de bolsa de valores.")
				 else
             	 triggerClientEvent(thePlayer, "startDxB", thePlayer)
	         	 bolsa[thePlayer] = true
	    		-- exports.bgo_admin:outputAdminMessage(" "..getPlayerName(thePlayer).." ID: #7cc576(" .. getElementData(thePlayer, "playerid")..") Abriu o painel de bolsa de valores.")
			 end
	      else
	     bolsa[thePlayer] = false
		 triggerClientEvent(thePlayer, "startDxB", thePlayer)
	 end
	 end
end

function restart()
	for index, player in ipairs(getElementsByType("player")) do
	bindKey(player, "F4", "down", painel)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), restart)

function entrar()
	bindKey(source, "F4", "down", painel)
end
addEventHandler("onPlayerJoin", getRootElement(), entrar)

function fechar(player)
	for index, player in ipairs(getElementsByType("player")) do
	unbindKey(player, "F4", "down", painel)
	end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), fechar)

addEventHandler("onPlayerQuit", root,
function ()
     if isTimer(contagemTimer[source]) then
		 killTimer(contagemTimer[source])
     end
end)

local myBlip = { }
function aviso()
	for index, veh in ipairs(getElementsByType("vehicle")) do
	if getElementDimension(veh) == 0 then
	local id = getElementData(veh,"veh:id") or ""
	local oname = getElementData(veh, "veh:oname") or ""
	if exports['bgo_items']:hasItemS(veh, 144) then					
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com Heroina em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 

			if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com Heroina em andamento marcado no gps", v, 255, 255, 255, 10000)
			end
			end
			
	end
	if exports['bgo_items']:hasItemS(veh, 15) then					
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com Heroina em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 
		 	if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com Heroina em andamento em marcado no gps", v, 255, 255, 255, 10000)
			end
			end
			
	end
	if exports['bgo_items']:hasItemS(veh, 14) then					
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com Heroina em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 
		 			if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com Heroina em andamento marcado no gps", v, 255, 255, 255, 10000)
			end
			end
	end
	
	
	if exports['bgo_items']:hasItemS(veh, 231) then					
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com Heroina em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 
		 	if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com Heroina em andamento marcado no gps", v, 255, 255, 255, 10000)
			end
			end
			
			
	end
	if exports['bgo_items']:hasItemS(veh, 232) then
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com Heroina em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 
		 	if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com Heroina em andamento marcado no gps", v, 255, 255, 255, 10000)
			end
			end
			
			
	end
	if exports['bgo_items']:hasItemS(veh, 233) then
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com pasta base em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 
		 			if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com pasta base em andamento marcado no gps", v, 255, 255, 255, 10000)
			end
			end
			
	end
	if exports['bgo_items']:hasItemS(veh, 234) then
	     exports.bgo_admin:outputAdminMessage("[Denuncia]: Tem caminhão com Cocaina em andamento Dono: "..oname.." ID do veiculo: "..id.."!")
		 
		 	if isElement(myBlip[veh]) then
			destroyElement( myBlip[veh] )
			end
			myBlip[veh] = createBlipAttachedTo (veh, 1 )
			setBlipColor ( myBlip[veh], 255, 0, 0, 255 )
			setBlipSize ( myBlip[veh], 3 )
			setElementVisibleTo ( myBlip[veh], root, false )
			local x, y, z = getElementPosition ( veh )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 20000, 1, myBlip[veh])

			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[veh], v, true )
			exports.bgo_hud:drawNote("Carregamento"..math.random(1, 10).."" .. location .. "", "[Denúncia]: Caminhão com Cocaina em andamento marcado no gps", v, 255, 255, 255, 10000)
			end
			end
			
	end	
	end	
	end
end
aviso()
setTimer(aviso, 180000, 0)

local originalGetPlayerCount = getPlayerCount
function getPlayerCount()
    return originalGetPlayerCount and originalGetPlayerCount() or #getElementsByType("player")
end