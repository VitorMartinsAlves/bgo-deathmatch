

function setPedDanceAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
   local theVehicle = getPedOccupiedVehicle ( ped )
   if theVehicle then return end
if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
if isElement(ped) then
if animation == "crckdeth1" 
or animation == "crckdeth2" 
or animation == "crckdeth3" 
or animation == "crckdeth4" 
or animation == "crckidle1" 
or animation == "crckidle2" 
or animation == "crckidle3" 
or animation == "crckidle4" then
triggerClientEvent ( root, "setPedDanceAnimation", root, ped,animation,tiempo,repetir,mover,interrumpible )
if tiempo > 1 then
setTimer(setPedAnimation,tiempo,1,ped,false)
setTimer(setPedAnimation,tiempo+100,1,ped,false)
end
end
end
 
end
--[[
EJEMPLO/EXAMPLE
CUANDO CAMBIA EL NICK
WHEN NICK IS CHANGED

function wasNickChangedByUser(oldNick, newNick, changedByUser)
setPedDanceAnimation(source,"baile 8",7000,true,false,false,false)
end
addEventHandler("onPlayerChangeNick", getRootElement(), wasNickChangedByUser) -- add an event handler




--]]



function teste()
if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
bgoadmin = true --exports.bgo_admin:AntiComandTempo(player) --or (getElementData(localPlayer,"acc:id") == 1)
else	
bgoadmin = false
end
end
setTimer(teste, 200, 0)	
		

function howtouse ( player, _, arg )
if not bgoadmin then return end
dance = tonumber(arg)
local rotx,roty,rotz = getElementRotation(player)
		if ( exports.bgo_admin:AntiComandTempo(player) ) then
		exports.bgo_admin:AntiComandoTime(player, 5000)

if dance == 1 then 
setElementRotation(player, 0,0,rotz+190,"default",true)


setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckidle1",-1,true,false,false,false)
elseif dance == 2 then 
setElementRotation(player, 0,0,rotz+190,"default",true)
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckidle2",-1,true,false,false,false)

elseif dance == 3 then 
setElementRotation(player, 0,0,rotz+190,"default",true)
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckidle3",-1,true,false,false,false)

elseif dance == 4 then 
setElementRotation(player, 0,0,rotz+190,"default",true)
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckidle4",-1,true,false,false,false)

elseif dance == 5 then 
setElementRotation(player, 0,0,rotz+190,"default",true)
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckdeth1",-1,true,false,false,false)
elseif dance == 6 then 
setElementRotation(player, 0,0,rotz+190,"default",true)
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckdeth2",-1,true,false,false,false)

elseif dance == 7 then
setElementRotation(player, 0,0,rotz+190,"default",true)
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckdeth3",-1,true,false,false,false)

elseif dance == 8 then
setElementRotation(player, 0,0,rotz+190,"default",true) 
setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckdeth4",-1,true,false,false,false)

else
setElementRotation(player, 0,0,rotz+190,"default",true)


setElementData(player, "animLoopDN", 0)
triggerEvent("unbindStopAnimation2", player)
triggerEvent("stopAnimBindKey2", player)
setPedDanceAnimation(player,"crckidle1",-1,true,false,false,false)
--setElementRotation(player, 0,0,rotz+190,"default",true)
--triggerEvent("unbindStopAnimation2", player)
--setElementData(player, "animLoopDN", 0)
--setPedAnimation(player)
end
			else
		drawNote('AntiComando', 'Você não pode utilizar este comando agora! Aguarde: '.. exports.bgo_admin:AntiComandGetTime ( player ) .. ' segundos', player, 255, 0, 0, 5000)
		end
end
addCommandHandler ( "d", howtouse )


			
			function drawNote(id, text, player, r, g, b, time)
				exports.bgo_hud:drawNote(id, text, player, r, g, b, time)
			end



function stopAnimBindKey2()
	bindKey(source, "space", "down", animationStopCommand)
end
addEvent("stopAnimBindKey2", false)
addEventHandler("stopAnimBindKey2", getRootElement(), stopAnimBindKey2)

function animLoopDN()
	setElementData(source, "animLoopDN", 1)
end
addEvent("animLoopDN", true)
addEventHandler("animLoopDN", getRootElement(), animLoopDN)

function nonanimLoopDN()
	setElementData(source, "animLoopDN", 0)
end
addEvent("nonanimLoopDN", true)
addEventHandler("nonanimLoopDN", getRootElement(), nonanimLoopDN)

function unbindStopAnimation2()
	unbindKey(source, "space", "down", animationStopCommand)
end
addEvent("unbindStopAnimation2", false)
addEventHandler("unbindStopAnimation2", getRootElement(), unbindStopAnimation2)

function animationStopCommand(player)
	if not getControlState(player, "sprint") then
		local animLoopDN = getElementData(player, "animLoopDN")
		setElementData(player, "handsup", false)
		if not (animLoopDN==1) then
			stopAnimation(player)
			triggerEvent("unbindStopAnimation2", player)
		end
	end
end
addCommandHandler("stopanim", animationStopCommand, false, false)




function playerSpawn()
	setPedAnimation(source)
	toggleAllControls(source, true, true, false)
	setElementData(source, "animLoopDN", 0)
end
addEventHandler("onPlayerSpawn", getRootElement(), playerSpawn)
addEvent( "onPlayeranimationStopCommand2", true )

function stopAnimation(player)
	if isElement(player) and getElementType(player)=="player" then
		local updateCurrentAnimation = setPedAnimation(player)
		setElementData(player, "animLoopDN", 0)
		--toggleAllControls(player, true, true, false)
		setPedAnimation(player)
		setTimer(setPedAnimation, 50, 2, player)
		setTimer(triggerEvent, 100, 1, "onPlayeranimationStopCommand2", player)
		
		local rotx2,roty2,rotz2 = getElementRotation(player)
		setTimer(setElementRotation, 100, 1, player, 0,0,rotz2+190,"default",true)
		
		return updateCurrentAnimation
	else
		return false
	end
end



