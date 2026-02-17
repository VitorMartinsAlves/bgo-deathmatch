if fileExists("sourceC.lua") then
	fileDelete("sourceC.lua")
end


data = { }
function datachange(value)
	if (data[value] == nil) then
		data[value] = 1
	else
		data[value] = data[value] + 1
	end
end
--addEventHandler("onClientElementDataChange", getRootElement(), datachange)

function playSounds(asd)

	sound = playSound("files/".. asd ..".wav")
	setSoundMinDistance(sound,5)
end
addEvent("playSounds",true)
addEventHandler("playSounds",getRootElement(),playSounds)

function sendLocalMeMessage(player, msg)
	triggerServerEvent("sendLocalMeAction",player,player,msg)
end
addEvent("sendLocalMeMessage", true)
addEventHandler("sendLocalMeMessage", root, sendLocalMeMessage)

--bindKey("b", "down", "chatbox", "LocalOOC")


--local interface = exports["bgo_interface"]


function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x,y,w+1,1,color) -- Fent
	dxDrawRectangle(x,y+1,1,h,color) -- Bal Oldal
	dxDrawRectangle(x+1,y+h,w,1,color) -- Lent Oldal
	dxDrawRectangle(x+w,y+1,1,h,color) -- Jobb Oldal
end

function radioMessage()

	--playSoundFrontEnd(47)
	--setTimer(playSoundFrontEnd, 700, 1, 48)
	--setTimer(playSoundFrontEnd, 800, 1, 48)

end
addEvent("radioMessage", true)
addEventHandler("radioMessage",  getRootElement(), radioMessage)

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local textsToDraw = {}

local hideown
local showtime
local characteraddition
local maxbubbles

--local font = dxCreateFont( "fontok/myriadproregular.ttf", 12 )

local showthebubbles = true

function income(message,messagetype)
	if source ~= getLocalPlayer() or not hideown then
		addText(source,message,messagetype)
	end
end

function addText(source,message,messagetype)
	local notfirst = false
	for i,v in ipairs(textsToDraw) do
		if v[1] == source then
			v[4] = v[4] + 1
			notfirst = true
		end
	end
	local infotable = {source,message,messagetype,0}
	table.insert(textsToDraw,infotable)
	if not notfirst then
		setTimer(removeText,showtime + (#message * characteraddition),1,infotable)
	end
end

function removeText(sinfotable)
	for i,v in ipairs(textsToDraw) do
		if v[1] == sinfotable[1] and v[2] == sinfotable[2] then
			for i2,v2 in ipairs(textsToDraw) do
				if v2[1] == v[1] and v[4] - v2[4] == 1 then
					if(v[4] > maxbubbles) then -- Régieket töröljük amit nem látunk
						setTimer(removeText,50,1,v2)
					else
						setTimer(removeText,showtime + (#v2[2] * characteraddition),1,v2)
					end
				end
			end
			table.remove(textsToDraw,i)
			break
		end
	end
end

function getTextsToRemove()
	for i,v in ipairs(textsToDraw) do
		if v[1] == source then
			removeText(v)
		end
	end
end

function handleDisplay()
	if showthebubbles then
		for i,v in ipairs(textsToDraw) do
			if isElement(v[1]) then
				if getElementHealth(v[1]) > 0 then
					local camPosXl, camPosYl, camPosZl = getPedBonePosition (v[1], 6)
					local camPosXr, camPosYr, camPosZr = getPedBonePosition (v[1], 7)
					local x,y,z = (camPosXl + camPosXr) / 2, (camPosYl + camPosYr) / 2, (camPosZl + camPosZr) / 2
					local cx,cy,cz = getCameraMatrix()
					local px,py,pz = getElementPosition(v[1])
					local distance = getDistanceBetweenPoints3D(cx,cy,cz,px,py,pz)
					local posx,posy = getScreenFromWorldPosition(x,y,z+0.3)
					local elementtoignore1 = getPedOccupiedVehicle(getLocalPlayer()) or getLocalPlayer()
					local elementtoignore2 = getPedOccupiedVehicle(v[1]) or v[1]
					if posx and distance <= 15 and ( isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore1) or isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore2) ) and ( not maxbubbles or  v[4] < maxbubbles ) then 
						local width = dxGetTextWidth(v[2],0.9,"default")
						local kozep = posx - (22 + (0.5 * width))
						
						local r,g,b = 255,255,255
						local kieg = ""
						-- Do
						if v[3] == 1 then
							r,g,b = 255, 51, 102
						-- Me
						elseif v[3] == 2 then
							r,g,b = 194, 162, 218
						elseif v[3] == 3 then
							kieg = "_s"						
						elseif v[3] == 4 then
							kieg = "_s"						
						end
						
						dxDrawRectangle(posx - (0.5 * width)-10,posy - (v[4] * 25)-20,width + 23,20,tocolor(0,0,0,170))
						dxDrawText(v[2],posx - (0.5 * width),posy - (v[4] * 25)-18,posx - (0.5 * width),posy - (v[4] * 25)+150,tocolor(r,g,b,255),0.9,"default","left","top",false,false,false,true,true)
					end
				end
			end
		end
	end
end
addEventHandler("onClientHUDRender",getRootElement(),handleDisplay)


function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.4)
end


function getServerSettings()
    triggerServerEvent("onAskForBubbleSettings",getLocalPlayer())
end

function saveSettings(settings)
	showtime = settings[1]
	characteraddition = settings[2]
	maxbubbles = settings[3]
	hideown = settings[4]
	addEvent("onMessageIncome",true)
	addEventHandler("onMessageIncome",getRootElement(),income)
end

addEventHandler("onClientPlayerQuit",getRootElement(),getTextsToRemove)


addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),getServerSettings)
addEvent("onBubbleSettingsReturn",true)
addEventHandler("onBubbleSettingsReturn",getRootElement(),saveSettings)


setElementData(localPlayer,"chatbubbles",1)



--local sx,sy = guiGetScreenSize ()

local sx1, sy1 = guiGetScreenSize()
local sx,sy = ( sx1 / 1024 ), ( sy1 / 768 )


local chatData = getChatboxLayout()
local oocState = true
local maxLines = 10
local oocMessages = {}
local font = "default-bold"
local _,scale = chatData["chat_scale"]
local bg = {chatData["chat_color"]}
--local color = {205,205,205,255}
local color = {255,255,255,255}
local lines = chatData["chat_lines"]
local chatX,chatY = 14.515625*sx, 87
local szint = ""
local DefaultTime = 6;
local bgoadmin = false
addEventHandler ("onClientHUDRender",getRootElement(),
	function ()
	
		if getElementData(localPlayer, "loggedin") then
		if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
		bgoadmin = exports.bgo_admin:isPlayerDuty(localPlayer) --or (getElementData(localPlayer,"acc:id") == 1)
		else	
		bgoadmin = false
		end
		
		if bgoadmin then
				if oocState then
				local line = 10
				local scale2 = 1.5
				Font1 = "default-bold"
				Chat1 = (line-3)*30
				for k,v in ipairs(oocMessages) do
					if ( v.rTick <= getTickCount ( ) ) then
					table.remove ( oocMessages, k )
					end
		
					local tx,ty = chatX,chatY + (maxLines+2)*15 - k*27
					dxDrawText (removeHex(tostring ( v.text )),tx+1,ty+Chat1+1,sx*0,sy*0,tocolor(0,0,0,255), sy*0.85 ,Font1,"left","top",false,false,false)
					dxDrawText (tostring ( v.text ),tx,ty+Chat1,sx*0,sy*0,tocolor(color[1],color[2],color[3],color[1]), sy*0.85 ,Font1,"left","top",false,false,false,true)
					end
				end
			end
		end
	end
)

function removeHex(text, digits)
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (digits and string.rep("%x", digits) or "%x+"), "")
end

addEvent ("onOOCMessageSend",true)
addEventHandler ("onOOCMessageSend",getRootElement(),
	function (message,_,szin)
		local player = source
		local int,dim = getElementInterior (player),getElementDimension(player)
		if int == getElementInterior (getLocalPlayer()) and dim == getElementDimension (getLocalPlayer()) then
				local length = #oocMessages
				if #oocMessages >= maxLines then
					table.remove (oocMessages,maxLines)
				end
				szint = szin
				
				local time = tonumber ( time ) or DefaultTime

				
				local data = { 
				text =  message,
				rTick = getTickCount ( ) + (time*3000)
				}
				
				
				table.insert (oocMessages,1,data)
				
				
				if player ~= getLocalPlayer () then
					outputConsole (text)
				end
		end
	end
)

function isOOCChatToggled ()
	return oocState
end

function toggleOOCChat (state)
	if state ~= oocState then
		oocState = state
	end
end

function togOOCCMD (cname,arg)
		toggleOOCChat ( not oocState )
end
addCommandHandler ("fcopom",togOOCCMD)

function co ()
	for k in pairs (oocMessages) do
    oocMessages[k] = nil
	end
end
addCommandHandler ("lcopom",co)

