local connection = exports.bgo_mysql:getConnection()


vehicleWeight = {
	-- [VehID] = peso,
	[499] = true,
	[414] = true,
	[456] = true,
	[524] = true,
}

addEvent("bgo:comprarslots", true)
addEventHandler("bgo:comprarslots", getRootElement(), function (thePlayer, quantidade, preco)
		if tonumber(quantidade) < 1 then 
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | SLOTS", "Coloque a quantidade correta!", "erro")
		return 
		end
		
		if not quantidade == tonumber(quantidade) then 
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | SLOTS", "Coloque a quantidade correta!", "erro")
		return 
		end
		
		if not preco == tonumber(preco) then
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | SLOTS", "Ocoreu um problema, tente novamente mais tarde!!", "erro")		
		return 
		end
		
		if tonumber(getElementData(thePlayer, "char:pp") or 0) >= preco then		
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | SLOTS", "Você comprou "..quantidade.." slots por R$: "..preco.." PP ", "sucesso")					
		setElementData(thePlayer, "char:pp", getElementData(thePlayer, "char:pp") - preco)
		local slot = getElementData(thePlayer, "char:vehSlot") or 0
		setElementData(thePlayer, "char:vehSlot", tonumber(slot) + quantidade)
		
		dbExec(connection, "UPDATE characters SET carSlot=? WHERE id=?", tonumber(getElementData(thePlayer, "char:vehSlot")), getElementData(thePlayer, "char:id"))
		
		else
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | SLOTS", "Você não tem PP suficiente para comprar slots", "erro")	
	end
end
)

function saberslot(thePlayer)
local slot = getElementData(thePlayer, "char:vehSlot") or 0
triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | SLOTS", "Você tem "..slot.." slots de veiculos!", "sucesso")		
end
addCommandHandler("slots", saberslot)


addEvent("SpawnarGaragem", true)
addEventHandler("SpawnarGaragem", getRootElement(), function (thePlayer, vehicleId)
		for index, value in ipairs (getElementsByType("vehicle")) do
			if getElementData(value, "veh:id") == tonumber(vehicleId) then 
					if getElementData(value, "veh:owner") == getElementData(thePlayer, "char:id") then
					for index, value2 in ipairs (getElementsByType("vehicle")) do
					if not vehicleWeight[getElementModel(value2)] then
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
				break
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


addEvent("SpawnarGaragemDetran", true)
addEventHandler("SpawnarGaragemDetran", getRootElement(), function (vehicleId)
		for index, value in ipairs (getElementsByType("vehicle")) do
			if getElementData(value, "veh:id") == tonumber(vehicleId) then 
				if getElementData(value, "veh:owner") == getElementData(source, "char:id") then
					setElementInterior(value,0) 
					setElementDimension(value,0) 
			end
		end
	end
end
)

addEvent("GuardarVeiculo", true)
addEventHandler("GuardarVeiculo", getRootElement(), function (thePlayer)	
		    local v = getPedOccupiedVehicle ( thePlayer )
			if v then
			triggerEvent ("radio-parar", thePlayer, v )
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

--[[
function desbugG (thePlayer)
     if getElementDimension(thePlayer) ~= 0 then
         local theVehicle = getPedOccupiedVehicle ( thePlayer )
	     if theVehicle then	
             removePedFromVehicle(thePlayer)
             setElementDimension(thePlayer, 0)		
             setElementInterior(thePlayer, 0)
             else
             setElementDimension(thePlayer, 0)		
             setElementInterior(thePlayer, 0)					 
		 end
	 end
	 if getElementData(thePlayer, "spawn:vehicle") then
	     setElementData(thePlayer, "spawn:vehicle", false)
	 end
end

local detranZ = createColCuboid(2463.77344, -2144.27734, 10.52241, 76.55078125, 78.38720703125, 35.899960899353)

addEventHandler("onColShapeHit", detranZ,
function (thePlayer)
     if (getElementData(thePlayer, "char:dutyfaction") == 1 or getElementData(thePlayer, "char:dutyfaction") == 21) then
         ifVWithCar ()
	 end
end)

addEventHandler("onColShapeLeave", detranZ,
function (thePlayer)
     if (getElementData(thePlayer, "char:dutyfaction") == 1 or getElementData(thePlayer, "char:dutyfaction") == 21) then
         ifVWithCar ()
	 end
end)

function ifVWithCar ()
     for index, isEvent in pairs(getElementsWithinColShape(detranZ, "vehicle")) do
         if not (getElementData(isEvent, "detranAP")) then
             setElementData(isEvent, "detranAP", true)
			 outputDebugString("Veiculo ".. getVehicleName ( isEvent ) .." Apreendido com sucesso")
		 end
	 end
end



function Dregister (thePlayer, commandName, Mode)
     if Mode == "veiculo" then
	     if (getElementData(thePlayer, "char:dutyfaction") == 1 or getElementData(thePlayer, "char:dutyfaction") == 21) then
			 local theVehicle = getPedOccupiedVehicle ( thePlayer )
			 if (theVehicle) then
				 if not (getElementData(theVehicle, "detranAP")) then
				     return
			     else
			         outputChatBox(" ", thePlayer, 255,255,255, true)
			         outputChatBox("#7cc576[BGO DETRAN] #FFFFFFVeiculo liberado com sucesso.", thePlayer, 255,255,255, true)
			         outputChatBox("#7cc576[BGO DETRAN] #FFFFFFLiberado por: #7cc576"..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", ""), thePlayer, 255,255,255, true)
			         outputChatBox("#7cc576[BGO DETRAN] #FFFFFFNome do veiculo: #7cc576" .. getVehicleName ( theVehicle ), thePlayer, 255,255,255, true)
				     removeElementData(theVehicle, "detranAP")
				 end
			 end
		 end
	 end
end
addCommandHandler("liberar", Dregister)
]]--


function Dregister (thePlayer, commandName, Mode)
     if Mode == "veiculo" then
	     if (getElementData(thePlayer, "char:dutyfaction") == 1 or getElementData(thePlayer, "char:dutyfaction") == 21) then
		 
			triggerClientEvent(thePlayer, "inv:sucess", thePlayer, "Não existe mais este comando!" ) 
		 end
	 end
end
addCommandHandler("liberar", Dregister)