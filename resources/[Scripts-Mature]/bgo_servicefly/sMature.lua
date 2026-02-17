timer = 60

local blip = createBlip(1717.38, 1617.008, 10.117, 42)
setElementData(blip, "blipName", "Piloto de avião")

--createObject(988, 1958.800, -2189.879, 13.547, 0, 0, 180)
--createObject(988, 1964.276, -2189.879, 13.547, 0, 0, 180)

local fly = createColCuboid(1330.38904, 1203.17810, 6.94695, 396.92395019531, 660.224609375, 180.69974269867)

function enterfly (vehicle)
     if vehicle then
	     if getElementModel(vehicle) == 553 or getElementModel(vehicle) == 519 then
		     if (getElementType(vehicle) == "vehicle") then
		         for index, player in pairs(getElementsWithinColShape(fly, "player")) do
		             triggerClientEvent ( player, "FLY>CarColision>false", player, vehicle)
		    	 end
			 end
		 end
	 end
end
addEventHandler("onColShapeHit", fly, enterfly)

function exitfly (vehicle)
     if vehicle then
	     if getElementModel(vehicle) == 553 or getElementModel(vehicle) == 519 or getElementModel(vehicle) == 511 then
		     if (getElementType(vehicle) == "vehicle") then
		         for index, player in pairs(getElementsWithinColShape(fly, "player")) do
		             triggerClientEvent ( player, "FLY>CarColision>true", player, vehicle)
		    	 end
			 end
		 end
	 end
end
addEventHandler("onColShapeLeave", fly, exitfly)

local randomFly = {
     {553},
     {519},
	 {511},
}

local posFly = {
     {1479.1379394531,1807.5513916016,10.237668991089},
     {1478.4259033203,1741.8139648438,10.222187995911},
}

avi = {}


local timers = {}


addEvent("startService", true)
addEventHandler("startService", root,
function (thePlayer)
--if getElementData(thePlayer, "char:id") ~= 4 then outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO ERROR] #FFFFFFServiço em manutenção.", thePlayer, 255,255,255, true) return end
randomF = math.random(#randomFly)
pos = math.random(#posFly)
	 if thePlayer then
		if isTimer(timers[thePlayer]) then return end
		timers[thePlayer] = setTimer(function() end, 2000, 1) 

	     if (getElementData(thePlayer, "char:dutyfaction") ~= 222) then
		 outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO ERROR] #FFFFFFVocê não está no serviço de piloto de avião lamento.", thePlayer, 255,255,255, true)	
		 else
	         avi[thePlayer] = createVehicle(randomFly[randomF][1], posFly[pos][1], posFly[pos][2], posFly[pos][3], 0, -0, 179.379)
		     warpPedIntoVehicle (thePlayer, avi[thePlayer])  
		     setTimer(function (thePlayer)
		         triggerClientEvent (thePlayer, "FLY>Start", root, thePlayer)
				 setTimer(setElementModel, 1000, 1, thePlayer, 61)
		     end, 5000, 1, thePlayer)
		 end
     end	 
end)

addEvent("setaInfor", true)
addEventHandler("setaInfor", root,
function (thePlayer, x, y, z)
     exports.Script_futeis:setGPS(thePlayer, "Coordenada", x,y,z)	 
end)

warning = {}
timerwa = {}
inService = {}
timerServ = {}

function exitVehicle ( thePlayer, seat, jacked ) 
local theVehicle = getPedOccupiedVehicle ( thePlayer )
     if isElement(avi[thePlayer]) then 
       --  if not getElementModel(theVehicle) == 553 or getElementModel(theVehicle) == 519 then return end
             if not warning[thePlayer] then
			     if inService[thePlayer] then
	             outputChatBox(" ", thePlayer, 255,255,255, true)	
	             outputChatBox(" ", thePlayer, 255,255,255, true)	
	             outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFVocê esta carregando o avião.", thePlayer, 255,255,255, true)	
				 outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFNão pode sair dele no momento, Aguarde!.", thePlayer, 255,255,255, true)	
				 cancelEvent()
				     return
				 end
	                 outputChatBox(" ", thePlayer, 255,255,255, true)	
	                 outputChatBox(" ", thePlayer, 255,255,255, true)	
	                 outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFPressione 'F' novamente para sair do veiculo.", thePlayer, 255,255,255, true)	
	                 warning[thePlayer] = true
	                 cancelEvent()
	                 timerwa[thePlayer] = setTimer(function(thePlayer)
	                      if warning[thePlayer] then
			                 warning[thePlayer] = false
			             end
		             end, 60000, 1, thePlayer)
			 else
             if isElement(avi[thePlayer]) then
		         destroyElement(avi[thePlayer])
				 triggerClientEvent(thePlayer, "destroyMarker", thePlayer)
		    	 warning[thePlayer] = false
				 inService[thePlayer] = false
				 setTimer(function (thePlayer)
						setElementPosition(thePlayer,1710.9841308594,1597.7697753906,10.171875)
				     setElementModel(thePlayer, getElementData(thePlayer, "fly:skin"))
				 end, 1000, 1, thePlayer)
		     end
	     end
     end
end
addEventHandler ( "onVehicleStartExit", getRootElement(), exitVehicle)


addEvent("loadFly", true)
addEventHandler("loadFly", root,
function (thePlayer)
local theVehicle = getPedOccupiedVehicle ( thePlayer )
     if theVehicle then
	     if getElementModel(theVehicle) == 553 or getElementModel(theVehicle) == 519 or getElementModel(theVehicle) == 511 then
		     inService[thePlayer] = true
	         outputChatBox(" ", thePlayer, 255,255,255, true)	
	         outputChatBox(" ", thePlayer, 255,255,255, true)	
	         outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFVocê esta carregando o avião aguarde.", thePlayer, 255,255,255, true)	
			 setElementFrozen(theVehicle, true)
			 triggerClientEvent(thePlayer, "progressService", thePlayer, timer, "[FLY SERVICE] #FFFFFFPassageiros embarcando.")
			 timerServ[thePlayer] = setTimer(function(thePlayer)
			     if theVehicle then
				     setElementFrozen(theVehicle, false)
					 inService[thePlayer] = false
	                 outputChatBox(" ", thePlayer, 255,255,255, true)	
	                 outputChatBox(" ", thePlayer, 255,255,255, true)	
	                 outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFCarregamento do avião concluido!.", thePlayer, 255,255,255, true)	
				     outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFPode decolar!, a pista esta liberada.", thePlayer, 255,255,255, true)
				 end
			 end, timer * 1000 + 2000, 1, thePlayer)
		 end
	 end
end)

addEvent("loadFly2", true)
addEventHandler("loadFly2", root,
function (thePlayer)
local theVehicle = getPedOccupiedVehicle ( thePlayer )
     if theVehicle then
	     if getElementModel(theVehicle) == 553 or getElementModel(theVehicle) == 519 or getElementModel(theVehicle) == 511 then
		     inService[thePlayer] = true
	         outputChatBox(" ", thePlayer, 255,255,255, true)	
	         outputChatBox(" ", thePlayer, 255,255,255, true)	
	         outputChatBox(""..(exports.bgo_color:getColorServer() or "#FFFFFF").."[BGO FLY] #FFFFFFVocê esta descarregando o avião aguarde.", thePlayer, 255,255,255, true)	
			 setElementFrozen(theVehicle, true)
			 triggerClientEvent(thePlayer, "progressService", thePlayer, timer, "[FLY SERVICE] #FFFFFFPassageiros desembarcando.")
			 timerServ[thePlayer] = setTimer(function(thePlayer)
			     if theVehicle then
                     finishFly (thePlayer)
				 end
			 end, timer * 1000 + 2000, 1, thePlayer)
		 end
	 end
end)

function finishFly (thePlayer)
local randomM = math.random(5500, 10500)
local randomMoney = tonumber(randomM)
local randomXP = math.random(100, 900)
local theVehicle = getPedOccupiedVehicle ( thePlayer )
     if theVehicle then
	     if getElementModel(theVehicle) == 553 or getElementModel(theVehicle) == 519 or getElementModel(theVehicle) == 511 then
             if isElement(avi[thePlayer]) then
			     destroyElement(avi[thePlayer])
				 setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") + randomMoney)
				 setElementData(thePlayer, "LSys:EXP", getElementData(thePlayer, "LSys:EXP") + randomXP)
				 exports.bgo_hud:dm("Você recebu "..randomXP.." de experiencia.",thePlayer, 255, 255,255)
				 triggerClientEvent(thePlayer, "destroyMarker", thePlayer)
                 if isTimer(timerServ[thePlayer]) then
				     killTimer(timerServ[thePlayer])
                 end
                 if isTimer(timerwa[thePlayer]) then
				     killTimer(timerwa[thePlayer])
                 end
				 setTimer(function (thePlayer)
				     setElementPosition(thePlayer, 1710.9841308594,1597.7697753906,10.171875)
				     setElementModel(thePlayer, getElementData(thePlayer, "fly:skin"))
					 inService[thePlayer] = false
					 warning[thePlayer] = false
			
				 end, 2000, 1, thePlayer)
			 end
		 end
	 end
end

function notifyAboutExplosion()
     if getElementModel(source) == 553 or getElementModel(source) == 519 or getElementModel(source) == 511 then
	     destroyElement(source)
	 end
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion)

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
     if isElement(avi[source]) then
		 destroyElement(avi[source])
     if isTimer(timerServ[source]) then
		 killTimer(timerServ[source])
     end
     if isTimer(timerwa[source]) then
		 killTimer(timerwa[source])
     end
	 inService[source] = false
	 warning[source] = false
	 end
	end
)

addEventHandler("onPlayerQuit", root,
function ()
     if isElement(avi[source]) then
		 destroyElement(avi[source])
     if isTimer(timerServ[source]) then
		 killTimer(timerServ[source])
     end
     if isTimer(timerwa[source]) then
		 killTimer(timerwa[source])
     end
	 inService[source] = false
	 warning[source] = false
	 end
end)