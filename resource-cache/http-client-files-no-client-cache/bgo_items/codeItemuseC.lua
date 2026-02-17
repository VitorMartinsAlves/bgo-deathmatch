local szinez = "#88D373"
local r,g,b = 136,211,115
local showedIndentyCard = false
local showedPassaporte = false


addEventHandler ("onClientResourceStart", resourceRoot,
function()
			triggerServerEvent('bgo:energeticoOFF', localPlayer, localPlayer)
			setElementData(localPlayer,"char:energetico",false)
			exports["bgo_death"]:disableLSD()
			exports.bgo_hud:drawStat("Item", "", "", 200, 0, 0)
			setElementData(localPlayer,"char >> isDrugged",false)
			
    setTimer(function()
				local value = getElementData(localPlayer,"char:adminduty")
                if isElementInWater( localPlayer ) and value == 0 then
				if hasItem(localPlayer, 16) then
				mensagem("Ops!", "Você perdeu o celular!", "warning")
					triggerServerEvent('btcMTA->#takePlayerItemToID', localPlayer, localPlayer, 16, false)
                 end
				 end
             end,
             700, 0 )
end
)


addEvent("setObjectUnbreakableMochila", true)
addEventHandler("setObjectUnbreakableMochila", resourceRoot, 
	function (object)
		setObjectBreakable(object, false)
		setElementCollisionsEnabled(object, false)
	end
)

addEvent("plantarBomba", true)
addEventHandler("plantarBomba", resourceRoot,
	function (ms, bomb, dim, int)
		local x, y, z = getElementPosition(bomb)
		--table.insert(bombs, {x, y, z, getTickCount()+ms})
		--addEventHandler("onClientRender", root,teste)
		atmSound = setTimer(
			function (x, y, z, dim, int)
				atmBombSound2(x, y, z, dim, int)
			--end, ms-7000, 1, x, y, z)
			end, ms-7000, 1, x, y, z,dim, int)
	end
)
--[[
function teste()
		if isTimer(atmSound) then
			killTimer(atmSound)
		end
		
		if ( bombs ) then
			bombs = nil
		end
		removeEventHandler("onClientRender", root,teste)
	end
addEvent("terminarBomba", true)
addEventHandler("terminarBomba", resourceRoot, teste)
]]--

function atmBombSound2 (x, y, z, dim, int)
	
	for id = 1, 5 do 
	setTimer(function()
		--setTimer(playSound3D, id*1000, 1, "sounds/c4_beep"..id..".wav", x, y, z, false, true)
		local som = playSound3D("sounds/c4_beep"..id..".wav", x, y, z, false, true)
		setElementDimension(som, dim)
		setElementInterior(som, int)
	end,id*1000,1)
	end

end

--[[
	function teste()
		for _, data in pairs ( bombs ) do
			local x, y, z, tick = data[1], data[2], data[3]+2, data[4]
			local px, py, pz = getCameraMatrix(localPlayer)
			local leftTime = tick - getTickCount()
			local width = (leftTime*80)/300000
			if ( getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 10 ) then
				local x, y = getScreenFromWorldPosition(x, y, z)
					if ( x and y ) then
						local progress = math.floor(((300000-(tick-getTickCount()))/300000)*100)
						if ( progress > 100 ) then return end
						dxDrawRectangle(x-5, y-5, 90, 60, tocolor(0, 0, 0, 200), false, false)
						dxDrawRectangle(x, y, 80, 50, tocolor(255/3, 0/3, 0/3, 200), false, false)
						dxDrawRectangle(x, y, (80-width), 50, tocolor(255, 0, 0, 200), false, false)
						dxDrawText(progress.."%", x+25, y+15, 25, 25, tocolor(0, 0, 255, 255), 1.5, "default-bold")
					end
			end
		end
	end
]]--


function cDown ( )
    seconds = seconds - 1
    local mins,secds = secsToMin(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer( countDown )
        exports.bgo_hud:drawStat("Item", "", "", 200, 0, 0)
    else
        exports.bgo_hud:drawStat("Item", "Tempo do efeito: ", mins..":"..secds, 200, 0, 0)
    end
end



function secsToMin(seconds)
        local hours = 0
        local minutes = 0
        local secs = 0
        local theseconds = seconds
        if theseconds >= 60*60 then
            hours = math.floor(theseconds / (60*60))
            theseconds = theseconds - ((60*60)*hours)
        end
        if theseconds >= 60 then
            minutes = math.floor(theseconds / (60))
            theseconds = theseconds - ((60)*minutes)
        end
        if theseconds >= 1 then
            secs = theseconds
        end 
        if minutes < 10 then
            minutes = "0"..minutes
        end
        if secs < 10 then
            secs = "0"..secs
        end
    return minutes,secs
end



local showedLicensCard = false
local cigarette = {}

function giveHunger(give)
	if give then
		if getElementData(localPlayer, "char:hunger") + give <= 100 then
			setElementData(localPlayer, "char:hunger", getElementData(localPlayer, "char:hunger") + give)
			sucesso("Comendo...")
			triggerServerEvent("addgordura", localPlayer, localPlayer)

			local coco = math.random(5,15)
			if (getElementData(localPlayer, "char:Cagar") or 0) + coco <= 100 then
				setElementData(localPlayer, "char:Cagar", (getElementData(localPlayer, "char:Cagar") or 0) + math.random(1,9))

			if (getElementData(localPlayer, "char:Cagar") or 0) > 40 then
				--exports.JoinQuitGtaV:createNotification("comida", "*Ei, Você está precisando cagar! digite /cagar e sinta-se melhor", 5)
				mensagem("Ei menino ei...", "Digite /cagar e sinta-se melhor","warning")
			end


			elseif (getElementData(localPlayer, "char:Cagar") or 0) + coco > 100 then
				setElementData(localPlayer, "char:Cagar", 100)
				triggerServerEvent("addgordura", localPlayer, localPlayer)
			end


			return true
		elseif getElementData(localPlayer, "char:hunger") == 100 then 
			--outputChatBox("Você não está com fome!!", 255, 255, 255, true)
			mensagem("Ops!", "Você não está com fome!!!", "warning")
			return false
		elseif getElementData(localPlayer, "char:hunger") + give > 95 then
			setElementData(localPlayer, "char:hunger", 100)
			sucesso("Comendo...")
			triggerServerEvent("addgordura", localPlayer, localPlayer)
			return true
		end 
	end 
end

function giveThrink(give)
	if give then
		if getElementData(localPlayer, "char:thirst") + give <= 100 then
			setElementData(localPlayer, "char:thirst", getElementData(localPlayer, "char:thirst") + give)
			return true
		elseif getElementData(localPlayer, "char:thirst") == 100 then 
			--outputChatBox("Você não está com sede!!", 255, 255, 255, true)
			return false
		elseif getElementData(localPlayer, "char:thirst") + give > 85 then
			setElementData(localPlayer, "char:thirst", 100)
			return true
		end 
	end 
end

function giveArmor(thePlayer, give)
	if give then
		-- if getPedArmor(thePlayer) + give <= 100 then
			-- triggerServerEvent("giveArmor", localPlayer, getPedArmor(localPlayer) + give)
			-- return true
		-- elseif getPedArmor(thePlayer) + give > 100 then
			-- triggerServerEvent("giveArmor", localPlayer, 100)
			-- return true
		-- end 
		triggerServerEvent("giveArmor", localPlayer, localPlayer, 100)
	end 
end

function giveArmor2(thePlayer, give)
	if give then
		-- if getPedArmor(thePlayer) + give <= 100 then
			-- triggerServerEvent("giveArmor", localPlayer, getPedArmor(localPlayer) + give)
			-- return true
		-- elseif getPedArmor(thePlayer) + give > 100 then
			-- triggerServerEvent("giveArmor", localPlayer, 100)
			-- return true
		-- end 
		triggerServerEvent("giveArmor", localPlayer, localPlayer, math.random(0,1))
	end 
end

local alcoholTimer
local isAlcoholEffectEnabled = false
function giveAlcohol(give)
--[[
	local playerAlcoholLevel = tonumber(getElementData(localPlayer, "char:AlcoholLevel")) or 0
	if playerAlcoholLevel == 100 then
		setElementHealth(localPlayer, getElementHealth(localPlayer) - 15)
		return false
	else
		if not isTimer(alcoholTimer) then
			alcoholTimer = setTimer(alcoholCountDown, 5000, 0)
		end
		if playerAlcoholLevel > 30 then
			setElementData(localPlayer, "char:Aphasia", true)
			isAlcoholEffectEnabled = true
			--exports.bgo_death:setAlcoholLevel(true)
			exports.bgo_death:disableLSD()
			-- effect
		end
		setElementData(localPlayer, "char:AlcoholLevel", playerAlcoholLevel + give)
		return true
	end]]--
	
			exports["bgo_death"]:enableLSD(2)
			local rand = math.random(1,3)
			setTimer(function()
				exports["bgo_death"]:disableLSD()
			end,rand*60*1000,1)
			
end

function alcoholCountDown()
	local playerAlcoholLevel = tonumber(getElementData(localPlayer, "char:AlcoholLevel")) or 0
	if playerAlcoholLevel > 0 then
		local newLevel = playerAlcoholLevel - 1
		setElementData(localPlayer, "char:AlcoholLevel", newLevel)
		if newLevel < 30 and isAlcoholEffectEnabled then
			isAlcoholEffectEnabled = false
			setElementData(localPlayer, "char:Aphasia", false)
			exports.bgo_death:setAlcoholLevel(false)
			-- effect
		end
	else
		if isTimer(alcoholCountDown) then
			killTimer(alcoholCountDown)
		end
	end
end

function addAlcohol(str, give, itemID, slot, dbid)
	local state = giveAlcohol(give)
	if state then
		me("bebendo um "..str .. ".")
		modositItemCountIfWant(itemID, slot)
	end
end

function addItal(str, slot, itemID, dbid)
	me("bebendo um "..str .. ".")
	giveThrink(20)
	giveAlcohol(20)
	modositItemCountIfWant(itemID, slot)
end

local shields = { }

function addFood(str,give, slot, dbid)
	local state = giveHunger(give)
	if state then
		me("comendo um "..str.. ".")
		--triggerServerEvent("addgordura", localPlayer, localPlayer)
		modositItemCountIfWant(slot)
	end
end

local injekcioTimer

function giveHealth(give)
	if isPedDead(localPlayer) then
		----outputChatBox("Você não pode matá-lo!", 255, 255, 255, true)
		return false
	elseif isTimer(injekcioTimer) then
		--outputChatBox("Você só pode levar isso a cada 5 minutos!", 255, 255, 255, true)
		return false
	end
	if give then
		if getElementHealth(localPlayer) + give <= 100 then
			setElementHealth(localPlayer, getElementHealth(localPlayer) + give)
			injekcioTimer = setTimer(function() end, 5*60*1000, 1)
			return true
		elseif getElementHealth(localPlayer) == 100 then
			--outputChatBox("Você não precisa disso neste momento!", 255, 255, 255, true)
			mensagem("Ops!", "Você não precisa disso neste momento!", "warning")
			return false
		elseif getElementHealth(localPlayer) + give > 100 then
			setElementHealth(localPlayer, 100)
			return true
		end 	
	end 
end

function addHealth(str, give, slot, dbid, itemID)
	if giveHealth(give) then
		me(str)
		modositItemCountIfWant(itemID, slot)
	end
end

function me(me)
	triggerServerEvent("btcMTA->#setPlayerMe", localPlayer, localPlayer, me)
end



keyTable = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b", "c", "e", "f", "g", "h", "i", "j", "k",
 "l", "n", "o", "p", "q", "r", "t", "u", "v", "x", "y", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "num_enter", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "escape", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=" }

addEventHandler("onClientKey", root, function(button, press) 
     if (getElementData(localPlayer, "BloqueandoTecla")) then
	     for i,bindsK in ipairs(keyTable) do
             if (button == bindsK) then
                 cancelEvent() 
			 end
		 end
     end 
end)  




activePhone = -1

local efeitoCamera = false
local efeitoCamera2 = false
local mascaras = false
local mascaras2 = false
local mascaras3 = false
local mascaras4 = false
local mascaras5 = false
local mascaras6 = false
local mascaras7 = false
local mascaras8 = false
local mascaras9 = false
local mascaras10 = false
local mascaras11 = false
local mascaras12 = false
function useItem(DBID, itemSlot, itemID, itemValue, itemCount)
	if itemID == 1 then
		if getElementData(localPlayer,"char:hunger") >= 100 then
			--outputChatBox("você não está com fome!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com fome!", "warning")
		return
		end
		foodoper(itemSlot,DBID,itemID,itemValue,itemCount,15)
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
	elseif itemID == 2 then
		if getElementData(localPlayer,"char:hunger") >= 100 then
			--outputChatBox("Você não está com fome!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com fome!", "warning")
		return
		end
		foodoper(itemSlot,DBID,itemID,itemValue,itemCount,15)
		
		
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
	elseif itemID == 16 then
	
	--outputChatBox("O sistema de celular foi transferido para o 'B' ", 255, 255, 255, true)
	
	--[[
		if exports["mta_phone"]:showPhoneFunction(itemValue) then	
			return
		end]]--


	elseif itemID == 3 then
		if getElementData(localPlayer,"char:hunger") >= 100 then
			--outputChatBox("Você não está com fome!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com fome!", "warning")
		return
		end
		foodoper(itemSlot,DBID,itemID,itemValue,itemCount,15)
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
	elseif itemID == 4 then
		if getElementData(localPlayer,"char:hunger") >= 100 then
			--outputChatBox("Você não está com fome!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com fome!", "warning")
		return
		end
		foodoper(itemSlot,DBID,itemID,itemValue,itemCount,15)
	elseif itemID == 5 then
		if getElementData(localPlayer,"char:hunger") >= 100 then
			--outputChatBox("Você não está com fome!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com fome!", "warning")
		return
		end
		foodoper(itemSlot,DBID,itemID,itemValue,itemCount,15)
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
	elseif itemID == 6 then
		if getElementData(localPlayer,"char:hunger") >= 100 then
			--outputChatBox("Você não está com fome!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com fome!", "warning")
		return
		end
		foodoper(itemSlot,DBID,itemID,itemValue,itemCount,15)
		
	elseif itemID == 76 then
		setElementData(localPlayer, 'char:pp', (getElementData(localPlayer, 'char:pp') + 1000))
		modositItemCountIfWant(itemID, itemSlot)
		--triggerServerEvent("addpp", localPlayer, localPlayer)
	elseif itemID == 77 then
		setElementData(localPlayer, 'char:pp', (getElementData(localPlayer, 'char:pp') + 2000))
		modositItemCountIfWant(itemID, itemSlot)
		--triggerServerEvent("addpp", localPlayer, localPlayer)

	
	elseif itemID == 72 then
		setElementData(localPlayer, 'char:pp', (getElementData(localPlayer, 'char:pp') + 5000))
		modositItemCountIfWant(itemID, itemSlot)
		--triggerServerEvent("addpp", localPlayer, localPlayer)
		
	elseif itemID == 272 then
		setElementData(localPlayer, 'char:pp', (getElementData(localPlayer, 'char:pp') + 100))
		modositItemCountIfWant(itemID, itemSlot)
		--triggerServerEvent("addpp", localPlayer, localPlayer)
		
	elseif itemID == 7 then
				if getElementData(localPlayer,"char:thirst") >= 100 then
			--outputChatBox("Você não está com sede!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com sede!", "warning")
		return
		end
		dringStart(itemSlot,DBID,itemID,itemValue,itemCount,30)	
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)		
	elseif itemID == 8 then
			if getElementData(localPlayer,"char:thirst") >= 100 then
			--outputChatBox("Você não está com sede!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com sede!", "warning")
		return
		end
		dringStart(itemSlot,DBID,itemID,itemValue,itemCount,30)
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)	
	elseif itemID == 12 then
				if getElementData(localPlayer,"char:thirst") >= 100 then
			--outputChatBox("Você não está com sede!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com sede!", "warning")
		return
		end
		dringStart(itemSlot,DBID,itemID,itemValue,itemCount,10)
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
	elseif itemID == 9 then
				if getElementData(localPlayer,"char:thirst") >= 100 then
			--outputChatBox("Você não está com sede!", 255, 255, 255, true)
			mensagem("Ops!", "você não está com sede!", "warning")
		return
		end
		dringStart(itemSlot,DBID,itemID,itemValue,itemCount,2)

		giveAlcohol(1)

			
		if getElementData(localPlayer,"char:hunger") >= 20 then
			setElementData(localPlayer,"char:hunger", getElementData(localPlayer, "char:hunger") - 20)
		else
			setElementData(localPlayer,"char:hunger", 0)
		end
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)	
	elseif itemID == 10 then
		dringStart(itemSlot,DBID,itemID,itemValue,itemCount,2)	
		giveAlcohol(1)
		if getElementData(localPlayer,"char:hunger") >= 20 then
			setElementData(localPlayer,"char:hunger", getElementData(localPlayer, "char:hunger") - 20)
		else
			setElementData(localPlayer,"char:hunger", 0)
		end
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)	
	elseif itemID == 11 then
		dringStart(itemSlot,DBID,itemID,itemValue,itemCount,2)	
		giveAlcohol(1)
		if getElementData(localPlayer,"char:hunger") >= 20 then
			setElementData(localPlayer,"char:hunger", getElementData(localPlayer, "char:hunger") - 20)
		else
			setElementData(localPlayer,"char:hunger", 0)
		end
		triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)	
	elseif itemID == 215 then
		if hasItem(localPlayer, 67) then 
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
			modositItemCountIfWant(itemID, itemSlot)
			smokeStart(itemSlot,DBID,itemID,itemValue,itemCount,30)
		else
			--outputChatBox("#D24D57[btc~Items] #ffffffVocê não tem isso #F7CA18'isqueiro'#ffffff.", 255, 255, 255, true)
			
			mensagem("Ops!", "Você precisa de um isqueiro", "warning")
			
		end	
	elseif itemID == 144 then
		if hasItem(localPlayer, 67) then 
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
			
			--giveArmor2 (localPlayer, math.random(1,5))
			exports["bgo_death"]:enableLSD(math.random(1,1))
			modositItemCountIfWant(itemID, itemSlot)
			smokeStart(itemSlot,DBID,itemID,itemValue,itemCount,30)
		else
			--outputChatBox("#D24D57[btc~Items] #ffffffVocê não tem isso #F7CA18'isqueiro'#ffffff.", 255, 255, 255, true)
			mensagem("Ops!", "Você precisa de um isqueiro", "warning")
		end

	elseif itemID == 17 then
	modositItemCountIfWant(itemID, itemSlot)
	mensagem("Ops!", "O energetico foi removido da cidade!", "warning")
	--[[
		if not getElementData(localPlayer,"char:energetico") or false then
		
		if getElementData(localPlayer, "algemado") then 
		mensagem("Ops!", "Você não pode usar energetico algemado!", "warning")
		return 
		end
		
		if getElementData(localPlayer, "adminjail") == 1 then 
		mensagem("Ops!", "Preso não pode usar energetico!", "warning")
		return 
		end

			triggerEvent("progressService", localPlayer, 5, "#ffffffBebendo energetico!")
			triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "vending", "vend_drink2_p", 5000)
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false)
			me("Bebendo energético")
			setElementData(localPlayer,"char:energetico",true)
			modositItemCountIfWant(itemID, itemSlot)
			if isTimer(tempoEN) then
			killTimer(tempoEN)
			end
			tempoEN = setTimer( function()
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, itemID, false, true)
			

		
		
			triggerServerEvent('bgo:energeticoON', localPlayer, localPlayer)
			sucesso("Efeito do energetico ativo!")
			local rand = 2
			
			seconds = 120
			countDown = setTimer ( cDown, 1000, 120 )
			
			setTimer(function()
			mensagem("Ops!", "Efeito do energético acabou!", "warning")
			triggerServerEvent('bgo:energeticoOFF', localPlayer, localPlayer)
			setElementData(localPlayer,"char:energetico",false)
			end,rand*60*1000,1)
			
			end,5000,1)
			
		else
			mensagem("Ops!", "Você só pode tomar 1 energético de cada vez!", "warning")
		end	
		
		]]--
	elseif itemID == 13 then
		modositItemCountIfWant(itemID, itemSlot)
		triggerServerEvent('btcMTA->#inventoryGiveItem', localPlayer, localPlayer, 215, 1, 20, 0, true)
		
		
		
	elseif itemID == 24 then
	
	if hasItem(localPlayer, 67) then 
		modositItemCountIfWant(itemID, itemSlot)
		triggerServerEvent('bgo:iniciarC4', localPlayer, localPlayer)
	else
	mensagem("Ops!", "Você precisa de um isqueiro para utilizar este item", "warning")
	end
		
		
	elseif itemID == 14 then
		if not getElementData(localPlayer,"char >> isDrugged") or false then
			exports["bgo_death"]:enableLSD(math.random(2,4))
			me("Cheirou uma tira de cocaína")
			setElementData(localPlayer,"char >> isDrugged",true)
			setElementData(localPlayer,"char:hunger",math.random(1,10))
			local rand = math.random(1,3)
			setTimer(function()
				exports["bgo_death"]:disableLSD()
				setElementData(localPlayer,"char >> isDrugged",false)
			end,rand*60*1000,1)
			modositItemCountIfWant(itemID, itemSlot)
		else
			--outputChatBox("Você só pode tomar 1 droga de cada vez!",  255, 255, 255, true)
			mensagem("Ops!", "Você só pode tomar 1 droga de cada vez!", "warning")
		end		
	elseif itemID == 15 then
		if not getElementData(localPlayer,"char >> isDrugged") or false then
			exports["bgo_death"]:enableLSD(4)
			me("Usou e ficou doido com uma heroína")
			setElementData(localPlayer,"char >> isDrugged",true)
			setElementData(localPlayer,"char:hunger",math.random(1,10))
			local rand = math.random(1,3)
			setTimer(function()
				exports["bgo_death"]:disableLSD()
				setElementData(localPlayer,"char >> isDrugged",false)
			end,rand*60*1000,1)
			modositItemCountIfWant(itemID, itemSlot)
		else
			--outputChatBox("Você só pode tomar 1 droga de cada vez!",  255, 255, 255, true)
			mensagem("Ops!", "Você só pode tomar 1 droga de cada vez!", "warning")
		end	
		
	elseif (itemID == 56) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, "99999")
	slots = itemSlot
	itemids = itemID
	
	elseif itemID == 17 then
		-- triggerServerEvent("checkCarKey",localPlayer,localPlayer,DBID,itemValue)	
	elseif (itemLists[itemID].weaponID == 1) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
	elseif (itemLists[itemID].weaponID == 2) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
	elseif (itemLists[itemID].weaponID == 3) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
	elseif (itemLists[itemID].weaponID == 4) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
elseif (itemLists[itemID].weaponID == 5) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
	elseif (itemLists[itemID].weaponID == 10) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
	elseif (itemLists[itemID].weaponID == 11) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID
	elseif (itemLists[itemID].weaponID == 12) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, itemValue)
	slots = itemSlot
	itemids = itemID

	elseif (itemLists[itemID].weaponID == 42) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, "99999")
	slots = itemSlot
	itemids = itemID

	elseif (itemLists[itemID].weaponID == 41) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, "99999")
	slots = itemSlot
	itemids = itemID

	elseif (itemLists[itemID].weaponID == 224) then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, "99999")
	slots = itemSlot
	itemids = itemID
	
	--elseif itemID == 63 then
	elseif (itemLists[itemID].weaponID == 46) then
	if tonumber(getPedWeapon(getLocalPlayer())) == tonumber(itemLists[itemID].weaponID) then
	--outputChatBox("#7cc576[ITEMS] #FFFFFFJá tem uma molotov equipada!", 255, 0, 0,true)
	mensagem("Ops!", "Já tem um Paraquedas equipado", "warning")
	else
	triggerServerEvent("toggleGun2", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, "1")
	slots = itemSlot
	itemids = itemID
	modositItemCountIfWant(itemID, itemSlot)

	end

	elseif (itemLists[itemID].weaponID == 18) then
	if tonumber(getPedWeapon(getLocalPlayer())) == tonumber(itemLists[itemID].weaponID) then
	--outputChatBox("#7cc576[ITEMS] #FFFFFFJá tem uma molotov equipada!", 255, 0, 0,true)
	mensagem("Ops!", "Já tem uma molotov equipada", "warning")
	else
	triggerServerEvent("toggleGun2", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, "1")
	slots = itemSlot
	itemids = itemID
	modositItemCountIfWant(itemID, itemSlot)

	end
	elseif itemID == 316 then
	local pedSlot = getPedWeaponSlot ( localPlayer )
	if (pedSlot == 0)	then
	--outputChatBox("#7cc576[ITEMS]#FFFFFF Equipe uma arma primeiro para depois equipar este item!!", 255, 0, 0,true)
	mensagem("Ops!", "Equipe uma arma primeiro para depois equipar este item", "warning")
	return
	end
	
	if getElementData(localPlayer,"efeitoCamera2") then  return end --outputChatBox("#7cc576[ITEMS]#FFFFFF Você já está com um efeito de camera equipada!", 255, 0, 0,true) return end
	if not efeitoCamera then
	setCameraGoggleEffect("nightvision")
	
	--outputChatBox("#7cc576[ITEMS]#FFFFFF nightvision equipada!", 255, 0, 0,true)
	
	efeitoCamera = true
	setElementData(localPlayer, "efeitoCamera", true)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	else
	setCameraGoggleEffect("normal")
	efeitoCamera = false
	setElementData(localPlayer, "efeitoCamera", false)
	--outputChatBox("#7cc576[ITEMS]#FFFFFF nightvision desequipada!", 255, 0, 0,true)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end

	elseif itemID == 317 then
	local pedSlot = getPedWeaponSlot ( localPlayer )
	if (pedSlot == 0)	then
	--outputChatBox("#7cc576[ITEMS]#FFFFFF Equipe uma arma primeiro para depois equipar este item!!", 255, 0, 0,true)
	mensagem("Ops!", "Equipe uma arma primeiro para depois equipar este item", "warning")
	return
	end
	
	if getElementData(localPlayer,"efeitoCamera") then  return end --outputChatBox("#7cc576[ITEMS]#FFFFFF Você já está com um efeito de camera equipada!", 255, 0, 0,true) return end
	if not efeitoCamera2 then
	setCameraGoggleEffect("thermalvision")
	--outputChatBox("#7cc576[ITEMS]#FFFFFF thermalvision equipada!", 255, 0, 0,true)
	efeitoCamera2 = true
	setElementData(localPlayer, "efeitoCamera2", true)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	else
	setCameraGoggleEffect("normal")
	--outputChatBox("#7cc576[ITEMS]#FFFFFF thermalvision desequipada!", 255, 0, 0,true)
	efeitoCamera2 = false
	setElementData(localPlayer, "efeitoCamera2", false)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
	
	elseif itemID == 113 then
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		if theVehicle then
			if getElementHealth(theVehicle) <= 1000 then
			setElementHealth(theVehicle, 1000 )
			fixVehicle(theVehicle)
			triggerServerEvent("fixveh", getLocalPlayer())
			modositItemCountIfWant(itemID, itemSlot)
			else
			--outputChatBox("#7cc576[ITEMS]#FFFFFF Seu veiculo ja está com vida completa!!", 255, 0, 0,true)
			mensagem("Ops!", "Seu veiculo ja está com vida completa", "warning")
		end
		else
			--outputChatBox("#7cc576[ITEMS]#FFFFFF Item só é usavel dentro do veiculo!!", 255, 0, 0,true)
			mensagem("Ops!", "Item só é usavel dentro do veiculo", "warning")
	end

	elseif itemID == 114 then
	local theVehicle = getPedOccupiedVehicle ( localPlayer )
	if theVehicle then
		if getElementData(theVehicle, 'veh:fuel') <= 99 then
		setElementData(theVehicle, 'veh:fuel', 100 )
		modositItemCountIfWant(itemID, itemSlot)
		else
			--outputChatBox("#7cc576[ITEMS]#FFFFFF Seu veiculo ja está com gasolina completa!!", 255, 0, 0,true)
			mensagem("Ops!", "Seu veiculo ja está com gasolina cheia", "warning")
		end
	else
		--outputChatBox("#7cc576[ITEMS]#FFFFFF Item só é usavel dentro do veiculo!!", 255, 0, 0,true)
		mensagem("Ops!", "Item só é usavel dentro do veiculo!", "warning")
	end

elseif itemID == 115 then
	local theVehicle = getPedOccupiedVehicle ( localPlayer )
	if theVehicle then
		setElementRotation(theVehicle,0,0,0)
		modositItemCountIfWant(itemID, itemSlot)
	else
		--outputChatBox("#7cc576[ITEMS]#FFFFFF Item só é usavel dentro do veiculo!!", 255, 0, 0,true)
		mensagem("Ops!", "Item só é usavel dentro do veiculo!", "warning")
end

	elseif itemID == 280 then
	

	elseif itemID == 288 then
		---if ( not getElementModel ( localPlayer ) == 0 ) then --outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) return end
		if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end

	if not mascaras then
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 4)
		mascaras = true
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		setElementData(localPlayer, "mascara", true)
	else
		setElementData(localPlayer, "mascara", false)
		mascaras = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)

		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end


	elseif itemID == 289 then
		--if ( getElementModel ( localPlayer ) == 0 ) then
		if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if not mascaras2 then
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 1)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		mascaras2 = true
		setElementData(localPlayer, "mascara2", true)
	else
		setElementData(localPlayer, "mascara2", false)
		mascaras2 = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
--else
	----outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) 
 	--end

	elseif itemID == 290 then
		--if ( getElementModel ( localPlayer ) == 0 ) then
		if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if not mascaras3 then
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 2)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		mascaras3 = true
		setElementData(localPlayer, "mascara3", true)
	else
		setElementData(localPlayer, "mascara3", false)
		mascaras3 = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
--else
	----outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) 
	-- end
	 

	elseif itemID == 291 then
		--if ( getElementModel ( localPlayer ) == 0 ) then 
		if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if not mascaras4 then
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 6)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		mascaras4 = true
		setElementData(localPlayer, "mascara4", true)
	else
		setElementData(localPlayer, "mascara4", false)
		mascaras4 = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
--else
	----outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) 
 	--end
	elseif itemID == 292 then
		--if ( getElementModel ( localPlayer ) == 0 ) then
		if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if not mascaras5 then
		setElementData(localPlayer, "mascara5", true)
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 3)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		mascaras5 = true
	else
		setElementData(localPlayer, "mascara5", false)
		mascaras5 = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
--else
	----outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) 
	-- end
	 
	elseif itemID == 293 then
	--	if ( getElementModel ( localPlayer ) == 0 ) then
		if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if not mascaras6 then
		setElementData(localPlayer, "mascara6", true)
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 7)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		mascaras6 = true
	else
		setElementData(localPlayer, "mascara6", false)
		mascaras6 = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
--else
	----outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) 
 	--end

	elseif itemID == 294 then
		if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
		--if ( getElementModel ( localPlayer ) == 0 ) then

	if not mascaras7 then
		triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 5)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
		setElementData(localPlayer, "mascara7", true)
		mascaras7 = true
	else
		setElementData(localPlayer, "mascara7", false)
		mascaras7 = false
		triggerServerEvent("removeMask2", localPlayer, localPlayer)
		setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
	end
	--else
	----outputChatBox("#7cc576[ITEMS]#FFFFFF Você só pode equipar mascara na SKIN CJ!", 255, 0, 0,true) 
 	--end


elseif itemID == 295 then
	if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
if not mascaras8 then
	triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 9)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	setElementData(localPlayer, "mascara8", true)
	mascaras8 = true
else
	setElementData(localPlayer, "mascara8", false)
	mascaras8 = false
	triggerServerEvent("removeMask2", localPlayer, localPlayer)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
end


elseif itemID == 301 then
	if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
if not mascaras9 then
	triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 10)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	setElementData(localPlayer, "mascaras9", true)
	mascaras9 = true
else
	setElementData(localPlayer, "mascaras9", false)
	mascaras9 = false
	triggerServerEvent("removeMask2", localPlayer, localPlayer)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
end

elseif itemID == 302 then
	if getElementData(localPlayer,"mascara") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara11") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
if not mascaras10 then
	triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 11)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	setElementData(localPlayer, "mascaras10", true)
	mascaras10 = true
else
	setElementData(localPlayer, "mascaras10", false)
	mascaras10 = false
	triggerServerEvent("removeMask2", localPlayer, localPlayer)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
end

elseif itemID == 341 then
	if getElementData(localPlayer,"mascara") then  mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara12") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
if not mascaras11 then
	triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 12)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	setElementData(localPlayer, "mascaras11", true)
	mascaras11 = true
else
	setElementData(localPlayer, "mascaras11", false)
	mascaras11 = false
	triggerServerEvent("removeMask2", localPlayer, localPlayer)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
end

elseif itemID == 359 then
	if getElementData(localPlayer,"mascara") then  mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara2") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara3") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara4") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara5") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara6") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara7") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara8") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara9") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	if getElementData(localPlayer,"mascara10") then mensagem("Ops!", "Você já está com uma mascara equipada", "warning") return end
	
if not mascaras12 then
	triggerServerEvent("mask", getLocalPlayer(), getLocalPlayer(), 13)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)
	setElementData(localPlayer, "mascaras12", true)
	mascaras12 = true
else
	setElementData(localPlayer, "mascaras12", false)
	mascaras12 = false
	triggerServerEvent("removeMask2", localPlayer, localPlayer)
	setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
end



	elseif itemID == 29 then
		if not showedIndentyCard then
			local values = fromJSON(itemValue)
		--	--outputChatBox(values[1])
			exports.bgo_identidade:showCard(1,values[1],values[2],values[3],values[4])
			showedIndentyCard = true
		else
			showedIndentyCard = false
			exports.bgo_identidade:destroyCard(1)
		end
		
		elseif itemID == 111 then
		if not showedPassaporte then
			local values = fromJSON(itemValue)
		--	--outputChatBox(values[1])
			exports.bgo_passaporte:showPassaporte(1,values[1],values[2],values[3],values[4])
			showedPassaporte = true
		else
			showedPassaporte = false
			exports.bgo_passaporte:destroyPassaporte(1)
		end	
		
	
	elseif itemID == 152 then
		triggerServerEvent('btcMTA->#createShield', localPlayer, localPlayer)
		slots = itemSlot
		itemids = itemID
	elseif itemID == 109 then
		setElementData(localPlayer, 'money', (getElementData(localPlayer, 'money') + 20000000))
		modositItemCountIfWant(itemID, itemSlot)
	elseif itemID == 26 then
			--local veh = getPedOccupiedVehicle(localPlayer)
			--setElementData(veh, "fuel", 100, false)
            --modositItemCountIfWant(itemID, itemSlot)
	elseif itemID == 28 then
		if not showedLicensCard then
			local values = fromJSON(itemValue)
		---	--outputChatBox(values[1])
			exports.bgo_detran:showJogsi(2,values[1],values[2],values[3],values[4])
			showedLicensCard = true
		else
			showedLicensCard = false
			exports.bgo_detran:destroyJogsi(2)
		end
	elseif itemID == 34 then
		if not getElementData(localPlayer, 'char->bage.show') then 
			setElementData(localPlayer, 'char->bage', itemValue)
			setElementData(localPlayer, 'char->bage.show', true)
			me('Sou deficiente auditivo, por favor digite pelo chat local (U).')
			setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, true)	
		else
			me('Sou deficiente auditivo, por favor digite pelo chat local (U).')
			setElementData(localPlayer, "char:weaponGettin"..getItemType(itemID)..itemSlot, false)
			setElementData(localPlayer, 'char->bage', 0)
			setElementData(localPlayer, 'char->bage.show', false)
		end
	elseif itemID == 84 then
		sucesso("Equipando colete....")
    triggerServerEvent("btcMTA->#setPlayerMe", localPlayer, localPlayer, "Colocou o colete à prova de balas.")
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 3000, true, false, false)
	--triggerEvent("progressService", localPlayer, 10, "#ffffffEquipando colete!")
    setPedArmor(localPlayer, 100)
    modositItemCountIfWant(itemID, itemSlot)
	--[[
	if tonumber(getPedArmor(localPlayer) or 0) < 100 then
	fecharItem()
	
	setElementData(localPlayer,"BloqueandoTecla", true)
	sucesso("Equipando colete....")
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 10000, true, false, false)
	--triggerEvent("progressService", localPlayer, 10, "#ffffffEquipando colete!")
    setPedArmor(localPlayer, getPedArmor(localPlayer) + 10)
    modositItemCountIfWant(itemID, itemSlot)
	
	setTimer(function()
	setElementData(localPlayer,"BloqueandoTecla", false)
	sucesso("Equipando...")
	me('Colocou o colete à prova de balas.')
	if tonumber(getPedArmor(localPlayer) or 0) + 10 <= 100 then		
			
			colete = setTimer(function()
			if tonumber(getPedArmor(localPlayer)or 0) < 100 then
			setPedArmor(localPlayer, getPedArmor(localPlayer) + 10)
			--giveArmor (localPlayer, 10 )
			sucesso("+10 Colete")
			else
			if isTimer(colete) then
			killTimer(colete)
			end
			sucesso("Colete equipado!")
			setPedArmor(localPlayer, 100)
			end
			end,1000,0)
			else
			
			if isTimer(colete) then
			killTimer(colete)
			end
			sucesso("Colete equipado!")
			setPedArmor(localPlayer, 100)
	end
	modositItemCountIfWant(itemID, itemSlot)
	end,10000,1)

	else
	mensagem("Ops!", "Você não precisa de colete", "warning")
	end --]]
	
	elseif itemID == 64 then
	if tonumber(getElementHealth(localPlayer) or 0) + 10 < 100 then
	fecharItem()
	
	setElementData(localPlayer,"BloqueandoTecla", true)
	sucesso("Usando kit de primeiros socorros....")
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 10000, true, false, false)
	triggerEvent("progressService", localPlayer, 10, "#ffffffUsando kit de primeiros socorros!")
	
	
	setTimer(function()
			setElementData(localPlayer,"BloqueandoTecla", false)
			sucesso("Iniciando primeiros socorros....")
			me('Usei um kit de primeiros socorros.')
			--giveArmor (localPlayer, 100 )
			
			vida = setTimer(function()
			if tonumber(getElementHealth(localPlayer) or 0) + 10 <= 100 then
			setElementHealth(localPlayer, getElementHealth(localPlayer) + 10)
			sucesso("+10 Vida")
			else
			if isTimer(vida) then
			killTimer(vida)
			end
			sucesso("Vida restaurada!!")
			setElementHealth(localPlayer, 100)
			end
			end,1000,0)
			
			
			modositItemCountIfWant(itemID, itemSlot)
	end,10000,1)
	else
	mensagem("Ops!", "Você não precisa de primeiros socorros", "warning")
	end
	elseif itemID == 112 then
		if not showedLicensCardP then
			local values = fromJSON(itemValue)
		---	--outputChatBox(values[1])
			exports.bgo_cardporte:showCardP(3,values[1],values[2],values[3], values[4])
			showedLicensCardP = true
		else
			showedLicensCardP = false
			exports.bgo_cardporte:destroyCardP(3)
		end
	elseif itemID == 62 then
		if getElementDimension(localPlayer) > 0 then
			triggerServerEvent("item->createSafe",localPlayer,localPlayer) 
			modositItemCountIfWant(itemID, itemSlot)
		else
			--outputChatBox("Você só pode criar um cofre dentro de um interior")
			mensagem("Ops!", "Você só pode criar um cofre dentro de um interior!", "warning")
		end	
	elseif itemID == 85 then
		--outputChatBox("#d24d57[pescaria]: #ffffffNenhuma isca nele!", 255, 255, 255, true)
	elseif itemID == 65 then
		if not getElementData(localPlayer,"char >> isDrugged") or false then
			exports.bgo_death:enableAmf(math.random(1,4))
			me("Usou uma metanfetamina")
			setElementData(localPlayer,"char >> isDrugged",true)
			--setElementData(localPlayer,"char:hunger",math.random(1,10))
			--exports.bgo_death:enableAmf(math.random(4))
			--addHealth("tomou um remédio",math.random(10,20),itemSlot,DBID, itemID)
			setTimer(function()
			setElementHealth(localPlayer, getElementHealth(localPlayer) + 10)
			
			if getElementData(localPlayer, "char:hunger") + 10 <= 100 then
			setElementData(localPlayer, "char:hunger", getElementData(localPlayer, "char:hunger") + 10)
			else
			setElementData(localPlayer, "char:hunger", 100)
			end
			if getElementData(localPlayer, "char:thirst") + 10 <= 100 then
			setElementData(localPlayer, "char:thirst", getElementData(localPlayer, "char:thirst") + 10)
			else
			setElementData(localPlayer, "char:thirst", 100)
			end

			end,1000,15)
			
			local rand = math.random(1,2)
			setTimer(function()
				exports["bgo_death"]:disableAmf()
				setElementData(localPlayer,"char >> isDrugged",false)
			end,rand*60*1000,1)
			modositItemCountIfWant(itemID, itemSlot)
		else
			--outputChatBox("Você só pode tomar 1 droga de cada vez!",  255, 255, 255, true)
			mensagem("Ops!", "Você só pode tomar 1 droga de cada vez!", "warning")
		end	
		
		
		
	elseif itemID == 78 then
		----outputChatBox("#d24d57[BTCMTA]: #ffffffEste item foi desativado!!", 255, 255, 255, true)
		if not getElementData(localPlayer, "PlayerCaido") then
		addHealth("Usou uma bolsa de sangue!",math.random(100,100),itemSlot,DBID, itemID)
		else
		--outputChatBox("Você não pode usar este item caido!",255,255,255,true)
		mensagem("Ops!", "Você não pode usar este item caido!", "warning")
		end
	elseif itemID == 70 then
		if not isPedInVehicle(localPlayer) then
			--outputChatBox("Você não está sentado em um veículo!",255,255,255,true)
			mensagem("Ops!", "Você não está sentado em um veículo!!", "warning")
		else
			local vehicle = getPedOccupiedVehicle(localPlayer);
			local health = getElementHealth(vehicle);
			if health>=950 then
				--outputChatBox("Seu veículo não está danificado o suficiente!",255,255,255,true)
				mensagem("Ops!", "Seu veículo não está danificado o suficiente!", "warning")
			else	
				triggerServerEvent("fixCardUse",localPlayer,vehicle)
				modositItemCountIfWant(itemID, itemSlot)
			end
		end
	elseif itemID == 71 then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
			local fuel = tonumber(getElementData(vehicle, "veh:fuel")) or 1
			if fuel>=95 then
				--outputChatBox("Você não precisa reabastecer seu veículo ainda!", 255, 30, 30, true)
				mensagem("Ops!", "Você não precisa reabastecer seu veículo ainda!", "warning")
			else
				setElementData(vehicle, "fuel", 100)
				modositItemCountIfWant(itemID, itemSlot)
			end
		else
			--outputChatBox("Você não está em um carro!", 255, 30, 30, true)
			mensagem("Ops!", "Você não está em um carro!", "warning")
		end
	elseif itemID == 158 then
		exports['bgo_fishing']:createStick()	
	elseif itemID == 105 then--108 then
		exports['bgo_Event']:startEventFunction()
		modositItemCountIfWant(itemID, itemSlot)
	elseif itemID == 106 then--108 then
		exports['bgo_caixaDourada']:startEventFunction()	
		modositItemCountIfWant(itemID, itemSlot)
	elseif itemID == 107 then--108 then
		exports['bgo_caixaPatriota']:startEventFunction()
		modositItemCountIfWant(itemID, itemSlot)
	elseif itemID == 108 then--108 then
		exports['bgo_Event2']:startEventFunction()
		modositItemCountIfWant(itemID, itemSlot)	
	elseif itemID == 111 then
		exports['btcLicenses']:showLicenses(itemValue, 1)	
	elseif itemID == 112 then
		exports['btcLicenses']:showLicenses(itemValue, 2)	
	elseif itemID == 136 then
		exports['btcLicenses']:showLicenses(itemValue, 3)
	elseif itemID == 216 then
		-- if exports['bgo_groups']:isPlayerInFaction(localPlayer, 1) then
			exports['btcTicket']:createTicket()
		--end
	elseif itemID == 27 then
		if tonumber(getElementData(localPlayer,"char:vicio") or 0) > 1 then
			sucesso("Eba!", "Você se tratou do vicio, parabéns!", "warning")
			setElementData(localPlayer,"char:vicio",0)
            modositItemCountIfWant(itemID, itemSlot)
			else
			mensagem("Ops!", "Você não preciso disso!", "warning")
			end
			
	elseif itemID == 217 then
		exports['btcTicket']:drawTickets(itemValue)	
	elseif itemID == 142 then
		if getElementInterior(localPlayer) > 0 and getElementDimension(localPlayer) > 0 then 
			triggerServerEvent('btcMTA->#createPlant', localPlayer, localPlayer, 2)
		else
			--outputChatBox("#D24D57[btc~Items] #ffffffVocê só pode colocar esse objeto no interior!", 255, 194, 14, true)
			mensagem("Ops!", "Você só pode colocar esse objeto no interior!", "warning")
		end
	elseif itemID == 227 then
		-- if exports['bgo_groups']:isPlayerInFaction(localPlayer, 1) or exports['bgo_groups']:isPlayerInFaction(localPlayer, 2) or exports['bgo_groups']:isPlayerInFaction(localPlayer, 4) then
			exports['btcInserSiren']:createSiren()
			modositItemCountIfWant(itemID, itemSlot)
		--end
	elseif itemID == 110 then
		exports["btcLotto"]:showLotto(itemValue)
	elseif itemID == 143 then
		if getElementInterior(localPlayer) > 0 and getElementDimension(localPlayer) > 0 then 
			triggerServerEvent('btcMTA->#createPlant', localPlayer, localPlayer, 1)
		else
			--outputChatBox("#D24D57[btc~Items] #ffffffVocê só pode colocar esse objeto no interior!", 255, 194, 14, true)
			mensagem("Ops!", "Você só pode colocar esse objeto no interior!", "warning")
		end
	elseif itemID >= 231 and itemID <= 240 then
		--triggerServerEvent('btcMTA->#insertStat', localPlayer, localPlayer, itemID, itemSlot)


	-- pistolas
	elseif (itemLists[itemID].weaponID == 22) then
	if getElementData(localPlayer, "balas-pistola") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-pistola")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 23) then
	if getElementData(localPlayer, "balas-pistola") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-pistola")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 24) then
	if getElementData(localPlayer, "balas-pistola") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-pistola")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end

	-- shotgun
	elseif (itemLists[itemID].weaponID == 25) then
	if getElementData(localPlayer, "balas-shotgun") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-shotgun")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 26) then
	if getElementData(localPlayer, "balas-shotgun") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-shotgun")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 27) then
	if getElementData(localPlayer, "balas-shotgun") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-shotgun")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end

	-- Sub-metralhadora
	elseif (itemLists[itemID].weaponID == 28) then
	if getElementData(localPlayer, "balas-submetralhadora") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-submetralhadora")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 29) then
	if getElementData(localPlayer, "balas-submetralhadora") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-submetralhadora")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 32) then
	if getElementData(localPlayer, "balas-submetralhadora") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-submetralhadora")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end


	-- Fuzil
	elseif (itemLists[itemID].weaponID == 30) then
	if getElementData(localPlayer, "balas-fuzil") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-fuzil")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 31) then
	if getElementData(localPlayer, "balas-fuzil") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-fuzil")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end


	-- snipers
	elseif (itemLists[itemID].weaponID == 33) then
	if getElementData(localPlayer, "balas-sniper") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-sniper")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end
	elseif (itemLists[itemID].weaponID == 34) then
	if getElementData(localPlayer, "balas-sniper") > 0 then
	triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), itemSlot, itemID, tonumber(getElementData(localPlayer, "balas-sniper")) or 1)
	slots = itemSlot
	itemids = itemID
	else
	--outputChatBox("Sem você não tem munição!",  255, 255, 255, true)
	mensagem("Ops!", "você não tem munição!", "warning")
	end



	else
	mensagem("Ops!", "Não há ação para este item!", "warning")
	end	
end

local haszItem = ""
local haszItemValue = ""
local haszItemCount = ""
local haszItemSlot = ""
local haszItemDBID = ""
local haszItemFood = ""

function foodoper(itemSlot,DBID,itemID,itemValue,itemCount,foodfuel)
	if isTimer(timers) then mensagem("Ops!", "Aguarde um pouco!", "warning") return end
	timers = setTimer(function() end,4000,1)
	
	haszItem = itemID
	haszItemValue = itemValue
	haszItemCount = itemCount
	haszItemSlot = itemSlot
	haszItemDBID = DBID
	haszItemFood = foodfuel
	

	--triggerServerEvent("addgordura", localPlayer, localPlayer)

	giveHunger(math.random(20,35))
	triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "food", "eat_burger", 4000, true, false)
	modositItemCountIfWant(haszItem, haszItemSlot)
	
	setTimer(function()
	triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
	end,4000,1)



	--setElementData(localPlayer, "Comendo", true)
	--modositItemCountIfWant(haszItem, haszItemSlot)
	--addEventHandler("onClientRender",getRootElement(),foodRender)


end

function dringStart(itemSlot,DBID,itemID,itemValue,itemCount,foodfuel)

	if isTimer(timers) then mensagem("Ops!", "Aguarde um pouco!", "warning") return end
	timers = setTimer(function()
	end,4000,1)

		
		
	haszItem = itemID
	haszItemValue = itemValue
	haszItemCount = itemCount
	haszItemSlot = itemSlot
	haszItemDBID = DBID
	haszItemFood = foodfuel
	
	
	
	--me("Bebendo ".. getItemName(haszItem).. '')
	giveThrink(math.random(15,25))
	triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "vending", "vend_drink2_p", 4000, true, false)
	modositItemCountIfWant(haszItem, haszItemSlot)
	setTimer(function()
	triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
	end,4000,1)
	




	--setElementData(localPlayer, "Comendo", true)
	--modositItemCountIfWant(haszItem, haszItemSlot)

	--addEventHandler("onClientRender",getRootElement(),drinkRender)

end

function smokeStart(itemSlot,DBID,itemID,itemValue,itemCount,foodfuel)
	haszItem = itemID
	haszItemValue = itemValue
	haszItemCount = itemCount
	haszItemSlot = itemSlot
	haszItemDBID = DBID
	haszItemFood = foodfuel
	
	setElementData(localPlayer, "Comendo", true)
	
	--modositItemCountIfWant(haszItem, haszItemSlot)
		
	addEventHandler("onClientRender",getRootElement(),smokeRender)
end


local box = {40,40}
local box2 = {64,64}
local box3 = {200,30}
local actionBar = {342,110}
local katt = 0
local lastClick = 0

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function checkCursor()
	if not guiGetInputEnabled() and not isMTAWindowActive() and isCursorShowing( ) then
		return true
	else
		return false
	end
end

function foodRender()

	local width,height = itemSize*(actionbarSlot)+margin*(actionbarSlot+1), itemSize+margin*2

	if isInSlot(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2]) then
		dxCreateBorder(monitorSize[1]/2 - width/2+120,actionPosY-height+10-51,box[1],box[2],tocolor(136,211,115,255))
		dxDrawImage(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2],"files/items/"..haszItem..".png")

		if getKeyState("mouse1") and lastClick+200 <=getTickCount() then
			lastClick = getTickCount() -- food eat_burger
			if isTimer(timers) then mensagem("Ops!", "Aguarde um pouco!", "warning") return end
			if katt < 9 then
				katt = katt + 1
				--setElementFrozen(localPlayer,true)
				--setPedAnimation(localPlayer, "food", "eat_burger",2000,false,false)
				triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "food", "eat_burger", 4000, true, false)
				timers = setTimer(function()
				--	setElementFrozen(localPlayer,false)
				end,3000,1)
				
				--me("Esta comendo ".. getItemName(haszItem) .. '')

				--triggerServerEvent("addgordura", localPlayer, localPlayer)

				giveHunger(5)
				
				if getElementData(localPlayer,"char:hunger") >= 90 then
					giveHunger(10)
					triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
					removeEventHandler("onClientRender",getRootElement(),foodRender)
					
					setElementData(localPlayer, "Comendo", false)
					
					
					--modositItemCountIfWant(haszItem, haszItemSlot)
					katt = 0
				end
			else
				setElementData(localPlayer, "Comendo", false)
				removeEventHandler("onClientRender",getRootElement(),foodRender)
				--modositItemCountIfWant(haszItem, haszItemSlot)
				katt = 0
				triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
			end
		end	
		if getKeyState("mouse2") and lastClick+200 <=getTickCount() then
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
			lastClick = getTickCount()
			triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "carry", "putdwn", 4000, false, false)
			-- setPedAnimation(localPlayer, "carry", "putdwn",2000,false,false)
			--modositItemCountIfWant(haszItem, haszItemSlot)
			--me("Jogou um objeto no chão (".. getItemName(haszItem)..")")
			exports["bgo_death"]:disableLSD()
			
			setElementData(localPlayer, "Comendo", false)
			
			removeEventHandler("onClientRender",getRootElement(),foodRender)
			katt = 0
		end
	else
		dxDrawImage(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2],"files/items/"..haszItem..".png")
	end

	dxDrawImage(monitorSize[1]/2 - width/2+40,actionPosY-height-height-20,box2[1],box2[2],"img/1.png")
	dxDrawImage(monitorSize[1]/2 - width/2+180,actionPosY-height-height-20,box2[1],box2[2],"img/2.png")
	dxDrawRectangle(monitorSize[1]/2 - width/2+40,actionPosY-height+10,box3[1],box3[2],tocolor(0,0,0,150))
	dxDrawText("Comer",monitorSize[1]/2 - width/2+10,actionPosY-height+10-35,0,0,tocolor(255,255,255,255),1,"default-bold")
	dxDrawText("Descartar",monitorSize[1]/2 - width/2+235,actionPosY-height+10-35,0,0,tocolor(255,255,255,255),1,"default-bold")
	dxDrawRectangle(monitorSize[1]/2 - width/2+42,actionPosY-height+10+1.6,box3[1]*(katt*10)/100,box3[2]-4,tocolor(136,211,115,150))
	dxDrawText((katt*10).."%",monitorSize[1]/2 - width/2+130,actionPosY-height+10+7,0,0,tocolor(255,255,255,255),1,"default-bold")

end

function drinkRender()

	local width,height = itemSize*(actionbarSlot)+margin*(actionbarSlot+1), itemSize+margin*2

	if isInSlot(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2]) then
		dxCreateBorder(monitorSize[1]/2 - width/2+120,actionPosY-height+10-51,box[1],box[2],tocolor(136,211,115,255))
		dxDrawImage(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2],"files/items/"..haszItem..".png")

		if getKeyState("mouse1") and lastClick+200 <=getTickCount() then
			lastClick = getTickCount() -- food eat_burger
			if isTimer(timers) then mensagem("Ops!", "Aguarde um pouco!", "warning") return end
			if katt < 9 then
				katt = katt + 1
				--setElementFrozen(localPlayer,true)
				 --setPedAnimation(localPlayer, "vending", "vend_drink2_p",2000,false,false)
				triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "vending", "vend_drink2_p", 4000, true, false)
				timers = setTimer(function()
				--	setElementFrozen(localPlayer,false)
				end,3000,1)
				
				--me("Bebendo ".. getItemName(haszItem).. '')
				giveThrink(5)
				if getElementData(localPlayer,"char:thirst") >= 90 then
				
				setElementData(localPlayer, "Comendo", false)
				
				giveThrink(10)
					triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
					removeEventHandler("onClientRender",getRootElement(),drinkRender)
				--	modositItemCountIfWant(haszItem, haszItemSlot)
					katt = 0
				end
			else
				setElementData(localPlayer, "Comendo", false)
				removeEventHandler("onClientRender",getRootElement(),drinkRender)
				--modositItemCountIfWant(haszItem, haszItemSlot)
				katt = 0
			end
		end	
		if getKeyState("mouse2") and lastClick+200 <=getTickCount() then
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
			lastClick = getTickCount()
		--	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "carry", "putdwn", 1000, false, false)
			--modositItemCountIfWant(haszItem, haszItemSlot)
			--me("Jogou um objeto no chão (".. getItemName(haszItem)..")")
			setElementData(localPlayer, "Comendo", false)
			
			removeEventHandler("onClientRender",getRootElement(),drinkRender)
			katt = 0
		end
	else
		dxDrawImage(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2],"files/items/"..haszItem..".png")
	end

	dxDrawImage(monitorSize[1]/2 - width/2+40,actionPosY-height-height-20,box2[1],box2[2],"img/1.png")
	dxDrawImage(monitorSize[1]/2 - width/2+180,actionPosY-height-height-20,box2[1],box2[2],"img/2.png")
	dxDrawRectangle(monitorSize[1]/2 - width/2+40,actionPosY-height+10,box3[1],box3[2],tocolor(0,0,0,150))
	dxDrawText("Beber",monitorSize[1]/2 - width/2+10,actionPosY-height+10-35,0,0,tocolor(255,255,255,255),1,"default-bold")
	dxDrawText("Descartar",monitorSize[1]/2 - width/2+235,actionPosY-height+10-35,0,0,tocolor(255,255,255,255),1,"default-bold")
	dxDrawRectangle(monitorSize[1]/2 - width/2+42,actionPosY-height+10+1.6,box3[1]*(katt*10)/100,box3[2]-4,tocolor(136,211,115,150))
	dxDrawText((katt*10).."%",monitorSize[1]/2 - width/2+130,actionPosY-height+10+7,0,0,tocolor(255,255,255,255),1,"default-bold")

	
end


function smokeRender()

	local width,height = itemSize*(actionbarSlot)+margin*(actionbarSlot+1), itemSize+margin*2

	if isInSlot(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2]) then
		dxCreateBorder(monitorSize[1]/2 - width/2+120,actionPosY-height+10-51,box[1],box[2],tocolor(136,211,115,255))
		dxDrawImage(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2],"files/items/"..haszItem..".png")

		if getKeyState("mouse1") and lastClick+200 <=getTickCount() then
			lastClick = getTickCount()
			if isTimer(timers) then mensagem("Ops!", "Aguarde um pouco!", "warning") return end
			if tonumber(katt) < 9 then
				katt = katt + 1
				triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GANGS", "smkcig_prtl", 4000, false, false)
				timers = setTimer(function()
				end,3000,1)
				me("Fumando ".. getItemName(haszItem):gsub('cigarro', 'cigarro').. '')
				local linha = math.random(1, 255 )
				
				if haszItem == 144 then
				--[[
				if tonumber(getElementHealth(localPlayer)or 0) + 10 < 100 then
				setElementHealth(localPlayer, getElementHealth(localPlayer) + 10)
				exports.bgo_hud:drawNote("Vida"..linha.."", "+10 Vida", 255, 255, 255, 7000)
				else
				setElementHealth(localPlayer, 100)
				end]]--
				
				if tonumber(getPedArmor(localPlayer)or 0) + 5 < 100 then
				setPedArmor(localPlayer, getPedArmor(localPlayer) + 5)
				exports.bgo_hud:drawNote("Colete"..linha.."", "+5 Colete", 255, 255, 255, 7000)
				else
				setPedArmor(localPlayer, 100)
				end					
				end
				
				if tonumber(getElementData(localPlayer, "char:vicio")or 0) + 1 < 100 then
				setElementData(localPlayer, "char:vicio", tonumber(getElementData(localPlayer, "char:vicio") or 0) + 1)
				exports.bgo_hud:drawNote("Vicio"..linha.."", "+1 Vicio em "..getItemName(haszItem):gsub('cigarro', 'cigarro').." ", 255, 255, 255, 7000)
				else
				setElementData(localPlayer, "char:vicio", 100)
				end
				
			else
				triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
				lastClick = getTickCount()
				setElementData(localPlayer, "Comendo", false)
				removeEventHandler("onClientRender",getRootElement(),smokeRender)
				katt = 0
			end
		end	
		if getKeyState("mouse2") and lastClick+200 <=getTickCount() then
			lastClick = getTickCount()
			triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "carry", "putdwn", 1000, false, false)
			triggerServerEvent('btcMTA->#createAttachObj', localPlayer, localPlayer, haszItem, false, true)
			me("Deixa cair um objeto no chão (".. getItemName(haszItem)..")")
			exports["bgo_death"]:disableLSD()
			katt = 0			
			setElementData(localPlayer, "Comendo", false)
			removeEventHandler("onClientRender",getRootElement(),smokeRender)
		end
	else
		dxDrawImage(monitorSize[1]/2 - width/2+120,actionPosY-height+10-50,box[1],box[2],"files/items/"..haszItem..".png")
	end

	dxDrawImage(monitorSize[1]/2 - width/2+40,actionPosY-height-height-20,box2[1],box2[2],"img/1.png")
	dxDrawImage(monitorSize[1]/2 - width/2+180,actionPosY-height-height-20,box2[1],box2[2],"img/2.png")
	dxDrawRectangle(monitorSize[1]/2 - width/2+40,actionPosY-height+10,box3[1],box3[2],tocolor(0,0,0,150))
	dxDrawText("Fumar",monitorSize[1]/2 - width/2+10,actionPosY-height+10-35,0,0,tocolor(255,255,255,255),1,"default-bold")
	dxDrawText("Fescartar",monitorSize[1]/2 - width/2+235,actionPosY-height+10-35,0,0,tocolor(255,255,255,255),1,"default-bold")
	dxDrawRectangle(monitorSize[1]/2 - width/2+42,actionPosY-height+10+1.6,box3[1]*(katt*10)/100,box3[2]-4,tocolor(136,211,115,150))
	dxDrawText((katt*10).."%",monitorSize[1]/2 - width/2+130,actionPosY-height+10+7,0,0,tocolor(255,255,255,255),1,"default-bold")

end

function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x,y,w+1,1,color,true) -- Fent
	dxDrawRectangle(x,y+1,1,h,color,true) -- Bal Oldal
	dxDrawRectangle(x+1,y+h,w,1,color,true) -- Lent Oldal
	dxDrawRectangle(x+w,y+1,1,h,color,true) -- Jobb Oldal
end

-- function outputLoss(loss)
    -- if getElementModel(source) == 1631 then 
		-- local newHealth = getElementHealth(source) - 10
		-- setElementHealth(getElementData(source, 'obj >> element'), newHealth)
		-- if newHealth <= 0 then 
			-- triggerServerEvent('btcMTA->#createShield', getElementData(getElementData(source, 'obj >> element'), 'obj >> player'), getElementData(getElementData(source, 'obj >> element'), 'obj >> player'))
			-- modositItemCountIfWant(itemids, slots)
		-- end
	-- end
-- end
-- addEventHandler("onClientObjectDamage", root, outputLoss)


--[[

addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), 
function (weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if weapon == 17 and getElementType(localPlayer)=="player" then 
		modositItemCountIfWant(itemids, slots)
	elseif weapon == 23 and getElementType(localPlayer)=="player" then 
		local px, py, pz = getElementPosition(localPlayer)
		local distance = getDistanceBetweenPoints3D(hitX, hitY, hitZ, px, py, pz)
		
		if (distance<10) then
			fxAddSparks(hitX, hitY, hitZ, 1, 1, 1, 1, 10, 0, 0, 0, true, 3, 1)
		end
		playSoundFrontEnd(38)
		-- triggerServerEvent("tazerFired", localPlayer, hitX, hitY, hitZ, hitElement) 
	end
end)
]]--




function modositItemCountIfWant(itemID, slot)
	local count = 0
	-- if itemTable[getItemType(itemID)] and itemTable[getItemType(itemID)][slot] then 
		if tonumber(itemTable[getItemType(itemID)][slot]['count'] or 0) > 1 then
			count = tonumber(itemTable[getItemType(itemID)][slot]['count']) - 1
			-- triggerServerEvent("btcMTA->#setSlotCount", getLocalPlayer(), getLocalPlayer(), getItemType(itemID), slot, itemTable[getItemType(itemID)][slot]['value'] or 0, itemTable[getItemType(itemID)][slot]['count'] or 0, itemTable[getItemType(itemID)][slot]['duty'] or 0, itemTable[getItemType(itemID)][slot]['actionSlot'] or 0, itemID)
			setSlotCount(slot, count, itemID, itemTable[getItemType(itemID)][slot]['duty'] or 0)
		else
			itemTable[getItemType(itemID)][slot] = {-1,-1,-1,-1}
			triggerServerEvent("btcMTA->#deleteItem", getLocalPlayer(), getLocalPlayer(), getItemType(itemID), slot)
			

			
		end
	-- end
end

