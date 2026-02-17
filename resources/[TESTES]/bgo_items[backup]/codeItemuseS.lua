--local connection = exports.mysql:getConnection()
local szinez = "#88D373"
local r,g,b = 136,211,115

--[[

addEvent("checkCarKey",true)
addEventHandler("checkCarKey",getRootElement(),function(player,dbid,value)
	dbQuery(function(qh)
		local result = dbPoll(qh,0)
		if #result > 0 then
			outputChatBox(szinez.."[Inventorio]:#FFFFFF Não há ação para este item!",player,255,255,255,true)
		else
			outputChatBox(szinez.."[Inventorio]:#FFFFFF Eu não consegui encontrar um veículo assim, então eu deletei sua chave!",player,255,255,255,true)
			dbExec(connection,"DELETE FROM items WHERE id = ?",dbid)
			setTimer(function()
			exports["bgo_items"]:loadPlayerItems(player)end,500,1)
		end	
	end,connection,"SELECT * FROM vehicles WHERE id = ?",value)
end)
]]--
addEvent("fixCardUse",true)
addEventHandler("fixCardUse",getRootElement(),function(vehicle)
	fixVehicle(vehicle);
	setVehicleDamageProof(vehicle, false);
end)

addEvent("giveArmor",true)
addEventHandler("giveArmor",getRootElement(),function(player, amount)
	setPedArmor(player, amount)
end)

addEvent("addpp",true)
addEventHandler("addpp",getRootElement(),function(player)
	--dbExec(connection,"UPDATE accounts SET btcpp = ? WHERE id = ?",getElementData(player,"acc:pp"),getElementData(player,"acc:id"))
end)

addEvent("addgordura",true)
addEventHandler("addgordura",getRootElement(),function(player)
	local stat = getPedStat ( player, 21 )
	if ( stat <= 999 ) then
	setPedStat(player, 21, getPedStat ( player, 21 ) + 30) 
	end
	if ( stat > 980 ) then
		outputChatBox ( getPlayerName ( source ) .. " Precisa perder um pouco de peso!!", player, 255,255,255, true )
	end
end)

addEvent("mask", true)
addEventHandler("mask", root,
	function(player, id)
		triggerClientEvent("addMask", player, id)
	end
)


addEvent("fixveh", true)
addEventHandler("fixveh", root,
	function()
		local theVehicle = getPedOccupiedVehicle ( source )
		if theVehicle then
		fixVehicle(theVehicle)
		end
	end
)


