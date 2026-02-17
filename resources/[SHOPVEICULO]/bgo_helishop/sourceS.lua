local connection = exports['bgo_mysql']:getConnection()

-- triggerServerEvent('bgoMTA->#insertVehicle', localPlayer, localPlayer, vehicles[currentVehicle][1], vehicles[currentVehicle][2], 'money', savedVehicleColors["all"])

local oldP = 0

local rand = {
	[1] = {1633.368, 1673.599, 10.82},
	[2] = {1634.28, 1654.302, 10.82},
	[3] = {1645.557, 1663.721, 10.82},
}

function getRandomPos()
	local p = math.random(1, #rand)
	if p == oldP then
		p = p - 1
		if p < 1 then
			p = #rand
		end
	end
	oldP = p
	return p
end

addEvent("bgoMTA->#insertVehicle3", true)		
addEventHandler("bgoMTA->#insertVehicle3", root, function(playerSource, modellID, price, element, color)
	--if (getElementData(playerSource, element)) >= price then
		-- if exports.global:canPlayerBuyVehicle(playerSource) then
			local myCars = 0
			for _, value in ipairs(getElementsByType("vehicle")) do
				if getElementData(value,"veh:owner") == getElementData(playerSource,"acc:id") then
					myCars = myCars+1
				end
			end
		
			if tonumber(myCars) < tonumber(getElementData(playerSource,"char:vehSlot")) then 
			
			local t = getRandomPos()
			local x, y, z = rand[t][1], rand[t][2], rand[t][3]
			    
				local pos = toJSON({x,y,z, 0 ,0})
				local szin = color
			 
				local insterT = dbQuery(connection, "INSERT INTO vehicle SET pos=?,model=?,owner=?,color=?, fuel=?", 
				pos,modellID,getElementData(playerSource,"acc:id"),toJSON({szin[1], szin[2], szin[3], 0, 0, 0}), 10)
		
				local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)
				if QueryEredmeny then
					exports["bgo_vehicle"]:addVehicle(getElementData(playerSource,"acc:id"), modellID, x, y, z, Beszurid, szin[1], szin[2], szin[3])
					dbExec(connection,"UPDATE characters SET premiumpont = ? WHERE id = ?", getElementData(playerSource,"char:pp")-price, getElementData(playerSource,"acc:id"))
					--player:setData("char:pp",player:getData("char:pp") - money)
					
					setElementData(playerSource, 'char:pp', getElementData(playerSource, 'char:pp') - price)
					
					
				end	
			else
			 exports.bgo_info:addNotification(playerSource, "Você não tem slot suficiente para comprar este veiculo!","info")
			end

		 end
)