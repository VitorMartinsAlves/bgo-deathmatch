NPC = {
 {1347.31, 191.29, 18.603, 243.75, 0},
 {1494.8435058594,-1820.4112548828,13.546875, 265.80474853516, 141},
 {-2288.352, -87.877, 34.3, 179.95, 0},
 {2870.2993164063,2473.0034179688,10.066512107849, 225.63233947754, 9}
}

for i,v in pairs(NPC) do
    ped = createPed(v[5], v[1], v[2], v[3])
	setElementRotation(ped, -0, 0, v[4])
	setElementFrozen(ped, true)
	setElementData(ped, "SHOP:Ped", true)
	
    blip = createBlip(v[1], v[2], v[3], 45)
	setElementData(blip, "blipName", "Loja de RoupasF")
	
addEventHandler ( "onClientPedDamage", ped,
     function () 
       cancelEvent()
end)
end