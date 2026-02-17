local colshapeWeapon = {
	-- X, Y, Z, RADIUS, Helyszín, Hova spawnolon x, y, z

	{1555.763, -1675.679, 16.199,2, 'Delegacia', 1549.506, -1675.725, 14.997},

}

for k, v in ipairs(colshapeWeapon) do
	cols = createColSphere(v[1],v[2],v[3],v[4]) 
	cols:setData("isDetector",true)
	cols:setData("isDetectorID", k)
end


addEvent("setPos",true)
addEventHandler("setPos",getRootElement(),function(player, id)
	setElementPosition(player, colshapeWeapon[id][6], colshapeWeapon[id][7], colshapeWeapon[id][8])
	
	triggerClientEvent(root, "playSoundsMetal",root, colshapeWeapon[id][6], colshapeWeapon[id][7], colshapeWeapon[id][8])
	
	
end)

