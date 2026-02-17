local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}, edit={}}

function startPanel()
if not isElement(painel.window[1])  then
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 500, 400, "Garagem BGO", false)
	centerWindow(painel.window[1])
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	dgs:dgsSetProperty(painel.window[1], "font", "arial")
	painel.tab[1] = dgs:dgsCreateTabPanel(2, 2, 496, 290, false, painel.window[1])
	painel.tab[2] = dgs:dgsCreateTab("Garagem", painel.tab[1])
	painel.grid[1] = dgs:dgsCreateGridList(2, 2, 492, 270, false, painel.tab[2])
	painel.column[1] = dgs:dgsGridListAddColumn(painel.grid[1], "Veiculos", 0.4)
	painel.column[2] = dgs:dgsGridListAddColumn(painel.grid[1], "ID", 0.3)
	painel.column[3] = dgs:dgsGridListAddColumn(painel.grid[1], "Condição", 0.5)
	painel.button[1] = dgs:dgsCreateButton(0, 276, 496, 35, "Pegar", false, painel.tab[2])
	painel.button[2] = dgs:dgsCreateButton(0, 316, 496, 35, "Guardar", false, painel.tab[2])
	end
end

function carregar()
		if isElement(painel.window[1]) then
		dgs:dgsGridListClear(painel.grid[1])
		for key, value in ipairs(myVehicles) do
		local row = dgs:dgsGridListAddRow(painel.grid[1])
		valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
		id = getElementData(value, "veh:id")
		condicao = ""..math.floor(getElementHealth(value) / 10 + 0.5).."%"
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], valor)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[2], id)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[3], condicao)
		end
	end
end

function gpsVehicle(commandName, vehicleId)
	if vehicleId then 
		for index, value in ipairs (getElementsByType("vehicle")) do				
			if getElementData(value, "veh:id") == tonumber(vehicleId) then			
				if not getElementData(value, "veh:owner") == getElementData(localPlayer, "char:id") then 
				   outputChatBox("#7cc576[BGO MTA] #ffffffVocê não é o dono do veículo!",0,0,0,true)	
				   return
				end
				
				    if getElementData(localPlayer, "spawn:vehicle") then
					  --  outputChatBox("#7cc576[BGO MTA] #ffffffVocê precisa guardar seu antigo veiculo para spawnar outro!!",0,0,0,true)
						triggerEvent("bgo>info", localPlayer,"Garagem BGO","Você precisa guardar seu antigo veiculo para spawnar outro!!", "erro")
                    return
					end
					if (getElementDimension(value) == 0) then
					--outputChatBox("#7cc576[BGO MTA] #ffffffSeu veiculo não pode ser spawnado porque ja está na cidade!!",0,0,0,true)
					triggerEvent("bgo>info", localPlayer,"Seu veiculo não pode ser spawnado porque ja está na cidade!", "erro")
					return
					end
					if (getElementData(value, "detranAP")) then 
					if not vehicleWeight[getElementModel(value)] then
					--outputChatBox("#7cc576[BGO MTA] #ffffffSeu veiculo está no detran!",0,0,0,true)
					triggerEvent("bgo>info", localPlayer,"Garagem BGO","Seu veiculo está no detran!", "erro")
					triggerServerEvent("SpawnarGaragemDetran", localPlayer, vehicleId)
					break
					else
					triggerEvent("bgo>info", localPlayer,"Garagem BGO","Não pode spawnar caminhão nesta garagem", "erro")
					--outputChatBox("#7cc576[BGO MTA] #ffffffnão pode spawnar caminhão nesta garagem!!!",0,0,0,true)
					break
					end
					else
					if not vehicleWeight[getElementModel(value)] then
					triggerServerEvent("SpawnarGaragem", localPlayer,localPlayer, vehicleId)
					break
					else
					triggerEvent("bgo>info", localPlayer,"Garagem BGO","Não pode spawnar caminhão nesta garagem", "erro")
					--outputChatBox("#7cc576[BGO MTA] #ffffffnão pode spawnar caminhão nesta garagem!!!",0,0,0,true)
					break
					end
				 end
			end
		end
	end
end


local preco = {}
addEventHandler("onDgsMouseClick", root,
	function(button, state)
		if button == "left" and state == "down" then
		if isTimer(tempo) then triggerEvent("bgo>info", localPlayer,"Garagem BGO", "Aguarde um pouco!", "erro") return end
			if source == painel.button[1] then
				local selected = dgs:dgsGridListGetSelectedItem(painel.grid[1])
				if selected ~= -1 then
				local name = dgs:dgsGridListGetItemText(painel.grid[1], selected, painel.column[2])
				tempo = setTimer(function() end,2000,1)
				if exports.placa:checkvalores(localPlayer) then
				gpsVehicle("gps", name)
				end
				else
				outputChatBox("Nada selecionado!", 255,0,0)
				triggerEvent("bgo>info", localPlayer,"Garagem BGO","Nada selecionado!", "erro")
				end
				elseif source == painel.button[2] then
				tempo = setTimer(function() end,2000,1)
				triggerServerEvent("GuardarVeiculo", localPlayer, localPlayer)
				
				elseif source == botao then
				local text = dgs:dgsGetText ( edit )
				if string.find(text, "%p+") then
					--exports.bgo_infobox:addNotification("Você não pode colocar caracter especial no dinheiro!","error")
					triggerEvent("bgo>info", localPlayer,"DRVV Transito | SLOTS","Você não pode colocar caracter especial na quantidade!", "erro")
					return
				end
				if string.find(text,"-") or string.find(text,"_") then
					--exports.bgo_infobox:addNotification("Não use um sinais na quantidade ","error")
					triggerEvent("bgo>info", localPlayer,"DRVV Transito | SLOTS", "Não use um sinais na quantidade", "erro")
					return
				end
				if not tonumber(text) then 
				triggerEvent("bgo>info", localPlayer,"DRVV Transito | SLOTS", "Apenas numeros!", "erro")
				return 
				end
				
				quantidadee = tonumber(text)
				preco = tonumber(text)*2000
				
				if not quantidadee == tonumber(quantidadee) then return end
				if not preco == tonumber(preco) then return end
		
				if tonumber(quantidadee) < 1 then 
				triggerEvent("bgo>info", localPlayer,"DRVV Transito | SLOTS", "Coloque a quantidade correta!", "erro")	
				return
				end
				

				fecharPainelSlots()
				ComprarSlot2()
				elseif source == botao2 then
		if not quantidadee == tonumber(quantidadee) then return end
		if not preco == tonumber(preco) then return end
		
				if tonumber(quantidadee) < 1 then 
				triggerEvent("bgo>info", localPlayer,"DRVV Transito | SLOTS", "Coloque a quantidade correta!", "erro")	
				return
				end
				
				if tonumber(getElementData(localPlayer, "char:pp") or 0) >= preco then
				triggerServerEvent("bgo:comprarslots", localPlayer, localPlayer, quantidadee, preco)
				fecharPainelSlots()
				preco = false
				quantidadee = false
				else
				triggerEvent("bgo>info", localPlayer,"DRVV Transito | SLOTS", "Você não tem PP suficiente para comprar slots", "erro")	
				end
				elseif source == botao3 then
				preco = false
				quantidadee = false
				fecharPainelSlots()
				ComprarSlot()
			end
		end
	end
)




local open = false
function fecharPainel()
		--cancelEvent()
	if isElement(painel.window[1]) then
	removeEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
		playSoundFrontEnd(20)
		destroyElement(painel.window[1])
		--showCursor(false)
		open = false
	end
end
--addEventHandler("BGO.onClosePainelG", resourceRoot, fecharPainel)


function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end
vehicleWeight = {
	-- [VehID] = peso,
	[499] = true,
	[414] = true,
	[456] = true,
	[524] = true,
	[487] = true,
	[469] = true,
}


function getMyVehicles()
	myVehicles = {}
	for key, value in ipairs(getElementsByType("vehicle")) do
		if getElementData(value, "veh:owner") == getElementData(localPlayer, "acc:id") then
		if not vehicleWeight[getElementModel(value)] then
			table.insert(myVehicles, value)
		end
		end
	end
	if myVehicles then
	if isElement(painel.window[1]) then
		dgs:dgsGridListClear(painel.grid[1])
		
		for key, value in ipairs(myVehicles) do
		local row = dgs:dgsGridListAddRow(painel.grid[1])
		valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
		id = getElementData(value, "veh:id")
		condicao = ""..math.floor(getElementHealth(value) / 10 + 0.5).."%"
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], valor)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[2], id)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[3], condicao)
		end
	end
	end
	--carregar()
end



markers = { 

    [1] = { 1907.1381835938,-1808.0466308594,13.655365943909 }, 
    [2] = { -2234.9548339844,2357.5026855469,5 }, 
	[3] = { 2121.3347167969,953.43859863281,10.81298828125 }, 
    [4] = { -1705.351, 397.892, 7.18 }, 
	[5] = { -2025.646, 139.296, 28.836 }, 
    [6] = { 559.668, -1281.141, 17.248 }, 
	[7] = { 207.356, -259.257, 1.578 }, 
    [8] = { 1395.336, 454.758, 20.065 }, 
	[9] = { -1105.509, -599.372, 32.869 }, 
	[10] = { 1479.3843994141,-1784.6329345703,12.546875 }, 
	[11] = { 2509.9304199219,2291.3012695313,09.8203125 }, 
    [12] = { 1241.2791748047,-1476.8537597656,13.548749923706 }, 
	[13] = { 2192.0322265625,2498.5871582031,10.8203125 }, 
    [14] = { 1698.644, 1622.77, 10.834 }, 
	[15] = { 2136.9155273438,1433.9739990234,09.8203125 }, 
    [16] = { 1638.5115966797,-1224.1899414063,13.831893920898 }, 
	[17] = { 2148.51, -1170.392, 23.82 }, 
    [18] = { -1829.4876708984,1293.9094238281,30.858720779419 }, 
	[19] = { 2436.3518066406,-2135.4201660156,12.546875 }, 
    [20] = { 2259.8728027344,1939.1916503906,9.8671274185181 }, 
	[21] = { 2716.0239257813,696.61450195313,09.934374809265 }, 
    [22] = { -980.35363769531,-1739.9169921875,77.247634887695 },
	[23] = { 2049.4248046875,2049.7473144531,10.8203125 },
	[24] = { 2411.05859375, -1278.6580810547, 24.176536010742 },
	[25] = { 171.298, -15.131, 1.578 },
} 
  


for i = 1, #markers, 1 do
veiculos = createMarker(markers[i][1], markers[i][2],markers[i][3]-0.9, "cylinder",2.5, 255, 200, 0, 80)
local myBlip1 = createBlipAttachedTo ( veiculos, 55 )
setElementData(myBlip1,"blipName", "BGO - Garagem")

addEventHandler( "onClientMarkerLeave", veiculos,
function( hitElement, matchingDimension )
   if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
	fecharPainel()
    end
end
)

addEventHandler( "onClientMarkerHit", veiculos, 
function( hitElement, matchingDimension )
   if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
	if not isElement(painel.window[1]) then
	startPanel()
	end
	addEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
	--showCursor(true)
	getMyVehicles()
	playSoundFrontEnd(20)
end
end
)
end



function ComprarSlot()
if not isElement(window)  then
	window = dgs:dgsCreateWindow(0, 0, 500, 265, "DRVV BGO - SLOTS", false)
	centerWindow(window)
	dgs:dgsSetProperty(window, "sizable", false)
	dgs:dgsSetProperty(window, "font", "arial")
	
	texto = dgs:dgsCreateLabel(0.16,0.04,0,0,
	[[
	    Compre seu slot para ter mais veiculo em sua garagem!
	Lembrando que os slots é apenas comprado com Dinheiro VIP
	
	       Coloque a quantidade de slots que deseja comprar!
	]]
	,true,window)
	
	texto2 = dgs:dgsCreateLabel(0.31,0.30,0.94,0.2,"Atualmente você tem " .. #myVehicles .. "/" .. getElementData(localPlayer, "char:vehSlot").." slots",true,window)	
	dgs:dgsSetFont ( texto, "default-bold" )
	dgs:dgsSetFont ( texto2, "default-bold" )
	--dgs:dgsSetFont ( texto3, "default-bold" )
	edit = dgs:dgsCreateEdit(0.3, 0.5, 0.4, 0.11, "Quantidade?", true,  window)
	botao = dgs:dgsCreateButton(2, 200, 496, 35, "Comprar", false, window)
end
end

function ComprarSlot2()
if not isElement(window)  then
	window = dgs:dgsCreateWindow(0, 0, 500, 200, "DRVV BGO - COMPRA DOS SLOTS", false)
	centerWindow(window)
	dgs:dgsSetProperty(window, "sizable", false)
	dgs:dgsSetProperty(window, "font", "arial")
	
	texto = dgs:dgsCreateLabel(0.18,0.04,0.94,0.2,
	[[
	                             Preste atenção no preço!
	Não responsabilizamos pelo gasto errado feito por você!
	              Colocou a quantidade certa? só prosseguir
	]]
	,true,window)
	
	
	texto2 = dgs:dgsCreateLabel(0.31,0.33,0.94,0.2,"Total a pagar R$: "..preco.." Por "..quantidadee.." slots",true,window)	
	dgs:dgsSetFont ( texto, "default-bold" )
	dgs:dgsSetFont ( texto2, "default-bold" )
	botao2 = dgs:dgsCreateButton(2, 95, 496, 35, "Pagar", false, window)
	botao3 = dgs:dgsCreateButton(2, 135, 496, 35, "Voltar", false, window)
end
end


local jobPed = {}
local job_PedPos = {
	{28, 2460.1032714844, -2088.8662109375, 17.454364776611, "DRVV: Slots",88.625061035156},
}
local startTick = getTickCount()
local progress = ""
local elements = ""

local maxElem = 5
local nextPage = 0
local show = false

function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:jobSlots", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:jobSlots") then
			cancelEvent ()
		end
	end
)

function fecharPainelSlots()
		--cancelEvent()
	if isElement(window) then
		removeEventHandler("onDgsWindowClose",window,fecharPainelSlots)
		playSoundFrontEnd(20)
		destroyElement(window)
		
		showCursor(false)
		show = false
		--preco = false
	end
	
end


addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:jobSlots") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 

			if not isElement(window) then
			getMyVehicles()
			ComprarSlot()
			end
			addEventHandler("onDgsWindowClose",window,fecharPainelSlots)
			showCursor(true)
			playSoundFrontEnd(20)
			show = true
	

			elements = element
		end
	end
	end
end)