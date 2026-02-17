local connection = exports['bgo_mysql']:getConnection()



local atmCooldown = {}
local atmSerial = {}


function atmIsAbleToRob ( player )
	return not isTimer(atmCooldown[player])
end

addCommandHandler('lcveh',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 1 then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then
			outputChatBox (" Você removeu o tempo pra comprar veiculo ao "..getPlayerName(targetPlayer).." ", thePlayer, 255, 0, 0, true )
			exports.bgo_discordlogs:sendDiscordMessage(1, false, " "..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "").." removeu o tempo para comprar veiculo ao "..getPlayerName(targetPlayer):gsub("#%x%x%x%x%x%x", "").." ")
		if isTimer ( atmCooldown[targetPlayer] ) then
		killTimer(atmCooldown[player])
		atmCooldown[targetPlayer] = nil
		end
			end
		end
	end
end
)


function atmGetTimeOut ( player )
	if isTimer ( atmCooldown[player] ) then
		local miliseconds = getTimerDetails ( atmCooldown[player] )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end

function atmSetTimeOut ( player, time )
	atmCooldown[player] = setTimer( function (player) atmCooldown[player] = nil end, time, 1, player)
end


addEventHandler("onPlayerQuit", root,
	function ()
		if ( atmGetTimeOut(source) ) then
			atmSerial[getPlayerSerial(source)] = atmGetTimeOut(source)
		end
	end
)

addEventHandler("onPlayerJoin", root,
	function ()
		for serial, cooldown in pairs ( atmSerial ) do
			if ( getPlayerSerial(source) == serial ) then
				atmSetTimeOut(source, cooldown*1000)
				atmSerial[serial] = nil
			end
		end
	end
)


	
	
function buyVehicle(player, modellID, r, g, b, money, jelenVeh, number)
	if isElement(player) then 
	
	if ( not atmIsAbleToRob(player) ) then
	triggerClientEvent(player, "bgo>info", player,"Informação", "Você não pode comprar outro veiculo dentro de ".. atmGetTimeOut ( player ) .. " segundos", "info")
	return
	end
	
		if (tonumber(player:getData("char:bankmoney") or 0) >= tonumber(money)) then
			local myCars = 0
			for _, value in ipairs(getElementsByType("vehicle")) do
				if value:getData("veh:owner") == player:getData("acc:id") then
					myCars = myCars+1
				end
			end
		
			if tonumber(myCars) < tonumber(player:getData("char:vehSlot")) then 
				x,y,z = 1639.982, -1257.37, 14.829
				local carshopPos = {
				[1] = {
					{1639.982, -1257.37, 14.829},
					{1640.263, -1268.563, 14.829},
					{1640.29, -1244.498, 14.823},
					{1640.187, -1279.659, 14.81},
					
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
					triggerClientEvent(player,"returnVasarlas",player,Beszurid)
					dbExec(connection,"UPDATE characters SET bankmoney = ? WHERE id = ?", player:getData("char:bankmoney")-money, getElementData(player,"acc:id"))
					player:setData("char:bankmoney",player:getData("char:bankmoney")-money)
					atmSetTimeOut(player, 7200000)
				end	
			else
				--outputChatBox("#00aeef[btcMTA - Carshop] #ffffffNão a #F7CA18'Slots' #ffffffsuficiente para comprar.",player,255,255,255,true)
				
				triggerClientEvent(player, "bgo>info", player,"concessionária BGO", "Você não tem slots o suficiente para comprar o veiculo!", "info")
				
				
			end
		else
		triggerClientEvent(player,"returnSemDinheiro",player)
		triggerClientEvent(player, "bgo>info", player,"concessionária BGO", "Você não tem Dinheiro no banco o suficiente para comprar o veiculo!", "info")
			--outputChatBox("#00aeef[btcMTA - Carshop] #ffffffVocê não tem #87D37C'dinheiro no banco' #ffffff suficiente para comprar.",player,255,255,255,true)
		end 
	end
end
addEvent("buyVehicleSever", true)
addEventHandler("buyVehicleSever", root, buyVehicle)

function buyVehiclePP(player, modellID, r, g, b, money, jelenVeh, number)
	if isElement(player) then 
		if (tonumber(player:getData("char:pp") or 0) >= tonumber(money)) then
			local myCars = 0
			for _, value in ipairs(getElementsByType("vehicle")) do
				if value:getData("veh:owner") == player:getData("acc:id") then
					myCars = myCars+1
				end
			end
		
			if tonumber(myCars) < tonumber(player:getData("char:vehSlot")) then 
			
			    local x,y,z = 1639.982, -1257.37, 14.829
				local pos = toJSON({x,y,z, 0 ,0})
				
				local insterT = dbQuery(connection, "INSERT INTO vehicle SET pos=?,model=?,owner=?,color=?, fuel=?", 
					pos,modellID,getElementData(player,"acc:id"),toJSON({r, g, b, 0, 0, 0}), 10)
		
				local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)
				if QueryEredmeny then
					exports["bgo_vehicle"]:addVehicle(getElementData(player,"acc:id"), modellID, x, y, z, Beszurid, r, g, b)
					triggerClientEvent(player,"returnVasarlas",player,Beszurid)
					dbExec(connection,"UPDATE characters SET premiumpont = ? WHERE id = ?", player:getData("char:pp")-money, getElementData(player,"acc:id"))
					player:setData("char:pp",player:getData("char:pp") - money)

				end	
			else
			triggerClientEvent(player, "bgo>info", player,"concessionária BGO", "Você não tem slots o suficiente para comprar o veiculo!", "info")
				--outputChatBox("#00aeef[btcMTA - Carshop] #ffffffVocê não tem #F7CA18'Slots'#ffffff o suficiente!.",player,255,255,255,true)
			end
		else
		triggerClientEvent(player, "bgo>info", player,"concessionária BGO", "Você não tem Dinheiro vip o suficiente para comprar o veiculo!", "info")
			--outputChatBox("#00aeef[btcMTA - Carshop] #ffffffVocê não tem #19B5FE'Dinheiro vip'#ffffff suficiente para comprar.",player,255,255,255,true)
		end
	end
end
addEvent("buyVehiclePPSever", true)
addEventHandler("buyVehiclePPSever", root, buyVehiclePP)