local font = dxCreateFont('files/calibris.ttf', 10)
-- local font = 'default'

-- local hit = 1000
local hit = 10
local ppHit = 20

local sellPed = {}
local sellCol = {}

local sellPos = {
	{156, 1234.7646484375, -1158.0845947266, 23.541213989258, "John", 0, 3, 3, 2, 0, 0}
}

function createSellPed()
	for index, value in ipairs (sellPos) do 
		if isElement(sellPed[index]) then destroyElement(sellPed[index]) end
		if isElement(sellCol[index]) then destroyElement(sellCol[index]) end
		sellPed[index] = createPed(value[1], value[2], value[3], value[4])
		
		local blip = createBlipAttachedTo ( sellPed[index], 25 )
		setElementData(blip,"blipName", "Comprador de minério")
	
		


		setElementInterior(sellPed[index], value[10])
		setElementDimension(sellPed[index], value[11])
		setPedRotation(sellPed[index], value[6])
		setElementData(sellPed[index], "Ped:Name", value[5])
		setElementData(sellPed[index], "name:tags", "Comprador de minério")	
		setElementData(sellPed[index], "ped >> death", true)		
		setElementFrozen(sellPed[index], true)
		sellCol[index] = createColCuboid(value[2]-value[7]/2, value[3]-value[8]+3, value[4]-0.5, value[7], value[8], value[9])
		setElementData(sellCol[index], "sell >> ore", true)
		setElementInterior(sellCol[index], value[10])
		setElementDimension(sellCol[index], value[11])
	end
end
createSellPed()


addEventHandler("onClientRender", root, function()
	for k,v in ipairs(getElementsByType("object", getResourceRootElement(getThisResource()), true)) do
		if isElement(v) and tonumber(getElementData(v, 'stone >> ID') or 0) > 0 then 
			local x, y ,z = getElementPosition(v)
			local wx, wy, wz = getScreenFromWorldPosition(x , y, z)
			if wx and wy then
				local playerx, playery, playerz = getElementPosition(getLocalPlayer())
				if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 6 then
					local stone_HP = (getElementData(v, 'stone >> Health') or 0)
					if stone_HP > 0 then
						if not getElementData(v, 'Dono >> stone') == false then
						dxDrawRectangle(wx-200/2,wy,200,30,tocolor(0,0,0,170))
						dxDrawRectangle(wx-200/2+2,wy+2, (stone_HP/1000)*(200 - 4) ,26,tocolor(124, 197, 118, 190))
						dxDrawText(math.floor(stone_HP/10) .. '% - Já tem um dono!',  wx-200/2 + 200/2+1, wy+30/2, wx-200/2 + 200/2+1, wy+30/2, tocolor(0, 0, 0,255),1, font, "center","center",false,false,false,true,false)
						dxDrawText(math.floor(stone_HP/10) .. '% - Já tem um dono!', wx-200/2 + 200/2, wy+30/2, wx-200/2 + 200/2, wy+30/2, tocolor(255, 255, 255,255),1, font, "center","center",false,false,false,true,false)

						else
						dxDrawRectangle(wx-200/2,wy,200,30,tocolor(0,0,0,170))
						dxDrawRectangle(wx-200/2+2,wy+2, (stone_HP/1000)*(200 - 4) ,26,tocolor(124, 197, 118, 190))
						dxDrawText(math.floor(stone_HP/10) .. '% - Sem Dono',  wx-200/2 + 200/2+1, wy+30/2, wx-200/2 + 200/2+1, wy+30/2, tocolor(0, 0, 0,255),1, font, "center","center",false,false,false,true,false)
						dxDrawText(math.floor(stone_HP/10) .. '% - Sem Dono', wx-200/2 + 200/2, wy+30/2, wx-200/2 + 200/2, wy+30/2, tocolor(255, 255, 255,255),1, font, "center","center",false,false,false,true,false)
						end
					end
				end
			end
		end
	end
end, true, "low-5")


addEventHandler("onClientObjectDamage", getRootElement(), function(loss, attacker)
	if isTimer(minerTImer) then
		return
	end
	
	if (tonumber(getElementData(source, 'stone >> ID')) or 0) > 0 and getPedWeapon(localPlayer) == 11 and getElementModel(source) == 868 then

		local count = getPlayerCount()
		if count > 160 then

 
		if attacker == localPlayer then
			local health = getElementData(source, 'stone >> Health') or 1000
			if health <= hit then 
			if getElementData(source, 'Dono >> stone') == getElementData(localPlayer, "char:id") then	
				addEventHandler("onClientRender", root, dxH)
				House = true
				triggerServerEvent("bgoMTA->#DonoOFF", localPlayer, localPlayer)
				
				--SellOre3()
				
				--triggerServerEvent('bgoMTA->#giveOre', attacker, attacker)
				setElementData(source, 'stone >> Health', health - hit)
				local sound = playSound("files/crash.mp3", false)
				setSoundVolume(sound, 0.1)
				end
			else
			if getElementData(source, 'Dono >> stone') == getElementData(localPlayer, "char:id") then
				minerTImer = setTimer(function() end,4000,1)
				playSound("files/pickaxe.mp3", false)
				setElementData(source, 'stone >> Health', health - hit)
			else
			if  getElementData(localPlayer, "donopedra") == false then
			if  getElementData(source, 'Dono >> stone') == false then 
				triggerServerEvent("bgoMTA->#Dono", localPlayer, localPlayer)
				
				--SellOre2()
				
				minerTImer = setTimer(function() end,4000,1)
				playSound("files/pickaxe.mp3", false)
				setElementData(source, 'stone >> Health', health - hit)
			else
				outputChatBox("[bgoMTA ~ Miner]: #ffffffEsta pedra ja tem um dono para quebra-la!", 124, 197, 118, true)
				end
			else
				outputChatBox("[bgoMTA ~ Miner]: #ffffffVocê ja tem uma pedra para quebra-la seja humilde!", 124, 197, 118, true)

			end
		end
	end		
end

else
outputChatBox("[bgoMTA ~ Miner]: #ffffffPrecisa ter 160 jogadores na cidade para minerar!!", 124, 197, 118, true)
end


elseif (tonumber(getElementData(source, 'stone >> ID')) or 0) > 0 and getPedWeapon(localPlayer) == 10 and getElementModel(source) == 868 then

		local count = getPlayerCount()
		if count > 160 then


		if attacker == localPlayer then
			local health = getElementData(source, 'stone >> Health') or 1000
			if health <= ppHit then 
			if getElementData(source, 'Dono >> stone') == getElementData(localPlayer, "char:id") then			
				addEventHandler("onClientRender", root, dxH)
				House = true
				triggerServerEvent("bgoMTA->#DonoOFF", localPlayer, localPlayer)
				
				--SellOre3()
				setElementData(source, 'stone >> Health', health - ppHit)
				
				outputChatBox("[bgoMTA ~ Miner]: #ffffffVida da pedra: "..health - ppHit.." ", 124, 197, 118, true)
				
				
				local sound = playSound("files/crash.mp3", false)
				setSoundVolume(sound, 0.1)
				end
			else

				if getElementData(source, 'Dono >> stone') == getElementData(localPlayer, "char:id") then
					minerTImer = setTimer(function() end,4000,1)
					playSound("files/pickaxe.mp3", false)
					setElementData(source, 'stone >> Health', health - ppHit)
					
					outputChatBox("[bgoMTA ~ Miner]: #ffffffVida da pedra: "..health - ppHit.." ", 124, 197, 118, true)
					
					
				else

				if getElementData(localPlayer, "donopedra") == false then
				if getElementData(source, 'Dono >> stone') == false then 
					triggerServerEvent("bgoMTA->#Dono", localPlayer, localPlayer)
					--SellOre2()
					minerTImer = setTimer(function() end,4000,1)
					playSound("files/pickaxe.mp3", false)
					setElementData(source, 'stone >> Health', health - ppHit)
					
					outputChatBox("[bgoMTA ~ Miner]: #ffffffVida da pedra: "..health - ppHit.." ", 124, 197, 118, true)
					
					
				else
					outputChatBox("[bgoMTA ~ Miner]: #ffffffEsta pedra ja tem um dono para quebra-la!", 124, 197, 118, true)
				end
			else
				outputChatBox("[bgoMTA ~ Miner]: #ffffffVocê ja tem uma pedra para quebra-la seja humilde!", 124, 197, 118, true)
			end

		end
	end		
end
else
outputChatBox("[bgoMTA ~ Miner]: #ffffffPrecisa ter 160 jogadores na cidade para minerar!!", 124, 197, 118, true)
end




end


end)

addEventHandler("onClientColShapeHit", getRootElement(),
	function(player)
		if player ~= getLocalPlayer() then return end
		if source and getElementData(source, "sell >> ore") then 
			getPlayerItem()
		end
	end
)

function getPlayerItem()
	triggerServerEvent("bgoMTA->#SellOre", localPlayer, localPlayer)
end

addEventHandler("onClientPlayerStealthKill", getRootElement(), function(targetPlayer) 
	if (getElementType(targetPlayer) == 'ped' and getElementData(targetPlayer, "ped >> death")) then  
		cancelEvent()
	end
end)




local originalGetPlayerCount = getPlayerCount

function getPlayerCount()
    return originalGetPlayerCount and originalGetPlayerCount() or #getElementsByType("player")
end







local screenW2,screenH2  = guiGetScreenSize()
local resW2, resH2       = 1920, 1080
local xS, yS         =  (screenW2/resW2), (screenH2/resH2)

House = false
cor = {}

function dxH ()
		if House then 
        cor[1] = tocolor(48, 248, 48, 85)
     	if isCursorOnElement(xS*35, yS*595, xS*113, yS*28) then cor[1] = tocolor(48, 248, 48, 180) end

        cor[2] = tocolor(255, 40, 40, 88)
     	if isCursorOnElement(xS*163, yS*595, xS*113, yS*28) then cor[2] = tocolor(255, 40, 40, 180) end
		
        dxDrawRectangle(xS*27, yS*508, xS*259, yS*125, tocolor(1, 0, 0, 145), false)
        dxDrawRectangle(xS*27, yS*511, xS*259, yS*36, tocolor(1, 0, 0, 145), false)
        dxDrawText("BGO - Minério", xS*27, yS*508, xS*286, yS*544, tocolor(255, 255, 255, 92), xS*1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("Clique nas opções para definir a ação!", xS*27, yS*554, xS*286, yS*585, tocolor(255, 255, 255, 255), xS*1.10, "default-bold", "center", "top", false, false, false, false, false)
 

		dxDrawRectangle(xS*35, yS*595, xS*113, yS*28, cor[1], false)
        dxDrawRectangle(xS*163, yS*595, xS*113, yS*28, cor[2], false)
        dxDrawText("Pegar", xS*36, yS*597, xS*148, yS*623, tocolor(255, 255, 255, 255), xS*1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Cancelar", xS*164, yS*595, xS*276, yS*621, tocolor(255, 255, 255, 255), xS*1.00, "default-bold", "center", "center", false, false, false, false, false)
end
end

function click (button, state)
     if House then 
         if  state == "down"  then 
         if isCursorOnElement(xS*35, yS*595, xS*113, yS*28) then
             triggerServerEvent('bgoMTA->#giveOre', localPlayer, localPlayer)
			 removeEventHandler("onClientRender", root, dxH)
		     House = false
		 elseif isCursorOnElement(xS*163, yS*595, xS*113, yS*28) then
			 removeEventHandler("onClientRender", root, dxH)
		     House = false
			 end
         end
     end
end
addEventHandler("onClientClick", getRootElement(), click)

--[[
function startDxH (nameAnd)
     if (House == false) then
	     visit = nameAnd
	     addEventHandler("onClientRender", root, dxH)
		 House = true
		 else
	     removeEventHandler("onClientRender", root, dxH)
		 House = false
	 end
end
addEvent("startDxH", true)
addEventHandler("startDxH", root, startDxH)
]]--


function isCursorOnElement(achx,achy,width,height)
if not isCursorShowing () then return end
    local cx, cy = getCursorPosition()
    local cx, cy = (cx*screenW2), (cy*screenH2)
    if (cx >= achx and cx <= achx + width) and (cy >= achy and cy <= achy + height) then
    return true
    else
    return false
    end
end





--[[

local dono = { }
function SellOre2(element)
	for k,v in ipairs(getElementsByType("object", root, true)) do
		if isElement(v) and tonumber(getElementData(v, 'stone >> ID') or 0 ) > 0 then 
			local x, y ,z = getElementPosition(v)
				local playerx, playery, playerz = getElementPosition(localPlayer)
				if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 3 then
				outputChatBox("[bgoMTA ~ Miner]: #ffffffEstá pedra agora é sua!!", 124, 197, 118, true)
				setElementData(v, 'Dono >> stone', getElementData(localPlayer, "char:id"))
				setElementData(localPlayer,"donopedra", true)
				

				dono = setTimer(function()
				setElementData(v, 'Dono >> stone', false)
				setElementData(localPlayer,"donopedra", false)
				end, 190000, 1)
				end
			end
	
		end
end
addEvent("bgoMTA->#Dono", true)
addEventHandler("bgoMTA->#Dono", root, SellOre2)

function SellOre3(element)
	for k,v in ipairs(getElementsByType("object", root, true)) do
		if isElement(v) and tonumber(getElementData(v, 'stone >> ID') or 0 ) > 0 then 
			local x, y ,z = getElementPosition(v)
				local playerx, playery, playerz = getElementPosition(localPlayer)
				if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 3 then
				setElementData(v, 'Dono >> stone', false)
				setElementData(localPlayer,"donopedra", false)				
				--print("[Minério]: (".. getPlayerName(localPlayer) .. ") : ("..getElementData(localPlayer,"acc:id")..") acaba de quebrar um minerio ")
				if isTimer(dono) then
				killTimer(dono)
				end
				end
			end
		end
end
addEvent("bgoMTA->#DonoOFF", true)
addEventHandler("bgoMTA->#DonoOFF", root, SellOre3)]]--