addEvent("server->applyTexture", true)
addEventHandler("server->applyTexture", root, function(element, name, texture)
    if element and name and texture then
			local x,y,z = getElementPosition(element)
			local tabela = getElementsWithinRange( x, y, z, 100, "player" )
			local targetPlayer = nil
			for i = 1, #tabela do
			targetPlayer = tabela[i] 
        triggerClientEvent(targetPlayer, "client->applyTexture", targetPlayer, element, name, texture)
		end
    end
end)

addEvent("server->destroyTexture", true)
addEventHandler("server->destroyTexture", root, function(element)
    if element then
	for k,v in ipairs(getElementsByType("player")) do
        triggerClientEvent(v, "destroyTexture", v, element)
		end
    end
end)



function quitPlayer ( quitType )
    if source then
	for k,v in ipairs(getElementsByType("player")) do
        triggerClientEvent(v, "destroyTexture", v, source)
		end
    end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

