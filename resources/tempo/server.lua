function updateTime()
	hour = getRealTime().hour
	valodi = getRealTime().hour
	minute = getRealTime().minute
	
	 if hour >=0 and hour <= 2 then
		hour = hour
        setTime(hour, minute)
        setMinuteDuration(60000)
       -- outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour >=3 and hour < 6 then
        hour = hour-2
        setTime(hour, minute)
        setMinuteDuration(60000)
        --outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
    elseif hour >= 6 and hour < 7 then
        hour = getRealTime().hour-2
        setTime(hour, minute)
        setMinuteDuration(60000)
       -- outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour >= 7 and hour < 8 then
        hour = getRealTime().hour-1
        setTime(hour, minute)
        setMinuteDuration(60000)
       -- outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour >= 8 and hour < 15 then
        hour = getRealTime().hour
        setTime(hour, minute)
        setMinuteDuration(60000)
       -- outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour >= 15 and hour <= 16  then
        hour = hour+4
        setTime(hour, minute)
        setMinuteDuration(60000)
       -- outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
    elseif hour > 16 and hour <= 17 then
        hour = hour+5
        setTime(hour, minute)
        setMinuteDuration(60000)
        --outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour > 17  and hour <= 19 then
        hour = hour+5
        if hour >= 24 then
		 hour = 0
			setTime(hour, minute)
			setMinuteDuration(60000)
			--outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
		else
		setTime(hour, minute)
		setMinuteDuration(60000)
		--outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
		end
	elseif hour > 19  and hour <= 20 then
        hour = 0
		setTime(hour, minute)
		setMinuteDuration(60000)
		--outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour > 20  and hour <= 21 then
        hour = 0
        setTime(hour, minute)
        setMinuteDuration(60000)
        --outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour > 21  and hour <= 22 then
        hour = 0
		setTime(hour, minute)
        setMinuteDuration(60000)
        --outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour > 22  and hour <= 23 then
        hour = 0
		setTime(hour, minute)
        setMinuteDuration(60000)
        --outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	elseif hour > 22  and hour <= 24 then
        hour = 0
        setTime(hour, minute)
        setMinuteDuration(60000)
       -- outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
    end
	
	--outputDebugString("Servidor: : " .. string.format("%02d:%02d", (hour), minute))
	--outputDebugString("Servidor: : " .. string.format("%02d:%02d", (amount), minute))
	--outputDebugString("Hora Real: " .. string.format("%02d:%02d", (valodi), minute))
	--outputDebugString("----------------------------------")

	local realtime = getRealTime()
	hour = realtime.hour

	if hour >= 24 then
		hour = hour - 24
	elseif hour < 0 then
		hour = hour + 24
	end

	if hour >= 17 then
		hour = hour + 4
	elseif hour <= 7 then
		hour = hour - 2
	end

	minute = realtime.minute

	setTime(hour, minute)
	setMinuteDuration(60000)

	outputDebugString("Hora Real: " .. realtime.hour .. ":" .. minute)
	outputDebugString("Servidor: : " .. hour .. ":" .. minute)
end
setTimer(updateTime, 1000*60*60, 0) --> 1 óra

function initialise()
	updateTime()
	--updateWeather()
end
addEventHandler("onResourceStart", resourceRoot, initialise)


weathers = {
	{math.random(0, 7), "limpo"},
	{7, "nublado"},
	{31, "nebuloso"},
	{8, "nublado, chuvoso"},
	{16, "chuvoso"},
}

function updateWeather()
	randomWeather = math.random(1, 50)
	randomStorm = math.random(1, 60)
	
	outputDebugString(randomWeather .. " " .. randomStorm)
	
	if randomWeather ~= randomStorm then
		weather = 1
	else
		weather = math.random(1, 4)
	end

	local currentWeather = math.random(#weathers)

	--setWaveHeight(weather / 2)
	outputChatBox(" ", root, 255, 162, 0, true)
	outputChatBox(" ", root, 255, 162, 0, true)
	 outputChatBox(" ", root, 255, 162, 0, true)
	outputChatBox(" ", root, 255, 162, 0, true)
	timerSet = weathers[currentWeather][1]
	timerStats = tonumber(timerSet)
	outputChatBox("[CLIMA]: #ffffffTempo atualmente na cidade #FFA200"..weathers[currentWeather][2]..".", root, 255, 162, 0, true)
	setWeather(timerStats)
	--outputChatBox("[Tempo]: #ffffffAtualmente na cidade #FFA200"..temperature.." #ffffff°C van.", root, 255, 162, 0, true)
end
--setTimer(updateWeather, 1000*60*20, 0) --> 1 óra
--[[
function initialise()
	updateTime()
	--updateWeather()

	if #getElementsByType("player") < 20 then
		if not isTimer(trafficTimer) then
			trafficTimer = setTimer(handleTrafficLightsOutOfOrder, 500, 0)
		end
	else
		if isTimer(trafficTimer) then
			killTimer(trafficTimer)
			setTrafficLightState("auto")
		end	
	end	
end
addEventHandler("onResourceStart", resourceRoot, initialise)

function handleTrafficLightsOutOfOrder()
	local lightsOff = getTrafficLightState() == 9
	    
	if lightsOff then
	    setTrafficLightState(6)
	else
	    setTrafficLightState(9)
	end
end


addEventHandler("onPlayerQuit", root, function()
	if #getElementsByType("player") < 20 then
		if not isTimer(trafficTimer) then
			trafficTimer = setTimer(handleTrafficLightsOutOfOrder, 500, 0)
		end
	end
end)

addEventHandler("onPlayerJoin", root, function()
	if #getElementsByType("player") >= 20 then
		if isTimer(trafficTimer) then
			killTimer(trafficTimer)
			setTrafficLightState("auto")
		end
	end
end)
]]--

--[[
-------- REMOVE FULL SAN FIERRO
 for key, value in ipairs(getElementsByType("object")) do
	local modelId = getElementModel(value)
	local x, y, z = getElementPosition(value)

	if getZoneName(x, y, z) == "San Fierro" then
		--outputChatBox(modelId)

	end
end]]--

--removeWorldModel (4215, 10000, 0, 0, 0)