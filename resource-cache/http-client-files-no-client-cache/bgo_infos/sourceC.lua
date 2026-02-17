
if fileExists("sourceC.lua") then 
	fileDelete("sourceC.lua")
end

local nameTagPlayer = {}
local showName = true
local customFont = dxCreateFont('files/icons.ttf',15, false)
local renderdistance = 10


local itemTick = getTickCount()
local glue = ''

local togMyName = false
local levelText = ''

local progress 
local size

function refresTable(element)
	if getElementType(element)=="player" then
		nameTagPlayer[element] = {
		(getElementData(element, "char >> showedItem"))
		}
	end
end

datatypes = {"char >> showedItem"}

addEventHandler("onClientElementDataChange", root, function(data, oldValue)
    if getElementType(source)=="player" and isElementStreamedIn(source) then
		for k,v in ipairs(datatypes) do
			if (tostring(data) == v) then
				refresTable(source)
			end
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function ()
	local type = getElementType (source)
	if showName then 
		if type == "player" or type == "ped" then
			refresTable(source)
			--setPlayerNametagShowing (source,false)
		end
	end
end)

addEventHandler( "onClientElementStreamOut", root, function ()
	local type = getElementType (source)
	if showName then 
		if type == "player" or type == "ped" then
			nameTagPlayer[source] = nil
			--setPlayerNametagShowing (source,false)
		end	
	end
end)

function streamAllElements()
	for k,v in ipairs(getElementsByType("player")) do
		if isElementStreamedIn(v) then
			refresTable(v)
			--setPlayerNametagShowing (v,false)
		end
	end
	for k,v in ipairs(getElementsByType("ped")) do
		if isElementStreamedIn(v) then
			refresTable(v)
		end
	end
end
streamAllElements()
setElementData(localPlayer,"nevekbe",false)
setElementData(localPlayer, 'localName', false)

addEventHandler("onClientRender", root, function()
	if showName then
		local px,py,pz = getElementPosition(localPlayer)
		for k,value in pairs(nameTagPlayer) do
			if isElement(k) then
				x,y,z = getElementPosition(k)
				dist = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
				
				if (dist <= renderdistance) and (not(getElementAlpha(k)==0) and isLineOfSightClear(px, py, pz, x, y, z, true, false, false, true, false, false, false, localPlayer) and (localPlayer ~= k or togMyName) ) or (getElementData(localPlayer,"nevekbe") and localPlayer ~= k) then
					
					if getElementData(localPlayer,"nevekbe") and nameTagPlayer[localPlayer][9] then
						progress = dist/renderdistance
						size = interpolateBetween (0.5,0,0,0.6,0,0,progress,"OutQuad") * 0.9
					else
						progress = dist/renderdistance
						size = interpolateBetween (0.8,0,0,0.2,0,0,progress,"OutQuad") * 0.9
					end
					
					if size >= 1.0 then
						size = 1.0
					end					

					sx,sy,sz = getPedBonePosition(k,8)
					local position = { getScreenFromWorldPosition ( sx,sy,sz+0.4 ) }
					if position[1] and position[2] then
						if nameTagPlayer[k][1] then
							local height = 70 * size
							itemTick = nameTagPlayer[k][1][5]
							if itemTick then 
								local progress = (getTickCount() - itemTick) / 750
								if progress > 1 then
									 alphas = interpolateBetween(0,0,0,255,0,0,progress,"Linear")
								end
								local y, _, _ = interpolateBetween(position[2]-80 - 5, 0, 0,position[2]-80, 0, 0,progress, "CosineCurve")
								dxDrawImage (position[1]-height/2, y, height, height,exports["bgo_items"]:getItemImg(nameTagPlayer[k][1][2]),0,0,0,tocolor(255,255,255,alphas))
								dxDrawText(nameTagPlayer[k][1][3],position[1]+1, y+height+1, position[1]+1, position[2]+1,tocolor(0,0,0,255),size,customFont,"center","top")	
								dxDrawText(nameTagPlayer[k][1][3],position[1], y+height, position[1]+1, position[2]+1,tocolor(255, 255, 255,255),size,customFont,"center","top")
							end
						end
					end
				end
			end
		end
	end
end, true, "low-5")

