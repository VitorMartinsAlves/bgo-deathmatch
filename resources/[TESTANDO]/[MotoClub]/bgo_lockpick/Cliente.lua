local bloqueio = false
local iniciou = false
keyTable = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b", "c", "e", "f", "g", "h", "i", "j", "k",
 "l", "n", "o", "p", "q", "r", "t", "u", "v", "x", "y", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "num_enter", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "escape", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=", "w", "a", "s", "d" }

addEventHandler("onClientKey", root, function(button, press) 
     if (bloqueio) then
	     for i,bindsK in ipairs(keyTable) do
             if (button == bindsK) then
                 cancelEvent() 
			 end
		 end
     end 
end)  


addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if isElement(element) and getElementType(element) == "vehicle" and not iniciou then
		if state == "down" and button == "left" and not isPedInVehicle(localPlayer) then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 3 then 
			
			if exports['bgo_items']:hasItem(localPlayer, 18) then	
			
			if getElementData(element, "veh:owner") == getElementData(localPlayer, "acc:id") or (getElementData(element, "owner") == getElementData(localPlayer, "acc:id")) then
			
			triggerEvent("bgo>info", localPlayer,"Informação", "Leigo este veiculo é seu!!", "info")
			return 
			end

			local locked = isVehicleLocked(element)
			if not locked then 
			triggerEvent("bgo>info", localPlayer,"Informação", "Este veiculo não está trancado!", "info")
			return 
			end
			
			
			triggerEvent("bgo>info", localPlayer,"Informação", "Utilize A e D parar manter a seta no centro ( não deixe ela cair )", "info")
			CameraNoNPC(element)
			triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "bomber", "BOM_Plant_Loop", 15000, true, false, false)
			triggerEvent("progressService", localPlayer, 5, "#ffffffIniciando tentativa de roubo!")
			setTimer(function()
			bloqueio = true
			end,100,1)
			iniciou = true
		
			setTimer(function()
			bloqueio = false
			setBalanceQTEState(true, 0.5)
			end,5000,1)
			
			
			elements = element

			end
			end
		end
	end
end
)



function sucesso(sucess)
	if sucess then
		ResetCameraNPC()
		iniciou = false
		bloqueio = false
		local vehID = getElementModel(elements)
		local vehName = exports.bgo_realname:getVehicleRealName(vehID)
		triggerServerEvent("bgoMTA->#tentarLP", localPlayer, localPlayer, 18, elements, vehName)
		--elements = nil		
	else
	triggerEvent("bgo>info", localPlayer,"Informação", "Você falhou na missão, - 1 lock pick", "info")
	triggerServerEvent("bgoMTA->#removerLP", localPlayer, localPlayer, 18)
	ResetCameraNPC()
		iniciou = false
		bloqueio = false
	end
end

--[[
local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)
function createPanel()
		if iniciou then
 		local r, g, b = 255, 255, 255	
		if not isInSlot(sx*633,sy*615, sx*135,sy*30) then			
		dxDrawRectangle(sx*633,sy*615, sx*135,sy*30, tocolor(r, g, b, 255))
		else
		dxDrawRectangle(sx*633,sy*615, sx*135,sy*30, tocolor(r, g, b, 210))
		end	
		dxDrawText("Cancelar!", sx*1400, sy*1260, sx/2, 0, tocolor(0, 0, 0, 255), sy/0.7, "default", "center", "center", false, false, false, true)
	end
end

function teste(button, state, x, y, elementx, elementy, elementz, element)
	if state == "down" and button == "left" then 
	if iniciou then
	if isInSlot(sx*633,sy*615, sx*135,sy*30) then
	cancelRender()
	end
	end
	end
end
--addEventHandler( "onClientClick", root, teste )




function cancelRender()
if isTimer(tempo) then
killTimer(tempo)
end
	removeEventHandler("onClientPreRender", root, createPanel)
	ResetCameraNPC()
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 1000, true, false, false)
	triggerEvent("progressService", localPlayer, 0.1, "#ffffff")
	iniciou = false
	setPedAnimation(elements)
	bloqueio = false
	elements = nil
end

function isInSlot( posX, posY, width, height )
  if isCursorShowing( ) then
    local mouseX, mouseY = getCursorPosition( )
    local clientW, clientH = guiGetScreenSize( )
    local mouseX, mouseY = mouseX * clientW, mouseY * clientH
    if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
      return true
    end
  end
  return false
end
]]--
	
-----------------------------------------------------
------CAMERA NPC
-----------------------------------------------------

local save_cam_matrix = {}

function CameraNoNPC(npc_id)

	npc = npc_id
	  

	save_cam_matrix.x, save_cam_matrix.y, save_cam_matrix.z, save_cam_matrix.lx, save_cam_matrix.ly, save_cam_matrix.lz = getCameraMatrix()
	x, y, z = getPositionFromElementOffset(npc,  0 , 3 , 1 ) 
		
	smoothMoveCamera(save_cam_matrix.x, save_cam_matrix.y, save_cam_matrix.z, save_cam_matrix.lx, save_cam_matrix.ly, save_cam_matrix.lz,
					x, y, z, npc.position.x, npc.position.y, npc.position.z + 0.6, 1500)
					
	--setPedAnimation(npc, "ped", "IDLE_chat")
end

function ResetCameraNPC()
	local x, y, z, lx, ly, lz = getCameraMatrix()
	smoothMoveCamera(x, y, z, lx, ly, lz, save_cam_matrix.x, save_cam_matrix.y, save_cam_matrix.z, save_cam_matrix.lx, save_cam_matrix.ly, save_cam_matrix.lz, 1500)
	
	setTimer(setCameraTarget, 1600, 1, localPlayer)
	setTimer(setCameraTarget, 1800, 1, localPlayer)
	
	setElementFrozen(npc, false)
	setElementFrozen(npc, true)
	setPedAnimation(npc)
	setPedAnimation(localPlayer)
	npc = nil
end




addEvent("acionaralarm", true)
addEventHandler("acionaralarm", root,
	function(veiculo, xp, yp, zp, int, dim)
		local song = playSound3D("alarm.ogg", xp, yp, zp)
		setSoundVolume(song, 0.9)
		setSoundMaxDistance(song, 60)
		setElementInterior(song, int)
		setElementDimension(song, dim)		
		attachElements ( song, veiculo, 0, 0, 2 )
end)




 
local sm = {
	moov = 0;
}

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end

local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientPreRender",root,camRender)
	end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	if not y2 then
		local _x1,_y1,_z1,_x1t,_y1t,_z1t = getCameraMatrix( )
		smoothMoveCamera(_x1,_y1,_z1,_x1t,_y1t,_z1t, x1,y1,z1,x1t,y1t,z1t, x2)
		return
	end

	sm.object1 = createObject(1337,x1,y1,z1)
	setElementCollisionsEnabled(sm.object1, false)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementCollisionsEnabled(sm.object2, false)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	addEventHandler("onClientPreRender",root,camRender)
	return true
end








function getPositionFromElementOffset(element,offX,offY,offZ) 
    local m = getElementMatrix ( element ) 
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1] 
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2] 
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3] 
    return x, y, z 
end 
  
  
  