DGS = exports.dgs

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)

Open = false
repairing = false
itemID = 280 -- ID do step
saveWheelsName = nil
saveVehicle = nil

function verifyFromCompponents(element, components)
    local lf, lb, rf, rb = getVehicleWheelStates(element)
    if components == 'wheel_lf_dummy' or components == 'wheel_front' then
        if lf ~= 0 then
            return true
        end
    elseif components == 'wheel_lb_dummy' or components == 'wheel_rear' then
        if lb ~= 0 then
            return true
        end
    elseif components == 'wheel_rf_dummy' and rf ~= 0 then
        return true
    elseif components == 'wheel_rb_dummy' and rb ~= 0 then
        return true
    end
end

--[[
function verifyFromCompponents(element, components)
	local lf, lb, rf, rb = getVehicleWheelStates(element)
	if components == 'wheel_lf_dummy' and lf ~= 0 then
		return true
	elseif components == 'wheel_lb_dummy' and lb ~= 0 then
		return true
	elseif components == 'wheel_rf_dummy' and rf ~= 0 then
		return true
	elseif components == 'wheel_rb_dummy' and rb ~= 0 then
		return true
	end
end
]]--

addEventHandler ( "onClientClick", getRootElement(),
	function(_, state, _, _, _, _, _, elementClicked)
		if not exports['bgo_items']:hasItem(localPlayer, itemID) then return end
		if state == "down" and not Open and not repairing then
			if elementClicked then
				if getElementType(elementClicked) == "vehicle" then 
					local px, py, pz = getElementPosition(localPlayer)
		    		local vehsTable = getElementsWithinRange( px, py, pz, 0.05, "vehicle" )
		            for i=1, #vehsTable do
		                for compname in pairs(getVehicleComponents(vehsTable[i])) do
		                	if verifyFromCompponents(vehsTable[i], compname) then 
								local vx,vy,vz = getVehicleComponentPosition(vehsTable[i], compname, "world")
								if getDistanceBetweenPoints3D(px, py, pz, vx,vy,vz) < 1.5 then
									Open = true
									materialTeste = DGS:dgsCreate3DInterface(px, py, pz, 5,5, 1300,1300, tocolor(255,255,255,255),nil, nil, nil)
									exportedX, exportedY, exportedZ = px, py, pz
									addEventHandler('onClientRender', root, attFaceTo)
									saveWheelsName = compname
									saveVehicle = vehsTable[i]
									dgsButton = DGS:dgsCreateButton(0.6, 0.4, 0.15, 0.05, 'TROCAR PNEU', true, materialTeste, tocolor(255, 255, 255, 255), false, false, false, false, false, tocolor(40, 40, 40, 255))
									DGS:dgsSetFont ( dgsButton, "default-bold" )
									closeButton = DGS:dgsCreateButton(0.6, 0.4 + 0.06, 0.15, 0.05, 'FECHAR', true, materialTeste, tocolor(255, 255, 255, 255), false, false, false, false, false, tocolor(40, 40, 40, 255), tocolor(255, 90, 90,255))
									DGS:dgsSetFont ( closeButton, "default-bold" )
								end
							end
						end
					end
				end
			end
		end
	end
)

function attFaceTo()
	if materialTeste and exportedX and exportedY and exportedZ then
		local px, py, pz = getElementPosition(localPlayer)
		if getDistanceBetweenPoints3D(px, py, pz, exportedX, exportedY, exportedZ) < 1.5 then
			local rx,ry,rz = getElementRotation(localPlayer)
			DGS:dgs3DInterfaceSetRotation( materialTeste, rx)
			DGS:dgs3DInterfaceSetPosition( materialTeste, exportedX, exportedY, exportedZ)
		else
			closer()
		end
	end
end


addEventHandler ( "onDgsMouseClick", root, function(b, s)
    if s == 'down' then
        if source == closeButton then
            closer()
        elseif source == dgsButton then
            if saveWheelsName == 'wheel_rb_dummy' then
                triggerServerEvent('repairWheel', localPlayer, localPlayer, saveVehicle, -1, -1, -1, 0, itemID)
                closer()
            elseif saveWheelsName == 'wheel_rf_dummy' then
                triggerServerEvent('repairWheel', localPlayer, localPlayer, saveVehicle, -1, -1, 0, -1, itemID)
                closer()
            elseif saveWheelsName == 'wheel_lb_dummy' or saveWheelsName == 'wheel_rear' then
                triggerServerEvent('repairWheel', localPlayer, localPlayer, saveVehicle, -1, 0, -1, -1, itemID)
                closer()
            elseif saveWheelsName == 'wheel_lf_dummy' or saveWheelsName == 'wheel_front' then
                triggerServerEvent('repairWheel', localPlayer, localPlayer, saveVehicle, 0, -1, -1, -1, itemID)
                closer()
            end
            repairing = true
            setTimer(function ()
                repairing = false
            end,10000,1)
        end
    end
end )

function closer()
	destroyElement(dgsButton)
	destroyElement(closeButton)
	destroyElement(materialTeste)
	flatTire = { }
	dgsButton = { }
	setTimer(function() Open = false end, 100, 1)
	removeEventHandler('onClientRender', root, attFaceTo)
	exportedX, exportedY, exportedZ = nil
	saveWheelsName = nil
	saveVehicle = nil
end









