
local sx,sy = guiGetScreenSize ()
local learningState = false
local learningTick = 0
local learningClickTick = 0
local learningInProgress = false
local learningQuizState = false
local learningQuizData = {}

function showLearningQuiz(state)
	level = 9
	if state ~= learningQuizState then
		if state == true then
			local keys = {"arrow_l","arrow_u","arrow_d","arrow_r"}
			local times = level*4
			learningQuizData.level = level
			learningQuizData.startTick = getTickCount ()
			learningQuizData.duration = 500*times -level*12*times
			learningQuizData.times = times
			learningQuizData.keys = {}
				
			for k=1,times do
				learningQuizData.keys[k] = {}
				local empty = math.random (1,3)
				if empty ~= 1 or k == 1 or k == times then 
					local key = keys[math.random(1,#keys)]
					if key then
						learningQuizData.keys[k]["key"] = key
						learningQuizData.keys[k]["passed"] = 0 
					end
				else
					learningQuizData.keys[k]["key"] = ""
				end
			end
				
			addEventHandler ("onClientKey",getRootElement(),onQuizArrowClick)
			learningQuizState = true
			setLearningMode(true)
			
		elseif state == false then
			learningQuizData = {}
			removeEventHandler ("onClientKey",getRootElement(),onQuizArrowClick)
			learningQuizState = false
		end
	end
end

function endLearningQuiz ()
	if learningQuizState then
		local level = learningQuizData.level
		local total = 0
		local passed = 0
		for k,v in ipairs(learningQuizData.keys) do
			if v["key"] ~= "" then
				total = total+1
				if v["passed"] == 2 then
					passed = passed+1
				end
			end
		end
		if passed/total >= 0.85 then
			--outputChatBox("#edc937Sensei: #FFFFFFVocê passou no teste!.", 255, 255, 255, true)
			--outputChatBox("#edc937Sensei: #FFFFFFNa segunda fase, testaremos seu senso de equilíbrio, pois é importante que você fique em pé com seus próprios pés.", 255, 255, 255, true)
			--setTimer(
				--function ()
				finishLearningProcess(true)
					--secondLearningStage()
				--end,
			--8000, 1)
			setLearningMode (false)
			
		else	
			outputChatBox("#edc937Sensei: #FFFFFFVocê falhou no teste. Quando estiver pronto, comece tudo de novo.", 255, 255, 255, true)
			setLearningMode (false)
		end
	end
end

function onQuizArrowClick (key,state)
	if state then
		local right = false
		local keys = {"arrow_l","arrow_u","arrow_d","arrow_r"}
		for k,v in ipairs(keys) do
			if key == v then
				right = true
				break
			end
		end
		if right then
			local iconSize = 128
			local insideIconSize = 128
			local arrowSize = 64
			
			local cTick = getTickCount ()
			local delay = cTick - learningQuizData.startTick
			local progress = delay/learningQuizData.duration
			
			local totalWidth = learningQuizData.times*insideIconSize*0.8
			local iy = sy-100
			
			local total = 0
			local passed = 0
			
			for k,v in ipairs(learningQuizData.keys) do
				if v["key"] ~= "" then
					--if v["passed"] == 0 then
						local offset = interpolateBetween (
							0,0,0,
							totalWidth,0,0,
							(k-1)/learningQuizData.times,"Linear"
						)
						--dxDrawText ("off " .. k .. " " .. offset,50,500+k*25)
						local cx = sx + insideIconSize/2 + offset - totalWidth*progress
						if cx >= -insideIconSize/2 and cx <= sx/2+iconSize*2 then
							local cx = sx + insideIconSize/2 + offset - totalWidth*progress
							if cx >= sx/2-iconSize/4 and cx <= sx/2+iconSize/4 then
								if v["passed"] == 0 then
									if v["key"] == key then
										learningQuizData.keys[k]["passed"] = 2
									else
										learningQuizData.keys[k]["passed"] = 1
									end
								end
								break
							else
								if v["passed"] == 0 then
									learningQuizData.keys[k]["passed"] = 1
									break
								end
							end
						end
						--break
					--end
				end
			end
			--[[for k,v in ipairs(learningQuizData.keys) do
				if v["key"] ~= "" then
					total = total+1
					if v["passed"] ~= 0 then
						passed = passed+1
					else
						return
					end
				end
			end
			if passed == total then
				endLearningQuiz ()
			end]]
		end
	end
end

function setLearningMode (state)
	if state ~= learningState then
		if state == true then
					
			showCursor (true)
			learningTick = getTickCount ()
			--triggerServerEvent("toggleLearning", getLocalPlayer(), true)
			addEventHandler ("onClientRender",getRootElement(),renderLearningArea)
			learningState = true
			learningInProgress = false
			bwState = false
		elseif state == false then
			showLearningQuiz (false)
			
			--removeEventHandler ("onClientClick",getRootElement(),onWaterClick)
			--triggerServerEvent("toggleLearning", getLocalPlayer(), false)
			removeEventHandler ("onClientRender",getRootElement(),renderLearningArea)
			learningState = false
			showCursor (false)
			bwState = false
		end
	end
end

function renderLearningArea ()
	local tick = getTickCount ()
	local progress = (tick-learningTick)/2000
	
	if learningQuizState then
		local y = sy/3.2 
		
		local iconSize = 128
		local insideIconSize = 128
		local arrowSize = 64
		
		local cTick = getTickCount ()
		local delay = cTick - learningQuizData.startTick
		local progress = delay/learningQuizData.duration
		
		local totalWidth = learningQuizData.times*insideIconSize*0.8
		local iy = sy-100
		
		
		for k,v in ipairs(learningQuizData.keys) do
			local last = false
			if k >= learningQuizData.times then
				last = true
			end
			if v["key"] ~= "" then
				local offset = interpolateBetween (
					0,0,0,
					totalWidth,0,0,
					(k-1)/learningQuizData.times,"Linear"
				)
				--dxDrawText ("off " .. k .. " " .. offset,50,500+k*25)
				local cx = sx + insideIconSize/2 + offset - totalWidth*progress
				if cx >= -insideIconSize/2 and cx <= sx+insideIconSize/2 then
					local col = tocolor(255,255,255,255)
					if v["passed"] == 0 then
						if cx < sx/2-iconSize/4 then
							learningQuizData.keys[k]["passed"] = 1
							col = tocolor(203,19,19,255)
						end
					elseif v["passed"] == 1 then 
						col = tocolor(203,19,19,255)
					elseif v["passed"] == 2 then
						col = tocolor(133,250,0,255)
					end
					dxDrawImage (cx-insideIconSize/2,iy-insideIconSize/2,insideIconSize,insideIconSize,"files/circle.png",0,0,0,col,true)
					dxDrawImage (cx-arrowSize/2,iy-arrowSize/2,arrowSize,arrowSize,"files/" .. v["key"] .. ".png",0,0,0,tocolor(255,255,255,255),true)
				end
				if last then
					if cx <= -insideIconSize/2 then
						endLearningQuiz ()
					end
				end
			end
		end
		
		dxDrawImage (sx/2-iconSize/2,iy-iconSize/2,iconSize,iconSize,"files/mainCircle.png",0,0,0,tocolor(255,255,255,255),true)
	end
end