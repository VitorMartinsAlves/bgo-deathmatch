local rroot = getResourceRootElement()
local jug = 1

addEventHandler("onResourceStart",rroot,function()
	setTimer(renderRayo,10000,0)
end)

function renderRayo()
	local weatherID = getWeather()
	if weatherID == 8 then
	local jugadores = getElementsByType("player")
	if not jugadores[jug] and jugadores[1] then jug = 1
	elseif not jugadores[1] then return end
	
	local x,y,z = getElementPosition(jugadores[jug])
	if z > 200 then
		jug = jug+1
		return
	end
	local data = {}
	data[1] = math.random(-40,40)+x
	data[2] = math.random(-40,40)+y
	data[3] = 200
	data[4] = math.random(-35,35)+x
	data[5] = math.random(-35,35)+y
	data[6] = math.random(-25,25)+x
	data[7] = math.random(-25,25)+y
	for k,v in ipairs(jugadores) do
		if getDistanceBetweenPoints3D(x,y,z,getElementPosition(v)) < 150 then
			triggerClientEvent("zm-rayo",jugadores[jug],data)
		end
	end
	jug = jug + 1
end
end