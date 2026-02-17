payammount = 0
Pizzas = 0
local PizzaslocLS = {
    {2019.836, 1007.72, 9.82},
    {2014.058, 774.598, 10.461},
    {2369.11, 734.88, 10.461},
    {2595.835, 1095.737, 9.822},
    {2406.174, 1063.578, 9.82},
    {2440.701, 1220.789, 13.343},
    {2439.388, 1293.36, 10.012},
    {2454.337, 1499.514, 10.595},
    {2183.861, 2295.375, 9.82},
    {2225.044, 2522.876, 10.222},
    {2049.698, 2764.289, 9.82},
    {1313.833, 2610.188, 10.299},
    {1168.633, 1363.139, 9.922},
    {1309.365, 1931.25, 10.461},
    {1678.413, 2690.969, 9.82},
    {1843.995, 718.726, 11.468},
    {2581.261, 1060.548, 10.782},
    {2109.235, 2652.743, 9.813},
    {1671.52, 1814.299, 9.82},
    {2222.982, 2786.208, 9.82},
    {1909.369, 2351.761, 9.98},
    {884.216, 2042.243, 10.461},
    {1643.795, 2753.448, 9.82},
    {2177.037, 925.38, 10.1},
    {1084.506, 1976.741, 10.469},
    {1557.588, 1007.226, 9.813},
    {1223.019, 2616.69, 9.827},
    {1684.263, 2088.869, 10.461},
    {1902.351, 920.583, 9.82},
    {1551.531, 2567.342, 9.82},
    {2810.894, 1987.733, 9.82},
    {2014.113, 650.405, 10.461},
    {1495.693, 2033.238, 13.74},
    {1500.142, 2535.376, 9.82},
    {2533.953, 997.664, 13.272},
}
local PizzaslocSF = {
{-2563.3, 1148.7, 54.7},
{-2506.3999, 1141.7, 54.7},
{-2396.7, 1132.6, 54.7},
{-2451.3, 1141.5, 54.7},
{-2351.8999, 1318, 15.1},
{-2477.2, 1281.5, 22.7},
{-2433.6001, 1338.2, 7.5},
{-2789.2, -181.10001, 8.9},
{-2791.8, -134.3, 9},
{-2791.8, -24.4, 9},
{-2791.2, 126.9, 6.1},
{-2791.8, 218.60001, 6.8},
{-2883.8999, 743.5, 28.1},
{-2864.6001, 681.59998, 22.2},
{-2880.8999, 790.20001, 34.1},
{-2845.1001, 928.40002, 42.9},
{-2900.3999, 1081, 31.1},
{-2285, 849.59998, 64.1},
{-2174.3, 903.70001, 79},
{-2223.8, 744, 48.4},
{-2686.8999, -187.89999, 6.2},
{-2689.3999, -141.10001, 6.2},
{-2688.8, -89.4, 3.2},
{-2662.1001, 877, 78.7},
{-2721.8, 923.90002, 66.6},
{-2710.7, 968.09998, 53.4},
{-2641.1001, 935.70001, 70.9},
{-2321.7, 797.09998, 44.1},
{-2280.8999, 1023, 82.8},
{-2168.3, 1107.5, 79},
{-2112.5, 796.70001, 68.6},
{-2058.8999, 890.79999, 60.8},
{-2621.8999, 782.59998, 43.9},
{-2686.2, 722.79999, 31.1},
{-2687.7, 803.70001, 48.9},
}
local PizzasMarkersLS = {
{2387.781, 2089.563, 9.835},
{2385.584, 2089.572, 9.835},
{2383.778, 2089.383, 9.835},
{2384.162, 2087.894, 9.835},
{2384.152, 2086.027, 9.835},
{2386.794, 2084.992, 9.835},
}
local PizzasMarkersSF = {
{374.174, -114.018, 1000.492},
{376.185, -114.142, 1000.492},
{378.079, -114.234, 1000.492},
}
local ctrls ={
"sprint",
"jump",
"enter_exit",
"enter_passenger",
"fire", 
"crouch", 
"aim_weapon",
"next_weapon",
"previous_weapon",
}
local pizzas = {}
function randomh()
	--if exports.bgo_chat:getPlayerCity(localPlayer) == "LS" then
		return unpack( PizzaslocLS [math.random (#PizzaslocLS)] )
	--elseif exports.bgo_chat:getPlayerCity(localPlayer) == "SF" then
	--	return unpack( PizzaslocSF [math.random (#PizzaslocSF)] )
	--end
end

function randomMarkers()
	--if exports.bgo_chat:getPlayerCity(localPlayer) == "LS" then
		return unpack( PizzasMarkersLS [math.random (#PizzasMarkersLS)] )
	--elseif exports.bgo_chat:getPlayerCity(localPlayer) == "SF" then
	--	return unpack( PizzasMarkersSF [math.random (#PizzasMarkersSF)] )
	--end
end

function onIntchange()
	if (exports.bgo_employment:getPlayerJob(true) == "ifood") then
		local new = getElementInterior(localPlayer)
		if isElement(Pizzabox) then setElementInterior(Pizzabox,new) end
		local newD = getElementDimension(localPlayer)
		if isElement(Pizzabox) then setElementDimension(Pizzabox,newD) end
		for i,v in pairs(pizzas) do
			if isElement(v) then
				setElementInterior(v,new)
				setElementDimension(v,newD) 
			end
		end
	end
end
addEvent("onClientPlayerChangeInterior",true)
addEventHandler("onClientPlayerChangeInterior", root, onIntchange)

addEvent("GTIPizzaDelivery.onPizzaBoyEnter", true)
addEventHandler("GTIPizzaDelivery.onPizzaBoyEnter", root, function()
    if (exports.bgo_employment:getPlayerJob(true) == "ifood") then 
   -- exports.bgo_hud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
        if not isElement(Pizzabox) and not isElement(blip) and not isElement(refblip) then
            if ( Pizzas == 0 ) then
				local rdmX,rdmY,rdmZ = randomMarkers()
				refmarker = createMarker (rdmX, rdmY, rdmZ, "cylinder", 0.8, 255, 25, 0, 170 )
				exports.Script_futeis:setGPS("Coordenada",rdmX,rdmY,rdmZ)
				setElementData(refblip,"blip >> blipOnScreen", true)
				refblip = createBlipAttachedTo(refmarker, 41)
                exports.bgo_hud:dm("Você está sem Pizzas! Vá assar novas Pizzas para continuar.", 255, 0, 0)
				reload = false
            else
                mission()
            end
        end
    end
end )
addEvent("GTIPizzaDelivery.marker", true)
addEventHandler("GTIPizzaDelivery.marker", root, function(theVeh)
    local mx,my,mz = getElementPosition(theVeh)
	veiculo = theVeh
    refillmarker = createMarker(mx, my, mz, "cylinder", 0.8, 255, 25, 0, 170 )
    exports.bgo_util:markPlayer(mx, my, mz)
	exports.Script_futeis:setGPS("Coordenada",mx, my, mz)
    attachElements(refillmarker,theVeh,0,-1.3,-0.5,1,0,0)
end )
					
					
function findRotation(x1,y1,x2,y2)
    local X = math.abs( x2 - x1 )
    local Y = math.abs( y2 - y1 )
    Rotm = math.deg( math.atan2( Y , X ) )
    if ( x2 >= x1 ) and ( y2 > y1 ) then    -- north-east
        Rotm = 90 - Rotm
    elseif ( x2 <= x1 ) and ( y2 > y1 ) then    -- north-west
        Rotm = 270 + Rotm
    elseif ( x2 >= x1 ) and ( y2 <= y1 ) then   -- south-east
        Rotm = 90 + Rotm
    elseif ( x2 < x1 ) and ( y2 <= y1 ) then    -- south-west
        Rotm = 270 - Rotm
    end
    return (630-Rotm)
end

function mission()
    local x1, y1, z1 = randomh()
	if x1 == lastPosx and y1 == lastPosy then
		mission()
	return end
	lastPosx,lastPosy,lastPosz = x1,y1,z1
    marker = createMarker ( x1, y1, z1, "cylinder", 0.9, 255, 255, 50, 170 )
    blip = createBlipAttachedTo(marker, 41)
	exports.Script_futeis:setGPS("Coordenada",x1, y1, z1)
	setElementData(blip,"blip >> blipOnScreen", true)
    loca = getZoneName(x1,y1,z1)
    exports.bgo_hud:dm("Pediram uma pizza em "..loca, 255, 255, 0)
    local d1x, d1y, d1z = getElementPosition ( marker )
    local d2x, d2y, d2z = getElementPosition ( localPlayer )
    local distance = getDistanceBetweenPoints3D(d1x,d1y,d1z,d2x,d2y,d2z)
    payammount = distance
end

function Pizzaexit(thePlayer)
    if ( getElementModel ( source ) == 448 ) and ( thePlayer == localPlayer )and (exports.bgo_employment:getPlayerJob(true) == "ifood") then
        if ( Pizzas > 0 ) then
			local p1x, p1y, p1z = getElementPosition ( marker )
			local p2x, p2y, p2z = getElementPosition ( localPlayer )
			local dist = getDistanceBetweenPoints3D(p1x,p1y,p1z,p2x,p2y,p2z)
			if ( dist < 40 ) then
				triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,true)
				setElementFrozen(localPlayer,true)
				toggleAllControls(false,true,false)
				setTimer( function()
					setElementFrozen(localPlayer,false)
					toggleAllControls(true)
					toggleControl("crouch", false)
					triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,1,2)
					pizza = true
					setPedWeaponSlot(localPlayer,0)
                end, 950, 1 )
        end
        end
end
end
addEventHandler ( "onClientVehicleExit", root, Pizzaexit )


function refill(theElement)
    if ( source == refillmarker ) and ( theElement == localPlayer) and reload then
		destroyElement(refillmarker)
		exports.bgo_hud:drawProgressBar("PizzaPro", "Por favor, espere...", 255, 200, 0, 7500)
		toggleAllControls(false,true,false) 
		pTimer1 = setTimer(refillDone, 7500, 1)
		refTimer1 = setTimer(function()
		
		--destroyPizzas()
			local i = table.maxn(pizzas)
			if isElement(pizzas[i]) then
				destroyElement(pizzas[i])
				--pizzas[i] = nil
				table.remove(pizzas,i)
			end	
			
			
		end,1450,5)
	end
end
addEventHandler ( "onClientMarkerHit", root, refill)
function refillDone()
    Pizzas = 5
    setPedAnimation(localPlayer, "VENDING", "VEND_Use", 7, true, false, false, false)
    toggleAllControls(true)
    exports.bgo_hud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
    exports.bgo_hud:dm("Suas Pizzas foram colocadas em sua Moto Pizza Boy!", 255, 0, 0)
	for i,v in ipairs(ctrls) do
		toggleControl(v, true)
	end
    triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,false)
	reload = false
end
		
		
function getPizzas()
            triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,1)
            local x,y,z = getElementPosition(localPlayer)
			att = 0.39
			for i = 1,5 do 
				local Pizzaboxtemp = createObject(1582, x, y, z)
				setObjectScale(Pizzaboxtemp,0.75)
				local int = getElementInterior(localPlayer)
				local dim = getElementDimension(localPlayer)
				if dim == 134 then
					setElementInterior(Pizzaboxtemp,int)
					setElementDimension(Pizzaboxtemp,dim) 
				end
				attachElements(Pizzaboxtemp,localPlayer,0,0.45,att,1,0,0)
				att = att + 0.06
				setElementCollisionsEnabled(Pizzaboxtemp,false)
				table.insert(pizzas,Pizzaboxtemp)
			end
            exports.bgo_hud:dm("Agora que as suas Pizzas estão assadas, coloque-as na sua Moto Pizza Boy.", 255, 204, 0)
			reload = true
            stopSound(bakingsound)
            triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,true)
            triggerServerEvent("GTIPizzaDelivery.getTheVeh", resourceRoot)
end



		
function destroyPizzas()
			for b = 1,5 do 
			local i = table.maxn(pizzas)
			if isElement(pizzas[i]) then
				destroyElement(pizzas[i])
				table.remove(pizzas,i)
		end	
	end
end

function startprogress(thePlayer)
    if ( source == refmarker ) and ( thePlayer == localPlayer) and not ( isPedInVehicle ( thePlayer ) ) then
		for i,v in ipairs(ctrls) do
			toggleControl(v, false)
		end
		triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,2)
		setPedWeaponSlot(localPlayer,0)
		destroyElement(refmarker)
		destroyElement(refblip)
		bakingsound = playSFX("genrl", 45, 0, true)
		exports.bgo_hud:drawProgressBar("PizzaPro", "Por favor, espere...", 255, 200, 0, 10000)
		pTimer = setTimer(getPizzas, 9900, 1)
    end
end
addEventHandler("onClientMarkerHit",getRootElement(),startprogress)
function pay(thePlayer)
    if ( thePlayer == localPlayer ) and ( source == marker ) and not ( isPedInVehicle ( thePlayer ) ) then
        if (pizza == true) then
			toggleAllControls(false,true,false) 
			destroyElement(marker)
			destroyElement(blip)
			playSound("walking.mp3", false)
			setTimer(function()
				playSFX("spc_fa", 17, math.random(5,11), false)
				Pizzas = Pizzas - 1
				pizza = false
				exports.bgo_hud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
				toggleAllControls(true,true,false) 
                triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,false)
                triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,3,0)
                triggerServerEvent("GTIPizzaDelivery.getpaid", resourceRoot, payammount)
            end, 7500,1 )
        end
    end 
end
addEventHandler ( "onClientMarkerHit", root, pay)

function delelem(thePlayer)
	if (exports.bgo_employment:getPlayerJob(true) == "ifood") then
		payammount = 0
		Pizzas = 0
		pizza = false
		if isElement(marker) then destroyElement(marker) end
		if getPedAnimation(localPlayer) then triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,0,0) end		
		destroyPizzas()
		if isElement(refmarker) then destroyElement(refmarker) end
		if isElement(refillmarker) then destroyElement(refillmarker) end
		if isElement(refblip) then destroyElement(refblip) end
		if isElement(Pizzabox) then destroyElement(Pizzabox) end
		if isElement(blip) then destroyElement(blip) end
		exports.bgo_hud:drawStat("PizzaID", "", "", 255, 200, 0)
		if isTimer(pTimer1) then killTimer(pTimer1) end
		if isTimer(pTimer) then killTimer(pTimer) end
		if isTimer(refTimer1) then killTimer(refTimer1) end
		toggleAllControls(true)
	end
end
addEvent("onClientRentalVehicleHide", true)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)

function onJobQuit(job)
    if ( job == "ifood" ) then 
		Pizzas = 0
		payammount = 0
		if isElement(marker) then destroyElement(marker) end
		if isElement(blip) then destroyElement(blip) end
		if isTimer(pTimer) then killTimer(pTimer) end
		destroyPizzas()
		toggleAllControls(true)
		if getPedAnimation(localPlayer) then triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,0,0) end
		if isTimer(pTimer1) then killTimer(pTimer1) end
		if isTimer(refTimer1) then killTimer(refTimer1) end
		if isElement(Pizzabox) then destroyElement(Pizzabox) end
		if isElement(refillmarker) then destroyElement(refillmarker) end
		if isElement(refmarker) then destroyElement(refmarker) end
		if isElement(refblip) then destroyElement(refblip) end
		exports.bgo_hud:drawStat("PizzaID", "", "", 255, 200, 0)
	end
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler ("onClientPlayerQuitJob", root, onJobQuit)
addEventHandler ("onClientPlayerGetJob", root, onJobQuit)

addEventHandler("onClientPlayerQuit", localPlayer,
	function ()
		destroyPizzas()	
	end
)
