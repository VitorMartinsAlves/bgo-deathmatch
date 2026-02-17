-- // Script Created by Steve Scott // --
-- // Change the MySql datas to your own! // --

local host = "localhost"
local username = "bgo"
local password = "3u29fH0k8fUBwRGh"
local database = "bgo"
local sqlConnection = dbConnect( "mysql", "dbname="..database..";host="..host, username, password, "charset=utf8" )


local ox, oy, oz = 1165.2939453125, -3872.89453125, 1300.72039794922 -- basic position; do not change
local doorObj = {}


-- [ID] = {x,y,z} --
furnitureOffSetTable = {
	-- \\ Bedroom // --
	[1417] = {-0.02, -0.011, 0.269},
	[1740] = {-0.012, -1.166, -0.001},
	[1741] = {-0.512, -1.107, -0.003},
	[1816] = {-0.504, -0.513, -0.006},
	[2025] = {-0.494, -0.005, -0.003},
	[2087] = {-0.532, 0.151, -0.003},
	[2088] = {-0.504, -1.074, -0.005},
	[2089] = {-0.419, 0.123, -0.007},
	[2094] = {-0.509, -1.178, -0.001},
	[2095] = {-0.01, -1.107, -0.001},
	[2200] = {-0.631, 0.162, -0.001},
	[2323] = {-0.497, -1.112, -0.009},
	[2328] = {-0.014, -1.113, -0.003},
	[2329] = {-0.512, -1.091, -0.001},
	[2307] = {-0.509, -1.195, -0.001},
	[2330] = {-0.497, -1.118, -0.009},
	[2576] = {-1.63, -0.089, -0.011},
	[2708] = {-0.715, 0.092, -0.003},
	[1700] = {-0.511, -2.241, -0.004},
	[1701] = {-0.504, -2.248, -0.07},
	[1745] = {-0.507, -2.155, -0.001},
	[1793] = {-0.473, -2.113, -0.007},
	[1794] = {-0.466, -2.317, 0.031},
	[1795] = {-0.484, -2.172, -0.002},
	[1796] = {-0.113, -2.309, -0.013},
	[1797] = {-0.519, -2.2, -0.006},
	[1798] = {-0.503, -2.114, -0.007},
	[1799] = {-0.483, -2.18, 0.063},
	[1800] = {-0.147, -2.287, 0.003},
	[1801] = {-0.499, -2.272, 0.004},
	[1802] = {-0.529, -2.22, -0.012},
	[1803] = {-0.505, -2.238, -0.014},
	[1812] = {0.013, -1.313, -0.005},
	[2090] = {-0.526, -2.239, -0.009},
	[2298] = {-1.327, -2.563, -0.006},
	[2299] = {-0.502, -2.235, -0.006},
	[2300] = {-1.333, -2.863, 0.003},
	[2301] = {-0.49, -2.048, -0.005},
	[2302] = {-0.493, -2.083, -0.007},
	[2331] = {-0.005, -0.004, 0.244},
	[2333] = {-0.515, -1.055, -0.006},
	[2563] = {-1.506, -1.267, -0.006},
	[2564] = {-2.518, -1.25, -0.006},
	[2565] = {-2.501, -1.277, 0.58},
	[2566] = {-1.514, -1.277, 0.58},
	[2575] = {-1.501, -1.289, 0.382},
	[14446] = {-0.011, -0.007, 0.588},
	--[0] = {-0, -0, -0},

	 -- \\ LIVINGR // --
	[2571] = {-1.516, -0.85, -0.002},
	[2357] = {-0.002, 0, 0.395},
	[2290] = {-0.998, -0.011, 0.007},
	[2239] = {-0.013, -0.004, 0},
	[2119] = {-0.507, -0.01, -0.007},
	[2118] = {-0.513, -0.006, -0.008},
	[2117] = {-0.506, -0.005, -0.005},
	[2116] = {-0.514, -0.006, -0.007},
	[2115] = {-0.51, -0.006, 0.001},
	[2109] = {-0.001, -0.006, 0.391},
	[2112] = {-0.003, -0.005, 0.392},
	[2111] = {-0.006, 0, 0.39},
	[2108] = {-0.019, -0.023, 0},
	[1768] = {-1.012, -0.011, 0.002},
	[1766] = {-1.025, -0.009, -0.001},
	[1764] = {-1.013, -0.021, -0.01},
	[1763] = {-0.623, -0.102, 0},
	[1761] = {-1.009, -0.014, -0.002},
	[1760] = {-1.01, -0.011, -0.006},
	[1757] = {-1.01, 0.004, -0.005},
	[1756] = {-0.884, -0.048, -0.004},
	[1753] = {-1.021, -0.004, -0.005},
	[1713] = {-0.821, -0.012, 0},
	[1712] = {-0.729, -0.02, -0.003},
	[1710] = {-1.833, -0.02, -0.003},
	[1709] = {-2.772, -0.523, -0.003},
	[1707] = {-0.792, -0.058, -0.007},
	[1706] = {-0.51, -0.007, -0.002},
	[1703] = {-1.014, -0.02, -0.002},
	[1702] = {-1.0, -0.023, -0.002},
	[1742] = {-0.231, 0.303, -0.005},
	[1743] = {-0.517, -1.082, 0.018},
	[1744] = {-0.477, 0.324, -0.004},
	[1754] = {0.002, 0.002, -0.005},
	[1755] = {-0.513, -0.008, -0.006},
	[1758] = {-0.504, -0.014, -0.004},
	[1759] = {-0.493, -0.099, 0},
	[1762] = {-0.49, -0.001, 0.008},
	[1767] = {-0.523, -0.01, -0.001},
	[1769] = {-0.486, -0.024, 0.001},
	[1814] = {-0.486, -0.511, -0.011},
	[1815] = {-0.519, -0.501, -0.001},
	[1820] = {-0.499, -0.508, -0.007},
	[1822] = {-0.508, -0.523, 0},
	[1823] = {-0.51, -0.506, -0.017},
	[2024] = {-0.509, -0.506, -0.001},
	[2046] = {-0.012, -0.008, 0.531},
	[2078] = {-0.497, 0.119, -0.001},
	[2081] = {-0.509, -0.505, -0.013},
	[2082] = {-0.498, -0.514, -0.011},
	[2083] = {-0.501, -0.502, 0},
	[2084] = {-0.219, 0.14, 0},
	[2161] = {-0.184, 0.224, -0.005},
	[2162] = {-0.402, 0.179, -0.004},
	[2163] = {-0.403, 0.225, -0.005},
	[2164] = {-0.399, 0.22, -0.007},
	[2167] = {0.027, 0.225, -0.005},
	[2191] = {-0.245, -0.206, -0.002},
	[2199] = {-0.208, 0.201, -0.003},
	[2200] = {-0.631, 0.162, -0.001},
	[2204] = {-0.987, 0.205, -0.008},
	[2234] = {-0.508, -0.516, -0.006},
	[2235] = {-0.514, -0.505, -0.008},
	[2291] = {-0.499, -0.013, -0.001},
	[2292] = {-0.003, -0.005, -0.001},
	[2295] = {-0.003, -0.005, -0.006},
	[2462] = {0.117, 0.192, -0.002},
	[1663] = {-0.01, -0.016, 0.46},
	[1671] = {-0.011, -0.016, 0.46},
	[1704] = {-0.459, -0.01, -0.003},
	[1705] = {-0.503, -0.013, -0.002},
	[1708] = {-0.494, -0.01, 0},
	[1711] = {-0.179, -0.017, -0.003},
	[1726] = {-1.005, -0.019, -0.008},
	[1735] = {-0.016, 0.009, -0.002},
	[1806] = {-0.005, -0.14, 0.02},
	[1811] = {-0.009, -0.005, 0.626},
	[1998] = {-0.515, -0.504, 0},
	[1999] = {-0.503, -0.05, 0},
	[2096] = {-0.002, -0.094, -0.001},
	[2173] = {-0.509, -0.072, 0},
	[2180] = {-0.488, 0.05, -0.002},
	[2184] = {-1.043, -0.341, -0.004},
	[2206] = {-0.935, -0.015, -0.008},
	[2311] = {-0.759, -0.007, -0.008},
	[2313] = {-0.692, -0.006, -0.003},
	[2314] = {-0.767, -0.019, -0.003},
	[2315] = {-0.748, -0.011, -0.002},
	[2319] = {-0.776, -0.01, 0.002},
	[2321] = {-0.768, -0.014, -0.001},
	[2346] = {-0.504, -0.047, -0.001},
	[2370] = {-0.322, -0.36, -0.005},
	[11665] = {-0.001, -0.004, 0.699},
	[2699] = {-0.002, -0.008, 0.624},
	[1235] = {0, -0.022, 0.503},
--	[0] = {-0, -0, -0},

	-- \\ BATHROOM // --
	[2516] = {-0.645, -0.008, 0},
	[2517] = {-0.085, -0.944, -0.008},
	[2518] = {-0.514, -0.278, -0.412},
	[2519] = {-0.645, -0.008, 0},
	[2520] = {-0.085, -0.955, -0.008},
	[2521] = {-0.011, -0.178, -0.007},
	[2522] = {-0.661, -0.008, 0},
	[2523] = {-0.508, -0.229, 0},
	[2524] = {-0.494, -0.305, 0},
	[2525] = {-0.012, -0.186, 0},
	[2526] = {-0.629, -0.017, 0.001},
	[2527] = {-0.071, -0.947, -0.008},
	[2528] = {-0.006, -0.07, 0},
	[1778] = {0.065, 0.237, -0.002},

	-- \\ Kitchen // --
	[2109] = {-0.001, -0.006, 0.391},
	[2111] = {-0.006, 0, 0.39},
	[2112] = {-0.003, -0.005, 0.392},
	[2031] = {-0.51, -0.007, -0.002},
	[2030] = {-0.005, -0.003, 0.399},
	[2029] = {-0.514, -0.005, 0.005},
	[1770] = {-0.511, -0.004, -0.001 },
	[936] = {-0.011, -0.02, 0.475},
	[937] = {-0.01, -0.018, 0.475},
	[941] = {-0.254, -0.018, 0.475},
	[1821] = {-0.496, -0.508, -0.006},
	[2014] = {-0.001, -0.003, -0.15},
	[2015] = {0, -0.003, 0},
	[2016] = {0, -0.003, 0},
	[2018] = {0, -0.003, 0},
	[2019] = {0, -0.003, 0},
	[2020] = {-0.501, -0.743, -0.003},
	[2021] = {-0.003, -1.246, 0},
	[2128] = {-0.007, -0.125, -0.001},
	[2129] = {-0.003, -0.125, -1.659},
	[2133] = {-0.014, -0.107, -0.001},
	[2134] = {-0.007, -0.099, -0.001},
	[2137] = {-0.016, -0.15, -0.001},
	[2138] = {-0.007, -0.15, -0.001},
	[2139] = {-0.014, -0.157, -0.009},
	[2140] = {-0.021, -0.155, 0.01},
	[2141] = {-0.007, -0.099, 0.013},
	[2142] = {-0.194, 0.124, -0.001},
	[2143] = {-0.267, 0.124, -0.001},
	[2145] = {0.139, 0.124, -0.001},
	[2151] = {-0.197, 0.129, -0.001},
	[2152] = {-0.194, 0.129, -0.001},
	[2153] = {0.137, 0.129, -0.001},
	[2154] = {-0.194, 0.129, -0.001},
	[2155] = {0.082, 0.129, -0.001},
	[2156] = {-0.194, 0.134, -0.001},
	[2157] = {-0.194, 0.134, -0.001},
	[2158] = {-0.009, -0.155, -0.002},
	[2159] = {-0.194, 0.134, -0.001},
	[2160] = {-0.192, 0.134, -0.001},
	[2303] = {-0.021, -0.141, -0.001},
	--2304
	[2305] = {-0.014, -0.013, -0.001},
	[2334] = {-0.008, -0.16, 0.006},
	[2335] = {-0.009, -0.16, -0.009},
	[2338] = {0, 0, -0.009},
	[2341] = {-0.01, -0.004, -0.001},
	[1432] = {-0.023, -0.218, 0.132},
	[1433] = {-0.015, -0.003, 0.18},
	[1594] = {0, -0.005, 0.477},
	[1720] = {-0.01, -0.177, -0.001},
	[1721] = {-0.017, -0.155, 0.013},
	[1805] = {-0.005, -0.009, 0.249},
	[1810] = {0.235, -0.201, -0.001},
	[2636] = {-0.018, -0.027, 0.636},
	[2120] = {-0.016, -0.008, 0.638},
	[2121] = {-0.009, -0.008, 0.513},
	[2124] = {-0.005, -0.001, 0.831},
	[2125] = {-0.015, -0.008, 0.31},
	[2079] = {-0.007, -0.007, 0.636},
	[2637] = {-0.013, -0.021, 0.405},
	[2644] = {-0.024, -0.018, 0.405},
	[2762] = {-0.018, -0.021, 0.405},
	[2763] = {-0.02, -0.025, 0.405},
	[2764] = {-0.024, -0.02, 0.405},
	[2788] = {-0.002, -0.004, 0.53},
	[2802] = {-0.089, -0.011, 0.33},
	[15036] = {-0.007, -0.001, 1.147},
	[2294] = {-0.004, -0.12, -0.001},
	[2336] = {-0.508, -0.152, -0.005},
	[2337] = {-0.014, -0.135, -0.009},
	[2339] = {-0.007, -0.099, -0.001},
	[2340] = {0.001, -0.099, -0.001},
	[2127] = {-0.503, -0.123, -0.001},
	[2131] = {-0.514, -0.099, -0.006},
	[2132] = {-0.507, -0.107, -0.001},
	[2135] = {-0.012, -0.141, -0.001},
	[2136] = {-0.516, -0.142, 0.001},
	[2147] = {-0.008, -0.09, -0.006},

	-- \\ Electronics // --
	[1429] = {-0.013, -0.015, 0.253},
	[1747] = {0.195, 0.255, -0.007},
	[1748] = {0.172, 0.314, -0.001},
	[1749] = {0.195, 0.178, -0.005},
	[1750] = {0.142, 0.281, -0.008},
	[1751] = {0.134, 0.277, 0},
	[1752] = {0.061, 0.209, -0.008},
	[1781] = {0.148, 0.305, -0.005},
	[1791] = {0.093, 0.191, 0.001},
	[1792] = {-0.092, 0.262, -0.001},
	[2296] = {-0.996, 0.096, -0.002},
	[2297] = {-0.508, -0.516, -0.006},
	[14532] = {-0.005, 0.003, 0.983},
	[1719] = {-0.009, -0.014, 0.054},
	[2028] = {-0.003, -0.016, 0.083},
	[2421] = {0.148, 0.209, 0.005},
	[2149] = {-0.017, -0.017, 0.151},
	[2229] = {0.308, 0.242, 0},
	[2230] = {0.304, 0.264, 0},
	[2231] = {0.247, 0.264, 0},
	[2232] = {-0.009, -0.005, 0.598},
	[2233] = {0.372, 0.374, -0.001},
	[2099] = {-0.128, 0.245, -0.002},
	[2100] = {-0.233, 0.193, -0.001},
	[2101] = {0, -0.011, 0.003},
	[2225] = {0.148, 0.276, 0},
	[2226] = {-0.01, -0.007, -0.002},
	[2227] = {0.27, 0.357, -0.001},
	[1782] = {-0.003, -0.012, 0.083},
	[1783] = {-0.007, -0.018, 0.071},
	[1785] = {-0.009, -0.012, 0.101},
	[1787] = {-0.003, -0.013, 0.071},
	[1790] = {-0.007, -0.012, 0.07},

	-- \\ Decorations // --
	[2724] = {-0.002, -0.01, 0.547},
	[2725] = {-0.007, -0.01, 0.433},
	[3383] = {-0.006, -0.006, 0},
	[16151] = {0.513, -0.267, 0.392},
	[2224] = {-0.177, -0.885, -0.004},
	[2452] = {-0.301, 0.059, -0.007},
	[2627] = {-0.009, 0, -0.001},
	[2630] = {-0.008, -0.013, -0.005},
	[2628] = {-0.01, -0.006, -0.006},
	[2629] = {-0.012, -0.013, 0.002},
	[2915] = {0.216, -0.005, 0.121},
	[2916] = {-0.014, -0.003, 0.117},
	[1585] = {-0.068, 0.047, -0.004},
	--[1584] = {-0, -0, -0},
	[1583] = {-0.068, 0.039, -0.002},
	[2484] = {-0.005, -0.011, 0.834},
	[2491] = {0.244, 0.238, -0.006},
	[2489] = {-0.006, -0.009, 0.132},
	[2490] = {-0.006, -0.009, 0.132},
	[2500] = {0.214, 0.188, -0.003},
	[2581] = {-0.017, -0.02, 1.152},
	[2584] = {-0.015, -0.021, 0.821},
	[1775] = {-0.014, -0.026, 1.097},
	[1776] = {-0.008, -0.011, 1.099},
	[2743] = {0, -0.002, 1.349},
	[1369] = {-0.009, -0.013, 0.622},
	[3065] = {-0.016, -0.014, 0.135},
	[1985] = {-0.002, -0.003, 2.429},
	[3461] = {-0.003, -0.005, 1.575},
	[3534] = {-0.008, -0.009, 1.301},
	[3385] = {-0.005, -0.007, 0},
	[2238] = {-0.003, -0.007, 0.408},
	[1829] = {-0.002, -0.008, 0.465},
	[2778] = {-0.024, -0.02, -0.007},
	[2779] = {-0.023, -0.02, -0.007},
	[2872] = {-0.026, -0.014, -0.007},
	[630] = {-0.002, -0.003, 1.025},
	[631] = {-0.004, -0.004, 0.9},
	[632] = {0.972, -0.026, 0.447},
	[633] = {-0.005, -0.006, 0.994},
	[638] = {-0.017, -0.043, 0.697},
	[646] = {-0.007, -0.001, 1.417},
	[948] = {-0.007, -0.018, -0.001},
	[949] = {-0.016, -0.021, 0.636},
	[950] = {-0.033, -0.044, 0.543},
	[1361] = {-0.007, -0.004, 0.743},
	[2001] = {-0.001, -0.005, 0},
	[2010] = {-0, -0.004, 0.903},
	[2011] = {-0.003, -0.006, 1.0},
	[2194] = {-0.004, -0.007, 0.331},
	[2195] = {-0.01, -0.004, 0.617},
	[2240] = {-0.009, -0.005, 0.598},
	[2241] = {-0.005, -0.004, 0.504},
	[2244] = {-0.006, -0.004, 0.276},
	[2251] = {-0.008, -0.007, 0.843},
	[2252] = {-0.026, 0.006, 0.322},
	[2253] = {-0.01, -0, 0.28},
	[2811] = {-0.01, -0.005, 0},
	[14834] = {-0.076, -0.11, 0.294},
}


addCommandHandler("addcustominterior",
	function(playerSource, commandName, size, cost, intname)
		if getElementData(playerSource, "acc:admin") >= 8 then
			if tonumber(size) and tonumber(cost) then
				name = intname
				x,y,z = getElementPosition(playerSource)
				local ix = 0
				local iy = 0
				local iz = 0
				local marker_int = getElementInterior(playerSource)
				local marker_dim = getElementDimension(playerSource)
        -- default interior creation
				local query = dbQuery(sqlConnection, "INSERT INTO interiors SET x = ?, y = ?, z = ?, interiorx = ?, interiory = ?, interiorz = ?, name = ?, type = ?, cost = ?, interior = ?, interiorwithin = ?, dimensionwithin = ?, customint = ?, size = ?,owner = ?",x, y, z, ix, iy, iz, name, 0, cost, 0, marker_int, marker_dim, 1, tonumber(size),0)
				local inserted, _, insertid = dbPoll(query, -1)
				if inserted then
          generateHouse(insertid, size, true)
				end
				outputChatBox("#99cc99[BGOMTA - Custom-Interior]:#ffffff Interior created, ID: #33ccff"..insertid, playerSource,124, 197, 118,true)
			else
				outputChatBox("#99cc99[BGOMTA - Custom-Interior]:#ffffff /" .. commandName .. " [Size] [Price] [Name]", playerSource,124, 197, 118,true)
			end
		end
	end
)


local doorX, doorY, doorZ, doorRot = 0,0,0, 0
local saveWallTable = {}
local saveFloorTable = {}
local saveRoofTable = {}
local floorTable = {}
local roofTable = {}
local wallTable = {}
local createdWallObjects = {}
local createdWallObjects2 = {}
local furnitureTable = {}
local innerDoorTable = {}

local wallTextureTable = false
local sqlInsideWalls = false
local sqlInsideWalls2 = false
function generateHouse(dbID, size, firstGenerated, textureTable, insideWallObjects, insideWallObjects2, furnitures, floorTextures, ceilTextures, innerWallTextures, inWallTexture2, doorObjects, doorTextures, headDoorTable)
  -- FLOORS --
  local wallLength = 3.21
  local wallLength2 = .17
  local ox, oy, oz = 1165.2939453125, -3872.89453125, 1300.72039794922

	floorTable[dbID] = {}
  local row, column = tonumber(size), tonumber(size)
  local total = row*column

  local actColumn = 0
  local counter = 0

  for i = 1, total do
  	counter = counter + 1
  	floorTable[dbID][i] = createObject(7429, ox+counter*3.21, oy+actColumn*3.21, oz)
    setElementDimension(floorTable[dbID][i], dbID)
  	setElementRotation(floorTable[dbID][i], 0, 90,0)
  	if counter == row then
  		counter = 0
  		actColumn = actColumn + 1
  	end
  end

  -- ROOF --
  local actColumn = 0
  local counter = 0
  roofTable[dbID] = {}
  for i = 1, total do
  	counter = counter + 1
  	roofTable[dbID][i] = createObject(7429, ox+counter*3.21, oy+actColumn*3.21, oz+wallLength+wallLength2)
    setElementDimension(roofTable[dbID][i], dbID)
  	setElementRotation(roofTable[dbID][i], 0, 90,0)
  	if counter == row then
  		counter = 0
  		actColumn = actColumn + 1
  	end
  end

  -- WALLS --
  local row, column = tonumber(size), tonumber(size)
  local total = tonumber(size)*4
  local actColumn = 0
  local counter = 0
  local wallObjID = 3269
	wallTable[dbID] = {}
	createdWallObjects[dbID] = {}
	createdWallObjects2[dbID] = {}
	doorObj[dbID] = {}
	furnitureTable[dbID] = {}
	innerDoorTable[dbID] = {}

  for i = 1, total do
  	if i > total/2 then
  		--counter = counter + 1
  		if actColumn ~= row then
  			actColumn = actColumn +1
  		end
			if not headDoorTable then
	  		if i == total then
	  			wallObjID = 8859
	  		end
			else
				if i == headDoorTable[1] then
	  			wallObjID = 8859
				else
					wallObjID = 3269
	  		end
			end
  		wallTable[dbID][i] = createObject(wallObjID, ox+wallLength+(actColumn-1)*wallLength, oy-wallLength/2-wallLength2+(counter)*wallLength+wallLength2, oz+1.66)
      setElementDimension(wallTable[dbID][i], dbID)

			if not headDoorTable then
				if i == total then
					doorObj[dbID] = createObject(1494, 0,0,0)
					setElementDimension(doorObj[dbID], dbID)
					attachElements(doorObj[dbID], wallTable[dbID][i],0,-0.74,-1.75,0,0,90)
					doorX, doorY, doorZ = getElementPosition(wallTable[dbID][i])
					_,_,doorRot = getElementRotation(wallTable[dbID][i])
				end
			else
				if i == headDoorTable[1] then
					doorObj[dbID] = createObject(1494, 0,0,0)
					setElementDimension(doorObj[dbID], dbID)
					attachElements(doorObj[dbID], wallTable[dbID][headDoorTable[1]],0,-0.74,-1.75,0,0,90)
					doorX, doorY, doorZ = getElementPosition(wallTable[dbID][headDoorTable[1]])
					_,_,doorRot = getElementRotation(wallTable[dbID][headDoorTable[1]])
				end
			end

  		if i > total/2+total/4 then
  			setElementRotation(wallTable[dbID][i], 0,0,-90)
  		else
  			setElementRotation(wallTable[dbID][i], 0,0,90)
  		end
  		if actColumn == row then
  			actColumn = 0
  			counter = row
  		end
  	else
  		counter = counter + 1
      if i <= total/4 then
  			lastWallOffSet = 0
  		else
  			lastWallOffSet = -wallLength2/2*row+wallLength2/2
  		end
			if headDoorTable then
				if i == headDoorTable[1] then
	  			wallObjID = 8859
				else
					wallObjID = 3269
	  		end
			end
      wallTable[dbID][i] = createObject(wallObjID, ox+wallLength/2-wallLength2/2+actColumn*(wallLength+(wallLength2/2))+lastWallOffSet, oy+(counter-1)*wallLength, oz+1.66)
      setElementDimension(wallTable[dbID][i], dbID)
			if headDoorTable then
				if i == headDoorTable[1] then
					doorObj[dbID] = createObject(1494, 0,0,0)
					setElementDimension(doorObj[dbID], dbID)
					attachElements(doorObj[dbID], wallTable[dbID][headDoorTable[1]],0,-0.74,-1.75,0,0,90)
					doorX, doorY, doorZ = getElementPosition(wallTable[dbID][headDoorTable[1]])
					_,_,doorRot = getElementRotation(wallTable[dbID][headDoorTable[1]])
				end
			end
  		if counter == row then
  			counter = 0
  			actColumn = column
  		end
  		if i == total/2 then
  			counter = 0
  			actColumn = 0
  		end
  	end
  end

	if firstGenerated then
	  dbExec(sqlConnection, "INSERT INTO custominteriors SET realInteriorIndex= ?, size = ?, texturechanger =?, ceilTexture =?",dbID, tonumber(size), "[ [ false ] ]", "[ [ false ] ]")
	  local interiorEntranceX, interiorEntranceY, interiorEntranceZ = getPositionInfrontOfElement(doorX, doorY, oz+1.2, doorRot, -1)
	  dbExec(sqlConnection, "UPDATE interiors SET interiorx = ?, interiory = ?, interiorz = ? WHERE id = ?",interiorEntranceX, interiorEntranceY, interiorEntranceZ, dbID)
	  exports.bgo_interiors:loadOneInteriorWhereID(dbID)
	else
		if insideWallObjects then
			for k, v in pairs(insideWallObjects) do
				createdWallObjects[dbID][k] = createObject(v[2],v[3],v[4],v[5],v[6],v[7],v[8])
				setElementDimension(createdWallObjects[dbID][k], dbID)
			end
		end
		if insideWallObjects2 then
			for k, v in pairs(insideWallObjects2) do
				createdWallObjects2[dbID][k] = createObject(v[2],v[3],v[4],v[5],v[6],v[7],v[8])
				setElementDimension(createdWallObjects2[dbID][k], dbID)
			end
		end
		if doorObjects then
			for k, v in pairs(createdWallObjects[dbID]) do
				if doorObjects[k] then
					for doorK, doorV in pairs(doorObjects) do
						if doorV.index1 then
								innerDoorTable[dbID][doorK] = createObject(doorV.index1[2],doorV.index1[3],doorV.index1[4],doorV.index1[5],doorV.index1[6],doorV.index1[7],doorV.index1[8])
								setElementDimension(innerDoorTable[dbID][doorK], dbID)
						end
					end
				end
			end
			for k, v in pairs(createdWallObjects2[dbID]) do
				if doorObjects[k] then
					for doorK, doorV in pairs(doorObjects) do
						if doorV.index2 then
						--	if doorV.index2[1] == k then
								innerDoorTable[dbID][doorK] = createObject(doorV.index2[2],doorV.index2[3],doorV.index2[4],doorV.index2[5],doorV.index2[6],doorV.index2[7],doorV.index2[8])
								setElementDimension(innerDoorTable[dbID][doorK], dbID)
						--	end
						end
					end
				end
			end
		end
		if furnitures then
			for k, v in pairs(furnitures) do
				local furnOffSetX, furnOffSetY, furnOffSetZ = 0,0,0
				local r = 0
				local xOffset = 0
				local yOffset = 0
			--	if v[5] == 0 then
					if furnitureOffSetTable[v[1]] then
						furnOffSetX, furnOffSetY, furnOffSetZ = furnitureOffSetTable[v[1]][1], furnitureOffSetTable[v[1]][2], furnitureOffSetTable[v[1]][3]
						if v[5] > 0 then
						 	r = -v[5]*math.pi/180
							xOffset = math.cos(r)*furnOffSetX+math.sin(r)*furnOffSetY
							yOffset = -math.sin(r)*furnOffSetX+math.cos(r)*furnOffSetY
						else
							xOffset = furnOffSetX
							yOffset = furnOffSetY
						end
					end
			--	else

			--	end
				furnitureTable[dbID][k] = createObject(v[1],v[2]+xOffset,v[3]+yOffset,v[4]+furnOffSetZ,0,0,v[5])
				setElementDimension(furnitureTable[dbID][k], dbID)
			--	if furnitureOffSetTable[v[1]] then
					--setElementPosition(furnitureTable[dbID][k], v[2]+furnitureOffSetTable[v[1]][1], v[3]+furnitureOffSetTable[v[1]][2], v[4]+furnitureOffSetTable[v[1]][3])
			--	end
			end
		end
	end
end
addEvent("createHouseObjects", true)
addEventHandler("createHouseObjects",getRootElement(), generateHouse)

function regenerateHouseServer(dbid, size, textureTable, insideWallObjects, insideWallObjects2, furnitures, floorTextures, ceilTextures, innerWallTexture, innerWallTexture2, doorElements, doorTextures, headDoorThings)
	for k, v in pairs(wallTable[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	--wallTable[dbid] = {}
	for k, v in pairs(createdWallObjects[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	--createdWallObjects[dbid] = {}
	for k, v in pairs(createdWallObjects2[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	for k, v in pairs(furnitureTable[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	for k, v in pairs(floorTable[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	for k, v in pairs(roofTable[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	for k, v in pairs(innerDoorTable[dbid]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	--createdWallObjects2[dbid] = {}
	if isElement(doorObj[dbid]) then
		destroyElement(doorObj[dbid])
	end
	--generateHouse(dbid, size, false, textureTable, insideWallObjects, insideWallObjects2, furnitures, floorTextures, ceilTextures, innerWallTexture, innerWallTexture2, doorElements, doorTextures, headDoorThings)

	-- // has to be imported from SQL
	local loadCount = 0
	local sqlQuery = dbPoll(dbQuery(sqlConnection,"SELECT * FROM custominteriors WHERE realInteriorIndex = ?", dbid), -1)
	if (sqlQuery) then
		for k, v in ipairs(sqlQuery) do
			if (v["walltexturechanger"]) ~= "[ [ false ] ]" then
				wallTextureTable = fromJSON(v["walltexturechanger"])
			else
				wallTextureTable = false
			end
			if (v["createdWallObjects"]) ~= "[ [ false ] ]" then
				sqlInsideWalls = fromJSON(v["createdWallObjects"])
			else
				sqlInsideWalls = false
			end

			if (v["createdWallObjects2"]) ~= "[ [ false ] ]" then
				sqlInsideWalls2 = fromJSON(v["createdWallObjects2"])
			else
				sqlInsideWalls2 = false
			end

			if v["furnitures"] ~= "[ [ false ] ]" then
				furnitureObjects = fromJSON(v["furnitures"])
			else
				furnitureObjects = false
			end

			if v["texturechanger"] ~= "[ [ false ] ]" then
				floorTextures = fromJSON(v["texturechanger"])
			else
				floorTextures = false
			end

			if v["ceilTexture"] and v["ceilTexture"] ~= "[ [ false ] ]" then
				ceilTextures = fromJSON(v["ceilTexture"])
			else
				ceilTextures = false
			end

			if v["innerwalltexturechanger"] and v["innerwalltexturechanger"] ~= "[ [ false ] ]" and v["innerwalltexturechanger"] ~= "[[]]" then
				generateInnerWallTexture = fromJSON(v["innerwalltexturechanger"])
			else
				generateInnerWallTexture = false
			end
			if v["innerwalltexturechanger2"] and v["innerwalltexturechanger2"] ~= "[ [ false ] ]" and v["innerwalltexturechanger2"] ~= "[[]]" then
				generateInnerWallTexture2 = fromJSON(v["innerwalltexturechanger2"])
			else
				generateInnerWallTexture2 = false
			end

			if v["doorObjects"] and v["doorObjects"] ~= "[ [ false ] ]" and v["doorObjects"] ~= "[[]]" then
				generateDoorObjects = fromJSON(v["doorObjects"])
			else
				generateDoorObjects = false
			end

			if v["doorTextures"] and v["doorTextures"] ~= "[ [ false ] ]" and v["doorTextures"] ~= "[[]]" then
				doorTextures = fromJSON(v["doorTextures"])
			else
				doorTextures = false
			end

			if v["headDoorTable"] and v["headDoorTable"] ~= "[ [ false ] ]" and v["headDoorTable"] ~= "[ [ ] ]" and v["headDoorTable"] ~= "[[]]" then
				genHeadDoorTable = fromJSON(v["headDoorTable"])
			else
				genHeadDoorTable = false
			end
			generateHouse(v["realInteriorIndex"], v["size"], false, wallTextureTable, sqlInsideWalls, sqlInsideWalls2, furnitureObjects, floorTextures, ceilTextures, generateInnerWallTexture, generateInnerWallTexture2, generateDoorObjects, doorTextures, genHeadDoorTable)
		end
	end
end
addEvent("regenerateHouseServer", true)
addEventHandler("regenerateHouseServer",getRootElement(), regenerateHouseServer)


addEventHandler("onResourceStart",resourceRoot,function()
	local loadCount = 0
	local sqlQuery = dbPoll(dbQuery(sqlConnection,"SELECT * FROM custominteriors"),-1)
	if (sqlQuery) then
		for k, v in ipairs(sqlQuery) do
			if (v["walltexturechanger"]) ~= "[ [ false ] ]" then
				wallTextureTable = fromJSON(v["walltexturechanger"])
			else
				wallTextureTable = false
			end
			if (v["createdWallObjects"]) ~= "[ [ false ] ]" then
				sqlInsideWalls = fromJSON(v["createdWallObjects"])
			else
				sqlInsideWalls = false
			end

			if (v["createdWallObjects2"]) ~= "[ [ false ] ]" then
				sqlInsideWalls2 = fromJSON(v["createdWallObjects2"])
			else
				sqlInsideWalls2 = false
			end

			if v["furnitures"] ~= "[ [ false ] ]" then
				furnitureObjects = fromJSON(v["furnitures"])
			else
				furnitureObjects = false
			end

			if v["texturechanger"] ~= "[ [ false ] ]" then
				floorTextures = fromJSON(v["texturechanger"])
			else
				floorTextures = false
			end

			if v["ceilTexture"] and v["ceilTexture"] ~= "[ [ false ] ]" then
				ceilTextures = fromJSON(v["ceilTexture"])
			else
				ceilTextures = false
			end

			if v["innerwalltexturechanger"] and v["innerwalltexturechanger"] ~= "[ [ false ] ]" and v["innerwalltexturechanger"] ~= "[[]]" then
				generateInnerWallTexture = fromJSON(v["innerwalltexturechanger"])
			else
				generateInnerWallTexture = false
			end
			if v["innerwalltexturechanger2"] and v["innerwalltexturechanger2"] ~= "[ [ false ] ]" and v["innerwalltexturechanger2"] ~= "[[]]" then
				generateInnerWallTexture2 = fromJSON(v["innerwalltexturechanger2"])
			else
				generateInnerWallTexture2 = false
			end

			if v["doorObjects"] and v["doorObjects"] ~= "[ [ false ] ]" and v["doorObjects"] ~= "[[]]" then
				generateDoorObjects = fromJSON(v["doorObjects"])
			else
				generateDoorObjects = false
			end

			if v["doorTextures"] and v["doorTextures"] ~= "[ [ false ] ]" and v["doorTextures"] ~= "[[]]" then
				doorTextures = fromJSON(v["doorTextures"])
			else
				doorTextures = false
			end

			if v["headDoorTable"] and v["headDoorTable"] ~= "[ [ false ] ]" and v["headDoorTable"] ~= "[ [ ] ]" and v["headDoorTable"] ~= "[[]]" then
				genHeadDoorTable = fromJSON(v["headDoorTable"])
			else
				genHeadDoorTable = false
			end
			generateHouse(v["realInteriorIndex"], v["size"], false, wallTextureTable, sqlInsideWalls, sqlInsideWalls2, furnitureObjects, floorTextures, ceilTextures, generateInnerWallTexture, generateInnerWallTexture2, generateDoorObjects, doorTextures, genHeadDoorTable)
			loadCount = loadCount+1
		end
		--outputChatBox(loadCount.. " custom interiors are loaded")
	end
end)


function receiveEditedInfosFromClient(playerSource, dbID, textureTable, wallObjects1, wallObjects2, furnitures, floorTexture, ceilTexture, innerWallTexture, innerWallTexture2, innerDoors, innerDoorTextures, headDoorTexTable)
	dbExec(sqlConnection, "UPDATE custominteriors SET walltexturechanger = ?, createdWallObjects = ?, createdWallObjects2 =?, furnitures =?, texturechanger =?, ceilTexture =?, innerwalltexturechanger = ?, innerwalltexturechanger2 = ?, doorObjects=?, doorTextures = ?, headDoorTable = ?  WHERE realInteriorIndex = ?", toJSON(textureTable), toJSON(wallObjects1), toJSON(wallObjects2),toJSON(furnitures),toJSON(floorTexture),toJSON(ceilTexture),toJSON(innerWallTexture), toJSON(innerWallTexture2),toJSON(innerDoors),toJSON(innerDoorTextures),toJSON(headDoorTexTable),dbID)
	-- // set back the time to the actual
	local hour, minute = getTime()
	triggerClientEvent(playerSource, "setBackToActualTime", playerSource, hour, minute)
end
addEvent("receiveEditedInfosFromClient", true)
addEventHandler("receiveEditedInfosFromClient",getRootElement(), receiveEditedInfosFromClient)

function checkForSavingsServer(player, dbID)
	local sqlQuery = dbPoll(dbQuery(sqlConnection,"SELECT * FROM custominteriors WHERE realInteriorIndex = ?", dbID), -1)
	if (sqlQuery) then
		for k, v in ipairs(sqlQuery) do
			if v["walltexturechanger"] ~= "[ [ false ] ]" then
				sendTextureTableClient = fromJSON(v["walltexturechanger"])
			else
				sendTextureTableClient = false
			end
			if v["createdWallObjects"] ~= "[ [ false ] ]" then
				sendWallObjects = fromJSON(v["createdWallObjects"])
			else
				sendWallObjects = false
			end
			if v["createdWallObjects2"] ~= "[ [ false ] ]" then
				sendWallObjects2 = fromJSON(v["createdWallObjects2"])
			else
				sendWallObjects2 = false
			end
			if v["furnitures"] ~= "[ [ false ] ]" then
				sendFurnitureObjects = fromJSON(v["furnitures"])
			else
				sendFurnitureObjects = false
			end

			if v["texturechanger"] ~= "[ [ false ] ]" then
				sendFloorTextures = fromJSON(v["texturechanger"])
			else
				sendFloorTextures = false
			end

			if v["ceilTexture"] and v["ceilTexture"] ~= "[ [ false ] ]" then
				sendCeilTextures = fromJSON(v["ceilTexture"])
			else
				sendCeilTextures = false
			end

			if v["innerwalltexturechanger"] and v["innerwalltexturechanger"] ~= "[ [ false ] ]" and v["innerwalltexturechanger"] ~= "[[]]" then
				sendInnerWallTexture = fromJSON(v["innerwalltexturechanger"])
			else
				sendInnerWallTexture = false
			end
			if v["innerwalltexturechanger2"] and v["innerwalltexturechanger2"] ~= "[ [ false ] ]" and v["innerwalltexturechanger2"] ~= "[[]]" then
				sendInnerWallTexture2 = fromJSON(v["innerwalltexturechanger2"])
			else
				sendInnerWallTexture2 = false
			end

			if v["doorObjects"] and v["doorObjects"] ~= "[ [ false ] ]" and v["doorObjects"] ~= "[[]]" then
				sendDoorObjects = fromJSON(v["doorObjects"])
			else
				sendDoorObjects = false
			end

			if v["doorTextures"] and v["doorTextures"] ~= "[ [ false ] ]" and v["doorTextures"] ~= "[[]]" then
				sendDoorTextures = fromJSON(v["doorTextures"])
			else
				sendDoorTextures = false
			end

			if v["headDoorTable"] and v["headDoorTable"] ~= "[ [ false ] ]" and v["headDoorTable"] ~= "[[]]" and v["headDoorTable"] ~= "[ [ ] ]" then
				sendHeadDoorTable = fromJSON(v["headDoorTable"])
			else
				sendHeadDoorTable = false
			end

			triggerClientEvent(player, "createHouseObjectsClient", player,dbID, v["size"], sendTextureTableClient, sendWallObjects, sendWallObjects2, sendFurnitureObjects, sendFloorTextures, sendCeilTextures, sendInnerWallTexture, sendInnerWallTexture2, sendDoorObjects, sendDoorTextures, sendHeadDoorTable)
			--exports.bgo_interiors:loadOneInteriorWhereID(dbID)
		end
	end
end
addEvent("checkForSavingsServer", true)
addEventHandler("checkForSavingsServer",getRootElement(), checkForSavingsServer)

function changeDimInt(player, dim, int, x, y, z)
  --setElementInterior(player, int)
	setElementDimension(player, dim)
  setElementPosition(player, x, y, z)
end
addEvent("changeDimInt", true)
addEventHandler("changeDimInt",getRootElement(), changeDimInt)


function callLoadInteriorTextures(player, dbID)
	local sqlQuery = dbPoll(dbQuery(sqlConnection,"SELECT * FROM custominteriors WHERE realInteriorIndex = ?", dbID), -1)
	if (sqlQuery) then
		for k, v in ipairs(sqlQuery) do
			if v["walltexturechanger"] ~= "[ [ false ] ]" then
				sendTextureTableClient = fromJSON(v["walltexturechanger"])
			else
				sendTextureTableClient = false
			end

			if v["texturechanger"] ~= "[ [ false ] ]" then
				sendFloorTextures = fromJSON(v["texturechanger"])
			else
				sendFloorTextures = false
			end

			if v["ceilTexture"] and v["ceilTexture"] ~= "[ [ false ] ]" then
				sendCeilTextures = fromJSON(v["ceilTexture"])
			else
				sendCeilTextures = false
			end

			if v["innerwalltexturechanger"] and v["innerwalltexturechanger"] ~= "[ [ false ] ]" and v["innerwalltexturechanger"] ~= "[[]]" then
				sendInnerWallTexture = fromJSON(v["innerwalltexturechanger"])
			else
				sendInnerWallTexture = false
			end

			if v["innerwalltexturechanger2"] and v["innerwalltexturechanger2"] ~= "[ [ false ] ]" and v["innerwalltexturechanger2"] ~= "[[]]" then
				sendInnerWallTexture2 = fromJSON(v["innerwalltexturechanger2"])
			else
				sendInnerWallTexture2 = false
			end

			if v["doorObjects"] and v["doorObjects"] ~= "[ [ false ] ]" and v["doorObjects"] ~= "[[]]" then
				sendDoorObjects = fromJSON(v["doorObjects"])
			else
				sendDoorObjects = false
			end

			if v["doorTextures"] and v["doorTextures"] ~= "[ [ false ] ]" and v["doorTextures"] ~= "[[]]" then
				sendDoorTextures = fromJSON(v["doorTextures"])
			else
				sendDoorTextures = false
			end

			if v["headDoorTable"] and v["headDoorTable"] ~= "[ [ false ] ]" and v["headDoorTable"] ~= "[[]]" and v["headDoorTable"] ~= "[ [ ] ]" then
				sendHeadDoorTable = fromJSON(v["headDoorTable"])
			else
				sendHeadDoorTable = false
			end

			loadInteriorTextures(player, dbID, sendTextureTableClient, sendFloorTextures, sendCeilTextures, sendInnerWallTexture, sendInnerWallTexture2, sendDoorTextures, sendHeadDoorTable, sendDoorObjects)
			--exports.bgo_interiors:loadOneInteriorWhereID(dbID)
		end
	end
end

function loadInteriorTextures(player, dbID, textureTable, floorTextures, ceilTextures, innerWallTextures, inWallTexture2, doorTextures, headDoorTable, doorObjects)
		if headDoorTable then
			triggerClientEvent(player, "receiveTextureClient", player, doorObj[dbID], headDoorTable[2], "*")
		end
		if textureTable then
			for k, v in pairs(wallTable[dbID]) do
				for textureK, textureV in pairs(textureTable) do
					if textureV.index1 then
						if textureV.index1[1] == k then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index1[2], textureV.index1[3])
						end
					end
					if textureV.index2 then
						if textureV.index2[1] == k then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index2[2], textureV.index2[3])
						end
					end
				end
			end
		end

		if innerWallTextures then
			for k, v in pairs(createdWallObjects[dbID]) do
				for textureK, textureV in pairs(innerWallTextures) do
					if k == textureK then
						if textureV.index1 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index1[2], textureV.index1[3])
						end
						if textureV.index2 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index2[2], textureV.index2[3])
						end
						if textureV.index3 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index3[2], textureV.index3[3])
						end
						if textureV.index4 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index4[2], textureV.index4[3])
						end
					end
				end
			end
		end
		if inWallTexture2 then
			for k, v in pairs(createdWallObjects2[dbID]) do
				for textureK, textureV in pairs(inWallTexture2) do
					if k == textureK then
						if textureV.index1 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index1[2], textureV.index1[3])
						end
						if textureV.index2 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index2[2], textureV.index2[3])
						end
						if textureV.index3 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index3[2], textureV.index3[3])
						end
						if textureV.index4 then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV.index4[2], textureV.index4[3])
						end
					end
				end
			end
		end
		if doorTextures then
			for k, v in pairs(innerDoorTable[dbID]) do
				for textureK, textureV in pairs(doorTextures) do
					--for doorK, doorV in pairs(doorObjects) do
					if k == textureK then
						if textureV.index1 then
							triggerClientEvent(player, "receiveTextureClient", player, innerDoorTable[dbID][k], textureV.index1[2], "*")
						end
						if textureV.index2 then
							triggerClientEvent(player, "receiveTextureClient", player, innerDoorTable[dbID][k], textureV.index2[2], "*")
						end
					end
	      end
			end
		end
		if floorTextures then
			for k, v in pairs(floorTable[dbID]) do
				for textureK, textureV in pairs(floorTextures) do
					if textureV[1] then
						if textureV[1] == k then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV[4], "la_carp"..textureV[2])
						end
					end
				end
			end
		end
		if ceilTextures then
			for k, v in pairs(roofTable[dbID]) do
				for textureK, textureV in pairs(ceilTextures) do
					if textureV[1] then
						if textureV[1] == k then
							triggerClientEvent(player, "receiveTextureClient", player, v, textureV[4], "la_carp"..textureV[2])
						end
					end
				end
			end
		end
	end
addEvent("loadInteriorTextures", true)
addEventHandler("loadInteriorTextures",getRootElement(), loadInteriorTextures)


function changeInteriorEntrance(dbID, wIndex, size)
	local dX, dY, dZ = getElementPosition(wallTable[dbID][wIndex])
	local dRot = 0
	if wIndex > size/2 then
		if wIndex > size/2+size/4 then
			dRot = 0
		else
			dRot = 180
		end
	else
		if wIndex < size/2-size/4 then
			dRot = 90
		else
			dRot = -90
		end
	end
	

	
	local interiorEntranceX, interiorEntranceY, interiorEntranceZ = getPositionInfrontOfElement(dX, dY, oz+1.2, dRot, -1)
	dbExec(sqlConnection, "UPDATE interiors SET interiorx = ?, interiory = ?, interiorz = ? WHERE id = ?",interiorEntranceX, interiorEntranceY, interiorEntranceZ, dbID)
	for k,v in ipairs(getElementsByType("marker")) do
		if getElementData(v,"isIntOutMarker") then
			if getElementData(v,"acc:id") == dbID then
				local _,_,actualZ = getElementPosition(v)
				setElementPosition(v, interiorEntranceX, interiorEntranceY, actualZ)
				setElementData(v, "x", interiorEntranceX)
				setElementData(v, "y", interiorEntranceY)
				setElementData(v, "z", actualZ)
				--outputChatBox(dRot.. " position changed")
		--exports.bgo_interiors:loadOneInteriorWhereID(dbID)
			end
		end
	end
	
end
addEvent("changeInteriorEntrance", true)
addEventHandler("changeInteriorEntrance",getRootElement(), changeInteriorEntrance)



function exitWithoutSaving(playerSource)
	-- // set back the time to the actual
	local hour, minute = getTime()
	triggerClientEvent(playerSource, "setBackToActualTime", playerSource, hour, minute)
end
addEvent("exitWithoutSaving", true)
addEventHandler("exitWithoutSaving",getRootElement(), exitWithoutSaving)


function getPositionInfrontOfElement(x,y,z, rot, meters)
    local meters = (type(meters) == "number" and meters) or 3
    local posX, posY, posZ = x,y,z
    posX = posX - math.sin(math.rad(rot)) * meters
    posY = posY + math.cos(math.rad(rot)) * meters
    rot = rot + math.cos(math.rad(rot))
    return posX, posY, posZ , rot
end
