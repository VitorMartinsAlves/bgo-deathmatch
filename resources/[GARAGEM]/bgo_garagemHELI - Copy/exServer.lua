
vehicleWeight = {
	-- [VehID] = peso,
	[487] = true,
}


addEvent("updateINTDIMGARAGEMHELI", true)
addEventHandler("updateINTDIMGARAGEMHELI", getRootElement(), function (thePlayer, vehicleId)
		for index, value in ipairs (getElementsByType("vehicle")) do			
			if getElementData(value, "veh:id") == tonumber(vehicleId) then 
				if getElementData(value, "veh:owner") == getElementData(thePlayer, "char:id") then
				
					
					
					for index, value2 in ipairs (getElementsByType("vehicle")) do
					if vehicleWeight[getElementModel(value2)] then
					
					if tem(thePlayer, value2) then 
					return 
					end
					
					end
					end
				
					setElementInterior(value,0) 
					setElementDimension(value,0) 
					local x, y, z = getElementPosition(thePlayer)
					setElementPosition(value, x, y, z)
					setElementVelocity(value, 0, 0, 0)
					
					local rotx,roty,rotz = getElementRotation ( thePlayer )
					setVehicleRotation ( value, rotx, roty, rotz )
					warpPedIntoVehicle(thePlayer,value)
					setVehicleEngineState(value,true)
					setElementData(value,"veh:motor",true)
			end
		end
	end
end
)

function tem(thePlayer, value)	
	if getElementDimension(value) == 0 then
	if getElementData(value, "veh:owner") == getElementData(thePlayer, "char:id") then	
	
	outputChatBox("#7cc576[BGO MTA] #ffffffVocê precisa guardar seu antigo veiculo para spawnar outro.",thePlayer, 0,0,0,true)
	return true
	else
	return false
	end		
	end
end


addEvent("respawnVehicleHELI", true)
addEventHandler("respawnVehicleHELI", getRootElement(), function (thePlayer)
		    local v = getPedOccupiedVehicle ( thePlayer )
			if v then
			if getElementData(v, "veh:owner") == getElementData(thePlayer, "acc:id") then
			for index, value in ipairs(getElementsByType("player")) do
				inVehicle = getPedOccupiedVehicle(value)
				if inVehicle and inVehicle == v then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end
			local teste = math.random(1,65535)
			setElementDimension(v, teste)
    		setElementInterior(v, teste)
			setVehicleEngineState(v,false)
			setElementData(v,"veh:motor",false)
			setVehicleLocked(v,true)
			setElementData(v,"veh:status",true)
			outputChatBox("#7cc576[BGO MTA] #ffffffVeiculo guardado com sucesso.", thePlayer ,0,0,0,true)
			setElementData(v, "radio:state", false)
			else
			outputChatBox("#7cc576[BGO MTA] #ffffffVocê não é o dono do veículo!",thePlayer,0,0,0,true)	
		end
			else
			outputChatBox("#7cc576[BGO MTA] #ffffffVocê precisa estar dentro de um de seus veiculo para guardar!",thePlayer,0,0,0,true)
		end
	
	
	

end
)


