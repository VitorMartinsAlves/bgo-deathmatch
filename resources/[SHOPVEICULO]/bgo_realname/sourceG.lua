sellVehicle = {
	-- ID, NÉV,Pénz,PP,limit
	
	{500,"Fusca",8000,8000, 55},
	{551,"Fiat Punto",25000,25000, 60},
	{436,"Fiat UNO 2 PORTAS",20000,15000, 60},
	{562,"Chevrolet Agile",40990,40990, 60},
	{492,"Fiesta",52000,52000, 30},
	{561,"Ford Focus",68000,68000, 30},
	{579,"Hyundai Santa Fe",190000,190000, 25},
	{546,"Renault Sandero",40000,40000, 60},
	{445,"Golf GTi",90000,90000, 25},
	{401,"Gol G5",40000,40000, 60},
	{496,"Gol-Quadrado",12000,12000, 60},
	{540,"Gol g4",20000,20000, 60},
	{600,"Saveiro",50000,50000, 30},
	{581,"CB1000",40000,40000, 60},
	{586,"Harley Davison", 140000, 140000, 10},
	{522,"Hornet",25000,25000, 60},
	{461,"Tiger",70000,70000, 60},
	{468,"Xre",16000,16000, 60},
	{560,"Mercedes CLS63",350000,350000, 30},
	{466,"Audi Q7",400000,400000, 25},
	{405,"Audi RS7",380000,380000, 30},
	{580,"Volkswagen Passat B8", 65000,65000, 80},
	{471,"Quadriciclo VIP",10000000000,15000, 15},
	{505,"Range Rover Evoke VIP",10000000000,29800, 17},
	{603,"Camaro SS 2017 VIP",10000000000,50000, 20},
	{411,"Lamborghini Veneno VIP",10000000000, 75000, 20},
	{521,"Kawasaki Ninja VIP",10000000000,35000, 20},


	{499,"Benson 20Kilo",100000,80000, 100},
	{414,"Mule 40Kilo",300000,120000, 100},
	{456,"Yankee 60Kilo",600000,300000, 100},
	{524,"Semente 80Kilo",1000000,500000, 100},
	
}

sellVehicle2 = {
	-- ID, NÉV,Pénz,PP,limit
	
	{500,"Fusca",8000,8000, 200},
	{551,"Fiat Punto",25000,25000, 200},
	{436,"Fiat UNO 2 PORTAS",20000,15000, 200},
	{562,"Chevrolet Agile",40990,40990, 200},
	{492,"Fiesta",52000,52000, 160},
	{561,"Ford Focus",68000,68000, 160},
	{579,"Hyundai Santa Fe",190000,190000, 135},
	{546,"Renault Sandero",40000,40000, 200},
	{445,"Golf GTi",90000,90000, 135},
	{401,"Gol G5",40000,40000, 200},
	{496,"Gol-Quadrado",12000,12000, 200},
	{540,"Gol g4",20000,20000, 200},
	{600,"Saveiro",50000,50000, 140},
	{581,"CB1000",40000,40000, 200},
	{586,"Harley Davison", 140000, 140000, 20},
	{522,"Hornet",25000,25000, 200},
	{461,"Tiger",70000,70000, 200},
	{468,"Xre",16000,16000, 200},
	{580,"Volkswagen Passat B8", 65000,65000, 80},
	{560,"Mercedes CLS63",350000,350000, 200},
	{466,"Audi Q7",400000,400000, 35},
	{405,"Audi RS7",380000,380000, 40},


	{499,"Benson 20Kilo",100000,80000, 100},
	{414,"Mule 40Kilo",300000,120000, 100},
	{456,"Yankee 60Kilo",600000,300000, 100},
	{524,"Semente 80Kilo",1000000,500000, 100},
	
}


allVehicleName = {	
	[436] = "Uno",
	[500] = "Fusca", 
	[471] = "Range Rover Evoke VIP", 
	[560] = "Mercedes CLS63", 
	[505] = "Range Rover Evoke VIP", 	
	[603] = "Camaro SS 2017 VIP",
	[411] = "Lamborghini Veneno VIP",
	[468] = "Kawasaki Ninja VIP",
	[562] = "Chevrolet Agile",
	[492] = "Fiesta",
	[561] = "Ford Focus",
	[579] = "Hyundai Santa Fe",
	[551] = "Fiat Punto",
	[466] = "Audi Q7",
	[405] = "Audi RS7",
	[580] = "Volkswagen Passat B8",
	[546] = "Renault Sandero",
	[445] = "Golf GTi",
	[401] = "Gol G3",
	[496] = "Gol-Quadrado",
	[540] = "Gol g4",
	[600] = "Saveiro",
	[581] = "CB1000",
	[586] = "Harley Davison",
	[522] = "Hornet",
	[461] = "Tiger",
	[468] = "Start",
	[468] = "Xre",
	[415] = "Veloster",

	[456] = "Yankee", 
	[414] = "Mule",
	[499] = "Benson",
	[524] = "Semente",


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


function getVehicleShopCost2(vehicleid)
	if allVehicleName[vehicleid] then
		for k, v in ipairs(sellVehicle2) do
			if sellVehicle2[k][1] == vehicleid then
				local cost = sellVehicle2[k][3]
				return cost
			end
		end
	else 
		return "Desconhecido"
	end 
end