local con = exports.bgo_mysql:getConnection()


sellVehicle = {
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


desmanche = false

function atmGetTimeOut ( player )
	if isTimer ( timer ) then
		local miliseconds = getTimerDetails ( timer )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end


local tempo = {}
addEvent("desmancharV", true)
addEventHandler("desmancharV", getRootElement(), function (thePlayer)
	if desmanche == true then 
	outputChatBox("Faltam "..atmGetTimeOut ( thePlayer ).." segundos para desmanchar outro veiculo!",thePlayer,  255,255,255, true)
	--triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Utilizaram desmanche demais tente mais tarde!" ) 
	return 
	end
	
	if isTimer(tempo[thePlayer]) then return end
		local v = getPedOccupiedVehicle ( thePlayer )
		if v then
		
		if getElementData(v, "veh:owner") == getElementData(thePlayer, "char:id") then	
		triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "ai ai","Bobinho você é leigo? o carro é seu!" ) 
		return
		end
		if sellVehicle[getElementModel(v)] and getElementData(v, "veh:owner") then


		--setTimer(function()
		--setVehicleDoorState ( v, 0, 4, true )
		--end,1000,1, v)


		setTimer(function()
			setVehicleDoorState ( v, 0, 4, true )
				setTimer(function()
					setVehicleDoorState ( v, 1, 4, true )
						setTimer(function()
							setVehicleDoorState ( v, 2, 4, true )
							setTimer(function()
							setVehicleDoorState ( v, 3, 4, true )
							setTimer(function()
							setVehicleDoorState ( v, 4, 4, true )
							setTimer(function()
							setVehicleDoorState ( v, 5, 4, true )
							end, 1000, 1, v)
						end, 1000, 1, v)
					end, 1000, 1, v)
				end, 1000, 1, v)
			end, 1000, 1, v)
		end, 1000, 1, v)
		
		
		
		
		setElementData(thePlayer, "Exercicio", true)
		triggerClientEvent(thePlayer, "progressService", thePlayer, 60, "#ffffffDesmanchando veiculo!")
		desmanche = true
		tempo[thePlayer] = setTimer(desmanchado, 60000,1, thePlayer, v)
		else
		setElementData(thePlayer, "desmanchando", false)
		triggerClientEvent(thePlayer, "inv:erro", thePlayer,  "Ops!","Este veiculo não pode ser desmanchado!" ) 
		end
	end
end
)

function desmanchado2()
desmanche = false
end


function desmanchado(player, veiculo)
			triggerEvent ("radio-parar", player, veiculo )
			for index, value in ipairs(getElementsByType("player")) do
				inVehicle = getPedOccupiedVehicle(value)
				if inVehicle and inVehicle == veiculo then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end
			
			
			timer = setTimer(desmanchado2, 60000,1)
			
			local dimSu = sellVehicle2[getElementModel(veiculo)][1] --math.random(20000,50000)
			if dimSu then
			if exports.bgo_items:giveItem(player, 230, 1, dimSu, 0, true) then 
			local linha = math.random(1, 255 )
			exports.bgo_hud:drawNote("Sujo"..linha.."", "+ "..dimSu.." em blocos de dinheiro!", player, 255, 255, 255, 7000) 
			triggerClientEvent(player, "onClientPlayerGiveMoney", player, dimSu)
			end
		
			outputChatBox("Foi ganho "..dimSu.." em blocos de dinheiro ao desmanchar o veiculo!",player,  255,255,255, true)
			triggerClientEvent(player, "inv:sucess", player, "Veiculo desmanchado com sucesso!" ) 
			end
			
			local teste = math.random(1,65535)
			setElementDimension(veiculo, teste)
    		setElementInterior(veiculo, teste)
			setVehicleEngineState(veiculo,false)
			setElementData(veiculo,"veh:motor",false)
			setVehicleLocked(veiculo,true)
			setElementData(veiculo,"veh:status",true)
			setElementData(veiculo, "radio:state", false)
			setElementData(player, "Exercicio", false)
			setElementData(veiculo, "detranAP", true)
			setElementData(player, "desmanchando", false)

			--local dinheiroSujo = (getElementData(player, "char:moneysujo") or 0)
			--setElementData(player, "char:moneysujo", dinheiroSujo + dimSu)
			
			setElementPosition(veiculo, 2521.9270019531, -2082.6071777344, 13.546875)
end