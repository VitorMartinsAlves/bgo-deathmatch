-- 'main parameters'
root = getRootElement()
player = getLocalPlayer()
vehicle = nil
 
 
-- 'round value'
function roundValue(value)
    local var = math.floor((value) + 0.5)
    return var
end
 

 
 
 
-- CAMBIO DO VEICULO
 
function getVehicleGear()   
    if (vehicle) then
        local vehicleGear = getVehicleCurrentGear(vehicle)
       
        return tonumber(vehicleGear)
    else
        return 0
    end
end
 
 
function getFormattedVehicleGear()
    local gear = getVehicleGear()
    local rearString = "R"
   
    if (gear > 0) then
        return gear
    else
        return rearString
    end
end
--====================================================================================
-- FUN??O DO CONTA GIROS

--====================================================================================

g_Player = getLocalPlayer()
function getVehicleSpeed()
    if isPedInVehicle(g_Player) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(g_Player))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 187.5
    end
    return 0
end
function getElementSpeed(element,unit)
    assert(isElement(element), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(element) .. ")")
    assert(getElementType(element) == "player" or getElementType(element) == "ped" or getElementType(element) == "object" or getElementType(element) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(element) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(element)) * mult).length
end

 
local screenWidth, screenHeight = guiGetScreenSize()
 
 
-- 'fonts'
local myFont = dxCreateFont( "font/opensans.ttf", 30 )
--local myFont2 = dxCreateFont( "files/bitsu.ttf", 7 )
local myFont3 = dxCreateFont( "font/Prototype.ttf", 17 )
--local myFont4 = dxCreateFont( "files/aero.ttf", 11 )
--local myFont5 = dxCreateFont( "files/aero.ttf", 9 )
 
 
local sx,screenH = guiGetScreenSize()
local resW, resH = 1280, 720
local x, y =  (sx/resW), (screenH/resH)
 
 
--local screenW,screenH = guiGetScreenSize()
--resW, resH = 1366,768
--sx,sy = (screenW/resW), (screenH/resH)





--  'Alpha'
local textAlpha = 255
 
fadeIn = false
function checkApha()
  if textAlpha < 100 then
    fadeIn = true
  elseif textAlpha >= 200 and textAlpha <= 255 and fadeIn == true then
    fadeIn = false
  end
end

		
			
local doDraw_Speed = true

local desligado = false
local screenX, screenY = guiGetScreenSize ( );
local maxAngle = 180;

local open = false
local moving = false
local moving2 = false
teste = false
local screenWidth = sx+300

local screenWidth2 = sx+1

local moveSpeed = 10

local moveSpeed2 = 9.5

function setSpeedoOpen ( bool )
	if bool and not open and isPedInVehicle ( localPlayer ) then
		open = true
		moving = true
		--moving2 = true
		addEventHandler ( "onClientRender", root, VelocimetroSZ )
	elseif not bool and open then
		moving = true
		--moving2 = true
	end
end

function veloHUD()
	if ( isPlayerMapVisible (  ) ) then
		return
	end
		if ( moving2 ) then
			if (isPedInVehicle ( localPlayer ) ) then
				if ( screenWidth2 ~= sx - 270 ) then
					if ( screenWidth2 > sx - 270 ) then
						screenWidth2 = screenWidth2 - moveSpeed2
					else
						screenWidth2 = sx - 270
						moving2 = false
					end
				end
			else
				if ( screenWidth2 < sx + 1 ) then
					screenWidth2 = screenWidth2 + moveSpeed2
				else
					moving2 = false
				end
			end
		end


	
			local pArmor = getPedArmor(localPlayer)
		if pArmor > 100 then 
			pArmor = pArmor / 2 
		end 
		
		local pHealth = getElementHealth(localPlayer) 
		if pHealth > 100 then 
			pHealth = pHealth / 2 
		end 

        dxDrawImage(roundValue(screenWidth2 - 260), roundValue(screenHeight - 265), 250, 290, "img/vida.png", 0, 0, 0, tocolor(255, 255, 255 , 190), false)
		
		dxDrawRectangle(roundValue(screenWidth2 - 196), roundValue(screenHeight - 162), 126*(pHealth/100), 20, tocolor(255, 0, 0, 155))
		dxDrawRectangle(roundValue(screenWidth2 - 196), roundValue(screenHeight - 115), 126*(pArmor/100), 20, tocolor(255, 255, 255, 155))
end
--addEventHandler ( "onClientRender", root, veloHUD )

function VelocimetroSZ()
if open then 
	if ( isPlayerMapVisible (  ) ) then
		return
	end

	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		if vehicle then
		
		if getVehicleType(vehicle) == 'Boat' then return end
		
		
			vehicleSpeed = getElementSpeed(vehicle,1)
			fuel = tonumber ( getElementData ( vehicle, "veh:fuel" ) ) or 0
			teste = true

			if not getVehicleEngineState ( vehicle, true ) then
				desligado = true
			else
				desligado = false
			end
		else
			vehicleSpeed = 0 
			fuel = 0 
			teste = false
		end

		if ( not doDraw_Speed ) then return end
		if ( moving ) then
			if (isPedInVehicle ( localPlayer ) ) then
				if ( screenWidth ~= sx - 10 ) then
					if ( screenWidth > sx - 10 ) then
						screenWidth = screenWidth - moveSpeed
					else
						screenWidth = sx - 10
						moving = false
					end
				end
			else
				if ( screenWidth < sx + 300 ) then
					screenWidth = screenWidth + moveSpeed
				else
					open = false
					moving = false
					desligado = false
					removeEventHandler ( 'onClientRender', root, VelocimetroSZ )
				end
			end
		end

		if desligado  then
			dxDrawText("VEICULO DESLIGADO \n'J' PARA LIGAR", screenWidth - 150, screenHeight - 143, screenWidth - 160, screenHeight - 115, tocolor(0, 0, 0, 255), 1, myFont3, "center", "top", false, false, true)
			dxDrawText("VEICULO DESLIGADO \n'J' PARA LIGAR", screenWidth - 150, screenHeight - 145, screenWidth - 160, screenHeight - 115, tocolor(255, 255, 255, 255), 1, myFont3, "center", "top", false, false, true)
		else
		

-- FUNDO DO VELOCIMETRO
        dxDrawImage(roundValue(screenWidth - 260), roundValue(screenHeight - 245), 250, 250, "img/speedo1.png", 0, 0, 0, tocolor(255, 255, 255 , 180), true)
-- CONTA GIROS
		dxDrawImage(roundValue(screenWidth - 260), roundValue(screenHeight - 238), 250, 250, "img/needle1.png", (vehicleSpeed/1.55)-116, 0, 0, tocolor(255, 255, 255 , 255), true)	
-- VELOCIDADE
		local getSpeed = string.format("%03d",vehicleSpeed)
        dxDrawText(getSpeed.."\n "..math.floor(fuel).."%", screenWidth - 106, screenHeight - 118, screenWidth - 158, screenHeight - 115, tocolor(0, 0, 0, 255), 0.7, myFont, "center", "top", false, false, true)
        dxDrawText(getSpeed.."\n "..math.floor(fuel).."%", screenWidth - 106, screenHeight - 120, screenWidth - 160, screenHeight - 115, tocolor(255, 255, 255, 255), 0.7, myFont, "center", "top", false, false, true)
-- CAMBIO

--[[
		local cambio = getFormattedVehicleGear()
		local neutro = math.floor(vehicleSpeed)
        if neutro > 0 then
			dxDrawText(cambio, screenWidth - 383, screenHeight - 83, screenWidth - 160, screenHeight - 115, tocolor(0, 0, 0, 255), 1, myFont3, "center", "top", false, false, true)
			dxDrawText(cambio, screenWidth - 380, screenHeight - 85, screenWidth - 160, screenHeight - 115, tocolor(255, 255, 255, 255), 1, myFont3, "center", "top", false, false, true)
        else
			dxDrawText("N", screenWidth - 383, screenHeight - 83, screenWidth - 160, screenHeight - 115, tocolor(0, 0, 0, 255), 1, myFont3, "center", "top", false, false, true)
			dxDrawText("N", screenWidth - 385, screenHeight - 85, screenWidth - 160, screenHeight - 115, tocolor(255, 255, 255, 255), 1, myFont3, "center", "top", false, false, true)
		end ]]--
		
		if teste then
		local time = 8.110
		if fadeIn == false then
		textAlpha = textAlpha - time
		elseif fadeIn == true then
		textAlpha = textAlpha + time
		end
		checkApha()	
-- SETA ESQUERDA
		if(getElementData ( vehicle, 'i:left' )) then   
        dxDrawImageSection(roundValue(screenWidth - 174), roundValue(screenHeight - 42), 28, 18, 10, -2, 28, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, textAlpha), true)
		else
        dxDrawImageSection(roundValue(screenWidth - 174), roundValue(screenHeight - 42), 28, 18, 10, -2, 28, 18, "img/icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
-- SETA DIREITA
		if(getElementData ( vehicle, 'i:right' )) then
        dxDrawImageSection(roundValue(screenWidth - 123), roundValue(screenHeight - 42), 28, 18, 61, -2, 28, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, textAlpha), true)       
		else
        dxDrawImageSection(roundValue(screenWidth - 123), roundValue(screenHeight - 42), 28, 18, 61, -2, 28, 18, "img/icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) 
		end
-- FREIO DO VEICULO
		if isElementFrozen( vehicle ) then   
        dxDrawImageSection(roundValue(screenWidth - 144), roundValue(screenHeight - 42), 18, 18, 40, -2, 18, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		else
        dxDrawImageSection(roundValue(screenWidth - 144), roundValue(screenHeight - 42), 18, 18, 40, -2, 18, 18, "img/icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
-- PORTA TRANCADA
		if isVehicleLocked( vehicle ) or ( getElementData( vehicle, "cl_vehiclelocked" ) ) then 
        dxDrawImageSection(roundValue(screenWidth - 194), roundValue(screenHeight - 22), 28, 18, -10, 18, 28, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		else
        dxDrawImageSection(roundValue(screenWidth - 194), roundValue(screenHeight - 22), 28, 18, -10, 18, 28, 18, "img/icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		--[[
-- MOTOR DO VEICULO
		if getVehicleEngineState ( vehicle ) then     
        dxDrawImageSection(roundValue(screenWidth - 161), roundValue(screenHeight - 22), 28, 18, 23, 18, 28, 18, "img/icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) 
		else
		dxDrawImageSection(roundValue(screenWidth - 161), roundValue(screenHeight - 22), 28, 18, 23, 18, 28, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)     
		end]]--
		
-- VIDRO DO CARRO       
   --     dxDrawImageSection(roundValue(screenWidth - 135), roundValue(screenHeight - 22), 28, 18, 50, 18, 28, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
-- FAROL DO VEICULO     
		if getVehicleOverrideLights ( vehicle ) ~= 2 then
        dxDrawImageSection(roundValue(screenWidth - 104), roundValue(screenHeight - 22), 28, 18, 80, 18, 28, 18, "img/icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) 
		else
        dxDrawImageSection(roundValue(screenWidth - 104), roundValue(screenHeight - 22), 28, 18, 80, 18, 28, 18, "img/iconglow.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)     
		end  
		
		--if not fuel then return false end
		--local fuel = math.floor(fuel)
	end
end
	else
		open = false
	end
end

addEventHandler ( "onClientResourceStart", resourceRoot, function ( )
	if ( isPedInVehicle ( localPlayer ) ) then
		setSpeedoOpen ( true )
	end
end )

addEventHandler ( "onClientPlayerVehicleEnter", root, function ( car )
	if ( source == localPlayer ) then
		setSpeedoOpen ( true )
	end
end ) addEventHandler ( "onClientVehicleStartExit", root, function ( source2 )
	if ( source2 == localPlayer ) then
		setSpeedoOpen ( false )
	end
end ) addEventHandler ( "onClientPlayerWasted", root, function ( )
	if ( source == localPlayer ) then
		setSpeedoOpen ( false )
	end
end )




 
 
function playSoundPlayerVehicle (player)
    local theVehicle = getPedOccupiedVehicle(localPlayer)
    if theVehicle and getVehicleController(theVehicle) == localPlayer then
                sound = playSound("files/starter.mp3")
                --setSoundMaxDistance(sound, 10)
        end
end
addEvent( "playSoundPlayerVehicle", true )
addEventHandler( "playSoundPlayerVehicle", getLocalPlayer(), playSoundPlayerVehicle)

