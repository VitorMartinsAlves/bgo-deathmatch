local intens = 100 -- Determines the maximum darkness

--setFogDistance(0)
--resetSkyGradient()

lock_color = false
bx, by, bz, ax, ay, az =  168, 135, 84, 136, 91, 61

function clr(a, t)
	return (a - (a*(t-20)/3))
end

function uclr(a, t)
	return (a*(t-2)/3)
end

function timeInterval()
	if (getMinuteDuration() >= 100) then
		return getMinuteDuration()
	else
		return 100
	end
end

setTimer(function()
	--local h, m = getTime()
	
	local timer = getRealTime()
	local hours = timer.hour
	 
	if hours >= 5 then
		resetSkyGradient()
		resetFogDistance()	
		return
	end	
--[[
	if hours >= 7 then
		resetSkyGradient()
		resetFogDistance()	
		return
	end	
	
	if hours >= 12 then
		resetSkyGradient()
		resetFogDistance()	
		return
	end	
	
]]--
	if hours >= 18 then
		--setFogDistance(-intens)
		setSkyGradient(0, 0, 0, 0, 0, 0)
		return
	end
	
	
	if hours >= 00 and hours <= 5 then
		--setFogDistance(-1)
		setSkyGradient(0, 0, 0, 0, 0, 0)
		return
	end
	
	--resetSkyGradient()
	--resetFogDistance()

	
	


--[[
	if (h >= 5) and (h <= 7) then
		setFogDistance(-1)
		setSkyGradient( 0, 22, 78, 0, 0, 0)
	end

	if (h >= 07 and h <= 18 ) then
		resetSkyGradient()
		setFogDistance(0)
	end]]--
end, 100, 0)
	


--[[

addEventHandler( "onResourceStart", getRootElement( ),
    function ()
		setFogDistance(-intens)

		setSkyGradient(0, 0, 0, 0, 0, 0)
    end
);
]]--

addEventHandler( "onResourceStop", resourceRoot,
    function ()
		setFogDistance(0)
		resetSkyGradient()
    end
);