sellVehicle = {
	-- ID, NÉV,Pénz,PP,limit
	

	{499,"Benson 20Kilos",100000,80000, 100},
	{414,"Mule 40Kilos",300000,120000, 100},
	{456,"Yankee 60Kilos",600000,300000, 100},
	{524,"Semente 80Kilos",1000000,500000, 100},
}

allVehicleName = {	
	[456] = "Yankee 60Kilos", 
	[414] = "Mule 40Kilos",
	[499] = "Benson 20Kilos",
	[524] = "Semente 80Kilos"
}







function getVehicleRealName(vehicleid)
	if allVehicleName[vehicleid] then
		return allVehicleName[vehicleid]
	else 
		return "Desconhecido"
	end 
end

function getVehicleShopCost(vehicleid)
	if allVehicleName[vehicleid] then
		for k, v in ipairs(sellVehicle) do
			if sellVehicle[k][1] == vehicleid then
				local cost = sellVehicle[k][3]
				return cost
			end
		end
	else 
		return "Desconhecido"
	end 
end