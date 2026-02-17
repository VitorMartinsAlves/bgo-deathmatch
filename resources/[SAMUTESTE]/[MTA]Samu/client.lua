--[[
function ModSamu(attacker, weapon, bodypart)
	if weapon == 23 then return end
	if ( bodypart == 9 ) then
		--cancelEvent()
		triggerServerEvent("OnHS", source, attacker)


		--exports.bgo_admin:outputAdminMessage("#7cc576" .. getPlayerName(source) .. " (" .. getElementData(source, "playerid") .. ") #ffffffAcabou de ser derrubado pelo "..getPlayerName(attacker).."")


	end
end
addEventHandler("onClientPlayerDamage",root,ModSamu)
--]]

local screenW, screenH = guiGetScreenSize()
local resW, resH = 1360,768
local x, y = (screenW/resW), (screenH/resH)

local factionInfo = ''

function text()
    for _, player in ipairs(getElementsByType('player')) do
        if isElementOnScreen(player) and getElementData(player, "PlayerCaido") then
            local x, y, z = getElementPosition(player)
            local cx, cy, cz = getCameraMatrix()
            local vx, vy, vz = getPedBonePosition(player, 8)
            local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz)
            local drawDistance = 30.0
            if (dist < drawDistance or player == target) then
                if(isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false)) then
                    local x, y = getScreenFromWorldPosition (vx, vy, vz + 0.6)
                    if(x and y) then
                        local px, py = getScreenFromWorldPosition (vx, vy, vz + 0.3)
						
						if getElementHealth(player) <= 1 then
							if tonumber(getElementData(player, 'dead.weapon')) or 0 > 1 then 
								if (getElementData(player, 'dead.info')) == 9 then
									factionInfo = "#FFFFFFFoi morto com tiro na cabeça, Arma: #FF0000( #FFFFFF" .. getWeaponNameFromID(getElementData(player, 'dead.weapon')).. " #FF0000)"
								else
									factionInfo = "#FFFFFFFoi morto pela arma: #FF0000( #FFFFFF" .. getWeaponNameFromID(getElementData(player, 'dead.weapon')):gsub('Soco', "Desconhecida"):gsub('Fall', "Desconhecida") .. " #FF0000)"

								end
							end
						else
							factionInfo = ' '
						end
						
						
						local text = "#FFFFFFPRECISANDO DE #FF0000RESGATE#FFFFFF!\n"..factionInfo..""
						
                        local w = dxGetTextWidth(text:gsub("#%x%x%x%x%x%x", ""), 1, "default-bold")
                        local h = dxGetFontHeight(1, "default-bold")
                      -- dxDrawText("#FFFFFFPRECISANDO DE #FF0000RESGATE#FFFFFF!", x - 0  - w / 2,y - 15 - h - 12, w, h, tocolor(255,0,0, math.abs(math.sin(getTickCount()/170))*200), 1, "default-bold", "left", "top", false, false, false, true, false)
                       dxDrawText(text, x - 0  - w / 2,y - 15 - h - 12, w, h, tocolor(255,0,0, math.abs(math.sin(getTickCount()/170))*200), 1, "default-bold", "left", "top", false, false, false, true, false)

                    end
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, text)


addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), function  ( attacker, weapon, bodypart )
	if attacker then
	setElementData(source, 'dead.weapon', 0)
	--setElementData(source, 'dead.info', 0)
	setElementData(source, 'dead.weapon', weapon)
	end
end)

addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), function ()
	setElementData(source, 'dead.weapon', 0)
	--setElementData(source, 'dead.info', 0)
end)




--[[
addEventHandler("onClientElementStreamIn", root,
    function()
        if getElementType(source) == "player" then
            if getElementData(source, "PlayerCaido") then
                if isElementInWater(source) then
                    setTimer(setPedAnimation, 50, 2, source, "ped", "Drown", -1, false, true, false)
					local x,y,z = getElementPosition(source)
					setElementPosition(source, x,y,z)
                else
                    setTimer(setPedAnimation, 50, 2, source, "ped", "FLOOR_hit_f", -1, false, true, false)
					local x,y,z = getElementPosition(source)
					setElementPosition(source, x,y,z)
                end
            end
        end
    end
)
]]--




function ModSamu(attacker, weapon, bodypart)
	if weapon == 23 then return end
	--if ( bodypart == 9 ) then
		--cancelEvent()
		triggerServerEvent("OnDano", source, attacker)
		--exports.bgo_admin:outputAdminMessage("#7cc576" .. getPlayerName(source) .. " (" .. getElementData(source, "playerid") .. ") #ffffffAcabou de ser derrubado pelo "..getPlayerName(attacker).."")
	--end
end
--addEventHandler("onClientPlayerDamage",root,ModSamu)


function abortAllStealthKills(targetPlayer)
    cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", getLocalPlayer(), abortAllStealthKills)




function ModSamu2(attacker, weapon, bodypart)
	if getElementData(source, "PlayerCaido") then	
		cancelEvent()
	end
end
--addEventHandler("onClientPlayerDamage",root,ModSamu2)








function cancelExplode() 
    cancelEvent() 
end 
addEventHandler("onVehicleExplode", root, cancelExplode) 



function handleVehicleDamage(attacker, weapon, loss, x, y, z, tyre) 
    if getElementHealth(source) < 10 then return end 

    if getElementHealth(source) < 300 or (getElementHealth(source)-loss) < 300 then 
        setElementHealth(source, 300) 
        cancelEvent() 
    end 
end 
addEventHandler("onClientVehicleDamage", root, handleVehicleDamage)





local ctrls ={
"sprint",
"jump",
"crouch", 
"next_weapon",
"previous_weapon",
}










local player = localPlayer

function ChecarAnimo2()
	--for i, player in pairs (getElementsByType("player")) do
	if getElementData(player, "algemado") then return end
	if getElementData(player, "char:recuperacao") == true then return end
		if not getElementData(player, "PlayerAnimo") then
			if getElementData(player, "PlayerCaido") then return end
			
				if tonumber(getElementHealth(player)) > 1 then
					if tonumber(getElementHealth(player)) < 50 then 
						setElementData(player, "PlayerAnimo", true)
						--triggerEvent(player,"JoinQuitGtaV:notifications", player,"animo", "Você está desanimado vá para o hospital e tome um remedio!", 15 )

						triggerEvent("JoinQuitGtaV:notifications", player,"animo", "Você está desanimado vá para o hospital e tome um remedio!", 15 )
						for i,v in ipairs(ctrls) do
						toggleControl(v, false)
						end
						triggerServerEvent("andar-desanimado", player, player, 1)
					end
				end
			else
			--setPedWalkingStyle(player,120)
			
			if  getPedWalkingStyle(player) ~= 120 then
			
			triggerServerEvent("andar-desanimado", player, player, 1)
			for i,v in ipairs(ctrls) do
			toggleControl(v, false)
			end		
			end
			
			if getKeyState( "space" ) == true then
			if not getPedAnimation(localPlayer) then
			setPedAnimation(player, "CRACK", "crckidle2", -1, true, false, false)
			triggerServerEvent("anti-bugAnimacao", player, player)
			for i,v in ipairs(ctrls) do
			toggleControl(v, false)
			end	
			end
			else
			--if getPedAnimation(localPlayer) then
            local block, animation = getPedAnimation(player)
            if animation == "crckidle2" then
			--setPedAnimation(player, 'CRACK', 'crckidle2', 0, true, false, false)
			
			
			for i,v in ipairs(ctrls) do
			toggleControl(v, false)
			end	
			setPedAnimation(player)
			triggerServerEvent("anti-bugAnimacaoOFF", player, player)
			
			end
			
			
			
			end
			
			
			
			
		--end
	end
end
setTimer(ChecarAnimo2, 200, 0)

function ChecarAnimo()
	--for i, player in pairs (getElementsByType("player")) do
		if  getElementData(player, "PlayerAnimo") then
			if tonumber(getElementHealth(player)) > 51 then
				setElementData(player, "PlayerAnimo", false)
				setElementData(player, "PlayerCaido", false)
				setPedAnimation(player)
				triggerServerEvent("andar-desanimado", player, player, 2)

				for i,v in ipairs(ctrls) do
				toggleControl(v, true)
				end
			
				setTimer ( setPedAnimation, 100, 1, player,  "GHANDS", "gsign2", 5000, false, false, false)
				setTimer ( setPedAnimation, 250, 1, player, nil)
			--end
		end
	end
end
setTimer(ChecarAnimo, 200, 0)













function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end





function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end



function showHealthPanel(player, state)
	if state == 1 then
		addEventHandler("onClientRender", root, renderHealthPanel)
		showingHealth = true
		showCursor(true)
		
	else
		removeEventHandler("onClientRender", root, renderHealthPanel)
		showingHealth = false
			showCursor(false)

	end
end
addEvent("showHealthPanel", true)
addEventHandler("showHealthPanel", getRootElement(), showHealthPanel)

local monitorSize = {guiGetScreenSize()}
local panelSize = {400, 200}
local panelX, panelY = monitorSize[1]/2-panelSize[1]/2, monitorSize[2]/2-panelSize[2]/2
local cost = 1000
local buttons = {{"Curar"}, {"Fechar"}}
local font = "default-bold" 
function renderHealthPanel()
	if showingHealth then		
		
		dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2], tocolor(0, 0, 0, 180))
		dxDrawRectangle(panelX, panelY, panelSize[1], 25, tocolor(0, 0, 0, 230))
		
		dxDrawText("#FCFCFCBGO MTA - #FC7500Hospital Plano Particular", panelX+400/2, panelY+12.5, panelX+400/2, panelY+12.5, tocolor(0, 0, 0, 230), 1, font, "center", "center", false, false, true, true)
		dxDrawText("#ffffffSe você quer se curar, clique em #FC7500CURAR#ffffff\nO serviço custará #FC7500R$: " .. cost .. "$#ffffff.", panelX+400/2, panelY+50, panelX+400/2, panelY+50, tocolor(0, 0, 0, 230), 1.0, font, "center", "center", false, false, true, true)
		
		for k, v in ipairs(buttons) do
			
			if isInSlot(panelX-175+(k*200), panelY+130, 150, 50) then
				dxDrawRectangle(panelX-175+(k*200), panelY+130, 150, 50, tocolor(252, 117, 0, 230))
			else
				dxDrawRectangle(panelX-175+(k*200), panelY+130, 150, 50, tocolor(0, 0, 0, 230))
			end
			
			dxDrawText(v[1],panelX-301+(k*200)+400/2, panelY+153, panelX-302+(k*200)+400/2, panelY+153, tocolor(255, 255, 255, 230), 1.0, font, "center", "center", false, false, true, true)
		end
	end
end

addEventHandler("onClientClick", root,
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
		
		if button == "left" and state == "down" and showingHealth then
			
			for k, v in ipairs(buttons) do
			
				if dobozbaVan(panelX-175+(k*200), panelY+130, 150, 50, absoluteX, absoluteY) then
					if v[1] == "Fechar" then	
						showHealthPanel(localPlayer, 2)
					elseif v[1] == "Curar" then
						triggerServerEvent("gyogyitPlayer", localPlayer, localPlayer)
						showHealthPanel(localPlayer, 2)
					end
				end
			
			end
		
	
		end
	
	end
)







function showHealthPanelLV(player, state)
	if state == 1 then
		addEventHandler("onClientRender", root, renderHealthPanelLV)
		showingHealth2 = true
		showCursor(true)
		
	else
		removeEventHandler("onClientRender", root, renderHealthPanelLV)
		showingHealth2 = false
			showCursor(false)

	end
end
addEvent("showHealthPanelLV", true)
addEventHandler("showHealthPanelLV", getRootElement(), showHealthPanelLV)
 
local cost2 = 500
function renderHealthPanelLV()
	if showingHealth2 then		
		
		dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2], tocolor(0, 0, 0, 180))
		dxDrawRectangle(panelX, panelY, panelSize[1], 25, tocolor(0, 0, 0, 230))
		
		dxDrawText("#FCFCFCBGO MTA - #FC7500Hospital Plano Particular", panelX+400/2, panelY+12.5, panelX+400/2, panelY+12.5, tocolor(0, 0, 0, 230), 1, font, "center", "center", false, false, true, true)
		dxDrawText("#ffffffSe você quer se curar, clique em #FC7500CURAR#ffffff\nO serviço custará #FC7500R$: " .. cost2 .. "$#ffffff.", panelX+400/2, panelY+50, panelX+400/2, panelY+50, tocolor(0, 0, 0, 230), 1.0, font, "center", "center", false, false, true, true)
		
		for k, v in ipairs(buttons) do
			
			if isInSlot(panelX-175+(k*200), panelY+130, 150, 50) then
				dxDrawRectangle(panelX-175+(k*200), panelY+130, 150, 50, tocolor(252, 117, 0, 230))
			else
				dxDrawRectangle(panelX-175+(k*200), panelY+130, 150, 50, tocolor(0, 0, 0, 230))
			end
			
			dxDrawText(v[1],panelX-301+(k*200)+400/2, panelY+153, panelX-302+(k*200)+400/2, panelY+153, tocolor(255, 255, 255, 230), 1.0, font, "center", "center", false, false, true, true)
		end
	end
end

addEventHandler("onClientClick", root,
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
		
		if button == "left" and state == "down" and showingHealth2 then
			
			for k, v in ipairs(buttons) do
			
				if dobozbaVan(panelX-175+(k*200), panelY+130, 150, 50, absoluteX, absoluteY) then
					if v[1] == "Fechar" then	
						showHealthPanel(localPlayer, 2)
					elseif v[1] == "Curar" then
						triggerServerEvent("gyogyitPlayerLV", localPlayer, localPlayer)
						showHealthPanel(localPlayer, 2)
					end
				end
			
			end
		
	
		end
	
	end
)
