local con = exports.bgo_mysql:getConnection()
--local adminlog = "INSERT INTO adminlog SET admin_name=?, adminacc_id=?, tevkod=?, chatlog=?, target_name=?, targetacc_id=?, date=CURDATE(), time=CURTIME()"

		        local zone = createColCuboid(1997.35864, 2032.22888, 4.09263, 109.93505859375, 70.932495117188, 39.599917793274)
				
				
function adasVeteli(thePlayer, commandName, targetPlayer, osszeg)
	if isPedInVehicle(thePlayer) then
		local veh = getPedOccupiedVehicle(thePlayer)
		if (veh) then
		
		if not isElementWithinColShape ( thePlayer, zone ) then
		exports.bgo_hud:dm("Local para vender o veiculo agora fica em Las Venturas siga o GPS!", thePlayer, 255, 200, 0)
		exports.Script_futeis:setGPS(thePlayer, "Coordenada",2050.8759765625,2049.3688964844,10.8203125)
		return 
		end
		
		

				
			if not (targetPlayer) or not (osszeg) then
				outputChatBox("#7cc576[btcMTA]:#ffffff /" .. commandName .." [Nome / ID] [Preço]", thePlayer, 255, 255, 255, true)
			else
				if getElementData(thePlayer, "av:selling") then outputChatBox("#dc143c[btcMTA]:#ffffffUm contrato de venda já está em andamento.", thePlayer, 255, 255, 255, true) return end
				
				local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

				local osszeg = tonumber(osszeg)
				if osszeg < 1 then outputChatBox("#dc143c[btcMTA]:#ffffff É por isso que um veículo não pode ser tão barato.", thePlayer, 255, 255, 255, true) return end
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)
				local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
				local tint, tdim = getElementInterior(targetPlayer), getElementDimension(targetPlayer)
				local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
				if distance <= 5 and int == tint and dim == tdim then
					if thePlayer == targetPlayer then outputChatBox("#dc143c[btcMTA]:#ffffffVocê não pode vender seus veículos.", thePlayer, 255, 255, 255, true) return end
					if getElementData(thePlayer, "acc:id") == getElementData(veh, "veh:owner") or getElementData(thePlayer, "acc:admin") >= 7 then

					if not exports['bgo_items']:hasItemS(thePlayer, 228) then 
					exports.bgo_hud:dm("Você não tem um Contrato de Vendas para negociar seu veiculo, Siga o GPS para comprar!", thePlayer, 255, 200, 0)
					exports.Script_futeis:setGPS(thePlayer, "Coordenada",2090.795, 2054.198, 10.829)
					return
					end	
					
					
					if not exports['bgo_items']:hasItemS(targetPlayer, 229) then 
					exports.bgo_hud:dm("O seu cliente não tem uma caneta para assinar o contrato!", thePlayer, 255, 200, 0)
					exports.bgo_hud:dm("Você recebeu um contrato de venda porem não tem uma caneta para assinar, siga o GPS para comprar!", targetPlayer, 255, 200, 0)
					exports.Script_futeis:setGPS(targetPlayer, "Coordenada",2083.608, 2053.726, 10.829)
					return
					end	
					
					
					
						sendAjanlat(thePlayer, targetPlayer, osszeg, veh, 1)
					else
						outputChatBox("#dc143c[btcMTA]:#ffffff Você só pode vender seu próprio veículo.", thePlayer, 255, 255, 255,true)
					end
				else
					outputChatBox("#dc143c[btcMTA]:#ffffff Você está muito longe do jogador.", thePlayer, 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("vender", adasVeteli, false, false)

function sendAjanlat(thePlayer, targetPlayer, osszeg, veh, state)
	if isElement(thePlayer) and isElement(targetPlayer) then
	
		if state == 1 then
			local vehname = getElementModel(veh) or "desconhecido"
			outputChatBox("#1E8BC3[Vendas]:#ffffff " .. getPlayerName(thePlayer):gsub("_"," ") .. " ofereceu-lhe para venda este veiculo: #7cc576" .. vehname .. "", targetPlayer, 255, 255, 255, true)
			outputChatBox("#1E8BC3[Vendas]:#ffffff Preço: #0094ff" .. osszeg .. "$", targetPlayer, 255, 255, 255, true)
			outputChatBox("#1E8BC3[Vendas]:#ffffff Para aceitar digite: #7cc576/aceitar#ffffff.", targetPlayer, 255, 255, 255, true)
			outputChatBox("#1E8BC3[Vendas]:#ffffff Para recusar digite: #dc143c/recusar#ffffff.", targetPlayer, 255, 255, 255, true)
			outputChatBox("#1E8BC3[Vendas]:#ffffff Oferecido para venda #7cc576" .. vehname .. "#ffffff.", thePlayer, 255, 255, 255, true)
			outputChatBox("#1E8BC3[Vendas]:#ffffff Preço: #0094ff" .. osszeg .. "$", thePlayer, 255, 255, 255, true)
			
			setElementData(targetPlayer, "av:accept", 1)
			setElementData(thePlayer, "av:selling", 1)
			setElementData(targetPlayer, "av:veh", veh)
			setElementData(targetPlayer, "av:osszeg", osszeg)
			setElementData(targetPlayer, "av:tplayer", thePlayer)			
		end
	end
end

function elfogad(source, cmd)
		if getElementData(source, "av:accept") == 1 then
		
					if not exports['bgo_items']:hasItemS(source, 229) then 
					exports.bgo_hud:dm("Você recebeu um contrato de venda porem não tem uma caneta para assinar, siga o GPS para comprar!", source, 255, 200, 0)
					exports.Script_futeis:setGPS(source, "Coordenada",2083.608, 2053.726, 10.829)
					return
					end	
			
			local veh = getElementData(source, "av:veh")
			local vehid = getElementData(veh, "veh:id")
			local oldOwner = getElementData(veh, "veh:owner")
			local osszeg = getElementData(source, "av:osszeg")
			local tplayer = getElementData(source, "av:tplayer")
			local newOwner = getElementData(source, "acc:id")
			local count = 0
			local x, y, z = getElementPosition(source)
			local tx, ty, tz = getElementPosition(tplayer)
			local int, dim = getElementInterior(source), getElementDimension(source)
			local tint, tdim = getElementInterior(tplayer), getElementDimension(tplayer)
			local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
			if distance <= 5 and int == tint and dim == tdim then
				
				for k, v in ipairs(getElementsByType("vehicle")) do
					if getElementData(v, "veh:owner") == getElementData(source, "acc:id") then
						count = count+1
					end
				end
				
				if count >= getElementData(source, "char:vehSlot") then 
					outputChatBox("#dc143c[btcMTA]:#ffffff Você não tem slots suficientes à sua disposição.", source, 255, 255, 255, true) 
					outputChatBox("#dc143c[btcMTA]:#ffffff " .. getPlayerName(source):gsub("_"," ") .. " o jogador não tem slots suficientes à sua disposição.", tplayer, 255, 255, 255, true) 
					setElementData(source, "av:accept", false)
					setElementData(source, "av:veh", false)
					setElementData(source, "av:osszeg", false)
					setElementData(tplayer, "av:selling", false)
					setElementData(source, "av:tplayer", false)
					return
				end
				
				if getElementData(source, "char:bankmoney") >= osszeg then
				
					local sql = dbExec(con, "UPDATE vehicle SET owner='" .. newOwner ..  "' WHERE owner='" .. oldOwner .. "' AND id='" .. vehid .. "'")
					if (sql) then
						setElementData(veh, "veh:owner", newOwner)
						setElementData(veh, "veh:oname", getElementData(source, "char:name"))
						
					
						setElementData(source, "char:bankmoney", getElementData(source, "char:bankmoney")-osszeg)
						
						triggerEvent("getListData",source,source)
						triggerEvent("getListData",tplayer,tplayer)
						
						outputChatBox("#1E8BC3[Vendas]:#ffffff Você aceitou o contrato de venda. Pegue as chaves do carro do revendedor.", source, 255, 255, 255, true)
						outputChatBox("#1E8BC3[Vendas]:#ffffff Agora você pode encontrar seu veiculo no menu F3 'Propriedade'.", source, 255, 255, 255, true)
						--outputChatBox("#1E8BC3[Vendas]:#ffffff A vételPreço levonásra kerül a készpénzedből.", source, 255, 255, 255, true)
						outputChatBox("#1E8BC3[Vendas]:#ffffff Você vendeu com sucesso o veiculo ao .", getElementData(source, "av:tplayer"), 255, 255, 255, true)
						--dbExec(con, adminlog, getPlayerName(getElementData(source, "av:tplayer")), getElementData(getElementData(source, "av:tplayer"), "acc:id"), "Sell", getPlayerName(getElementData(source, "av:tplayer")) .. " ele vendeu seu veiculo ao " .. getPlayerName(source) .. " " .. getElementModel(veh) .. " (ID: " .. getElementData(veh, "veh:id") .. "). Quantidade: " .. osszeg .. "", getPlayerName(source), getElementData(source, "acc:id"))
						setElementData(tplayer, "char:bankmoney", getElementData(tplayer, "char:bankmoney")+osszeg)

						if exports['bgo_items']:hasItemS(tplayer, 228) then 
						exports['bgo_items']:takePlayerItemToID(tplayer, 228, true)	
						end
						
						if exports['bgo_items']:hasItemS(source, 229) then 
						exports['bgo_items']:takePlayerItemToID(source, 229, true)	
						end	
	
						exports.logs:logMessage("[VENDAS] " .. getPlayerName(tplayer) .. " ("..getElementData(tplayer, "char:id")..") vendeu um veiculo por "..osszeg.." para o jogador " .. getPlayerName(source) .. " ("..getElementData(source, "char:id")..") ", 5)



	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "veh:owner") == getElementData(source, "acc:id") then
			local r = getRealTime()
			local tempo = ("%04d-%02d-%02d %02d:%02d"):format(r.year+1900, r.month + 1, r.monthday, r.hour,r.minute)
			dbExec(con, "UPDATE vehicle SET data = ? WHERE owner = ?", tempo, getElementData(source,"acc:id"))
			if getElementDimension(v) == 0 then
			for index, value in ipairs(getElementsByType("player")) do
					inVehicle = getPedOccupiedVehicle(value)
					if inVehicle and inVehicle == v then
					removePedFromVehicle(value)
					local x, y, z = getElementPosition(value)
					setElementPosition(value, x, y+1, z)
				end
			end


		local dbid = tonumber(getElementData(v, "veh:id")) or 0
		if isElement(v) and tostring(getElementType(v)) == "vehicle" and dbid >= 0 then
		local fuel = getElementData(v, "veh:status")
		local engine = getElementData(v, "veh:motor") or false
		local locked = isVehicleLocked(v)
		local fuel = getElementData(v, "veh:fuel")
		local neon = tonumber(getElementData(v, "veh:neon") or 0)
		local lights = getVehicleOverrideLights(v)
		local health = getElementHealth(v)
		local wheel1, wheel2, wheel3, wheel4 = getVehicleWheelStates(v)
		local wheelState = toJSON( { wheel1, wheel2, wheel3, wheel4 } )	
		local panel0 = getVehiclePanelState(v, 0)
		local panel1 = getVehiclePanelState(v, 1)
		local panel2 = getVehiclePanelState(v, 2)
		local panel3 = getVehiclePanelState(v, 3)
		local panel4 = getVehiclePanelState(v, 4)
		local panel5 = getVehiclePanelState(v, 5)
		local panel6 = getVehiclePanelState(v, 6)
		local panelState = toJSON( { panel0, panel1, panel2, panel3, panel4, panel5, panel6 } )
			
		local door0 = getVehicleDoorState(v, 0)
		local door1 = getVehicleDoorState(v, 1)
		local door2 = getVehicleDoorState(v, 2)
		local door3 = getVehicleDoorState(v, 3)
		local door4 = getVehicleDoorState(v, 4)
		local door5 = getVehicleDoorState(v, 5)
		local doorState = toJSON( { door0, door1, door2, door3, door4, door5 } )
		
		local x,y,z = getElementPosition(v)
		local int = getElementInterior(v)
		local dim = getElementDimension(v)
		local pos = toJSON({x,y,z,int,dim})
		if dbPoll ( dbQuery( con, "UPDATE vehicle SET panel=?,  pos=? , wheel=?, door=?, fuel=?, motor=?, status=?, lampa=?, hp=? WHERE id=?", panelState, pos, wheelState, doorState, fuel, engine, locked, lights, health,dbid), -1 ) then
		end
		if isElement(v) then
		destroyElement(v)
		end
		
		end
		
			end
		end

	end
						
						setElementData(source, "av:accept", false)
						setElementData(source, "av:veh", false)
						setElementData(source, "av:osszeg", false)
						setElementData(getElementData(source, "av:tplayer"), "av:selling", false)
						setElementData(source, "av:tplayer", false)
					
					else
						outputChatBox("szar sql mentés")
					end
				else
					outputChatBox("#dc143c[btcMTA]:#ffffff Você não tem dinheiro suficiente para comprar um veiculo.", source, 255, 255, 255, true)
					
					setElementData(source, "av:accept", false)
					setElementData(source, "av:veh", false)
					setElementData(source, "av:osszeg", false)
					setElementData(getElementData(source, "av:tplayer"), "av:selling", false)
					outputChatBox("#dc143c[btcMTA]:#ffffff O cliente não tem dinheiro suficiente para comprar o veiculo.", tplayer, 255, 255, 255, true)
					setElementData(source, "av:tplayer", false)
				end
			else
				outputChatBox("#dc143c[btcMTA]:#ffffff Você está muito longe do jogador.", source, 255, 255, 255, true)
			end
		end
	end
addCommandHandler("aceitar", elfogad, false, false)

function decline(source, cmd)
	if getElementData(source, "av:accept") == 1 then
		
		setElementData(source, "av:accept", false)
		setElementData(source, "av:veh", false)
		setElementData(source, "av:osszeg", false)
		setElementData(getElementData(source, "av:tplayer"), "av:selling", false)
		outputChatBox("#1e8bc3[Vendas]:#ffffff Você rejeitou o contrato de venda.", source, 255, 255, 255, true)
		outputChatBox("#1e8bc3[Vendas]:#ffffff Seu contrato de venda foi rejeitado.", getElementData(source, "av:tplayer"), 255, 255, 255, true)
		setElementData(source, "av:tplayer", false)
	end
end
addCommandHandler("recusar", decline, false, false)










