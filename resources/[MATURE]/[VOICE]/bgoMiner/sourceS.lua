--local connection = exports["mysql"]:getConnection(getThisResource())
local connection = exports.bgo_mysql:getConnection()
--[[
addEventHandler("onResourceStart", root, function(startedRes)
	if getResourceName(startedRes) == "mysql" then
		connection = exports['mysql']:getConnection(getThisResource())
		restartResource(getThisResource())
	end
end)]]--

local modellID = 868
local destroyModelID = 807

local stoneTable = {}
local stoneTimer = {}

local oreTable = {
	-- { ID, Min db, MaxDB, minPay, maxPay},
	{249, 10, 10, 10, 60},
	{250, 10, 20, 10, 60},
	{250, 10, 20, 10, 60},
	{250, 10, 20, 10, 60},
		{263, 1, 2, 10, 100},
	{250, 10, 20, 10, 60},
	{250, 10, 20, 10, 60},
	{250, 10, 20, 10, 60},
	{250, 10, 20, 10, 60},
	{250, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
		{263, 1, 2, 10, 100},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{251, 10, 20, 10, 60},
	{252, 5, 10, 12, 60},
	{253, 10, 20, 10, 60},
	{253, 10, 20, 10, 60},
	{253, 10, 20, 10, 60},
	{253, 10, 20, 10, 60},
		{263, 1, 2, 10, 100},
	{254, 10, 20, 10, 60},
	{254, 10, 20, 10, 60},
	{254, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
		{263, 1, 2, 10, 100},
	{255, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
	{255, 10, 20, 10, 60},
	{256, 10, 20, 15, 60},
	{256, 10, 20, 15, 60},
	{256, 10, 20, 15, 60},
	{256, 10, 20, 15, 60},
	{256, 10, 20, 15, 60},
		{263, 1, 2, 10, 100},
	{256, 10, 20, 15, 60},
	{256, 10, 20, 15, 60},
	{256, 10, 20, 15, 60},
	{257, 10, 30, 10, 60},
	{258, 10, 30, 14, 60},
	{259, 10, 80, 10, 52},
	{260, 1, 20, 10, 60},
		{263, 1, 2, 10, 100},
	{261, 5, 30, 15, 150},
	{262, 10, 100, 0, 1},
	{262, 10, 100, 0, 1},
	{263, 1, 2, 10, 100},
	{263, 1, 2, 10, 100},
	{263, 1, 2, 10, 100},
	{263, 1, 2, 10, 100},
	{263, 1, 2, 10, 100},
	{263, 1, 2, 10, 100},
	{263, 1, 2, 10, 100},
}

Async:setPriority("high")
Async:setDebug(true)

------------------------------

-- // Kövek Betöltés

------------------------------

function loadMinerStone()
	Async:setPriority(500, 100)
	
	dbQuery(function(loadStoneQuery)
		local queryElement, queryNumber = dbPoll(loadStoneQuery, 0)
		if queryNumber > 0 then
			Async:foreach(queryElement, function(stoneTable)
				local value = fromJSON(stoneTable['Value'])
				local ID = stoneTable['ID']
				createStone(modellID, ID, value[1], value[2], value[3], value[4], value[5], value[6])
			end)
			
			local time = ((queryNumber*100)/60/1000)

			outputDebugString("Loaded Stone (".. queryNumber .." DB) ("..math.floor(time).." mp)", 0, 25, 181, 254)
		end
	end, connection, "SELECT * FROM miner" ) 
end 
loadMinerStone()

------------------------------

-- // Kövek Létrehozása

------------------------------

function createIStone(player)
	if tonumber(getElementData(player, 'acc:admin') or 0) >= 7 then 
		local x, y, z = getElementPosition(player)
		local _, _, rot = getElementRotation(player)
		local int, dim = getElementInterior(player), getElementDimension(player)
		local values = toJSON({ x, y, z, rot, int, dim })
		local insertQuery = dbQuery(connection, "INSERT INTO miner SET Value=?", values)
		local dt, insert, ID = dbPoll(insertQuery,-1)
		if dt then
			createStone(modellID, ID, x, y, z, rot, int, dim)
			outputChatBox("[bgoMTA ~ Miner]: #ffffffVocê criou pedras minadas com sucesso!", player, 124, 197, 118, true)
		end
	end
end
addCommandHandler('createStone', createIStone)
addCommandHandler('createstone', createIStone)

function createStone (modellID, ID, x, y, z, rot, int, dim)
	local stone = createObject(modellID, x, y, z, 0, 0, rot)
	setElementInterior(stone, int)
	setElementDimension(stone, dim)
	setElementData(stone, 'stone >> ID', ID)
	setElementData(stone, 'stone >> Health', 1000)
	setElementData(stone, 'Dono >> stone', false)
end

addEventHandler('onElementDataChange', root, function(dataName)
	if source and getElementType(source) == 'object' and (tonumber(getElementData(source, 'stone >> ID') or 0)) > 0 then 
		if tostring(dataName) == 'stone >> Health' then 
			if getElementData(source, dataName) <= 0 then 
				setElementModel(source, destroyModelID)
				stoneTimer[source] = setTimer(function(source)
					setElementData(source, 'stone >> Health', 1000)
				end, 1000*60*5, 1, source)
			elseif getElementData(source, dataName) == 1000 then 
				setElementModel(source, modellID)
			end
		end
	end
end)

--[[
addEventHandler('onElementDataChange', root, function(dataName)
	if source and getElementType(source) == 'object' and (getElementData(source, 'stone >> ID') or 0) > 0 then 
		if tostring(dataName) == 'stone >> Dono' then 
			if not getElementData(source, dataName) then 
				setElementData(source, 'stone >> Dono', true)
				stoneTimer[source] = setTimer(function(source)
					setElementData(source, 'stone >> Dono', false)
				end, 60000, 1, source)
			end
		end
	end
end)

]]--

local dono = { }
function SellOre2(element)
	for k,v in ipairs(getElementsByType("object", getResourceRootElement(getThisResource()), true)) do
		if isElement(v) and tonumber(getElementData(v, 'stone >> ID') or 0 ) > 0 then 
			local x, y ,z = getElementPosition(v)
				local playerx, playery, playerz = getElementPosition(element)
				if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 3 then
				outputChatBox("[bgoMTA ~ Miner]: #ffffffEstá pedra agora é sua!!", element, 124, 197, 118, true)
				setElementData(v, 'Dono >> stone', getElementData(element, "char:id"))
				setElementData(element,"donopedra", true)
				

				dono[element] = setTimer(function()
				setElementData(v, 'Dono >> stone', false)
				setElementData(element,"donopedra", false)
				end, 190000, 1)
				end
			end
	
		end
end
addEvent("bgoMTA->#Dono", true)
addEventHandler("bgoMTA->#Dono", root, SellOre2)

function SellOre3(element)
	for k,v in ipairs(getElementsByType("object", getResourceRootElement(getThisResource()), true)) do
		if isElement(v) and tonumber(getElementData(v, 'stone >> ID') or 0 ) > 0 then 
			local x, y ,z = getElementPosition(v)
				local playerx, playery, playerz = getElementPosition(element)
				if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 3 then
				setElementData(v, 'Dono >> stone', false)
				setElementData(element,"donopedra", false)				
				print("[Minério]: (".. getPlayerName(element) .. ") : ("..getElementData(element,"acc:id")..") acaba de quebrar um minerio ")
				if isTimer(dono[element]) then
				killTimer(dono[element])
				end
				end
			end
		end
end
addEvent("bgoMTA->#DonoOFF", true)
addEventHandler("bgoMTA->#DonoOFF", root, SellOre3)


function displayLoadedRes (  )
local players = getElementsByType ( "player" ) 
for theKey,thePlayer in ipairs(players) do
	setElementData(thePlayer,"donopedra", false)
end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )

				--[[
function quitPlayer ( )
				if isTimer(dono[source]) then
				for k,v in ipairs(getElementsByType("object", root, true)) do
				if isElement(v) and tonumber(getElementData(v, 'stone >> ID') or 0) > 0 then
				setElementData(v, 'Dono >> stone', false)
				setElementData(source,"donopedra", false)	
				end
				killTimer(dono[element])
				end
end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )
	]]--	


------------------------------

-- // Érc Adá / Leadás

------------------------------
local minerTImer = { }
function giveOre(player)
	if player then 
		if isTimer(minerTImer[player]) then return end
		local randomOre = math.random(#oreTable)
		local itemID = tonumber(oreTable[randomOre][1])
		local count = tonumber( math.random( oreTable[randomOre][2], oreTable[randomOre][3] ) )
		exports['bgo_items']: giveItem(player, itemID, 1, count, 0, true) 
	--	exports['bgo_items']: giveItem(player, 296, 1, 1, 0, true) 
		exports.bgo_info:addNotification(player,'você tem '.. count .. ' db '..exports.bgo_items:getItemName(itemID) .. '.','info')
		outputChatBox('#c0c0c0[minerador]: #ffffffvocê tem #F7CA18'.. count .. ' #ffffffdb #7cc576'..exports.bgo_items:getItemName(itemID) .. '#ffffff.', player, 255, 255, 255, true)
		setElementData(player,"char >> showedItem",{true, itemID, exports.bgo_items:getItemName(itemID),exports.bgo_items:getItemDescription(itemID),getTickCount()})
		setTimer(function(player)
			setElementData(player,"char >> showedItem",{false,nil,nil,nil,nil})
		end,5000,1, player)	
		minerTImer[player] = setTimer(function() end,2000,1)		
	end
end
addEvent('bgoMTA->#giveOre', true)
addEventHandler('bgoMTA->#giveOre', root, giveOre)

function SellOre(element)
	for key, value in ipairs(oreTable) do
		local money = math.random(value[4], value[5])
		exports["bgo_items"]:deleteItemById(element, value[1], money)
	end
end
addEvent("bgoMTA->#SellOre", true)
addEventHandler("bgoMTA->#SellOre", root, SellOre)
