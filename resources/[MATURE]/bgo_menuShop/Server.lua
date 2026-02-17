--local Marker1 = createMarker(1348.7099609375, -1762.9429931641, 13.549824714661 -1, "cylinder", 2, 200, 150, 0, 0)


amount = 3
local element = {}
allAmbiMarkers = {}
ambiMarkers = { 
	[1] = {359.48489379883,-2031.9790039063,7.7359375},
    [2] = {935.00024414063, -1356.1656494141, 13.343712806702},
    [3] = {1926.5078125,-1764.0018310547,13.555365943909},  -- para o novo local criado pelo valter
   	[4] = {2394.5078125, -1905.37109375, 13.556812286377},
    [5] = {2855.381, 2430.612, 11.083},
    [6] = {2384.3869628906,2079.3500976563,10.842040061951},
    [7] = {2648.0893554688,1866.6785888672,11.034210205078},
    [8] = {2097.6865234375,2239.5634765625,11.030031204224},
    [9] = {1941.6203613281,2302.8957519531,10.844325065613},
    [10] = {2354.2407226563,2548.4799804688,10.837710380554},
    [11] = {2329.3525390625,6.2583117485046,26.521263122559},
    [12] = {2353.9924316406,69.272331237793,22.308109283447},
    [13] = {1380.749, 239.777, 19.568},
    [14] = {205.192, -186.562, 1.585},
    [15] = {2644.6572265625,1668.4836425781,11.028012275696},
    [16] = {-2156.22265625,-2449.9765625,30.850011825562}, 
    [17] = {2198.7280273438,1986.8363037109,12.297924995422},
    [18] = {251.11239624023,-57.005558013916,1.5703125},
    [19] = {663.77453613281,-568.50592041016,16.343263626099},
    [20] = {301.11090087891,-1551.5383300781,36.0390625},
    [21] = {2121.0869140625,-1811.2785644531,13.461710357666},
    [22] = {1683.9119873047,-1261.2683105469,14.815582275391},
    [23] = {1004.8141479492,-923.00958251953,42.328125},   
    [24] = {2413.9714355469,-1502.7836914063,24.009855270386},  	
    [25] = {1684.0915527344,-2288.5502929688,-1.2326006889343},  
    [26] = {664.6611328125,-1866.1820068359,5.4609375},  
	[27] = {1234.5808105469,-1463.2061767578,13.548749923706},
	[28] = {2141.0476074219,-1161.4659423828,23.9921875}, --maquina perto da antiga prefeitura
	[29] = {1945.2729492188,-1382.8665771484,18.478125},
	[30] = {1799.4897460938,-1117.8035888672,23.985935592651},
	[31] = {1312.513671875,-885.70794677734,39.478125},
	[32] = {2144.6096191406,1440.2861328125,10.8203125},	
	[33] = {1552.1214599609,-1795.5860595703,17.758363723755},		
	[34] = {2450.087890625,-2073.9479980469,13.546875},	
	[35] = {2830.2849121094,-1521.6857910156,11.270147323608},	
	[36] = {2451.7358398438,2399.1293945313,12.296487808228},
	[37] = {1617.3876953125,1813.0269775391,10.87343788147},
	[38] = {2087.1267089844,2094.669921875,10.827750205994}, --cartorio de lv
	[39] = {2647.7111816406,1128.3559570313,11.1796875},
	[40] = {2699.91796875,758.65179443359,10.934374809265}, -- estacionamento lv	
}



for i = 1, #ambiMarkers, 1 do
element["MARKERPRO"..i] = createMarker(ambiMarkers[i][1], ambiMarkers[i][2],ambiMarkers[i][3]-0.8, "cylinder",1, 255, 200, 0, 100)
local m = element["MARKERPRO"..i]


local myBlip = createBlipAttachedTo ( m, 56 )
setElementData(myBlip ,"blipName", "Comércio")

addEventHandler("onMarkerHit",m,
function(hitElement)
if (getElementType(hitElement) == "player") then
		if not isPedInVehicle(hitElement) then
            triggerClientEvent(hitElement,"LOJAMIDAON",hitElement)
            
			
			exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(hitElement).." ABRIU A LOJA DE ALIMENTOS`")
			
			
            triggerClientEvent(hitElement,"JoinQuitGtaV:notifications", hitElement,"comida", "Pressione M e clique no item desejado para comprar!", 10 )

	end
end
end)

addEventHandler("onMarkerLeave",m,
function(hitElement)
if (getElementType(hitElement) == "player") then
		if not isPedInVehicle(hitElement) then
			triggerClientEvent(hitElement,"LOJAMIDAOFF",hitElement)
	end
end
end)
end

addEvent("Hamburguer",true)
addEventHandler("Hamburguer",root,
function(quant)
   --outputChatBox("Suco de laranja x1", source)  


    money = getElementData(source,"char:money") or 0
    if money >= quant * 15 then
               if exports.bgo_items:giveItem(source, 1, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Hamburguer"..linha.."", "Hamburguer comprado com sucesso", source, 255, 255, 255, 7000)
                setElementData(source, "char:money", money - quant * 15)
               else
                   outputChatBox("", source)  
               end
       end


end)


addEvent("Tacos",true)
addEventHandler("Tacos",root,
function(quant)
   --outputChatBox("Suco de laranja x1", source)  


    money = getElementData(source,"char:money") or 0
    if money >= quant * 15 then
               if exports.bgo_items:giveItem(source, 2, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Tacos"..linha.."", "Tacos comprado com sucesso", source, 255, 255, 255, 7000)
                setElementData(source, "char:money", money - quant * 15)
               else
                   outputChatBox("", source)  
               end
       end


end)

addEvent("Pizza",true)
addEventHandler("Pizza",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 15 then
              if exports.bgo_items:giveItem(source, 5, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
               -- exports.bgo_items:addPhone(source)
               -- executeCommandHandler("celular123123123", source)
                exports.bgo_hud:drawNote("Pizza"..linha.."", "Pizza - Cola comprada com sucesso", source, 255, 255, 255, 7000)
                   setElementData(source, "char:money", money - quant * 15)
               else
                   outputChatBox("", source)  
             end
       end


end)

addEvent("Suco",true)
addEventHandler("Suco",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 15 then
              if exports.bgo_items:giveItem(source, 7, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
               -- exports.bgo_items:addPhone(source)
               -- executeCommandHandler("celular123123123", source)
                exports.bgo_hud:drawNote("Suco"..linha.."", "Suco de laranja comprada com sucesso", source, 255, 255, 255, 7000)
                   setElementData(source, "char:money", money - quant * 15)
               else
                   outputChatBox("", source)  
             end
       end


end)

addEvent("Celular",true)
addEventHandler("Celular",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 1500 then
             if exports.bgo_items:giveItem(source, 16, math.random(11111111,99999999), 1, 0, true) then 
                local linha = math.random(1, 255 )
               --exports.mta_phone:addPhone(source)
               -- executeCommandHandler("celular123123123", source)
                exports.bgo_hud:drawNote("Celular"..linha.."", "Celular comprado com sucesso", source, 255, 255, 255, 7000)
                   setElementData(source, "char:money", money - 1500)
               --else
               --    outputChatBox("", source)  
            end
       end


end)



--[[


local agencia = createColCuboid(1159.85657, -1697.35083, 11.62815, 20.1396484375, 24.8876953125, 8.7000259399414)


function ColShapeHitagencia ( thePlayer, matchingDimension )
	local detection = isElementWithinColShape ( thePlayer, agencia )

	detection = detection and getElementDimension( thePlayer ) == getElementDimension( agencia )
	if detection then
        triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"agencia", "Pressione M e clique no NPC desejado com botão esquerdo ou direito do mouse para interagir!", 15 )
	end

end
addEventHandler ( "onColShapeHit", agencia, ColShapeHitagencia )







--local safe = createColCuboid(1401.56531, -1835.44092, 9.66384, 157.29138183594, 92.047241210938, 48.400066757202)
local safe = createColCuboid(1399.06677, -1862.11011, 12.21111, 160.49841308594, 119.70886230469, 31.79991569519)

function ColShapeHitsafe ( thePlayer, matchingDimension )
	local detection = isElementWithinColShape ( thePlayer, safe )

	detection = detection and getElementDimension( thePlayer ) == getElementDimension( safe )
	if detection then
        triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"safe", "Você acaba de entrar em uma zona safe!", 10 )
	end

end
addEventHandler ( "onColShapeHit", safe, ColShapeHitsafe )

addEventHandler("onResourceStart", root, function()
     if not isTimer(verificationTimer) then
	     verificationTimer = setTimer(frozenVehicle, 5000, 0)
	 end
end)

function frozenVehicle()
     for index, Car in pairs(getElementsWithinColShape(safe, "vehicle")) do
	     if getElementType(Car) == "vehicle" then 
         local counter = 0
         for seat, player in pairs(getVehicleOccupants(Car)) do
             counter = counter + 1
         end
             speedx, speedy, speedz = getElementVelocity ( Car )
    		 actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) -- can be: math.sqrt(speedx^2 + speedy^2 + speedz^2)
             mps = actualspeed * 50
             kmh = actualspeed * 180
             mph = actualspeed * 111.847
    		 veloci = math.floor(mps)
             if (veloci <= 0) then
			     if (getElementDimension(Car) == 0) then
				     if (counter == 0) then
					     if not getElementModel(Car) == 471 then
    		                 setElementFrozen(Car, true)
							 else
							 setElementFrozen(Car, false)
						 end
    		    	 end
				 end
			 end
         end	     
	 end
end



local postodegasolina = createColCuboid(1925.09058, -1852.89294, 12.17624, 25.548706054688, 17.860717773438, 4.5000127792358)


function ColShapeHitpostodegasolina ( thePlayer, matchingDimension )
	local detection = isElementWithinColShape ( thePlayer, postodegasolina )

	detection = detection and getElementDimension( thePlayer ) == getElementDimension( postodegasolina )
	if detection then
        triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"postodegasolina", "Bem vindo a Conveniência BGO, Pressione M e clique no NPC desejado com botão esquerdo ou direito do mouse para interagir!", 15 )
	end

end
addEventHandler ( "onColShapeHit", postodegasolina, ColShapeHitpostodegasolina )

]]--


