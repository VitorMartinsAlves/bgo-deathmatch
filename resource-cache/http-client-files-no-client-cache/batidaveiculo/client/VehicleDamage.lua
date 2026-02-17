--[[
	Name: 101ResourceReleases
	Filename: VehicleDamage.lua
	Author: Sam@ke
--]]

local screenWidth, screenHeight
local player = getLocalPlayer()
local vehicle
local vehicleDamageShader
local screenSource
local impactTimer

local canImpact = "true"
local heartSound
local tinnitusSound
local impactSoundVolume = 0
local blurStrength = 0
local colorFadeValue = 0


addEventHandler("onClientResourceStart", resourceRoot, 
function()
	screenWidth, screenHeight = guiGetScreenSize()
	vehicleDamageShader =  dxCreateShader("res/Shaders/damage.fx")
	screenSource = dxCreateScreenSource(screenWidth, screenHeight)
	
	if (not vehicleDamageShader) or (not screenSource) then
		--outputChatBox("Vehicle damage shader couldnt created! Please use '/debugscript3' for further details.")
	end
end)



function batida()
	--vehicle = player:getOccupiedVehicle()
	
	if (vehicleDamageShader) and (screenSource) then
		screenSource:update()
		
		blurStrength = blurStrength - 0.1
		
		if (blurStrength <= 0) then
			blurStrength = 0
		end
		
		colorFadeValue = colorFadeValue - 0.0025
		
		if (colorFadeValue <= 0) then
			colorFadeValue = 0
		end
		
		impactSoundVolume = impactSoundVolume - 0.005
		
		if (impactSoundVolume <= 0) then
			impactSoundVolume = 0
			
			if (heartSound) and (isElement(heartSound)) then
				heartSound:stop()
			end
		end
		
		if (heartSound) and (isElement(heartSound)) then
			heartSound:setVolume(impactSoundVolume * 3)
		end
		
		if (tinnitusSound) and (isElement(tinnitusSound)) then
			tinnitusSound:setVolume(impactSoundVolume)
		end
		
		vehicleDamageShader:setValue("screenSource", screenSource)
		vehicleDamageShader:setValue("blurStrength", blurStrength)
		vehicleDamageShader:setValue("colorFadeValue", colorFadeValue)
		
		dxDrawImage(0, 0, screenWidth, screenHeight, vehicleDamageShader)
	end
end


addEventHandler("onClientVehicleCollision", root,
function(element, force)
	if (force > 300) then
		if (source == getPedOccupiedVehicle(localPlayer)) and (canImpact == "true") then
			canImpact = "false"
			toggleAllControls(false)
			removeEventHandler("onClientPreRender", root, batida)
			addEventHandler("onClientPreRender", root, batida)
			
		if isTimer(bati) then
		killTimer(bati)
		end
		bati = setTimer(function()
		removeEventHandler("onClientPreRender", root, batida)
		end,6000,1)
		
			if (not impactTimer) then
				impactTimer = setTimer(function()
					canImpact = "true"
					toggleAllControls(true)
					
				end, 4000, 1)
			else
				if (impactTimer) and (impactTimer:isValid()) then
					impactTimer:destroy()
				end
				
				impactTimer = setTimer(function()
					canImpact = "true"
					toggleAllControls(true)
				end, 4000, 1)
			end

			blurStrength = force / 35
			colorFadeValue = 1
			impactSoundVolume = 1
			
			--heartSound = playSound("res/Sounds/heartbeat.ogg", true)
			tinnitusSound = playSound("res/Sounds/tinnitus.ogg", false)
		end
	end
end)

addEventHandler("onClientResourceStop", resourceRoot, 
function()
	if (vehicleDamageShader) then
		vehicleDamageShader:destroy()
	end
	
	if (screenSource) then
		screenSource:destroy()
	end
	
	if (impactTimer) and (impactTimer:isValid()) then
		impactTimer:destroy()
	end
	
	if (heartSound) and (isElement(heartSound)) then
		heartSound:stop()
	end
	
	if (tinnitusSound) and (isElement(tinnitusSound)) then
		tinnitusSound:stop()
	end
	
	--outputChatBox("Vehicle damage shader was stopped!")	
end)