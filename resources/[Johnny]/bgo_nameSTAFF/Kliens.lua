--BGOMTA 2017

if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end
if fileExists("Kliens.luac") then
	fileDelete("Kliens.luac")
end

function unfuck(text)
	return string.gsub(text, "(#%x%x%x%x%x%x)", function(colorString) return "" end)
end

function drawHPBar( x, y, v, d)
	if(v < 0.0) then
		v = 0.0
	elseif(v > 100.0) then
		v = 100.0
	end
	dxDrawRectangle(x - 21, y, 42, 8, tocolor ( 0, 0, 0, 255 ))
	dxDrawRectangle(x - 20, y + 1, v/2.5 , 6, tocolor ( 255, 0, 0, 255 ))
end

function drawArmourBar( x, y, v, d)
	if(v < 0.0) then
		v = 0.0
	elseif(v > 100.0) then
		v = 100.0
	end
	dxDrawRectangle(x - 21, y , 42, 8, tocolor ( 0, 0, 0, 255 ))
	dxDrawRectangle(x - 20, y + 1, v/2.5 , 6, tocolor ( 255, 255, 255, 255 ))

end

local drawDistance = 200

function onClientRender( )
	                			local cx, cy, cz, lx, ly, lz = getCameraMatrix()

	                			local target = getPedTarget(localPlayer)
								
								local x1,y1,z1 = getElementPosition(localPlayer)
								local tabela = getElementsWithinRange( x1,y1,z1, drawDistance, "player" )
								local player = nil
								for k = 1, #tabela do
								player = tabela[k] 
								if isElement(player) then --and isElementOnScreen(player) then
								if player ~= localPlayer then
				
								local vx, vy, vz = getPedBonePosition(player, 8)
								local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz )
								if dist < drawDistance or player == target then
								local x2,y2,z2 = getElementPosition(player)
								local x, y = getScreenFromWorldPosition (vx, vy, vz + 0.3)
								if(x and y) then
								local name = unfuck(getPlayerName(player))
								local w = dxGetTextWidth(name, 1, "default-bold")
								local h = dxGetFontHeight(1, "default-bold")
								local color = tocolor(255,255,255,255)
								
								if (getElementData(localPlayer, "char:adminduty") == 1) then
								if not getElementData(player, "invisible") then	
								if getElementData(player, "char:adminduty") == 0 then
								
								local health = getElementHealth ( player )
								local armour = getPedArmor ( player )
								
								local weapon = getPedWeapon (player) 
								local weaponID = getWeaponNameFromID (weapon) 
								
								if getSlotFromWeapon ( weaponID ) > 2 then
                                w = dxGetTextWidth(weaponID, 1, "default-bold")
								dxDrawText(weaponID, x - 1  - w / 2,y - 1 - h - 75, w, h, tocolor(0,0,0), 1, "default-bold")
								dxDrawText(weaponID, x - 1  - w / 2,y - h - 75, w, h, tocolor(255, 255, 0), 1, "default-bold")
								end
								
								if(health > 0.0) then
								
								dxDrawText(name.."", x - 1  - w / 2,y - 1 - h - 45, w, h, tocolor(0,0,0), 1, "default-bold" )
								dxDrawText(name.."", x - w / 2,y - h - 45, w, h, color, 1, "default-bold" )
								
								local rate =   math.ceil(500/(getPedStat(player,24)))
								drawHPBar(x, y -32.0, health*rate, dist)
								if(armour > 0.0) then
								drawArmourBar(x, y -42.0, armour, dist)
								end
								else

								dxDrawText(name.."", x - 1  - w / 2,y - 1 - h - 45, w, h, tocolor(0,0,0), 1, "default-bold" )
								dxDrawText(name.."", x - w / 2,y - h - 45, w, h, color, 1, "default-bold" )
								
                                w = dxGetTextWidth("Morto", 1, "default-bold")
								dxDrawText("Morto", x - 1  - w / 2,y - 1 - h - 25, w, h, tocolor(0,0,0), 1, "default-bold")
								dxDrawText("Morto", x - 1  - w / 2,y - h - 25, w, h, tocolor(255,255,155), 1, "default-bold")
								
								end
								end
							end
						end
					end
				end
		end
	end
end
end
addEventHandler("onClientRender", root, onClientRender)