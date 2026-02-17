if fileExists('client.lua') then 
	fileDelete('client.lua') 
end

local timers = {}
local fontsize = 1
local font = dxCreateFont("files/font.otf", 9)
local font2 = dxCreateFont("files/font.otf", 12)
local font3 = dxCreateFont("files/font.otf", 10)
local clickTimer 

addEventHandler("onClientPedDamage", root,
   function(e)
       if getElementData(source, "hunter:animal") then
           cancelEvent()
		   if e and getElementType(e) ~= "player" then
		       return
		   end
		   local x,y,z = getElementPosition(source)
		   local px,py,pz = getElementPosition(e)
		   local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
		   if d < maxDist + 20 and not isElementFrozen(e) then
		      local multipler = 1-d/maxDist
	          local oldHealth = getElementData(source, "hunter:health")
		      local damage = 4
		      local weapon = getPedWeapon(e)
		      for k,v in ipairs(weaponDamages) do
		          if v[1] == weapon then
			          damage = v[2]
					  --outputChatBox(damage)
			      end
		      end
			  triggerServerEvent("hunter:startAttack", root, e, source)
	          setElementData(source, "hunter:health", oldHealth - damage)
			  --[[local skin = getElementModel(source)
			  if sounds[skin] then
			      local sound = sounds[skin][1]
				  triggerServerEvent("server:sound", root, source, sound)
				  --removeElementData(source, "hunter:sound")
			  end--]]
		   end
	   end
   end
)

local cursorX, cursorY = 0,0

function checkCursor()
	if not guiGetInputEnabled() and not isMTAWindowActive() and isCursorShowing( ) then
		return true
	else
		return false
	end
end

addEventHandler("onClientCursorMove", root,
	function(_,_,x,y)
		cursorX = x
		cursorY = y
	end
)

function inBox(xmin,ymin,xmax,ymax)
	if checkCursor() then
		x,y = cursorX, cursorY
		xmin = tonumber(xmin) or 0
		xmax = (tonumber(xmax) or 0)+xmin
		ymin = tonumber(ymin) or 0
		ymax = (tonumber(ymax) or 0)+ymin
		return x >= xmin and x <= xmax and y >= ymin and y <= ymax
	else
		return false
	end
end

-- BORDER CREATE
function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x,y,w+1,1,color) -- Fent
	dxDrawRectangle(x,y+1,1,h,color) -- Bal Oldal
	dxDrawRectangle(x+1,y+h,w,1,color) -- Lent Oldal
	dxDrawRectangle(x+w,y+1,1,h,color) -- Jobb Oldal
end

setTimer(
    function()
	    for k,v in ipairs(getElementsByType("ped")) do
		   if getElementData(v, "hunter:animal") then
		       if getElementData(v, "hunter:autoAttack") then
			       --outputChatBox("asd1")
			       local x,y,z = getElementPosition(v)
				   local px,py,pz = getElementPosition(localPlayer)
			       local d = getDistanceBetweenPoints3D(x,y,z, px,py,pz)
				   --outputChatBox(d)
				   --outputChatBox(maxDist)
			       if not getElementData(v, "hunter:attack") and d < maxDist then
				       triggerServerEvent("hunter:startAttack", root, localPlayer, v)
				   --[[elseif getElementData(v, "hunter:attack") then
				       local e = getElementData(v, "hunter:target")
					   if e and isElement(e) and e ~= localPlayer then
					       local px,py,pz = getElementPosition(e)
					       local d2 = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
						   if d < d2 then
						       triggerServerEvent("hunter:startAttack", root, localPlayer, v)
						   end
					   end--]]
				   end
		       end
		   end
		end
    end, 2000, 0
)

--[[addEventHandler("onClientRender", root,
    function()
	    for k,v in ipairs(getElementsByType("ped", true)) do
		    if getElementData(v, "hunter:animal") then
		    	local x,y,z = getElementPosition(v)
				local px,py,pz = getElementPosition(localPlayer)
				local sx, sy = getScreenFromWorldPosition(x,y,z)
				local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				local bPathClear = isLineOfSightClear(x,y,z, px,py,pz , true, true, false, true)
				if d < maxDist and bPathClear then
					local size = 1-d/maxDist
					local a = 180 * size
					if sx and sy and not isElementFrozen(v) then
				    	local w, h = 200 * size, 30 * size
						local health = getElementData(v, "hunter:health")
						local maxHealth = getElementData(v, "hunter:maxHealth")
						local bar = w * health/maxHealth
			    		dxDrawRectangle(sx - w/2, sy - h/2, w, h, tocolor(0,0,0, a - 60))
						dxDrawRectangle(sx - w/2, sy - h/2, bar, h, tocolor(124,197,118, a))
						dxCreateBorder(sx - w/2, sy - h/2, w, h, tocolor(0,0,0, a))
					end
				end
			end
		end
    end
)--]]

addEventHandler("onClientElementDataChange", root,
   function(dName, oldValue)
       if getElementType(source) == "ped" and getElementData(source, "hunter:animal") then
	       if dName == "hunter:target" then
		       local e = getElementData(source, dName)
			   if isElement(e) then
			       --outputChatBox("asd")
			       npc_follow(source, e)
			   end
		   end
	   end
   end
)

addEvent("hunter:sound", true)
addEventHandler("hunter:sound", root,
   function(sound, x,y,z)
      local soundElement = playSound3D(sound, x,y,z, false)
	  setSoundMaxDistance(soundElement, maxInteract)
   end
)

local t_Data = {}
 
function npc_follow(npc) 
    local who = getElementData(npc, "hunter:target")
    local intX, intY, intZ = getElementPosition (who)
    local _, _, intRZ = getElementRotation (who)
    local t_Matrix = getElementMatrix (who)
   
    -- Calculate a position 4m behind local player
    local intPedX = -4 * t_Matrix[2][1] + t_Matrix[4][1]
    local intPedY = -4 * t_Matrix[2][2] + t_Matrix[4][2]
    local intPedZ = -4 * t_Matrix[2][3] + t_Matrix[4][3]
   
    local num = #t_Data + 1
	
	t_Data[num] = {}
	t_Data[num].ped = npc
	--t_Data[num].ped = createPed (0, intPedX, intPedY, intPedZ, intRZ)
	
    t_Data[num].updateNPCTimer = setTimer(npc_updatePosition, 50, 0, num)
end

function npc_toggleFollow(num) 
    if (t_Data[num].ped) then
        if (t_Data[num].updateNPCTimer) then
            if (isTimer(t_Data[num].updateNPCTimer)) then
                killTimer (t_Data[num].updateNPCTimer)
            end
        end
        if (isElement(t_Data[num].ped)) then
            destroyElement (t_Data[num].ped)
        end
		setElementData (t_Data[num].ped, "hunter:attack", false)
		--setElementData (t_Data[num].ped, "hunter:target", nil)
        t_Data[num].ped = nil
		t_Data[num] = nil
        return true
    end
end

function npc_updatePosition(e)
    if not isElement(t_Data[e].ped) or isElementFrozen(t_Data[e].ped) then
        return npc_toggleFollow(e)
    end
   
    local who = getElementData(t_Data[e].ped, "hunter:target")
	local t_PlayerPos
	if who then
        t_PlayerPos = {getElementPosition(who)}
    else
	    t_PlayerPos = getElementData(t_Data[e].ped, "hunter:defPos")
	end
    local t_PedPos = {getElementPosition(t_Data[e].ped)}
   
    local intDistance = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_PlayerPos))
	
	if intDistance > maxDist then
	    setElementData(t_Data[e].ped, "hunter:target", nil)
		setElementData(t_Data[e].ped, "hunter:attack", false)
	    t_PlayerPos = getElementData(t_Data[e].ped, "hunter:defPos")
	end
	
	local intDistance = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_PlayerPos))
	
	local t_LocalPos = {getElementPosition(localPlayer)}
	local localDist = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_LocalPos))
	
	if localDist > maxDist and intDistance <= 1 then
	    setPedControlState (t_Data[e].ped, 'forwards', false)
	    return npc_toggleFollow(e)
	end
	
	local t_LocalPos = getElementData(t_Data[e].ped, "hunter:defPos")
	local localDist = getDistanceBetweenPoints3D (t_PedPos[1], t_PedPos[2], t_PedPos[3], unpack(t_LocalPos))
	
	if localDist > maxDist * 3 then
	    setElementPosition (t_Data[e].ped, unpack(t_LocalPos))
	    setPedControlState (t_Data[e].ped, 'forwards', false)
	    return npc_toggleFollow(e)
	end
	
	if not who and intDistance <= 1 or isElementFrozen(t_Data[e].ped) then
	    setPedControlState (t_Data[e].ped, 'forwards', false)
		return npc_toggleFollow(e)
	end
	
    if (intDistance < 1) then
	    --outputChatBox("ütni kéne...")
	    setPedControlState (t_Data[e].ped, 'forwards', false)
		local state = not getPedControlState(t_Data[e].ped, "fire")
		--outputChatBox(tostring(state))
		setPedControlState(t_Data[e].ped, "fire", state)
        return true
    end
   
    local intPedRot = -math.deg (math.atan2(t_PlayerPos[1] - t_PedPos[1], t_PlayerPos[2] - t_PedPos[2]))
    if intPedRot < 0 then intPedRot = intPedRot + 360 end;
   
    setElementRotation (t_Data[e].ped, 0, 0, intPedRot, 'default', true)
    setPedControlState (t_Data[e].ped, 'forwards', true)
   
    local bPathClear = true
    local t_Matrix = getElementMatrix (t_Data[e].ped)
   
    -- Calculate a position 1m ahead of ped
    local int_RayX = t_Matrix[2][1] + t_Matrix[4][1]
    local int_RayY = t_Matrix[2][2] + t_Matrix[4][2]
    local int_RayZ = t_Matrix[2][3] + t_Matrix[4][3]
   
    --We cast 10 rays 1m ahead of the ped
    for i = 1, 10 do
        local intSourceX, intSourceY, intSourceZ = t_PedPos[1], t_PedPos[2], t_PedPos[3]
       
        -- The target position height is identical to the center of the ped (1m above ground)
        -- We lower this value by 0.5m to detect short obstacle
        local intTargetX, intTargetY, intTargetZ = int_RayX, int_RayY, int_RayZ - 0.5 + i*0.2
       
        bPathClear = isLineOfSightClear (intSourceX, intSourceY, intSourceZ, intTargetX, intTargetY, intTargetZ, true, true, false, true)
        --dxDrawLine3D (intSourceX, intSourceY, intSourceZ, intTargetX, intTargetY, intTargetZ, bPathClear and tocolor(255,255,255,255) or tocolor(255,0,0,255))
       
        if (not bPathClear) then
            break
        end
    end

    if (not bPathClear) then
        setPedControlState (t_Data[e].ped, 'jump', true)
    else
        setPedControlState (t_Data[e].ped, 'jump', false)
    end
   
    if (intDistance > 8) then
        setPedControlState (t_Data[e].ped, 'sprint', true)
    else
        setPedControlState (t_Data[e].ped, 'sprint', false)
    end
end

local interactElement
local interactStat = false
local distance = 30
local anim = false
local animX = 0
local animState = "Desconhecido."
-- local animText = animTexts[1][1]
local animText = ""
local animNum = 1
local xPlus = 2
local animBoxX = 550
local animBoxY = 20
local animMaxX = animBoxX / 2
local ar,ag,ab,aa = 124, 197, 118, 180
local sx, sy = 0,0
local interactGui 
local selectedElement

addEventHandler("onClientClick", root,
    function(b, s, _,_,_,_,_, e)
	    if e and getElementType(e) == "ped" and getElementData(e, "hunter:animal") and isElementFrozen(e) and not interactStat then
		    local x,y,z = getElementPosition(e)
			local px,py,pz = getElementPosition(localPlayer)
		    local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			local bPathClear = isLineOfSightClear(x,y,z, px,py,pz , true, true, false, true)
			local sx, sy = getScreenFromWorldPosition(x,y,z)
		    if b == "left" and s == "down" and d < 3 and not anim and sx and sy and not getElementData(e, "hunter:use") and tonumber(getElementData(e, "hunter:clicks") or 0) == 0 then
			if isTimer(packetTimer) then return end
				--if isTimer(clickTimer) then
		    	--    outputChatBox("#53bfcd[BGO CAÇA]: #ffffffNão clique tão rápido!", 255, 255, 255, true)
		    	----    return
			    --end
			    --clickTimer = setTimer(function() end, 2000, 1)
			    interactGui = guiCreateWindow(sx + rectangleSize[1]/2, sy, rectangleSize[1], 20, " teste ", false)
				guiSetAlpha(interactGui, 0)
				--guiWindowSetMovable(interactGui, false)
				guiWindowSetSizable(interactGui, false)
				setElementData(e, "hunter:use", true)
				setElementData(e, "hunter:clicks", tonumber(getElementData(e, "hunter:clicks") or 0 ) + 1)
			    interactElement = e
				selectedElement = e
				interactStat = true
			end
		end
	end
)

setTimer(
    function()
	    if interactStat then
	        local x,y,z = getElementPosition(interactElement)
			local px,py,pz = getElementPosition(localPlayer)
			local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			local bPathClear = isLineOfSightClear(x,y,z, px,py,pz , true, true, false, true)
	        if d > maxInteract or not bPathClear then
			    setElementData(interactElement, "hunter:use", false)
				setElementData(interactElement, "hunter:clicks", tonumber(getElementData(e, "hunter:clicks") or 0 ) - 1)
		        interactStat = false
			end
		end
	end, 2000, 0
)

addEventHandler("onClientRender", root,
    function()
	    if interactStat then
		    local x,y,z = getElementPosition(interactElement)
		    local sx, sy = guiGetPosition(interactGui, false)
			local px,py,pz = getElementPosition(localPlayer)
			local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			if sx and sy and d < maxInteract then
			    local size = 1-d/maxDist
			    local x, y = rectangleSize[1] * size, rectangleSize[2] * size
			    dxDrawRectangle(sx, sy, x+20, y-25, tocolor(0,0,0,80))
				dxDrawRectangle(sx, sy-30, x+20, 30, tocolor(0,0,0,255))
				dxDrawText("#7cc576BGO#ffffffMTA", sx+20+x/2, sy - 40, sx+x/2, sy + 10, tocolor(255,255,255,255), fontsize, font2, "center", "center", false, false, false, true)
				
				local x, y = rectangleSize[3] * size, rectangleSize[4] * size
				local r,g,b,a = 0,0,0,150
                local tr,tg,tb,ta = 255,255,255,255
				if inBox(sx+20, sy + distance-20, x, y-10) then
				    r,g,b,a = 124, 197, 118, 200
					tr,tg,tb,ta = 0,0,0,180
				end
				dxDrawRectangle(sx+ 15, sy-5 + distance-15, x+10, y, tocolor(0,0,0,150))
				dxDrawRectangle(sx+ 20, sy + distance-15, x, y-10, tocolor(r,g,b,a))
				dxDrawText("Fazer um troféu", sx+35+x/2, sy-35 + y/2 + distance, sx+10+x/2, sy + y/2 + distance, tocolor(tr,tg,tb,ta), fontsize, font3, "center", "center")
				
                local x, y = rectangleSize[3] * size, rectangleSize[4] * size
				local r,g,b,a = 0,0,0,180
				local tr,tg,tb,ta = 255,255,255,255
				if inBox(sx + 20, sy + (y + distance - 5), x, y-10) then
				    r,g,b,a = 0, 174, 255, 200
					tr,tg,tb,ta = 0,0,0,180
				end
				dxDrawRectangle(sx+ 15, sy-5 + distance+39, x+10, y, tocolor(0,0,0,150))
				dxDrawRectangle(sx + 20, sy + (y + distance - 5), x, y-10, tocolor(r,g,b,a))
				dxDrawText("Desenhe um animal", sx+35+x/2, sy-35 + y/2 + (y + distance + 10), sx+10+x/2, sy + y/2 + (y + distance + 10), tocolor(tr,tg,tb,ta), fontsize, font3, "center", "center")
				
				local x, y = rectangleSize[3] * size, rectangleSize[4] * size
				local r,g,b,a = 0,0,0,180
				local tr,tg,tb,ta = 255,255,255,255
				if inBox(sx+20, sy + (y*2 + distance+5), x, y-10) then
				    r,g,b,a = 215, 85, 85, 200
					tr,tg,tb,ta = 0,0,0,180
				end
				dxDrawRectangle(sx+ 15, sy-5 + distance+90, x+10, y, tocolor(0,0,0,150))
				dxDrawRectangle(sx+ 20, sy + (y*2 + distance+5), x, y-10, tocolor(r,g,b,a))
				dxDrawText("Fechar", sx+35+x/2, sy-35 + y/2 + (y*2 + distance + 20), sx+10+x/2, sy + y/2 + (y*2 + distance + 20), tocolor(tr,tg,tb,ta), fontsize, font3, "center", "center")
			end
		end
	end
)

addEventHandler("onClientClick", root,
    function(b, s, _,_,_,_,_, e)
	    if interactStat then
		    if b == "left" and s == "down"  then
			   -- if isTimer(clickTimer) then
		    	--    outputChatBox("#53bfcd[BGO CAÇA]: #ffffffNão clique não rapido!!", 255, 255, 255, true)
		    	--    return
			    --end
			    --clickTimer = setTimer(function() end, 2000, 1)
			    local x,y,z = getElementPosition(interactElement)
		    	local sx, sy = guiGetPosition(interactGui, false)
				local px,py,pz = getElementPosition(localPlayer)
				local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if sx and sy and d < maxInteract then
				    local size = 1-d/maxDist
					local x, y = rectangleSize[3] * size, rectangleSize[4] * size
					if inBox(sx+10, sy + distance, x, y) and (exports['bgo_items']:hasItem(localPlayer, 38) or exports['bgo_items']:hasItem(localPlayer, 134) or exports['bgo_items']:hasItem(localPlayer, 135)) then
						interactStat = false
						triggerServerEvent("server:changeAnimation", root, localPlayer, "bomber", "bom_plant_in")
						triggerEvent('bgoMTA->#startMinigame', localPlayer, true, 13, 42, "entMinigameToHunter") 
					elseif inBox(sx+ 15, sy-5 + distance+39, x+10, y) and (exports['bgo_items']:hasItem(localPlayer, 38) or exports['bgo_items']:hasItem(localPlayer, 134) or exports['bgo_items']:hasItem(localPlayer, 135)) then
						interactStat = false
						triggerServerEvent("server:changeAnimation", root, localPlayer, "bomber", "bom_plant_in")
						triggerEvent('bgoMTA->#startMinigame', localPlayer, true, 13, 42, "entMinigameToHunter")
					elseif inBox(sx+ 15, sy-5 + distance+90, x+10, y) then
				    	interactStat = false
						setElementData(interactElement, "hunter:use", false)
						setElementData(interactElement, "hunter:clicks", tonumber(getElementData(e, "hunter:clicks") or 0 ) - 1)
					end
				end
			end
		end
	end
)

addEvent('bgoMTA->#entMinigameToHunter', true)
addEventHandler('bgoMTA->#entMinigameToHunter', root, function(win)
	if win then   
		  local type = 1
		  anim = false
		  local skin = getElementModel(interactElement)
		  
		  triggerServerEvent("hunter:destroyAnimal", root, selectedElement)
		  local itemID = itemReceivers[skin][type]
		  triggerServerEvent("server:giveItem", root, localPlayer, itemID,skin)
		  triggerServerEvent("server:changeAnimation", root, localPlayer, "", "")
		  triggerServerEvent("server:frozenChange", root, localPlayer, false)
	else
		setElementHealth(localPlayer, getElementHealth(localPlayer) - 10)
		outputChatBox('#D24D57[BGO CAÇA]: #ffffffVocê se cortou!',124,197,118,true)
	end
end)

local ax, ay = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
	    if anim then
		    local r,g,b,a = 0,0,0,180
			local multipler = 5
		    dxDrawRectangle(ax/2 - animBoxX/2, ay - animBoxY*multipler, animBoxX, animBoxY, tocolor(r,g,b,a - 80))
			
			animX = animX + xPlus
			if animX >= animBoxX then
			   animX = 0
			   animTextsL = #animTexts
			   animNum = animNum + 1
			   if animNum > animTextsL then
				  local type = 1
			      anim = false
				  local skin = getElementModel(interactElement)
				  if animState == "Fazer um troféu" then
				      type = 1
					  triggerServerEvent("hunter:destroyAnimal", root, selectedElement)
				  elseif animState == "Desenhe um animal" then 
				      type = 2
				      triggerServerEvent("hunter:destroyAnimal", root, selectedElement)
				  end
				  local itemID = itemReceivers[skin][type]
				--  outputChatBox(itemID)
				  triggerServerEvent("server:giveItem", root, localPlayer, itemID,skin)
				  triggerServerEvent("server:changeAnimation", root, localPlayer, "", "")
				  triggerServerEvent("server:frozenChange", root, localPlayer, false)
				  --setPedAnimation(localPlayer, "", "")
				  return
			   end
			   animText = animTexts[animNum][1]
			end
			-- dxDrawRectangle(ax/2 + animBoxX/2, ay - animBoxY*multipler, animX, animBoxY, tocolor(r,g,b,a - 40))
			dxDrawRectangle(ax/2 -5 - animBoxX/2, ay-5 - animBoxY*multipler,animX+10, animBoxY+10, tocolor(0,0,0,150))
			dxDrawRectangle(ax/2 - animBoxX/2, ay - animBoxY*multipler, animX, animBoxY, tocolor(124,197,118,200))
			
			local tg,tb,tr,ta = 255,255,255,255
			dxDrawText(animText, ax/2, ay - animBoxY*multipler + animBoxY/2, ax/2, ay - animBoxY*multipler + animBoxY/2, tocolor(tr,tg,tb,ta), size, font, "center", "center")
		end
	end
)

--------------------------------------------------------------------------------------------------------

local skinID = 202
local x,y,z = -2811.880859375, -1530.4716796875, 140.84375
local name = "Wilson"
local ped = createPed(skinID, x,y,z)
setElementData(ped, "hunter:receiver", true)
setElementData(ped, "Ped:Name", name)
setElementData(ped, "name:tags", "Vadászat")
setElementData(ped, "hunter:type", 1)
setElementFrozen(ped, true)
setElementData(ped, "ped >> death", true)

local skinID = 73
local x,y,z = -2816.3603515625, -1530.4384765625, 140.84375
local name = "William"
local ped = createPed(skinID, x,y,z)
setElementData(ped, "hunter:receiver", true)
setElementData(ped, "Ped:Name", name)
setElementData(ped, "name:tags", "Vadászat")
setElementData(ped, "hunter:type", 2)
setElementFrozen(ped, true)
setElementData(ped, "ped >> death", true)

local destroySell = false

function giveMoney(e, m) 
	local nowMoney = getElementData(e, moneyElement) or 0
	setElementData(e, moneyElement, nowMoney + m)
end

setDevelopmentMode(false)

---------------------------------------------------------------------------------------------------------

function abortAllStealthKills(targetPlayer)
	if getElementType ( targetPlayer ) == "ped" and (getElementData(targetPlayer, "hunter:animal")) or (getElementData(targetPlayer, "hunter:receiver")) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerStealthKill", getLocalPlayer(), abortAllStealthKills)

function boltosPedLoves()
	if(getElementData(source, "hunter:animal")) or (getElementData(source, "hunter:receiver")) then
		cancelEvent() -- Boltosok nem kapják a lövést stb.
	end
end
addEventHandler("onClientPedDamage",  getRootElement(), boltosPedLoves)

local block = false


function packetLossCheck()
    local packet = getNetworkStats()["packetlossLastSecond"]   
	if (packet > 5) then
		destroySell = true
		interactStat = false
		packetTimer = setTimer(function() destroySell = false end, 1000*10, 1) --- spam védelem
    end
end
setTimer(packetLossCheck, 50, 0)

addEventHandler("onClientColShapeHit", getRootElement(),
	function(player)
		if player ~= getLocalPlayer() then return end
		if source and getElementData(source, "sell >> hunter") then 
			getPlayerItem()
		end
	end
)

function getPlayerItem()
	triggerServerEvent("sell:hunter", localPlayer, localPlayer)
end

-- addEventHandler("onClientClick", root,
    -- function(b, s, _,_,_,_,_, e)
		  -- if b == "left" and s == "down" and e and getElementType(e) == "ped" and getElementData(e,"hunter:receiver") and not destroySell then
			-- block = true
			-- local x,y,z = getElementPosition(e)
			-- local px,py,pz = getElementPosition(localPlayer)
			-- local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			-- if isTimer(packetTimer) then return end
			-- if isTimer(clickTimer) then return end
			-- if d < maxInteract then
				-- local whatTake = getElementData(e, "hunter:type")
				-- clickTimer = setTimer(function() end, 2000, 1)

				-- for k,v in pairs(itemReceivers) do
					-- found = false
					-- itemID = itemReceivers[k][whatTake]
					-- money = itemReceivers[k][whatTake + 2]
					-- name = itemReceivers[k][5]
					-- nameType = "Ismeretlen"
					-- --outputChatBox(itemID)
					-- if whatTake == 1 then
						-- nameType = "bőr"
					-- elseif whatTake == 2 then
						-- nameType = "trófea"
					-- end
					-- --outputChatBox(k)
					-- --outputChatBox(itemID)
					-- local hasItems, slot, a, c = exports.bgo_items:hasItem(localPlayer, itemID)
					-- if hasItems then
						-- -- outputChatBox(itemID.."_2")
						-- triggerServerEvent("bgoMTA->#deleteItem", localPlayer, localPlayer, exports['bgo_items']:getItemType(itemID), slot)
						-- giveMoney(localPlayer, money)
						-- outputChatBox("#53bfcd[Vadászat]: #ffffffSikeresen leadtad a #00AEFF"..name.." "..nameType.."#ffffff nevezetű tárgyat, #7cc576"..money.." #ffffffForintért!", 255, 255, 255, true)
					-- end
				-- end
			-- end
		-- end
	-- end
-- )