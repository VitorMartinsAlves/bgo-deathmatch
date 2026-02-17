local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}, edit={}}

local painelPrender = {window={}, tab={}, button={}, grid={}, column={}, edit={}}

function painelLiberar()
if not isElement(painel.window[1])  then
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 500, 400, "Liberação DRVV", false)
	centerWindow(painel.window[1])
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	dgs:dgsSetProperty(painel.window[1], "font", "arial")
	painel.tab[1] = dgs:dgsCreateTabPanel(2, 2, 496, 290, false, painel.window[1])
	painel.tab[2] = dgs:dgsCreateTab("Lista", painel.tab[1])
	painel.grid[1] = dgs:dgsCreateGridList(2, 2, 492, 270, false, painel.tab[2])
	painel.column[1] = dgs:dgsGridListAddColumn(painel.grid[1], "Veiculo", 0.4)
	painel.column[2] = dgs:dgsGridListAddColumn(painel.grid[1], "ID", 0.2)
	painel.column[3] = dgs:dgsGridListAddColumn(painel.grid[1], "Dono", 0.2)
	painel.button[1] = dgs:dgsCreateButton(0, 276, 496, 35, "Liberar", false, painel.tab[2])
	painel.button[2] = dgs:dgsCreateButton(0, 316, 496, 35, "Fechar", false, painel.tab[2])
	end
end


function painelPrenderLista()
if not isElement(painelPrender.window[1])  then
	painelPrender.window[1] = dgs:dgsCreateWindow(0, 0, 500, 400, "Apreensão DRVV", false)
	centerWindow(painelPrender.window[1])
	dgs:dgsSetProperty(painelPrender.window[1], "sizable", false)
	dgs:dgsSetProperty(painelPrender.window[1], "font", "arial")
	painelPrender.tab[1] = dgs:dgsCreateTabPanel(2, 2, 496, 290, false, painelPrender.window[1])
	painelPrender.tab[2] = dgs:dgsCreateTab("Lista", painelPrender.tab[1])
	painelPrender.grid[1] = dgs:dgsCreateGridList(2, 2, 492, 270, false, painelPrender.tab[2])
	painelPrender.column[1] = dgs:dgsGridListAddColumn(painelPrender.grid[1], "Veiculo", 0.4)
	painelPrender.column[2] = dgs:dgsGridListAddColumn(painelPrender.grid[1], "ID", 0.2)
	painelPrender.column[3] = dgs:dgsGridListAddColumn(painelPrender.grid[1], "Dono", 0.2)
	painelPrender.button[1] = dgs:dgsCreateButton(0, 276, 496, 35, "Prender", false, painelPrender.tab[2])
	painelPrender.button[2] = dgs:dgsCreateButton(0, 316, 496, 35, "Atualizar", false, painelPrender.tab[2])
	end
end


function fecharPainelLiberar()
	if isElement(painel.window[1]) then
		removeEventHandler("onDgsWindowClose",painel.window[1],fecharPainelLiberar)
		playSoundFrontEnd(20)
		destroyElement(painel.window[1])
	end
	if isElement(painelPrender.window[1]) then
		removeEventHandler("onDgsWindowClose",painelPrender.window[1],fecharPainelLiberar)
		playSoundFrontEnd(20)
		destroyElement(painelPrender.window[1])
	end
end

function PuxarLista()
if (getElementData(localPlayer, "char:dutyfaction") == 1 or getElementData(localPlayer, "acc:id") == 1) then
	if not isElement(painel.window[1]) then
		painelLiberar()
		addEventHandler("onDgsWindowClose",painel.window[1],fecharPainelLiberar)
		playSoundFrontEnd(20)
		end
		
		myVehicles = {}
		table.insert(myVehicles, value)
		for key, value in ipairs(getElementsByType("vehicle")) do
			if (getElementData(value, "detranAP")) then
				table.insert(myVehicles, value)
			end
		end

		if myVehicles then
			if isElement(painel.window[1]) then
				dgs:dgsGridListClear(painel.grid[1])
				for key, value in ipairs(myVehicles) do
				local row = dgs:dgsGridListAddRow(painel.grid[1])
				valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
				id = getElementData(value, "veh:id")
				owner = getElementData(value, "veh:oname") or ""
				dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], valor)
				dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[2], id)
				dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[3], owner)
			end
		end
	end
end
end
--addCommandHandler( "ldrvv", PuxarLista )







local jobPed = {}
local job_PedPos = {
	{26, 2472.4858398438,-2108.2404785156,13.546875, "DRVV Apreensão",268.46063232422, 1},
	{26, 2452.3679199219,-2082.4294433594,13.546875, "DRVV Liberação",358.36859130859, 2},
	

}
function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:PDRVV", true)
		jobPed[index]:setData("ped:Qual", value[7])
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:PDRVV") then
			cancelEvent ()
		end
	end
)


addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:PDRVV") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
			if (getElementData(localPlayer, "char:dutyfaction") == 1 or getElementData(localPlayer, "acc:id") == 1) then
			if element:getData("ped:Qual") == 1 then
				PrenderLista()
			elseif element:getData("ped:Qual") == 2 then
				PuxarLista()
			end
				elements = element
			else
			 triggerEvent("bgo>info", localPlayer,"DRVV BGO", "Somente DRVV tem acesso aqui!", "erro") 
				end
			end
		end
	end
end
)


local detranZ = createColCuboid(2463.77344, -2144.27734, 10.52241, 76.55078125, 78.38720703125, 35.899960899353)

function PrenderLista()
	if (getElementData(localPlayer, "char:dutyfaction") == 1 or getElementData(localPlayer, "acc:id") == 1) then
			if not isElement(painelPrender.window[1]) then
			painelPrenderLista()
			addEventHandler("onDgsWindowClose",painelPrender.window[1],fecharPainelLiberar)
			playSoundFrontEnd(20)
			end

			myVehicles2 = {}
			
			for key, value in ipairs(getElementsByType("vehicle")) do
				local detection = isElementWithinColShape ( value, detranZ )
				if detection then
				if getElementDimension(value) == 0  then
					--if ( getElementData(value, "detranAP")) then
						table.insert(myVehicles2, value)
					end
				end
			end

			if myVehicles2 then
				if isElement(painelPrender.window[1]) then
					dgs:dgsGridListClear(painelPrender.grid[1])
					for key, value in ipairs(myVehicles2) do
					local row = dgs:dgsGridListAddRow(painelPrender.grid[1])
					valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
					id = getElementData(value, "veh:id")
					owner = getElementData(value, "veh:oname") or ""
					dgs:dgsGridListSetItemText(painelPrender.grid[1], row, painelPrender.column[1], valor)
					dgs:dgsGridListSetItemText(painelPrender.grid[1], row, painelPrender.column[2], id)
					dgs:dgsGridListSetItemText(painelPrender.grid[1], row, painelPrender.column[3], owner)
				end
			end
		end
	end
end

addEventHandler("onDgsMouseClick", root,
	function(button, state)
		if button == "left" and state == "down" then
		if isTimer(tempo) then triggerEvent("bgo>info", localPlayer,"DRVV BGO", "Aguarde um pouco!", "erro") return end
			if source == painel.button[1] then
				local selected = dgs:dgsGridListGetSelectedItem(painel.grid[1])
				if selected ~= -1 then
				local name = dgs:dgsGridListGetItemText(painel.grid[1], selected, painel.column[2])
				tempo = setTimer(function() end,2000,1)
				liberar(name)
				PuxarLista()
				else
				outputChatBox("Nada selecionado!", 255,0,0)
				triggerEvent("bgo>info", localPlayer,"DRVV BGO","Nada selecionado!", "erro")
				end
				elseif source == painel.button[2] then
				tempo = setTimer(function() end,2000,1)
				fecharPainelLiberar()
				end
				
				if source == painelPrender.button[1] then
				local selected = dgs:dgsGridListGetSelectedItem(painelPrender.grid[1])
				if selected ~= -1 then
				local name = dgs:dgsGridListGetItemText(painelPrender.grid[1], selected, painelPrender.column[2])
				tempo = setTimer(function() end,2000,1)
				prender(name)
				fecharPainelLiberar()
				else
				outputChatBox("Nada selecionado!", 255,0,0)
				triggerEvent("bgo>info", localPlayer,"DRVV BGO","Nada selecionado!", "erro")
				end

				elseif source == painelPrender.button[2] then
				tempo = setTimer(function() end,2000,1)
				PrenderLista()
				end
			
		end
	end
)

function liberar(vehicleId)
	if vehicleId then 
		for index, value in ipairs (getElementsByType("vehicle")) do				
			if getElementData(value, "veh:id") == tonumber(vehicleId) then			
				triggerServerEvent("LiberarVeiculoDRVV", localPlayer, localPlayer, value)
				break
			end
		end
	end
end

function prender(vehicleId)
	if vehicleId then 
		for index, value in ipairs (getElementsByType("vehicle")) do				
			if getElementData(value, "veh:id") == tonumber(vehicleId) then			
				triggerServerEvent("PrenderVeiculoDRVV", localPlayer, localPlayer, value)
				break
			end
		end
	end
end




function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end