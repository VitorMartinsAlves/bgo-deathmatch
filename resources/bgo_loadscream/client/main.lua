sx,sy = guiGetScreenSize()
x,y =  (sx/1366), (sy/768)
local root = getRootElement()
local resourceRoot = getResourceRootElement(getThisResource())
local screenWidth, screenHeight = guiGetScreenSize()
local blurStrength = 8
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)

messages = {}
local posi = 30
local Animation = 0
local ATimer
local Frames = 0

local Angle, Radius, AnimCenter
local MoveSpeed, AnimMove
local GrooveAnim, LookAt

function resetCoordinates(number)
	if number == 1 then
		Angle = 120
		Radius = 120
		AnimCenter = {
			x = 1544.1,
			y = -1353.3,
			z = 210
		}

	elseif number == 2 then

		MoveSpeed = 0.0001
		AnimMove = {
			x = 416,
			y = -1348,
			z = 17
		}

	elseif number == 3 then

		GrooveAnim = {
			x = 2379,
			y = -1658,
			z = 14
		}

		LookAt = {
			x = 2477, 
			y = -1670,
			z = 14
		}

	end
end

function startLoginAnimation(number)

	if isTimer(ATimer) then return false end
	fadeCamera(false, 2)

	ATimer = setTimer(function()
		fadeCamera(true, 2)
		Frames = 0
		Animation = number
		triggerEvent("startLoginAnimation", localPlayer, number)
	end, 2000, 1)

end

function stopLoginAnimation()

	if isTimer(ATimer) then killTimer(ATimer) end

	fadeCamera(false, 2)

	ATimer = setTimer(function()
		Animation = 0
		setCameraTarget(localPlayer)
		fadeCamera(true, 2)
	end, 2000, 1)
end

addEvent("startLoginAnimation", true)
addEventHandler("startLoginAnimation", root, resetCoordinates)

addEventHandler("onClientRender", root, function()
	if Animation > 0 then Frames = Frames+1 end

	if Animation == 1 then

		Angle = Angle+0.15

		local x = AnimCenter.x + Radius*math.cos( math.rad(Angle) )
		local y = AnimCenter.y - Radius*math.sin( math.rad(Angle) )
		local z = AnimCenter.z + 70

		AnimCenter.z = AnimCenter.z - 0.05

		setCameraMatrix(x, y, z, AnimCenter.x, AnimCenter.y, AnimCenter.z, 0, 90)

		if Frames == 750 then
			startLoginAnimation(2)
		end

	elseif Animation == 2 then

		AnimMove.x = AnimMove.x + 0.12
		AnimMove.y = AnimMove.y + 0.08
		AnimMove.z = AnimMove.z + MoveSpeed

		MoveSpeed = MoveSpeed + 0.00006

		local lx = AnimMove.x - 6
		local ly = AnimMove.y - 4
		local lz = AnimMove.z - 1 + (30*MoveSpeed)

		setCameraMatrix(AnimMove.x, AnimMove.y, AnimMove.z, lx, ly, lz, 0, 90)

		if Frames == 620 then
			startLoginAnimation(3)
		end

	elseif Animation == 3 then

		GrooveAnim.x = GrooveAnim.x + 0.14
		if GrooveAnim.x > LookAt.x then GrooveAnim.z = GrooveAnim.z + 0.01 end

		setCameraMatrix(GrooveAnim.x, GrooveAnim.y, GrooveAnim.z, LookAt.x, LookAt.y, LookAt.z, 0, 90)

		if Frames == 800 then
			startLoginAnimation(1)
		end

	end

end)
--[[
local sounds = {
				"803959660",
				"803959645",
				"803959660",
				"803959645",
				"803959660",
				"803959645",
} 
  ]]--
 
 local sounds = {
				"112274484",
}  


local musica = true

function onClientResourceStart()
	if getElementData(localPlayer, "loggedin") == false then
	tick = getTickCount()
	font = dxCreateFont("gfx/sans-pro-regular.ttf", 30)
	som2 = playSound("http://api.soundcloud.com/tracks/"..sounds[math.random(1, #sounds)].."/stream?client_id=N2eHz8D7GtXSl6fTtcGHdSJiS74xqOUI", true)
	setSoundVolume(som2, 0.05)
	setCameraMatrix(1544.1, -1353.3, 210, 1544.1, -1353.3, 210, 0, 90)
	setTimer(checkTransfer,2000,1)
	showCursor(true)
	showChat(false)
	addEventHandler("onClientRender", root, paint)
end
end
addEventHandler("onClientResourceStart",resourceRoot,onClientResourceStart)



function checkTransfer()    
    if isTransferBoxActive() == true then
        setTimer(checkTransfer,2000,1) -- Check again after 2 seconds
    else 
        removeEventHandler("onClientRender", root, paint)
		destroyElement(som2)
		setElementData(localPlayer, "saiudaespera", false)
		showCursor(false)
		--showChat(true)
		musica = false
		stopLoginAnimation()
		
    end
end

--addEventHandler("onClientResourceStart",resourceRoot,checkTransfer)


function paint()
	local rh,ry = interpolateBetween(0, (y*559/2)+y*105, 0, y*559, y*105, 0, (getTickCount()-tick)/1400, "Linear")

--[[
	 if (blurShader) then
        dxUpdateScreenSource(myScreenSource)
        
        dxSetShaderValue(blurShader, "ScreenSource", myScreenSource);
        dxSetShaderValue(blurShader, "BlurStrength", blurStrength);
		dxSetShaderValue(blurShader, "UVSize", screenWidth, screenHeight);

        dxDrawImage(0, 0, screenWidth, screenHeight, blurShader)
    end]]--

	if getTickCount()-tick > 2500 then

		local rotation22 = 0
		local anim2 = getSoundFFTData(som2, 2048, 2)
		for i,v in pairs(anim2) do
		rotation1 = math.round((v*330),0)
		rotation22 = math.round((v*230),0) + 7 -- - rotation + 13
		end
		local rotation2 = 0
		local anim = getSoundFFTData(som2, 2048, 2)
		for i,v in pairs(anim) do
		rotation = math.round((v*420),0)
		rotation2 = math.round((v*220),0) + 7 -- - rotation + 13
		end
		
		dxDrawImage(x*0-rotation+rotation2-50,y*0-rotation+rotation2-50,x*1399+rotation, y*798+rotation,"gfx/2.png",0,0,0,tocolor(255,255,255,255))

			if isMouseInPosition (x*35,y*60,x*49, y*48) then 
				dxDrawImage(x*35,y*60,x*49, y*48,"gfx/pause.png",0,0,0,tocolor(255,0,0,255))
			else
				dxDrawImage(x*35,y*60,x*49, y*48,"gfx/pause.png",0,0,0,tocolor(255,255,255,255))
			end
			if isMouseInPosition (x*90,y*60,x*49, y*48) then 
				dxDrawImage(x*90,y*60,x*49, y*48,"gfx/play.png",0,0,0,tocolor(255,0,0,255))
			else
				dxDrawImage(x*90,y*60,x*49, y*48,"gfx/play.png",0,0,0,tocolor(255,255,255,255))
			end
		
		

		dxDrawImage(x*523-rotation1+rotation22,y*110-rotation1+rotation22,x*299+rotation1, y*299+rotation1,"gfx/logo.png",0,0,0,tocolor(0,0,0,255))
		dxDrawImage(x*523-rotation+rotation2,y*110-rotation+rotation2,x*299+rotation, y*299+rotation,"gfx/logo.png",0,0,0,tocolor(255,255,255,255))

		--dxDrawText("BEM VINDO AO MELHOR ROLEPLAY DO MUNDO!",x*585,y*412-rotation1+rotation22,x*588+x*192,y*592+y*43+rotation1,tocolor(0,0,0),y*0.9,font,"center","center",false,false,false,true)
		--dxDrawText("BEM VINDO AO MELHOR ROLEPLAY DO MUNDO!",x*584,y*410-rotation+rotation2,x*588+x*192,y*592+y*43+rotation,tocolor(255,255,255),y*0.9,font,"center","center",false,false,false,true)


		--dxDrawText("Baixando recursos do servidor!",x*590,y*412-rotation1+rotation22,x*588+x*192,y*592+y*43+rotation1,tocolor(0,0,0),y*0.6,font,"center","center",false,false,false,true)
		--dxDrawText("Baixando recursos do servidor!",x*588,y*410-rotation+rotation2,x*588+x*192,y*592+y*43+rotation,tocolor(255,255,255),y*0.6,font,"center","center",false,false,false,true)

					

		--dxDrawText("Discord do servidor : https://discord.gg/z2Cs2u",x*590,y*492-rotation1+rotation22,x*588+x*192,y*592+y*43+rotation1, tocolor(0,0,0),y*0.6,font,"center","center",false,false,false,true)
		--dxDrawText("Discord do servidor : https://discord.gg/z2Cs2u",x*588,y*490-rotation+rotation2,x*588+x*192,y*592+y*43+rotation,tocolor(255,255,255),y*0.6,font,"center","center",false,false,false,true)


end
end


addEventHandler('onClientClick', root, function (button, state, _, _, _, _, _, element)
	if button == 'left' and state == 'down' and musica then 

			if isMouseInPosition (x*35,y*60,x*49, y*48) then
			setSoundPaused(som2, true)
		elseif isMouseInPosition (x*90,y*60,x*49, y*48) then
			setSoundPaused(som2, false)
			end
	end
end)


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


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



function dxDrawBorder2(posX, posY,posW,posH,color,scale)
	dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)
	dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)
	dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)
	dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)
end


function dxDrawBorder(posX, posY,posW,posH,color,scale)
	dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)
	dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)
	dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)
	dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)
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


deletefiles =
            { "client/main.lua"
}

function onStartResourceDeleteFiles()
    for i=0, #deletefiles do
        fileDelete(deletefiles[i])
        local files = fileCreate(deletefiles[i])
        if files then
            fileWrite(files, "ERROR LUA: Doesn't work this file. Please report on contact in http://www.lua.org/contact.html")
            fileClose(files)
        end
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStartResourceDeleteFiles)