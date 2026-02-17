--BGOMTA 2017

if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end
if fileExists("Kliens.luac") then
	fileDelete("Kliens.luac")
end
local x, y = guiGetScreenSize()
local settings = {}
settings.font = dxCreateFont("files/roboto.ttf", 20)
--settings.maxdis = 20 -- max távolság
settings.anames = false
settings.maxdis = 50
local screenW, screenH = guiGetScreenSize()
windowSize = {1130, 750}
windowSize = {(windowSize[1] * screenW / 1280) , (windowSize[2] * screenH / 720)}

local levelNames = {
	"#ff00a0(SUPORTE EM TESTE)", 
	"#2d3cee(SUPORTE)",
	"#01f827(MODERADOR)",
	"#00dcff(SUB ADMINISTRADOR)", 
	"#00ff90(ADMINISTRADOR)",
	"#999595(ADMINISTRADOR GERAL)",
	"#8A2BE2(SUB GAME MASTER)",
	"#030303(GAME MASTER)", 
	"#FF0000(SUPORTE DE CONTAS)", 
	"#C25151(DEUS)"
}
levelNames[0] = ""


local VoiceON = {}
function clamp(val, lower, upper)
    if (lower > upper) then lower, upper = upper, lower end
    return math.max(lower, math.min(upper, val))
end

local helperNames = {"#C71585(Helper)", "#C71585(Helper)"}
helperNames[0] = ""

function getAdminLevelName(player)
	if getElementData(player, "char:adminduty") == 0 then return "" end
	return levelNames[getElementData(player, "acc:admin")]
end

function getHelperLevelName(player)
	return helperNames[getElementData(player, "acc:aseged")]
end

local alpha = 200
local screenW2, screenH2 = guiGetScreenSize()
local x2,y2 = (screenW2/1360), (screenH2/768)

addEventHandler("onClientPreRender",root, function()
				if getElementData(localPlayer, "loggedin") == false then return end
				local x1,y1,z1 = getElementPosition(localPlayer)
				local tabela = getElementsWithinRange( x1,y1,z1, settings.maxdis, "player" )
				local v = nil
				for k = 1, #tabela do
				v = tabela[k] 
				if isElement(v) and isElementOnScreen(v) then
				
				
				
				if v ~= localPlayer then
				if not getElementData(v, "loggedin") then return end
				local x2,y2,z2 = getElementPosition(v)
				local cx,cy,cz = getCameraMatrix()
				local headPosX,headPosY,headPosZ = getPedBonePosition(v,4)
				local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
				local distance = distance-(distance/3)
				local progress = distance/settings.maxdis
				local scale = interpolateBetween(0.7, 0, 0, 0.2, 0, 0, progress, "OutQuad")
				local scale = scale*(x+1920)/(1920*1.1)
				local progress2 = distance/30
				local scale2 = interpolateBetween(0.7, 0, 0, 0.0, 0, 0, progress2, "OutQuad")
				local scale2 = scale2*(x+1920)/(1920*2.2)
				local clear = isLineOfSightClear(cx,cy,cz,headPosX,headPosY,headPosZ,true,false,false,true,false,false,false)
				local adminduty = getElementData(localPlayer, "char:adminduty")
				local adminlevel = getElementData(v, "acc:admin")
				local adminhelper = getElementData(v, "acc:aseged")
				local adminduty = getElementData(v, "char:adminduty")
				local adutyText = " "..getAdminLevelName(v)
				local helperText = " "..getHelperLevelName(v)

				if distance < settings.maxdis then
					local sx,sy = getScreenFromWorldPosition(x2,y2,headPosZ+0.38)
					if sy then
						sy = sy-15
					end
					local name = getPlayerName(v)
					if name then
						local nameformat = string.gsub(string.gsub(name, "#%x%x%x%x%x%x", ""),"_", " ")
						local id = getElementData(v, "playerid")
						
						if adminlevel > 0 then
							text = adutyText.."\n("..id..")"
						else
							text = helperText.."\n("..id..")"
						end
						local badge = getElementData(v, "jelveny:state")
						local badgeText = ""
						if badge then
							if sy then
								sy = sy-20
							end
							badgeText = "\n#F39C12("..getElementData(v, "jelveny:text")..")"
						end

						local colorAlpha = 255
						if getElementHealth(v) == 0 then
							colorAlpha = 80
						end

						if sx and sy and name and id then
							if not settings.anames then --and clear then
							
								





							if(getElementData(v, "inCall2") and not getElementData(v, "VoiceCor")) then	
							if getElementData(v, "char:adminduty") == 0 then
							if clear then
							dxDrawText("NO CELULAR", sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale2, settings.font, "center", "top", false, false, false, true)
							dxDrawText("NO CELULAR", sx, sy, sx, sy, tocolor(247, 255, 0,colorAlpha), scale2, settings.font, "center", "top", false, false, false, true)
							end
							end
							end
							
							if(getElementData(v, "VoiceCorCall") and not getElementData(v, "inCall2")) then	
							if getElementData(v, "char:adminduty") == 0 then
							if clear then
							dxDrawText("NO RADINHO", sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale2, settings.font, "center", "top", false, false, false, true)
							dxDrawText("NO RADINHO", sx, sy, sx, sy, tocolor(247, 255, 0,colorAlpha), scale2, settings.font, "center", "top", false, false, false, true)
							end
							end
							end


							if(getElementData(v, "VoiceCor") and not getElementData(v, "VoiceCorCall") and not getElementData(v, "inCall2")) then								
									if getElementData(v, "char:adminduty") == 0 then
									if clear then
									
									local voz2 = getElementData(v, "ModoVoz")
									if voz2 == "#00ff00Normal" then
									dxDrawText("FALANDO", sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale2, settings.font, "center", "top", false, false, false, true)
									dxDrawText("FALANDO", sx, sy, sx, sy, tocolor(247, 255, 0,colorAlpha), scale2, settings.font, "center", "top", false, false, false, true)
									elseif voz2 == "#00FBFFSussurro" then
									dxDrawText("SUSSURRANDO", sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale2, settings.font, "center", "top", false, false, false, true)
									dxDrawText("SUSSURRANDO", sx, sy, sx, sy, tocolor(247, 255, 0,colorAlpha), scale2, settings.font, "center", "top", false, false, false, true)
									end
									end
								end
							end
							

								if getElementData(v, "char:adminduty") == 1 and not getElementData(v, "reconx") then
									if clear then
									dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale-0.5, settings.font, "center", "top", false, false, false, true)
									dxDrawText(text, sx, sy, sx, sy, tocolor(255,255,255,colorAlpha), scale-0.5, settings.font, "center", "top", false, false, false, true)
									if progress < 1 then
										local scale = interpolateBetween(0.7, 0, 0, 0, 0, 0, progress, "OutQuad")
										local width, height = 210*scale, 190*scale
										local sx, sy = sx-width/2, sy-height
										
										local adminlevel = getElementData(v, "acc:admin")
										
										local logoPath = "files/admin.png"
										dxDrawImage(sx, sy, width, height, logoPath, 0, 0, 0, tocolor(255,255,255,255))
									end
									end
									end	

									if getElementData(localPlayer, "char:admincabeca") == 1  then
									if tonumber(getElementData(v, "acc:admin") or 0) >= 1 and tonumber(getElementData(v, "acc:admin") or 0) <= 5 then
										dxDrawText(string.gsub(name, "#%x%x%x%x%x%x", ""), sx+1, sy-74, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
										dxDrawText(name, sx, sy-75, sx, sy, tocolor(255, 255, 255,colorAlpha), scale, settings.font, "center", "top", false, false, false, true)
									end
									
									end
									
									if getElementData(localPlayer, "char:admincabeca") == 1  then
									if tonumber(getElementData(localPlayer, "acc:admin") or 0) >= 7 then
									if tonumber(getElementData(v, "acc:admin") or 0) >= 5 then
										dxDrawText(string.gsub(name, "#%x%x%x%x%x%x", ""), sx+1, sy-74, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
										dxDrawText(name, sx, sy-75, sx, sy, tocolor(255, 255, 255,colorAlpha), scale, settings.font, "center", "top", false, false, false, true)
									end
									end
									end

									--end

									if getElementData(localPlayer, "char:admincabecaRES") == 1  then
										if getElementData(v, "char:dutyfaction") == 4 then
											dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx+1, sy-74, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
											dxDrawText(text, sx, sy-75, sx, sy, tocolor(255, 255, 255,colorAlpha), scale, settings.font, "center", "top", false, false, false, true)
									end
									end
 

								
					
	
							if (getElementData(localPlayer, "char:adminduty") == 1) then
							if not getElementData(v, "invisible") then	
								--if getElementData(v, "char:adminduty") == 0 then
								if getElementData(v, "char:adminduty") == 0 then	
							
									dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
									dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx, sy, sx, sy, tocolor(255,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
									
									dxDrawText(string.gsub(badgeText, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale/10, settings.font, "center", "top", false, false, false, true)
									dxDrawText(badgeText, sx, sy, sx, sy, tocolor(255,255,255,255), scale/10, settings.font, "center", "top", false, false, false, true)
							end
							end
							end
							

							
								--[[	
							elseif settings.anames then
							
								if (not getElementData(v, "invisible")) or (getElementData(v, "invisible") and getElementData(localPlayer, "acc:admin") >= 6) then
									dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
									dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx, sy, sx, sy, tocolor(255,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
									
									dxDrawText(string.gsub(badgeText, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale/10, settings.font, "center", "top", false, false, false, true)
									dxDrawText(badgeText, sx, sy, sx, sy, tocolor(255,255,255,255), scale/10, settings.font, "center", "top", false, false, false, true)
								end
							end
							
							if settings.anames then
								if (not getElementData(v, "invisible")) or (getElementData(v, "invisible") and getElementData(localPlayer, "acc:admin") >= 6) then
									local scale = interpolateBetween(0.7, 0, 0, 0, 0, 0, progress, "OutQuad")
									local width, height = 200*scale, 100*scale
									local sx, sy = sx-width/2, sy-height

									dxDrawRectangle(sx, sy+height-height/10, width*0.45, height/10, tocolor(0,0,0,200))
									dxDrawRectangle(sx, sy+height-height/10, width*0.45/100*getElementHealth(v), height/10, tocolor(255,255,0,180))
									
									dxDrawRectangle(sx+width*0.55, sy+height-height/10, width*0.45, height/10, tocolor(0,0,0,200))
									dxDrawRectangle(sx+width*0.55, sy+height-height/10, width*0.45/100*getPedArmor(v), height/10, tocolor(82,179,217,180))
								end
								]]--
							end
							
						end
						
					end
				end
			end
		end
	end


	
			local tabela = getElementsWithinRange( x1,y1,z1, 20, "ped" )
			local v = nil
			for k = 1, #tabela do
			v = tabela[k] 
			
		if isElement(v) and isElementOnScreen(v) then
			if v ~= localPlayer then
					local x2,y2,z2 = getElementPosition(v)
					local cx,cy,cz = getCameraMatrix()
					local headPosX,headPosY,headPosZ = getPedBonePosition(v,4)
					local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
					local distance = distance-(distance/3)
					local progress = distance/20 --settings.maxdis
					local scale = interpolateBetween(0.7, 0, 0, 0.2, 0, 0, progress, "OutQuad")
					local scale = scale*(x+1920)/(1920*1.9)
					local clear = isLineOfSightClear(cx,cy,cz,x2,y2,headPosZ,true,false,false,true,false,false,false)
					if distance < 20 then --settings.maxdis then
					local sx,sy = getScreenFromWorldPosition(x2,y2,headPosZ+0.38)
					if sy then
						sy = sy-15
					end
					
					--[[
					if (getElementData(localPlayer, "char:adminduty") == 1) then
					
					local name2 = getElementData(v, "Ped:NameMorto")
					if not name2 then return end
					local nameformat2 = string.gsub(string.gsub(name2, "#%x%x%x%x%x%x", ""),"_", " ")
					local text2 = "#f2921e[MORTO]: #ffffff "..nameformat2
					if sx and sy and name2 then
						dxDrawText(string.gsub(text2, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
						dxDrawText(text2, sx, sy, sx, sy, tocolor(255,255,255,255), scale, settings.font, "center", "top", false, false, false, true)
					end
					
					
					end]]--
					
					--[[
					if (getElementData(localPlayer, "char:dutyfaction") == 4) then
					
					
					local name2 = getElementData(v, "Ped:NameMorto")
					if not name2 then return end
					local nameformat2 = string.gsub(string.gsub(name2, "#%x%x%x%x%x%x", ""),"_", " ")
					local text2 = "#f2921e[MORTO]"
					if sx and sy and name2 then
						dxDrawText(string.gsub(text2, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
						dxDrawText(text2, sx, sy, sx, sy, tocolor(255,255,255,255), scale, settings.font, "center", "top", false, false, false, true)
					end
					
					
					end]]--
					
					local name = getElementData(v, "Ped:Name")
					if not name then return end
					local nameformat = string.gsub(string.gsub(name, "#%x%x%x%x%x%x", ""),"_", " ")
					local text = nameformat.." #f2921e[NPC]"
					local colorAlpha = 255
					if getElementHealth(v) == 0 then
						colorAlpha = 80
					end
					if sx and sy and name and clear then
						dxDrawText(string.gsub(text, "#%x%x%x%x%x%x", ""), sx+1, sy+1, sx, sy, tocolor(0,0,0,255), scale, settings.font, "center", "top", false, false, false, true)
						dxDrawText(text, sx, sy, sx, sy, tocolor(255,255,255,colorAlpha), scale, settings.font, "center", "top", false, false, false, true)
					end
					

					
					
				end
			end
		end
	end
end
, false)



local voz = "#00ff00Normal"
	setElementData(localPlayer, "ModoVoz", voz)
	setElementData(localPlayer, "maxDist",20)
bindKey("O", "down",
    function(key, state)
	if state == "down" then
	if not getElementData(localPlayer, "loggedin") then return end
	if isTimer(tempo) then return end
	if voz == "#00ff00Normal" then
	voz = "#00FBFFSussurro"
	setElementData(localPlayer, "ModoVoz", voz)
	triggerEvent("bgo>info", localPlayer,"MODO DE VOZ", "Você ativou o modo Sussurro, para voltar ao normal pressione O ", "info")
	
	tempo = setTimer(function() end,2000,1)
	setElementData(localPlayer, "maxDist",3)
	elseif voz == "#00FBFFSussurro" then
	voz = "#00ff00Normal"
	triggerEvent("bgo>info", localPlayer,"MODO DE VOZ", "Você ativou o modo Normal, para voltar ao Sussurro pressione O ", "info")
	setElementData(localPlayer, "ModoVoz", voz)
	setElementData(localPlayer, "maxDist",20)
	tempo = setTimer(function() end,2000,1)	
	end
    end
end
)



addEventHandler("onClientPreRender", root, function()
	if not getElementData(localPlayer, "loggedin") then return end
		modo = tocolor(255, 254, 254, 255)
		if getElementData(localPlayer, "VoiceCor") == true then
		local xx, yy = x2*1200, y2*28
		local teste = math.abs(math.sin(getTickCount() / 200))*6
		local teste2 = math.abs(math.sin(getTickCount() / 200))*15
		local teste3 = math.abs(math.sin(getTickCount() / 200))*20
		dxDrawImage(xx-teste-0.1, yy-teste, x2*35+teste3, y2*35+teste3, "mic.png", 0, 0, 0, tocolor(0, 0, 0, 255), false)
		dxDrawImage(xx-teste, yy-teste, x2*35+teste2-1, y2*35+teste2, "mic.png", 0, 0, 0, modo, false)
		end

		if getElementHealth ( localPlayer ) <= 50 then
		local teste = 0
		local teste2 = 0
		dxDrawImage(x2*0-teste-120, y2*0-teste-200, x2*1500+teste2, y2*1100+teste2, "files/sangue.png", 0, 0, 0, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 200))*200), false)
		end
end
)



function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end





addEvent("SomRadinho", true)
addEventHandler("SomRadinho", root,
	function(ativo , x2, y2, z2)
		if ativo then
				if song2 then
		stopSound(song2)
		end
		local song2 = playSound3D("radinho.ogg", x2, y2, z2)
		setSoundVolume(song2, 0.02)
		else
		
		local song = playSound("radinho.ogg", false) 
		setSoundVolume(song, 0.05)
		end
		
	end
	)
	
	
	
addEvent("SomRadinhoInicio", true)
addEventHandler("SomRadinhoInicio", root,
	function(ativo , x2, y2, z2)
		if ativo then
		if song2 then
		stopSound(song2)
		end
		local song2 = playSound3D("rinicio.ogg", x2, y2, z2)
		setSoundVolume(song2, 0.02)
		else
		local song = playSound("rinicio.ogg", false) --playSound3D("rinicio.ogg", xp, yp, zp)
		setSoundVolume(song, 0.05)
		end
	end)
	
	
	
local blockedTasks =
{
	"TASK_SIMPLE_IN_AIR", -- We're falling or in a jump.
	"TASK_SIMPLE_JUMP", -- We're beginning a jump
	"TASK_SIMPLE_LAND", -- We're landing from a jump
	"TASK_SIMPLE_GO_TO_POINT", -- In MTA, this is the player probably walking to a car to enter it
	"TASK_SIMPLE_NAMED_ANIM", -- We're performing a setPedAnimation
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE", -- Opening a car door
	"TASK_SIMPLE_CAR_GET_IN", -- Entering a car
	"TASK_SIMPLE_CLIMB", -- We're climbing or holding on to something
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD", -- When we try to jump but something hits us on the head
	"TASK_SIMPLE_FALL", -- We fell
	"TASK_SIMPLE_GET_UP" -- We're getting up from a fall
}

bindKey("Z", "both",
	function(key, state)
		if state == "down" then
			local theVehicle = getPedOccupiedVehicle ( localPlayer )
			if theVehicle then return end

	if getElementData(localPlayer, "inCall") == false then return end
	if getElementData(localPlayer, "inCallPolicia") == false then return end
	if getElementData(localPlayer, "VoiceCorCall") == false then
	setElementData(localPlayer, "VoiceCorCall", true)
	--triggerServerEvent ( "onClientAnimCall", resourceRoot, localPlayer )
	end

	else
		if getElementData(localPlayer, "inCall") == false then return end
		if getElementData(localPlayer, "inCallPolicia") == false then return end
	--if not getElementData(localPlayer, "inCall") then return end
	if getElementData(localPlayer, "VoiceCorCall") == true then
	setElementData(localPlayer, "VoiceCorCall", false)
	end
	--triggerServerEvent ( "onClientSyncVOZparar", resourceRoot, localPlayer )
	end
end
)

--[[
addEventHandler("onClientElementDataChange", root, function(dataName)
	if source and getElementType(source) == 'player' then 
		if tostring(dataName) == 'VoiceCorCall' then 
			if getElementData(source, dataName) then 
			setPedAnimation(source, "GANGS", "smkcig_prtl", 0, true, false, false)
			setTimer ( setPedAnimationSpeed, 100, 1, source, "smkcig_prtl", 0)
			setTimer ( setPedAnimationProgress, 100, 1, source, "smkcig_prtl", 1.36)
			elseif not getElementData(source, dataName) then 
			setElementData(source, "handsup", false)
			setTimer ( setPedAnimation, 100, 1, source,  "GHANDS", "gsign2", 5000, false, false, false)
			setTimer ( setPedAnimation, 250, 1, source)
			end
		end	
	end
end
)
]]--


addEventHandler("onClientPlayerVoiceStart",root,function()
    if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then 	
		--if not getElementData(source, "VoiceCor") then
		setElementData(source, "VoiceCor", true)
		--outputConsole("Voice On", source)
		--end
	end
end)


addEventHandler("onClientPlayerVoiceStop",root,function()
	if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then 		
		--if getElementData(source, "VoiceCor") then
		setElementData(source, "VoiceCor", false)
		
		--outputConsole("Voice Off", source)
		--end
	end
end)





--[[
if isVoiceEnabled() then

addEventHandler("onClientPlayerVoiceStart",root,function()
    if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then 
		if not getElementData(source, "VoiceCor") then
		setElementData(source, "VoiceCor", true)
		--outputConsole(getPlayerName(source).." has start talking.")
		end
	end
end)


addEventHandler("onClientPlayerVoiceStop",root,function()
	if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then 		
		--if getElementData(source, "VoiceCor") then
		--removeElementData(source, "VoiceCor")
		setElementData(source, "VoiceCor", false)
		--outputConsole(getPlayerName(source).." has stop talking.")
		--end
	end
end)

end]]--




addCommandHandler("nomes",
function()
if getElementData(localPlayer, "char:dutyfaction") == 4 or getElementData(localPlayer, "char:id") == 1 then
if getElementData(localPlayer, "char:admincabecaRES") == 1 then
setElementData(localPlayer, "char:admincabecaRES", 0)
else
setElementData(localPlayer, "char:admincabecaRES", 1)	
end
end
end
)

addCommandHandler("adm",
function()
if tonumber(getElementData(localPlayer, "acc:admin") or 0) >= 2 then

if getElementData(localPlayer, "char:admincabeca") == 1 then
setElementData(localPlayer, "char:admincabeca", 0)
else
setElementData(localPlayer, "char:admincabeca", 1)	
end

end
end
)


function apontarmao ()
		if not getElementData(localPlayer, "loggedin") then return end
		if getKeyState("mouse2") then
		if  getElementData(localPlayer, "veh_fueling") then 
		triggerServerEvent ( "removerarma", resourceRoot, localPlayer )
		setElementData(localPlayer, "apontararma", false)
		setPedControlState ("fire", false)
		setPedWeaponSlot (localPlayer,  0 )
		setPlayerHudComponentVisible ("crosshair", true)
		toggleControl ( "fire", false ) 
		setPedControlState ("fire", false)
		return 
		end
		local pedSlot = getPedWeaponSlot ( localPlayer )
		if (pedSlot == 0) then
		if getElementData(localPlayer, "apontararma") == false then			
		setElementData(localPlayer, "apontararma", true)
		triggerServerEvent ( "dararma", resourceRoot, localPlayer )
		setPlayerHudComponentVisible ("crosshair", false)
		setPedControlState ("fire", false)
		toggleControl ( "fire", false ) 
		end
		end
		
		else
		if getElementData(localPlayer, "apontararma") == true then
		triggerServerEvent ( "removerarma", resourceRoot, localPlayer )
		setElementData(localPlayer, "apontararma", false)
		setPedControlState ("fire", false)
		toggleControl ( "fire", true ) 
		setPedWeaponSlot (localPlayer,  0 )
		setPlayerHudComponentVisible ("crosshair", true)
		end 
	end
end
setTimer ( apontarmao, 100, 0 )




function levantarmao ()
		if not getElementData(localPlayer, "loggedin") then return end
		if getKeyState("x") then
		if not getElementData(localPlayer, "loggedin") then return end
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		if theVehicle then return end
		if getElementData(localPlayer, "apontar") == false then
		local task = getPedSimplestTask (localPlayer)
		for idx, badTask in ipairs(blockedTasks) do
		if (task == badTask) then
		return
		end
		end
		setElementData(localPlayer, "apontar", true)
		end
		else
		if getElementData(localPlayer, "apontar") then
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		if theVehicle then return end
		local task = getPedSimplestTask (localPlayer)
		for idx, badTask in ipairs(blockedTasks) do
		if (task == badTask) then
		return
		end
		end
		setElementData(localPlayer, "apontar", false)
		end
	end
end
setTimer ( levantarmao, 100, 0 )


bindKey("lalt", "both",
    function(key, state)
	if state == "down" then
	if not getElementData(localPlayer, "loggedin") then return end
	local theVehicle = getPedOccupiedVehicle ( localPlayer )
	if theVehicle then return end
	if getElementData(localPlayer, "Desmaiar") == false then
	local task = getPedSimplestTask (localPlayer)
	for idx, badTask in ipairs(blockedTasks) do
	if (task == badTask) then
	return
	end
	end
	setElementData(localPlayer, "Desmaiar", true)
	triggerServerEvent ( "onClientDesmaiarON", resourceRoot, localPlayer )
	end
	else
	local theVehicle = getPedOccupiedVehicle ( localPlayer )
	if theVehicle then return end
	setElementData(localPlayer, "Desmaiar", false)
	triggerServerEvent ( "onClientSyncVOZparar", resourceRoot, localPlayer )
    end
end
)

--addEvent("syncSongassobiar", true)
--addEventHandler("syncSongassobiar", root,function(player, xp, yp, zp, int, dim)
		--local song = playSound3D("assobiar.mp3", xp, yp, zp)
		--setSoundVolume(song, 0.9)
		--setElementInterior(song, int)
		--setElementDimension(song, dim)
		--setSoundMaxDistance(song, 60)
		--attachElements(song, player, 0,0,2)
--	end
--)


--bindKey("n", "down",function(key, state)
--if not getElementData(localPlayer, "loggedin") then return end
	--local theVehicle = getPedOccupiedVehicle ( localPlayer )
	--if theVehicle then return end
	--if getElementData(localPlayer, "assobiar") == false then
	--local task = getPedSimplestTask (localPlayer)
	--for idx, badTask in ipairs(blockedTasks) do
	--if (task == badTask) then
	--return
	--end
	--end
	--if assoviei then assoviei = false return end
	--assoviei = true
	--setElementData(localPlayer, "assobiar", true)
	--setTimer ( setElementData, 10000, 1, localPlayer, "assobiar", false)

  --  end
--end
--)



bindKey("j", "down",function(key, state)
if not getElementData(localPlayer, "loggedin") then return end
	local theVehicle = getPedOccupiedVehicle ( localPlayer )
	if theVehicle then return end
	if getElementData(localPlayer, "Pesada") == false then
	local task = getPedSimplestTask (localPlayer)
	for idx, badTask in ipairs(blockedTasks) do
	if (task == badTask) then
	return
	end
	end
	setElementData(localPlayer, "Pesada", true)
	setTimer ( setElementData, 3000, 1, localPlayer, "Pesada", false)
	triggerServerEvent ( "onClientPesadaON", resourceRoot, localPlayer )
    end
end
)




function setSellerLookAt(player)
	if(isElement(player)) then
	setPedLookAt(player, 0.0, 0.0, 0.0, 3000, localPlayer)
	end
end

--[[

addEventHandler("onClientRender", root, function()
	if not getElementData(localPlayer, "loggedin") then return end

	if(getTickCount() - (lastLocalHeadUpdate or 0) > 100) then
	local task = getElementData(localPlayer,"TASK")
	if(not task or task == "") then
	local x, y, z, lx, ly, lz = getCameraMatrix()
	local px, py, pz = getPedBonePosition(localPlayer, 4)
	local lookAtX = px - (x-lx) * 20.0
	local lookAtY = py - (y-ly) * 20.0
	local lookAtZ = pz - (z-lz) * 20.0
	setPedLookAt(localPlayer, lookAtX, lookAtY, lookAtZ, 3000)
	lastLocalHeadUpdate = getTickCount()
	end
	end


	if(getTickCount() - (lastRemoteHeadUpdate or 0) > 100) then	
	local x2,y2,z2 = getElementPosition(localPlayer)
	local tabela = getElementsWithinRange( x2,y2,z2, 20, "player" )
	local v = nil
	for i = 1, #tabela do
	v = tabela[i] 
	
	local x, y, z, lx, ly, lz = getCameraMatrix()
	local lookAtOffsetX = math.ceil((x-lx)*20.0)
	local lookAtOffsetY = math.ceil((y-ly)*20.0)
	local lookAtOffsetZ = math.ceil((z-lz)*20.0)	
	setElementData(localPlayer, "lookAtOffsetX", lookAtOffsetX)
	setElementData(localPlayer, "lookAtOffsetY", lookAtOffsetY)
	setElementData(localPlayer, "lookAtOffsetZ", lookAtOffsetZ)
	
	if isElement(v) and v ~= getLocalPlayer() then			
	local px, py, pz = getPedBonePosition(v, 4)
	local lookAtX = px - (getElementData(v, "lookAtOffsetX") or 0)
	local lookAtY = py - (getElementData(v, "lookAtOffsetY") or 0)
	local lookAtZ = pz - (getElementData(v, "lookAtOffsetZ") or 0)
	setPedAimTarget(v, lookAtX, lookAtY, lookAtZ)
	setPedLookAt(v, lookAtX, lookAtY, lookAtZ, 2000)
	end
	end
	lastRemoteHeadUpdate = getTickCount()
	--end
	end
end
)

]]--


contPlayersInArena = function() 
	local playerCount = nil 
	for _,player in ipairs (getElementsByType("player")) do 
	local posX1, posY1, posZ1 = getElementPosition(localPlayer)
	local posX2, posY2, posZ2 = getElementPosition(player)
	local distance = getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2)
	if distance <= 5 then
	playerCount = getElementData(player,"char:id") --playerCount+1  
	end
	end 
	return playerCount 
end 





--[[
addCommandHandler("shown", function()
	if getElementData(localPlayer, "acc:admin") > 0 or getElementData(localPlayer, "acc:guard") > 0 then
		settings.anames = not settings.anames
		if settings.anames then
			outputChatBox("#7cc576[BTCMTA - Nomes]: #ffffffVocê ativou com sucesso #ffffffos nomes.", 255, 255, 255, true)
			settings.maxdis = 200
		else
			outputChatBox("#7cc576[BTCMTA - Nomes]: #ffffffVocê desativou com sucesso #ffffffos nomes.", 255, 255, 255, true)
			settings.maxdis = 20
		end
	end
end)]]--

--[[
local lastClick = getTickCount()
addEventHandler ("onClientRender",getRootElement(),
	function ()
		local cTick = getTickCount ()
		if cTick-lastClick >= 300000 then
			if getElementData(getLocalPlayer(),"afk") == false then
				local hp = getElementHealth (getLocalPlayer())
				if hp > 0 then
					setElementData (getLocalPlayer(),"afk",true)
					if isTimer (StartTimer) then 
						killTimer(StartTimer)
					end

					SimaTimer = setTimer(function ()
						StartTimer = setTimer(Timer,1000,0)
						if isTimer (SimaTimer) then 
							killTimer(SimaTimer)
						end
					end, 10*1000, 1 )
				end
			end
		end
	end
)
addEventHandler( "onClientRestore", getLocalPlayer(),
	function ()
		lastClick = getTickCount ()
		setElementData (getLocalPlayer(),"afk",false)
		sec = 0
		sech = setElementData(getLocalPlayer(),"Timer", 0)
		if isTimer (StartTimer) then 
			killTimer(StartTimer)
		end
	end
)
addEventHandler( "onClientMinimize", getRootElement(),
	function ()
		setElementData (getLocalPlayer(),"afk",true)
		sech = setElementData(getLocalPlayer(),"Timer", 0)
		sec = 0
		if isTimer (StartTimer) then 
			killTimer(StartTimer)
		end
		SimaTimer = setTimer(function ()
		end, 10*1000, 1 )
	end
)
addEventHandler( "onClientCursorMove", getRootElement( ),
    function ( x, y )
		lastClick = getTickCount ()
		if getElementData(getLocalPlayer(),"afk") == true then
			setElementData (getLocalPlayer(),"afk",false)
			sech = setElementData(getLocalPlayer(),"Timer", 0)
			if isTimer (StartTimer) then 
				killTimer(StartTimer)
			end
		end
    end
)
addEventHandler("onClientKey", getRootElement(), 
	function ()
		
		lastClick = getTickCount ()
		if getElementData(getLocalPlayer(),"afk") == true then

			setElementData (getLocalPlayer(),"afk",false)
			sech = setElementData(getLocalPlayer(),"Timer", 0)
			sec = 0
			if isTimer (StartTimer) then 
				killTimer(StartTimer)
			end
		end
	end
)
]]--
function checkForConsole()
	if isConsoleActive() then
		setElementData(getLocalPlayer(), "consoleTyping", true)	
	elseif not isConsoleActive() then
		setElementData(getLocalPlayer(), "consoleTyping", false)
	end
end
--setTimer ( checkForConsole, 100, 0 )
function checkForChat()
	if isChatBoxInputActive() then
		setElementData(getLocalPlayer(), "pmTyping", true)	
	elseif not isChatBoxInputActive() then
		setElementData(getLocalPlayer(), "pmTyping", false)
	end
end
--setTimer ( checkForChat, 100, 0 )
function loc(x, y, z)
	local hx,hy,hz = getElementPosition(localPlayer)
	exports.bgo_radar:utvonalTervezes(hx,hy,hz, x , y , z)
end
addEvent("localizar", true)
addEventHandler("localizar", root, loc)




addEventHandler("onClientResourceStart", resourceRoot, 
function (res) 
		--setPedsLODDistance ( 500 )
		--setVehiclesLODDistance ( 500, 500 )
		setElementData(localPlayer, "inCall", false)
end)


addEventHandler("onClientResourceStop", resourceRoot, 
function (res) 
		resetPedsLODDistance()
		resetVehiclesLODDistance()
end)


addEventHandler ("onClientKey", root, function (button)
	if button == "y" then
		--if getElementData (localPlayer, "loginPanel") then
			cancelEvent()
		--end
	end
end)




addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
    setElementData(localPlayer, "status:RadioAtivo", false )
	setElementData(localPlayer, "status:Radio", false )
    end
);



local ativou = false
bindKey("z", "both",function(key, state)
	if not getElementData(localPlayer, "loggedin") then return end
	

	--if exports.bgo_admin:isPlayerDuty(localPlayer) or getElementData(localPlayer, "acc:admin") >= 1 then
	local theTeam = getPlayerTeam(localPlayer)
	if ( theTeam ) then
	if (state == "down") then 
	
	if getElementData(localPlayer, "status:Radio") == true then
	outputChatBox ( "#F4A460[Frequência]#F08080Você está com a Frequência do Radinho Mutada!  Digite /radiom para desmutar", 255, 255, 255, true ) 
	return
	end
	

	if getKeyState( "capslock" ) == true then
	setTimer(function()
	if getElementData(localPlayer, "status:RadioAtivo") == true then
	outputChatBox ( "#F4A460[Frequência]#F08080Aguarde o atual companheiro falar!", 255, 255, 255, true ) 
	exports.bgo_infobox:addNotification("[Frequência] Aguarde o atual companheiro falar!","error")
	return
	end	
	
	setElementData(localPlayer, "VoiceCorCall", true)
	triggerServerEvent ( "copomativo", localPlayer, localPlayer )
	ativou = true
	end,100,1)
	end
	else
	if ativou == true then
	triggerServerEvent ( "copomoff", localPlayer, localPlayer )
	setElementData(localPlayer, "VoiceCorCall", false)
	ativou = false
    end

	end
	end

end
)

