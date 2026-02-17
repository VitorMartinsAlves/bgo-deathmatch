local scrX,scrY = guiGetScreenSize();
local resW2, resH2 = 1280,720
local x, y =  (scrX/resW2), (scrY/resH2);
local skinID   = {}
local rotz     = {}

--[[
local l_0_1 = false
local l_0_2, l_0_3 = guiGetScreenSize()
local l_0_4 = dxCreateScreenSource(l_0_2, l_0_3)

addEventHandler ("onClientRender", root, 
function()
  if l_0_1 then
    dxUpdateScreenSource(l_0_4)
    dxDrawImage(0, 0, l_0_2, l_0_3, l_0_4)
  end
end
)]]--

local Shop = {
	Window = {},
	Gridlist = {},
	Button = {},
	Label = {},
	Combobox = {},
	Preview = {},
	Items = {},
}

addEventHandler ( "onClientClick", root,
function ( button, state, _, _, _, _, _, clickPED)
  if button == "left" and state == "down" then
	if ( clickPED ) then
		if ( getElementType ( clickPED ) == "ped" ) then
	     	local cx, cy, cz = getElementPosition ( clickPED )
	     	local px, py, pz = getElementPosition ( localPlayer )
	     	local distance	= getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz )
	    if ( distance <= 5 ) then
		    if getElementData(clickPED, "SHOP:Ped") then
			
				local genero = getElementData(localPlayer, "char:genero")
				if genero == "mulher" then 
			     Open ()
				 else
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox(" ", 255, 255, 255, true)
		outputChatBox("Roupas apenas para mulheres!  (Se você é mulher e não consegue acessar o painel, procure o suporte de contas!!!)", 255, 255, 255, true)
				 end
			end
		end
	  end
    end
  end
end
)

SkinPed = {
   {1, 10, 3000},
   {2, 263, 2100},
   {3, 13, 2400},
   {4, 9, 3500},
   {5, 11, 3600},
   {6, 12, 3800},
   {7, 40, 4000},
   {8, 178, 5000},
   {9, 191, 5000},
   {10, 214, 3100},
   {11, 216, 3800},
   {12, 38, 2600},
   {13, 39, 2500},
   {14, 64, 3100},
   {15, 46, 3500},
   {16, 199, 3500},
   {17, 93, 4200},
   {18, 31, 6000},
   {19, 130, 2500},
   {20, 131, 6000},
}
--[[
local BincExe1 = createPickup(217.792, -5.209, 1000.211 + 1, 3, 1275, 1)
local BincExe2 = createPickup(204.422, -159.938, 999.523 + 1, 3, 1275, 1)
local BincExe3 = createPickup(217.65, -5.113, 1000.211 + 1, 3, 1275, 1)

setElementDimension(BincExe1, 1)
setElementDimension(BincExe2, 2)
setElementDimension(BincExe3, 3)

setElementInterior(BincExe1, 15)
setElementInterior(BincExe2, 14)
setElementInterior(BincExe3, 5)
]]--

addEventHandler ("onClientRender", root,
function ()
    if (PanelSk == true) then
    rotz[localPlayer] = rotz[localPlayer] + 1
	exports.object_preview:setRotation(myObject,-0, 0, rotz[localPlayer])
    end
end
)

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end


PanelSk = false
function PanelSkin ()
for k,v in pairs(SkinPed) do
	local ID = skinID[localPlayer]
	   if (ID == v[1]) then
        dxDrawImage(x*0, y*0, x*1280, y*720, "Files/walpaper.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if (v[2] == 0) then
        dxDrawRectangle(x*50, y*338, x*367, y*58, tocolor(254, 161, 0, 106), false)
        dxDrawRectangle(x*50, y*414, x*367, y*58, tocolor(255, 254, 254, 154), false)
        dxDrawText("SKIN GRÀTIS", x*49, y*339, x*417, y*396, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("SAIR", x*49, y*414, x*417, y*471, tocolor(0, 0, 0, 154), 2.00, "default-bold", "center", "center", false, false, false, false, false)
		else
		if (getElementModel(localPlayer) == v[2]) then 
		dxDrawRectangle(x*50, y*414, x*367, y*58, tocolor(255, 254, 254, 154), false)
        dxDrawText("SAIR", x*49, y*414, x*417, y*471, tocolor(0, 0, 0, 154), 2.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("SKIN COMPRADA", x*49, y*339, x*417, y*396, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
		else
		if (getElementData(localPlayer, "SK"..v[1])) then
        dxDrawRectangle(x*50, y*338, x*367, y*58, tocolor(220, 163, 198, 106), false)
        dxDrawRectangle(x*50, y*414, x*367, y*58, tocolor(255, 254, 254, 154), false)
        dxDrawText("USAR", x*49, y*339, x*417, y*396, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("SAIR", x*49, y*414, x*417, y*471, tocolor(0, 0, 0, 154), 2.00, "default-bold", "center", "center", false, false, false, false, false)
		else
        dxDrawRectangle(x*50, y*338, x*367, y*58, tocolor(220, 163, 198, 106), false)
        dxDrawRectangle(x*50, y*414, x*367, y*58, tocolor(255, 254, 254, 154), false)
        dxDrawText("COMPRAR", x*49, y*339, x*417, y*396, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("SAIR", x*49, y*414, x*417, y*471, tocolor(0, 0, 0, 154), 2.00, "default-bold", "center", "center", false, false, false, false, false)
		end
       end
      end
    end
  end
end

function values()
local ID = skinID[localPlayer]
  for k,v in pairs(SkinPed) do
    if ID == v[1] then
        dxDrawText("SKIN ID: ("..v[2]..")", x*136, y*486, x*434, y*534, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("R$ "..(convertNumber(v[3])), x*136, y*544, x*434, y*592, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "center", false, false, false, false, false)
        if (ID > 1) then
		--dxDrawRectangle(x*922, y*459, x*70, y*60, tocolor(0, 0, 0, 154), false)
     	dxDrawText("<", x*922, y*463, x*992, y*523, tocolor(255, 255, 255, 255), 2.00, "pricedown", "center", "bottom", false, false, false, false, false)
		end
		else
		if (ID < 20) then
        --dxDrawRectangle(x*1036, y*459, x*70, y*60, tocolor(0, 0, 0, 154), false)
		dxDrawText(">", x*1036, y*463, x*1106, y*523, tocolor(255, 255, 255, 255), 2.00, "pricedown", "center", "bottom", false, false, false, false, false)
		end
	  end
   end
end

function MenuModos ( button,state,thePlayer )
local ID = skinID[localPlayer]
    if PanelSk == true then
          if  state == "down"  then 
                if  isCursorOnElement(x*1036, y*459, x*70, y*60) then
                  if ID < 20 then
				     skinID[localPlayer] = skinID[localPlayer] + 1
                    setSkin ()
					end
                end
          end
    end
end
addEventHandler("onClientClick",getRootElement(), MenuModos)

function MenuModos2 ( button,state,thePlayer )
local ID = skinID[localPlayer]
     if PanelSk == true then
       if  state == "down"  then 
            if isCursorOnElement(x*922, y*459, x*70, y*60) then
              if ID > 1 then
                 skinID[localPlayer] = skinID[localPlayer] - 1
				 setSkin ()	
              end				 
           end
       end
   end
end
addEventHandler("onClientClick",getRootElement(), MenuModos2)

function setSkin ()
local ID = skinID[localPlayer]
if (PanelSk == true) then
   for k,v in pairs(SkinPed) do
   if (ID == v[1]) then
   setElementModel(myElement, v[2])
   end
   end
  end
end

function buySkin ( button,state,thePlayer )
if PanelSk == true then
    if  state == "down"  then 
        if isCursorOnElement(x*50, y*338, x*367, y*58) then
		buySkinCX ()
        end
        end
    end
end
addEventHandler("onClientClick",getRootElement(), buySkin)

function buySkinCX ()
local ID = skinID[localPlayer]
 for k,v in pairs(SkinPed) do
  if (ID == v[1]) then
   if (getElementData(localPlayer, "SK"..v[1])) or (v[2] == 0) then
   -- setElementModel(localPlayer, v[2])
    triggerServerEvent("skinsetloja", root, localPlayer, v[2])
  
    else
	local money = getElementData(localPlayer, "char:money")
    if money >= v[3] then
	
	   setElementData(localPlayer, v[1], true)
	   triggerServerEvent("SaveSQL", root, localPlayer, v[1], v[3], v[2])
       else
	   triggerServerEvent("SaveSQL", root, localPlayer, v[1], v[3])
	   end
	  end
    end				 
  end
end
 
function creatPedProjection()
local ID = skinID[localPlayer]
  ShopW, ShopH = x*250, y*500
    x1, y1, z1 = getCameraMatrix()
	    for k,v in pairs(SkinPed) do
		  if (ID == v[1]) then
	      myElement = createPed (9, x1, y1, z1)
          myObject = exports.object_preview:createObjectPreview(myElement, 5, 5, 0, x*490, y*2, x*ShopW, y*ShopH, false, true, true)
		end
	end
end

function resetPedProjection ()
   exports.object_preview:destroyObjectPreview(myObject)
		myElement = nil
		myObject = nil
end

function Open ()
if (PanelSk == false) then
   showChat(false)
      sound = playSound( "files/Sound.mp3", true )
         addEventHandler ("onClientRender", root, PanelSkin)
		 addEventHandler ("onClientRender", root, values)
		 resetPedProjection ()
            tick1 = getTickCount()
            showCursor (true)
			showChat(false)
            PanelSk = true
            skinID[localPlayer] = 1
            rotz[localPlayer] = 0
			creatPedProjection()
			l_0_1 = true
          else
		    destroyElement(myElement)
		    exports.object_preview:destroyObjectPreview(myObject)
            removeEventHandler ("onClientRender", root, PanelSkin)
			removeEventHandler ("onClientRender", root, values)
			showChat(true)
         showCursor (false)
      PanelSk = false
	l_0_1 = false
    end
end
addEvent("OpenXS", true)
addEventHandler("OpenXS", root, Open)

function cloedPanel ( button,state,thePlayer )
if (PanelSk == true) then
    if  state == "down"  then 
        if isCursorOnElement(x*50, y*414, x*367, y*58) then
		Open ()
		resetPedProjection ()
        end
        end
    end
end
addEventHandler("onClientClick",getRootElement(), cloedPanel)

--------------
--[[
function dxDrawImageOnElement(x, y, z,Image,distance,height,width,R,G,B,alpha)
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
	
pos3D = {
 {1347.31, 191.29, 18.603},
 {1272.7690429688,-1537.6707763672,12.563931465149},
 {-2288.352, -87.877, 34.3},
}	
	
local tag = dxCreateTexture("Files/shop_icon.png")

addEventHandler("onClientPreRender", root,
function()
     for k,v in ipairs(pos3D) do
         dxDrawImageOnElement(v[1], v[2], v[3] + 1,tag)
     end
end) 
]]--
--[]




local x,y = guiGetScreenSize()
 function isCursorOnElement(x,y,w,h)
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end
