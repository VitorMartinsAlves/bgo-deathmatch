--local connection = exports['bgo_mysql']:getConnection()

function PremiumPontbuyItem(player, item, amount , money)
			if player:getData("char:pp") >= money then
			local rand = math.random(11111111,99999999)
			local status,msg = exports["bgo_items"]:giveItem(player, item, rand, 1, 0, true)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second

        local monthday = time.monthday
	local month = time.month
	local year = time.year

     local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
	 
			if status then
			player:setData("char:pp", player:getData("char:pp") - money)

						
		exports.bgo_discordlogs:sendDiscordMessage(7, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ID: "..getElementData(player,"char:id") .. " id do item:"..rand.." comprou uma: " .. exports['bgo_items']:getItemName(item).." no Dia: "..formattedTime.."")
		
		
			exports.logs:logMessage("[F6 COMPRA]: " .. getPlayerName(player) .. getElementData(player,"char:id") .. " Comprou um item: " .. exports.bgo_items:getItemName(item) .. " na loja do F6 ", 10)


			triggerClientEvent(player, "showNotifications", player, "Você comprou com sucesso #FE8100".. exports.bgo_items:getItemName(item).. "#ffffff.", "green")
			else
			triggerClientEvent(player, "showNotifications", player, "Você não tem espaço na bolsa para comprar este item!", "green")
			end
			else
			triggerClientEvent(player, "showNotifications", player, "Você não tem dinheiro vip para comprar este item", "red")
	end
	--dbExec(connection,"UPDATE characters SET premiumpont = ? WHERE id = ?", player:getData("char:pp")-amount, getElementData(player,"acc:id"))
end
addEvent("PremiumPontbuyItem", true)
addEventHandler("PremiumPontbuyItem", getRootElement(), PremiumPontbuyItem)




