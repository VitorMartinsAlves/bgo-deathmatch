local connection = exports["bgo_mysql"]:getConnection() -- // SQL kapcsolat
local shopPed = {}

addEventHandler("onResourceStart", root, function(startedRes)
	if getResourceName(startedRes) == "bgo_mysql" then
		connection = exports['bgo_mysql']:getConnection()
		restartResource(getThisResource())
	end
end)

------------------------------

-- // Shop betöltése

------------------------------

addEventHandler('onResourceStart', resourceRoot, function()
	loadShop()
end)

Async:setPriority("high")
Async:setDebug(true)

function loadShop()
	Async:setPriority(500, 100)
	
	dbQuery(function(loadedItemQuery)
		local queryElement, queryNumber = dbPoll(loadedItemQuery, 0)
		if queryNumber > 0 then
			Async:foreach(queryElement, function(shopTable)
				local position = fromJSON(shopTable["pos"])
				shopPed[shopTable["id"]] = createPed(shopTable["skin"], position[1], position[2], position[3])
				if isElement(shopPed[shopTable["id"]]) then 
					setPedRotation(shopPed[shopTable["id"]], position[6] or 0)
					setElementDimension(shopPed[shopTable["id"]], position[4])
					setElementInterior(shopPed[shopTable["id"]], position[5])
					setElementFrozen(shopPed[shopTable["id"]], true)
					setElementData(shopPed[shopTable["id"]], "shop >> owner", shopTable["owner"])
					setElementData(shopPed[shopTable["id"]], "shop >> type", shopTable["type"])	
					setElementData(shopPed[shopTable["id"]], "shop >> npc", true)
					setElementData(shopPed[shopTable["id"]], "shop >> id", shopTable["id"])
					setElementData(shopPed[shopTable["id"]], "ped >> death", true)
					setElementData(shopPed[shopTable["id"]], "name:tags", "PED")
					setElementData(shopPed[shopTable["id"]], "Ped:Name",shopTable["name"])
				end
			end)
			
			local time = ((queryNumber*100)/60/1000)

			outputDebugString("Loaded Shop (".. queryNumber .." DB) ("..math.floor(time).." mp)", 0, 25, 181, 254)
		end
	end, connection, "SELECT * FROM shops" ) 
end

------------------------------

-- // Shop törlése

------------------------------

addCommandHandler("delshop",
function(playerSource, cmd)
	if getElementData( playerSource, "acc:admin" ) >= 3 then
		local x, y, _ = getElementPosition(playerSource)
		local shopShape = createColCircle ( x, y, 3 )
		local shopNumber = 0
		for _,v in ipairs(getElementsWithinColShape ( shopShape, "ped" ) ) do
				local ShopID = getElementData(v,"shop >> id") or 0
				shopNumber = shopNumber + 1
				destroyElement(shopShape)
				if ShopID >= 1 then 
					destroyElement(v)
				end
				dbPoll ( dbQuery( connection, "DELETE FROM shops WHERE id = '?'", ShopID), 0 )
				outputChatBox("#7cc576[bgo~Items] #ffffffLoja excluída com sucesso. ID: #F7CA18"..ShopID, playerSource, 255, 255, 255, true)
				return
		end
		if(shopNumber == 0) then
			destroyElement(shopShape)
			outputChatBox("#D24D57[bgo~Items] #ffffffNenhuma loja perto de você.", playerSource, 255, 255, 255, true)
		end
	end
end)

------------------------------

-- // Shop létrehozása

------------------------------

function createShop(element, cmd, skin, type, name)
	if (getElementData(element, 'acc:admin') >= 7) then 
		if not (skin) or not type or not name and tonumber(type) < 0 and tonumber(type) < #shopItemList+1 then
			outputChatBox("#7cc576[use]:#ffffff /".. cmd .." [Olhar NPC] [tipo] [NPC nome]", element,255,255,255,true)
			outputChatBox("#ffffffTípus: 1: Food Individual 2: Loja de bebidas 3: Loja geral 4: eletrônica 5: Loja de passatempo 6: Burger Shot 7: Cluck'n'Bell 8: Pizza 9: Suprimentos de mineração 10: Suprimentos para lenhadores 11: Vajdaság 12: Loja da máfia 13: pescaria 14: loja Arma", element,255,255,255,true)
			outputChatBox("15: Lojas de tabaco 16: Mudas ilegais 17: artigos de papelaria 18: Armazem de peixe 19: farmácia 20: pet Store 21: Mascaras 22: Martelo, 23: Caneta, 24: Contrato de vendas", element,255,255,255,true)
		return
		end
		local x, y, z = getElementPosition(element)
		local dim = getElementDimension(element)
		local int = getElementInterior(element)
		local rot = getPedRotation(element)
		
		local position = toJSON( {x, y, z, dim, int, rot})
		local insertQuery = dbQuery( connection, "INSERT INTO `shops` SET `type`=?, `pos`=?, `skin`=?, `name`=?", tonumber(type), position, skin, name)
		local insertQueryData, _, insertID = dbPoll ( insertQuery, -1 )
		if (insertQueryData) then
			shopPed[insertID] = createPed(skin,x,y,z)
			setPedRotation(shopPed[insertID], rot)
			setElementDimension(shopPed[insertID], dim)
			setElementInterior(shopPed[insertID], int)
			setElementFrozen(shopPed[insertID], true)
			setElementData(shopPed[insertID], "shop >> type", type)	
			setElementData(shopPed[insertID], "ped >> death", true)
			setElementData(shopPed[insertID], "shop >> npc", true)
			setElementData(shopPed[insertID], "shop >> id", insertID)
			setElementData(shopPed[insertID], "name:tags", "NPC")
			setElementData(shopPed[insertID], "Ped:Name", name)
		end
	end
end
addCommandHandler('addshop', createShop)
addCommandHandler('createshop', createShop)

------------------------------

-- // Item adás

------------------------------

function buyItem(player, item, value, count, amount, duty)
	money = getElementData(player,"char:money") or 0
	-- if money >= amount then
		if item == 16 then 
			-- if setElementData(player,"char:money",money-amount) then 
				exports['btcPhone']:addPhone(player)
			-- end
		else
			-- if setElementData(player,"char:money",money-amount) then 
				if exports.bgo_items:giveItem(player, item, value, count, 0, true) then 
					outputChatBox("#ffffffVocê conseguiu um #32B3FF".. exports.bgo_items:getItemName(item).." #ffffffobjeto.",player,255,0,0,true)
				else
					-- setElementData(player, "char:money", money + amount)
				end
			-- end
		end
	-- else
		-- outputChatBox("#ffffffNincs elég pénzed meg venni a kiválasztott tárgyat! (#32B3FF".. amount .." #ffffffFt).",player,255,255,255,true)
	-- end
end
addEvent("btcMTA->#buyItem", true)
addEventHandler("btcMTA->#buyItem", getRootElement(), buyItem)
