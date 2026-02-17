addEvent("Hamburguer",true)
addEventHandler("Hamburguer",root,
function(quant)
   --outputChatBox("Suco de laranja x1", source)  


    money = getElementData(source,"char:money") or 0
    if money >= quant * 25 then
               if exports.bgo_items:giveItem(source, 1, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Hamburguer"..linha.."", "Hamburguer comprado com sucesso", source, 255, 255, 255, 7000)
				
				
				--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(source).." Comprou Hamburguer`")
				
				
				
                setElementData(source, "char:money", money - quant * 25)
               else
                   outputChatBox("", source)  
               end
       end


end)


addEvent("Taco",true)
addEventHandler("Taco",root,
function(quant)
   --outputChatBox("Suco de laranja x1", source)  


    money = getElementData(source,"char:money") or 0
    if money >= quant * 20 then
               if exports.bgo_items:giveItem(source, 2, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Tacos"..linha.."", "Tacos comprado com sucesso", source, 255, 255, 255, 7000)
				
				--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(source).." Comprou Taco`")
				
				
                setElementData(source, "char:money", money - quant * 20)
               else
                   outputChatBox("", source)  
               end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
					
       end


end)

addEvent("Pizza2",true)
addEventHandler("Pizza2",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 35 then
              if exports.bgo_items:giveItem(source, 5, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
               -- exports.bgo_items:addPhone(source)
               -- executeCommandHandler("celular123123123", source)
                exports.bgo_hud:drawNote("Pizza"..linha.."", "Pizza comprada com sucesso", source, 255, 255, 255, 7000)
				
				--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(source).." Comprou Pizza`")
				
				
                   setElementData(source, "char:money", money - quant * 35)
               else
                   outputChatBox("", source)  
             end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
				
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
				
				--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(source).." Comprou Suco`")
				
				
                   setElementData(source, "char:money", money - quant * 15)
               else
                   outputChatBox("", source)  
             end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
				
       end


end)

addEvent("Celular",true)
addEventHandler("Celular",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 2000 then
             if exports.bgo_items:giveItem(source, 16, math.random(11111111,99999999), quant, 0, true) then 
                local linha = math.random(1, 255 )
               --exports.mta_phone:addPhone(source)
               -- executeCommandHandler("celular123123123", source)
                exports.bgo_hud:drawNote("Celular"..linha.."", "Celular comprado com sucesso", source, 255, 255, 255, 7000)
				
				--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(source).." Comprou Celular`")
				
				
                   setElementData(source, "char:money", money - quant * 2000)
               --else
               --    outputChatBox("", source)  
            end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
				
       end


end)

addEvent("Energetico",true)
addEventHandler("Energetico",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 3000 then
             if exports.bgo_items:giveItem(source, 17, math.random(11111111,99999999), quant, 0, true) then 
                local linha = math.random(1, 255 )
               --exports.mta_phone:addPhone(source)
               -- executeCommandHandler("celular123123123", source)
                exports.bgo_hud:drawNote("Celular"..linha.."", ""..quant.." Energetico comprado com sucesso", source, 255, 255, 255, 7000)
				
				--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMPRANDO ALIMENTO]: "..getPlayerName(source).." Comprou Celular`")
				
				
                   setElementData(source, "char:money", money - quant * 3000)
               --else
               --    outputChatBox("", source)  
            end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
				
       end


end)



addEvent("Radinho",true)
addEventHandler("Radinho",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 5000 then
             if exports.bgo_items:giveItem(source, 20, math.random(11111111,99999999), quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Radinho"..linha.."", "Radinho comprado com sucesso", source, 255, 255, 255, 7000)
                   setElementData(source, "char:money", money - quant * 5000) 
            end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
				
       end


end)






addEvent("Mochila",true)
addEventHandler("Mochila",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 10000 then
             if exports.bgo_items:giveItem(source, 150, math.random(11111111,99999999), quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Mochila"..linha.."", "Mochila comprado com sucesso", source, 255, 255, 255, 7000)
                   setElementData(source, "char:money", money - 10000) 
            end
			else
		triggerClientEvent(source, "bgo>info", source,"Ops!", "Infelizmente você não tem dinheiro suficiente!", "erro")
				
       end


end)














amount = 3
local element = {}
allAmbiMarkers = {}
ambiMarkers = { 
	--[1] = {1928.2550048828, -1768.8553466797, 13.655365943909},
   -- [2] = {1233.5521240234, -1463.2905273438, 13.548749923706},
	--[3] = {935.09136962891, -1358.9094238281, 13.351056098938},
	--[4] = {301.02395629883, -1551.84765625, 36.0390625},
	--[5] = {1004.5015869141, -922.95172119141, 42.328125},
	[1] = {359.48489379883,-2031.9790039063,7.8359375},
    [2] = {935.00024414063, -1356.1656494141, 13.343712806702},
    [3] = {1926.5078125,-1764.0018310547,13.655365943909},  -- para o novo local criado pelo valter
   	[4] = {2394.5078125, -1905.37109375, 13.556812286377},
    [5] = {2855.381, 2430.612, 11.083},
    [6] = {2384.3869628906,2079.3500976563,10.842040061951},
    [7] = {2648.0893554688,1866.6785888672,11.034210205078},
    [8] = {2097.6865234375,2239.5634765625,11.030031204224},
    [9] = {1941.6203613281,2302.8957519531,10.844325065613},
    [10] = {2354.2407226563,2548.4799804688,10.837710380554},
    [11] = {2329.3525390625,6.2583117485046,26.521263122559},
    [12] = {2353.9924316406,69.272331237793,22.308109283447},
    [13] = {1436.005, -988.257, 31.067}, -- banco LS
    [14] = {205.192, -186.562, 1.585},
    [15] = {2644.6572265625,1668.4836425781,11.028012275696},
    [16] = {-2156.22265625,-2449.9765625,30.850011825562}, 
    [17] = {2198.7280273438,1986.8363037109,12.297924995422},
    [18] = {251.11239624023,-57.005558013916,1.5703125},
    [19] = {663.77453613281,-568.50592041016,16.343263626099},
    [20] = {301.11090087891,-1551.5383300781,36.0390625},
    [21] = {2121.0869140625,-1811.2785644531,13.561710357666},
    [22] = {1683.9119873047,-1261.2683105469,14.815582275391},
    [23] = {1004.8141479492,-923.00958251953,42.328125},   
    [24] = {2413.9714355469,-1502.7836914063,24.009855270386},  	
    [25] = {1684.0915527344,-2288.5502929688,-1.2326006889343},  --aeroproto assalto
    [26] = {664.6611328125,-1866.1820068359,5.4609375}, --academia praia 
	[27] = {1234.5808105469,-1463.2061767578,13.548749923706}, -- posto meio
	[28] = {2141.0476074219,-1161.4659423828,23.9921875}, --maquina perto da antiga prefeitura
	[29] = {1945.2729492188,-1382.8665771484,18.478125},--parque BGO
	[30] = {-1675.974, 431.881, 7.18}, -- posto SF
	[31] = {1312.835, -885.736, 39.578}, -- BASE RESGATE
	[32] = {2144.6096191406,1440.2861328125,10.8203125}, --CENTRO MEIO
	[33] = {1552.1214599609,-1795.5860595703,17.758363723755},	--estacionamento centro
	[34] = {2450.087890625,-2073.9479980469,13.546875},	-- detran
	[35] = {2830.2849121094,-1521.6857910156,11.270147323608},--tuning	
	[36] = {2451.7358398438,2399.1293945313,12.296487808228},--prefeitura de LA
	[37] = {1617.3876953125,1813.0269775391,10.87343788147}, --HOSPITAL LA
	[38] = {2087.1267089844,2094.669921875,10.827750205994}, --cartorio de lv
	[39] = {2647.7111816406,1128.3559570313,11.1796875},-- POSTO PERTO DO PEDREIRO
	[40] = {2699.91796875,758.65179443359,10.934374809265}, -- PEDREIRO

		
}



for i = 1, #ambiMarkers, 1 do
element["MARKERPRO"..i] = createMarker(ambiMarkers[i][1], ambiMarkers[i][2],ambiMarkers[i][3]-0.9, "cylinder",1, 255, 200, 0, 100)
local m = element["MARKERPRO"..i]


local myBlip = createBlipAttachedTo ( m, 56 )
setElementData(myBlip ,"blipName", "Comércio")

addEventHandler("onMarkerHit",m,
function(hitElement)
if (getElementType(hitElement) == "player") then
		if not isPedInVehicle(hitElement) then
            triggerClientEvent(hitElement,"LOJAMIDAON",hitElement)


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