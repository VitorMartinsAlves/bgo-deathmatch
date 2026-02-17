dgs = exports.dgs
local LABEL_OFFSET = 0.80	-- Label Offset from Disk Pickup
local restrictions = {}		-- Restriction Table for Gridlist
local weap_restrict = {}	-- Restriction Table for Weapons List
local sourcePickup			-- The current associated pickup

addEvent("onClientVehicleRent2", true)
addEvent("onClientRentalVehicleHide2", true)

-- Location Data
----------------->>

function renderPickupNames()
	for i,pickup in ipairs(getElementsByType("pickup", resourceRoot, true)) do
		local px, py, pz = getCameraMatrix()
		local name = getElementData(pickup, "name")
		local color = split(getElementData(pickup, "color"), ",")
		if (name and color) then			
			local tx, ty, tz = getElementPosition(pickup)
			tz = tz + LABEL_OFFSET
			local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
			if (dist < 15) then
				if (isLineOfSightClear(px, py, pz, tx, ty, tz, true, true, false, true, true, false, false)) then
					local x,y = getScreenFromWorldPosition(tx, ty, tz)
					if (x) then
						local tick = getTickCount()/360
						local hover = math.sin(tick) * 10
						dxDrawText(name, x+1, y+1+hover, x+1, y+1+hover, tocolor(0,0,0), 1, "clear", "center", "center")
						dxDrawText(name, x, y+hover, x, y+hover, tocolor(color[1],color[2],color[3]), 1, "clear", "center", "center")
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, renderPickupNames)

-- Display Rental Panel
------------------------>>

function displayRentPanel(vehicleTbl, weaponsTbl, hasRental, ownedWeapons)
	sourcePickup = source
		-- Compile Vehicle Gridlist
	dgs:dgsGridListClear(rentalGUI.gridlist[1])
	for i,v in ipairs(vehicleTbl) do
		local vehicleID = v[1]
		local row = dgs:dgsGridListAddRow(rentalGUI.gridlist[1])
		dgs:dgsGridListSetItemText(rentalGUI.gridlist[1], row, 1, vehicleID, false, true)
		local vehicleName = getVehicleNameFromModel(tonumber(vehicleID))
		dgs:dgsGridListSetItemText(rentalGUI.gridlist[1], row, 2, vehicleName, false, false)
		--local hr_cost = v[4]
		--dgs:dgsGridListSetItemText(rentalGUI.gridlist[1], row, 3, (v[5] and "$"..exports.bgo_util:tocomma(hr_cost).."/hr" or "Free"), false, false)
		-- Turn non-selectable items red
		if (not v[2]) then
			for col=1,3 do
				dgs:dgsGridListSetItemColor(rentalGUI.gridlist[1], i-1, col, 255, 25, 25)
			end
		end
		
		restrictions[row] = v[3]
	end

	
	if (hasRental) then
		dgs:dgsSetEnabled(rentalGUI.button[2], true)
		dgs:dgsSetEnabled(rentalGUI.button[4], true)
		dgs:dgsSetEnabled(rentalGUI.button[5], true)
	else
		dgs:dgsSetEnabled(rentalGUI.button[2], false)
		dgs:dgsSetEnabled(rentalGUI.button[4], false)
		dgs:dgsSetEnabled(rentalGUI.button[5], false)
	end
	
	dgs:dgsSetText(rentalGUI.label[2], "")
	dgs:dgsSetVisible(rentalGUI.window[1], true)
	
	dgs:dgsSetAlpha(rentalGUI.window[1],0)
	dgs:dgsAlphaTo(rentalGUI.window[1],200,false,"OutQuad",600)
	
	--dgs:dgsMoveTo(rentalGUI.window[1],sX, sY,false,false,"OutQuad",600)
		
		
	showCursor(true)
end
addEvent("GTIrentalUI.displayRentPanel2", true)
addEventHandler("GTIrentalUI.displayRentPanel2", root, displayRentPanel)

--[[
function closer()
	if isElement(rentalGUI.window[1]) then
	--removeEventHandler("onDgsWindowClose",rentalGUI.window[1],closer)
	playSoundFrontEnd(20)
	dgs:dgsSetVisible(rentalGUI.window[1], false)
	--showCursor(false)
	end
end
addEventHandler("onDgsWindowClose",rentalGUI.window[1],closer)
]]--



function hideRentPanel(button, state)
	if (button ~= "left" or state ~= "up") then return end
	restrictions = {}
	dgs:dgsSetVisible(rentalGUI.window[1], false)
	showCursor(false)
end
addEventHandler("onDgsMouseClick", rentalGUI.button[3], hideRentPanel, false)
--addEventHandler("onDgsMouseClick", rentalGUI.button[6], hideRentPanel, false)

addEventHandler("onClientVehicleRent", root, function()
	hideRentPanel("left", "up")
end)

addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", localPlayer, function()
	hideRentPanel("left", "up")
end)

-- Update Permissions
---------------------->>

function updateVehiclePerm(button)
	if (button ~= "left") then return end
	
	local row,col = dgs:dgsGridListGetSelectedItem(rentalGUI.gridlist[1])
	if (not row or row == -1) then return end
	
	local rstn = restrictions[row]
	local rString = ""
	if (rstn) then
		for i,v in ipairs(restrictions[row]) do
			local rstns = split(v, ";")
			if (rString == "") then
				rString = "L"..rstns[2].." "..rstns[1].."s"
			else
				rString = rString..", L"..rstns[2].." "..rstns[1].."s"
			end
		end
		dgs:dgsSetText(rentalGUI.label[2], "Este veículo é restrito aos seguintes grupos:\n"..rString)
	else
		dgs:dgsSetText(rentalGUI.label[2], "")
	end	
end
addEventHandler("onDgsMouseClick", rentalGUI.gridlist[1], updateVehiclePerm, false)

-- Rent Vehicle
---------------->>

function rentVehicleToPlayer(button, state)
	--if (button ~= "left") then return end
	if (button ~= "left" or state ~= "up") then return end
	local row,col = dgs:dgsGridListGetSelectedItem(rentalGUI.gridlist[1])
	if (not row or row == -1) then return end
	local id = dgs:dgsGridListGetItemText(rentalGUI.gridlist[1], row, 1)
	triggerServerEvent("GTIrentalUI.rentVehicleToPlayer2", resourceRoot, tonumber(id), sourcePickup)
	dgs:dgsSetVisible(rentalGUI.window[1], false)
	showCursor(false)
end
addEventHandler("onDgsMouseClick", rentalGUI.button[1], rentVehicleToPlayer, false)

-- Return Vehicle
------------------>>

function returnVehicle(button, state)
	if (button ~= "left") then return end
	triggerServerEvent("GTIrentalUI.returnVehicle2", resourceRoot)
	dgs:dgsSetEnabled(rentalGUI.button[2], false)
	dgs:dgsSetEnabled(rentalGUI.button[4], false)
	dgs:dgsSetEnabled(rentalGUI.button[5], false)
	dgs:dgsSetVisible(rentalGUI.window[1], false)
	showCursor(false)
end
addEventHandler("onDgsMouseClick", rentalGUI.button[2], returnVehicle, false)


function gpsVehicle(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIrentalUI.gpsseguro", localPlayer, localPlayer)
	dgs:dgsSetEnabled(rentalGUI.button[2], false)
	dgs:dgsSetEnabled(rentalGUI.button[4], false)
	dgs:dgsSetEnabled(rentalGUI.button[5], false)
	dgs:dgsSetVisible(rentalGUI.window[1], false)
	showCursor(false)
end
addEventHandler("onDgsMouseClick", rentalGUI.button[4], gpsVehicle, false)

function seguroVehicle(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local oldCash = getElementData(localPlayer, "char:money") or 0
	if 	oldCash > 5000 then
	triggerServerEvent("GTIrentalUI.seguroVehicle", localPlayer, localPlayer)
	dgs:dgsSetEnabled(rentalGUI.button[2], false)
	dgs:dgsSetEnabled(rentalGUI.button[4], false)
	dgs:dgsSetEnabled(rentalGUI.button[5], false)
	dgs:dgsSetVisible(rentalGUI.window[1], false)
	showCursor(false)
	else
	triggerEvent("bgo>info", localPlayer,"BGO seguro", "Você não tem 5 mil reais para acionar o seguro!", "erro")	
	end
end
addEventHandler("onDgsMouseClick", rentalGUI.button[5], seguroVehicle, false)

