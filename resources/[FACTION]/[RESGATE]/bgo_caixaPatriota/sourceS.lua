local boxTable = {}

addEvent('btcMTA->#giveItem3', true)
addEventHandler('btcMTA->#giveItem3', root, function(element, itemID, objects, count)
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
		--print(""..getPlayerName(element):gsub("#%x%x%x%x%x%x", "").." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa patriota ")
		exports.bgo_discordlogs:sendDiscordMessage(7, false, ""..getPlayerName(element):gsub("#%x%x%x%x%x%x", "").." ID: "..rand.." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa patriota Dia:"..formattedTime.." ")
					setElementData(element,"char >> showedItem",{true,itemID,exports.bgo_items:getItemName(itemID),exports.bgo_items:getItemDescription(itemID),getTickCount()})
					setTimer(function(element)
					setElementData(element,"char >> showedItem",{false,nil,nil,nil,nil})
					end,5000,1, element)
	else
		--print(""..getPlayerName(element).." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa patriota porém a mochila dele estava cheia! ")
		exports.bgo_discordlogs:sendDiscordMessage(7, false, ""..getPlayerName(element):gsub("#%x%x%x%x%x%x", "").." ID: "..rand.." ganhou uma: " .. exports['bgo_items']:getItemName(itemID).." na caixa patriota porém a mochila dele estava cheia! Dia:"..formattedTime.."")
	 end
end)