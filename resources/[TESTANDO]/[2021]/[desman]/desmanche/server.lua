local zones = {
     {-110.79072570801,1133.0148925781,19.7421875},
}

local zone      = {}
local myZone    = {}
local elements  = {}
local zonetime  = {}
local tableZone = {}

local objetocaixa = {}
desmanche = false


blackListVehicle = {
	[500] = true,
    [496] = true,
	[401] = true,
	[436] = true,
	[550] = true,
	[540] = true,
	[562] = true,
	[600] = true,
	[546] = true,
	[492] = true,
	[551] = true,
	[580] = true,
	[445] = true,
	[579] = true,
	[560] = true,
	[405] = true,
	[466] = true,
	[418] = true,
	[400] = true,
	[402] = true,
	[468] = true,
	[522] = true,
	[581] = true,
	[461] = true,
	[586] = true,
	[471] = true,
	[505] = true,
	[603] = true,
	[411] = true,
	[521] = true,
	[541] = true,
    [504] = true,
	[477] = true,	
	[438] = true,
	[467] = true,
	[559] = true,
	[547] = true,
}



sellVehicle2 = {
	[500] = {6000}, -- FUSCA
    [496] = {9500}, -- GOL QUADRADO
	[401] = {10120}, -- GOL BOLINHA
	[436] = {9500}, -- UNO
	[550] = {10120}, -- PALIO
	[540] = {11000}, -- GOL G3
	[562] = {10500}, -- FOX
	[600] = {12000}, -- Saveiro
	[546] = {11000}, -- KWID
	[492] = {13000}, -- ECO ESPORTS
	[551] = {13900}, -- ONIX
	[580] = {14000}, -- PASSAT
	[445] = {15000}, -- GOLF
	[579] = {19000}, -- HR
	[560] = {22000}, -- MERCEDEZ SL
	[405] = {23000}, -- AUDI
	[466] = {25000}, -- Q7
	[418] = {25900}, -- SURBURBAN
	[400] = {26000}, -- S10
	[402] = {26200}, -- LAIKA LYRAN
	[468] = {20000}, -- XRE
	[522] = {21000}, -- HORNET
	[581] = {23000}, -- Xj
	[461] = {22600}, -- TIGER
	[586] = {25000}, -- MOTO ROCK
	[471] = {22670}, -- Quadriciculo
	[505] = {30000}, -- RANGE
	[603] = {35000}, -- CAMARO
	[411] = {40000}, -- LAMBO
	[521] = {29000}, -- KAWASAKI
	[541] = {43000}, -- FERRARI
    [504] = {30000}, -- DODGE
	[477] = {45000}, -- P1	
	[438] = {30000}, -- X5
	[467] = {31560}, -- LANCER
	[559] = {43000}, -- BUGGATI
	[547] = {26900}, -- JEEP
}


addEventHandler('onResourceStart', resourceRoot,
function()
    -- for i=1, #zones do
	    --zone[i] = createColSphere(zones[i][1], zones[i][2], zones[i][3], 10)
		zone = createColCuboid(-115.42204, 1125.40686, 18.74219, 9.0620422363281, 14.968872070313, 5.2077754974365)
		 addEventHandler('onColShapeHit', zone, enterZone)
		 addEventHandler('onColShapeLeave', zone, exitZone)
	-- end
end)

addEvent('ocupezone', true)
addEventHandler('ocupezone', root,
function (player, zone, vehicle)
		if isElement(zone) then
		setElementData(vehicle, 'vehicle:desmanche', true)
		setElementData(player, 'player:vehicle', vehicle)
	end
end
)

function exitZone (element)
     if getElementType (element) == "player"  and getElementData(element, "char:dutyfaction") == 23 or getElementData(element, "acc:id") == 1 then
	     local vehicle = getPedOccupiedVehicle (element)
		 if vehicle then
		     removeEventHandler ( "onVehicleExit", vehicle, exitVehicle)
			 myZone[element] = nil
		 end
	 end
end

function enterZone (element)
     if getElementType (element) == "player" and  getElementData(element, "char:dutyfaction") == 23 or getElementData(element, "acc:id") == 1  then
	 
	if desmanche == true then 
	triggerClientEvent(element, "bgo>info", element,  "Informação", "Faltam "..atmGetTimeOut ( element ).." segundos para desmanchar outro veiculo!","aviso" )
	return 
	end
	
	     local vehicle = getPedOccupiedVehicle (element)
		 if vehicle then
		     addEventHandler ( "onVehicleExit", vehicle, exitVehicle)
		 end
		 myZone[element] = source
	 end
end

function exitVehicle (player, seat)
     if isElement(source) then
			 	if getElementData(source, "veh:owner") == getElementData(player, "char:id") then	
				triggerClientEvent(player, "bgo>info", player,  "ai ai","Bobinho você é leigo? o carro é seu!","erro" ) 
				return
				end
				
				if blackListVehicle[getElementModel(source)] and getElementData(source, "veh:owner") then
		
			     if seat == 0 then
                     removeEventHandler ( "onVehicleExit", source, exitVehicle)
					setElementData(source, 'vehicle:desmanche', true)
					setElementData(player, 'player:vehicle', source)
					
     	          	 triggerClientEvent(player, 'startprogress', source, source, myZone[player])
				 else
				     removeEventHandler ( "onVehicleExit", source, exitVehicle)
				 end
			 else
				 triggerClientEvent(player, "bgo>info", player,  "Informação","Esse veiculo não pode ser desmanchado.","erro" ) 
				 removeEventHandler ( "onVehicleExit", source, exitVehicle)
		 end
	 end
end

addEventHandler ( "onVehicleStartEnter", getRootElement(),
function ( player, seat, jacked )
     if (getElementData(source, 'vehicle:desmanche')) then
         cancelEvent()
		  triggerClientEvent(player, "bgo>info", player,  "Informação","Esse veiculo está sendo desmanchado..","erro" )
     end
end)

addEvent('action:vehicle', true)
addEventHandler('action:vehicle', root,
function (vehicle, door, action)
     if isElement(vehicle) then
	     local door = tonumber(door)
	     setVehicleDoorOpenRatio (vehicle, door, action, 2000)
	 end
end)

function atmGetTimeOut ( player )
	if isTimer ( timer ) then
		local miliseconds = getTimerDetails ( timer )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end
		
		
addEvent('remove:component', true)
addEventHandler('remove:component', root,
function (thePlayer, vehicle, component)
     if isElement(vehicle) then
	if desmanche == true then 
	triggerClientEvent(player, "bgo>info", player,  "Informação", "Faltam "..atmGetTimeOut ( thePlayer ).." segundos para desmanchar outro veiculo!","aviso" )
	return 
	end
	
	     local players = getElementsByType("player")
         local player = nil
         for i = 1, #players do
	         player = players[i]
			 triggerClientEvent(player, 'remove:component', player, vehicle, component)
		 end
		 
		if isElement(objetocaixa[thePlayer]) then
			destroyElement(objetocaixa[thePlayer])
		end
			
		local rot = getElementRotation(thePlayer)
		objetocaixa[thePlayer] = createObject(3014, 0, 0, 0)
		setElementData(thePlayer,"Animando", true)
		setElementData(thePlayer,"CaixaNaMao", true)
		setObjectScale(objetocaixa[thePlayer], 0.9)		
		exports.bone_attach:attachElementToBone(objetocaixa[thePlayer],thePlayer,3,-0.1, 0.45, 0.19, 0, rot, 0) 
		exports.bgo_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)
		
		
		
	 end
end)




local tempCol = createColSphere (-108.12171936035,1126.7482910156,19.7421875, 1.5 )


function entregarcaixa ( thePlayer, matchingDimension )
    if getElementType ( thePlayer ) == "player" then --if the element that entered was player
		if isElement(objetocaixa[thePlayer]) then
		destroyElement(objetocaixa[thePlayer])
		setElementData(thePlayer,"CaixaNaMao", false)
		triggerEvent('btcMTA->#setPlayerAnimation', thePlayer, thePlayer, "carry", "putdwn", 500, false, false)
		end
    end
end
addEventHandler("onColShapeHit", tempCol, entregarcaixa)






addEvent('setAnimation', true)
addEventHandler('setAnimation', root,
function (player, anim_1, anim_2)
     if isElement(player) then
	     if anim_1 then
		     setElementFrozen(player, true)
		     setPedAnimation(player, anim_1, anim_2)
		 else
		    -- setPedAnimation(player)
			 setElementFrozen(player, false)
		 end
	 end
end)
		


function desmanchado2()
desmanche = false
end


addEvent('destroyVehicle', true)
addEventHandler('destroyVehicle', root,
function (player, vehicle)
     if isElement(vehicle) then

	     local players = getElementsByType("player")
         local player2 = nil
         for i = 1, #players do
	         player2 = players[i]
			 triggerClientEvent(player2, 'reset:remove:component', player2, vehicle)
		 end
		 setElementData(vehicle, 'vehicle:desmanche', nil)
	     setElementData(player, 'player:vehicle', nil)
		 
		 
			triggerEvent ("radio-parar", player, vehicle )
			for index, value in ipairs(getElementsByType("player")) do
				inVehicle = getPedOccupiedVehicle(value)
				if inVehicle and inVehicle == vehicle then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end
			
			timer = setTimer(desmanchado2, 60000,1)
			
			desmanche = true
			local teste = math.random(1,65535)
			setElementDimension(vehicle, teste)
    		setElementInterior(vehicle, teste)
			setVehicleEngineState(vehicle,false)
			setElementData(vehicle,"veh:motor",false)
			setVehicleLocked(vehicle,true)
			setElementData(vehicle,"veh:status",true)
			setElementData(vehicle, "radio:state", false)
			setElementData(player, "Exercicio", false)
			setElementData(vehicle, "detranAP", true)
			setElementData(player, "desmanchando", false)
			
			setElementPosition(vehicle, 2521.9270019531, -2082.6071777344, 13.546875)
			
			local dimSu = sellVehicle2[getElementModel(vehicle)][1] --math.random(20000,50000)
			if dimSu then
			if exports.bgo_items:giveItem(player, 230, 1, dimSu, 0, true) then 
			local linha = math.random(1, 255 )
			exports.bgo_hud:drawNote("Sujo"..linha.."", "+ "..dimSu.." em blocos de dinheiro!", player, 255, 255, 255, 7000) 
			triggerClientEvent(player, "onClientPlayerGiveMoney", player, dimSu)
			end
		
			outputChatBox("Foi ganho "..dimSu.." em blocos de dinheiro ao desmanchar o veiculo!",player,  255,255,255, true)
			triggerClientEvent(player, "bgo>info", player,  "Informação", "Veiculo desmanchado com sucesso valor do desmanche: "..dimSu.." ","sucesso" )
			end
			
			
		  
		 
	 end
end)

addEventHandler ( "onPlayerQuit", root,
function ()
     if getElementData(source, 'player:vehicle') then
	     local vehicle = getElementData(source, 'player:vehicle')
		 setElementData(vehicle, 'vehicle:desmanche', nil)
	     local players = getElementsByType("player")
         local player = nil
         for i = 1, #players do
	         player = players[i]
			 triggerClientEvent(player, 'reset:remove:component', player, vehicle)
		 end
	     setElementData(source, 'player:vehicle', nil)
	 end
end)