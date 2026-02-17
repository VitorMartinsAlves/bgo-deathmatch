sellVehicle = {
	{500,"Brasilia",15000,5000, 250},
    {496,"Gol-Quadrado",18000,6000, 250},
	{401,"Chevete",20000,8000, 250},
	{436,"GOLF GTI",25000,10000, 150},
	{483,"KOMBI",40000,15000, 100},
	--{550,"Fiat Palio",30000,9000, 400},
	--{540,"Gol G5",25000,15000, 400},
	{562,"Veloster",100000,30000, 50},
	--{600,"Saveiro",35000,20000, 400},
	--{546,"Renault Kwid",40000,25000, 300},
	--{492,"Ford EcoSport",40000,25000, 400},
	--{551,"Chevrolet Onix",45000,30000, 400},
	--{580,"Volkswagen Passat", 45000,30000, 400},
	--{445,"Golf GTi",65000,50000, 250},
	--{579,"Honda HRV",100000,60000, 330},
	{560,"Mercedes",350000,100000, 65},
	{405,"Sonata",380000,100000, 50},
	{466,"Capitiva",400000,100000, 50},
	{418,"Outlander",500000,50000, 250},
	{400,"TORO",400000,40000, 250},
	{482,"SPRINTER",1000000,75000, 20},
	--{402,"W Motors Lykan Hypersport",1500000,100000, 60},
	{468,"Titan",16000,10000, 250},
	{522,"XJ6 660",30000,24000, 200},
	--{581,"CB1000",40000,40000, 450},
	--{461,"Tiger",70000,40000, 350},
	--{586,"Harley Davison", 140000, 70000, 60},
	--{471,"Quadriciclo VIP",10000000000,12000, 200},
	--{505,"Range Rover Evoke VIP",10000000000,29800, 200},
	{603,"Camaro VIP",10000000000,50000, 100},
	{561,"Lamborghini VIP",10000000000, 75000, 100},
	{521,"Kawasaki H2R VIP",10000000000,40000, 100},
	{541,"Ferrari VIP",10000000000,59900, 100},
    {504,"Dodge VIP",10000000000,54900, 100},
	{477,"Audi R8 VIP",10000000000,59900, 100},	
	{438,"BMW X6 VIP",10000000000,49900, 100},
	--{467,"Mitsubishi Lancer Evo X VIP",10000000000,44900, 200},
	--{559,"Bugatti Divo VIP",10000000000,99990, 300},
	{547,"Jeep VIP",10000000000,59990, 100},
	--{558,"Subaru BRZ Drift LIMITADO!!!",10000000000,150000, 40},
}


allVehicleName = {	
	[482] = "SPRINTER",
	[470] = "Dodge Ram",
	[547] = "Jeep VIP",
	[483] = "KOMBI",
	--[550] = "Fiat Palio",
	[521] = "Kawasaki H2R",
	--[558] = "Subaru BRZ Drift",
	--[559] = "Bugatti Divo",
	--[402] = "W Motors Lykan Hypersport",
	[400] = "TORO",
	--[467] = "Mitsubishi Lancer Evo X VIP",
	[438] = "BMW X6 VIP",
	[477] = "Audi R8 VIP",
	[504] = "Dogde VIP",
	[541] = "Ferrari VIP", 
	[500] = "BRASILIA", 
	[436] = "GOLF GTI",
	--[471] = "Quadriciclo VIP", 
	[560] = "Mercedes", 
	--[505] = "Range Rover Evoque VIP", 	
	[603] = "Camaro VIP",
	[461] = "Lamborghini VIP",
	--[468] = "Kawasaki Ninja VIP",
	[562] = "Veloster",
	--[492] = "Ford EcoSport",
	--[579] = "Honda HRV",
	--[551] = "Chevrolet Onix",
	[466] = "Capitiva",
	[405] = "Sonata",
	--[580] = "Volkswagen Passat B8",
	--[546] = "Renault Kwid",
	--[604] = "Lexus LX570",
	--[445] = "Golf GTi",
	[401] = "Chevete",
	[496] = "Gol-Quadrado",
	--[540] = "Gol G5",
	--[600] = "Saveiro",
	--[581] = "CB1000",
	--[586] = "Harley Davison",
	[522] = "XJ6",
	--[461] = "Tiger",
	[468] = "Titan",
	--[456] = "Yankee 60Kilos", 
	--[414] = "Mule 40Kilos",
	--[499] = "Benson 20Kilos",
	--[524] = "Semente 80Kilos",
	--[487] = "Helicoptero",
	[418] = "Outlander",
	--[415] = "Veloster",
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