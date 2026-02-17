addEventHandler("onResourceStop", getResourceRootElement(),
	function ()
		for k, v in pairs(getElementsByType("vehicle")) do
			removeElementData(v, "cableHolder")
			removeElementData(v, "cableAttachment")
			removeElementData(v, "carAnimation")
			removeElementData(v, "carPlacedOnTruck")
		end
	end
)




addEventHandler( "onElementDestroy", root,
	function ()
	if getElementType(source) == "vehicle" then
	if getElementModel(source) == TRUCK_MODEL then
			--setElementData(source, "carPlacedOnTruck", false)
			local attached = getAttachedElements(source)
			for i = 1, #attached do
				if getElementType(attached[i]) == "vehicle" then
					--setElementData(attached[i], "carPlacedOnTruck", false)
					detachElements ( attached[i] )
				end
			end
			end
		end			
	end
)
addEvent("removergrude", true)
addEventHandler("removergrude", getRootElement(),
	function (towTruck)
		if towTruck then
			detachElements ( towTruck )
			setElementCollisionsEnabled(towTruck, true)
			setElementFrozen(towTruck, false)
		end
	end
)





addEvent("playPackerRampAnim", true)
addEventHandler("playPackerRampAnim", getRootElement(),
	function (towTruck)
		if towTruck then
			local rx, ry, rz = getElementRotation(towTruck)

			setElementRotation(source, 0, 0, rz - 90, "default", true)
			setElementFrozen(source, true)
			setPedAnimation(source, "police", "CopTraf_Left", -1, true, false, false)

			setTimer(
				function (thePlayer)
					if isElement(thePlayer) then
						setPedAnimation(thePlayer, false)
						setElementFrozen(thePlayer, false)
					end
				end,
			SLIDE_ANIMATION_TIME + ROTATE_ANIMATION_TIME, 1, source)
		end
	end
)



--[[
addEventHandler('onElementDataChange', root, function(dataName)
	if source and getElementType(source) == 'vehicle' then 
		if tostring(dataName) == 'carPlacedOnTruck' then 
			if getElementData(source, dataName) == false then 

				--setElementData(source, "carPlacedOnTruck", false)
				removeElementData(source, "cableAttachment")
				detachElements ( source )
				setElementFrozen(source, false)
				setElementData(source, "veh:detran", false)
				setElementCollisionsEnabled(source, true)
			end
		end
	end
end)
]]--


addEventHandler("onElementDataChange", getRootElement(),
	function (dataName, oldVal)
		if dataName == "packerState" then
			local dataVal = getElementData(source, "packerState") or "up"

			if dataVal ~= "up" then
				setElementFrozen(source, true)
			else
				setElementFrozen(source, false)
			end
		end

		if dataName == "carPlacedOnTruck" then
			local dataVal = getElementData(source, "carPlacedOnTruck")

			if oldVal and not dataVal then
				detachElements(source)
				setElementData(source, "veh:detran", false)
			end

			if dataVal then
				attachElements(source, dataVal[1], dataVal[2], dataVal[3], dataVal[4], dataVal[5], dataVal[6], dataVal[7])
				setElementData(source, "veh:detran", true)
			end
		end

		if dataName == "carAnimation" then
			local dataVal = getElementData(source, "carAnimation")

			if oldVal and not dataVal then
				setElementCollisionsEnabled(source, true)
			end

			if dataVal then
				setElementCollisionsEnabled(source, false)
			end
		end

		if dataName == "cableHolder" then
			local dataVal = getElementData(source, "cableHolder")

			if isElement(dataVal) and getElementType(dataVal) == "player" then
				setElementSyncer(source, dataVal)
			else
				setElementSyncer(source, true)
			end
		end
	end
)