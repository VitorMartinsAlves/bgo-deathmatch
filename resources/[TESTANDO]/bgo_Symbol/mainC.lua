local circle_texture = dxCreateTexture("files/images/circle.png")

local currpos = 0
local goingup = true
local alpha = 0

local symbols = {}

addEventHandler("onClientRender", getRootElement(), 
    function()
        for k, v in pairs(symbols) do
            if tonumber(getElementDimension(localPlayer)) == tonumber(v[8]) then
                local posX, posY, posZ = v[1], v[2], v[3]
                local dx, dy = getScreenFromWorldPosition(posX, posY, posZ)
                local px, py, pz = getElementPosition(localPlayer)
                local distance = getDistanceBetweenPoints3D(px, py, pz, posX, posY, posZ)

                if tonumber(distance) < v[10] and dx and dy and v[9] then
                    dxDrawImage(dx - 25, dy - 50, 50, 50, "files/images/"..v[4]..".png", 0, 0, 0, tocolor(255, 255, 255, 200))
                end

                if v[7] then
                    if v[5] then
                        v[6] = v[6] + 0.008
                        if v[6] >= 1 then
                            v[5] = false
                        end
                    else
                        v[6] = v[6] - 0.008
                        if v[6] <= 0 then
                            v[5] = true
                        end            
                    end
                    if not posX and not posY and not posZ then return end
                    dxDrawMaterialLine3D (posX - v[6], posY, posZ - 1, posX + v[6], posY, posZ - 1, circle_texture, v[6] * 2, tocolor(205,80,0,150), posX, posY, posZ)
                end
            end
        end
    end
)

function addSymbol(name, x, y, z, typ, drawcircle, dim, smallLogo, logoDistance)
    if not dim then dim = 0 end
    symbols[name] = {x, y, z, typ, true, 0, drawcircle, dim, smallLogo, logoDistance}
    return name
end



	
	addSymbol("cv", 2186.2211914063, -997.99670410156, 66.46875+0.1, "door", true, 0, true, 20)
	
	addSymbol("cv2", 22.846893310547, 1403.6444091797, 1084.4296875+0.1, "door", true, 20, true, 20)
	
	
	addSymbol("desmanche",-110.77703857422, 1132.9365234375, 19.7421875+0.1, "car", true, 0, false, 20)
	
	addSymbol("pcc", 1667.4351806641, -2107.3422851563, 14.072273254395+0.1, "door", true, 0, true, 20)
	
	addSymbol("pcc2", 22.846893310547, 1403.6444091797, 1084.4296875+0.1, "door", true, 25, true, 20)
	
	addSymbol("cadeia2", 2996.3483886719,-1965.22265625,11.06875038147+0.1, "package", true, 0, true, 20)
	
	
	
	addSymbol("Desmanche2", -108.12171936035,1126.7482910156,19.7421875+0.1, "package", true, 0, true, 10)
	
	
	
	
function removeSymbol(name)
    symbols[name] = nil
end
