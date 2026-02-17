local odimension = getElementDimension(localPlayer)
local ointerior = getElementInterior(localPlayer)
local screenSize = {guiGetScreenSize()}
screenSize.x, screenSize.y = screenSize[1], screenSize[2]
local myScreenSource = dxCreateScreenSource(screenSize.x, screenSize.y)


function infoSound(file)
	playSound("files/sounds/"..file..".mp3")
end
function infoBox(text, type)
	if not text then return end
	if not tonumber(type) then type = 4 end
	exports["bgo_infobox"]:addNotification(text, type)
end
function isCursorHover(startX, startY, sizeX, sizeY)
	if isCursorShowing() then
		local cursorPosition = {getCursorPosition()}
		cursorPosition.x, cursorPosition.y = cursorPosition[1] * screenSize.x, cursorPosition[2] * screenSize.y
		if cursorPosition.x >= startX and cursorPosition.x <= startX + sizeX and cursorPosition.y >= startY and cursorPosition.y <= startY + sizeY then
			return true
		else
			return false
		end
	else
		return false
	end
end

local dashboardOpened = false
local dutyskinOpened = false
local width, height = 800, 450
local startX, startY = (screenSize.x - width) / 2 , (screenSize.y - height) / 2
local bgColor = tocolor(0, 0, 0, 180)
local slotColor = tocolor(40, 40, 40, 200)
local hoverColor = tocolor(124, 197, 118, 180)
local secondColor = tocolor(124, 197, 118, 180)
local cancelColor = tocolor(243, 85, 85, 180)

local spacer = 2
local spacerBig = 5

local roboto = dxCreateFont("files/fonts/Roboto.ttf", 8, false, "proof")
local robotoBold = dxCreateFont("files/fonts/Roboto.ttf", 10, true, "proof")
local robotoBig = dxCreateFont("files/fonts/Roboto.ttf", 11, false, "proof")
local robotoGui = guiCreateFont("files/fonts/Roboto.ttf", 9)

local menuPoints = {{"Propriedade", "property"}}
local menuPointsWidth = (width - (#menuPoints - 1) * spacerBig) / #menuPoints
local playerInfos = {}

local optionsText = {"Ativado"}
optionsText[0] = "Desligado"
local changeTips = {"Desligar"}
changeTips[0] = "Ligar"
local vehicleTuningDatas = {{"engine", "Motor"}, {"turbo", "turbo"}, {"gearbox", "projeto de lei"}, {"ecu", "Ecu"}, {"pneus", "goma"}, {"brakes", "freio"}}
local vehicleTunings = {"#999999Não", "#acd737Rua", "#ffcc00Profissional", "#ff6600Competição", "#ff1a1aEngrenagem" , "#ff1a1aEngrenagem"}
vehicleTunings[0] = "#999999não"


local optionsCreateColor = ""
local optionsCreateText = "" 
local maxdistance = 0



local groupMembers = {}
local groupVehicles = {}
local meInGroup = {}

local admins = {}
local openedTick = getTickCount() - 2000


-- LOCALIZAÇÃO MAKER




markers = { 
    [1] = { 1907.1381835938,-1808.0466308594,13.655365943909 }, 
    [2] = { -2234.9548339844,2357.5026855469,5 }, 
	[3] = { 2121.3347167969,953.43859863281,10.81298828125 }, 
    [4] = { 275.70635986328,1963.7976074219,17.776561737061 }, 
	[5] = { -2108.541, -860.206, 31.172 }, 
    [6] = { 559.668, -1281.141, 17.248 }, 
	[7] = { 1508.6695556641,2164.9624023438,10.8203125 }, 
    [8] = { 2854.8178710938,906.32287597656,10.75 }, 
	[9] = { -1105.509, -599.372, 32.869 }, 
	[10] = { 1479.3843994141,-1784.6329345703,12.546875 }, 
	[11] = { 2509.9304199219,2291.3012695313,09.8203125 }, 
    [12] = { 1241.2791748047,-1476.8537597656,13.548749923706 }, 
	[13] = { 2192.0322265625,2498.5871582031,10.8203125 }, 
    [14] = { 1698.644, 1622.77, 10.834 }, 
	[15] = { 2136.9155273438,1433.9739990234,09.8203125 }, 
    [16] = { 1638.5115966797,-1224.1899414063,13.831893920898 }, 
	[17] = { 1856.6762695313,886.07464599609,09.897235870361 }, 
    [18] = { -1829.4876708984,1293.9094238281,30.858720779419 }, 
	[19] = { 2436.3518066406,-2135.4201660156,12.546875 }, 
    [20] = { 2259.8728027344,1939.1916503906,9.8671274185181 }, 
	[21] = { 2716.0239257813,696.61450195313,09.934374809265 }, 
    [22] = { -980.35363769531,-1739.9169921875,77.247634887695 },
	[23] = { 2049.4248046875,2049.7473144531,10.8203125 },
} 
  


for i = 1, #markers, 1 do
veiculos = createMarker(markers[i][1], markers[i][2],markers[i][3]-0.9, "cylinder",2.5, 255, 200, 0, 80)
local myBlip1 = createBlipAttachedTo ( veiculos, 55 )
setElementData(myBlip1,"blipName", "BGO - Garagem")

addEventHandler( "onClientMarkerLeave", veiculos,
function( hitElement, matchingDimension )
   if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
	dashboardOpened = false
    end
end
)

addEventHandler( "onClientMarkerHit", veiculos, 
function( hitElement, matchingDimension )
   if getElementType(hitElement) == "player" and (hitElement == localPlayer) then
		currentPage = 1
		dashboardOpened = true
		openedTick = getTickCount()
		getMyVehicles()
		maxVehicleRows = 9
		currentVehicleRow = 1
		lastVehicleRow = 1
		selectedVehicle = 0
end
end
)
end




vehicleWeight = {
	-- [VehID] = peso,
	[499] = true,
	[414] = true,
	[456] = true,
	[524] = true,
	[487] = true,
	[469] = true,
}




function gpsVehicle(commandName, vehicleId)
	if vehicleId then 
		for index, value in ipairs (getElementsByType("vehicle")) do				
			if getElementData(value, "veh:id") == tonumber(vehicleId) then			
				if not getElementData(value, "veh:owner") == getElementData(localPlayer, "char:id") then 
				   outputChatBox("#7cc576[BGO MTA] #ffffffVocê não é o dono do veículo!",0,0,0,true)	
				   return
				end
				    if getElementData(localPlayer, "spawn:vehicle") then
					    outputChatBox("#7cc576[BGO MTA] #ffffffVocê precisa guardar seu antigo veiculo para spawnar outro!!",0,0,0,true)
                    return
					end
					if (getElementDimension(value) == 0) then
					outputChatBox("#7cc576[BGO MTA] #ffffffSeu veiculo não pode ser spawnado porque ja está na cidade!!",0,0,0,true)
					return
					end
					if (getElementData(value, "detranAP")) then 
					if not vehicleWeight[getElementModel(value)] then
					outputChatBox("#7cc576[BGO MTA] #ffffffSeu veiculo está no detran!",0,0,0,true)
					triggerServerEvent("updateINTDIM22", localPlayer, vehicleId)
					else
					outputChatBox("#7cc576[BGO MTA] #ffffffnão pode spawnar caminhão nesta garagem!!!",0,0,0,true)
					end
					else
					if not vehicleWeight[getElementModel(value)] then
					triggerServerEvent("updateINTDIMGARAGEM", localPlayer,localPlayer, vehicleId)
					else
					outputChatBox("#7cc576[BGO MTA] #ffffffnão pode spawnar caminhão nesta garagem!!!",0,0,0,true)
					end
				 end
			end
		end
	end
end


addEventHandler("onClientKey", root, function(button, pressed)
	if pressed and getElementData(localPlayer, "loggedin") then
		if dashboardOpened then
			if currentPage == 1 then
				if isCursorHover(startX + 2 * spacerBig, startY + 2 * spacerBig + 30, width / 2 - 4 * spacerBig, maxVehicleRows * 22 + spacer) then
					if button == "mouse_wheel_down" then
						if currentVehicleRow < #myVehicles - (maxVehicleRows - 1) then
							currentVehicleRow = currentVehicleRow + 1
						end
					elseif button == "mouse_wheel_up" then
						if currentVehicleRow > 1 then
							currentVehicleRow = currentVehicleRow - 1
						end
					elseif button == "mouse1" then
						lastVehicleRow = currentVehicleRow + maxVehicleRows - 1
						for key, value in ipairs(myVehicles) do
							if key >= currentVehicleRow and key <= lastVehicleRow then
								key = key - currentVehicleRow + 1
								local forY = startY + 2 * spacerBig + 30 + spacer + (key - 1) * 22
								if isCursorHover(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20) then
									selectedVehicle = key + currentVehicleRow - 1
								end
							end
						end
						
					end
				end

			end
		end
	end
end
)



addEventHandler("onClientClick", root,
function(button, state, _, _, _, _, _, element)
	if button == 'left' and state == 'down' and dashboardOpened then
			local forY = startY + 2 * spacerBig + 200 + spacer * 22
			if isMouseInPosition(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20) then
			
			if exports.placa:checkvalores(localPlayer) then
			if tonumber(selectedVehicle) > 0 then				
			gpsVehicle("gps", getElementData(myVehicles[selectedVehicle], "veh:id"))
			else
			outputChatBox("#7cc576[BGO MTA] #ffffffSelecione o veiculo para spawnar." ,0,0,0,true)
			end
			end
			
			
			elseif isMouseInPosition(startX + 2 * spacerBig + spacer, forY+40, width / 2 - 4 * spacerBig - 2 * spacer, 20) then
			triggerServerEvent("respawnVehicle", localPlayer, localPlayer)
			
		end
	end
end
)

function isCursorOnBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
			return true
		else
			return false
		end
	end	
end





addEventHandler("onClientElementDataChange", root, function(dataName, oldValue)
	if source and getElementType(source) == "player" then
		if source == localPlayer then
			if dataName == "char:vehSlot" then
				getMyVehicles()
		end	
	end
	end
end)

function thousandsStepper(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if k == 0 then
			break
		end
	end
	return formatted
end
function getMyVehicles()
	myVehicles = {}
	for key, value in ipairs(getElementsByType("vehicle")) do
		if getElementData(value, "veh:owner") == getElementData(localPlayer, "acc:id") then
		if not vehicleWeight[getElementModel(value)] then
			table.insert(myVehicles, value)
		end
		end
	end
	vehicleInfos = {"BGO - Garagem"}
end

addEventHandler("onClientRender", root, function()
	if dashboardOpened then
		--if isChatVisible() then showChat(false) end
		if getElementData(localPlayer, "toggle-->All") then setElementData(localPlayer, "toggle-->All", false) end
		--dxDrawRectangle(startX-95, startY, width-200, height-100, tocolor(0,0,0,100))

		if currentPage == 1 then
			--- Vehicles
			local sizeX = ((width / 2 - 4 * spacerBig) - 2 * spacerBig) / 3
			local key = 0
			dxDrawText(vehicleInfos[key + 1], startX + 55 * spacerBig + key * (sizeX + spacerBig), startY - 15 * spacerBig, startX + 2 * spacerBig + key * (sizeX + spacerBig) + sizeX, startY + 2 * spacerBig + 30 - spacerBig, tocolor(255, 255, 255), 2, "default", "center", "center")
			--dxDrawText("Pressione M", startX + 55 * spacerBig + key * (sizeX + spacerBig), startY + 99 * spacerBig, startX + 2 * spacerBig + key * (sizeX + spacerBig) + sizeX, startY + 2 * spacerBig + 30 - spacerBig, tocolor(255, 255, 255), 2, "default", "center", "center")
			--dxDrawText("Clique 2 vezes para spawnar o veiculo selecionado!", startX + 55 * spacerBig + key * (sizeX + spacerBig), startY + 115 * spacerBig, startX + 2 * spacerBig + key * (sizeX + spacerBig) + sizeX, startY + 2 * spacerBig + 30 - spacerBig, tocolor(255, 255, 255), 2, "default", "center", "center")
			dxDrawRectangle(startX + 2 * spacerBig, startY + 2 * spacerBig + 30, width / 2 - 4 * spacerBig, maxVehicleRows * 22 + spacer, bgColor)
			if #myVehicles > 0 then
				for key = 0, maxVehicleRows - 1 do
					local forY = startY + 2 * spacerBig + 30 + spacer + key * 22
					dxDrawRectangle(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20, slotColor)
					if isCursorHover(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20) or key == selectedVehicle - currentVehicleRow then
						dxDrawRectangle(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20, hoverColor)
					end
				end
				lastVehicleRow = currentVehicleRow + maxVehicleRows - 1
				for key, value in ipairs(myVehicles) do
					if key >= currentVehicleRow and key <= lastVehicleRow then
						key = key - currentVehicleRow + 1
						local forY = startY + 2 * spacerBig + 30 + spacer + (key - 1) * 22
						dxDrawText(exports.bgo_carshop:getVehicleRealName(getElementModel(value)).." (ID: "..getElementData(value, "veh:id")..")", startX + 3 * spacerBig + spacer, forY, startX + 3 * spacerBig + spacer + width / 2 - 4 * spacerBig - 2 * spacer, forY + 20, tocolor(255, 255, 255), 1, roboto, "left", "center")
						dxDrawText("Condição: "..math.floor(getElementHealth(value) / 10 + 0.5).."%", startX + 2 * spacerBig + spacer, forY, startX + 2 * spacerBig + spacer + width / 2 - 5 * spacerBig - 2 * spacer, forY + 20, tocolor(255, 255, 255), 1, roboto, "right", "center")				
						if isCursorHover(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20) or key == selectedVehicle - currentVehicleRow + 1 then
							dxDrawText(exports.bgo_carshop:getVehicleRealName(getElementModel(value)).." (ID: "..getElementData(value, "veh:id")..")", startX + 3 * spacerBig + spacer, forY, startX + 3 * spacerBig + spacer + width / 2 - 4 * spacerBig - 2 * spacer, forY + 20, tocolor(0, 0, 0), 1, roboto, "left", "center")
							dxDrawText("Condição: "..math.floor(getElementHealth(value) / 10 + 0.5).."%", startX + 2 * spacerBig + spacer, forY, startX + 2 * spacerBig + spacer + width / 2 - 5 * spacerBig - 2 * spacer, forY + 20, tocolor(0, 0, 0), 1, roboto, "right", "center")					
						end
					end
				end
				
				--[[
				if myVehicles[selectedVehicle] then
				dxDrawRectangle(startX + 2 * spacerBig, startY + 2 * spacerBig + 30 + maxVehicleRows * 22 + spacer + spacerBig, width / 2 - 4 * spacerBig, (#vehicleTuningDatas + 2) * 22 + spacer, bgColor)



				for key, value in ipairs(vehicleTuningDatas) do
					local forY = startY + 2 * spacerBig + 30 + maxVehicleRows * 22 + spacer + spacerBig + spacer + (key + 1) * 22
					dxDrawRectangle(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20, slotColor)
					dxDrawText("#ffffff"..value[2]..": "..vehicleTunings[getElementData(myVehicles[selectedVehicle], "veh:performance_"..value[1]) or 0].." tuning", startX + 3 * spacerBig + spacer, forY, startX + 3 * spacerBig + spacer + width / 2 - 4 * spacerBig - 2 * spacer, forY + 20, tocolor(255, 255, 255), 1, roboto, "left", "center", false, false, false, true)

				end



				for key = 0, 1 do
					local forY = startY + 2 * spacerBig + 30 + maxVehicleRows * 22 + spacer + spacerBig + spacer + key * 22
					if key == 0 then
						if getElementData(myVehicles[selectedVehicle], "tuning.lsdDoor") then
							textT = "Porta LSD: #1b96fetem"
						else
							textT = "Porta LSD: #999999não"
						end
					else
						if getElementData(myVehicles[selectedVehicle], "tuning.paintjob") or 0 >= 1 then
							textT = "Paintjob: #1b96fevan (" .. getElementData(myVehicles[selectedVehicle], "tuning.paintjob") .. ")"
						else
							textT = "Paintjob: #999999não"
						end
					end
					dxDrawRectangle(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20, slotColor)
					dxDrawText(textT, startX + 3 * spacerBig + spacer, forY, startX + 3 * spacerBig + spacer + width / 2 - 4 * spacerBig - 2 * spacer, forY + 20, tocolor(255, 255, 255), 1, roboto, "left", "center", false, false, false, true)
				end
				end]]--
			else
				dxDrawText("Nenhum veiculo", startX + 2 * spacerBig + spacerBig, startY + 2 * spacerBig + 30, startX + 2 * spacerBig + spacerBig + width / 2 - 4 * spacerBig, startY + 2 * spacerBig + 30 + maxVehicleRows * 22 + spacer, cancelColor, 1, robotoBig, "center", "center")
			end
			local rightSx = startX + 390 + 4 * spacerBig
		end
		
				--dxDrawRectangle(startX-25, startY+300, width-590, height-490, tocolor(255,255,0,100))
		--if isMouseInPosition(startX, startY, width-590, height-490) then
		local forY = startY + 2 * spacerBig + 200 + spacer * 22
		if isMouseInPosition(startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20) then
		dxDrawButton("SPAWNAR", startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20, tocolor(253, 128, 20, 100))
		else
		dxDrawButton("SPAWNAR", startX + 2 * spacerBig + spacer, forY, width / 2 - 4 * spacerBig - 2 * spacer, 20, tocolor(253, 128, 20, 180))
		end
		
		if isMouseInPosition(startX + 2 * spacerBig + spacer, forY+40, width / 2 - 4 * spacerBig - 2 * spacer, 20) then
		dxDrawButton("GUARDAR VEICULO ATUAL", startX + 2 * spacerBig + spacer, forY+40, width / 2 - 4 * spacerBig - 2 * spacer, 20, tocolor(253, 128, 20, 100))
		else
		dxDrawButton("GUARDAR VEICULO ATUAL", startX + 2 * spacerBig + spacer, forY+40, width / 2 - 4 * spacerBig - 2 * spacer, 20, tocolor(253, 128, 20, 180))
		end
		--dxDrawRectangle(startX+220, startY+300, width-590, height-490, tocolor(255,255,0,100))
		--dxDrawButton("GUARDAR", startX + 220 * 1, startY*2, width-590, height-490, tocolor(124, 197, 118, 180))




	end
end)

function dxDrawButton(text, startX, startY, width, height, color)
	dxDrawRectangle(startX - 1, startY, 1, height, bgColor) --left
	dxDrawRectangle(startX + width, startY, 1, height, bgColor) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, bgColor) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, bgColor) --bottom
	dxDrawRectangle(startX, startY, width, height, color)
	dxDrawText(text, startX+1, startY+1, startX + width, startY + height, tocolor(0, 0, 0,255), 1, roboto, "center", "center", false, false, false, true)
	dxDrawText(text, startX, startY, startX + width, startY + height, tocolor(255, 255, 255,255), 1, roboto, "center", "center", false, false, false, true)

end

function dxDrawEdit(startX, startY, width, height, element)
	dxDrawRectangle(startX - 1, startY, 1, height, bgColor) --left
	dxDrawRectangle(startX + width, startY, 1, height, bgColor) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, bgColor) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, bgColor) --bottom
	dxDrawRectangle(startX, startY, width, height, slotColor)
	dxDrawText(guiGetText(element), startX + 4, startY, startX + width, startY + height, tocolor(255, 255, 255), 1, roboto, "left", "center")
end

--[[
setTimer(function()
	setControlState("walk", true)
end, 500, 0)]]--

function isMouseInPosition ( x, y, width, height ) 
    if ( not isCursorShowing ( ) ) then 
        return false 
    end 
  
    local sx, sy = guiGetScreenSize ( ) 
    local cx, cy = getCursorPosition ( ) 
    local cx, cy = ( cx * sx ), ( cy * sy ) 
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then 
        return true 
    else 
        return false 
    end 
end 



function _3DResim(TheElement,Image,distance,height,width,R,G,B,alpha)
        local x, y, z = getElementPosition(TheElement)
        local x2, y2, z2 = getElementPosition(localPlayer)
        local distance = distance or 20
        local height = height or 2
        local width = width or 1
        local checkBuildings = checkBuildings or true
        local checkVehicles = checkVehicles or false
        local checkPeds = checkPeds or false
        local checkObjects = checkObjects or true
        local checkDummies = checkDummies or true
        local seeThroughStuff = seeThroughStuff or false
        local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
        local ignoredElement = ignoredElement or nil
        if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
          local sx, sy = getScreenFromWorldPosition(x, y, z+height)
          if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
              dxDrawMaterialLine3D(x, y, z+1+height-(distanceBetweenPoints/distance), x, y, z+height, Image, width-(distanceBetweenPoints/distance), tocolor(R or 255, G or 255, B or 255, alpha or 255))
            end
          end
      end
  end
  
  function dxDrawOctagon3D(x, y, z, radius, width, color)
  if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
    return false
  end

  local radius = radius or 1
  local radius2 = radius/math.sqrt(2)
  local width = width or 1
  local color = color or tocolor(255,255,255,150)

  point = {}

    for i=1,8 do
      point[i] = {}
    end

    point[1].x = x
    point[1].y = y-radius
    point[2].x = x+radius2
    point[2].y = y-radius2
    point[3].x = x+radius
    point[3].y = y
    point[4].x = x+radius2
    point[4].y = y+radius2
    point[5].x = x
    point[5].y = y+radius
    point[6].x = x-radius2
    point[6].y = y+radius2
    point[7].x = x-radius
    point[7].y = y
    point[8].x = x-radius2
    point[8].y = y-radius2

  for i=1,8 do
    if i ~= 8 then
      x, y, z, x2, y2, z2 = point[i].x,point[i].y,z,point[i+1].x,point[i+1].y,z
    else
      x, y, z, x2, y2, z2 = point[i].x,point[i].y,z,point[1].x,point[1].y,z
    end
    dxDrawLine3D(x, y, z, x2, y2, z2, color, width)
  end
  return true
end


