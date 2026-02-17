local connection = exports['bgo_mysql']:getConnection()

function buyVehicle(player, modellID, r, g, b, money, jelenVeh, number)
	if isElement(player) then 
		if (tonumber(player:getData("char:bankmoney") or 0) >= tonumber(money)) then
			local myCars = 0
			for _, value in ipairs(getElementsByType("vehicle")) do
				if value:getData("veh:owner") == player:getData("acc:id") then
					myCars = myCars+1
				end
			end
		
			if tonumber(myCars) < tonumber(player:getData("char:vehSlot")) then 
				x,y,z = 2119.8017578125, -1129.298828125, 25.36576461792
				local carshopPos = {
				
				    [1] = {
					
					{2234.3627929688,-2384.0017089844,12.956562995911},
					{2260.6467285156,-2359.1796875,12.956501960754},
					{2273.0263671875,-2345.9106445313,12.956541061401},
					
					},
				}
				
				--outputChatBox(number)
				--outputChatBox(carshopPos[number][1][1])
				local randed = math.random(1, #carshopPos[number])
				local pos = toJSON({carshopPos[number][randed][1], carshopPos[number][randed][2], carshopPos[number][randed][3], 0 ,0})
				
				local insterT = dbQuery(connection, "INSERT INTO vehicle SET pos=?,model=?,owner=?,color=?, fuel=?", 
					pos,modellID,getElementData(player,"acc:id"),toJSON({r, g, b, 0, 0, 0}), 10)
		
				local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)
				if QueryEredmeny then
					exports["bgo_vehicle"]:addVehicle(getElementData(player,"acc:id"), modellID, carshopPos[number][randed][1], carshopPos[number][randed][2], carshopPos[number][randed][3], Beszurid, r, g, b)
					triggerClientEvent(player,"returnVasarlas2",player,Beszurid)
					dbExec(connection,"UPDATE characters SET bankmoney = ? WHERE id = ?", player:getData("char:bankmoney")-money, getElementData(player,"acc:id"))
					player:setData("char:bankmoney",player:getData("char:bankmoney")-money)
					--exports.bgo_item:giveItem(player, 34, Beszurid, 1,0)	
				end	
			else
				outputChatBox("#00aeef[btcMTA - Carshop] #ffffffNão a #F7CA18'Slots' #ffffffsuficiente para comprar.",player,255,255,255,true)
			end
		else
			outputChatBox("#00aeef[btcMTA - Carshop] #ffffffVocê não tem #87D37C'dinheiro no banco' #ffffff suficiente para comprar.",player,255,255,255,true)
			triggerClientEvent(player,"returnSemDinheiro",player)
		end 
	end
end
addEvent("buyVehicleSever2", true)
addEventHandler("buyVehicleSever2", root, buyVehicle)

function buyVehiclePP(player, modellID, r, g, b, money, jelenVeh, number)
	if isElement(player) then 
		if (tonumber(player:getData("char:pp")) >= tonumber(money)) then
			local myCars = 0
			for _, value in ipairs(getElementsByType("vehicle")) do
				if value:getData("veh:owner") == player:getData("acc:id") then
					myCars = myCars+1
				end
			end
		
			if tonumber(myCars) < tonumber(player:getData("char:vehSlot")) then 
			
			    local x,y,z = 2134.0712890625, -1134.2509765625, 25.688035964966
			    
			    if number == 1 then
				    x,y,z = 2134.0712890625, -1134.2509765625, 25.688035964966
				elseif number == 2 then
				    x,y,z = 2157.7282714844, 1429.0026855469, 10.8203125
				end
				--player:setData("char:pp",player:getData("char:pp") - money)
				local pos = toJSON({x,y,z, 0 ,0})
				
				local insterT = dbQuery(connection, "INSERT INTO vehicle SET pos=?,model=?,owner=?,color=?, fuel=?", 
					pos,modellID,getElementData(player,"acc:id"),toJSON({r, g, b, 0, 0, 0}), 10)
		
				local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)
				if QueryEredmeny then
					exports["bgo_vehicle"]:addVehicle(getElementData(player,"acc:id"), modellID, x, y, z, Beszurid, r, g, b)
					triggerClientEvent(player,"returnVasarlas2",player,Beszurid)
					dbExec(connection,"UPDATE characters SET premiumpont = ? WHERE id = ?", player:getData("char:pp")-money, getElementData(player,"acc:id"))
					player:setData("char:pp",player:getData("char:pp") - money)
					--exports.bgo_item:giveItem(player, 34, Beszurid, 1,0)
				end	
			else
				outputChatBox("#00aeef[btcMTA - Carshop] #ffffffNincs elég #F7CA18'Slotod'#ffffff a vásárláshoz.",player,255,255,255,true)
			end
		else
			outputChatBox("#00aeef[btcMTA - Carshop] #ffffffVocê não tem #19B5FE'Dinheiro vip'#ffffff suficiente para comprar.",player,255,255,255,true)
		end
	end
end
addEvent("buyVehiclePPSever2", true)
addEventHandler("buyVehiclePPSever2", root, buyVehiclePP)