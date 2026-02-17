function tazerFired(x, y, z, target)
	local px, py, pz = getElementPosition(source)
	local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)

	if (distance<12) then
		if (isElement(target) and getElementType(target)=="player") then
			for key, value in ipairs(getElementsByType("player")) do
				if (value~=source) then
					triggerClientEvent(value, "showTazerEffect", value, x, y, z, value) 
				end
			end
			setElementData(target, "tazed", 1, false)
			toggleAllControls(target, false, false, false)
			setPedAnimation(target, "ped", "FLOOR_hit_f", -1, false, false, true)
			setTimer(removeAnimation, 30005, 1, target)
			setElementFrozen(target, true)
			setElementData(target,"lesokkolt",true)
			--outputChatBox(tostring(getElementData(target,"lesokkolt")))
		end
	end
end
addEvent("tazerFired", true )
addEventHandler("tazerFired", getRootElement(), tazerFired)

function removeAnimation(thePlayer)
	if (isElement(thePlayer) and getElementType(thePlayer)=="player") then
		setPedAnimation(thePlayer)
		toggleAllControls(thePlayer, true, true, true)
		setElementData(thePlayer, "tazed", 0, false)
		setElementData(thePlayer,"lesokkolt",false)
		setElementFrozen(thePlayer, false)
	end
end