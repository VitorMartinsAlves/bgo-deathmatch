-- // Script Created by Steve Scott // --


local showIcons = true
local marker = nil
local displayWidth, displayHeight = guiGetScreenSize();

local notificationData = {};

local notificationFont = dxCreateFont('files/OpenSansB.ttf', 6 * 2, false);
local infosFont = dxCreateFont('files/opensans.ttf', 5 * 2, false);
local iconsFont = dxCreateFont('files/icons.ttf', 12 * 2, false);



function renderInteriorPanel()
	--if isElement(marker) then
		for k, v in pairs(notificationData) do
			if (v.State == 'fadeIn') then
				local alphaProgress = (getTickCount() - v.AlphaTick) / 650;
				local alphaAnimation = interpolateBetween(0, 0, 0, 255, 0, 0, alphaProgress, 'Linear');

				if (alphaAnimation) then
					v.Alpha = alphaAnimation;
				else
					v.Alpha = 255;
				end

				if (alphaProgress > 1) then
					v.Tick = getTickCount();
					v.State = 'openTile';
				end
			elseif (v.State == 'fadeOut') then
				local alphaProgress = (getTickCount() - v.AlphaTick) / 650;
				local alphaAnimation = interpolateBetween(255, 0, 0, 0, 0, 0, alphaProgress, 'Linear');

				if (alphaAnimation) then
					v.Alpha = alphaAnimation;
				else
					v.Alpha = 0;
				end

				if (alphaProgress > 1) then
					notificationData = {};
				end
			elseif (v.State == 'openTile') then
				local tileProgress = (getTickCount() - v.Tick) / 350;
				local tilePosition = interpolateBetween(v.StartX, 0, 0, v.EndX, 0, 0, tileProgress, 'Linear');
				local tileWidth = interpolateBetween(0, 0, 0, v.Width, 0, 0, tileProgress, 'Linear');

				if (tilePosition and tileWidth) then
					v.CurrentX = tilePosition;
					v.CurrentWidth = tileWidth;
				else
					v.CurrentX = v.EndX;
					v.CurrentWidth = v.Width;
				end

				if (tileProgress > 1) then
					if becsukva then
						v.State = 'fixTile';
						v.Tick = getTickCount();
						v.State = 'closeTile';
					end
				end
			elseif (v.State == 'closeTile') then
				local tileProgress = (getTickCount() - v.Tick) / 350;
				local tilePosition = interpolateBetween(v.EndX, 0, 0, v.StartX, 0, 0, tileProgress, 'Linear');
				local tileWidth = interpolateBetween(v.Width, 0, 0, 0, 0, 0, tileProgress, 'Linear');

				if (tilePosition and tileWidth) then
					v.CurrentX = tilePosition;
					v.CurrentWidth = tileWidth;
				else
					v.CurrentX = v.StartX;
					v.CurrentWidth = 0;
				end

				if (tileProgress > 1) then
					v.AlphaTick = getTickCount();
					v.State = 'fadeOut';
				end
			elseif (v.State == 'fixTile') then
				v.Alpha = 255;
				v.CurrentX = v.EndX;
				v.CurrentWidth = v.Width;
			end

			roundedRectangle(v.CurrentX-60, displayHeight/2+350, 65 + v.CurrentWidth, 65, tocolor(0, 0, 0, 150 * v.Alpha / 255));
			dxDrawRectangle(v.CurrentX-60, displayHeight/2+350, 65, 65, tocolor(0, 0, 0, 255 * v.Alpha / 255));

			if (v.Alpha == 255) then
				dxDrawText(v.Text, v.CurrentX+40, displayHeight/2 - 105/2+200+200+10, v.CurrentX + v.CurrentWidth -40, displayHeight/2 - 50/2+300+20 +10+ 50+30, tocolor(153, 255, 153, 255), 1.1, notificationFont, 'center', 'center', true, false, true);
				dxDrawText(v.Text2, v.CurrentX+25, displayHeight/2 - 2/2+200+130-10, v.CurrentX + v.CurrentWidth -20, displayHeight/2 - 50/2+280 + 70+150, tocolor(255, 255, 255, 255), 1, infosFont, 'center', 'center', true, false, true);
			end

			if (v.Type == 0) then
				--dxDrawText('', v.CurrentX + 5, displayHeight/2 - 50/2+325, v.CurrentX + 5 + 50 - 10, 20 + displayHeight/2 - 50/2+300, tocolor(255, 255, 255, v.Alpha), 1, iconsFont, 'center', 'center', false, false, true);
				dxDrawImage(v.CurrentX - 60, displayHeight/2 +350,64,64,"files/icons/status.png",0,0,0,tocolor(255,255,255,255 * v.Alpha / 255),true)
			elseif (v.Type == 1) then
				dxDrawImage(v.CurrentX - 60, displayHeight/2 +350,64,64,"files/icons/elado.png",0,0,0,tocolor(255,255,255,255 * v.Alpha / 255),true)
			elseif (v.Type == 2) then
				dxDrawImage(v.CurrentX - 60, displayHeight/2 +350,64,64,"files/icons/status.png",0,0,0,tocolor(255,255,255,255 * v.Alpha / 255),true)
			elseif (v.Type == 4) then
				dxDrawImage(v.CurrentX - 60, displayHeight/2 +350,64,64,"files/icons/garazs.png",0,0,0,tocolor(255,255,255,255 * v.Alpha / 255),true)
			end
		end
	--end
end
addEventHandler("onClientRender", getRootElement(), renderInteriorPanel)

local lightShowing = false

function clientMarkerHit(thePlayer, matchingDimension)
	cancelEvent()
	if thePlayer == localPlayer then
		if getElementDimension(source) == getElementDimension(thePlayer) then
			if getElementData(source,"isIntMarker") == true or getElementData(source,"isIntOutMarker") == true then
				marker = nil
				bindKey("e", "down", bindKeyInteriorFunctions)
				bindKey("k", "down", lockInteriorFunctions)
				setElementData(thePlayer, "isInIntMarker",true)
				setElementData(thePlayer, "int:Marker", source)
				marker = source
				local inttype = getElementData(marker,"inttype")
				local owner = getElementData(marker,"owner")
				local ownerName = getElementData(marker,"ownerName") or "Desconhecido!"
				local intCost = getElementData(marker,"cost")
				if (inttype==4) then
					text = "["..tonumber(getElementData(marker,"acc:id")).."] Garagem"
				else
					text = "["..tonumber(getElementData(marker,"acc:id")).."] "..tostring(getElementData(marker,"name"))..""
				end

				if getElementData(marker, "customint") == 1 and getElementDimension(localPlayer) == 0 then
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFEste é um interior personalizável.",0,0,0,true)
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFUse o comando #99cc99/editar#FFFFFF para personalizá-lo.",0,0,0,true)
				elseif getElementData(marker, "customint") == 1 and getElementDimension(localPlayer) ~= 0 then
					-- // light state check
					lightShowing = getElementData(marker, "light")
				end

				-- sima
				if inttype == 0 and owner <= 0 then
					infoText = "Preço: R$:" .. tostring(getElementData(marker,"cost")) .. ""
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFPressione [E] para comprar este interior! #33ccff("..intCost.."$)",153, 255, 153,true)
				elseif inttype == 0 and owner >= 1 then
					infoText = "Dono: " ..string.gsub(ownerName, "_", " ") .. ""
				-- biznisz
				elseif inttype == 1 and owner <= 0 then
					infoText = "Preço: R$:" .. tostring(getElementData(marker,"cost")) .. ""
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFPressione [E] para comprar este interior! #33ccff("..intCost.."$)",153, 255, 153,true)
				elseif inttype == 1 and owner >= 1 then
					infoText = "Dono: " ..string.gsub(ownerName, "_", " ") .. ""
				-- önkoris(bolt, stb...)
				elseif inttype == 2 then
					infoText = "Edifício estatal."
				-- garázs
				elseif inttype == 4 and owner <= 0 then
					infoText = "Preço: R$:" .. tostring(getElementData(marker,"cost")) .. ""
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFPressione [E] para comprar este interior! #33ccff("..intCost.."$)", 153, 255, 153,true)
				elseif inttype == 4 and owner >= 1 then
					infoText = "Dono: " ..string.gsub(ownerName, "_", " ") .. ""
				else
					infoText = "Interior errado"
				end

				if (notificationData ~= nil) then
					table.remove(notificationData, #notificationData);
				end

				table.insert(notificationData,
					{
						StartX = (displayWidth / 2) - (25 / 2),
						EndX = (displayWidth / 2)-115,
						Text = text,
						Text2 = infoText,
						Width = 345-65,
						Alpha = 0,
						State = 'fadeIn',
						Tick = 0,
						AlphaTick = getTickCount(),
						CurrentX = (displayWidth / 2) - (25 / 2),
						CurrentWidth = 0,
						Type = inttype
					}
				);
				if getElementData(localPlayer, "char:adminduty") == 1 then
					if inttype == 0 and owner >= 1 or inttype == 1 and owner >= 1 or inttype == 4 and owner >= 1 then
						outputChatBox("#99cc99[BGOMTA - Admin]: #FFFFFF O dono deste interior é: #33ccff"..(ownerName:gsub("_", " ")), 153, 255, 153, true)
					end
				end
			end
		end
	end
end
addEventHandler("onClientMarkerHit", resourceRoot, clientMarkerHit)

addEventHandler("onClientMarkerLeave", resourceRoot, function(thePlayer, matchingDimension)
	if thePlayer == localPlayer then
		marker = nil
		unbindKey("e", "down", bindKeyInteriorFunctions)
		unbindKey("k", "down", lockInteriorFunctions)
		setElementData(thePlayer, "isInIntMarker",false)
		setElementData(thePlayer, "int:Marker", nil)
		lightShowing = false
		for k, v in pairs(notificationData) do
			v.State = 'fixTile';
			v.Tick = getTickCount();
			v.State = 'closeTile';
		end
	end
end)


-- // show the actual light
local lightRGB = {255,255,255,255}
addEventHandler("onClientRender", getRootElement(), function()
	if lightShowing then
		dxDrawRectangle(displayWidth/2-24, displayHeight-120, 48, 48, tocolor(0,0,0,180))
		if isCursorInBox(displayWidth/2-24, displayHeight-120, 48, 48) then
			lightRGB = {153, 204, 153,255}
		else
			lightRGB = {255,255,255,255}
		end
		if lightShowing == 0 then
			dxDrawImage(displayWidth/2-17, displayHeight-115, 34, 34,":bgo_customint/files/icons/lightoff.png", 0,0,0,tocolor(lightRGB[1], lightRGB[2], lightRGB[3], lightRGB[4]))
		else
			dxDrawImage(displayWidth/2-17, displayHeight-115, 34, 34,":bgo_customint/files/icons/lighton.png", 0,0,0,tocolor(lightRGB[1], lightRGB[2], lightRGB[3], lightRGB[4]))
		end
	end
end)

-- // click handler for changing the inside lightning
addEventHandler("onClientClick", getRootElement(), function(button, state)
	if lightShowing then
		if button == "left" and state == "down" then
			if isCursorInBox(displayWidth/2-24, displayHeight-120, 48, 48) then
				if lightShowing == 0 then
					lightShowing = 1
					setTime(12, 0)
				else
					lightShowing = 0
					setTime(0, 0)
				end
				setElementData(marker, "light", lightShowing)
			end
		end
	end
end)

function bindKeyInteriorFunctions()
	if isElement(marker) then
		local theElement = getElementData(marker, "other")
		if theElement then
			local intID = getElementData(marker,"acc:id")
			local intLocked = getElementData(marker,"locked")
			local intType = getElementData(marker,"inttype")
			local intOwner = getElementData(marker,"owner")
			local intCost = getElementData(marker,"cost")
			if intType == 0 and intOwner <= 0 then

				local count = 0
				for k, v in ipairs(getElementsByType("marker")) do
					if getElementData(v, "owner") == getElementData(localPlayer, "acc:id") and getElementData(v, "acc:id") and not getElementData(v,"isIntOutMarker") then
						count = count + 1
					end
				end

				if (getElementData(localPlayer, "char:money") or 0) >= intCost then
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê comprou um interior com sucesso. #7cc576("..intCost.." $.)",124, 197, 118,true)
					triggerServerEvent("updateInteriorOwner", localPlayer, intID, localPlayer, intCost)
					triggerServerEvent("giveInteriorKey",localPlayer,localPlayer,intID, intCost)
				else
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê não tem dinheiro suficiente para comprar este interior.",124, 197, 118,true)
				end
			elseif intType == 1 and intOwner <= 0 then

				local count = 0
				for k, v in ipairs(getElementsByType("marker")) do
					if getElementData(v, "owner") == getElementData(localPlayer, "acc:id") and getElementData(v, "acc:id") and not getElementData(v,"isIntOutMarker") then
						count = count + 1
					end
				end


				if (getElementData(localPlayer,"char:money") or 0) >= intCost then
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê comprou um negócio com sucesso. #7cc576("..intCost.." $.)",124, 197, 118,true)
					triggerServerEvent("updateInteriorOwner", localPlayer, intID, localPlayer, intCost)
					triggerServerEvent("giveInteriorKey",localPlayer,localPlayer,intID, intCost)
				else
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê não tem dinheiro suficiente para comprar este interior.",124, 197, 118,true)
				end
			elseif intType == 4 and intOwner <= 0 then

				local count = 0
				for k, v in ipairs(getElementsByType("marker")) do
					if getElementData(v, "owner") == getElementData(localPlayer, "acc:id") and getElementData(v, "acc:id") and not getElementData(v,"isIntOutMarker") then
						count = count + 1
					end
				end

				if (getElementData(localPlayer,"char:money") or 0) >= intCost then
					triggerServerEvent("updateInteriorOwner", localPlayer, intID, localPlayer, intCost)
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê comprou uma garagem com sucesso. #7cc576("..intCost.." $.)",124, 197, 118,true)
				else
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê não tem dinheiro suficiente para comprar esta garagem.",124, 197, 118,true)
				end
			else
				if intLocked == 0 then
					if isPedInVehicle(localPlayer) and intType == 4 then
						local x,y,z = getElementData(theElement,"x"),getElementData(theElement,"y"),getElementData(theElement,"z")
						local intInt = getElementInterior(theElement)
						local intDim = getElementDimension(theElement)
						triggerServerEvent("changeVehInterior",localPlayer,localPlayer,getPedOccupiedVehicle(localPlayer),x,y,z,intInt,intDim)
						lockedSound = playSound("files/sounds/intenter.mp3")
					else
						if not isPedInVehicle(localPlayer) then
							local x,y,z = getElementData(theElement,"x"),getElementData(theElement,"y"),getElementData(theElement,"z")
							local intInt = getElementInterior(theElement)
							local intDim = getElementDimension(theElement)
							if getElementData(theElement, "customint") == 1 and getElementDimension(localPlayer) == 0 then
								customInt = true
								dbID = getElementData(theElement, "acc:id")
							else
								customInt = false
								dbID = 0
							end
							triggerServerEvent("changeInterior",localPlayer,localPlayer,x,y,z,intInt,intDim,customInt,dbID)

							-- // have to add it twice, to get the right effect on changing the time
							if getElementData(theElement, "customint") == 1 and getElementDimension(localPlayer) == 0 then
								lightState = getElementData(theElement, "light")
								if lightState == 0 then
									setTime(0,0)
								else
									setTime(12, 0)
								end
							end

							lockedSound = playSound("files/sounds/intenter.mp3")
						else
							outputChatBox("#99cc99[BGOMTA]: #FFFFFFIsto não é uma garagem.",124, 197, 118,true)
						end
					end
				else
					if isElement(lockedSound) then
						destroyElement(lockedSound)
					end
					lockedSound = playSound("files/sounds/locked.mp3")
					outputChatBox("#99cc99[BGOMTA]: #FFFFFFEste interior está trancado.",124, 197, 118,true)
				end
			end
		end
	end
end

function setBackToActualTime(hour, minute)
	setTime(hour, minute)
end
addEvent("setBackToActualTime",true)
addEventHandler("setBackToActualTime", getRootElement(), setBackToActualTime)

function lockInteriorFunctions()
	if isElement(marker) then
		local markID = tonumber(getElementData(marker, "acc:id")) or 0
		local markType = tostring(getElementData(marker, "inttype")) or nil
		local markLocked = tonumber(getElementData(marker, "locked")) or 0
		if markID then
			if (getElementData(localPlayer, "char:adminduty") == 1) or getElementData(marker, "owner") == getElementData(localPlayer, "acc:id") then--exports.bgo_items:hasItem(19, markID) then
				local theElement = getElementData(marker, "other")
				if theElement then
					if markLocked == 0 then
						if isElement(openCloseSound) then
							destroyElement(openCloseSound)
						end
						openCloseSound = playSound("files/sounds/openclose.mp3")
						setElementData(marker, "locked", 1)
						setElementData(theElement, "locked", 1)
						triggerServerEvent("lockIntToClient",localPlayer,localPlayer,tonumber(markID),1)
						return
					else
						if isElement(openCloseSound) then
							destroyElement(openCloseSound)
						end
						openCloseSound = playSound("files/sounds/openclose.mp3")
						setElementData(marker, "locked", 0)
						setElementData(theElement, "locked", 0)
						triggerServerEvent("lockIntToClient",localPlayer,localPlayer,tonumber(markID),0)
						return
					end
				end
			else
				outputChatBox("#99cc99[BGOMTA]: #FFFFFFVocê não tem a chave para este interior.",124, 197, 118,true)
			end
		end
	end
end



local png = tag1
local scale = 0
local tag1 = dxCreateTexture("files/icons/elado.png")
local tag2 = dxCreateTexture("files/icons/haz.png")
local tag3 = dxCreateTexture("files/icons/allami.png")
local tag4 = dxCreateTexture("files/icons/garazs.png")
addEventHandler( "onClientRender", getRootElement(),function()
	if showIcons == true then
		for k,v in pairs(getElementsByType("marker")) do
			if isElement(v) and v then
				if getElementType(v) == "marker" and isElementStreamedIn(v) and getElementData(v, "acc:id") then
					local Marker = v
					local markType = getElementData(v,"inttype")
					local markOwner = getElementData(v,"owner")
					if markType == 0 and markOwner <= 0 then
						png = tag1
						ic1,ic2,ic3 = 82, 225, 63
					elseif markType == 0 and markOwner >= 1 then
						png = tag2
						ic1,ic2,ic3 = 102, 204, 255
					elseif markType == 1 then
						png = tag3
						ic1,ic2,ic3 = 221, 118, 0
					elseif markType == 2 then
						png = tag3
						ic1,ic2,ic3 = 221, 118, 0
					elseif markType == 4 then
						png = tag4
						ic1,ic2,ic3 = 102, 204, 255
					end
					local px,py,pz = getElementPosition(localPlayer)
					local x, y, z = getElementPosition(v)
					dxDrawImageOnElement(Marker, png,1000,1,0.4, ic1, ic2, ic3)
				end
			end
		end
	end
end)

function dxDrawImageOnElement(TheElement,Image,distance,height,width,R,G,B,alpha)
				local x, y, z = getElementPosition(TheElement)
				local x2, y2, z2 = getElementPosition(localPlayer)
				local distance = distance or 20
				local height = height or 1
				local width = width or 1
        local checkBuildings = checkBuildings or true
        local checkVehicles = checkVehicles or false
        local checkPeds = checkPeds or false
        local checkObjects = checkObjects or true
        local checkDummies = checkDummies or true
        local seeThroughStuff = seeThroughStuff or false
        local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
        local ignoredElement = ignoredElement or nil
			--	if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
					local sx, sy = getScreenFromWorldPosition(x, y, z+height)
					if(sx) and (sy) then
						local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
						if(distanceBetweenPoints < distance) then
							dxDrawMaterialLine3D(x, y, z+0.4+height-(distanceBetweenPoints/distance)-0.3, x, y, z+height-0.3, Image, width-(distanceBetweenPoints/distance), tocolor(R or 255, G or 255, B or 255, alpha or 255))
						end
					end
		--	end
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


function getCursorPositionAdded()
    return cursorX, cursorY
end


function isCursorInBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(isCursorXY(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end
end

function isCursorXY(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end
