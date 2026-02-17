
function radargps(thePlayer, kx,ky,kz)

local x,y,z = getElementPosition(thePlayer)
triggerClientEvent(thePlayer, "radargpsC", thePlayer, x, y, z, kx,ky,kz)

end
addEvent("radargpsS", true)
addEventHandler("radargpsS", root, radargps)

