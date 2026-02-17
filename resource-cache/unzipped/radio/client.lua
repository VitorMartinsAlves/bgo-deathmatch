local streamedInRadios = {}
local sx, sy = guiGetScreenSize()
local added, selected, px, py, onVolumeChange, scrollState

local render = function()
	if selected then
		local data = streamedInRadios[selected]
		if not data then return end

		dxDrawRectangle(sx*px-150, sy*py-100, 300, 245, 0xff5e5e5e)
		dxDrawRectangle(sx*px-150, sy*py-100, 300, 20, 0xff4a4a4a)
		dxDrawText("Radio", sx*px-145, sy*py-100, sx*px+145, sy*py-80, 0xffdadada, 1, "default-bold", "left", "center")
		dxDrawText("✘", sx*px-145, sy*py-100, sx*px+145, sy*py-80, cursorInZone(sx*px-145, sy*py-100, sx*px+145, sy*py-80) and 0xffa32727 or 0xffdadada, 1, "default-bold", "right", "center")

		dxDrawRectangle(sx*px-100, sy*py-70, 200, 30, 0xff4a4a4a)
		dxDrawRectangle(sx*px-100, sy*py-70, 200*data.volume, 30, 0xff497ac9)
		dxDrawText(math.floor(data.volume*100).."%", sx*px-100, sy*py-70, sx*px+100, sy*py-40, 0xffdadada, 1.2, "default-bold", "center", "center")
		dxDrawText("◄", sx*px-140, sy*py-70, sx*px-110, sy*py-40, cursorInZone(sx*px-140, sy*py-60, sx*px-110, sy*py-30) and 0xffb0b0b0 or 0xffdadada, 2.5, "default-bold", "right", "center")
		dxDrawText("►", sx*px+110, sy*py-70, sx*px+140, sy*py-40, cursorInZone(sx*px+110, sy*py-60, sx*px+140, sy*py-30) and 0xffb0b0b0 or 0xffdadada, 2.5, "default-bold", "left", "center")

		dxDrawRectangle(sx*px-141, sy*py-31, 282, 127, 0xff4a4a4a)
		
		local j = 0
		for i, station in ipairs(SETTINGS.STATIONS) do
			if i > scrollState and i <= 5+scrollState then
				local offset = j * 25
				local color  = (data.station == i) and 0xff698abf or (cursorInZone(sx*px-130, sy*py-30+offset, sx*px+130, sy*py-5+offset) and 0xff8ba9d9 or (i % 2 == 1 and 0xff666666 or 0xff555555))
				dxDrawRectangle(sx*px-140, sy*py-30+offset, 280, 25, color)
				dxDrawText(station[1], sx*px-130, sy*py-30+offset, sx*px+130, sy*py-5+offset, 0xffdadada, 1, "default-bold", "left", "center")
				j = j + 1
			end
		end
		if #SETTINGS.STATIONS > 5 then
			local scrollHeight = 125 * (5 / #SETTINGS.STATIONS)
			local scrollOffset = scrollState * ((125 - scrollHeight) / (#SETTINGS.STATIONS - 5))
			dxDrawRectangle(sx*px+135, sy*py-30, 5, 125, 0xffb0b0b0)
			dxDrawRectangle(sx*px+135, sy*py-30+scrollOffset, 5, scrollHeight, 0xffdadada)
		end

		if isCursorShowing() and onVolumeChange then
			local cx = getCursorPosition()
			local percentage = (sx*cx - (sx*px-100)) / 200
			data.volume = math.max(0, math.min(1, percentage))
			data.sound:setVolume(data.volume)
		end

		dxDrawText(SETTINGS.STATIONS[data.station][1], sx*px-145, sy*py-100, sx*px+145, sy*py-80, 0xffdadada, 1.2, "default-bold", "center", "center")
		
		dxDrawRectangle(sx*px-140, sy*py+105, 280, 30, cursorInZone(sx*px-140, sy*py+105, sx*px+140, sy*py+135) and 0xffb0b0b0 or 0xffdadada)
		dxDrawText(data.attachto and "TURN OFF" or "PICKUP", sx*px-140, sy*py+105, sx*px+140, sy*py+135, 0xff4a4a4a, 1.3, "default-bold", "center", "center")
	end
end

local infoRender = function()
	local px, py, pz = getElementPosition(localPlayer)
	local vehicle    = localPlayer:getOccupiedVehicle()
	
	for object, v in pairs(streamedInRadios) do
		if not v.attachto or v.attachto[1] ~= vehicle then
			local x, y, z  = getElementPosition(object)
			local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
			
			if distance < 10 then
				local screenX, screenY = getScreenFromWorldPosition(x, y, z + 0.35)		
				
				if screenX and screenY then
					local stationName = SETTINGS.STATIONS[v.station][1]
					dxDrawText(stationName, screenX+1, screenY+1, screenX+1, screenY+1, 0xff222222, 1.2, "default-bold", "center", "center")
					dxDrawText(stationName, screenX, screenY, screenX, screenY, 0xffdadada, 1.2, "default-bold", "center", "center")
					
					if SETTINGS.SHOW_SOUND_WAVES then
						local waveData = getSoundWaveData(v.sound, 256)
						
						if waveData then
							for i = 0, 15 do
								local wave_avg = 0
								for j = i*16, (i+1)*16 do
									wave_avg = wave_avg + math.abs(waveData[math.min(255, j)])
								end
								dxDrawRectangle(screenX+i*8-64, screenY-10, 8, wave_avg/16 * (-64 * v.volume))
							end
						end
					end
				end
			end
		end
	end
end



local samples = 256

function renderWave ()
    if (isElement (localPlayer)) then
        local waveData = getSoundWaveData (localPlayer, samples)
        for i=0, samples-1 do
            if (waveData) then -- Avoid NaN values.
                dxDrawRectangle (i, 128, 1, math.abs (waveData[i]) * 128)
            end
        end
    end
end
addEventHandler ("onClientRender", root, renderWave)



local scrolling = function(key)
    if key == "mouse_wheel_up" then
        scrollState = math.max(0, scrollState - 1)
    else
        scrollState = math.min(#SETTINGS.STATIONS-5, scrollState + 1)
    end
end

toggleRadioPanel = function(radio)
	if selected then
		selected = nil
		removeEventHandler("onClientHUDRender", root, render)
        unbindKey("mouse_wheel_up",   "down", scrolling)
        unbindKey("mouse_wheel_down", "down", scrolling)
		showCursor(false)
	else
		selected    = radio
		px, py	    = 0.5, 0.5
		scrollState = 0
		if isCursorShowing() then px, py = getCursorPosition() end
		addEventHandler("onClientHUDRender", root, render)
        bindKey("mouse_wheel_up",   "down", scrolling)
        bindKey("mouse_wheel_down", "down", scrolling)
		showCursor(true)
	end
end
addEvent("toggleRadioPanel", true)
addEventHandler("toggleRadioPanel", resourceRoot, toggleRadioPanel)

local onClientClick = function(button, state, _, _, _, _, _, element)
	if button == "right" and state == "up" and not selected and element and streamedInRadios[element] then
		toggleRadioPanel(element)

	elseif button == "left" and selected then
		if state == "up"  then
			if onVolumeChange then
				onVolumeChange = nil
				triggerServerEvent("setRadioVolume", selected, streamedInRadios[selected].volume)
			
			elseif cursorInZone(sx*px-145, sy*py-100, sx*px+145, sy*py-80) then -- close
				Sound("click.wav")
				return toggleRadioPanel()

			elseif cursorInZone(sx*px-140, sy*py+105, sx*px+140, sy*py+135) then -- pickup
				Sound("click.wav")
				triggerServerEvent("pickupRadio", selected)
				return toggleRadioPanel()

			elseif cursorInZone(sx*px-140, sy*py-70, sx*px-110, sy*py-40) then -- prev station
				Sound("click.wav")
				return triggerServerEvent("changeRadioStation", selected, "prev")
			elseif cursorInZone(sx*px+110, sy*py-70, sx*px+140, sy*py-40) then -- prev station
				Sound("click.wav")
				return triggerServerEvent("changeRadioStation", selected, "next")
			end
			
			local j = 0
			for i, station in ipairs(SETTINGS.STATIONS) do
				if i > scrollState and i <= 5+scrollState then
					local offset = j * 25
					
					if cursorInZone(sx*px-130, sy*py-30+offset, sx*px+130, sy*py-5+offset) then
						return triggerServerEvent("changeRadioStation", selected, i)
					end
					j = j + 1
				end
			end
			
		elseif state == "down" then
			if cursorInZone(sx*px-100, sy*py-70, sx*px+100, sy*py-40) then -- volume change
				onVolumeChange = true
			end
		end
	end
end


addEventHandler("onClientResourceStart", resourceRoot, function()
	local parent = Element.getByID("radio_parent")
	

	addEvent("receiveRadioDetails", true)
	addEventHandler("receiveRadioDetails", parent, function(received)
		if isElementStreamedIn(source) then
			local old		= streamedInRadios[received.object]
			received.sound	= old and old.sound or nil
		
			if old and old.station ~= received.station then old.sound:destroy() end
		
			if not old or not isElement(old.sound) then
				received.sound = Sound3D(SETTINGS.STATIONS[received.station][2], getElementPosition(received.object))
				received.sound:setMaxDistance(SETTINGS.SOUND_RADIUS)
				received.sound:attach(received.object)
			end
			received.sound:setVolume(received.volume)
			streamedInRadios[received.object] = received
		end
	end)


	local unloadRadio = function(element)
		if streamedInRadios[element] then
			streamedInRadios[element].sound:destroy()
			streamedInRadios[element] = nil
			
			if selected and selected == element then toggleRadioPanel() end
			
			if added and #getElementsByType("object", parent, true) <= 0 then
				removeEventHandler("onClientClick",  root, onClientClick)
				removeEventHandler("onClientRender", root, infoRender)
				added = nil
			end
		end
	end

	addEventHandler("onClientElementStreamIn", parent, function()
		triggerServerEvent("requestRadioDetails", source)
		
		if not added and #getElementsByType("object", parent, true) > 0 then
			addEventHandler("onClientClick",  root, onClientClick)
			addEventHandler("onClientRender", root, infoRender)
			added = true
		end
	end)

	addEventHandler("onClientElementStreamOut", parent, function()
		unloadRadio(source)
	end)

	addEvent("onRadioPickup", true)
	addEventHandler("onRadioPickup", parent, function()
		unloadRadio(source)
	end)
end)

cursorInZone = function(x, y, ex, ey)
	if not isCursorShowing() then return false end
	local cx, cy = getCursorPosition()
	return sx*cx >= x and sx*cx <= ex and sy*cy >= y and sy*cy <= ey
end

local getVehicleAttachOffset = function(vehicle)
	local _, _, _, _, _, y = vehicle:getBoundingBox()
	return {vehicle, 0, 0, y}
end

local radio = function()
	local vehicle = localPlayer:getOccupiedVehicle()
	
	-- close your eyes here
	for object, v in pairs(streamedInRadios) do
		if v.owner == localPlayer then
			if v.attachto then
				if vehicle then
					if vehicle == v.attachto[1] then
						return toggleRadioPanel(v.object)
					else
						return triggerServerEvent("moveRadio", v.object, "attach", getVehicleAttachOffset(vehicle))
					end
				else
					local x, y, z = getElementPosition(localPlayer)
					return triggerServerEvent("moveRadio", v.object, "ground", {x, y, z-1})
				end
			else
				if vehicle then
					return triggerServerEvent("moveRadio", v.object, "attach", getVehicleAttachOffset(vehicle))
				else
					return toggleRadioPanel(v.object)
				end
			end
			break
		end
	end

	triggerServerEvent("placeRadio", localPlayer, vehicle and getVehicleAttachOffset(vehicle))
end

if SETTINGS.COMMAND then addCommandHandler(SETTINGS.COMMAND, radio) end
if SETTINGS.BIND    then bindKey(SETTINGS.BIND, "up", radio)        end