local animEnable = {}
local syncPlayers = {}

function handleCommand(player,anim)
		if (not animEnable[player]) then
			animEnable[player] = true
			triggerClientEvent(syncPlayers, "anim", player, "cower", true)
		else
			animEnable[player] = false
			triggerClientEvent(syncPlayers, "anim", player, false)
	end
end
addCommandHandler("render",handleCommand)

addEvent("onClientSync", true )
addEventHandler("onClientSync", resourceRoot,
    function()
        table.insert(syncPlayers, client)
		for player, enable in ipairs(animEnable) do
			if (enable) then
				triggerClientEvent(client, "anim", player, "render", true)
			end
		end
    end
)

addEventHandler("onPlayerQuit", root,
    function()
        for i, player in ipairs(syncPlayers) do
            if source == player then 
                table.remove(syncPlayers, i)
                break
            end 
        end
        if (animEnable[source] == true or animEnable[source] == false) then animEnable[source] = nil end
    end
)