local aclRestricted = true -- Prevent regular players from using the troll commands or not, limit it to admins/staff, default set to admins/moderators only
local aclAllowed =
{
	aclGetGroup("Console"),
}

local function getPlayerFromName(name)

	if not name then return false end

	local players = getElementsByType("player")
	local foundPlayers = {}
	local foundPlayer = false
	
	for index,player in ipairs(players) do
		local playerName = player.name
		if name == playerName then
			return player
		end
		if string.find(string.lower(playerName),string.lower(name)) and foundPlayer == false then
			foundPlayer=player
		end
	end
	
	return foundPlayer

end

local function isPlayerAllowed(player)

	if not player.account then return false end
	if isGuestAccount(player.account) then return false end
	local acc = player.account.name
	for _,group in ipairs(aclAllowed) do
		if isObjectInACLGroup("user."..acc,group) then
			return true
		end
	end
	
	return false

end

local function cenaPlayer(player,cmd,target)

	if aclRestricted and not isPlayerAllowed(player) then return end

	target = getPlayerFromName(target)
	if not target then return end
	
	triggerClientEvent(target,"startCena",target)

end

local function cenaAll(player)

	if aclRestricted and not isPlayerAllowed(player) then return end

	for index,player in ipairs(getElementsByType("player")) do
		triggerClientEvent(player,"startCena",player)
	end

end

local function stopCena(player,cmd,target)

	if aclRestricted and not isPlayerAllowed(player) then return end

	target = getPlayerFromName(target)

	if target then
		triggerClientEvent(target,"stopCena",target)
	else
		for index,player in ipairs(getElementsByType("player")) do
			triggerClientEvent(player,"stopCena",player)
		end
	end

end

local function initScript()

	addCommandHandler("pcena",stopCena,false,false)
	addCommandHandler("cena",cenaPlayer,false,false)
	addCommandHandler("lcena",cenaAll,false,false)

end

addEventHandler("onResourceStart",resourceRoot,initScript)