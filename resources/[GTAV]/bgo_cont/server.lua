

function setPedDanceAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
if isElement(ped) then
triggerClientEvent ( root, "setPedDanceAnimationCont", root, ped,animation,tiempo,repetir,mover,interrumpible )
if tiempo > 1 then
setTimer(setPedAnimation,tiempo,1,ped,false)
setTimer(setPedAnimation,tiempo+100,1,ped,false)
end
end
end


function howtouse ( player, _ )

setElementData(player, "animLoopCont", 0)
triggerEvent("unbindStopAnimationCont", player)
triggerEvent("stopAnimBindKeyCont", player)
setPedDanceAnimation(player,"crckidle1",-1,true,false,false,false)
end
addCommandHandler ( "cont", howtouse )






function stopAnimBindKeyCont()
	bindKey(source, "space", "down", animationStopCommandCont)
end
addEvent("stopAnimBindKeyCont", false)
addEventHandler("stopAnimBindKeyCont", root, stopAnimBindKeyCont)

function animLoopCont()
	setElementData(source, "animLoopCont", 1)
end
addEvent("animLoopCont", true)
addEventHandler("animLoopCont", root, animLoopCont)

function nonanimLoopCont()
	setElementData(source, "animLoopCont", 0)
end
addEvent("nonanimLoopCont", true)
addEventHandler("nonanimLoopCont", root, nonanimLoopCont)

function unbindStopAnimationCont()
	unbindKey(source, "space", "down", animationStopCommandCont)
end
addEvent("unbindStopAnimationCont", false)
addEventHandler("unbindStopAnimationCont", root, unbindStopAnimationCont)

function animationStopCommandCont(player)
	if not getControlState(player, "sprint") then
		local animLoopCont = getElementData(player, "animLoopCont")
		setElementData(player, "handsup", false)
		if not (animLoopCont==1) then
			stopAnimation(player)
			triggerEvent("unbindStopAnimationCont", player)
		end
	end
end
addCommandHandler("stopanim", animationStopCommandCont, false, false)




function playerSpawn()
	setPedAnimation(source)
	toggleAllControls(source, true, true, false)
	setElementData(source, "animLoopCont", 0)
end
addEventHandler("onPlayerSpawn", root, playerSpawn)
addEvent( "onPlayeranimationStopCommandCont2", true )

function stopAnimation(player)
	if isElement(player) and getElementType(player)=="player" then
		local updateCurrentAnimation = setPedAnimation(player)
		setElementData(player, "animLoopCont", 0)
		--toggleAllControls(player, true, true, false)
		setPedAnimation(player)
		setTimer(setPedAnimation, 50, 2, player)
		setTimer(triggerEvent, 100, 1, "onPlayeranimationStopCommandCont2", player)		
		return updateCurrentAnimation
	else
		return false
	end
end



