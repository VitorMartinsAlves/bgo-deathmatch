--Scriptet Írta: Csoki
if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end

	
	
	
function displayLoadedRes()

setTimer(function()
-- HOSPITAIS

	local medico = createBlip(334.054, -1520.198, 35.858, 22)
	setElementData(medico ,"blipName", "Hospítal BGO")
	
	local medico2 = createBlip(1607.87, 1834.246, 13.293, 22)
	setElementData(medico2 ,"blipName", "Hospítal BGO LV")

-- ENTRETENIMENTO

	--local blipPiscina1 = createBlip(1913.9410400391,-1425.1060791016,21.366991043091, 21 )
	--setElementData(blipPiscina1 ,"blipName", "Parque BGO")
	
	local blipPiscina1 = createBlip(1501.9035644531,750.18902587891,10.897898674011, 21 )
	setElementData(blipPiscina1 ,"blipName", "Igreja de LV")
	
	local blipPiscina1 = createBlip(1551.4538574219,-1766.6059570313,22.746885299683, 21 )
	setElementData(blipPiscina1 ,"blipName", "Entretenimento")
	
	local boate = createBlip(2543.1530761719,1031.0069580078,11.633570671082, 12 )
	setElementData(boate ,"blipName", "Boate Dos Crias LV")
	
	local boate2 = createBlip(2421.3518066406,-1236.8354492188,27.63357925415, 12 )
	setElementData(boate2 ,"blipName", "Boate Dos Crias LS")

-- COMPRAS

	local blipMascaras = createBlip(2244.7780761719,-1679.9641113281,15.478799819946, 7 )
	setElementData(blipMascaras ,"blipName", "Loja de Mascaras")
	
	local martelo = createBlip(995.23333740234,-1299.6437988281,13.389896392822, 40)
	setElementData(martelo ,"blipName", "Mercado Negro!")
 

-- BANCOS 

	local banco = createBlip(1464.4305419922, -999.56317138672, 26.818206787109, 52)
	setElementData(banco ,"blipName", "BGO Bank LS")
setBlipColor ( banco, 255, 255, 255, 255 )

	local banco2 = createBlip(2413.9780273438,1123.7436523438,10.8203125, 52)
	setElementData(banco2 ,"blipName", "BGO Bank LV")
setBlipColor ( banco2, 255, 255, 255, 255 )

-- SERVIÇOS

	--local oficina5 = createBlip(2440.2954101563,-2089.4858398438,13.546875, 24)
	--setElementData(oficina5 ,"blipName", "DRVV Pátio")


	local oficina3 = createBlip(2446.6772460938,-2125.7348632813,13.546875, 24)
	setElementData(oficina3 ,"blipName", "DRVV Habilitação")


	local preflv = createBlip(2434.852, 2376.788, 11.513, 44)
	setElementData(preflv ,"blipName", "Prefeitura LV")
	
		local prefls = createBlip(1127.3492431641,-1709.1652832031,17.152893066406, 44)
	setElementData(prefls ,"blipName", "Prefeitura LS")
	

	
	local cartorio = createBlip(2080.58984375,2064.3493652344,10.828749656677, 43)
	setElementData(cartorio ,"blipName", "Cartório")

	local oficina = createBlip(2782.251953125,-1614.7406005859,10.921875, 63)
	setElementData(oficina ,"blipName", "BGO Tunagem")

	--local exttaxi1 = createBlip(1560.6265869141,-1718.9327392578,13.546875, 53) --do lado da dp
	--setElementData(exttaxi1 ,"blipName", "Ponto de Taxi")
	
	--local exttaxi2 = createBlip(1183.6979980469,-1734.0354003906,13.39430809021, 53) --antiga prefeitura
	--setElementData(exttaxi2 ,"blipName", "Ponto de Taxi")
	
	--local exttaxi3 = createBlip(1281.4544677734,-1332.4348144531,13.375058174133, 53) --ao lado do exercito
	--setElementData(exttaxi3 ,"blipName", "Ponto de Taxi")
	
-- TRABALHOS


	local mecanico = createBlip(2844.41, -1541.473, 11.099, 42)
	setElementData(mecanico ,"blipName", "Trabalho de Mecânico")

	local ifood = createBlip(2102.6655273438,-1806.8385009766,13.5546875, 42)
	setElementData(ifood ,"blipName", "Trabalho de Ifood")


	local TValores = createBlip(1534.048828125,-1448.1882324219,13.3828125, 42)
	setElementData(TValores ,"blipName", "Trabalho de Eletricista")
	
	

	local TValores = createBlip(1537.7969970703,-1018.7615356445,24.078125, 42)
	setElementData(TValores ,"blipName", "Trabalho de T. De Valores")


	--[[
-- ESTACIONAMENTOS

	local shop = createBlip(1524.9227294922,-1527.6099853516,13.333889961243,38)
	setElementData(shop ,"blipName", "Estacionamento")

	local shop = createBlip(1479.3961181641,-1741.6561279297,19.146894454956,38) -- estacionamento dp
	setElementData(shop ,"blipName", "Estacionamento")

	local shop = createBlip(1626.9455566406,-1208.1741943359,14.843851089478,38)
	setElementData(shop ,"blipName", "Estacionamento")

	local shop = createBlip(1255.7042236328,-1466.5551757813,13.548749923706,38)
	setElementData(shop ,"blipName", "Estacionamento")

	local shop = createBlip(2129.6765136719,1403.4437255859,11.1328125,38)
	setElementData(shop ,"blipName", "Estacionamento")
	
	local shop = createBlip(2501.5620117188,2379.6860351563,10.8203125,38) --pref lv
	setElementData(shop ,"blipName", "Estacionamento")
	
	local shop = createBlip(2715.9760742188,718.13684082031,11.106249809265,38) --pedreiro lv
	setElementData(shop ,"blipName", "Estacionamento")
]]--

	local blipPiscina2 = createBlip(1601.0799560547,1585.9237060547,10.8203125, 5 )
	setElementData(blipPiscina2 ,"blipName", "HELIPONTO")
	
	local blipPiscina3 = createBlip(1524.5822753906,-1501.5030517578,13.655365943909, 5 )
	setElementData(blipPiscina3 ,"blipName", "HELIPONTO")
	
	local blipMINERADORA = createBlip(1058.6710205078,-61.211055755615,23.302772521973, 26 )
	setElementData(blipMINERADORA ,"blipName", "MINERADORA")

	local blipVIP = createBlip(2099.5397949219,1331.5151367188,10.8203125, 51 )
	setElementData(blipVIP ,"blipName", "CARROS VIPs")
	
	
	
	
	-- lixao
	
		local lixao = createBlip(2486.2492675781, -1668.0031738281, 14.646727561951, 61, 1 , 7, 212, 0, 255)
	setElementData(lixao ,"blipName", "Grove")
	setBlipColor(lixao, 7, 212, 0, 255)
	
	-- CV
	
	local CV = createBlip(2165.2517089844, -1004.7407836914, 63.74670791626, 61, 1 ,255, 0, 0, 255)
	setElementData(CV ,"blipName", "C.V")
	setBlipColor(CV, 255, 0, 0, 255)

	local pcc = createBlip(1694.3635253906, -2112.7075195313, 13.446563720703, 61, 1 ,255, 255, 255, 255)
	setElementData(pcc ,"blipName", "P.C.C")
	setBlipColor(pcc, 255, 255, 255, 255)
	
	

	--exports.bgo_Symbol:addSymbol("cv", 2415.1125488281,-829.32189941406,115.16874694824, "door", true, 0, true)
	


		
		

local blips = getElementsByType("blip")

for index, blip in ipairs(blips) do
	setBlipVisibleDistance(blip, 250)
end

end,1000,1)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )



	

	