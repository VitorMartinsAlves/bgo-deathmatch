shopPos = {
	-- {SkinID, x, y, z, Név, rot, startCam X, Y, Z, endCam X, Y, Z, false},
	{147, 1600.781, 1691.092, 10.82, 'Carlos', 177.09352111816, 
		-1223.173828125, -5.1005859375, 14.325521469116 -- VehiclePos
	, false},
}

camPos = {}
camPos[1] = {} -- Campos[érték] táblázata
camPos[1]["start"] = {-1226.5197753906, 11.168299674988, 17.33749961853, -1226.3198242188, 10.193261146545, 17.240919113159}
camPos[1]["end"] = {-1239.0024414063, -10.230600357056, 17.15060043335, -1238.0545654297, -9.9235000610352, 17.065223693848}
camPos[1]["speed"] = 5000
camPos[1]["type"] = "Linear"

camPos[2] = {} -- Campos[érték] táblázata
camPos[2]["start"] = {-1223.0478515625, -21.652700424194, 17.897199630737, -1223.0559082031, -20.661233901978, 17.76708984375}
camPos[2]["end"] = {-1207.6373291016, 0.56709998846054, 17.897199630737, -1208.5687255859, 0.22724649310112, 17.76708984375}
camPos[2]["speed"] = 10000
camPos[2]["type"] = "Linear"

camPos[3] = {} -- Campos[érték] táblázata
camPos[3]["start"] = {-1226.5197753906, 11.168299674988, 17.33749961853, -1226.3198242188, 10.193261146545, 17.240919113159}
camPos[3]["end"] = {-1239.0024414063, -10.230600357056, 17.15060043335, -1238.0545654297, -9.9235000610352, 17.065223693848}
camPos[3]["speed"] = 10000
camPos[3]["type"] = "Linear"

camPos[4] = {} -- Campos[érték] táblázata
camPos[4]["start"] = {-1223.0478515625, -21.652700424194, 17.897199630737, -1223.0559082031, -20.661233901978, 17.76708984375}
camPos[4]["end"] = {-1207.6373291016, 0.56709998846054, 17.897199630737, -1208.5687255859, 0.22724649310112, 17.76708984375}
camPos[4]["speed"] = 10000
camPos[4]["type"] = "Linear"

camPos[5] = {} -- Campos[érték] táblázata
camPos[5]["start"] = {-1226.5197753906, 11.168299674988, 17.33749961853, -1226.3198242188, 10.193261146545, 17.240919113159}
camPos[5]["end"] = {-1239.0024414063, -10.230600357056, 17.15060043335, -1238.0545654297, -9.9235000610352, 17.065223693848}
camPos[5]["speed"] = 10000
camPos[5]["type"] = "Linear"


vehicles = {
	--{ID, FT, PP, ÜZEMANYAG, Limit, csak PP [FALSE = nem True = Igen]}
	{487, 2000000000, 250000, 'petrol', 40, true},
	--{469, 2000000000, 160000, 'petrol', 20, true},
}

idg = {
	[487] = 'Helicoptero 4 Lugares',
	[469] = 'Helicoptero 2 Lugares',

}

function getVehicleRealName(thePlayer, _vehID)
	local vehID = tonumber(_vehID)
	if idg[vehID] then
		return idg[vehID]
	end
end

function getVehicleShopCost(vehicleid)
	if idg[vehicleid] then
		for k, v in ipairs(vehicles) do
			if vehicles[k][1] then
				if tonumber(vehicles[k][1]) == tonumber(vehicleid) then 
					return vehicles[k][2]
				end
			else
				return 0
			end
		end
	else 
		return 0
	end 
end