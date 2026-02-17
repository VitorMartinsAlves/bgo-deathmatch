local Pizzas = {}

	local blip = createBlip (2361.4655761719,2073.990234375,10.671875, 42)
	setElementData(blip,"blipName", "Trabalho de Ifood")
	
	
addEvent("GTIPizzaDelivery.getpaid", true)
addEventHandler("GTIPizzaDelivery.getpaid", root, function(dist_)
	local distance = math.ceil(dist_)
	--[[
	
	local pay = 40 --math.random(50,100)
	--givePlayerMoney(client, pay)
	setElementData(client,"char:money", getElementData(client,"char:money") + pay)
	exports.bgo_hud:dm("Você Ganhou +R$"..pay.." por entregar a pizza", client, 255, 200, 0)

	local ganho = 50 --math.random (20, 135)
	exports.bgo_Level:givePlayerExp(client, ganho )
	]]--
	
	exports.bgo_admin:setPlayerPagamento(client)
	
end)

function PizzaboyEnter ( thePlayer, seat, jacked )
    if isElement(source) and ( getElementModel ( source ) == 448 ) and (exports.bgo_rentals:getPlayerRentalVehicle(thePlayer) == source) and (seat == 0) and (exports.bgo_employment:getPlayerJob(thePlayer,true) == "ifood") then 
       triggerClientEvent ( thePlayer, "GTIPizzaDelivery.onPizzaBoyEnter", resourceRoot )
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), PizzaboyEnter )
addEvent("GTIPizzaDelivery.freeze", true)
addEventHandler("GTIPizzaDelivery.freeze", root, function(fre)
local theveh = exports.bgo_rentals:getPlayerRentalVehicle(client) 
if fre == false then
setElementFrozen(theveh,false)
end
if fre == true then 
setElementFrozen(theveh,true)
end
end )

addEvent("GTIPizzaDelivery.getTheVeh", true)
addEventHandler("GTIPizzaDelivery.getTheVeh", root, function()
local theVeh = exports.bgo_rentals:getPlayerRentalVehicle(client) 
triggerClientEvent ( client, "GTIPizzaDelivery.marker", client, theVeh )
end )
addEvent("GTIPizzaDelivery.anim", true)
addEventHandler("GTIPizzaDelivery.anim", root, function(anim,box)
if box == 0 then
	if isElement(Pizzas[client]) then
	destroyElement(Pizzas[client])
	Pizzas[client] = nil
	end
	
	elseif box == 2 then
	
	if isElement(Pizzas[client]) then
	destroyElement(Pizzas[client])
	Pizzas[client] = nil
	end	
	
	local x,y,z = getElementPosition(client)
	Pizzas[client] = createObject(1582, x, y, z)
	setObjectScale(Pizzas[client],0.75)
	setElementCollisionsEnabled(Pizzas[client],false)
	attachElements(Pizzas[client],client,0,0.45,0.37,1,0,0)
end
if anim == 1 then
    toggleControl(client,"sprint", false)
    toggleControl(client,"jump", false)
    toggleControl(client,"enter_exit", false)
    toggleControl(client,"enter_passenger",false)
    toggleControl(client,"aim_weapon",false)
    toggleControl(client,"fire", false)
    toggleControl(client,"next_weapon", false)
    toggleControl(client,"previous_weapon", false)
    exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, false)
    exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, true)
end
if anim == 2 then 
exports.bgo_anims:setJobAnimation(client, "VENDING", "VEND_Use", 10000, true, false, false, false)
end
if anim == 3 then 
exports.bgo_anims:setJobAnimation(client, "ON_LOOKERS", "wave_loop", 1000, false, false, false, false)
end
end )

addEventHandler("onPlayerQuit", root, function()
	if isElement(Pizzas[source]) then
	destroyElement(Pizzas[source])
	Pizzas[source] = nil
	end	
	
end)

addEvent ("onPlayerQuitJob", true )
addEventHandler ("onPlayerQuitJob", root,
	function ( )
	if isElement(Pizzas[source]) then
	destroyElement(Pizzas[source])
	Pizzas[source] = nil
	end
	
	end
)