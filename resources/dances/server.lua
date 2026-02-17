 
function setPedFortniteAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
   local theVehicle = getPedOccupiedVehicle ( ped )
   if theVehicle then return end
if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
if isElement(ped) then
if animation == "baile 1" or animation == "baile 2" or animation == "baile 3" or animation == "baile 4" or animation == "baile 5" or animation == "baile 6" or animation == "baile 7" or animation == "baile 8" or animation == "baile 9" or animation == "baile 10" or animation == "baile 11" or animation == "baile 12" or animation == "baile 13" then
for i = 1,3 do
triggerClientEvent ( root, "setPedFortniteAnimation", root, ped,animation,tiempo,repetir,mover,interrumpible )
if tiempo > 1 then
setTimer(setPedAnimation,tiempo,1,ped,false)
setTimer(setPedAnimation,tiempo+100,1,ped,false)
end
end
end
end
 
end
--[[
EJEMPLO/EXAMPLE
CUANDO CAMBIA EL NICK
WHEN NICK IS CHANGED

function wasNickChangedByUser(oldNick, newNick, changedByUser)
setPedFortniteAnimation(source,"baile 8",7000,true,false,false,false)
end
addEventHandler("onPlayerChangeNick", getRootElement(), wasNickChangedByUser) -- add an event handler




--]]

function howtouse ( player, command, dance )
    if dance then 
if isElement(player) then
setPedFortniteAnimation(player,"baile "..dance.."",-1,true,false,false,false)
end
end
end
--addCommandHandler ( "dance", howtouse )