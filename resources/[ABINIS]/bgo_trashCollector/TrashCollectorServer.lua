addEvent("GTITrashCollector.marker", true)
addEventHandler("GTITrashCollector.marker", root, function()
local theVeh =  exports.bgo_rentals:getPlayerRentalVehicle(client)
if ( isElement(theVeh) ) and ( getElementModel(theVeh) == 408 ) then
local SX,SY,SZ = getElementPosition(theVeh)
triggerClientEvent ( client, "GTITrashCollector.createmarker", resourceRoot, SX, SY, SZ, theVeh )
end
end )

	local blip = createBlip (-1101.771, -1653.382, 76.864, 42)
	setElementData(blip,"blipName", "Trabalho de Lixeiro")
	
	
addEvent("GTITrashCollector.pay", true)
addEventHandler("GTITrashCollector.pay", root, function()
	--[[
	local pay = 150 --math.random(500,1200)
	setElementData(client,"char:money", getElementData(client,"char:money") + pay)
	exports.bgo_hud:dm("Você Ganhou +R$"..pay.." por entregar os lixos", client, 255, 200, 0)
	local ganho = 100 --math.random (20, 115)
	exports.bgo_Level:givePlayerExp(client, ganho )
	]]--
	exports.bgo_admin:setPlayerPagamento(client)
	
	
	--end
end)

function trashEnter ( thePlayer, seat, jacked )
    if isElement(source) and ( getElementModel ( source ) == 408 ) and (exports.bgo_rentals:getPlayerRentalVehicle(thePlayer) == source) and (seat == 0) and (exports.bgo_employment:getPlayerJob(thePlayer,true) == "Lixeiro") then 
       triggerClientEvent ( thePlayer, "GTITrashCollector.onWasteEnter", resourceRoot )
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), trashEnter )

addEvent("GTITrashCollector.freeze", true)
addEventHandler("GTITrashCollector.freeze", root, function(fre)
    local theveh = exports.bgo_rentals:getPlayerRentalVehicle(client) 
    if fre == false then
        setElementFrozen(theveh,false)
    elseif fre == true then 
        setElementFrozen(theveh,true)
    end
end )
addEvent("GTITrashCollector.anim", true)
addEventHandler("GTITrashCollector.anim", root, function(anim)
if anim == 1 then
    exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, false)
    exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, true)
elseif anim == 2 then 
    exports.bgo_anims:setJobAnimation(client, "CARRY", "liftup", 1000, true, false, false, false)
elseif anim == 3 then 
	exports.bgo_anims:setJobAnimation(client, "GRENADE", "WEAPON_throwu", 500, true, false, false, false)
end
end )