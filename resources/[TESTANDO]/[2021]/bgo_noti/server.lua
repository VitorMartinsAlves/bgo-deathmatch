
function serverNotification (player, type, message, time, max)
     triggerClientEvent(player, "info:box", resourceRoot, type, message, time, max)
end

function serverNotificationTeclas (player, tecla, message, time)
     triggerClientEvent(player, "info:tecla", resourceRoot, tecla, message, time)
end

function barraProgress (player, time, argument)
     triggerClientEvent(player, "RZK:Progress01", resourceRoot, tonumber(time), argument)
end

function alertNotification (player, text)
     triggerClientEvent(player, "info:alert", resourceRoot, text)
end

function notificationLegend (player, message, states)
     triggerClientEvent(player, "rzk:info:fivem", resourceRoot, message, states)
end