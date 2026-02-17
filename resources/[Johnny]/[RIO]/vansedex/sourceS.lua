local ambulanceDoorStates = {}
local ambulanceDoorUsages = {}

addEvent("requestAmbulanceDoorStates", true)
addEventHandler("requestAmbulanceDoorStates", resourceRoot,
	function ()
		if client then
			triggerClientEvent(client, "receiveAmbulanceDoorStates", resourceRoot, ambulanceDoorStates)
		end
	end
)

addEvent("tryToHandleAmbulanceDoor", true)
addEventHandler("tryToHandleAmbulanceDoor", resourceRoot,
	function (pVehicle)
		if client then
			if isElement(pVehicle) then
				if not ambulanceDoorStates[pVehicle] then
					ambulanceDoorStates[pVehicle] = g_DoorStates.DOOR_CLOSE
				end

				if not ambulanceDoorUsages[pVehicle] then
					ambulanceDoorUsages[pVehicle] = 0
				end

				local newDoorState = false
				local timeInterval = 0

				if ambulanceDoorStates[pVehicle] == g_DoorStates.DOOR_CLOSE then
					newDoorState = g_DoorStates.DOOR_OPEN
					timeInterval = g_AnimationTime.DOOR_OPEN + g_AnimationTime.DOOR_SLIDE_BACK
				elseif ambulanceDoorStates[pVehicle] == g_DoorStates.DOOR_OPEN then
					newDoorState = g_DoorStates.DOOR_CLOSE
					timeInterval = g_AnimationTime.DOOR_CLOSE + g_AnimationTime.DOOR_SLIDE_FORTH
				end

				if getTickCount() > ambulanceDoorUsages[pVehicle] then
					setElementSyncer(pVehicle, client)

					ambulanceDoorStates[pVehicle] = newDoorState
					ambulanceDoorUsages[pVehicle] = timeInterval + getTickCount()

					triggerClientEvent("syncAmbulanceDoorState", resourceRoot, pVehicle, newDoorState)
				end
			end
		end
	end
)

addEventHandler("onElementDestroy", root,
	function ()
		ambulanceDoorStates[source] = nil
		ambulanceDoorUsages[source] = nil
	end
)
