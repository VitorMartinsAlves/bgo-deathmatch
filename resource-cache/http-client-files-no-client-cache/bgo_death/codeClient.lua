local monitorSize= {guiGetScreenSize()}
local fadeTimer = false
local fadTimer = false
local hitTime = 30*60 -- 15 perc
-- local hitTime = 10 -- 15 perc,
local deadPed = false
local spawnTimer = false
local startTimer = false
local stopTimer = false
local ripPed = {}
local sound = false
local ripPedPos = {
	{68, 812.9013671875, -1098.236328125, 25.786804199219, 90}, -- PAP
	{221,811.0986328125, -1097.205078125, 25.784603118896, 180},
	{190,811.1962890625, -1099.33984375, 25.784721374512, 0},
}



local scene = 1
fadeCamera(true, 1) 
-- setCameraTarget(localPlayer)
toggleAllControls(true)

local sounds = {
	"798983896"
	--"789613636"
--[[
	"509760969",
	"488286273",
	"503202672",
	"449874870"]]--
} 



local blurStrength = 5
local myScreenSource = dxCreateScreenSource(monitorSize[1], monitorSize[2])
local font = dxCreateFont('files/Calibri.ttf', 20)

addEventHandler('onClientResourceStart', resourceRoot, function()
	--if (getElementHealth(localPlayer)) > 0 and  (getElementHealth(localPlayer)) <= 20 then 
		--loadHit()
	if (getElementHealth(localPlayer)) == 0 then
		if not isTimer(stopTimer2) then
		triggerServerEvent('bgoMTA->#createPedToPlayer', localPlayer, localPlayer)
		end
		
		stopTimer2 = setTimer(function() end, 5000, 1)
		
		
		
		blurShader, blurTec = dxCreateShader("files/BlurShader.fx")
		setElementData(localPlayer,"screen",true)
		fadeCamera(false, 0.3) 
		scene = 2
		setGameSpeed(0.5) -- normal Game Speed == 1
		startDeadFunction()
		destroyHitFunc()
		if isElement(sound) then 
			stopSound(sound)
		end
		showChat(false)
		--sound = playSound('files/song.mp3', true)
		sound = playSound("http://api.soundcloud.com/tracks/"..sounds[math.random(1, #sounds)].."/stream?client_id=N2eHz8D7GtXSl6fTtcGHdSJiS74xqOUI", true)
		setSoundVolume(sound, 0.3)	
				
		toggleAllControls( false)
	end
end)

addEventHandler('onClientPlayerWasted', localPlayer, function ()
	blurShader, blurTec = dxCreateShader("files/BlurShader.fx")
	setElementData(localPlayer,"screen",true)
	--fadeCamera(false, 0.3) 
	scene = 2
	setGameSpeed(0.5) -- normal Game Speed == 1
	startDeadFunction()
	destroyHitFunc()
	if isElement(sound) then 
		stopSound(sound)
	end
	showChat(false)

	--sound = playSound('files/song.mp3', true)
	
	sound = playSound("http://api.soundcloud.com/tracks/"..sounds[math.random(1, #sounds)].."/stream?client_id=N2eHz8D7GtXSl6fTtcGHdSJiS74xqOUI", true)
	setSoundVolume(sound, 0.3)		
	--toggleAllControls( false)
	--if not isPedInVehicle(localPlayer) then
	
		if not isTimer(stopTimer) then
		--triggerServerEvent('bgoMTA->#createPedToPlayer', localPlayer, localPlayer)
		triggerServerEvent('bgoMTA->#removePlayerToVehicle', localPlayer, localPlayer)
		end
		
		stopTimer = setTimer(function() end, 5000, 1)
		
		
	--else
	--	triggerServerEvent('bgoMTA->#removePlayerToVehicle', localPlayer, localPlayer)
	--end

end)


function tempomorte(stats, parceiro, vip)
hitTime =  stats*60  
if parceiro then
parceirostreamer =  parceiro  
else
parceirostreamer =  false  
end
if vip then
jogadorvip =  vip  
else
jogadorvip =  false  
end
end
addEvent('bgoMTA->#tempomorte', true)
addEventHandler('bgoMTA->#tempomorte', root, tempomorte)


function startDeadFunction()
	--[[if scene == 1 then
		stopTimer = setTimer(function()
			fadeCamera(false, 1) 
			scene = 2
			startDeadFunction()
		end, 1000*20, 1)
		deadPed = createPed(getElementModel(localPlayer), 811.2, -1098.103515625, 25.90625, 187)
		for i=1,#ripPedPos do 
			ripPed[i] = createPed(ripPedPos[i][1], ripPedPos[i][2], ripPedPos[i][3], ripPedPos[i][4], ripPedPos[i][5])
			setPedAnimation(ripPed[i], "GRAVEYARD", "mrnM_loop", -1, true, false, false)
		end
		setPedAnimation(deadPed, "CRACK", "crckidle2", -1, true, false, false)
		setCameraMatrix(812.10998535156, -1098.2802734375, 29.334800720215, 812.02282714844, -1098.2797851563, 28.338605880737)
		fadeCamera(true, 1) ]]--

	if scene == 2 then	
		startTimer = setTimer(function ()
			--setCameraMatrix(899.05480957031, -1075.5179443359, 25.173099517822, 899.02416992188, -1074.5208740234, 25.102909088135)

			local x, y, z = getElementPosition(localPlayer)
			setCameraMatrix(x, y, z+5, x, y, z)
			--fadeCamera(true, 1)
			setTimer(function ()
			
			fadeCamera (false, 2, 0, 0, 0 )
			--	removeEventHandler('onClientRender', root, blurCreate)
			--	addEventHandler('onClientRender', root, blurCreate)
				
				if isTimer(hitTimer) then 
					killTimer(hitTimer)
				end
				
				
				removeEventHandler('onClientRender', root, hitRender)
				addEventHandler('onClientRender', root, hitRender)
				hitTimer = setTimer(hitTimerFunc, 1000, 0)
				
			end, 1005, 1)
			
		end, 3000, 1)
		if isElement(deadPed) then 
			destroyElement(deadPed)
		end		
		--[[
		for i=1,#ripPedPos do 
			if isElement(ripPed[i]) then 
				destroyElement(ripPed[i])
			end
		end]]--
	end
end

--[[
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), function(_, _, _, damage)
	if (getElementHealth(localPlayer)-damage) > 0 and  (getElementHealth(localPlayer)-damage) <= 20 then 
		loadHit()
	end
end)]]--

addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), function ()
	setTimer(function ()
		--if (getElementHealth(localPlayer)) > 0 and  (getElementHealth(localPlayer)) <= 29 then 
			--loadHit()
		if (getElementHealth(localPlayer)) > 1 then
			setElementData(localPlayer,"ammoInBody",{})
			setElementData(localPlayer, 'char->stuck', false)
			fadeCamera(true, 1)
			toggleControl("enter_exit", true)		
			setCameraTarget(localPlayer)
			destroyHitFunc()
			setElementData(localPlayer,"screen", false)
			setElementData(localPlayer, 'player->dead', false)
			showChat(true)
			toggleAllControls(true)
			fadeCamera (true, 2, 0, 0, 0 )
			--removeEventHandler('onClientRender', root, blurCreate)
			if isElement(sound) then 
				stopSound(sound)
			end
			scene = 1 
			if isTimer(hitTimer) then 
				killTimer(hitTimer)
			end	
			
			if isTimer(startTimer) then 
				killTimer(startTimer)
			end	
			
			if isTimer(stopTimer) then 
				killTimer(stopTimer)
			end
			
			if isElement(deadPed) then 
				destroyElement(deadPed)
			end	
--[[			
			for i=1,#ripPedPos do 
				if isElement(ripPed[i]) then 
					destroyElement(ripPed[i])
				end
			end
			]]--
			destroyHitFunc()
		end
	end, 500, 1)
end)

-- addEvent('bgoMTA->#destroyFunction', true)
-- addEventHandler('bgoMTA->#destroyFunction', root, destroyFunction)

function loadHit(player)
	if not player then player = localPlayer end
	if not fadTimer then 
		setElementData(player, "screen", false)
		hitTimer = setTimer(hitTimerFunc, 1000, 0)
		if not isPedInVehicle(player) then 
			triggerServerEvent('bgoMTA->#setPlayerAnimation', player, player, "BEACH", "ParkSit_M_loop", 1, true)
		end
		removeEventHandler('onClientRender', root, hitRender)
		addEventHandler('onClientRender', root, hitRender)
		fadeCameraFunction()
		toggleAllControls(false)
	end
end
addEvent('bgoMTA->#loadHit', true)
addEventHandler('bgoMTA->#loadHit', resourceRoot, loadHit)







function hitRender()
	if scene == 2 then 
		--dxDrawText("Descanse em paz:\n"..getPlayerName(localPlayer):gsub('_', ' '), monitorSize[1], monitorSize[2]-95, 0, 0, tocolor(0,0,0,255),1, font,"center","center",false,true,false)
		--dxDrawText("Descanse em paz:\n#D24D57"..getPlayerName(localPlayer):gsub('_', ' '), monitorSize[1]+1, monitorSize[2]-94, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)


		--dxDrawText("Você tem\n"..getPlayerName(localPlayer):gsub('_', ' '), monitorSize[1], monitorSize[2]-95, 0, 0, tocolor(0,0,0,255),1, font,"center","center",false,true,false)
		--dxDrawText("Aguardando o resgate chegar\n#D24D57"..getPlayerName(localPlayer):gsub('_', ' '), monitorSize[1]+1, monitorSize[2]-94, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)


	end
	
	--dxDrawText("Leia as regras", monitorSize[1], monitorSize[2]+100, 0, 0, tocolor(0,0,0,255),1, font,"center","center",false,true,false,true)
	--dxDrawText("#ffffffLeia as regras", monitorSize[1]+1, monitorSize[2]-200, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)
	
		dxDrawText([[
	"Leia as regras"
	
	Morto não fala!!,
	Após o renascimento, esquecer o que ocorreu anteriormente,
	Ao ser ajudado pelo resgate, não lembrar do ocorrido anterior,
	Se você morreu por algum bug ou erro no sistema, entre em nosso discord e informe o ocorrido.
	
	
	
	Tenha amor a vida!!!
	]], monitorSize[1]+1, monitorSize[2]-200, 0, 0, tocolor(0, 0, 0,255),1, font,"center","center",false,true,false,true)
		
		
	dxDrawText([[
	"Leia as regras"
	
	Morto não fala!!,
	Após o renascimento, esquecer o que ocorreu anteriormente,
	Ao ser ajudado pelo resgate, não lembrar do ocorrido anterior,
	Se você morreu por algum bug ou erro no sistema, entre em nosso discord e informe o ocorrido.
	
	
	
	Tenha amor a vida!!!
	]], monitorSize[1]+1, monitorSize[2]-199, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)
		
	
	if parceirostreamer then
	
		dxDrawText([[
	Agora os streamers da cidade tem tempo de morte reduzido de 30 min para 7 min,
	cuidado da proxima vez <3
	]], monitorSize[1]+1, monitorSize[2]+501, 0, 0, tocolor(0, 0, 0,255),1, font,"center","center",false,true,false,true)
		
		
		
	dxDrawText([[
	Agora os streamers da cidade tem tempo de morte reduzido de 30 min para 7 min,
	cuidado da proxima vez <3
	]], monitorSize[1]+1, monitorSize[2]+500, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)
		
	end
	
	if jogadorvip then
	
		dxDrawText([[
	Agora os VIPS da cidade tem tempo de morte reduzido de 30 min para 15 min,
	cuidado da proxima vez <3
	]], monitorSize[1]+1, monitorSize[2]+501, 0, 0, tocolor(0, 0, 0,255),1, font,"center","center",false,true,false,true)
		
		
		
	dxDrawText([[
	Agora os VIPS da cidade tem tempo de morte reduzido de 30 min para 15 min,
	cuidado da proxima vez <3
	]], monitorSize[1]+1, monitorSize[2]+500, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)
		
	end
	dxDrawText("Você tem "..secondsToTimeDesc(hitTime).." para nascer novamente!", monitorSize[1], monitorSize[2]+600, 0, 0, tocolor(0,0,0,255),1, font,"center","center",false,true,false,true)
	dxDrawText("#ffffffVocê tem #D24D57"..secondsToTimeDesc(hitTime).." #ffffffpara nascer novamente!", monitorSize[1]+1, monitorSize[2]+601, 0, 0, tocolor(255, 255, 255,255),1, font,"center","center",false,true,false,true)
	
end

function hitTimerFunc ()
	-- block, anim = getPedAnimation(localPlayer) 
	-- if block ~= "BEACH" and anim ~= "ParkSit_M_loop"then 
		-- triggerServerEvent('bgoMTA->#setPlayerAnimation', localPlayer, localPlayer, "BEACH", "ParkSit_M_loop", 1, true)
	-- end
	hitTime = hitTime - 1
	if hitTime <= 0 then 
		if scene == 2 then
			triggerServerEvent('bgoMTA->#spawnPed', localPlayer, localPlayer)
			fadeCamera(true, 1) 
			setCameraTarget(localPlayer)
			destroyHitFunc()
			setElementData(localPlayer,"screen",false)
			showChat(true)
			fadeCamera (true, 2, 0, 0, 0 )
			--removeEventHandler('onClientRender', root, blurCreate)
			if isElement(sound) then 
				stopSound(sound)
			end
			scene = 1 
		else
			triggerServerEvent('bgoMTA->#killPed', localPlayer, localPlayer)
		end
		
			
		if isTimer(hitTimer) then 
			killTimer(hitTimer)
		end
	end
end

function destroyHitFunc()
	if isTimer(fadTimer) then 
		killTimer(fadTimer)
	end	
	
	if isTimer(hitTimer) then 
		killTimer(hitTimer)
	end
	fadTimer = false
	hitTime =  30*60 --3*60 -- 15 perc
	removeEventHandler('onClientRender', root, hitRender)
	setGameSpeed(1)
end

function fadeCameraFunction()
	fadeTimer = not fadeTimer
	if isTimer(fadTimer) then 
		killTimer(fadTimer)
	end
	if fadeTimer then 
		fadeCamera(true, 0.5) -- false = true; true = false
		fadTimer = setTimer(fadeCameraFunction, 1000, 1)
	else
		fadeCamera(false, 1) -- false = true; true = false 
		fadTimer = setTimer(fadeCameraFunction, 2500, 1)
	end
end

function secondsToTimeDesc( seconds )
	if seconds then
		local results = {}
		local sec = ( seconds %60 )
		local min = math.floor ( ( seconds % 3600 ) /60 )
		local hou = math.floor ( ( seconds % 86400 ) /3600 )
		local day = math.floor ( seconds /86400 )

		
		-- if day > 0 and day < 10 then table.insert( results, day .. ( day == 1 and " day" or " days" ) ) 
		-- elseif day > 0  then table.insert( results, day .. ( day == 1 and "" or "" ) ) end
			
		-- if hou >= 0 and hou < 10 then table.insert( results, "0"..hou .. ( hou == 1 and "" or "" ) ) 
		-- elseif hou > 0  then table.insert( results, hou .. ( hou == 1 and "" or "" ) ) end
		
		if min >= 0 and min < 10 then table.insert( results, "0"..min .. ( min == 1 and "" or "" ) ) 
		elseif min > 0  then table.insert( results, min .. ( hou == 1 and "" or "" ) ) end
		
		if sec >= 0 and sec < 10 then table.insert( results, "0"..sec .. ( sec == 1 and "" or "" ) ) 
		elseif sec > 0  then table.insert( results, sec .. ( sec == 1 and "" or "" ) ) end
		
		return string.reverse ( table.concat ( results, " : " ):reverse():gsub(" : ", " : ", 1 ) )
	end
	return ""
end

--[[
function blurCreate()
    if (blurShader) then
		dxUpdateScreenSource(myScreenSource)	
		dxSetShaderValue(blurShader, "ScreenSource", myScreenSource);
		dxSetShaderValue(blurShader, "BlurStrength", blurStrength);
		dxSetShaderValue(blurShader, "UVSize", monitorSize[1], monitorSize[2]);

		dxDrawImage(0, 0, monitorSize[1], monitorSize[2], blurShader)
    end
end]]--

function showBlood(attacker, weapon, bodypart)
	local health = getElementHealth(source)
	if (health<=20) then
		local x, y, z = getElementPosition(source)
		fxAddBlood(x, y, z, 0, 0, 0, 1000, 1.0)
	end
	-- Realistic blood from bodypart
	if (attacker) and (weapon~=17) then
		if (bodypart==3) then -- torso
			local x, y, z = getPedBonePosition(source, 3)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		elseif (bodypart==4) then -- ass
			local x, y, z = getPedBonePosition(source, 1)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		elseif (bodypart==5) then -- left arm
			local x, y, z = getPedBonePosition(source, 32)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		elseif (bodypart==6) then -- right arm
			local x, y, z = getPedBonePosition(source, 22)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		elseif (bodypart==7) then -- left leg
			local x, y, z = getPedBonePosition(source, 42)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		elseif (bodypart==8) then -- right leg
			local x, y, z = getPedBonePosition(source, 52)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		elseif (bodypart==9) then -- head
			local x, y, z = getPedBonePosition(source, 6)
			fxAddBlood(x, y, z, 0, 0, 0, 500, 1.0)
		end
	end
end
addEventHandler("onClientPlayerDamage", getRootElement(), showBlood)