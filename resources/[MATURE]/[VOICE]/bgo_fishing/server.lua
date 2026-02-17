local sellPed = {}
local sellCol = {}
local stick = {}
local float = {}
local receive = {}
local fishingTable = {86, 87, 88, 89, 90, 91, 92, 93, 94, 95}
local sellPos = {
	{156, 1919.427, -1368.094, 13.669, "Comprador de Peixe - Josh", 109.07637023926, 10, 10, 3}
}
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function ()
	for index, value in ipairs (sellPos) do 
		if isElement(sellPed[index]) then destroyElement(sellPed[index]) end
		if isElement(sellCol[index]) then destroyElement(sellCol[index]) end
		sellPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(sellPed[index], true)
		setElementData(sellPed[index], "ped >> death", true)
		setPedRotation(sellPed[index], value[6])
		setElementData(sellPed[index], "Ped:Name", value[5])
		-- setElementData(sellPed[index], "name:tags", "Hal felvásárló")		
		sellCol[index] = createColSphere(value[2], value[3], value[4], 3)
		setElementData(sellCol[index], "sell:fishing", true)
	end
end)

function attachStick(player, type)
	if not stick[player] then 
		stick[player] = createObject(338, 0, 0, 0)
		exports["bone_attach"]:attachElementToBone(stick[player],player,12,0,-0.02,-0.05,0,260,0)
		setTimer(function ()
			setElementData(player, "fishing", true)
		end, 200, 1)
		triggerClientEvent(player, "char:synchronization", player, false, stick, false)
		--exports.bgo_chat:sendLocalMeAction(player,"Tira a vara de pescar.")
	elseif stick[player] or not type then
		exports["bone_attach"]:detachElementFromBone(stick[player])
		destroyElement(stick[player])
		stick[player] = nil
		triggerClientEvent(player, "char:synchronization", player, false, stick, false)
		setElementData(player, "fishing", false)
		--exports.bgo_chat:sendLocalMeAction(player,"Parou a vara de pescar.")
	end
end
addEvent("createandattachStick", true)
addEventHandler("createandattachStick", root, attachStick)

function giveFishintToServer(player)
	randomFish = fishingTable[math.random(#fishingTable)]
	if randomFish and player then 
		if exports["bgo_items"]:giveItem(player, randomFish, 1, 1, 0) then 
			local startTime = getTickCount()
			setElementData(player,"char >> showedItem",{true,randomFish,exports.bgo_items:getItemName(randomFish),exports.bgo_items:getItemDescription(randomFish),getTickCount()})
			outputChatBox("#53bfcd[Pescaria]: #ffffffVocê conseguiu capturar um #4183d7" .. exports.bgo_items:getItemName(randomFish) .. "#ffffff peixe/item!", player, 255, 255, 255, true)

			exports.bgo_chat:sendLocalMeAction(player, "Peguei um peixe: ".. exports.bgo_items:getItemName(randomFish))
			setTimer(function(player)
				setElementData(player,"char >> showedItem",{false,nil,nil,nil,nil})
			end,5000,1, player)			
		end
	end
end
addEvent("giveFishintToServer", true)
addEventHandler("giveFishintToServer", root, giveFishintToServer)

function createTranslator(player, worldX, worldY, worldZ)
	if not float[player] then 
		float[player] = createObject(1974, worldX, worldY, worldZ)
		setObjectScale(float[player], 2)
		triggerClientEvent(player, "char:synchronization", player, float, false, false)
		--exports.bgo_chat:sendLocalMeAction(player,"Jogou a bóia na água.")
	else
		destroyElement(float[player])
		float[player] = nil
		triggerClientEvent(player, "char:synchronization", player, float, false, false)
	end
end
addEvent("createTranslator", true)
addEventHandler("createTranslator", root, createTranslator)

function setPlayerAbimation(player, state, Anim, Animname)
	setPedAnimation(player, Anim, Animname, -1, true, true, true)
	receive[player] = state
	triggerClientEvent(player, "char:synchronization", player, false, false, receive)
end
addEvent("setPlayerAbimation", true)
addEventHandler("setPlayerAbimation", root, setPlayerAbimation)

local fishIds = {
	--id  ár
	{86, 120}, -- 12000
	{87, 120}, -- 12000
	{88, 0},
	{89, 0},
	{90, 0},
	{91, 0},
	{92, 220}, -- 22000
	{93, 350}, -- 17000
	{94, 580}, -- 17000
	{95, 600}, -- 27000
	{96, 950}, -- 17000
}
function sellFishing(element)
	for key, value in ipairs(fishIds) do
		exports["bgo_items"]:deleteItemById(element, value[1], value[2])
	end
end
addEvent("sell:Fishing", true)
addEventHandler("sell:Fishing", root, sellFishing)

function joinSynchronization()
	triggerClientEvent(root, "char:synchronization", root, float, stick, receive)
end
--addEventHandler("onPlayerJoin", getRootElement(), joinSynchronization)

function quitSynchronization()
	if (stick[source]) then
		attachStick(source)
	end	
	if (float[source]) then
		createTranslator(source)
	end
end
addEventHandler("onPlayerQuit", getRootElement(), quitSynchronization)