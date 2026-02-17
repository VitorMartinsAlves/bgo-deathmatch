
local sX, sY = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (sX/resW), (sY/resH)




local mapKey = "F11"
local scaleB = 0.8
local maxScale = 2.05
local minScale = 0.2
local scale = 0.8
local bSize = 25
local blipNames = {}
local showBigMap = false
local texture = dxCreateTexture( "files/map.png", "dxt5", true, "clamp", "3d")
local font = dxCreateFont('files/Calibri.ttf', 11)
local font2 = dxCreateFont('files/Calibri.ttf', 10)
local font3 = dxCreateFont('files/Calibri.ttf', 15)
local comy = dxCreateFont('files/font.ttf', 15)
-- dxSetTextureEdge( texture, "border", tocolor(43, 72, 100))
-- local texture = dxCreateTexture("files/map.jpg")
imageWidth, imageHeight = dxGetMaterialSize(texture)
local mozgatAdat = {0,0}
local honnanMozgat = {0,0}
local showMinimap = true
setElementData(localPlayer,"char >> 3dBlip",true)
 



addEventHandler("onClientRender",root,
    function()	
		setPlayerHudComponentVisible( "radar", false )	
		if (getElementData(localPlayer,"screen")) then
			return
		end		
		if (getElementData(localPlayer,"loggedin") == false) then
			return
		end		
		if (getElementInterior(localPlayer) ~= 0) then
			return
		end
		if not (showMinimap) then
			return
		end
		if (showBigMap) then
			return
		end	

	local width, height = sx*250,sy*150

	local posX = sx*5
	local posY = sY-height

		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		if not theVehicle then
			return
		end	
		--if not isPlayerHudComponentVisible("radar")then
		
		--end
		local px ,py, pz = getElementPosition( localPlayer )
		local mapX = px / ( 6000 / imageWidth ) + ( imageWidth / 2 ) - ( width / scale / 2 ) + 8
		local mapY = py / (-6000 / imageHeight) + (imageHeight / 2) - ( height / scale / 2 ) + 8
		local imageUnit = 3072/6000*scale 	
		local _, _, pRZ = getElementRotation(localPlayer)
		--dxDrawRectangle(posX+7, posY-24, width-9, 30, tocolor(0,0,0, 80))
		--dxDrawRectangle(posX+6, posY+1, width-9, 5, tocolor(0,0,0, 150))
		dxDrawRectangle(posX+9, posY+6, width-12, height-13, tocolor(65,131,215, 255))
		dxDrawRectangleBox(posX+10, posY+6, width-14, height-14, tocolor(0,0,0, 150))
		
		dxDrawImageSection( posX + 15/2 + 2, posY + 11.9/2, (width - 13), (height - 13), mapX, mapY, (width - 13) / scale, (height - 13) / scale, texture, 0, 0, 0, tocolor( 255, 255, 255, 255 ), false )
		
		for k, i in ipairs(getElementsByType("blip")) do
			bSize = 20
			local bX, bY, bZ = getElementPosition(i)
			local pX, pY, pZ = getElementPosition(localPlayer)
			local bIcon = getBlipIcon(i)
			--local br, bg, bb = getBlipColor(i) or 255,255,255
			local _, _, _, bcA = getBlipColor(i)
				local br, bg, bb = 255, 255, 255
				if getBlipIcon(i) == 0 then
					br, bg, bb = getBlipColor(i)
				end
				if getBlipIcon(i) == 61 then
					br, bg, bb = getBlipColor(i)
				end
				
		local timeNow = getTickCount()
		local alpha = (timeNow % 510)
		if alpha > 255 then
			alpha = 255 - (alpha - 255)
		end
		local color = tocolor(255,255,255, alpha)
				
			if getElementData(i, "blip:maxVisible") then
				if (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) <= posY + 13/2 then
					dY = posY + 13/2
				elseif (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) >= posY + 13/2 + (height - 13 - bSize) - 20 then
					dY = posY + 13/2 + (height - 13 - bSize) - 20
				else
					dY = posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2
				end	
				if ((posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) <= posX + 13/2) then
					dX = posX + 13/2
				elseif ((posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) >= posX + 13/2 + (width - 13 - bSize)) then
					dX = posX + 13/2 + (width - 13 - bSize)
				else
					dX = (posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) - bSize/2
				end
				dxDrawImage(dX, dY, bSize, bSize, "blips/" .. bIcon .. ".png", 0, 0, 0, tocolor(br, bg, bb, 255), true)
			else
				local minBH = (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) > posY + 13/2
				local minBW = (posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) > posX + 13/2
				local maxBH = (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) < posY + 13/2 + (height - 13 - bSize)
				local maxBW = (posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) < posX + 13/2 + (width - 13 - bSize) 			
				if minBH and minBW and maxBH and maxBW then

		if getBlipIcon(i) == 1 then
			bS = alpha * 0.2
			--dxDrawImage(posX + 13-bS/2 + (width - 13)/2 + (bX - pX) * imageUnit - bSize/2  , posY + 13-bS/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2 , bS, bS, "blips/1.png", 0, 0, 0, color, false)

						dxDrawImage(posX + 13-bS/2 + (width - 13)/2 + (bX - pX) * imageUnit - bSize/2, posY + 13-bS/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2, bS, bS, "blips/" .. bIcon .. ".png", 0, 0, 0, tocolor(br, bg, bb, bcA), false)


		else

						dxDrawImage(posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit - bSize/2, posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2, bSize, bSize, "blips/" .. bIcon .. ".png", 0, 0, 0, tocolor(br, bg, bb, bcA), false)


		end
		
		
		

				end
			end
		end
		
		
		for k, i in ipairs(getElementsByType("radararea")) do
			local pX, pY, pZ = getElementPosition(localPlayer)
			local aX, aY, aZ = getElementPosition(i)
			local aW, aH = getRadarAreaSize(i)
			local aR, aG, aB, aA = getRadarAreaColor(i)	
			local minAH = (posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit) > posY + aH/2
			local minAW = (posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit) > posX + aW/2
			local maxAH = (posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit) < posY + 13/2 + (height - aH)
			local maxAW = (posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit) < posX + 13/2 + (width - aW)	
			if minAH and minAW and maxAH and maxAW then	
				if isRadarAreaFlashing(i) then
					aA = aA*math.abs(getTickCount()%1000-500)/500
					dxDrawRectangle(posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit - 13, posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit - 13, aW, aH, tocolor(aR, aG, aB, aA))				
				else
					dxDrawRectangle(posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit - 13, posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit - 13, aW, aH, tocolor(aR, aG, aB, 150))			
				end
			end
		end
		
		dxDrawImage(posX + width/2 + (px - px) * imageUnit - 10 - imageUnit/2, posY + height/2 + (py - py ) * imageUnit - 10 - imageUnit/2, 20, 20, "files/arrow.png", -pRZ, 0, 0, tocolor(255, 255, 255, 255), true)
		--local pX, pY, pZ = getElementPosition(localPlayer)
		--local zoneName = getZoneName(pX, pY, pZ)
		--local GlobalzoneName = getZoneName(pX, pY, pZ, true)
		--dxDrawText(GlobalzoneName .. ": #ffffff"..zoneName.."", posX+35, posY-24+30/2, width-4, posY-24+30/2, tocolor(255, 255, 255, 255), 1, font, "left", "center", false, false, false, true) 
--[[
		local color = "#ffffff"
		if getCurrentFPS() and showfps then 
			if showfps < 30 then 
				color = "#D24D57"
			elseif showfps >= 30 and showfps < 50 then 
				color = "#ffa700"
			elseif showfps > 50  then 
				color = "#7cc576"
			end
			dxDrawText("FPS: ".. color .. math.floor(showfps), posX-6+(width-4), posY-24+30/2, posX-6+(width-4), posY-24+30/2, tocolor(255, 255, 255, 255), 1, font, "right", "center", false, false, false, true)
		end
		]]--
		--dxDrawImage(posX+12, posY-28+18/2, 18, 18, "files/logo.png", tocolor(255 ,255 ,255 ,255))
	end
)

-- setRadarAreaFlashing(radararea, true)

--F11
addEventHandler("onClientRender", getRootElement(),
	function()
		if (getElementInterior(localPlayer) ~= 0) then
			return
		end
		
		if (getElementData(localPlayer,"loggedin") == false) then
			return
		end
		
		if (showBigMap == false) then
			return
		end	
		if(honnanMozgat[1] ~= 0 or honnanMozgat[2] ~= 0) then
			local kx, ky = getCursorPosition ( )
			if(kx and ky) then
				kx, ky = kx*sX, ky*sY
				mozgatAdat = {kx-honnanMozgat[1], ky-honnanMozgat[2]}
				mozgatAdat = {math.max(math.min(-mozgatAdat[1], 3072),-3072), math.max(math.min(mozgatAdat[2], 3072), -3072)}
				pX = mozgatAdat[1]
				pY = mozgatAdat[2]
			end
		end
		posX, posY, width, height = 25, 25, sX - 50, sY - 50
		local mapX = pX / ( 6000 / imageWidth ) + ( imageWidth / 2 ) - ( width / scaleB / 2 ) + 5
		local mapY = pY / (-6000 / imageHeight) + (imageHeight / 2) - ( height / scaleB / 2 ) + 5
		local plX, plY, plZ = getElementPosition(localPlayer)
		local rX, rY, player_rz = getElementRotation(localPlayer)		
		local imageUnit = 3072/6000*scaleB
		if scaleB <= 0.8 then 
			dxDrawRectangleBox(sX/2-650/2, sY-50, 400, 35, tocolor(0,0,0, 255))
			dxDrawRectangle(sX/2-650/2, sY-50, 400, 35, tocolor(0,0,0, 150))			
			
			dxDrawRectangleBox(sX/2-650/2+405, sY-50, 200, 35, tocolor(0,0,0, 255))
			dxDrawRectangle(sX/2-650/2+405, sY-50, 200, 35, tocolor(0,0,0, 150))
			dxDrawImage(sX/2-650/2, sY-50, 32, 32, "files/mouse.png", tocolor(255 ,255 ,255 ,255))
			dxDrawText("Mover o radar", sX/2-650/2+30, sY-50+35/2, 540, sY-50+35/2, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true)
			dxDrawText("Zoom no radar", sX/2-650/2+240, sY-50+35/2, 740, sY-50+35/2, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true)
			dxDrawText("Blip 3D:", sX/2-650/2+410, sY-50+35/2, 740, sY-50+35/2, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true)

			if getElementData(localPlayer,"char >> 3dBlip") then
				status3D = "Desligar"
				color = {215,85,85}
			else
				status3D = "Ligar"
				color = {124,197,118}
			end
			dxDrawRectangle(sX/2-650/2+480, sY-48, 105, 30, tocolor(color[1],color[2],color[3], 200))
			dxDrawText(status3D, sX/2-650/2+500, sY-50+35/2, 740, sY-50+35/2, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true)

			dxDrawImage(sX/2-650/2+200, sY-50, 32, 32, "files/mouse2.png", tocolor(255 ,255 ,255 ,255))
		end
		dxDrawImageSection( posX + 13/2 + 1, posY + 13/2, (width - 13), (height - 13), mapX, mapY, (width - 13) / scaleB, (height - 13) / scaleB, texture, 0, 0, 0, tocolor( 255, 255, 255, 255 ), false )		
		for k, i in ipairs(getElementsByType("blip")) do
			local bX, bY, bZ = getElementPosition(i)
			local bIcon = getBlipIcon(i)
				local br, bg, bb = 255, 255, 255
				local _, _, _, bcA = getBlipColor(i)
				if getBlipIcon(i) == 0 then
					br, bg, bb = getBlipColor(i)
				end
				if getBlipIcon(i) == 61 then
					br, bg, bb = getBlipColor(i)
				end
				
		local timeNow = getTickCount()
		local alpha = (timeNow % 510)
		if alpha > 255 then
			alpha = 255 - (alpha - 255)
		end
		local color = tocolor(255,255,255, alpha)


			if getElementData(i, "blip:maxVisible") then
				if (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) <= posY + 13/2 then
					dY = posY + 13/2
				elseif (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) >= posY + 13/2 + (height - 13 - 20) then
					dY = posY + 13/2 + (height - 13 - 20)
				else
					dY = posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit  - bSize/2
				end	
				if ((posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) <= posX + 13/2) then
					dX = posX + 13/2
				elseif ((posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) >= posX + 13/2 + (width - 13 - 20)) then
					dX = posX + 13/2 + (width - 13 - 20)
				else
					dX = (posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) - bSize/2
				end
				dxDrawImage(dX, dY, 20, 20, "blips/" .. bIcon .. ".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
			else
				local minBH = (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) > posY + 13/2
				local minBW = (posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) > posX + 13/2
				local maxBH = (posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit) < posY + 13/2 + (height - 13 - 20)
				local maxBW = (posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit) < posX + 13/2 + (width - 13 - 20)			
				if minBH and minBW and maxBH and maxBW then	

		if getBlipIcon(i) == 1 then
			bS = alpha * 0.1
			dxDrawImage(posX + 13-bS/2 + (width - 13)/2 + (bX - pX) * imageUnit - bSize/2  , posY + 13-bS/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2 , bS, bS, "blips/1.png", 0, 0, 0, color, false)
		else
			dxDrawImage(posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit - bSize/2, posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2, 20, 20, "blips/" .. bIcon .. ".png", 0, 0, 0, tocolor(br, bg, bb, bcA), false)
		end
		

					if isInSlot(posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit - bSize/2, posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit - bSize/2, 20, 20) then
						if getElementData(i, "blipName") or false then
							blipNeve = getElementData(i, "blipName")
						elseif blipNames[bIcon] then
							blipNeve = blipNames[bIcon]
						else
							blipNeve = "Não disponível"
						end
						TextWidth = dxGetTextWidth(blipNeve,1,font)
						dxDrawText(blipNeve,posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit+10, posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit + 20, TextWidth + 10 + posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit - 13, 20 + posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit + 20,tocolor(255,255,255,255),1,font,"center","center",false,false,true,true)	
		
						dxDrawRectangle(posX + 13/2 + (width - 13)/2 + (bX - pX) * imageUnit, posY + 13/2 + (height - 13)/2 + (pY - bY) * imageUnit + 20, TextWidth + 10, 20,tocolor(0,0,0,180))				
					end
				end
			end
		end
		--[[
		for k, i in ipairs(getElementsByType("radararea")) do
			local aX, aY, aZ = getElementPosition(i)
			local aW, aH = getRadarAreaSize(i)
			local aR, aG, aB, aA = getRadarAreaColor(i)	
			local minAH = (posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit - 13) > posY + 13/2
			local minAW = (posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit - 13) > posX + 13/2
			local maxAH = (posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit - 13) < posY + 13/2 + (height - 13 - 20)
			local maxAW = (posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit - 13) < posX + 13/2 + (width - 13 - 20)	
			if minAH and minAW and maxAH and maxAW then	
				if isRadarAreaFlashing(i) then
					aA = aA*math.abs(getTickCount()%1000-500)/500
					dxDrawRectangle(posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit - 13, posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit - 13, (aW*scaleB), (aH*scaleB), tocolor(aR, aG, aB, aA))				
				else
					dxDrawRectangle(posX + 13/2 + (width - 13)/2 + (aX - pX) * imageUnit - 13, posY + 13/2 + (height - 13)/2 + (pY - aY) * imageUnit - 13, (aW*scaleB), (aH*scaleB), tocolor(aR, aG, aB, 150))			
				end
			end
		end	]]--
		dxDrawImage(posX + width/2 + (plX - pX) * imageUnit - (10/scale) + scale +2, posY + height/2 + (pY - plY ) * imageUnit - (10.5/scale) + scale +2, 30, 31, "files/arrow.png", 360-player_rz, 0, 0, tocolor(255 ,255 ,255 ,255), false)
		--dxDrawText(scaleB, sX/2-650/2+30, sY-50+35/2, 540, sY-50+35/2, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true)


		--dxDrawImage(posX + width/2 + (plX - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - plY ) * imageUnit - (10.5/scale) + scale, 20, 21, "blips/63.png", 360-player_rz, 0, 0, tocolor(255 ,255 ,255 ,255), false)
		
		if getElementData(localPlayer,"char:adminduty") == 1 and getElementData(localPlayer, 'acc:admin') >= 1 then
			for k,v in ipairs(getElementsByType("player")) do
				if v ~= localPlayer then	
					if v ~= getLocalPlayer() and isElement(v) then
						if getElementData(v,"loggedin") then
						local rot = getPedRotation( v )
							local tx,ty = getElementPosition(v)
							--[[
							if getElementData(v, 'acc:admin') >= 1 then
							dxDrawImage(posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale, 20, 21, "blips/2.png", 360, 0, 0, tocolor(255 ,255 ,255 ,255), false)

							else
							dxDrawImage(posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale, 20, 21, "blips/2.png", 360, 0, 0, tocolor(255 ,255 ,255 ,255), false)
							end
							]]--
							
							if getElementData(v,"char:adminduty") == 1 and tonumber(getElementData(v, 'acc:admin') or 0) >= 1 and tonumber(getElementData(v, 'acc:admin') or 0) < 7 then
							dxDrawImage(posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale, 20, 21, "blips/2.png", -rot, 0, 0, tocolor(0,255,13 ,255))
							else
							if getElementData(v,"char:adminduty") == 0 then
							dxDrawImage(posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale, 20, 21, "blips/2.png", -rot, 0, 0, tocolor(255,0,0 ,255))
							end
							end
							
							
					
							if getElementData(v,"char:adminduty") == 1 and tonumber(getElementData(v, 'acc:admin') or 0) >= 7 then
							else
							if isInSlot(posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale, 20, 21) then
								isInti = ""
								if getElementDimension(v) > 0 then
									isInti = "{INTERIOR}"
								end
								local szoveg = "("..getElementData(v, "acc:id")..") "..getPlayerName(v):gsub("_", " ") .. " "..isInti
								local szovegHossz = dxGetTextWidth(szoveg, 1, font)+10
								dxDrawRectangle(posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale+21, szovegHossz, 21,tocolor(0,0,0,150))
								dxDrawText(szoveg,posX + width/2 + (tx - pX) * imageUnit - (10/scale) + scale, posY + height/2 + (pY - ty ) * imageUnit - (10.5/scale) + scale+21,0,0,tocolor(255,255,255,255),1,font, "left", "top")
							end
							end
						end
					end
				end
			end
		end
		
		-- dxDrawRectangle(0, sY-30, sX, 30, tocolor(0, 0, 0, 150))
	end
)

addEventHandler("onClientKey", getRootElement(), 
	function(k, v)
		if not v then
			return
		end
		if getElementData(localPlayer, 'loggedin') == false  then
			return
		end
		if (getElementData(localPlayer,"radarshow") == 0) then
			return
		end	
		if (k == mapKey) then
			cancelEvent()
			showChat(false)
			setElementData(localPlayer,"screen", true)
			if (showBigMap) then
				showBigMap = false
				showChat(true)
				setElementData(localPlayer,"screen", false)
			else
				pX, pY, pZ = getElementPosition(localPlayer)
				showBigMap = true
				showChat(false)
				setElementData(localPlayer,"screen", true)	
			end
		elseif (k == "mouse_wheel_up") and showBigMap then 
			if scaleB + 0.1 <= maxScale then
				scaleB = scaleB + 0.1
			end			
		elseif (k == "mouse_wheel_down") and showBigMap then 
			if scaleB - 0.1 >= minScale then
				scaleB = scaleB - 0.1
			end				
		end
	end
)

--[[
addEventHandler("onClientElementDataChange", root, function(data)
    if (source==localPlayer) then
	
	if (data == 'loggedin')then
		if getElementData(localPlayer, 'loggedin') == true  then
			showMinimap = true
		else
			showMinimap = false
		end
	end
	
    end
end)
]]--
--[[
addEventHandler("onClientRender",getRootElement(),function()
	if getElementData(localPlayer,"char >> 3dBlip") then
		local playerX,playerY = getElementPosition(localPlayer)
		for k, i in ipairs(getElementsByType("blip")) do
			local blipX,blipY,blipZ = getElementPosition(i)
			local bIcon = getBlipIcon(i)
			local br, bg, bb = getBlipColor(i)
			local distance = getDistanceBetweenPoints2D(blipX, blipY, playerX, playerY)
			if getElementData(i,"blip >> blipOnScreen") then
				local x,y,z = getScreenFromWorldPosition ( blipX,blipY,blipZ )
				if x and y and tonumber(math.floor(distance)) < 1000 then
					dxDrawImage(x,y,30,30,"blips/".. bIcon .. ".png",0,0,0,tocolor(br, bg, bb,255),true)
					if getElementData(i, "blipName") or false then
						blipNeve = getElementData(i, "blipName")
					elseif blipNames[bIcon] then
						blipNeve = blipNames[bIcon]
					else
						blipNeve = "Não disponível"
					end
					
					local text = tostring(math.floor(distance)) .. " m"
					dxDrawText(blipNeve.. "\n"..text,x+15,y+30,x+15,y+30,tocolor(255,255,255,255),1,font,"center","top")
				end
			end
		end
	end
end)

]]--
addEventHandler("onClientRender",getRootElement(),function()
	if getElementData(localPlayer,"char >> 3dBlip") then
		for k, i in ipairs(getElementsByType("blip")) do
			if getElementData(i,"blip >> blipOnScreen") then
			local blipX,blipY,blipZ = getElementPosition(i)
			local bIcon = getBlipIcon(i)
			local br, bg, bb = getBlipColor(i)
			local playerX,playerY = getElementPosition(localPlayer)
			local distance = getDistanceBetweenPoints2D(blipX, blipY, playerX, playerY)
				local x,y,z = getScreenFromWorldPosition ( blipX,blipY,blipZ )
				if x and y and tonumber(math.floor(distance)) < 1000 then
					dxDrawImage(x,y,30,30,"blips/"..bIcon..".png",0,0,0,tocolor(br, bg, bb,255),true)					
					local text = tostring(math.floor(distance)) .. " m"
					dxDrawText(text,x+15,y+30,x+15,y+30,tocolor(255,255,255,255),1,"default-bold","center","top")
				end
			end
		end
	end
end)

addCommandHandler('togradar', function()
	showMinimap = not showMinimap
end)

function nagyMapKattintas ( gomb, statusz, x, y, ... )
	if(showBigMap) then
		if(gomb == "left") then
			if(statusz == "down") then
				if mozgatAdat[1] == 0 and mozgatAdat[2] == 0 then
					local pX, pY, pZ = getElementPosition(localPlayer)
					mozgatAdat[1] = pX
					mozgatAdat[2] = pY
					honnanMozgat = {x+mozgatAdat[1],y-mozgatAdat[2]}
				else
					honnanMozgat = {x+mozgatAdat[1],y-mozgatAdat[2]}
				end
			end
			if(statusz == "up") then
				honnanMozgat = {0,0}
			end
		end
		if(gomb == "left" and statusz == "down") then
			if isInSlot(sX/2-650/2+480, sY-55, 105, 30) then
				if getElementData(localPlayer,"char >> 3dBlip") then
					setElementData(localPlayer,"char >> 3dBlip",false)
				else
					setElementData(localPlayer,"char >> 3dBlip",true)
				end
			end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), nagyMapKattintas )

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

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 200);
		end
		
		if (not bgColor) then
			bgColor = borderColor;
		end
		
		--> Background
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		
		--> Border
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI); -- top
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI); -- bottom
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI); -- left
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI); -- right
	end
end


function dxDrawRectangleBox(left, top, width, height, color)
	--dxDrawRectangle(left, top, width, height, tocolor(151, 61, 83,50))
	dxDrawRectangle(left-4, top-4, 4, height+8, color) -- Bal
	dxDrawRectangle(left+width, top-4, 4, height+8, color) -- Jobb
	dxDrawRectangle(left, top-4, width, 4, color)
	dxDrawRectangle(left, top+height, width, 4, color)
end

--------------------
---SZERVER BLIPEK---
--------------------
--north = createBlip( 733.1318359375, 3700.951171875, -200, 4, 2, 255, 255, 255, 255) -- észak blip
--setBlipOrdering ( north,  -2000 )
--setElementData(north, "blip:maxVisible", true)

--------------------
--[[
setTimer(function()
	showfps = getCurrentFPS()
end,1000,0)

local fps = false
function getCurrentFPS()
    return fps
end

function updateFPS(msSinceLastFrame)
    fps = (1 / msSinceLastFrame) * 1000
end
addEventHandler("onClientPreRender", root, updateFPS)
]]--