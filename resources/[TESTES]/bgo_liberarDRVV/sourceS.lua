addEvent("LiberarVeiculoDRVV", true)
addEventHandler("LiberarVeiculoDRVV", root, 
function (player, veiculo)
			for index, value in ipairs(getElementsByType("player")) do
				inVehicle = getPedOccupiedVehicle(value)
				if inVehicle and inVehicle == veiculo then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end
			setElementDimension(veiculo, 0)
    		setElementInterior(veiculo, 0)
			
			setElementPosition(veiculo, 2443.8137207031,-2072.8864746094,12.956697463989)
			setElementRotation(veiculo, 0,0,178.9578704834)
			setVehicleEngineState(veiculo,false)
			setElementData(veiculo,"veh:motor",false)
			setVehicleLocked(veiculo,true)
			setElementData(veiculo,"veh:status",true)
			setElementData(veiculo, "radio:state", false)
			setElementData(veiculo, "detranAP", false)
			triggerClientEvent(player, "inv:sucess", player, "Veiculo liberado com sucesso!" ) 
	end
)



addEvent("PrenderVeiculoDRVV", true)
addEventHandler("PrenderVeiculoDRVV", root, 
function (player, veiculo)
			for index, value in ipairs(getElementsByType("player")) do
				inVehicle = getPedOccupiedVehicle(value)
				if inVehicle and inVehicle == veiculo then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end
			
			local teste = math.random(1,65535)
			setElementDimension(veiculo, teste)
    		setElementInterior(veiculo, teste)
			setVehicleEngineState(veiculo,false)
			setElementData(veiculo,"veh:motor",false)
			setVehicleLocked(veiculo,true)
			setElementData(veiculo,"veh:status",true)
			setElementData(veiculo, "radio:state", false)
			setElementData(veiculo, "detranAP", true)
			triggerClientEvent(player, "inv:sucess", player, "Veiculo apreendido com sucesso!" ) 
	end
)