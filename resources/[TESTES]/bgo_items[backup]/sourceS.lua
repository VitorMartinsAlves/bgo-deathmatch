local connection = exports["bgo_mysql"]:getConnection()


inventoryElem = { 'craft', 'weapon', 'key', 'bag'} -- // Inventory szétválasztások
row = 5 -- // Sor
column = 10 -- // Oszlop
baseWeight = 25 --// Alap peso
oneLevelBag = 35 -- // Sima táska
premiumLevelBag = 45 -- // Sima táska
oneLevelBagID = 150 -- // Sima táska ID
premiumLevelBagID = 151 -- // Prémium táska ID
maxCraftSlot = 16 -- // Craft slot
maxCraftRecipe = 9 -- // max Craft receptek


loadallItem = {} 



addEventHandler("onResourceStart", resourceRoot, function()
	loadItemToTable()
	setElementData(root, 'item >> loaded', false)
end)

Async:setPriority("high")
Async:setDebug(true)

function loadItemToTable()
	Async:setPriority(500, 100)
	local typeText = "bag"
	
	dbQuery(function(loadedItemQuery)
		local queryElement, queryNumber = dbPoll(loadedItemQuery, 0)
		if queryNumber > 0 then
			Async:foreach(queryElement, function(itemtables)
				if tonumber(itemtables["type"]) == 1 or tonumber(itemtables["type"]) == 2 then 
					typeText = "bag"
				else
					typeText = getItemType(tonumber(itemtables["itemid"]))
				end
									
				if not loadallItem[tonumber(itemtables["type"])] then 
					loadallItem[tonumber(itemtables["type"])] = {} 
				end	
				if not loadallItem[tonumber(itemtables["type"])][tonumber(itemtables["owner"])] then 
					loadallItem[tonumber(itemtables["type"])][tonumber(itemtables["owner"])] = {} 
				end
				if not loadallItem[tonumber(itemtables["type"])][tonumber(itemtables["owner"])][typeText] then
					loadallItem[tonumber(itemtables["type"])][tonumber(itemtables["owner"])][typeText] = {} 
				end				
				loadallItem[tonumber(itemtables["type"])][tonumber(itemtables["owner"])][typeText][tonumber(itemtables["slot"])] = {
					["dbID"] = tonumber(itemtables["id"]),
					["itemID"] = tonumber(itemtables["itemid"]),
					["value"] = (itemtables["value"]),
					["count"] = tonumber(itemtables["count"]),
					["duty"] = tonumber(itemtables["dutyitem"]),
					["slot"] = tonumber(itemtables["slot"]),	
					["itemtype"] = tonumber(itemtables["type"]),	
					["actionSlot"] = tonumber(itemtables["actionslot"]),	
					["healt"] = tonumber(itemtables["healt"]),	
				}
			end)
			
			local time = ((queryNumber*100)/60/1000)

			outputDebugString("Loaded Item (".. queryNumber .." DB) ("..math.floor(time).." mp)", 0, 25, 181, 254)
			setElementData(root, 'item >> loaded', true)
		end
	end, connection, "SELECT * FROM items" ) 
end

addEvent('btcMTA->#getElementItem', true)
addEventHandler('btcMTA->#getElementItem', root, function (element)
	if loadallItem[getType(element)] and  loadallItem[getType(element)][getOwnerID(element)] then 
		triggerClientEvent(source, 'btcMTA->#loadItemToClient', source, loadallItem[getType(element)][getOwnerID(element)])
	else
		triggerClientEvent(source, 'btcMTA->#loadItemToClient', source, {})
	end
end)

------------------------------

-- // Check veiculo
------------------------------

function checkVehicleInvenroty(player, vehicle)
	setElementData(vehicle, "clickToVehicle", tonumber(getElementData(vehicle, "clickToVehicle") or 0) + 1) 
	if getElementData(vehicle, "clickToVehicle") == 1 then
		--local vehID = getElementModel(vehicle)
		--local vehName = exports.bgo_carshop:getVehicleRealName(player, vehID) or "Veículo desconhecido"
		triggerClientEvent(player, "btcMTA->#checkVehicleInfo", player, vehicle)
		setElementData(vehicle, "inUse", true)
		setElementData(player, "openVehInventory", true)
		local playerName = getPlayerName(player)
		doorState(vehicle, 1)
	end
end
addEvent("btcMTA->#checkVehicleInvenroty", true)
addEventHandler("btcMTA->#checkVehicleInvenroty", root, checkVehicleInvenroty)


function doorState(vehicle, type)
	if type == 1 then
		setVehicleDoorOpenRatio(vehicle, 1, 1, 800)
	else
		setVehicleDoorOpenRatio(vehicle, 1, 0, 800)
		setElementData(vehicle, "inUse", false)
		setElementData(vehicle, "clickToVehicle", 0)
	end
end
addEvent("btcMTA->#doorState", true)
addEventHandler("btcMTA->#doorState", root, doorState)



function checkCofreInvenroty2(player, elemento)
	--setElementData(elemento, "clickToCofre", tonumber(getElementData(elemento, "clickToCofre") or 0) + 1) 
	--if getElementData(elemento, "clickToCofre") == 1 then
		triggerClientEvent(player, "btcMTA->#checkVehicleInfo", player, elemento)
	--end
end
addEvent("btcMTA->#checkCofreInvenroty", true)
addEventHandler("btcMTA->#checkCofreInvenroty", root, checkCofreInvenroty2)

------------------------------

-- // Item frisítések

------------------------------

addEvent('btcMTA->#updateValue', true)
addEventHandler('btcMTA->#updateValue', root, function (element, itemType, slot, item, val, db, duty, actionSlot)
	if not val then val = 0 end
	if not db then db = 1 end
	dbExec(connection, "UPDATE items SET value = ?, dutyitem = ? WHERE owner = ? AND slot = ? AND type = ? AND itemid = ?", val, duty,  getOwnerID(element), slot, tonumber(getType(element)) or 0, item)
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['value'] = val
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['duty'] = duty
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]["actionSlot"] = actionSlot
end)

function setSlotCount(element, itemType, slot, val, db, duty, actionSlot, itemid)
	if not val then val = 0 end
	if not db then db = 1 end
	dbExec(connection, "UPDATE items SET count = ?, dutyitem = ? WHERE owner = ? AND slot = ? AND type = ? AND itemid = ?", db, duty,  getOwnerID(element), slot, tonumber(getType(element)) or 0, itemid)
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['count'] = db
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['value'] = val
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['duty'] = duty
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['actionSlot'] = actionSlot
end
addEvent('btcMTA->#setSlotCount', true)
addEventHandler('btcMTA->#setSlotCount', root, setSlotCount)

addEvent('btcMTA->#setActionBarSlot', true)
addEventHandler('btcMTA->#setActionBarSlot', root, function (element, itemType, slot, val, db, actionSlot, item)
	if not val then val = 0 end
	if not db then db = 1 end
	
	--loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['count'] = db
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['value'] = val
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['actionSlot'] = actionSlot
	dbExec(connection, "UPDATE items SET actionslot = ? WHERE slot = ? AND owner = ? AND itemid = ?", actionSlot, slot,  getOwnerID(element), item)
	
	triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, loadallItem[getType(element)][getOwnerID(element)])
end)



function setSlotItem(element, itemType, slot, item, val, count, duty)
	if not val then val = 0 end
	if not count then count = 1 end
	
	dbExec(connection, "INSERT INTO items SET slot = ?, itemid = ?, value = ?, count = ?, owner = ?, type = ?, dutyitem = ?", slot, item, val, count,  getOwnerID(element), tonumber(getType(element)) or 0, duty)

	local types = getItemToType(element, item)	
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
	end
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
	end	
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types][slot] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types][slot] = {}
	end


	loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types][slot] = {
		["dbID"] = tonumber(-1),
		["itemID"] = tonumber(item),
		["value"] = val,
		["count"] = tonumber(count),
		["duty"] = tonumber(duty),
		["slot"] = tonumber(slot),	
		["itemtype"] = tonumber(getType(element)),	
		["actionSlot"] = tonumber(-1),	
	}
	
	

	
	
end
addEvent('btcMTA->#setSlotItem', true)
addEventHandler('btcMTA->#setSlotItem', root, setSlotItem)

function deleteItem(element, itemType, slot)
	if not val then val = 0 end
	if not db then db = 1 end
	
	if not loadallItem[tonumber(getType(element)) or 0] then
		loadallItem[tonumber(getType(element)) or 0] = {}
	end			
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
	end			
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][itemType] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][itemType] = {}
	end	
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][itemType][slot] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][itemType][slot] = {}
	end	
	dbExec(connection, "DELETE FROM items WHERE owner = ? AND slot = ? AND type = ? AND itemid = ?", getOwnerID(element), slot, tonumber(getType(element)) or 0, loadallItem[getType(element)][getOwnerID(element)][itemType][slot]['itemID'])
	
	loadallItem[getType(element)][getOwnerID(element)][itemType][slot] = {
		["dbID"] = -1,
		["itemID"] = -1,
		["value"] = -1,
		["count"] = -1,
		["duty"] = -1,
		["slot"] = -1,	
		["itemtype"] = -1,	
		["actionSlot"] = -1,	
	}
	
	if loadallItem and loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] then 
		triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, loadallItem[getType(element)][getOwnerID(element)])
	end
end
addEvent('btcMTA->#deleteItem', true)
addEventHandler('btcMTA->#deleteItem', root, deleteItem)


local timers = {}

addEvent('btcMTA->#movedItemToElement', true)
addEventHandler('btcMTA->#movedItemToElement', root, function(element, targetElement, slot, item, val, count)

    if isTimer(timers[element]) then 
	exports.bgo_infobox:addNotification(element,"Aguarde 15 segundos!","error")
	return end
    timers[element] = setTimer(function() end, 15000, 1)

    local types = getItemToType(element, item)
    if giveItem(targetElement, item, val, count, 0, true) then

        setPlayerAnimation(element, "DEALER", "DEALER_DEAL", 3000, false, false, false, false)
		
        setPlayerAnimation(targetElement, "DEALER", "DEALER_DEAL", 3000, false, false, false, false)

		setTimer(setElementFrozen, 3000,1, element, false)
		setTimer(setElementFrozen, 3000,1, targetElement, false)
		
        if getElementType(element) == "player" and getElementType(targetElement) == "player" then
            --	exports.logs:logMessage("[TROCA JOGADOR]  "..playerName.." Passou um objeto para ".. getPlayerName(targetElement):gsub("_"," ").." (".. getItemName(item)..")", 6)
			--outputChatBox("[TROCA JOGADOR] "..getPlayerName(element).." Passou um objeto para ".. getPlayerName(targetElement):gsub("_"," ").." (".. getItemName(item)..") ",v,255,255,255,true)
			
			--[[
		for k,v in ipairs(getElementsByType("player")) do
			if tonumber(getElementData(v, "acc:admin") or 0) >= 1 then
				local value = getElementData(v,"char:adminduty")
			if value == 1 then
				--outputChatBox("#00FF1E====================#FFFFFFIMPORTANTE======================",v,255,255,255,true)
				outputChatBox("#00FFFB[TROCA JOGADOR] #FFFFFF"..getPlayerName(element).." ("..getElementData(element, "char:id")..") #FFC400Passou um objeto para #FFFFFF".. getPlayerName(targetElement):gsub("_"," ").." #FFC400(".. getItemName(item)..") ",v,255,255,255,true)
				end
			end
		end]]--
		elseif getElementType(element) == "player" and getElementType(targetElement) == "vehicle" then
		
		exports.logs:logMessage("[Porta-Malas]  " .. getPlayerName(element) .. " ("..getElementData(element, "char:id")..") Colocou um objeto no porta-malas. (" .. getItemName(item) .. ")", 6)
		--[[
		for k,v in ipairs(getElementsByType("player")) do
			if tonumber(getElementData(v, "acc:admin") or 0) >= 1 then
				local value = getElementData(v,"char:adminduty")
				if value == 1 then
				--outputChatBox("#00FF1E====================#FFFFFFIMPORTANTE======================",v,255,255,255,true)
				outputChatBox("#00FFFB[Porta-Malas] #FFFFFF"..getPlayerName(element).." ("..getElementData(element, "char:id")..") #FFC400Colocou um objeto no porta-malas. #FFC400(".. getItemName(item)..") ",v,255,255,255,true)
				end
			end
		end]]--
		
        elseif getElementType(element) == "vehicle" and getElementType(targetElement) == "player" then
            local playerName = getPlayerName(targetElement)
            exports.logs:logMessage("[Porta-Malas]  " .. getPlayerName(targetElement) .. " ("..getElementData(targetElement, "char:id")..") Retirou um objeto do porta-malas. (" .. getItemName(item) .. ")", 6)

--[[
		for k,v in ipairs(getElementsByType("player")) do
				if tonumber(getElementData(v, "acc:admin") or 0) >= 1 then
					local value = getElementData(v,"char:adminduty")
				if value == 1 then
				--outputChatBox("#00FF1E====================#FFFFFFIMPORTANTE#00FF1E======================",v,255,255,255,true)
				outputChatBox("#00FFFB[Porta-Malas] #FFFFFF"..getPlayerName(targetElement).." ("..getElementData(targetElement, "char:id")..") #FFC400Retirou um objeto do porta-malas. #FFC400(".. getItemName(item)..") ",v,255,255,255,true)
				end
			end
		end]]--
		

        end

		-- abinis
        if getElementType(element) == "player" then
            deleteItem(element, types, slot)
            if loadallItem and loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] then
                triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, loadallItem[getType(element)][getOwnerID(element)])
            end
        elseif getElementType(element) == "object" then
            deleteItem(element, types, slot)
            if loadallItem and loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] then
                triggerClientEvent(targetElement, 'btcMTA->#loadItemToClient', targetElement, loadallItem[getType(element)][getOwnerID(element)])
            end
        elseif getElementType(element) == "vehicle" then
            deleteItem(element, types, slot)
            if loadallItem and loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] then
                triggerClientEvent(targetElement, 'btcMTA->#loadItemToClient', targetElement, loadallItem[getType(element)][getOwnerID(element)])
            end
        end
    else
        if getElementType(element) == "player" then
            outputChatBox('#D24D57[btc~Items] #ffffffNão há espaço suficiente no inventário!', element, 255, 255, 255, true)
        elseif getElementType(element) == "vehicle" then
            outputChatBox('#D24D57[btc~Items] #ffffffNão há espaço suficiente no inventário!', targetElement, 255, 255, 255, true)
        end
    end
end)

------------------------------

-- // Give Item 

------------------------------
--[[
addCommandHandler("giveitem",
	function(playerSource, cmd, id, item, value, count)
		if getElementData( playerSource, "acc:admin" ) >= 6 then
			if (getElementData (playerSource, "adminduty") or 0) == 1 then
				if id and item and value and count then
					local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(playerSource, id)			
					if targetPlayer then
						if giveItem(targetPlayer, tonumber(item), tonumber(value), tonumber(count), 0, true) then -- 0 -> dutyitem
							local comy = getElementData(playerSource, "char::anick")
							outputChatBox("#7cc576[Informação]: #ffffffKaptál #00AEFF".. comy .."#FFFFFF-tól/től egy #D75555" ..getItemName(tonumber(item)).." #ffffffitemet.", targetPlayer,255,255,255,true)				
							outputChatBox("#7CC576[#7CC576btc#ffffffMTA #ffffff- #53bfdcAdmin információ#7CC576]: #00AEFF".. targetPlayerName:gsub("_", " ") .."#FFFFFF-nak/nek adtál egy #D75555" ..getItemName(tonumber(item)).." #ffffffitemet.", playerSource,255,255,255,true)				
							exports.global:sendMessageToAdmins("#7CC576[#7CC576btc#ffffffMTA #ffffff- #53bfdcadmin Log#7CC576]#ffffff: #00AEFF" .. comy .. " #FFFFFFadott #00AEFF".. targetPlayerName:gsub("_", " ") .."#ffffff-nak/nek egy #D75555" ..getItemName(tonumber(item)).."#ffffff nevezetű itemet.", 255, 0, 0,true)
							--exports.logs:logMessage("[addolás]  ".. comy .. " adott ".. targetPlayerName:gsub("_", " ") .."-nak/nek egy " ..getItemName(tonumber(item)).." nevezetű itemet.", 34)			
						else
							outputChatBox("#7CC576[#7CC576btc#ffffffMTA #ffffff- #53bfdcAdmin információ#7CC576]: #ffffffNem fér el több tárgy az adott játékosnál!", playerSource, 255 ,255, 255, true)
						end
					end
				else
					outputChatBox("#7cc576[Használat]: #ffffff/"..cmd.." [Név / ID] [ItemId] [Érték] [Db]", playerSource, 255, 255, 255, true)
				end
			else
				outputChatBox("#D24D57[btc - Defend]: #FFFFFFNem vagy adminszolgálatba!", playerSource,255,255,255,true)	
			end
		end
	end
)]]--

function giveItem(element, item, value, count, duty, state)
    if (not value) then value = 0 end
    if (not count) then count = 1 end
    if (not duty) then duty = 0 end
    if (not state) then state = false end
    if (getItemsWeight(element) + getItemsWeightElement(element, item, count) < getMaxWeight(element)) then
        local slot = getFreeSlot(element, item)
        if (slot ~= false) then
            local types = getItemToType(element, item)
            setSlotItem(element, types, slot, item, value, count, duty)
            if state then
                if loadallItem and loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] then
                    triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, loadallItem[getType(element)][getOwnerID(element)])
                end
            end
            return true
        else
            outputChatBox("Não há slot suficiente na sua mochila!", element, 255, 255, 255, true)
            return false
        end
    else
        outputChatBox("Não há espaço suficiente na sua mochila!", element, 255, 255, 255, true)	
        return false
    end
end

addEvent('btcMTA->#inventoryGiveItem', true)
addEventHandler('btcMTA->#inventoryGiveItem', root, giveItem)

------------------------------

-- // Súly / Item lekérdezések

------------------------------

function getItemsWeightElement(element, itemID, count)
	local all = 0
	all = all + getItemWeight(itemID)*count
	return all
end

function getItemsWeight(element)
	local all = 0
	for i = 1, row * column do	
		for index, value in ipairs (inventoryElem) do 
			
			if not loadallItem[tonumber(getType(element)) or 0] then
				loadallItem[tonumber(getType(element)) or 0] = {}
			end			
			
			if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
				loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
			end			
			
			if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][value] then
				loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][value] = {}
			end	
			
			if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][value][i] then
				loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][value][i] = {}
			end		
			
			if(loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] and loadallItem[getType(element)][getOwnerID(element)][value] and loadallItem[getType(element)][getOwnerID(element)][value][i] and tonumber(loadallItem[getType(element)][getOwnerID(element)][value][i]['itemID']) or -1 > 0)then
				all = all + (getItemWeight(loadallItem[getType(element)][getOwnerID(element)][value][i]['itemID']) or 1)*tonumber(loadallItem[getType(element)][getOwnerID(element)][value][i]['count'] or 1)
			end
		end
	end
	return all
end

function getFreeSlot(element, itemID)
	local types = getItemToType(element, itemID)

	for i = 1, row * column do	
		if not loadallItem[tonumber(getType(element)) or 0] then
			loadallItem[tonumber(getType(element)) or 0] = {}
		end			
		
		if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
			loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
		end			
		
		if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
			loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
		end	
		
		if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types][i] then
			loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types][i] = {}
		end		
		
		if not loadallItem[tonumber(getType(element))][getOwnerID(element)][types][i]['itemID'] then
			loadallItem[tonumber(getType(element))][getOwnerID(element)][types][i]['itemID'] = -1
		end
		
		if loadallItem[tonumber(getType(element))][getOwnerID(element)][types][i]['itemID'] < 0 then
			return i
		end
	end
	return false
end

function hasItemS(element, itemID, itemValue)
	local types = getItemToType(element, itemID)
	
	if not loadallItem[tonumber(getType(element)) or 0] then
		loadallItem[tonumber(getType(element)) or 0] = {}
	end		
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
	end			
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
	end	
	
	for k,v in pairs(loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] or {}) do
		if itemValue then
			if v['itemID'] == itemID and v['value'] == itemValue then
				return true, k, v["value"], v["count"]
			end
		else
			if v['itemID'] == itemID then
				return true, k, v["value"], v["count"]
			end
		end
	end
	return false
end

------------------------------

-- // remove Item cuccok

------------------------------

function RemovePlayerDutyItems(element)
	for i = 1, row * column do	
		for index, value in ipairs (inventoryElem) do 
			if(loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] and loadallItem[getType(element)][getOwnerID(element)][value] and loadallItem[getType(element)][getOwnerID(element)][value][i] and tonumber(loadallItem[getType(element)][getOwnerID(element)][value][i]['duty'] or -1) > 0)then
				deleteItem(element, value, loadallItem[getType(element)][getOwnerID(element)][value][i]['slot'])
				--[[
				if getElementType(element) == 'player' and getItemWeaponID(loadallItem[getType(element)][getOwnerID(element)][value][i]['itemID']) then 
					triggerEvent("detachWeapon", element, element, getItemWeaponID(loadallItem[getType(element)][getOwnerID(element)][value][i]['itemID']))
				end
				]]--

			end
		end
	end
	if loadallItem[getType(element)] and  loadallItem[getType(element)][getOwnerID(element)] then 
		triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, loadallItem[getType(element)][getOwnerID(element)])
	else
		triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, {})
	end
end
addEvent('btcMTA->#RemovePlayerDutyItems', true)
addEventHandler('btcMTA->#RemovePlayerDutyItems', root, RemovePlayerDutyItems)

function takePlayerItemToID(element, itemID, all)
	if not all then all = false end 
	
	local types = getItemToType(element, itemID)
	
	if not loadallItem[tonumber(getType(element)) or 0] then
		loadallItem[tonumber(getType(element)) or 0] = {}
	end		
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
	end			
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
	end	
	
	
	for i = 1, row * column do	
		if loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] and loadallItem[getType(element)][getOwnerID(element)][types] and loadallItem[getType(element)][getOwnerID(element)][types][i] and tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['itemID'] or  - 1)  == tonumber(itemID) then --
			if not all then 
				if tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['count']) > 1 then  
					setSlotCount(element, types, i, tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['value']), tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['count'])-1, tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['duty']), -1, tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['itemID']))
					break
				else
					deleteItem(element, types, tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['slot']))
					break
				end
			else
				deleteItem(element, types, tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['slot']))
			end
		end
	end
	if loadallItem[getType(element)] and  loadallItem[getType(element)][getOwnerID(element)] then 
		triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, loadallItem[getType(element)][getOwnerID(element)])
	else
		triggerClientEvent(element, 'btcMTA->#loadItemToClient', element, {})
	end
end
addEvent("btcMTA->#takePlayerItemToID", true)
addEventHandler("btcMTA->#takePlayerItemToID", root, takePlayerItemToID)


function deleteItemById(element, itemID, itemPrice)
	if not itemPrice then itemPrice = 0 end
	local types = getItemToType(element, itemID)
	
	if not loadallItem[tonumber(getType(element)) or 0] then
		loadallItem[tonumber(getType(element)) or 0] = {}
	end		
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
	end			
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
	end	
	
	local giveMoney = 0
	for i = 1, row * column do	
		if loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] and loadallItem[getType(element)][getOwnerID(element)][types] and loadallItem[getType(element)][getOwnerID(element)][types][i] and tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['itemID'] or  - 1)  == tonumber(itemID) then 
			giveMoney = giveMoney + (tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['count'])*itemPrice)
			deleteItem(element, types, i)
		end
	end
	
	if math.abs(giveMoney) > 0 then
		setElementData(element, "char:money", getElementData(element, "char:money") + math.abs(giveMoney))
		outputChatBox("#7cc576Josh: #ffffffComprou de você #00AEFF"..getItemName(itemID).."!", element, 255, 255, 255, true)
		outputChatBox("#7cc576Josh: #ffffffPreço do item vendido: #00AEFF"..formatMoney(giveMoney).."!", element, 255, 255, 255, true)
	end
end
addEvent("btcMTA->#deleteItemById", true)
addEventHandler("btcMTA->#deleteItemById", root, deleteItemById)




function deleteItemIlegal(element, itemID, itemPrice)
	if not itemPrice then itemPrice = 0 end
	local types = getItemToType(element, itemID)
	
	if not loadallItem[tonumber(getType(element)) or 0] then
		loadallItem[tonumber(getType(element)) or 0] = {}
	end		
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
	end			
	
	if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
		loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
	end	
	
	local giveMoney = 0
	for i = 1, row * column do	
		if loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] and loadallItem[getType(element)][getOwnerID(element)][types] and loadallItem[getType(element)][getOwnerID(element)][types][i] and tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['itemID'] or  - 1)  == tonumber(itemID) then 
			giveMoney = giveMoney + (tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['count'])*itemPrice)
			deleteItem(element, types, i)
		end
	end
	
	if math.abs(giveMoney) > 0 then
		setElementData(element, "char:moneysujo", tonumber(getElementData(element, "char:moneysujo") or 0) + math.abs(giveMoney))
		--outputChatBox("#7cc576Josh: #ffffffComprou de você #00AEFF"..getItemName(itemID).."!", element, 255, 255, 255, true)
		--outputChatBox("#7cc576Josh: #ffffffPreço do item vendido: #00AEFF"..formatMoney(giveMoney).."!", element, 255, 255, 255, true)
	end
end
addEvent("btcMTA->#deleteItemByIdIlegal", true)
addEventHandler("btcMTA->#deleteItemByIdIlegal", root, deleteItemIlegal)

 


function formatMoney(amount)
	local formatted = tonumber(amount)
	if formatted then
		while true do  
			formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if (k==0) then
			break
		end
	end
		return formatted
	else
		return amount
	end
end

function deleteGoldItem(element, itemID, _, state)
	if state then 
		local types = getItemToType(element, itemID)
	
		if not loadallItem[tonumber(getType(element)) or 0] then
			loadallItem[tonumber(getType(element)) or 0] = {}
		end		
		
		if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] then
			loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)] = {}
		end			
		
		if not loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] then
			loadallItem[tonumber(getType(element)) or 0][getOwnerID(element)][types] = {}
		end	
		
		local text = 0
		for i = 1, row * column do	
			if loadallItem[getType(element)] and loadallItem[getType(element)][getOwnerID(element)] and loadallItem[getType(element)][getOwnerID(element)][types] and loadallItem[getType(element)][getOwnerID(element)][types][i] and tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['itemID'] or  - 1)  == tonumber(itemID) then 
				deleteItem(element, types, tonumber(loadallItem[getType(element)][getOwnerID(element)][types][i]['slot']))
				local money = math.random(5000, 15000)
				text = text + money 
			end
		end
		if text ~= 0 then 
			outputChatBox("#7cc576Jason Power: #ffffffVocê vendeu as barras de ouro por #00AEFF"..text.."!", element,124,197,118,true) -- sikeresen leadtad az aranyat gecóó
			setElementData(element, 'money', getElementData(element, 'money') + text)
		end
	end
end
addEvent("btcMTA->#deleteGoldItem", true)
addEventHandler("btcMTA->#deleteGoldItem", root, deleteGoldItem)



--[[
addEventHandler('onPlayerWasted', root, function ()
	takePlayerItemToID(source, 82, true)
	takePlayerItemToID(source, 230, true)
end)
]]--


------------------------------

-- // animação ~ / me

------------------------------
local timers = { }
function setPlayerAnimation(element, animName, animtoName, animTime)
if ( isElement(element) ) then
    if not animTime then animTime = 3000 end ---1 end	
    setPedAnimation(element, animName, animtoName, animTime, true, false, false )
	timers[element] = setTimer(function()
	setPedAnimation(element)
	setElementFrozen(element, false)
	end,animTime,1)
	end
end
addEvent("btcMTA->#setPlayerAnimation", true)
addEventHandler("btcMTA->#setPlayerAnimation", getRootElement(), setPlayerAnimation)

function meAction(player, text)
    exports.bgo_chat:sendLocalMeAction(player, text)
end
addEvent("btcMTA->#setPlayerMe", true)
addEventHandler("btcMTA->#setPlayerMe", getRootElement(), meAction)

------------------------------

-- // lixo

------------------------------

local kuka

function loadTrash()
    Async:setPriority(500, 100)

    dbQuery(function(loadedItemQuery)
        local queryElement, queryNumber = dbPoll(loadedItemQuery, 0)
        if queryNumber > 0 then
            Async:foreach(queryElement, function(trash)
                trashPos = fromJSON(trash["pos"]) or "[[ 0,0,0,0,0,0,0,0 ]]"

                kuka = createObject(1359, trashPos[1], trashPos[2], trashPos[3] - 0.4, trashPos[4], trashPos[5], trashPos[6])
                setElementData(kuka, "kukaID", trash['id'])
                setElementInterior(kuka, trashPos[7])
                setElementDimension(kuka, trashPos[8])
            end)
            local time = ((queryNumber * 100) / 60 / 1000)

            outputDebugString("Loaded Trash (" .. queryNumber .. " DB) (" .. math.floor(time) .. " mp)", 0, 25, 181, 254)
        end
    end, connection, "SELECT * FROM bins")
end

addEventHandler("onResourceStart", resourceRoot, loadTrash)


addCommandHandler("createkuka",
    function(playerSource, cmd)
        if (getElementData(playerSource, "acc:admin") >= 6) then
            local x, y, z = getElementPosition(playerSource)
            local rx, ry, rz = getElementRotation(playerSource)
            local int = getElementInterior(playerSource)
            local Dim = getElementDimension(playerSource)

            local Query, _, insertID = dbQuery(connection, "INSERT INTO bins SET pos = ?", toJSON({ x, y, z, rx, ry, rz, int, Dim })) -- SQL BEszúrás

            --local Query, _, insertID = dbQuery(connection, "INSERT INTO bins (pos) VALUES(?)", toJSON({x, y, z, rx, ry, rz, int ,Dim}))


            local checkQuery, _, insertID = dbPoll(Query, -1)
            if checkQuery then
                outputChatBox("#7cc576[btc~Items] #ffffff Lixo criado.", playerSource, 255, 255, 255, true)
                kuka = createObject(1359, x, y, z - 0.4, rx, ry, rz)
                setElementData(kuka, "kukaID", insertID)
                setElementInterior(kuka, int)
                setElementDimension(kuka, Dim)
            end
        end
    end)

addCommandHandler("delkuka",
    function(playerSource, cmd)
        if getElementData(playerSource, "acc:admin") >= 6 then
            local x, y, _ = getElementPosition(playerSource)
            local kukashape = createColCircle(x, y, 3)
            local kukaszam = 0
            for _, v in ipairs(getElementsWithinColShape(kukashape, "object")) do
                local kukaid = getElementData(v, "kukaID") or 0
                kukaszam = kukaszam + 1
                destroyElement(kukashape)
                if kukaid >= 1 then
                    destroyElement(v)
                end
                dbPoll(dbQuery(connection, "DELETE FROM bins WHERE id = '?'", kukaid), 0)
                outputChatBox("#7cc576[btc~Items] #ffffffLixeira excluída com sucesso. ID: #F7CA18" .. kukaid, playerSource, 255, 255, 255, true)
                return
            end
            if (kukaszam == 0) then
                destroyElement(kukashape)
                outputChatBox("#D24D57[btc~Items] #ffffffNão há lixo perto de você.", playerSource, 255, 255, 255, true)
            end
        end
    end)

------------------------------

-- // Attach

------------------------------

local object = {}
local attachedTable = {
    -- [ItemID] = {OBJID, boneID, x, y, z, rotx, roty, rotz}
    [1] = { 2703, 12, 0, 0.05, 0.095, 0, 300, 0 },
    [2] = { 2769, 12, 0, 0.05, 0.095, 0, 300, 0 },
    [3] = { 2880, 12, -0.05, 0.1, 0.03, 90, 300, 0 },
    [5] = { 2702, 12, -0.04, 0.02, 0.08, 120, -80, 0 },
    [7] = { 1543, 11, -0.25, -0.12, 0.12, 3000, -70, 190 },
    [8] = { 1484, 11, 0.05, 0.02, 0.15, 200, 0, 190 },
    [9] = { 1486, 11, -0.01, 0, 0.08, 180, 300, 190 },
    [10] = { 1668, 11, -0.05, 0, 0.12, 180, 300, 190 },
    [11] = { 1520, 11, -0.1, 0, 0.15, 180, 300, 190 },
    [12] = { 2647, 11, 0.02, -0.02, 0.12, 180, 300, 190 },
    [215] = { 3027, 12, 0, 0.05, 0.095, 0, 300, 0 },
    [144] = { 1485, 12, -0.02, 0, -0.02, 0, 270, 0 },
}

function createAttachObj(element, itemID, anim, destroy)
    if attachedTable[itemID] then
        if not destroy then
            if not (object[element]) then
                object[element] = createObject(attachedTable[itemID][1], 0, 0, 0)
                setElementInterior(object[element], getElementInterior(element))
                setElementDimension(object[element], getElementDimension(element))
                exports.bone_attach:attachElementToBone(object[element], element, attachedTable[itemID][2], attachedTable[itemID][3], attachedTable[itemID][4], attachedTable[itemID][5], attachedTable[itemID][6], attachedTable[itemID][7], attachedTable[itemID][8])
            else
                exports.bone_attach:detachElementFromBone(object[element])
                destroyElement(object[element])
                object[element] = nil
            end
        else
            if isElement(object[element]) then
                exports.bone_attach:detachElementFromBone(object[element])
                destroyElement(object[element])
                object[element] = nil
            end
        end
    end
end

addEvent('btcMTA->#createAttachObj', true)
addEventHandler('btcMTA->#createAttachObj', root, createAttachObj)

------------------------------

-- // Weapon

------------------------------

local ATM_TIMEOUT = 1200000

local atmCooldown = {}
local atmSerial = {}


function atmIsAbleToRob ( player )
	return not isTimer(atmCooldown[player])
end

addCommandHandler('rpunicao',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 10)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 1 then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then
			outputChatBox (" Você removeu o punimento de armas do jogador "..getPlayerName(targetPlayer).." ", thePlayer, 255, 0, 0, true )
			exports.bgo_discordlogs:sendDiscordMessage(1, false, " "..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "").." Removeu o punimento de armas do jogador "..getPlayerName(targetPlayer):gsub("#%x%x%x%x%x%x", "").." ")
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
	
	
triggerClientEvent(player, "bgo>info", player,"Informação", "Você foi punido e não poderá utilizar armas novamente por "..atmGetTimeOut ( player ).." segundos!", "info")
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

addEventHandler("onPlayerWasted", root,
	function ()
		--if getPedWeapon(source) > 0 and atmIsAbleToRob(source) then
		if atmIsAbleToRob(source) then
		if getElementData(source,"acc:id") == 1 then
		print("Morri")
		end
		setElementData(source,"char:morto", true)
		end
	end
)

addEventHandler("onPlayerSpawn", root,
	function ()
		if getElementData(source,"char:morto") == true then
		atmSetTimeOut(source, ATM_TIMEOUT)
		setElementData(source,"char:morto", false)
		end
	end
)


function toggleGun(element, slot, item, itemValue)

	if ( not atmIsAbleToRob(element) ) then
	triggerClientEvent(element, "bgo>info", element,"Informação", "Você está punido de equipar qualquer tipo de armamento por ".. atmGetTimeOut ( element ) .. " segundos", "info")
	return
	end

    if item and itemLists[item].weaponID and getPedWeapon(element) > 0 and tonumber(getPedWeapon(element)) ~= tonumber(itemLists[item].weaponID) then
        outputChatBox("#D24D57[BGO~Items] #ffffffPrimeiro guarde sua arma", element, 255, 255, 255, true)
        return
    end
    takeAllWeapons(element)
    if item and itemLists[item].weaponID and (getElementData(element, "char:weaponInHand") or { -1, -1, -1 })[1] < 1 then
        local ammo = 0
        ammo = itemValue
        triggerEvent("server->applyTexture", element, element, exports["bgo_fegyverPJ"]:getWeaponWeaponShaderName(getWeaponID(item)), getStickerWeapon(item));
        giveWeapon(element, itemLists[item].weaponID, ammo, true)
		
        setElementData(element, "char:weaponInHand", { item, slot, itemLists[item].weaponID })
        setElementData(element, "char:weaponGettin" .. getItemType(item) .. slot, true)

        if tonumber(itemLists[item].AmmoID) then
		
		   local theVehicle = getPedOccupiedVehicle ( element )
			if not theVehicle then
            setPedAnimation(element, "BUDDY", "buddy_reload", 1000, false, true, true)
			end
        end

    else
        if getElementData(element, "char:weaponGettin" .. getItemType(item) .. slot) then
            triggerEvent("server->destroyTexture",element,element,element)
            setElementData(element, "char:weaponInHand", { -1, -1, -1 })
            setElementData(element, "char:weaponGettin" .. getItemType(item) .. slot, false)
        end
    end
end

addEvent("toggleGun", true)
addEventHandler("toggleGun", root, toggleGun)


------------------------------
function toggleGun22(element, slot, item, itemValue)
    if item and itemLists[item].weaponID and getPedWeapon(element) > 0 and tonumber(getPedWeapon(element)) ~= tonumber(itemLists[item].weaponID) then
        outputChatBox("#D24D57[BGO~Items] #ffffffPrimeiro guarde sua arma", element, 255, 255, 255, true)
        return
    end
    takeAllWeapons(element)
    if item and itemLists[item].weaponID and (getElementData(element, "char:weaponInHand") or { -1, -1, -1 })[1] < 1 then
        ammo = itemValue
        giveWeapon(element, itemLists[item].weaponID, ammo, true)
		--else
		-- outputChatBox("#D24D57[BGO~Items] #ffffffja tem uma molotov equipada!", element, 255, 255, 255, true)
    end
end

addEvent("toggleGun2", true)
addEventHandler("toggleGun2", root, toggleGun22)

------------------------------

-- // Bag

------------------------------
function getBagToElement(element)
    if hasItemS(element, oneLevelBagID) then -- // Sima Táska
        return oneLevelBag
    elseif hasItemS(element, premiumLevelBagID) then -- // Prémium Táska
        return premiumLevelBag
    else
        return baseWeight
    end
end


function getMaxWeight(element)
    --if (tostring(getElementType(element)) == "player") then
	if (getElementType(element) == "player") then
        return getBagToElement(element)
    elseif (tostring(getElementType(element)) == "vehicle") then
        return vehicleWeight[getElementModel(element)] or 50
    elseif (tostring(getElementType(element)) == "object") then
        return 100
    end
    return 0
end



------------------------------
-- // Debug dolgok
------------------------------


addEventHandler("onResourceStart", resourceRoot, function()
    for key, player in ipairs(getElementsByType("player")) do
        --if getElementData(player, "char:id") or -1 > 0 then
        if getElementData(player, "loggedin") then
            takeAllWeapons(player)
            setElementData(player, "char:weaponInHand", { -1, -1, -1 })
            setElementData(player, "char:weaponGettin", false)

            --setTimer(function()
            --	triggerClientEvent(player, "updatePlayerWeapons", player,player)
            --end,1000,1)
        end
    end
end)

------------------------------

-- // Baúhez tartozó dolgok

------------------------------
function loadSafeToServer()
    Async:setPriority(500, 100)

    dbQuery(function(loadedItemQuery)
        local queryElement, queryNumber = dbPoll(loadedItemQuery, 0)
        if queryNumber > 0 then
            Async:foreach(queryElement, function(safeTable)
                local pos = fromJSON(safeTable["Position"])
                local safe = createObject(2332, pos[1], pos[2], pos[3], pos[4], pos[5], pos[6])

                setElementInterior(safe, safeTable["Interior"])
                setElementDimension(safe, safeTable["Dimension"])
                setElementData(safe, "safe->ID", safeTable["ID"])
                setElementData(safe, "safe->State", safeTable["Status"])
            end)
            local time = ((queryNumber * 100) / 60 / 1000)

            outputDebugString("Loaded safe (" .. queryNumber .. " DB) (" .. math.floor(time) .. " mp)", 0, 25, 181, 254)
        end
    end, connection, "SELECT * FROM safe")
end

addEventHandler("onResourceStart", resourceRoot, loadSafeToServer)

addEvent("item->createSafe", true)
addEventHandler("item->createSafe", root, function(player)
    if player then
        local x, y, z = getElementPosition(player)
        local rx, ry, rz = getElementRotation(player)
        local int = getElementInterior(player)
        local dim = getElementDimension(player)
        local pos = toJSON({ x, y, z - 0.5, rx, ry, rz - 180 })
        local InsertSafe = dbQuery(connection, "INSERT INTO safe SET Position	=?, Interior = ?, Dimension=?", pos, int, dim)


        --local InsertSafe = dbQuery(connection, "INSERT INTO safe (Position, Interior, Dimension) VALUES(?, ?, ?)", pos, int, dim)




        if InsertSafe then
            local safe = createObject(2332, x, y, z - 0.5, rx, ry, rz - 180)
            setElementInterior(safe, int)
            setElementDimension(safe, dim)

            local QueryState, _, SafeIDs = dbPoll(InsertSafe, -1)
            if QueryState then
                setElementData(safe, "safe->ID", SafeIDs)
                setTimer(function()
                    giveItem(player, 19, SafeIDs, 1, 0)
                end, 100, 1)
            end
        end
    end
end)



addCommandHandler("createsafe",
    function(playerSource, cmd)
        if (tonumber(getElementData(playerSource, "acc:admin")) >= 6) then


            local x, y, z = getElementPosition(playerSource)
            local rx, ry, rz = getElementRotation(playerSource)
            local int = getElementInterior(playerSource)
            local dim = getElementDimension(playerSource)
            local pos = toJSON({ x, y, z - 0.5, rx, ry, rz - 180 })
            local InsertSafe = dbQuery(connection, "INSERT INTO safe SET Position	=?, Interior = ?, Dimension=?", pos, int, dim)


            --local InsertSafe = dbQuery(connection, "INSERT INTO safe (Position, Interior, Dimension) VALUES(?, ?, ?)", pos, int, dim)




            if InsertSafe then
                local safe = createObject(2332, x, y, z - 0.5, rx, ry, rz - 180)
                setElementInterior(safe, int)
                setElementDimension(safe, dim)

                local QueryState, _, SafeIDs = dbPoll(InsertSafe, -1)
                if QueryState then
                    setElementData(safe, "safe->ID", SafeIDs)
                    setTimer(function()
                        giveItem(player, 19, SafeIDs, 1, 0)
                    end, 100, 1)
                end
            end
        end
    end)


addCommandHandler("nearbysafe",
    function(playerSource, cmd)
        if (tonumber(getElementData(playerSource, "acc:admin")) >= 6) then
            local pX, pY, pZ = getElementPosition(playerSource)
            for k, v in ipairs(getElementsByType("object")) do
                vX, vY, vZ = getElementPosition(v)
                local dist = getDistanceBetweenPoints3D(pX, pY, pZ, vX, vY, vZ)
                local id = getElementData(v, "safe->ID") or "Desconhecido"
                local interior = getElementInterior(playerSource)
                local dimension = getElementDimension(playerSource)
                local interior1 = getElementInterior(v)
                local dimension1 = getElementDimension(v)
                if dist <= 15 and interior == interior1 and dimension == dimension1 then
                    outputChatBox("#F7CA18[Object] #F89406 Seguro #F89406| #ffffffdistância: #F89406" .. math.ceil(dist) .. " metros #F89406| #ffffffID:#F89406[" .. id .. "]", playerSource, 255, 255, 255, true)
                end
            end
        end
    end)

addCommandHandler("delsafe", function(player, _, safeID)
    if getElementData(player, "acc:admin") < 7 then return end
    if not tonumber(safeID) then
        outputChatBox(" /delsafe [ID]", player, 0, 0, 0, true)
        return
    end

    safeID = tonumber(safeID)
    --if (getElementData (player, "adminduty") or 0) == 1 then
    for _, safe in ipairs(getElementsByType("object")) do
        if tonumber(getElementData(safe, "safe->ID")) == safeID then
            destroyElement(safe)
            local delQuery = dbPoll(dbQuery(connection, "DELETE FROM safe WHERE id=?", safeID), -1)
            local delQuery = dbPoll(dbQuery(connection, "DELETE FROM items WHERE owner=?", safeID), -1)
            for k, v in ipairs(getElementsByType("player")) do
                if isElement(v) and tonumber(getElementData(v, "acc:admin") or 0) >= 7 then
                    outputChatBox("#D64541[Developer]#ffffff #7cc576" .. getElementData(player, "char::anick") .. " #ffffffexcluiu um Safe (ID: #7cc576" .. safeID .. "#ffffff)", v, 255, 255, 255, true)
                    exports.global:sendMessageToAdmins("#7CC576[#7CC576BGO#ffffffMTA #ffffff- #53bfdcadmin Log#7CC576] #00aeff" .. getElementData(player, "char::anick") .. " #ffffffexcluiu um Safe (ID: #7cc576" .. safeID .. "#ffffff)", 255, 0, 0, true)
                    --exports.logs:logMessage("[Baú]  "..getElementData(player, "char::anick").." excluiu um Safe (ID: "..safeID..")", 34)
                end
            end
        end
    end
    --else
    --	outputChatBox("#D24D57[btc - Defesa]: #FFFFFFVocê não é um administrador!", player, 255, 255, 255, true)
    --end
end)

addCommandHandler("movesafe", function(player, _, safeID)
    if getElementData(player, "acc:admin") < 5 then return end
    if not tonumber(safeID) then
        outputChatBox(" /movesafe [ID]", player, 0, 0, 0, true)
        return
    end
    safeID = tonumber(safeID)
    --if (getElementData (player, "adminduty") or 0) == 1 then
    for _, safe in ipairs(getElementsByType("object")) do
        if tonumber(getElementData(safe, "safe->ID")) == safeID then

            local x, y, z = getElementPosition(player)
            local rx, ry, rz = getElementRotation(player)
            local int = getElementInterior(player)
            local dim = getElementDimension(player)
            if int > 0 and dim > 0 then
                setElementPosition(safe, x, y, z - 0.5)
                setElementRotation(safe, rx, ry, rz - 180)
                setElementInterior(safe, int)
                setElementDimension(safe, dim)
                local pos = toJSON({ x, y, z - 0.5, rx, ry, rz - 180 })
                dbExec(connection, "UPDATE safe SET Position = ?, Interior = ?, Dimension = ? WHERE ID = ?", pos, int, dim, safeID)



                for k, v in ipairs(getElementsByType("player")) do
                    if isElement(v) and getElementData(v, "loggedin") and tonumber(getElementData(v, "acc:admin") or 0) >= 7 then
                        outputChatBox("#D64541[Developer]#ffffff #7cc576" .. getElementData(player, "char::anick") .. " #ffffffMudou de posição para o Baú (ID: #7cc576" .. safeID .. "#ffffff)", v, 255, 255, 255, true)
                        exports.global:sendMessageToAdmins("#7CC576[#7CC576BGO#ffffffMTA #ffffff- #53bfdcadmin Log#7CC576] #00aeff" .. getElementData(player, "char::anick") .. " #ffffffMudou de posição para o Baú! (ID: #7cc576" .. safeID .. "#ffffff)", 255, 0, 0, true)

                        --exports.logs:logMessage("[Baú]  "..getElementData(player, "char::anick").." Mudou de posição para o Baú! (ID: "..safeID..")", 34)
                    end
                end
            end
        end
    end
    --else
    --	outputChatBox("#D24D57[btc - Defesa]: #FFFFFFVocê não é um administrador!", player, 255, 255, 255, true)
    --end
end)

addEvent("Items-->DeleteSafes", true)
addEventHandler("Items-->DeleteSafes", root, function(player, safeElement, safeID)
    destroyElement(safeElement)
    local delQuery = dbPoll(dbQuery(connection, "DELETE FROM safe WHERE id=?", safeID), -1)
    local delQuery = dbPoll(dbQuery(connection, "DELETE FROM items WHERE owner=?", safeID), -1)
    loadPlayerItems(player)
end)


abinis2 = {
    ["E8D999E78FCA719E63D5F75D151AB8A2"] = true,
    --["41247E61601E8F9F942C1E9EC4270C02"] = true -- Luana
}



function ugyislebuksz(player, item)
    --local comy = getPlayerName(player) --getElementData(player, "char::anick")
    local item = getItemName(item)

    for k, v in ipairs(getElementsByType("player")) do
        if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then
            outputChatBox("#D64541[FUNDADOR] #7cc576" .. getPlayerName(player) .. " #ffffffPegou um item novo: " .. item .. " ", v, 255, 255, 255, true)
        end
    end

	exports.logs:logMessage("[FUNDADOR]  " .. getPlayerName(player) .. " ("..getElementData(player, "char:id")..") Pegou um item novo (" .. item .. ")", 9)
end

addEvent("ugyislebuksz", true)
addEventHandler("ugyislebuksz", getRootElement(), ugyislebuksz)

function ugyislebuksz3(player, item)
    local comy = getElementData(player, "char::anick") or getPlayerName(player)
    local item = getItemName(item)
    --exports.logs:logMessage("[caixote do lixo] --> "..comy.." jogou um objeto no lixo! [".. item .."]", 34)
end

addEvent("ugyislebuksz3", true)
addEventHandler("ugyislebuksz3", getRootElement(), ugyislebuksz3)


--[[
function setPlayerAnimation(player, animName, animtoName, animTime, loop)
    setPedAnimation(player, animName, animtoName, animTime, loop, false, false)
    setTimer(setPedAnimation, animTime, 1, player)
end

addEvent('btcMTA->#setPlayerAnimation', true)
addEventHandler('btcMTA->#setPlayerAnimation', root, setPlayerAnimation)
]]--




