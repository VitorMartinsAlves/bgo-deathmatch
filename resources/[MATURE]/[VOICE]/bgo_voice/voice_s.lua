--+----------------------------------------------------------------------------------------------------------------------------------------
--|   Script by K "Addlibs" Stasiak, downloaded from MTA community.
--|
--|   Licensed under Creative Commons Attribution 4.0 International Public License
--|   https://creativecommons.org/licenses/by/4.0/
--|
--|   You are free to copy and redistribute the script, to remix, transform, and build upon the script for any purpose, even commercially.
--|   You must give appropriate credit, provide a link to the license, and indicate if changes were made.
--|   You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
--+----------------------------------------------------------------------------------------------------------------------------------------

addEventHandler("onPlayerJoin", root,
    function () -- client has just joined and the proximity voice resource isn't yet running on the client (thus they'd be able to hear everything without limitations on distance)
        setPlayerVoiceIgnoreFrom(source, root)
       -- setPlayerVoiceBroadcastTo(source, nil)
    end
)


addEvent("proximity-voice::broadcastUpdate", true)
addEventHandler("proximity-voice::broadcastUpdate", root,
    function (thePlayer, broadcastList) -- client has streamed in or out another player and the broadcast list has changed
        --if client and source == client then else return end
		if isElement(thePlayer) then
		if getElementData(thePlayer, "inCall") == false then 
        setPlayerVoiceIgnoreFrom(thePlayer, nil)
        setPlayerVoiceBroadcastTo(thePlayer, broadcastList)
		end
		end
    end
)

	addEventHandler ( "onPlayerLogin", root,
		function()
		setPlayerVoiceIgnoreFrom(source, nil)
		setPlayerVoiceBroadcastTo(source, root)
			--setPlayerVoiceBroadcastTo ( source, getElementsByType("player", root, true))

		end
	)

	
	

--[[

	playerChannels = {}
	channels = {}


	addEventHandler ( "onPlayerQuit", root,
		function()
			local previousChannel = playerChannels[source]
			--Remove them from any previous channels
			if tonumber(previousChannel) then
				channels[previousChannel][source] = nil
				--Delete the empty table if he was the last player
				if not next(channels[previousChannel]) then
					channels[previousChannel] = nil
				end
			end
			playerChannels[source] = nil
		end
	)

	function getPlayerChannel ( player )
		if not checkValidPlayer ( player ) then return false end
		return playerChannels[player]
	end

	function setPlayerChannel ( player, id )
		if not checkValidPlayer ( player ) then return false end
		id = tonumber(id)
		if not id then
			return setPlayerDefaultChannel ( player )
		end
		local previousChannel = playerChannels[player]
		--Remove them from any previous channels
		if tonumber(previousChannel) then
			channels[previousChannel][player] = nil
			--Delete the empty table if he was the last player
			if not next(channels[previousChannel]) then
				channels[previousChannel] = nil
			end
		end
		playerChannels[player] = id
		--Insert them into the new channel
		channels[id] = channels[id] or {}
		channels[id][player] = true
		--Update all players in this channel of the new player in this channel
		playersInChannel = getPlayersInChannel ( id )
		for i,v in ipairs(playersInChannel) do
			setPlayerVoiceBroadcastTo ( v, playersInChannel )
		end
		return true
	end

	function getPlayersInChannel ( id )
		if not isElement(id) then
			id = tonumber(id)
			if not id then
				outputDebugString ( "getPlayersInChannel: Bad 'id' argument", 2 )
				return false
			end
		end
		return tableToArray(channels[id] or {})
	end

	function getNextEmptyChannel()
		local emptyChannel = 1
		while channels[emptyChannel] do
			emptyChannel = emptyChannel + 1
		end
		return emptyChannel
	end
	
	

	
	addEventHandler ( "onPlayerLogin", root,
		function()
			setPlayerDefaultChannel ( source )
			setPlayerVoiceIgnoreFrom(source, nil)
		end
	)
	
	addEventHandler ( "onResourceStart", getResourceRootElement(),
		function()
			refreshPlayers()
		end
	)

	function refreshPlayers()
		for i,player in ipairs(getElementsByType"player") do
			if not tonumber(getPlayerChannel ( player )) then --If he's not in a scripted channel
				setPlayerDefaultChannel ( player )
			end
		end
	end
	--setTimer ( refreshPlayers, 5000, 0 )

	function setPlayerDefaultChannel ( player )
			return setPlayerInternalChannel ( player, root )
	end


	function setPlayerInternalChannel ( player, element )
		if playerChannels[player] == element then
			return false
		end
		playerChannels[player] = element
		channels[element] = player
		setPlayerVoiceBroadcastTo ( player, element )
		setPlayerVoiceIgnoreFrom(player, nil)
		return true
	end
	
	--resourceRoot = getResourceRootElement(getThisResource())
	--setElementData ( resourceRoot, "voice_enabled", true ) -- REMOVE IN 1.4


	function tableToArray (tbl)
		local newtable = {}
		for k,v in pairs(tbl) do
			table.insert ( newtable, k )
		end
		return newtable
	end

	function checkValidPlayer ( player )
		if not isElement(player) or getElementType(player) ~= "player" then
			outputDebugString ( "setPlayerVoiceMuted: Bad 'player' argument", 2 )
			return false
		end
		return true
	end

]]--