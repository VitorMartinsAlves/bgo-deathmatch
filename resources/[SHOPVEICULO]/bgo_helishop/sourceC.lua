local monitorSize = {guiGetScreenSize()}
local peds = {}
local shopID = 0
local lastCamTick = 0
local currentVehicle = 1
local clientVehicle = false
local camFading = 0
local camID = 1
local startTick = 0
local show = false
local stoped = false
local colorPicker = false
local font = dxCreateFont('files/calibri.ttf', 12)
local font1 = dxCreateFont('files/calibri.ttf', 10)
local font3 = dxCreateFont('files/choice.ttf', 15)
local font2 = dxCreateFont('files/longhaul.ttf', 15)
local panelType = 'bgo_vehicleshop'
local savedVehicleColors = {["all"] = false, ["headlight"] = false}
local blurStrength = 2
local myScreenSource = dxCreateScreenSource(monitorSize[1], monitorSize[2])
local blurShader, blurTec = dxCreateShader("files/BlurShader.fx")

fadeCamera (true)
setCameraTarget(localPlayer)
toggleAllControls(true)

addEventHandler('onClientResourceStart', resourceRoot, function ()
	for index, value in ipairs(shopPos) do 
		peds[index] = createPed(value[1], value[2], value[3], value[4], value[6])
		setElementData(peds[index], 'helishop >> ped', true)
		setElementData(peds[index], 'helishop >> ID', index)
		setElementData(peds[index], "ped >> death", true)
		setElementData(peds[index], "name:tags", "Kereskedő")
		setElementData(peds[index], "Ped:Name", value[5])
		setElementFrozen(peds[index], true)
	end
end)

addEventHandler('onClientClick', root, function(button, state, _, _, worldX,worldY,worldZ, element)
	if button == 'left' and state == 'down' and element and getElementData(element, 'helishop >> ID') or 0 > 0 and not show then 
		local pX,pY,pZ = getElementPosition(getLocalPlayer())
		if getDistanceBetweenPoints3D(pX, pY, pZ, worldX, worldY, worldZ)<=6 then
			shopID = getElementData(element, 'helishop >> ID') or 0
			show = true
			panelType = "bgo_vehicleshop"
			lastCamTick = getTickCount ()
			addEventHandler('onClientPreRender', root, updateCamPosition, true, 'low-5')
			addEventHandler('onClientRender', root, drawPanel3, true, 'low-5')
			toggleAllControls(false)
			camID = 1
			setElementData(localPlayer, 'screen', true)
			showChat(false)
			blurShader, blurTec = dxCreateShader("files/BlurShader.fx")
			startTick = getTickCount ()
			-- // [[ Jármű létrehozás
				clientVehicle = createVehicle(vehicles[currentVehicle][1], shopPos[shopID][7], shopPos[shopID][8], shopPos[shopID][9])
				setVehiclePlateText(clientVehicle, ' ')
			--]]
		end
	elseif button == 'left' and state == 'down' and show then 
		if isMouseInPosition (monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+100-55, 185, 40) then 
			if vehicles[currentVehicle][5] then 
				--if exports.global:canPlayerBuyVehicle(localPlayer) then
					if not vehicles[currentVehicle][6] then 
						if getVehicleLimits(vehicles[currentVehicle][1]) < vehicles[currentVehicle][5] then 
							if (getElementData(localPlayer, 'char:money') or 0) >= vehicles[currentVehicle][2] then
								savedVehicleColors["all"] = {getVehicleColor(clientVehicle, true)}
								setElementData(localPlayer, 'char:money', getElementData(localPlayer, 'char:money') - vehicles[currentVehicle][2])
								setTimer(function()
									triggerServerEvent('bgoMTA->#insertVehicle3', localPlayer, localPlayer, vehicles[currentVehicle][1], vehicles[currentVehicle][2], 'char:money', savedVehicleColors["all"])
								end, 100, 1)
								setElementFrozen(localPlayer, false)
								show = false
								setCameraTarget(localPlayer)
								if isElement(clientVehicle) then
									destroyElement(clientVehicle)
								end
								setElementData(localPlayer, "screen", false)
								showChat(true)
								setElementDimension(localPlayer, 0)
								removeEventHandler('onClientPreRender', root, updateCamPosition, true, 'low-5')
								removeEventHandler('onClientRender', root, drawPanel3, true, 'low-5')
								fadeCamera (true)
								toggleAllControls(true)
								setCameraTarget(localPlayer)
								destroyColorPicker()
							else
								exports.bgo_info:addNotification("Você não tem dinheiro suficiente!","info")
							end
						else
							exports.bgo_info:addNotification("Você não pode comprar este veículo por dinheiro!","info")
						end
					end
				--else
				--	exports.bgo_info:addNotification("Você não tem slots de veículos suficientes!","info")
				--end
			else
				--if exports.global:canPlayerBuyVehicle(localPlayer) then
					if not vehicles[currentVehicle][6] then 
						if (getElementData(localPlayer, 'char:money') or 0) >= vehicles[currentVehicle][2] then
							savedVehicleColors["all"] = {getVehicleColor(clientVehicle, true)}
							-- setElementData(playerSource, 'money', getElementData(playerSource, 'money') - vehicles[currentVehicle][2])
							setElementData(localPlayer, 'char:money', getElementData(localPlayer, 'char:money') - vehicles[currentVehicle][2])
							setTimer(function()
								triggerServerEvent('bgoMTA->#insertVehicle3', localPlayer, localPlayer, vehicles[currentVehicle][1], vehicles[currentVehicle][2], 'char:money', savedVehicleColors["all"])
							end, 100, 1)
							setElementFrozen(localPlayer, false)
							show = false
							setCameraTarget(localPlayer)
							if isElement(clientVehicle) then
								destroyElement(clientVehicle)
							end
							setElementData(localPlayer, "screen", false)
							showChat(true)
							setElementDimension(localPlayer, 0)
							removeEventHandler('onClientPreRender', root, updateCamPosition, true, 'low-5')
							removeEventHandler('onClientRender', root, drawPanel3, true, 'low-5')
							fadeCamera (true)
							toggleAllControls(true)
							setCameraTarget(localPlayer)
							destroyColorPicker()
						else
							exports.bgo_info:addNotification("Você não tem dinheiro suficiente!","info")
						end
					else
						exports.bgo_info:addNotification("Este veículo não pode ser comprado por dinheiro.","info")
					end
				--else
				--	exports.bgo_info:addNotification("Você não tem vagas de veículos suficientes!","info")
				--end
			end
		elseif isMouseInPosition (monitorSize[1]/2-400/2+10+195, monitorSize[2]/2-100/2+100-55, 185, 40) then 
			--if exports.global:canPlayerBuyVehicle(localPlayer) then		
				if (getElementData(localPlayer, 'char:pp')) >= vehicles[currentVehicle][3] then
					-- setElementData(playerSource, 'char:pp', getElementData(playerSource, 'char:pp') - vehicles[currentVehicle][2])
					savedVehicleColors["all"] = {getVehicleColor(clientVehicle, true)}
					--setElementData(localPlayer, 'char:pp', getElementData(localPlayer, 'char:pp') - vehicles[currentVehicle][3])
					setTimer(function()
						triggerServerEvent('bgoMTA->#insertVehicle3', localPlayer, localPlayer, vehicles[currentVehicle][1], vehicles[currentVehicle][3], 'char:pp', savedVehicleColors["all"])
					end, 100, 1)
					setElementFrozen(localPlayer, false)
					show = false
					setCameraTarget(localPlayer)
					if isElement(clientVehicle) then
						destroyElement(clientVehicle)
					end
					setElementData(localPlayer, "screen", false)
					showChat(true)
					setElementDimension(localPlayer, 0)
					removeEventHandler('onClientPreRender', root, updateCamPosition, true, 'low-5')
					removeEventHandler('onClientRender', root, drawPanel3, true, 'low-5')
					fadeCamera (true)
					toggleAllControls(true)
					setCameraTarget(localPlayer)
					destroyColorPicker()
				else
					exports.bgo_info:addNotification("Dinheiro Vip insuficientes!","info")
				end
			--else
			--	exports.bgo_info:addNotification("Você não tem slots de veículos suficientes!","info")
			--end
		elseif isMouseInPosition (monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+125-30, 380, 30) then 
			panelType = "bgo_vehicleshop"
		end
	end
end)

function drawPanel3()
	if panelType == 'bgo_vehicleshop' then 
		Time = (getTickCount() - startTick) / 1300
		Size1 = interpolateBetween(0, 0, 0, 50, 0, 0, Time, 'Linear')
		Size2 = interpolateBetween(0, 0, 0, 300, 0, 0, Time, 'Linear')
		-- [[ Fejléc
			dxDrawRectangle(0, 0, monitorSize[1], Size1, tocolor(0, 0, 0, 240))
			dxDrawRectangle(0, 50, monitorSize[1], Size1-45, tocolor(124, 197, 118, 200))
			dxDrawText('bgoMTA - COMÉRCIO DE HELICÓPTEROS', 10, Size1/2+1, 1, Size1/2, tocolor(0, 0, 0, 255), 1, font2, 'left', 'center', false, false, false, true)
			dxDrawText('#7cc576bgo#ffffffMTA - COMÉRCIO DE HELICÓPTEROS', 10, Size1/2, 0, Size1/2, tocolor(255, 255, 255, 255), 1, font2, 'left', 'center', false, false, false, true)
			dxDrawText('Dinheiro: ' .. formatMoney(getElementData(localPlayer, 'char:money') or 0) .. '     Dinheiro Vip: '.. formatMoney(getElementData(localPlayer, 'char:pp') or 0), monitorSize[1]-11, Size1/2, monitorSize[1]-11, Size1/2, tocolor(0, 0, 0, 255), 1, font, 'right', 'center', false, false, false, true)
			dxDrawText('#fFfFfFDinheiro: #7cc576' .. formatMoney(getElementData(localPlayer, 'char:money') or 0) .. '     #fFfFfFDinheiro Vip: #4183d7'.. formatMoney(getElementData(localPlayer, 'char:pp') or 0), monitorSize[1]-10, Size1/2, monitorSize[1]-10, Size1/2, tocolor(255, 255, 255, 255), 1, font, 'right', 'center', false, false, false, true)
		-- ]]
		-- [[ Lábléc
			local text = ''
			if vehicles[currentVehicle][6] then 
				text = '#fFfFfFDinheiro: #D24D57Não disponível para compra     #fFfFfFDiheiro Vip: #4183d7'.. formatMoney(vehicles[currentVehicle][3])
			else
				text = '#fFfFfFDinheiro: #7cc576'.. formatMoney(vehicles[currentVehicle][2]) .. '     Diheiro Vip: #4183d7'.. formatMoney(vehicles[currentVehicle][3])
			end
			dxDrawRectangle(0, monitorSize[2], monitorSize[1], -Size1, tocolor(0, 0, 0, 240))
			dxDrawText(removeHex(text) , 10, monitorSize[2]-Size1+6, monitorSize[1], monitorSize[2]-Size1+6, tocolor(0, 0, 0, 255), 1, font, 'left', 'top', false, false, false, true)
			dxDrawText(text , 10, monitorSize[2]-Size1+5, monitorSize[1], monitorSize[2]-Size1+5, tocolor(0, 0, 0, 255), 1, font, 'left', 'top', false, false, false, true)
			dxDrawText('<      	'..idg[getElementModel(clientVehicle)] .. '      	>', 1, monitorSize[2]-Size1/2+1, monitorSize[1]+1, monitorSize[2]-Size1/2+1, tocolor(0, 0, 0, 255), 1, font3, 'center', 'center', false, false, false, true)
			dxDrawText('<      	'..idg[getElementModel(clientVehicle)] .. '      	>', 0, monitorSize[2]-Size1/2, monitorSize[1], monitorSize[2]-Size1/2, tocolor(255, 255, 255, 255), 1, font3, 'center', 'center', false, false, false, true)
			if vehicles[currentVehicle][5] then 
				dxDrawText('Limite: '.. getVehicleLimits(vehicles[currentVehicle][1]) .. '/' .. vehicles[currentVehicle][5], 10, monitorSize[2]-Size1+25, monitorSize[1]+1, monitorSize[2]-Size1+20, tocolor(255, 255, 255, 255), 1, font1, 'left', 'top', false, false, false, true)
			end
			dxDrawText("Pressione #FFA700'C' #ffffffPara mudar a cor.", 0, monitorSize[2]-Size1/2, monitorSize[1]-10, monitorSize[2]-Size1/2-15, tocolor(255, 255, 255, 255), 1, font1, 'right', 'center', false, false, false, true)

		-- ]]
	elseif panelType == 'selectPay' then 
		blurCreate()
		dxDrawRectangle(monitorSize[1]/2-400/2, monitorSize[2]/2-100/2, 400, 130, tocolor(0, 0, 0, 160))
		dxDrawRectangle(monitorSize[1]/2-400/2, monitorSize[2]/2-100/2, 400, 25, tocolor(0, 0, 0, 255))
		dxDrawText('Tem certeza de que deseja comprar este veículo?', monitorSize[1]/2-400/2+400/2, monitorSize[2]/2-100/2, monitorSize[1]/2-400/2+400/2, 100, tocolor(124, 197, 118, 255), 1, font, 'center', 'top', false, false, false, true)
		
		local r, g, b = 124, 197, 118
		if vehicles[currentVehicle][6] then 
			r, g, b = 108, 122, 137
		else
			r, g, b = 124, 197, 118
		end
		
		if isMouseInPosition (monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+100-55, 185, 40) then 
			dxDrawRectangle(monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+100-55, 185, 40, tocolor(r, g, b, 255))
		else
			dxDrawRectangle(monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+100-55, 185, 40, tocolor(r, g, b, 200))
		end
		dxDrawText('Dinheiro normal', monitorSize[1]/2-400/2+10+185/2, monitorSize[2]/2-100/2+120-55+20/2, monitorSize[1]/2-400/2+10+185/2, monitorSize[2]/2-100/2+100-55+20/2, tocolor(255, 255, 255, 255), 1, font, 'center', 'center', false, false, false, true)
		
		if isMouseInPosition (monitorSize[1]/2-400/2+10+195, monitorSize[2]/2-100/2+100-55, 185, 40) then 
			dxDrawRectangle(monitorSize[1]/2-400/2+10+195, monitorSize[2]/2-100/2+100-55, 185, 40, tocolor(0, 167, 255, 255))
		else
			dxDrawRectangle(monitorSize[1]/2-400/2+10+195, monitorSize[2]/2-100/2+100-55, 185, 40, tocolor(0, 167, 255, 200))
		end
		dxDrawText('Dinheiro Vip', monitorSize[1]/2-400/2+10+195+185/2, monitorSize[2]/2-100/2+120-55+20/2, monitorSize[1]/2-400/2+10+195+185/2, monitorSize[2]/2-100/2+100-55+20/2, tocolor(255, 255, 255, 255), 1, font, 'center', 'center', false, false, false, true)
		if isMouseInPosition (monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+125-30, 380, 30) then 
			dxDrawRectangle(monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+125-30, 380, 30, tocolor(215, 85, 85, 255))
		else
			dxDrawRectangle(monitorSize[1]/2-400/2+10, monitorSize[2]/2-100/2+125-30, 380, 30, tocolor(215, 85, 85, 200))
		end
		dxDrawText('Voltar ao seletor de veículos', monitorSize[1]/2-400/2+10+380/2, monitorSize[2]/2-100/2+160-30+20/2, monitorSize[1]/2-400/2+10+380/2, monitorSize[2]/2-100/2+100-30+20/2, tocolor(255, 255, 255, 255), 1, font, 'center', 'center', false, false, false, true)
	end
end

addEventHandler("onClientKey", root, function(k,v)
	if not show then return end
	if camID > 1 then 
		if k == "backspace" and v then	
			if panelType == "bgo_vehicleshop" then 
				setElementFrozen(localPlayer, false)
				show = false
				setCameraTarget(localPlayer)
				setElementPosition(localPlayer,1598.273, 1687.71, 10.82)
				if isElement(clientVehicle) then
					destroyElement(clientVehicle)
				end
				setElementData(localPlayer, "screen", false)
				showChat(true)
				setElementDimension(localPlayer, 0)
				removeEventHandler('onClientPreRender', root, updateCamPosition, true, 'low-5')
				removeEventHandler('onClientRender', root, drawPanel3, true, 'low-5')
				fadeCamera (true)
				toggleAllControls(true)
				setCameraTarget(localPlayer)
				destroyColorPicker()
			else
				panelType = "bgo_vehicleshop"
				destroyColorPicker()
			end
		if isTimer(timer) then return end
		timer = setTimer(function() end, 300, 1)
		elseif k == "arrow_l" and v and not stoped and panelType == "bgo_vehicleshop" then 
			if currentVehicle > 1 then
				currentVehicle = currentVehicle - 1
				stoped = true
			else
				currentVehicle = 1				
			end	
			fadeCamera (false,1,0,0,0)
			setTimer(function()
				fadeCamera (true, 2)
				if isElement(clientVehicle) then
					destroyElement(clientVehicle)
				end
				clientVehicle = createVehicle(vehicles[currentVehicle][1], shopPos[shopID][7], shopPos[shopID][8], shopPos[shopID][9])
				setVehiclePlateText(clientVehicle, ' ')
				stoped = false
				camFading = 2
				fadeCamera (true, 2)
				lastCamTick = getTickCount ()
			end , 1000, 1 )
		elseif k == "arrow_r" and v and not stoped and panelType == "bgo_vehicleshop" then 
			if currentVehicle < #vehicles then
				currentVehicle = currentVehicle + 1
				stoped = true
			else
				currentVehicle = 1				
			end
			fadeCamera (false,1,0,0,0)			
			setTimer(function()
				fadeCamera (true, 2)
				if isElement(clientVehicle) then
					destroyElement(clientVehicle)
				end
				clientVehicle = createVehicle(vehicles[currentVehicle][1], shopPos[shopID][7], shopPos[shopID][8], shopPos[shopID][9])
				setVehiclePlateText(clientVehicle, ' ')
				stoped = false
				camFading = 2
				fadeCamera (true, 2)
				lastCamTick = getTickCount ()
			end , 1000, 1 )
		elseif k == "enter" and v and not stoped and panelType == "bgo_vehicleshop" then
			panelType = 'selectPay'
		elseif k == "c" and v and not stoped and panelType == "bgo_vehicleshop" then
			if not colorPicker then 
				colorPicker = true
				-- savedVehicleColors["all"] = {getVehicleColor(clientVehicle, true)}
				createColorPicker(clientVehicle, monitorSize[1]-400-10, monitorSize[2]/2-200/2, 400, 200, "color1")
			else
				colorPicker = false
				destroyColorPicker()
			end
		end
	end
end)

function isMouseInPosition ( x, y, width, height ) 
    if ( not isCursorShowing ( ) ) then 
        return false 
    end 
  
    local sx, sy = guiGetScreenSize ( ) 
    local cx, cy = getCursorPosition ( ) 
    local cx, cy = ( cx * sx ), ( cy * sy ) 
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then 
        return true 
    else 
        return false 
    end 
end 

function getVehicleLimits(vehicleID)
	local ammount = 0
	local breake = false
	for i, v in ipairs (getElementsByType("vehicle")) do
		if getElementModel(v) == vehicleID and v ~= clientVehicle then 
			ammount = ammount + 1
			if ammount > 1 then 
				breake = true
			end
			if ammount == 1 and breake then 
				break
			end
		end
	end
	-- ammount = ammount -1
	return ammount
end

function updateCamPosition ()
	if camPos[camID] then
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = camPos[camID]["speed"]
		local easing = camPos[camID]["type"]
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				local cx,cy,cz = interpolateBetween (
					camPos[camID]["start"][1],camPos[camID]["start"][2],camPos[camID]["start"][3],
					camPos[camID]["end"][1],camPos[camID]["end"][2],camPos[camID]["end"][3],
					progress,easing
				)
				local tx,ty,tz = interpolateBetween (
					camPos[camID]["start"][4],camPos[camID]["start"][5],camPos[camID]["start"][6],
					camPos[camID]["end"][4],camPos[camID]["end"][5],camPos[camID]["end"][6],
					progress,easing
				)
				
				setCameraMatrix (cx,cy,cz,tx,ty,tz)
				
				if camFading == 0 then
					local left = duration-delay
					if left <= 3000 then -- Ez kezd sötétedni
						camFading = 1
						fadeCamera (false,3,0,0,0)
					end
				elseif camFading == 2 then -- színezett
					local left = duration-delay
					if left >= 2000 then
						camFading = 0
					end
				end
			else
				local nextID = false
				
				while nextID == false do
					local id = camID + 1
					if id ~= camID then
						nextID = id
					end
					if id > # camPos then 
						nextID = 2
					end
				end
				
				camFading = 2
				fadeCamera (true, 2)
				lastCamTick = getTickCount ()
				camID = nextID
				
				setCameraMatrix (camPos[camID]["start"][1],camPos[camID]["start"][2],camPos[camID]["start"][3],camPos[camID]["start"][4],camPos[camID]["start"][5],camPos[camID]["start"][6])
			end
		end
	end
end

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (digits and string.rep("%x", digits) or "%x+"), "")
end

function blurCreate()
    if (blurShader) then
		dxUpdateScreenSource(myScreenSource)
			
		dxSetShaderValue(blurShader, "ScreenSource", myScreenSource);
		dxSetShaderValue(blurShader, "BlurStrength", blurStrength);
		dxSetShaderValue(blurShader, "UVSize", monitorSize[1], monitorSize[2]);

		dxDrawImage(0, 0, monitorSize[1], monitorSize[2], blurShader)
    end
end

function formatMoney(amount)
	local formatted = tonumber(amount)
	if formatted then
		while true do  
			formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if (k==0) then
			break
		end
	end
		return formatted
	else
		return amount
	end
end

addEventHandler("onClientPlayerStealthKill", getRootElement(), function(targetPlayer) 
	if (getElementType(targetPlayer) == 'ped' and getElementData(targetPlayer, "ped >> death")) then  
		cancelEvent()
	end
end)