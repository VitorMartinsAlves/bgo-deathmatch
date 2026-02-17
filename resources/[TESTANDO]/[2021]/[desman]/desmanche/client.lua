local marker 
local marker_2
local part
local vehicle = false
local etapa   = {}

local zone
local timer
local horas
local minutos
local segundos

local coponents = {

     {'wheel_rear', 'Roda Dianteira', 0, -2, -0.7, 1},
	 {'wheel_front', 'Roda traseira', 0, 2, -0.7, 0},
	 
	 
     {'boot_dummy', 'Porta malas', 0, -3, -0.7, 1},
	 {'door_lf_dummy', 'Porta Esquerda', -2, 0, -0.7, 2},
	 {'bonnet_dummy', 'Capô', 0, 3, -0.7, 0},
	 {'door_rf_dummy', 'Porta Direita', 2, 0, -0.7, 3},
	 
	 {'wheel_rf_dummy', 'Roda Direita', 1.5, 1.5, -0.7, -1},
	 {'wheel_rb_dummy', 'Roda Traseira Direita', 1.5, -1.5, -0.7, -1},
	 
	 {'wheel_lb_dummy', 'Roda Traseira Esquerda', -1.5, -1.5, -0.7, -1},
	 {'wheel_lf_dummy', 'Roda Direita', -1.5, 1.5, -0.7, -1},
}


addEvent('cancel:service', true)
addEventHandler('cancel:service', root,
function (vehicle, coponent)
     if isElement(marker) then destroyElement(marker) destroyElement(marker_2) end
     etapa = nil
end)


addEvent('remove:component', true)
addEventHandler('remove:component', root,
function (vehicle, coponent)
     setVehicleComponentVisible(vehicle, coponent, false)
end)

addEvent('reset:remove:component', true)
addEventHandler('reset:remove:component', root,
function (vehicle)
        local getComponent = getVehicleComponents(vehicle)
        for k in pairs (getComponent) do
            setVehicleComponentVisible(vehicle, k, true) 
        end
		
end)


addEvent('startprogress', true)
addEventHandler('startprogress', root,
function (element, zone)
     if element then
	     vehicle = element
		 if etapa then
		    etapa = {}
		 end
		
		if (getVehicleType(element) == "Bike") then
		etapa = {['etapa'] = 1, ['vehicle'] = element, ['zone'] = zone, ['etapafinal'] = 1}
		end
		if (getVehicleType(element) == "Automobile") then
		etapa = {['etapa'] = 3, ['vehicle'] = element, ['zone'] = zone, ['etapafinal'] = 7}
		end
		 

		 
		 
		 setMarkerPosition (element) 
	 end
end)
--[[
addEventHandler("onClientColShapeLeave", resourceRoot,
function (element)
     if etapa then
         if element == etapa['vehicle'] then
    		 if isElement(marker) then destroyElement(marker) destroyElement(marker_2) end
    		 etapa = nil
		 end
	 end
end)]]--

function setMarkerPosition (vehicle) 
     if isElement(marker) then destroyElement(marker) destroyElement(marker_2) end
	 part = coponents[etapa['etapa']][1]
	 local x, y, z = getVehicleComponentPosition(vehicle, part, "world")
     marker = createMarker (x, y, z, "cylinder", 1.7, 0, 0, 0, 0 )
     marker_2 = createMarker (x, y, z, "cylinder", 0.7, 255, 175, 255, 50 )
	 attachElements ( marker, vehicle, coponents[etapa['etapa']][3], coponents[etapa['etapa']][4], coponents[etapa['etapa']][5])
	 attachElements ( marker_2, vehicle, coponents[etapa['etapa']][3], coponents[etapa['etapa']][4], coponents[etapa['etapa']][5])
	 addEventHandler('onClientMarkerHit', marker, onMarkerHitClient)
	 addEventHandler('onClientMarkerLeave', marker, onMarkerLeaveClient)
end

function vehicleAction (vehicle, door, action)
     if door >= 0 then
         triggerServerEvent('action:vehicle', localPlayer, vehicle, door, action)
	 end
end

function vehicleRemove (vehicle, component)
     triggerServerEvent('remove:component', localPlayer,localPlayer, vehicle, component)
end

function setAnimation(anim_1, anim_2)
     triggerServerEvent('setAnimation', localPlayer, localPlayer, anim_1, anim_2)
end

function onMarkerHitClient (player)
     if player == localPlayer then
	 if getElementData(localPlayer,"CaixaNaMao") then return end
		 triggerEvent("bgo>info", localPlayer,  "Desmanche","Pressione E para retirar o "..coponents[etapa['etapa']][2].." ", "info" ) 
		 bindKey('e', 'down', keyStart)
	 end
end

function onMarkerLeaveClient (player)
     if player == localPlayer then
		 unbindKey('e', 'down', keyStart)
	 end
end

function keyStart ()
	if getElementData(localPlayer,"CaixaNaMao") then return end
	 unbindKey('e', 'down', keyStart)
	 triggerEvent("progressService", localPlayer, 2, "#ffffffRemovendo "..coponents[etapa['etapa']][2].." ")

     vehicleAction (etapa['vehicle'], coponents[etapa['etapa']][6], 1)
	 if isElement(marker) then destroyElement(marker) destroyElement(marker_2) end
	 setAnimation('bomber', 'bom_plant_loop')
	 setTimer(function()
	     vehicleRemove (etapa['vehicle'], coponents[etapa['etapa']][1])
		 
		 if etapa['etapa'] > etapa['etapafinal'] then 
		     setAnimation()
		     triggerServerEvent('destroyVehicle', localPlayer, localPlayer, etapa['vehicle'])
			 etapa = {}
			 return
		 --elseif etapa['etapa'] == 1 then
		     --triggerServerEvent('ocupezone', localPlayer, localPlayer, etapa['zone'], etapa['vehicle'])
		 end
		 
		 
		 etapa['etapa'] = tonumber(etapa['etapa'] + 1)
		 setMarkerPosition (vehicle) 
		 setAnimation()
	 end, 2000, 1)
end


