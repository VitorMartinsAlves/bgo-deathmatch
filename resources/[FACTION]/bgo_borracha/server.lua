function CombatFired(x, y, z, target)
	local px, py, pz = getElementPosition(source)
	local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
	local rx,ry,rz = getElementRotation(source)

	if (distance<12) then
		if (isElement(target) and getElementType(target)=="player") then
			for key, value in ipairs(getElementsByType("player")) do
				if (value~=source) then
					triggerClientEvent(value, "showCombatEffect", value, x, y, z, value) 
				end
			end
		 setTimer(removeAnimation, 600, 1, target)
		 setElementRotation(target, rx,ry,rz + 180)
         setPedAnimation(target, "fight_d", "hitd_1", -1, true, false, false )
		 if getElementHealth(target) > 40 then
		     setElementHealth(target, 40)
		 end
         exports.bgo_hud:dm("Você acabou de ser atingido por um disparo de bala de borracha.",target, 255, 0, 0)
		end
	end
end
addEvent("CombatFired", true )
addEventHandler("CombatFired", getRootElement(), CombatFired)

function removeAnimation(thePlayer)
	if (isElement(thePlayer) and getElementType(thePlayer)=="player") then
		setPedAnimation(thePlayer)
	end
end