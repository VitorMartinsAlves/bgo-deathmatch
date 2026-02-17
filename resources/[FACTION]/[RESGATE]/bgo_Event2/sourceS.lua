local boxTable = {}

addEvent('btcMTA->#giveItem2', true)
addEventHandler('btcMTA->#giveItem2', root, function(element, itemID, objects, count)
	local rand = math.random(11111111,99999999)
	local status,msg = exports["bgo_items"]:giveItem(element, itemID, rand, count, 0, true)
	
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second

        local monthday = time.monthday
	local month = time.month
	local year = time.year

     local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)

	 if status then 	
		outputChatBox('Você ganhou uma: #D24D57' .. exports['bgo_items']:getItemName(itemID), element, 255, 255, 255, true)
		print(""..getPlayerName(element).." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa premium ")
		exports.bgo_discordlogs:sendDiscordMessage(7, false, ""..getPlayerName(element):gsub("#%x%x%x%x%x%x", "").." ID: "..rand.." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa premium Dia: "..formattedTime.."")
	else
		exports.bgo_discordlogs:sendDiscordMessage(7, false, ""..getPlayerName(element):gsub("#%x%x%x%x%x%x", "").." ID: "..rand.." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa premium porém a mochila dele estava cheia! Dia: "..formattedTime.."")
		print(""..getPlayerName(element).." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa premium porém a mochila dele estava cheia! ")
	 end
end)


