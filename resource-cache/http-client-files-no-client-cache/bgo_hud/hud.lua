
local sX,sY = guiGetScreenSize()
hudEnabled = nil	-- Is the Hud Enabled?

local SAFEZONE_X = sX*0.01
local SAFEZONE_Y = sY*0.09

local SAFEZONE_X2 = sX*0.01
local SAFEZONE_Y2 = sY*0.09
local disabledHUD = {"health", "armour", "breath", "clock", "money", "weapon", "ammo", "vehicle_name", "area_name", "wanted"} 
	-- Replaced HUD Components
local wantedOff = 55
local game_time	= ""	-- Game Date and Time
local date_ = ""		-- Client Date and Time
local uptime = getRealTime().timestamp
	-- Client Uptime

local healthTimer = setTimer(function() end, 1000, 0)
	-- Timer that makes health flash

-- Toggle HUD
-------------->>

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,hud in ipairs(disabledHUD) do
		setPlayerHudComponentVisible(hud, false)
	end
	hudEnabled = true
end)

-- HUD Exports
--------------->>

local enabledHud = {"radar", "radio", "crosshair"}
function showHud()
	if (isCustomHudEnabled()) then
		setPlayerHudComponentVisible("all", false)
		for i,hud in ipairs(enabledHud) do
			setPlayerHudComponentVisible(hud, true)
		end
	else
		setPlayerHudComponentVisible("all", true)
	end
end
addEvent("GTIhud.showHud", true)
addEventHandler("GTIhud.showHud", root, showHud)

function isCustomHudEnabled()
	return hudEnabled or false
end

local screenW2, screenH2 = guiGetScreenSize()
local x,y = (screenW2/1360), (screenH2/768)


addEventHandler("onClientPreRender", root,
	function()
	if not getElementData (localPlayer, "loggedin") then return end
	local logo = exports.bgo_logo:logo()
	if logo then
	        	dxDrawImage(x*1248, y*12, x*90, y*80, logo, 0, 0, 0, tocolor(255, 254, 254, 255), false)
		end
		end
)

	
	
-- Health
---------->>

function renderHealth()
if not getElementData (localPlayer, "loggedin") then return end
	if getElementData (localPlayer, "EsconderHUD") == true then return end
	for i,hud in ipairs(disabledHUD) do
		setPlayerHudComponentVisible(hud, false)
	end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	local health = getElementHealth(localPlayer)
	local maxHealth = getPedStat(localPlayer, 24)
	local maxHealth = (((maxHealth-569)/(1000-569))*100)+100
	local healthStat = health/maxHealth
	
	local r1,g1,b1, r2,g2,b2, a
	if (healthStat > 0.25) then
		r1,g1,b1 = 180,25,29
		r2,g2,b2 = 90,12,14
		a = 200
	else
		r1,g1,b1 = 180,25,29
		r2,g2,b2 = 90,12,14
		
		local aT = getTimerDetails(healthTimer)
		if (aT > 500) then
			a = (aT-500)/500*200
		else
			a = (500-aT)/500*200
		end
	end
	
	local dX,dY,dW,dH = sX-150,0,150,15
	local dX,dY,dW,dH = sX-150-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-147,3,144,9
	local dX,dY,dW,dH = sX-147-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX,dY,healthStat*dW,dH, tocolor(r1,g1,b1,a) )
	
	local dX,dY,dW,dH = sX-150,19,150,15
	local dX,dY,dW,dH = sX-150-SAFEZONE_X, dY+SAFEZONE_Y+0.5, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local fome = getElementData(localPlayer, "char:hunger")/100
	local dX,dY,dW,dH = sX-147,22,144,9
	local dX,dY,dW,dH = sX-147-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	dxDrawRectangle( dX,dY+0.5,fome*dW,dH, tocolor(124, 249, 1,a) )
	
	local dX,dY,dW,dH = sX-150,39,150,15
	local dX,dY,dW,dH = sX-150-SAFEZONE_X, dY+SAFEZONE_Y-1, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local fome = getElementData(localPlayer, "char:thirst")/100
	local dX,dY,dW,dH = sX-147,41,144,9
	local dX,dY,dW,dH = sX-147-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	dxDrawRectangle( dX,dY,fome*dW,dH, tocolor(0, 85, 255,a) )
	
	
	
	
	local dX,dY,dW,dH = sX-222,19,sX-222+75,20
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText("Fome:", dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText("Fome:", dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText("Fome:", dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "center")
	
	local dX,dY,dW,dH = sX-222,39,sX-222+75,20
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText("Sede:", dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText("Sede:", dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText("Sede:", dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "center")
	
	
	
end
--addEventHandler("onClientHUDRender", root, renderHealth)

-- Armor
--------->>

function renderArmor()
	    	if getElementData (localPlayer, "EsconderHUD") == true then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	
	local armor = getPedArmor(localPlayer)
	local oxygen = getPedOxygenLevel(localPlayer)
	if (oxygen < 1000) then return end
	local armorStat = armor/100
	
	local r1,g1,b1, r2,g2,b2
	r1,g1,b1 = 225,225,225
	r2,g2,b2 = 112,112,112
	
	local dX,dY,dW,dH = sX-222,0,72,15
	local dX,dY,dW,dH = sX-222-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-219,3,69,9
	local dX,dY,dW,dH = sX-219-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX,dY,armorStat*dW,dH, tocolor(r1,g1,b1,200) )
	--dxDrawRectangle( dX+dW-(armorStat*dW),dY,armorStat*dW,dH, tocolor(r1,g1,b1,200) )
end
--addEventHandler("onClientHUDRender", root, renderArmor)



-- Ping/FPS Meter
------------------>>

local FPScount = 0
local ping = 0
local fps = 0
function updatePingAndFPS()
	ping = getPlayerPing(localPlayer)
	fps = FPScount
	FPScount = 0
end
setTimer(updatePingAndFPS, 1000, 0)


function updateGameTime()
	local time = getRealTime()
	local hrs = time.hour
	local mins = time.minute
	
	
	local ampm = "am"
	if (hrs >= 12) then ampm = "pm" end
	
	--if (hrs == 0) then hrs = 12 end
	--if (hrs > 12) then hrs = hrs - 12 end
	if (hrs < 10) then hrs = "0"..hrs end
	if (mins < 10) then mins = "0"..mins end
	
	game_time = hrs..":"..mins.." "..ampm
end
setTimer(updateGameTime, 3000, 0)

daysmes = {
     {0, "01"},
	 {1, "02"},
	 {2, "03"},
	 {3, "04"},
	 {4, "05"},
	 {5, "06"},
	 {6, "07"},
	 {7, "08"},
	 {8, "09"},
	 {9, "10"},
	 {10, "11"},
	 {11, "12"},
}



function renderFPSandPing()
	 if getElementData (localPlayer, "EsconderHUD") == true then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	FPScount = FPScount + 1
	
	if (not ping or not fps) then return end
	local dX,dY,dW,dH = sX-5,60,sX-5,20
	local dX,dY,dW,dH = dX-SAFEZONE_X2, dY+SAFEZONE_Y2, dW-SAFEZONE_X2, dH+SAFEZONE_Y2
 	 local time = getRealTime()
	 local hours = time.hour
	 local minutes = time.minute
	 local seconds = time.second
	 local zeroh = ""
	 local zerom = ""

     local monthday = time.monthday
	 local month = time.month
	 local year = time.year
	 
	 local yearday = time.yearday
	 local weekday = time.weekday
	 

	 local ano = tostring(time.year):sub(-2)
	 
	 for _,mess in pairs(daysmes) do
	     if month == mess[1] then
		     meses = mess[2]
		 end
	 end


	dxDrawText(""..game_time.." | "..monthday.."/"..meses.."/20"..ano.."\nPing: "..ping.." | FPS: "..fps, dX+1,dY,dW+1,dH, tocolor(0,0,0,255), 1, "clear", "right", "top")
	dxDrawText(""..game_time.." | "..monthday.."/"..meses.."/20"..ano.."\nPing: "..ping.." | FPS: "..fps, dX,dY+1,dW,dH+1, tocolor(0,0,0,255), 1, "clear", "right", "top")
	dxDrawText(""..game_time.." | "..monthday.."/"..meses.."/20"..ano.."\nPing: "..ping.." | FPS: "..fps, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "right", "top")


end
addEventHandler("onClientHUDRender", root, renderFPSandPing)




-- Money
--------->>

local moneyY = 25
function renderMoney()
	    	if getElementData (localPlayer, "EsconderHUD") == true then return end
			if not getElementData (localPlayer, "loggedin") then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	
	local cash = getElementData(localPlayer, "char:money") --getPlayerMoney()
	cash = "r$: "..tocomma(cash)
	
	local r1,g1,b1
	if (getPlayerMoney() >= 0) then
		r1,g1,b1 = 54,104,44
	else
		cash = string.gsub(cash, "%D", "")
		cash = "-$"..tocomma(cash)
		r1,g1,b1 = 180,25,29
	end
		
	local dX,dY,dW,dH = sX-6,35+moneyY+wantedOff,sX-6,30
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(cash, dX+2,dY,dW+2,dH, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX,dY,dW,dH, tocolor(r1,g1,b1,255), 1.35, "pricedown", "right")
end
addEventHandler("onClientHUDRender", root, renderMoney)

-- Show +/- Money
------------------>>

local cashAmt = 0
local r,g,b = 0,0,0
local pmTimer
local pm = ""
function showPlusMoney(amount)
    if (isTimer(pmTimer) and pm == "-") then
           cashAmt = cashAmt + amount
           if (cashAmt < 0) then
            cashAmt = cashAmt - cashAmt - cashAmt
                pm = "-"
                mr,mg,mb = 180,80,90
           elseif (cashAmt > 0) then
                pm = "+"
                mr,mg,mb = 110,150,125
           end
    else
        cashAmt = cashAmt + amount
        pm = "+" 
        mr,mg,mb = 110,150,125
    end   
    if (isTimer(pmTimer)) then killTimer(pmTimer) pmTimer = nil end
    pmTimer = setTimer(function() cashAmt = 0 pmTimer = nil end, 5000, 1)
end
addEvent("onClientPlayerGiveMoney", true)
addEventHandler("onClientPlayerGiveMoney", localPlayer, showPlusMoney)



addEventHandler("onClientElementDataChange", root, function(dataName, oldValue)
	if source == localPlayer and dataName == "char:money" and getElementData(localPlayer, "loggedin") then
        local newValue = getElementData(source, "char:money") or 0
        if newValue then
            moneyTick = getTickCount() + 5000

            moneyChange = math.abs(newValue - oldValue)
            if newValue < oldValue then
				showMinusMoney(moneyChange)
            else
				
				showPlusMoney(moneyChange)
            end

			playSound("money.mp3", false)
        end
    elseif source == localPlayer and dataName == "loggedin" then
    	--loadStats()
	end
end)


function showMinusMoney(amount)
    if (isTimer(pmTimer) and pm == "+") then
           cashAmt = cashAmt - amount
           if (cashAmt < 0) then
                cashAmt = cashAmt - cashAmt - cashAmt
                pm = "-"
                mr,mg,mb = 180,80,90
           elseif (cashAmt > 0) then
                pm = "+"
                mr,mg,mb = 110,150,125
           end
    else
        cashAmt = cashAmt + amount
        pm = "-" 
        mr,mg,mb = 180,80,90   
    end         
           
           
    if (isTimer(pmTimer)) then killTimer(pmTimer) pmTimer = nil end
    pmTimer = setTimer(function() cashAmt = 0 pmTimer = nil end, 5000, 1)
end
addEvent("onClientPlayerTakeMoney", true)
addEventHandler("onClientPlayerTakeMoney", localPlayer, showMinusMoney)

local monA = 0
function renderPlusMinusMoney()
	if getElementData (localPlayer, "EsconderHUD") == true then return end
	if not getElementData (localPlayer, "loggedin") then return end
    if (isPlayerMapVisible() or not hudEnabled) then return end
    
    if (cashAmt == 0 or not pmTimer) then return end
    local cash = tocomma(cashAmt)
    
    local timeLeft = getTimerDetails(pmTimer)
    if (timeLeft > 4750) then
        monA = ((5000-timeLeft)/250) * 255
    elseif (timeLeft < 250) then
        monA = (timeLeft/250) * 255
    end
    
    local dX,dY,dW,dH = sX-6,70+moneyY+wantedOff,sX-6,30
    local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
    dxDrawText(pm.."$"..cash, dX+2,dY,dW+2,dH, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX,dY+2,dW,dH+2, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX-2,dY,dW-2,dH, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX,dY-2,dW,dH-2, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX,dY,dW,dH, tocolor(mr,mg,mb,monA), 1.25, "pricedown", "right")
end
addEventHandler("onClientHUDRender", root, renderPlusMinusMoney)


function tocomma(number)
	while true do
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return number
end


-- Weapons
----------->>

function renderWeapons()
	    	if getElementData (localPlayer, "EsconderHUD") == true then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	
	local weapon = getPedWeapon(localPlayer)
	local clip = getPedAmmoInClip(localPlayer)
	local ammo = getPedTotalAmmo(localPlayer)
	if (weapon == 0 or weapon == 1 or ammo == 0) then moneyY = 0 return end
	moneyY = 35
		
	local len = #tostring(clip)
	if string.find(tostring(clip), 1) then len = len - 0.5 end
	local xoff = (len*17) + 10
	
	local len2 = #tostring(ammo-clip)
	if string.find(tostring(ammo-clip), 1) then len2 = len2 - 0.5 end
	local weapLen = ((len+len2)*17) + 20
	
	if (weapon == 22) then moneyY = 0 return end
	
	if (weapon >= 15 and weapon ~= 40 and weapon <= 44 or weapon >= 46) then
			-- Ammo in Clip
		local dX,dY,dW,dH = sX-6,35+wantedOff,sX-6,30
		local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
		dxDrawText(clip, dX+2,dY,dW+2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY,dW,dH, tocolor(110,110,110,255), 1.25, "pricedown", "right")
			-- Total Ammo
		local dX,dY,dW,dH = sX-6-xoff,35+wantedOff,sX-6-xoff,30
		local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
		dxDrawText(ammo-clip, dX+2-xoff,dY,dW+2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY,dW,dH, tocolor(220,220,220,255), 1.25, "pricedown", "right")
	else
		xoff = 0
		weapLen = 0
	end

	if (weapon == 0 or weapon == 1) then return end
	local img = "weaps/"..weapon..".png"
	local dX,dY,dW,dH = sX-133-weapLen,35+wantedOff,128,40
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawImage(dX, dY, dW, dH, img)	
end
addEventHandler("onClientHUDRender", root, renderWeapons)



-- Game Time
------------->>


function renderGameTime()
	    	if getElementData (localPlayer, "EsconderHUD") == true then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
		
	local dX,dY,dW,dH = sX-222,-19,sX-222+75,20
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(game_time, dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText(game_time, dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText(game_time, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "center")
end
--addEventHandler("onClientHUDRender", root, renderGameTime)



--[[
-- Oxygen
---------->>

function renderOxygenLevel()
	    	if getElementData (localPlayer, "EsconderHUD") == true then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	
	local oxygen = getPedOxygenLevel(localPlayer)
	if (oxygen >= 1000) then return end
	local oxygenStat = oxygen/1000
	
	local r1,g1,b1, r2,g2,b2
	r1,g1,b1 = 172,203,241
	r2,g2,b2 = 86,101,120
	
	local dX,dY,dW,dH = sX-222,0,72,15
	local dX,dY,dW,dH = sX-222-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-219,3,69,9
	local dX,dY,dW,dH = sX-219-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX+dW-(oxygenStat*dW),dY,oxygenStat*dW,dH, tocolor(r1,g1,b1,200) )
end
addEventHandler("onClientHUDRender", root, renderOxygenLevel)




-- Wanted Level
---------------->>

local wantedOff = 0
function renderWantedLevel()
	    	if getElementData (localPlayer, "EsconderHUD") == true then return end
	if (isPlayerMapVisible() or not hudEnabled) then return end
	local wanted = getPlayerWantedLevel()
	if (wanted == 0) then wantedOff = 0 return end
	wantedOff = 35
	
	local DIST_BTWN_STARS = 216/6
	local dX,dY,dW,dH = sX-33,37,30,29
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	
	active = "wanted/wanted_active2.png"
	
	local total_stars = 0
	local active_stars = 0
	for i=1,wanted do
		dxDrawImage(dX-(total_stars*DIST_BTWN_STARS), dY, dW, dH, active)
		total_stars = total_stars + 1
		active_stars = active_stars + 1
	end
	for i=1,6-active_stars do
		dxDrawImage(dX-(total_stars*DIST_BTWN_STARS), dY, dW, dH, "wanted/wanted_inactive.png")
		total_stars = total_stars + 1
	end
end
addEventHandler("onClientHUDRender", root, renderWantedLevel)
]]--


setTimer(function()
    if getElementData(localPlayer, "loggedin") and getElementData(localPlayer, "char:adminduty") == 0 then
        local coco = getElementData(localPlayer, "char:Cagar")
        if getElementData(localPlayer, "adminjail") == 1 then
			return
		end
		if (tonumber(coco) or 0) > 40 then
                --outputChatBox("#7cc576[BGO MTA] #ffffffVocê está ficando com fome! Comer alguma coisa!",255, 255, 255, true)
                exports.JoinQuitGtaV:createNotification("comida", "*Ei, Você está precisando cagar! digite /cagar e sinta-se melhor", 5)
        end
    end
end, 1000 * 60 * 6, 0)

warningF = 0
warningS = 0
warningV = 0
setTimer(function()
    if getElementData(localPlayer, "loggedin") and getElementData(localPlayer, "char:adminduty") == 0 then
        local hunger = getElementData(localPlayer, "char:hunger")
        if getElementData(localPlayer, "adminjail") == 1 then
			return
		end
		
		if hunger > 7 then
            random = math.random(4, 7)
            setElementData(localPlayer, "char:hunger", hunger - random)
        elseif hunger ~= 0 and hunger <= 7 then
            setElementData(localPlayer, "char:hunger", 0)
        else
                outputChatBox("#7cc576[BGO MTA] #ffffffVocê está ficando com fome! Comer alguma coisa!",255, 255, 255, true)
				CGlitch:show(1000); 
                exports.JoinQuitGtaV:createNotification("comida", "*Ei, Você está ficando com fome, Tente comer alguma coisa!", 5)
                setElementHealth(localPlayer, getElementHealth(localPlayer) - 3)
        end
    end
end, 1000 * 60 * 6, 0)


setTimer(function()
    if getElementData(localPlayer, "loggedin") and getElementData(localPlayer, "char:adminduty") == 0 then
        local hunger = getElementData(localPlayer, "char:thirst")
        if getElementData(localPlayer, "adminjail") == 1 then
			return
		end
		
		if hunger > 7 then
            random = math.random(4, 7)
            setElementData(localPlayer, "char:thirst", hunger - random)
        elseif hunger ~= 0 and hunger <= 7 then
            setElementData(localPlayer, "char:thirst", 0)
        else
                outputChatBox("#7cc576[BGO MTA] #ffffff*Ei, Você está ficando com sede, Tente beber alguma coisa!",255, 255, 255, true)
				CGlitch:show(1000); 
                exports.JoinQuitGtaV:createNotification("comida", "*Ei, Você está ficando com sede, Tente beber alguma coisa!", 5)
                setElementHealth(localPlayer, getElementHealth(localPlayer) - 3)
        end
    end
end, 1000 * 60 * 6, 0)



setTimer(function()
    if getElementData(localPlayer, "loggedin") and getElementData(localPlayer, "char:adminduty") == 0 then
        local vicio = getElementData(localPlayer, "char:vicio")
        if getElementData(localPlayer, "adminjail") == 1 then
			return
		end
		
		if vicio > 1 then
            outputChatBox("#7cc576[BGO MTA] #ffffff*Ei, Você está com dependência em cigarros , Tente ir no hospital!",255, 255, 255, true)
            CGlitch:show(2000); 
            exports.JoinQuitGtaV:createNotification("comida", "*Ei, Você está com dependência em cigarros , Tente ir no hospital!", 5)
            setElementHealth(localPlayer, getElementHealth(localPlayer) - 3)
        end
    end
end, 1000 * 60 * 6, 0)



















local SHADER_CODE = base64Decode("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AAAAAAcAAAAAAAAAAAAAAAcAAAAEAAAAAAAAAAcAAAAIAAAAAQBQoAIAAAAAAAAABwAAAAgAAAAAAAAAAQAAABkAAAAAAAAABAAAAAgAAAABAFCgAgAAAAAAAAAHAAAACAAAAAAAAAABAAAACQAAAAAAAAAHAAAAAAAAAAEAQBABAAAAAAAAAAcAAAAAAAAAAAAAAAcAAAAEAAAAAQAQEAEAAAAAAAAABwAAAAQAAAAAAAAABwAAAAEAAAABAECgAgAAAAAAAAAHAAAAAQAAAAAAAAAHAAAAAAAAAAAAAAAHAAAABAAAAAEAUKACAAAAAAAAAAcAAAAEAAAAAAAAAAEAAAAKAAAAAAAAAAcAAAAAAAAAAgBQoAIAAAAAAAAABwAAAAAAAAAAAAAAAQAAAAwAAAAAAAAABwAAAAQAAAABAECgAgAAAAAAAAAHAAAABQAAAAAAAAAHAAAABAAAAAAAAAAHAAAAAAAAAAEAUKACAAAAAAAAAAcAAAAAAAAAAAAAAAEAAAALAAAAAAAAAAcAAAAEAAAAAQBAoAIAAAAAAAAABwAAAAQAAAAAAAAAAQAAAA4AAAAAAAAABwAAAAAAAAABAEAQAQAAAAAAAAAHAAAAAAAAAAAAAAAHAAAABAAAAAEAUKACAAAAAAAAAAcAAAAEAAAAAAAAAAEAAAAPAAAAAAAAAAcAAAAAAAAAAQBAoAIAAAAAAAAABwAAAAAAAAAAAAAAAQAAABAAAAAAAAAABwAAAAQAAAABAIAQAQAAAAAAAAAHAAAABAAAAAAAAAAHAAAAAQAAAAEAUKACAAAAAAAAAAcAAAABAAAAAAAAAAEAAAARAAAAAAAAAAcAAAAEAAAAAQBAEAEAAAAAAAAABwAAAAQAAAAAAAAABwAAAAAAAAABAECgAgAAAAAAAAACAAAABAAAAAAAAAABAAAAGgAAAAAAAAAHAAAAAQAAAAEAEKACAAAAAAAAAAcAAAABAAAAAAAAAAEAAAAbAAAAAAAAAAcAAAAEAAAAAQAAEAEAAAAAAAAABwAAAAEAAAAAAAAABAAAABAAAAABAACgAgAAAAAAAAAHAAAABAAAAAAAAAABAAAACAAAAAAAAAAHAAAAAQAAAAEAEBABAAAAAAAAAAcAAAABAAAAAAAAAAcAAAAEAAAAAQBQoAIAAAAAAAAABwAAAAEAAAAAAAAAAQAAAA4AAAAAAAAABAAAAAwAAAABAECgAgAAAAAAAAAHAAAABAAAAAAAAAABAAAACAAAAAAAAAAHAAAAAQAAAAEAUKACAAAAAAAAAAcAAAABAAAAAAAAAAEAAAASAAAAAAAAAAcAAAAEAAAAAQBAoAIAAAAAAAAABwAAAAAAAAAAAAAABwAAAAQAAAAAAAAABwAAAAgAAAABABAQAQAAAAAAAAAHAAAAAAAAAAAAAAAHAAAABAAAAAEAQKACAAAAAAAAAAcAAAAEAAAAAAAAAAEAAAAOAAAAAAAAAAcAAAAAAAAAAQAAMAMAAAAAAAAABwAAAAAAAAAAAAAAAQAAABQAAAAAAAAAAQAAABUAAAAAAAAABAAAABgAAAABAACgAgAAAAAAAAAHAAAACAAAAAAAAAABAAAACAAAAAAAAAAHAAAAAAAAAAEAUKACAAAAAAAAAAcAAAAAAAAAAAAAAAEAAAATAAAAAAAAAAcAAAAEAAAAAQAwEAEAAAAAAAAABwAAAAQAAAAAAAAABAAAAAQAAAABAAAQAQAAAAAAAAAHAAAABAAAAAAAAAAEAAAAAAAAAPDw8PAPDw8P//8AAFEAAAUHAA+gOdZPQUx3nEIAAAAAjO4qR1EAAAUIAA+gg/kiPgAAAD/bD8lA2w9JwFEAAAUJAA+gvTeGNs3MTD9mZmY/zcxMPVEAAAUKAA+gzczMPQAAgD8AAAAAzcxMPlEAAAULAA+gmpmZPs3MzD6amRk/MzMzP1EAAAUMAA+gdMlsPv3fWD5WAZo+zczMPVEAAAUNAA+gAAAAPwAAAL8AAIA/AAAgQlEAAAUOAA+gd/RKP2HLKD8AAAAAAACAP1EAAAUPAA+gtxoUP42vWT8AAAAAAACAP1EAAAUQAA+gYAd0P+TFsz4AAAAAAACAPx8AAAIFAACAAAADkB8AAAIAAACQAAgPoAUAAAMAAAGAAAAAoAAAVZATAAACAAACgAAAAIACAAADAAABgAAAVYEAAACABQAAAwAAAYAAAACAAQAAoAEAAAIAAAKAAgAAoFoAAAQAAAGAAADkgAcA5KAHAKqgBAAABAAAAYAAAACACAAAoAgAVaATAAACAAABgAAAAIAEAAAEAAABgAAAAIAIAKqgCAD/oCUAAAIBAAKAAAAAgAUAAAMAAAGAAQBVgAcA/6ATAAACAAABgAAAAIACAAADAAARgAAAAIAJAFWgAgAAAwAAAYAAAACBCQCqoAUAAAMAAAGAAAAAgAQAAKAEAAAEAAAIgAAAAIAKAACgAABVkAUAAAMBAAGAAAAAoAAAAJATAAACAQACgAEAAIACAAADAQABgAEAVYEBAACABQAAAwEAAYABAACAAQAAoAEAAAIBAAqAAgAAoFoAAAQBAAGAAQDkgAcA5KAHAKqgBAAABAEAAYABAACACAAAoAgAVaATAAACAQABgAEAAIAEAAAEAQABgAEAAIAIAKqgCAD/oCUAAAICAAKAAQAAgAUAAAMBAAGAAgBVgAcA/6ATAAACAQABgAEAAIACAAADAQABgAEAAIADAAChAgAAAwEAA4ABAACADQDkoAIAAAMBAAGAAQAAgQ0AqqAFAAADAQABgAEAAIANAP+gWAAABAEAAYABAFWACQAAoAEAAIAFAAADAQACgAEAAIAAAFWQBgAAAgEAAYABAACAEwAAAgIAAYABAFWAAgAAAwEAAoABAFWAAgAAgQUAAAMBAASAAQAAgAEAVYBaAAAEAQABgAEA7oAHAOSgBwCqoAQAAAQBAAGAAQAAgAgAAKAIAFWgEwAAAgEAAYABAACABAAABAEAAYABAACACACqoAgA/6AlAAACAgACgAEAAIAFAAADAQABgAIAVYAHAP+gEwAAAgEAAYABAACABQAAAwEAAYABAACABAAAoAUAAAMBAAGAAQAAgAkA/6AFAAADAQABgAEAAIAGAACgAgAAAwEABoACAACgAADQkFoAAAQBAAKAAQDpgAcA5KAHAKqgBAAABAEAAoABAFWACAAAoAgAVaATAAACAQACgAEAVYAEAAAEAQACgAEAVYAIAKqgCAD/oCUAAAICAAKAAQBVgAUAAAMBAAKAAgBVgAcA/6ATAAACAQACgAEAVYAFAAADAQACgAEAVYABAACABAAABAEAAYABAFWACABVoAEAAIABAAACAAAUgAAAAJAEAAAEAAASgAEAAIAKAACgAACqgEIAAAMCAA+AAADugAAI5KBCAAADAwAPgAAA7YAACOSgBAAABAAAEYABAACACgD/oAAAVYAFAAADAwAPgAMA5IAKAGmgBAAABAIAD4ACAOSACgBpoAMA5IBCAAADAwAPgAAA7IAACOSgBAAABAAAFIABAACACwAAoAAAAIAEAAAEAgAPgAMA5IAQAOSgAgDkgEIAAAMDAA+AAADugAAI5KAEAAAEAAASgAEAAIALAFWgAACqgAQAAAQCAA+AAwDkgA4A5KACAOSAQgAAAwMAD4AAAO2AAAjkoAQAAAQAABGAAQAAgAgAVaAAAFWABAAABAIAD4ADAOSADwDkoAIA5IBCAAADAwAPgAAA7IAACOSgBAAABAAAFIABAACACwCqoAAAAIAEAAAEAgAPgAMA5IAKAGagAgDkgEIAAAMDAA+AAADugAAI5KAEAAAEAAASgAEAAIALAP+gAACqgAQAAAQCAA+AAwDkgA8AxqACAOSAQgAAAwMAD4AAAO2AAAjkoAQAAAQAABGAAQAAgAkAVaAAAFWABAAABAEAEYABAACACQCqoAAAAIBCAAADBAAPgAAA7IAACOSgAQAAAgEAAoAAAP+AQgAAAwAAD4ABAOSAAAjkoAQAAAQBAA+AAwDkgA4AxqACAOSABAAABAEAD4AEAOSAEADGoAEA5IAEAAAEAAAPgAAA5IAKAFqgAQDkgAUAAAMACA+AAADkgAwA5KD//wAAAAAAAAAAAAD/////AAAAAAAAAABwAQAAAAL+//7/NQBDVEFCHAAAAJ8AAAAAAv7/AQAAABwAAAAAAAAgmAAAADAAAAACAAAABAAAAEgAAABYAAAAZ1dvcmxkVmlld1Byb2plY3Rpb24Aq6urAwADAAQABAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB2c18yXzAATWljcm9zb2Z0IChSKSBITFNMIFNoYWRlciBDb21waWxlciA5LjI3Ljk1Mi4zMDIyAFEAAAUEAA+gAACAPwAAAAAAAAAAAAAAAB8AAAIAAACAAAAPkB8AAAIFAACAAQAPkAQAAAQAAA+AAAAkkAQAQKAEABWgCQAAAwAAAcAAAOSAAADkoAkAAAMAAALAAADkgAEA5KAJAAADAAAEwAAA5IACAOSgCQAAAwAACMAAAOSAAwDkoAEAAAIAAAPgAQDkkP//AAD/////AwAAAAAAAAAAAAAAAQAAAA8AAABteVNjcmVlblNvdXJjZQAA")

-- export to mta and writted code by: XaskeL
-- shader code from glsl by: Coolok

CGlitch = {
	GlitchPower = 0.001; -- Glitch Power (0.0f to 1.0f);
	ScreenSize = { guiGetScreenSize() }; -- default screen size

	-- example[1]: CGlitch:destroy()
	-- example[2]: CGlitch.destroy()
	-- function for destroy glitch effects
	destroy = function(self)
		if CGlitch.AlreadyHandlered then
			removeEventHandler('onClientHUDRender', root, CGlitch.draw);
			removeEventHandler('onClientPreRender', root, CGlitch.update);
			CGlitch.AlreadyHandlered = false;
		end
		if self.Shader then
			destroyElement(self.Shader);
			self.Shader = false;
		end
		if self.MyScreenSource then
			destroyElement(self.MyScreenSource);
			self.MyScreenSource = false;
		end
		return true;
	end;
	
	-- function for update screen source
	update = function()
		if CGlitch.MyScreenSource then
			dxUpdateScreenSource(CGlitch.MyScreenSource);
		end
	end;

	-- function for draw glitch effect
	draw = function()
		if CGlitch.Shader then
			dxDrawImage(0, 0, CGlitch.ScreenSize[1], CGlitch.ScreenSize[2], CGlitch.Shader)
		end
		if (CGlitch.fTime and CGlitch.fTime < getTickCount()) then
			CGlitch:destroy();
		end
	end;
	
	-- example [1]: CGlitch:show(500);
	-- example [2]: CGlitch.show(CGlitch, 500); 
	-- params: @self (table CGlitch), 500 (time in milliseconds or false for permanently drawing)
	show = function(self, fTime)
		-- create screen source & shader
		if not self.Shader then
			self.MyScreenSource = dxCreateScreenSource(CGlitch.ScreenSize[1], CGlitch.ScreenSize[2]);
			self.Shader = dxCreateShader(SHADER_CODE);
			-- set default parametres
			dxSetShaderValue(self.Shader, 'GlitchPower', self.GlitchPower);
			dxSetShaderValue(self.Shader, 'myScreenSource', self.MyScreenSource);
		end
		-- set work time
		if fTime then self.fTime = getTickCount() + fTime; else self.fTime = false; end
		-- create event handlers
		if (not self.AlreadyHandlered) then
			addEventHandler('onClientPreRender', root, CGlitch.update);
			addEventHandler('onClientHUDRender', root, CGlitch.draw);
			self.AlreadyHandlered = true;
		end
	end;
};

--[[ example:
	CGlitch:show(500); -- show 500 ms
--]]

--[[ example:
	CGlitch:show(false); -- show permanently
	
	addCommandHandler('disableglitch', function()
		CGlitch:destroy();
	end )
--]]

-- CGlitch:show(500); -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 400, 1) -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 800, 1) -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 1200, 1) -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 800, 1) -- show 500 ms



--[[

local MarkerPos = { x = 2485.861; y = -1659.619; z = 13.336; };
local theMarker = createMarker(MarkerPos.x, MarkerPos.y, MarkerPos.z, "cylinder", 1.5, 255, 255, 0, 170)

addEventHandler('onClientMarkerHit', theMarker, function() 
	CGlitch:show(500); 
end);]]--