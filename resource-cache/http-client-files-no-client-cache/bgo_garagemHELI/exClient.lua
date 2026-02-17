local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}, edit={}}

function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end

function startPanel()
if not isElement(painel.window[1])  then
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 500, 400, "Garagem Heli BGO", false)
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
				triggerEvent("bgo>info", localPlayer,"Garagem BGO","Nada selecionado!", "erro")
				end
				elseif source == painel.button[2] then
				tempo = setTimer(function() end,2000,1)
				triggerServerEvent("respawnVehicleHELI", resourceRoot, localPlayer)
			end
		end
	end
)


vehicleWeight = {
	-- [VehID] = peso,
	[487] = true,
	[469] = true,
}





function gpsVehicle(commandName, vehicleId)
	if vehicleId then 
		for index, value in ipairs (getElementsByType("vehicle")) do				
			if getElementData(value, "veh:id") == tonumber(vehicleId) then			
				if not getElementData(value, "veh:owner") == getElementData(localPlayer, "char:id") then 
				   outputChatBox("#7cc576[BGO MTA] #ffffffVocê não é o dono do veículo!",0,0,0,true)	
				   return
				end
					if (getElementDimension(value) == 0) then
					outputChatBox("#7cc576[BGO MTA] #ffffffSeu veiculo não pode ser spawnado porque ja está na cidade!!",0,0,0,true)
					return
					end
			
					if vehicleWeight[getElementModel(value)] then
					triggerServerEvent("updateINTDIMGARAGEMHELI", resourceRoot,localPlayer, vehicleId)
					else
					outputChatBox("#7cc576[BGO MTA] #ffffffnão pode spawnar caminhão nesta garagem!!!",0,0,0,true)
					end
				 end
			end
		end
	end



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


function getMyVehicles()
	myVehicles = {}
	for key, value in ipairs(getElementsByType("vehicle")) do
		if getElementData(value, "veh:owner") == getElementData(localPlayer, "acc:id") then
		if vehicleWeight[getElementModel(value)] then
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

    [1] = { 1643.206, 1676.687, 10.82-0.8 }, 
    [2] = { 1410.126, -1790.039, 13.547-0.8 }, 
} 


for i = 1, #markers, 1 do
veiculos = createMarker(markers[i][1], markers[i][2],markers[i][3]-0.9, "cylinder",4.5, 255, 200, 0, 50)
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


