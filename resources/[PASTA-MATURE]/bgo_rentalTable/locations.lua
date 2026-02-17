----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 17 Mar 2014
-- Resource: GTIrentalTable/locations.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

rent_table = {




{
	name="Eletricista\nEmprego\nVeiculos",	pos={1510.7377929688,-1480.3428955078,9.5-1},	colorText={255,200,0},
	restrictions={"Eletrecista"},
	vehicles={
		{552, "Eletrecista"},  -- ID E TABELA DO VEICULO
	},
	spawn_points={
		["Eletrecista"] = {
			{1520.5251464844,-1473.9873046875,9.5156364440918, 273.8623046875},  -- SPAWN DO VEICULO
		},
	},
},


{
	name="Transporte de Gasolina\nEmprego\nVeiculos",	pos={1767.4178466797, -1905.6080322266, 13.567908287048-1},	colorText={255,200,0},
	restrictions={"Transporte de Gasolina"},
	vehicles={
		{403, "Eletrecista"},  -- ID E TABELA DO VEICULO
	},
	spawn_points={
		["Eletrecista"] = {
			{1789.6890869141, -1922.3800048828, 12.835907936096, 357.87954711914},  -- SPAWN DO VEICULO
		},
	},
},





{
	name="Transporte de Valores\nEmprego\nVeiculos",	pos={1522.5024414063,-1020.9153442383,23.87216758728-1},	colorText={255,200,0},
	restrictions={"Transporte de Valores"},
	vehicles={
		{428, "Transporte"},  -- ID E TABELA DO VEICULO
	},
	spawn_points={
		["Transporte"] = {
			{1531.6243896484,-1015.8436889648,24.465869903564},  -- SPAWN DO VEICULO
		},
	},
},





{
	name="Motorista de ônibus\nEmpregos\nVeiculos",	pos={1234.4266357422,-1823.6735839844,12.591278076172},	colorText={255,200,0},
	restrictions={"Motorista"},
	vehicles={
		{431, "ground"},
        --{437, "ground", {"Bus Driver;2"}},
	},
	spawn_points={
		["ground"] = {
		
			{1262.1826171875, -1799.771484375, 13.517366409302, 0},
			{1268.083984375, -1799.7421875, 13.506160736084, 0},
			{1274.4072265625, -1799.689453125, 13.517143249512, 0},
		},
	},
},


{
	name="Motorista Rodoviário\nEmpregos\nVeiculos",	pos={1920.3167724609,703.01715087891,10.1328125},	colorText={255,200,0},
	restrictions={"MotoristaR"},
	vehicles={
		{431, "MotoristaR"},
	},
	spawn_points={
		["MotoristaR"] = {
			{1926.2966308594,690.59637451172,11.393956184387 , 359.32104492188},
		},
	},
},




{
	name="Sedex\nEmprego\nVeiculos",	pos={1665.20703125, -1426.4541015625, 12.679351806641},	colorText={255,200,0},
	restrictions={"Sedex"},
	vehicles={
		--{440, "default"}, -- Boxville
		
		
		{413, "default"}, -- Pony
	},
	spawn_points={
		["default"] = {
			{1651.953125, -1426.431640625, 13.593105316162, 45},
			{1656.7294921875, -1427.212890625, 13.64079284668, 45},
			--{2275.926, -2405.522, 12.547, 45},
		},
	},
},



{
	name="Entregador de Gás\nEmprego\nVeiculos",	pos={2264.9384765625,-1026.8089599609,58.284931182861},	colorText={255,200,0},
	restrictions={"Entregador de Gas"},
	vehicles={
		{478, "default"}, -- Pony
	},
	spawn_points={
		["default"] = {
			{2265.6791992188,-1039.5677490234,51.670875549316, 225.09210205078},

		},
	},
},



-- Pizza Delivery
------------------>>
--[[
{
	name="IFOOD\nEmprego\nVeiculos",	pos={2389.7546386719,2088.5698242188,9.842040061951},	colorText={255,200,0},
	restrictions={"ifood"},
	vehicles={
		{448, "spawn1"}, -- Pizzaboy
	},
	spawn_points={
		["spawn1"] = {
			{2361.943, 2068.59, 10.678, 44},
			{2362.332, 2071.191, 10.677, 46},
			{2361.938, 2074.583, 10.677, 39},
			{2361.914, 2077.619, 10.677, 41},
			{2361.987, 2080.685, 10.677, 40},
			{2362.215, 2065.508, 10.678, 41},
		},
	},
},
]]--


{
	name="IFOOD\nEmprego\nVeiculos",	pos={2389.7546386719,2088.5698242188,9.842040061951},	colorText={255,200,0},
	restrictions={"ifood"},
	vehicles={
		{448, "spawn1"}, -- Pizzaboy
	},
	spawn_points={
		["spawn1"] = {
			{2361.943, 2068.59, 10.678, 44},
			{2362.332, 2071.191, 10.677, 46},
			{2361.938, 2074.583, 10.677, 39},
			{2361.914, 2077.619, 10.677, 41},
			{2361.987, 2080.685, 10.677, 40},
			{2362.215, 2065.508, 10.678, 41},
		},
	},
},


-- Quarry Miner (LV)
----------------------->>


{
	name="Limpador De Rua\nEmprego\nVeiculos",	pos={1769.4847412109,2072.3361816406,9.7203125},	colorText={255,200,0},
	restrictions={"Limpador"},
		-- Vehicles
	vehicles={
		{574, "Vehicle"}, 	-- Streak
	},
	spawn_points={
		["Vehicle"] = { {1756.1700439453,2069.8664550781,10.895574188232, 178.7420501709}, },
	},	
	
},


-- Train Driver
---------------->>

{
	name="Maquinista\nEmprego\nVeiculos",	pos={1706.624, -1939.626, 12.573},	colorText={255,200,0},
	restrictions={"Maquinista"},
		-- Vehicles
	vehicles={
		{538, "trains"}, 	-- Streak
		{537, "trains"}, 	-- Freight
	},
	spawn_points={
		["trains"] = { {1720.710, -1941.678, 12.580}, },
	},
},



-- Trash Collector
------------------->>

{
	name="Lixeiro\nEmprego\nVeiculos",	pos={-1109.665, -1666.303, 76.864-1},	colorText={255, 200, 0},
	restrictions={"Lixeiro"},
		-- Vehicles
	vehicles={
		{408, "spawn1"}, -- Trashmaster
	},
	spawn_points={
		["spawn1"] = {
			{-1104.416, -1623.021, 75.777, 235.4631652832},
		},
	},
},
}

function getRentTable()
	return rent_table
end
