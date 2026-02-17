if fileExists("sourceC.lua") then
	fileDelete("sourceC.lua")
end	

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)

local dgs = exports.dgs
--[[
local sx,sy = guiGetScreenSize()
local ax,ay = 1360,768
function gps(s,p)
  return sp/100
end

function getPercent(h,s)
local calc = h/s
local pct = calc100
    return gps(sx,pct)
end
]]--


local hora = 0
local chamada = 0
local minuto = 0
local Emchamada = false	
	
local monitorScreen = {guiGetScreenSize()}
local loadedPhoneInterFace = false
local actualPhoneID = -1
local menu = -1
local createdGuis = {}
local iconSize = {sx*35, sy*38}
local settingsMenu = {"Fundo", "Alarmes"}

local batteryState = -1

local showPhone = false
local numberTable = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"}
local numberText = {}
setElementData(localPlayer, "char:check", false) 
local menuNames = {"settings", "servicos", "comic"}
local alsoMenu = {"phone", "news_alt", "contacts2"}
local alsoMenu2 = {"sms"}
----------------


local rot = 0 
local rot2 = 0 
local rotObj = 0
local rotInicio = 0
local maxElem = 8
local nextPage = 0


local nextPageMessage = 0
local maxElemMessage = 6

local nextPageContact = 0
local maxElemContact = 6		
			
local celular_Table = {
	{"Chamar Staff", "staff"},
	{"Policia", "policia"}, 
	{"Taxi", "taxi"}, 
	{"BGO - Resgate", "resgate"}, 
	{"Mecânico", "mec"}, 
	{"DRVV - Detran", "drvv"}, 
}

local celularobjetos_Table = {
	{"Caixa de som na mão",""},
	{"Caixa na mão",""},
	{"Flor na mão",""},
	{"Guarda chuva na mão",""},
	
	{"Barraca Lanche",""},

}


--[[]]--
local phoneContacts = {}
local currentContactPos = -3
local addContact = false
local editContact = false
local editContactNumber = -1
local editContactID = -1
----------------
--[[SMS]]--
local chats = {}
local messages = {}
local currentChat = -1
local currentChatPos = -3
local currentMessagePos = -3
----------------
--[[]]--
local callMessages = {}
local callNumber = {}
local currentCallMSG = -3
local numberCall = -1
local inCallMember = nil
----------------
--[[]]--
local sounds = {}
local currentRing = -1
local musicID = -1
local sound = nil
for i = 1, 10 do
	sounds[#sounds + 1] = {"files/sounds/call/" .. i .. ".mp3"}
end
----------------
--[[]]--
local bgImgSize = {178, 388}
local optionWallpaperSize = {50, 70}
local wallpapers = {}
local wallPaperID = -1
local maxImage = 9
for i = 1, 9 do
	wallpapers[#wallpapers + 1] = {"files/wallpapers/" .. i .. ".png"}
end
----------------
function isSoundFinished(theSound)
    if (getSoundPosition(theSound) == getSoundLength(theSound)) then
		return true
	else
		return false
	end
end

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

addEventHandler("onClientResourceStart", resourceRoot, function()
	local txd = engineLoadTXD("cellphone.txd")
	engineImportTXD(txd, 330)
	local dff = engineLoadDFF("cellphone.dff")
	engineReplaceModel(dff, 330)
end)


local starttime = 0
local starttimeNubank = 0
function showPhoneFunction(itemValue)
	if showPhone then
		showPhone = false
		loadedPhoneInterFace = false
		actualPhoneID = -1
		menu = -1
		currentChat = -1
		musicID = -1
		rot = 0
		rot2 = 0 
		rotObj = 0

		rotInicio = 0
		Emchamada = false	
		if isElement(sound) then
			stopSound(sound)
		end			
		triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
		if isTimer(chamada2) then
		killTimer(chamada2)
		end
		guiSetInputMode("no_binds_when_editing")
						 
		fac = nil	
		windowClosed()
		createGuis("destroy")
		local Block = getElementData(localPlayer, "Animando")
		if not Block then
		triggerServerEvent("tiraranimacao", localPlayer, localPlayer) 		
		else
		triggerServerEvent("BTCdroid.stopAnimation", localPlayer, localPlayer)
	end
	
	else
	
	triggerServerEvent("abrircelular", localPlayer)	
	triggerServerEvent("BTCdroid.startAnimation2", localPlayer, localPlayer)
	triggerServerEvent("BTCdroid.startAnimation", localPlayer, localPlayer)
	
	
		Emchamada = false	
		if isTimer(chamada2) then
		killTimer(chamada2)
		end
		createGuis("destroy")
		guiSetInputMode("no_binds_when_editing")
		showPhone = true
		inCallMember = nil
		actualPhoneID = itemValue
		rot = 0
		rot2 = 0 
		rotObj = 0

		rotInicio = 0
		starttime = getTickCount()
		starttimeNubank = getTickCount()
		starttimeinicio = getTickCount()
		triggerServerEvent("getPhoneDataFromServer", localPlayer, localPlayer, actualPhoneID)
		triggerServerEvent("getPhoneContactFromServer", localPlayer, localPlayer, actualPhoneID)	
		--triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)			
		menu = 1
		numberText = {}
		callMessages = {}
		phoneContacts = {}
		currentCallMSG = -3							 
		fac = nil	
		windowClosed()
	end
end
addEvent("Celular", true)
addEventHandler("Celular", getRootElement(), showPhoneFunction)

function convertTime ( ms ) 
    local min = math.floor ( ms / 60000 ) 
    local sec = math.floor ( ( ms / 1000 ) % 60 ) 
    return min, sec 
end 

function showPhoneFunctionOFF()
	if showPhone then
		showPhone = false
		loadedPhoneInterFace = false
		actualPhoneID = -1
		menu = -1
		currentChat = -1
		musicID = -1

		if isElement(sound) then
			stopSound(sound)
		end	
		triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
	end
end
addEvent("CelularOFF", true)
addEventHandler("CelularOFF", getRootElement(), showPhoneFunctionOFF)


function getPhoneDataToClient(wallpaper, music)
	wallPaperID = tonumber(wallpaper)
	musicID = tonumber(music)
	batteryState = 100 --battery
	loadedPhoneInterFace = true
end
addEvent("getPhoneDataToClient", true)
addEventHandler("getPhoneDataToClient", getRootElement(), getPhoneDataToClient)

function getNumber(phoneNumber)
	if tonumber(phoneNumber) then
		for k, v in ipairs(phoneContacts) do
			if (tonumber(v[2]) == tonumber(phoneNumber)) then
				return v[1] .. " - " .. v[2]
			end
		end
		return phoneNumber
	end
end
	
function renderPhone()
	if not showPhone or not loadedPhoneInterFace then
		return
	end
	pX, pY = sx*1150, sy*200
	rotInicio = rotInicio + 4
	if ( rotInicio >= 255 ) then 
		rotInicio = 255
	end 	
	dxDrawImage(sx*1150, sy*200,sx*210, sy*410, "files/telefon.png", 0, 0, 0, tocolor(255,255,255,rotInicio), true)
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(255,255,255,rotInicio), false)
 	if getTickCount()-starttimeinicio >= 900 then
	dxDrawImage(sx*1150, sy*202,sx*210, sy*410, "files/telefon.png", 0, 0, 0, tocolor(0,0,0,155))
	dxDrawImage(sx*1150, sy*200,sx*210, sy*410, "files/telefon.png", 0, 0, 0, tocolor(255,255,255,255), true)
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(255,255,255,255), false)

		

	if (tonumber(menu) == 1) then	

--[[
		for k, v in pairs(alsoMenu2) do
		if isInSlot(sx*1130+k*(sx*52.5)+sx*k,sy*400,iconSize[1],iconSize[2]) then
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*401,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(0,0,0,215))
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*400,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(255,255,255,215))
		else
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*401,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(0,0,0,225))
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*400,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(255,255,255,255))
		end
		end]]--
		
		
		for k, v in pairs(alsoMenu) do
		if isInSlot(sx*1130+k*(sx*52.5)+sx*k,sy*500,iconSize[1],iconSize[2]) then
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*501,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(0,0,0,215))
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*500,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(255,255,255,215))
		else
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*501,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(0,0,0,225))
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*500,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(255,255,255,255))
		end
		end

		for k, v in pairs(menuNames) do
		if isInSlot(sx*1130+k*(sx*52.5)+sx*k,sy*450,iconSize[1],iconSize[2]) then
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*451,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(0,0,0,215))
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*450,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(255,255,255,215))
		else
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*451,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(0,0,0,225))
		dxDrawImage(sx*1130+k*(sx*52.5)+sx*k,sy*450,iconSize[1],iconSize[2], "files/icons/"..v.. ".png",0, 0, 0, tocolor(255,255,255,255))
		end
		end	
	elseif (tonumber(menu) == 2) then
		dxDrawImage(sx*1152, sy*202,sx*210, sy*405, "files/call.png", angle, 0, -120, tocolor(255,255,255,255), false)	
		dxDrawImage(sx*1297,sy*281,sx*19, sy*18, 'files/delete.png', angle, 0, 90, tocolor(255,255,255,200), true)
		dxDrawText(table.concat(numberText),sx*2470, sy*580, sx/2, 0,tocolor(255,255,255,235),sy/1,"default-bold","center", "center",false,false,false,true)
		if isInSlot(sx*1237,sy*491,iconSize[1],iconSize[2]) then
		dxDrawImage(sx*1237,sy*491,iconSize[1],iconSize[2], "files/icons/ligar.png",0, 0, 0, tocolor(255,255,255,225))
		else
		dxDrawImage(sx*1237,sy*491,iconSize[1],iconSize[2], "files/icons/ligar.png",0, 0, 0, tocolor(255,255,255,240))
		end			
		elseif (tonumber(menu) == 3) then
		rot = rot + 4
		if ( rot >= 255 ) then 
			rot = 255
		end 
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/fundo.png", 0, 0, 0, tocolor(255,255,255,255), false)
		dxDrawImage(sx*1155, sy*201,sx*200, sy*410, "files/nubank/nubankinicio.png", 0, 0, 0, tocolor(0,0,0,rot), false)
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/nubankinicio.png", 0, 0, 0, tocolor(255,255,255,rot), false)
		
		if getTickCount()-starttimeNubank >= 2000 then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/nubank.png", 0, 0, 0, tocolor(255,255,255,255), false)		
		rot2 = rot2 + 4
		if ( rot2 >= 255 ) then 
			rot2 = 255
		end 
		
		if isInSlot(sx*1223, sy*360,sx*65, sy*65) then
		dxDrawImage(sx*1223, sy*361,sx*65, sy*65, "files/nubank/enviar.png", 0, 0, 0, tocolor(0,0,0,120), false)
		dxDrawImage(sx*1223, sy*360,sx*65, sy*65, "files/nubank/enviar.png", 0, 0, 0, tocolor(255,255,255,220), false)
		else
		dxDrawImage(sx*1223, sy*360,sx*65, sy*65, "files/nubank/enviar.png", 0, 0, 0, tocolor(255,255,255,rot2), false)
		end

		
		if isInSlot(sx*1223, sy*450,sx*65, sy*65) then
		dxDrawImage(sx*1223, sy*451,sx*65, sy*65, "files/nubank/transferir.png", 0, 0, 0, tocolor(0,0,0,120), false)
		dxDrawImage(sx*1223, sy*450,sx*65, sy*65, "files/nubank/transferir.png", 0, 0, 0, tocolor(255,255,255,220), false)
		else
		dxDrawImage(sx*1223, sy*450,sx*65, sy*65, "files/nubank/transferir.png", 0, 0, 0, tocolor(255,255,255,rot2), false)
		end
	end
	elseif (tonumber(menu) == 12) then
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/nubank.png", 0, 0, 0, tocolor(255,255,255,255), false)
	rot2 = rot2 + 4
	if ( rot2 >= 255 ) then 
		rot2 = 255
	end 
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/fundo2.png", 0, 0, 0, tocolor(255,255,255,rot2), false)
	dxDrawImage(sx*1155, sy*110,sx*200, sy*410, "files/nubank/linha.png", 0, 0, 0, tocolor(255,255,255,rot2), false)	
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/linha.png", 0, 0, 0, tocolor(255,255,255,rot2), false)
	if isInSlot(sx*1197,sy*433, sx*121,sy*36) then
	dxDrawImage(sx*1197,sy*433, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(0, 0, 0, 155))
	dxDrawImage(sx*1197,sy*432, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 155))
	dxDrawText("Enviar",sx*2515, sy*900, sx/2, 0,tocolor(0,0,0,190),sy/1,"default-bold","center", "center",false,false,false,true)
	else
	dxDrawImage(sx*1197,sy*433, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(0, 0, 0, 255))
	dxDrawImage(sx*1197,sy*432, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 255))
	dxDrawText("Enviar",sx*2515, sy*900, sx/2, 0,tocolor(0,0,0,170),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	if isInSlot(sx*1237,sy*493, sx*36,sy*36) then
	dxDrawImage(sx*1237,sy*493, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(0, 0, 0, 255))
	dxDrawImage(sx*1237,sy*492, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(255, 255, 255, 255))
	else
	dxDrawImage(sx*1237,sy*493, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(0, 0, 0, 55))
	dxDrawImage(sx*1237,sy*492, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(255, 255, 255, 255))
	end
	if not isElement(createdGuis[1]) then
		return
	end
	if not isElement(createdGuis[2]) then
		return
	end	
	local addNubankTable = {guiGetText(createdGuis[1]),guiGetText(createdGuis[2])}
	for i = 1, 2 do		
	dxDrawText(addNubankTable[i],sx*2510, sy*423+i*(sy*176), sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	elseif (tonumber(menu) == 13) then
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/nubank.png", 0, 0, 0, tocolor(255,255,255,255), false)
	rot2 = rot2 + 4
	if ( rot2 >= 255 ) then 
		rot2 = 255
	end 	
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/fundo2.png", 0, 0, 0, tocolor(255,255,255,rot2), false)
	dxDrawImage(sx*1155, sy*110,sx*200, sy*410, "files/nubank/linha.png", 0, 0, 0, tocolor(255,255,255,rot2), false)	
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/nubank/linha.png", 0, 0, 0, tocolor(255,255,255,rot2), false)
	if isInSlot(sx*1197,sy*433, sx*121,sy*36) then
	dxDrawImage(sx*1197,sy*433, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(0, 0, 0, 155))
	dxDrawImage(sx*1197,sy*432, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 155))
	dxDrawText("Enviar",sx*2515, sy*900, sx/2, 0,tocolor(0,0,0,190),sy/1,"default-bold","center", "center",false,false,false,true)
	else
	dxDrawImage(sx*1197,sy*433, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(0, 0, 0, 255))
	dxDrawImage(sx*1197,sy*432, sx*121,sy*36, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 255))
	dxDrawText("Enviar",sx*2515, sy*900, sx/2, 0,tocolor(0,0,0,170),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	if isInSlot(sx*1237,sy*493, sx*36,sy*36) then
	dxDrawImage(sx*1237,sy*493, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(0, 0, 0, 255))
	dxDrawImage(sx*1237,sy*492, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(255, 255, 255, 255))
	else
	dxDrawImage(sx*1237,sy*493, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(0, 0, 0, 55))
	dxDrawImage(sx*1237,sy*492, sx*36,sy*36, "files/nubank/voltar.png", 0,0,0, tocolor(255, 255, 255, 255))
	end
	if not isElement(createdGuis[1]) then
		return
	end
	if not isElement(createdGuis[2]) then
		return
	end	
	local addNubankTable = {guiGetText(createdGuis[1]),guiGetText(createdGuis[2])}
	for i = 1, 2 do		
	dxDrawText(addNubankTable[i],sx*2510, sy*423+i*(sy*176), sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	elseif (tonumber(menu) == 4) then
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)

	if addContact or editContact then
	if not isElement(createdGuis[1]) then
			return
	end
	if not isElement(createdGuis[2]) then
		return
	end	
	local addContactTable = {"Telefone: ", guiGetText(createdGuis[1]), "Nome: ", guiGetText(createdGuis[2])}
	for i = 1, 4 do		
	dxDrawRectangle(sx*1175.5,sy*215+i*(sy*32), sx*161,sy*30, tocolor(0,0,0,120))
	dxDrawText(addContactTable[i],sx*2510, sy*465+i*(sy*62), sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	if isInSlot(sx*1175.5,sy*495, sx*161,sy*30) then
	dxDrawRectangle(sx*1175.5,sy*495, sx*161,sy*30, tocolor(0,0,0,160))
	dxDrawText("Aplicar",sx*2510, sy*1020, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
	else
	dxDrawRectangle(sx*1175.5,sy*495, sx*161,sy*30, tocolor(0,0,0,210))
	dxDrawText("Aplicar",sx*2510, sy*1020, sx/2, 0,tocolor(255,255,255,235),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	else
	local contactsCounter = 0
			for k, v in ipairs(phoneContacts) do
				--if k >= currentContactPos then
					--if k <= (currentContactPos + (5)) and v then
					
				if (k > nextPageContact and contactsCounter < maxElemContact) and v then
						chatY = sy*245+contactsCounter*(sy*44)
						dxDrawRectangle(sx*1175.5, chatY, sx*161,sy*43, tocolor(0,0,0,200), true)	
						dxDrawText(v[1],sx*2510, sy*510+contactsCounter*(sy*87), sx/2, 0,tocolor(255,255,255,235),sy/1.12,"default", "center", "center", false, false, true, false)	
						dxDrawImage(sx*1190.5,chatY+sy*20,sx*15,sy*15,"files/send.png", 0, 0, 0, tocolor(255,255,255,255), true)
						dxDrawImage(sx*1230.5,chatY+sy*20,sx*15,sy*15,"files/calls.png", 0, 0, 0, tocolor(255,255,255,255), true)
						dxDrawImage(sx*1270,chatY+sy*20,sx*15,sy*15,"files/edit.png", 0, 0, 0, tocolor(255,255,255,255), true)	
						dxDrawImage(sx*1305,chatY+sy*20,sx*15,sy*15,"files/x.png", 0, 0, 0, tocolor(255,255,255,255), true)												
						contactsCounter = contactsCounter + 1
					--end
				end
			end
	if isInSlot(sx*1295,sy*520, sx*31,sy*30) then
			dxDrawImage(sx*1295,sy*521, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(0,0,0,135))
			dxDrawImage(sx*1295,sy*520, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(255,255,255,135))
	else
			dxDrawImage(sx*1295,sy*521, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(0,0,0,235))
			dxDrawImage(sx*1295,sy*520, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(255,255,255,235))
		end
	end
	elseif (tonumber(menu) == 5) then
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)
	elem = 0
	for index, value in ipairs (celular_Table) do 
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			if not isInSlot(sx*1220,sy*215+elem*(sy*42), sx*121,sy*35) then					
				dxDrawImage(sx*1175,sy*216+elem*(sy*42), sx*35,sy*40, "files/scs/"..value[2]..".png", 0,0,0, tocolor(0, 0, 0, 255))
				dxDrawImage(sx*1175,sy*215+elem*(sy*42), sx*35,sy*40, "files/scs/"..value[2]..".png", 0,0,0, tocolor(255, 255, 255, 255))
				dxDrawImage(sx*1220,sy*215+elem*(sy*42), sx*121,sy*35, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 255))
			else
				dxDrawImage(sx*1175,sy*216+elem*(sy*42), sx*35,sy*40, "files/scs/"..value[2]..".png", 0,0,0, tocolor(0, 0, 0, 215))
				dxDrawImage(sx*1175,sy*215+elem*(sy*42), sx*35,sy*40, "files/scs/"..value[2]..".png", 0,0,0, tocolor(255, 255, 255, 215))
				dxDrawImage(sx*1220,sy*215+elem*(sy*42), sx*121,sy*35, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 210))
			end				
			dxDrawText("#000000"..value[1], sx*2566, sy*465+elem*(sy*84), sx/2, 0, tocolor(0, 0, 0, 255), sy/1, "default", "center", "center", false, false, false, true)
		end	
	end
	elseif (tonumber(menu) == 6) then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)
		rot = rot + 2
		if ( rot >= 255 ) then 
			rot = 0 
		end 
		dxDrawText(numberCall,sx*2510, sy*654, sx/2, 0, tocolor(255, 255, 255, 255), sy/0.8, "default", "center", "center", false, false, true, true)											
		dxDrawText("LIGAÇÃO\nEM ANDAMENTO",sx*2510, sy*854, sx/2, 0, tocolor(255, 255, 255, rot), sy/0.9, "default", "center", "center", false, false, true, true)
		if isInSlot(sx*1190,sy*515,sx*42,sy*41) then
		dxDrawImage(sx*1190,sy*515,sx*42,sy*41, "files/icons/ligar.png",0, 0, 0, tocolor(255,255,255,205))
		else
		dxDrawImage(sx*1190,sy*515,sx*42,sy*41, "files/icons/ligar.png",0, 0, 0, tocolor(255,255,255,220))
		end
		if isInSlot(sx*1273,sy*510,sx*51,sy*51) then
		dxDrawImage(sx*1273,sy*510,sx*51,sy*51, "files/icons/encerrar.jpg",0, 0, 0, tocolor(255,255,255,205))
		else
		dxDrawImage(sx*1273,sy*510,sx*51,sy*51, "files/icons/encerrar.jpg",0, 0, 0, tocolor(255,255,255,220))
		end
		elseif (tonumber(menu) == 7) then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)
		rot = rot + 2
		if ( rot >= 255 ) then 
			rot = 0 
		end 
		dxDrawText(numberCall,sx*2510, sy*654, sx/2, 0, tocolor(255, 255, 255, 255), sy/0.8, "default", "center", "center", false, false, true, true)											
		if Emchamada == false then
		dxDrawText("LIGANDO...",sx*2510, sy*854, sx/2, 0, tocolor(255, 255, 255, rot), sy/0.9, "default", "center", "center", false, false, true, true)
		else
		if tonumber(hora) < 1 then
		dxDrawText(""..minuto..":"..chamada.."",sx*2510, sy*854, sx/2, 0, tocolor(255, 255, 255, rot), sy/0.9, "default", "center", "center", false, false, true, true)			
		else
		dxDrawText(""..hora..":"..minuto..":"..chamada.."",sx*2510, sy*854, sx/2, 0, tocolor(255, 255, 255, rot), sy/0.9, "default", "center", "center", false, false, true, true)			
		end
		end
		if isInSlot(sx*1230,sy*491,sx*51,sy*51) then
		dxDrawImage(sx*1230,sy*491,sx*51,sy*51, "files/icons/encerrar.jpg",0, 0, 0, tocolor(255,255,255,225))
		else
		dxDrawImage(sx*1230,sy*491,sx*51,sy*51, "files/icons/encerrar.jpg",0, 0, 0, tocolor(255,255,255,240))
		end	
		elseif (tonumber(menu) == 8) then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/objetos/fundo.png", 0, 0, 0, tocolor(255,255,255,255), false)
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, "files/objetos/lobo.png", 0, 0, 0, tocolor(255,255,255,255), false)
		rotObj = rotObj + 1
		if ( rotObj >= 200 ) then 
			rotObj = 200
		end 
		dxDrawImageSection(sx*1255, sy*415, sx*70, sy*-(55*(rotObj/100)), 0, 0, sy*350, sy*-(195*(rotObj/100)), "files/objetos/obj.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if getTickCount()-starttime >= 3000 then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)
		elem = 0
		for index, value in ipairs (celularobjetos_Table) do 
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1
				if not isInSlot(sx*1175.5,sy*215+elem*(sy*42), sx*161,sy*30) then					
					--dxDrawRectangle(sx*1175.5,sy*215+elem*(sy*42), sx*161,sy*30, tocolor(255, 255, 255, 255))
					dxDrawImage(sx*1175.5,sy*215+elem*(sy*42), sx*161,sy*30, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 255))
				else
					--dxDrawRectangle(sx*1175.5,sy*215+elem*(sy*42), sx*161,sy*30, tocolor(255, 255, 255, 210))
					dxDrawImage(sx*1175.5,sy*215+elem*(sy*42), sx*161,sy*30, "files/botao.png", 0,0,0, tocolor(255, 255, 255, 210))
				end				
				dxDrawText("#000000"..value[1], sx*2510, sy*460+elem*(sy*83), sx/2, 0, tocolor(0, 0, 0, 255), sy/1, "default", "center", "center", false, false, false, true)
			end	
		end
	end
	elseif (tonumber(menu) == 9) then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)
		if isInSlot(sx*1237,sy*550,iconSize[1],iconSize[2]) then
		dxDrawImage(sx*1237,sy*551,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(0,0,0,245), true)
		dxDrawImage(sx*1237,sy*550,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(255,255,255,225), true)
		else
		dxDrawImage(sx*1237,sy*551,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(0,0,0,255), true)
		dxDrawImage(sx*1237,sy*550,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(255,255,255,240), true)
		end
	
		for k, v in ipairs(settingsMenu) do
		if isInSlot(sx*1175.5,sy*215+k*(sy*42), sx*161,sy*30) then
		dxDrawRectangle(sx*1175.5,sy*215+k*(sy*42), sx*161,sy*30, tocolor(0,0,0,120))
		dxDrawText(v,sx*2510, sy*465+k*(sy*80), sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		else
		dxDrawRectangle(sx*1175.5,sy*215+k*(sy*42), sx*161,sy*30, tocolor(0,0,0,150))
		dxDrawText(v,sx*2510, sy*465+k*(sy*80), sx/2, 0,tocolor(255,255,255,235),sy/1,"default-bold","center", "center",false,false,false,true)
		end
	end
	elseif (tonumber(menu) == 10) then
		dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[currentChooser][1], 0, 0, 0, tocolor(255,255,255,255), false)
		if isInSlot(sx*1237,sy*550,iconSize[1],iconSize[2]) then
		dxDrawImage(sx*1237,sy*551,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(0,0,0,245), true)
		dxDrawImage(sx*1237,sy*550,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(255,255,255,225), true)
		else
		dxDrawImage(sx*1237,sy*551,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(0,0,0,255), true)
		dxDrawImage(sx*1237,sy*550,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(255,255,255,240), true)
		end
		if isInSlot(sx*1175.5,sy*400, sx*21,sy*20) then
		dxDrawRectangle(sx*1175.5,sy*400, sx*21,sy*20, tocolor(0,0,0,110))
		dxDrawText("<",sx*2370, sy*820, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		else
		dxDrawRectangle(sx*1175.5,sy*400, sx*21,sy*20, tocolor(0,0,0,210))
		dxDrawText("<",sx*2370, sy*820, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		end
		
		if isInSlot(sx*1315,sy*400, sx*21,sy*20) then
		dxDrawRectangle(sx*1315,sy*400, sx*21,sy*20, tocolor(0,0,0,110))
		dxDrawText(">",sx*2650, sy*820, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		else
		dxDrawRectangle(sx*1315,sy*400, sx*21,sy*20, tocolor(0,0,0,210))
		dxDrawText(">",sx*2650, sy*820, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		end		
		if isInSlot(sx*1175.5,sy*495, sx*161,sy*30) then
		dxDrawRectangle(sx*1175.5,sy*495, sx*161,sy*30, tocolor(0,0,0,160))
		dxDrawText("Aplicar",sx*2510, sy*1020, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		else
		dxDrawRectangle(sx*1175.5,sy*495, sx*161,sy*30, tocolor(0,0,0,210))
		dxDrawText("Aplicar",sx*2510, sy*1020, sx/2, 0,tocolor(255,255,255,235),sy/1,"default-bold","center", "center",false,false,false,true)
	end
	elseif (tonumber(menu) == 11) then
		for i = 1, 10 do
			if currentRing == i then
				dxDrawRectangle(sx*1175.5,sy*215+i*(sy*25), sx*161,sy*23, tocolor(0, 0, 0, 170), true) -- alsó	
				dxDrawRectangle(sx*1175.5,sy*215+i*(sy*25), sx*161,sy*23, tocolor(124, 197, 118, 170), true)
				dxDrawImage(sx*1175.5,sy*215+i*(sy*25), sx*21,sy*23, "files/music.png", 0, 0, 0, tocolor(255,255,255,255), true)
				dxDrawText("Alarme " .. i,sx*2510, sy*454+i*(sy*50), sx/2, 0, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, true, true)											
			
			else
			
				dxDrawRectangle(sx*1175.5,sy*215+i*(sy*25), sx*161,sy*23, tocolor(0,0,0, 170), true) -- alsó	
				dxDrawText("Alarme " .. i,sx*2510, sy*454+i*(sy*50), sx/2, 0, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, true, true)											
			end			
		end
		if currentRing > 0 then
		if isInSlot(sx*1175.5,sy*495, sx*161,sy*30) then
		dxDrawRectangle(sx*1175.5,sy*495, sx*161,sy*30, tocolor(0,0,0,160))
		dxDrawText("Salvar",sx*2510, sy*1020, sx/2, 0,tocolor(255,255,255,215),sy/1,"default-bold","center", "center",false,false,false,true)
		else
		dxDrawRectangle(sx*1175.5,sy*495, sx*161,sy*30, tocolor(0,0,0,210))
		dxDrawText("Salvar",sx*2510, sy*1020, sx/2, 0,tocolor(255,255,255,235),sy/1,"default-bold","center", "center",false,false,false,true)
		end
		end

	
	elseif (tonumber(menu) == 14) then
	dxDrawImage(sx*1155, sy*200,sx*200, sy*410, wallpapers[wallPaperID][1], 0, 0, 0, tocolor(0,0,0,125), false)


			
			local messageCounter = 0
			if (messages[currentChat]) then
				currentMessagePos = #messages[currentChat]
	
			dxDrawText("" .. contato,sx*2510, sy*490, sx/2, 0,tocolor(255,255,255,255),sy/1,"default-bold","center", "center",false,false,false,true)
			
			for k, v in ipairs(messages[currentChat]) do
			if (k > nextPageMessage and messageCounter < maxElemMessage) and v then
				if (tonumber(v[1]) == tonumber(actualPhoneID)) then
						boxColor = tocolor(105, 105, 105,255)
						chatY = sy*276+messageCounter*(sy*48)
						local width = dxGetTextWidth(sortores(v[4]),1,"default-bold")
						dxDrawRectangle(sx*1337, chatY, sx-sx*width-20 / 2 ,sy*40, boxColor, false)
						dxDrawText(sortores(v[4]),sx*0, sy*281+messageCounter*(sy*48), sx*1331, 0,tocolor(0,0,0,235),sy/1.2,"default-bold", "right", "top", false, true, true, true)	
						dxDrawText(sortores(v[4]),sx*0, sy*280+messageCounter*(sy*48), sx*1330, 0,tocolor(255,255,255,235),sy/1.2,"default-bold", "right", "top", false, true, true, true)		
						else
						boxColor = tocolor(54, 54, 54, 255)
						local width = dxGetTextWidth(sortores(v[4]),1,"default-bold")
						chatY = sy*276+messageCounter*(sy*48)
						dxDrawRectangle(sx*1170.5, chatY, sx*width + 20 / 2,sy*40, boxColor, false)
						dxDrawText(sortores(v[4]),sx*1176, sy*283+messageCounter*(sy*47), sx/2, 0,tocolor(0,0,0,235),sy/1.2,"default-bold", "left", "top", false, true, true, true)	
						dxDrawText(sortores(v[4]),sx*1175, sy*282+messageCounter*(sy*47), sx/2, 0,tocolor(255,255,255,235),sy/1.2,"default-bold", "left", "top", false, true, true, true)	
						end
						messageCounter = messageCounter + 1				
					end
				end	
			end
		if not isElement(edit) then
		edit = dgs:dgsCreateEdit ( 0.863, 0.734, 0.087, 0.0275, "", true, false ,tocolor(255, 255, 255, 255), 1, 1, nil ,tocolor(45, 45, 45, 255), true )
		dgs:dgsBringToFront( edit )
		dgs:dgsFocus(edit)
		dgs:dgsSetProperty(edit,"caretStyle",1)
		dgs:dgsSetProperty(edit,"padding",{6,1})
		--dgs:dgsSetProperty(edit,"typingSound","files/sounds/tecla.mp3")
		
		
		dgs:dgsSetFont ( edit, "default-bold" )
		dgs:dgsEditSetMaxLength ( edit, 50 )
		end
		--dxDrawRectangle(sx*1305.5,sy*560, sx*25,sy*27, tocolor(255,255,255,199))
		
		
		if isInSlot(sx*1305.5,sy*560, sx*25,sy*27) then
		dxDrawImage(sx*1305.5,sy*560, sx*26,sy*28, "files/icons/sms.png", 30, 0, 0, tocolor(255,255,255,155), false)
		else
		dxDrawImage(sx*1305.5,sy*560, sx*25,sy*27, "files/icons/sms.png", 30, 0, 0, tocolor(255,255,255,255), false)
		end
		
		elseif (tonumber(menu) == 15) then
			--[[
	local contactsCounter = 0
			for k, v in ipairs(phoneMensagens) do
				if (k > nextPageContact and contactsCounter < maxElemContact) and v then
						chatY = sy*245+contactsCounter*(sy*44)
						dxDrawRectangle(sx*1175.5, chatY, sx*161,sy*43, tocolor(0,0,0,200), true)	
						dxDrawText(v[1],sx*2510, sy*510+contactsCounter*(sy*87), sx/2, 0,tocolor(255,255,255,235),sy/1.12,"default", "center", "center", false, false, true, false)	
						dxDrawImage(sx*1190.5,chatY+sy*20,sx*15,sy*15,"files/send.png", 0, 0, 0, tocolor(255,255,255,255), true)
						dxDrawImage(sx*1230.5,chatY+sy*20,sx*15,sy*15,"files/calls.png", 0, 0, 0, tocolor(255,255,255,255), true)
						dxDrawImage(sx*1270,chatY+sy*20,sx*15,sy*15,"files/edit.png", 0, 0, 0, tocolor(255,255,255,255), true)	
						dxDrawImage(sx*1305,chatY+sy*20,sx*15,sy*15,"files/x.png", 0, 0, 0, tocolor(255,255,255,255), true)												
						contactsCounter = contactsCounter + 1
					--end
				end
			end
		
	if isInSlot(sx*1295,sy*520, sx*31,sy*30) then
			dxDrawImage(sx*1295,sy*521, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(0,0,0,135))
			dxDrawImage(sx*1295,sy*520, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(255,255,255,135))
	else
			dxDrawImage(sx*1295,sy*521, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(0,0,0,235))
			dxDrawImage(sx*1295,sy*520, sx*31,sy*30, "files/icons/+contact.png",10, 0, 0, tocolor(255,255,255,235))
		end
		]]--
		
	end	
		if tonumber(menu) ~= 6 and tonumber(menu) ~= 7 and tonumber(menu) ~= 10 and tonumber(menu) ~= 14 and tonumber(menu) ~= 9 and tonumber(menu) ~= 12 and tonumber(menu) ~= 13 then
			if isInSlot(sx*1237,sy*550,iconSize[1],iconSize[2]) then
			dxDrawImage(sx*1237,sy*551,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(0,0,0,245), true)
			dxDrawImage(sx*1237,sy*550,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(255,255,255,225), true)
			else
			dxDrawImage(sx*1237,sy*551,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(0,0,0,255), true)
			dxDrawImage(sx*1237,sy*550,iconSize[1],iconSize[2], "files/icons/menu.png",0, 0, 0, tocolor(255,255,255,240), true)
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), renderPhone)


	
function showMenu(number, menuid, playerSource, actualPhoneID)
	if menuid and number then
		triggerServerEvent("getPhoneDataFromServer", localPlayer, localPlayer, actualPhoneID)


		numberCall = nocontato(number)
		menu = menuid
		showPhone = true
		inCallMember = playerSource
		starttimeNubank = getTickCount()
		starttimeinicio = getTickCount()
	end
end
addEvent("showMenu", true)
addEventHandler("showMenu", getRootElement(), showMenu)

function nocontato(phoneNumber)
		for k, v in ipairs(phoneContacts) do		
			if (tonumber(v[2]) == tonumber(phoneNumber)) then
				return v[1]
			end
		end
		return "Desconhecido"
end

function Emchamada()
		Emchamada = true
		chamada = 0	
		minuto = "00"
		hora = 0
		chamada2 = setTimer(function() 
		chamada = chamada + 1
		if minuto == tonumber(minuto) then
		if minuto > 60 then
		minuto = 0
		hora = hora + 1
		if (hora < 10) then
		hora = "0"..hora
		end
		end
		end
	
		if chamada > 60 then
		chamada = 0
		minuto = minuto + 1
		if (minuto < 10) then
			minuto = "0"..minuto
		end
		end
		if (chamada < 10) then
			chamada = "0"..chamada
		end
		end, 1000, 0) 
end
addEvent("Emchamada", true)
addEventHandler("Emchamada", getRootElement(), Emchamada)


addEventHandler("onClientKey", root, function(k,s)
	if not s then return end
	if (k == "mouse_wheel_up") and tonumber(menu) == 8 and showPhone then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif (k == "mouse_wheel_down") and tonumber(menu) == 8 and showPhone then
		nextPage = nextPage + 1
		if(nextPage > #celular_Table-maxElem)then
			nextPage = #celular_Table-maxElem
		end
	end
	

	if (k == "mouse_wheel_up") and tonumber(menu) == 14 and showPhone and messages[tonumber(currentChat)]  then

		if(nextPageMessage>0)then
		
			nextPageMessage = nextPageMessage - 1
	end
	elseif (k == "mouse_wheel_down") and tonumber(menu) == 14 and showPhone and messages[tonumber(currentChat)]  then
		nextPageMessage = nextPageMessage + 1
		if(nextPageMessage > #messages[currentChat]-maxElemMessage)then
			nextPageMessage = #messages[currentChat]-maxElemMessage
		end
	end	


	
	if (k == "mouse_wheel_up") and tonumber(menu) == 5 and showPhone then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif (k == "mouse_wheel_down") and tonumber(menu) == 5 and showPhone then
		nextPage = nextPage + 1
		if(nextPage > #celular_Table-maxElem)then
			nextPage = #celular_Table-maxElem
		end
	end	
	
	
	--[[
	if (k == "mouse_wheel_up") and tonumber(menu) == 4 and showPhone then
		if #phoneContacts > 7 then
			if currentContactPos < #phoneContacts - 6 then
				currentContactPos = currentContactPos + 1	
			end 
		end
	elseif (k == "mouse_wheel_down") and tonumber(menu) == 4 and showPhone then
		if #phoneContacts > 7 then
			if currentContactPos > 1 then
				currentContactPos = currentContactPos - 1
			end
		end
		]]--
		
		
	if (k == "mouse_wheel_up") and tonumber(menu) == 4 and showPhone then
		if(nextPageContact>0)then
			nextPageContact = nextPageContact - 1
		end
	elseif (k == "mouse_wheel_down") and tonumber(menu) == 4 and showPhone then
		nextPageContact = nextPageContact + 1
		if(nextPageContact > #phoneContacts-maxElemContact)then
			nextPageContact = #phoneContacts-maxElemContact
		end	
	
	



	end		
end
)





function createGuis(name)
	pX, pY = monitorScreen[1]-550, monitorScreen[2]/2-680/2
	if name then
		if tostring(name) == "destroy" then
if isElement(edit) then
destroyElement(edit)
end
			for i = 1, 2 do
				if isElement(createdGuis[i]) then
					destroyElement(createdGuis[i])
				end
			end
		elseif tostring(name) == "call" then
			createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 27)

		elseif tostring(name) == "sms" then
			createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 10)	
			createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 30)	

		elseif tostring(name) == "sms1" then
			createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 30)	
		elseif tostring(name) == "addContact" then
			createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 10)	
			createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 20)			
		elseif tostring(name) == "enviar" then
			createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 6)	
			createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[2], 6)
		elseif tostring(name) == "trans" then
			createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[1], 6)	
			createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
			guiEditSetMaxLength(createdGuis[2], 6)				
		end
	end
end

-- createGuis("call")

function showSound()
	setTimer(function()
	local musicID = getElementData(localPlayer, "musicID") or 1 --musicID
		if musicID > 0 then
			if isElement(sound) then
				stopSound(sound)
			end	
			sound = playSound("files/sounds/call/" .. musicID .. ".mp3", true)
			--removeEventHandler("onClientRender", getRootElement(), PlayedSound)
			--addEventHandler("onClientRender", getRootElement(), PlayedSound)
		end	
	end, 50, 1)
end
addEvent("showSound", true)
addEventHandler("showSound", getRootElement(), showSound)

function PlayedSound()
	if isSoundFinished(sound) then
		sound = playSound("files/sounds/call/" .. musicID .. ".mp3")					
	end
end


function answerPhone(type)
	if (tonumber(type) == 1) then -- reject
		inCallMember = nil
		numberCall = nil
		menu = 1
		callMessages = {}
		createGuis("destroy")
		showPhone = false
		loadedPhoneInterFace = false
		actualPhoneID = -1
		menu = -1
		currentChat = -1
		musicID = -1
		Emchamada = false
		if isTimer(chamada2) then
		killTimer(chamada2)
		end
		
		if isElement(sound) then
			stopSound(sound)
		end	
		triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
		--removeEventHandler("onClientRender", getRootElement(), PlayedSound)
		if isElement(sound) then
			stopSound(sound)
		end	
		callMessages = {}
		currentCallMSG = -3
	elseif (tonumber(type) == 2) then -- accept
		menu = 8
		callMessages = {}
		createGuis("call")
		if isElement(sound) then
			stopSound(sound)
		end	
	end
end
addEvent("answerPhone", true)
addEventHandler("answerPhone", getRootElement(), answerPhone)


function abrircelular()
		if not showPhone then 
		--showPhoneFunction(getElementData(localPlayer,"char:telefone"))
		createGuis("destroy")
		guiSetInputMode("no_binds_when_editing")
		showPhone = true
		inCallMember = nil
		actualPhoneID = getElementData(localPlayer,"char:telefone")
		triggerServerEvent("getPhoneDataFromServer", localPlayer, localPlayer, actualPhoneID)
		triggerServerEvent("getPhoneContactFromServer", localPlayer, localPlayer, actualPhoneID)	
		--triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)			
		menu = 1
		numberText = {}
		callMessages = {}
		phoneContacts = {}
		currentCallMSG = -3
		end
		
		end
addEvent("abrircelular", true)
addEventHandler("abrircelular", getRootElement(), abrircelular)

function onPhoneClick(button, state)
	if (button == "left") and (state == "down") and (showPhone) and loadedPhoneInterFace then
		if isInSlot(sx*1237,sy*550,iconSize[1],iconSize[2]) and not editContact and menu ~= 7 and menu ~= 12 and menu ~= 13 and menu ~= 14 then
			menu = 1
			currentChat = -1
			chats = {}
			editContactNumber = -1		
			addContact = false 
			editContactID = -1
			rot = 0
			rot2 = 0 
			rotObj = 0
			--removeEventHandler("onClientRender", getRootElement(), PlayedSound)
			if isElement(sound) then
				stopSound(sound)
			end	
			callMessages = {}
			currentCallMSG = -3
			createGuis("destroy")
			triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)	
		end
		if (tonumber(menu) == 1) then
		
			for k, v in pairs(alsoMenu2) do
				if isInSlot(sx*1130+k*(sx*52.5)+sx*k,sy*400,iconSize[1],iconSize[2]) then
					menu = 15
					triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)												
				end
			end	
			
			
			for k, v in pairs(alsoMenu) do
				if isInSlot(sx*1130+k*(sx*52.5)+sx*k,sy*500,iconSize[1],iconSize[2]) then
					menu = tonumber(k) + 1
					

					if (tonumber(k) == 2) then
					starttimeNubank = getTickCount()
					rot = 0
					rot2 = 0 
					rotObj = 0
					antiSpam = setTimer(function() end,2000,1)
					end
					
				
					
					if (tonumber(menu) == 14) then
						triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)							
						--triggerServerEvent("getChatFromServer", localPlayer, localPlayer, actualPhoneID)
						
						--createGuis("sms")	
					end
					
				end
			end	


			for k, v in pairs(menuNames) do
			if isInSlot(sx*1130+k*(sx*52.5)+sx*k,sy*450,iconSize[1],iconSize[2]) then
			if tonumber(menu) == 1 then
			if v == "settings" then
			menu = 9
			elseif v == "servicos" then
			menu = 5
			elseif v == "comic" then
			starttime = getTickCount()
			menu = 8
			end
			end
			end
			end
			
			
			
			
			
		elseif (tonumber(menu) == 14) then

				--if isInSlot(sx*1175.5,sy*555, sx*131,sy*30) then
				--print("aa")
					--if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
					--	guiBringToFront(createdGuis[1])
					--end
				--end	
				if isInSlot(sx*1305.5,sy*560, sx*25,sy*27) then
					if tonumber(currentChat) > 0 then
						if string.len(dgs:dgsGetText(edit)) > 2 then
							triggerServerEvent("sendMessagesInServer", localPlayer, localPlayer, actualPhoneID, currentChat, dgs:dgsGetText(edit), getTime(), getDate())
							dgs:dgsSetText (edit, "" )
							--createGuis("destroy")
							--createGuis("sms")
							--setElementData(localPlayer, "char:money", getElementData(localPlayer, "char:money") - 3)
						end
					end
				end				

			
			
			
			
			
			
			
			
			elseif tonumber(menu) == 5 then
			elem = 0
			for index, value in ipairs (celular_Table) do
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1			
				if isInSlot(sx*1220,sy*215+elem*(sy*42), sx*121,sy*35) then 
				if value[1] == "Policia" then
				--triggerServerEvent('SendMsgToTeamPolicia', localPlayer, localPlayer, "Prioridade")
				
				chamadaNumero("Policia")
				fac = "Policia"
				elseif value[1] == "Taxi" then 
				chamadaNumero("taxi")
				fac = "taxi"
				--triggerServerEvent('SendMsgToTeamtaxi', localPlayer, localPlayer)
				elseif value[1] == "BGO - Resgate" then 
				
				chamadaNumero("Resgate")
				fac = "Resgate"
				--triggerServerEvent('SendMsgToTeammedic', localPlayer, localPlayer, "Prioridade")	
				elseif value[1] == "Mecânico" then 
				chamadaNumero("mecanico")
				fac = "mecanico"
				--triggerServerEvent('SendMsgToTeamMecanico', localPlayer, localPlayer)			
				elseif value[1] == "DRVV - Detran" then
				chamadaNumero("drvv")
				fac = "drvv"
				--triggerServerEvent('SendMsgToTeamDetran', localPlayer, localPlayer)		
				elseif value[1] == "Chamar Staff" then 
				chamadaNumero("Staff")
				fac = "Staff"
				--triggerServerEvent('SendMsgToTeamstaff', localPlayer, localPlayer)		
						end	
					end
				end
			end






		elseif (tonumber(menu) == 2) then
			local elem = 1
			local sor = 1	
			for k, v in ipairs(numberTable) do
		
				if isInSlot(sx*1138 + (elem*(sy*51)),sy*280 + (sor*(sy*38)),sx*32,sy*30) then
					if #numberText + 1 <= 16 then
						table.insert(numberText, v)
					end
				end
				elem = elem + 1
				if (tonumber(elem) == 4) then
					sor = sor + 1
					elem = 1
				end		
			end
			
			if isInSlot(sx*1297,sy*281,sx*19, sy*18) then
				numberText[#numberText] = nil
			end
			
			if isInSlot(sx*1237,sy*491,iconSize[1],iconSize[2]) then
				--outputChatBox("#D64541Ligando para "..type(table.concat(numberText)).." ",255,255,255,true)


				callMemberClient(table.concat(numberText))



			end	
			
		elseif (tonumber(menu) == 3) then
		if isInSlot(sx*1223, sy*360,sx*65, sy*65) and not isTimer(antiSpam) then
		createGuis("enviar")
		menu = 12
		end
		
		if isInSlot(sx*1223, sy*450,sx*65, sy*65) and not isTimer(antiSpam) then
		createGuis("trans")
		menu = 13
		end	
		
		elseif (tonumber(menu) == 12) then	

		if isInSlot(sx*1237,sy*493, sx*36,sy*36) then
					starttimeNubank = getTickCount()
					rot = 0
					rot2 = 0 
					menu = 3
					createGuis("destroy")
					antiSpam = setTimer(function() end,2000,1)
		end
		
		
		if isInSlot(sx*1197,sy*433, sx*121,sy*36) then
				local item = tonumber(guiGetText(createdGuis[2]))
				local targerplayer = tonumber(guiGetText(createdGuis[1])) 
				if ( isTimer( tempodinheiro2 ) ) then return end
				tempodinheiro2 = setTimer( function(  ) end, 1500, 1 )
					if string.find(item, "%p+") then
						exports.bgo_infobox:addNotification("Você não pode colocar caracter especial no dinheiro!","error")
						return
					end
					
					if string.find(item,"-") or string.find(item,"_") then
						exports.bgo_infobox:addNotification("Não use um sinais na quantidade ","error")
						return
					end
				triggerServerEvent("phone:enviarM",localPlayer, localPlayer, targerplayer, item);
		end
				for i = 1, 2 do	
					if isInSlot(sx*1199,sy*194+i*(sy*90), sx*117,sy*28) then
						if guiEditSetCaretIndex(createdGuis[i], string.len(guiGetText(createdGuis[i]))) then
							guiBringToFront(createdGuis[i])
						end
					end
				end	
				
				
		elseif (tonumber(menu) == 13) then	

		if isInSlot(sx*1237,sy*493, sx*36,sy*36) then
					starttimeNubank = getTickCount()
					rot = 0
					rot2 = 0 
					menu = 3
					createGuis("destroy")
					antiSpam = setTimer(function() end,2000,1)
		end
		
		
		if isInSlot(sx*1197,sy*433, sx*121,sy*36) then
				local item = tonumber(guiGetText(createdGuis[2]))
				local targerplayer = tonumber(guiGetText(createdGuis[1])) 
				if ( isTimer( tempodinheiro2 ) ) then return end
				tempodinheiro2 = setTimer( function(  ) end, 1500, 1 )
			

					if string.find(item, "%p+") then
						exports.bgo_infobox:addNotification("Você não pode colocar caracter especial no dinheiro!","error")
						return
					end
					
					if string.find(item,"-") or string.find(item,"_") then
						exports.bgo_infobox:addNotification("Não use um sinais na quantidade ","error")
						return
					end
				triggerServerEvent("phone:transM",localPlayer, localPlayer, targerplayer, item);
		end
				for i = 1, 2 do	
					if isInSlot(sx*1199,sy*194+i*(sy*90), sx*117,sy*28) then
						if guiEditSetCaretIndex(createdGuis[i], string.len(guiGetText(createdGuis[i]))) then
							guiBringToFront(createdGuis[i])
						end
					end
				end	
				
				
		elseif (tonumber(menu) == 4) then
			if addContact or editContact then
				for i = 1, 2 do	
												
					if isInSlot(sx*1175.5,sy*215+i*(sy*64), sx*161,sy*30) then
						if guiEditSetCaretIndex(createdGuis[i], string.len(guiGetText(createdGuis[i]))) then
							guiBringToFront(createdGuis[i])
						end
					end
				end			
				if isInSlot(sx*1175.5,sy*495, sx*161,sy*30) then
					if not (string.len(guiGetText(createdGuis[1])) > 1) then
						return
					end
					if not (string.len(guiGetText(createdGuis[2])) > 1) then
						return
					end
					
					if editContact then

						if string.find(guiGetText(createdGuis[1]), "%p+") then
						exports.bgo_infobox:addNotification("Não pode ter caracteres especial no contato!","error")
						return
						end
						
						if string.find(guiGetText(createdGuis[1]),"_") then
						guiSetText(createdGuis[1],"")
						exports.bgo_infobox:addNotification("Não use um sinal _ no nome do seu personagem!","error")
							return
						end
						
						
						if string.find(guiGetText(createdGuis[1]),"á") or string.find(guiGetText(createdGuis[1]),"é") or string.find(guiGetText(createdGuis[1]),"í") or string.find(guiGetText(createdGuis[1]),"ú") or string.find(guiGetText(createdGuis[1]),"ó") or string.find(guiGetText(createdGuis[1]),"?") or string.find(guiGetText(createdGuis[1]),"Á") or string.find(guiGetText(createdGuis[1]),"É") or string.find(guiGetText(createdGuis[1]),"Í") or string.find(guiGetText(createdGuis[1]),"Ó") or string.find(guiGetText(createdGuis[1]),"?") or string.find(guiGetText(createdGuis[1])," ") then
							guiSetText(createdGuis[1],"")
							exports.bgo_infobox:addNotification("Não use caracteres acentuados no nome do seu personagem.","error")
							return
						end
						
						if string.find(guiGetText(createdGuis[2]), "%p+") then
						exports.bgo_infobox:addNotification("Não pode ter caracteres especial no contato!","error")
						return
						end

						if string.find(guiGetText(createdGuis[2]),"_") then
						guiSetText(createdGuis[2],"")
						exports.bgo_infobox:addNotification("Não use um sinal _ no nome do seu personagem!","error")
							return
						end
						
						if string.find(guiGetText(createdGuis[2]),"á") or string.find(guiGetText(createdGuis[2]),"é") or string.find(guiGetText(createdGuis[2]),"í") or string.find(guiGetText(createdGuis[2]),"ú") or string.find(guiGetText(createdGuis[2]),"ó") or string.find(guiGetText(createdGuis[2]),"?") or string.find(guiGetText(createdGuis[2]),"Á") or string.find(guiGetText(createdGuis[2]),"É") or string.find(guiGetText(createdGuis[2]),"Í") or string.find(guiGetText(createdGuis[2]),"Ó") or string.find(guiGetText(createdGuis[2]),"?") or string.find(guiGetText(createdGuis[2])," ")  then
							guiSetText(createdGuis[2],"")
							exports.bgo_infobox:addNotification("Não use caracteres acentuados no nome do seu personagem.","error")
							return
						end
						
			
		
						--triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)	
						triggerServerEvent("editContactS", localPlayer, localPlayer, guiGetText(createdGuis[1]), guiGetText(createdGuis[2]), actualPhoneID, editContactNumber, editContactID)		
					else

						if #phoneContacts < 8 then
					
						if string.find(guiGetText(createdGuis[1]), "%p+") then
						exports.bgo_infobox:addNotification("Não pode ter caracteres especial no contato!","error")
						return
						end

						if string.find(guiGetText(createdGuis[1]),"_") then
						guiSetText(createdGuis[1],"")
						exports.bgo_infobox:addNotification("Não use um sinal _ no nome do seu personagem!","error")
							return
						end
						
						if string.find(guiGetText(createdGuis[1]),"á") or string.find(guiGetText(createdGuis[1]),"é") or string.find(guiGetText(createdGuis[1]),"í") or string.find(guiGetText(createdGuis[1]),"ú") or string.find(guiGetText(createdGuis[1]),"ó") or string.find(guiGetText(createdGuis[1]),"?") or string.find(guiGetText(createdGuis[1]),"Á") or string.find(guiGetText(createdGuis[1]),"É") or string.find(guiGetText(createdGuis[1]),"Í") or string.find(guiGetText(createdGuis[1]),"Ó") or string.find(guiGetText(createdGuis[1]),"?") then
							guiSetText(createdGuis[1],"")
							exports.bgo_infobox:addNotification("Não use caracteres acentuados no nome do seu personagem.","error")
							return
						end


						if string.find(guiGetText(createdGuis[2]), "%p+") then
						exports.bgo_infobox:addNotification("Não pode ter caracteres especial no contato!","error")
						return
						end

						if string.find(guiGetText(createdGuis[2]),"_") then
						guiSetText(createdGuis[2],"")
						exports.bgo_infobox:addNotification("Não use um sinal _ no nome do seu personagem!","error")
							return
						end
						
						if string.find(guiGetText(createdGuis[2]),"á") or string.find(guiGetText(createdGuis[2]),"é") or string.find(guiGetText(createdGuis[2]),"í") or string.find(guiGetText(createdGuis[2]),"ú") or string.find(guiGetText(createdGuis[2]),"ó") or string.find(guiGetText(createdGuis[2]),"?") or string.find(guiGetText(createdGuis[2]),"Á") or string.find(guiGetText(createdGuis[2]),"É") or string.find(guiGetText(createdGuis[2]),"Í") or string.find(guiGetText(createdGuis[2]),"Ó") or string.find(guiGetText(createdGuis[2]),"?") or string.find(guiGetText(createdGuis[2])," ")  then
							guiSetText(createdGuis[2],"")
							exports.bgo_infobox:addNotification("Não use caracteres acentuados no nome do seu personagem.","error")
							return
						end					
					

	
						triggerServerEvent("addContactMemberS", localPlayer, localPlayer, guiGetText(createdGuis[1]), guiGetText(createdGuis[2]), actualPhoneID)
						createGuis("destroy")
						addContact = false
						
						

		showPhone = false
		loadedPhoneInterFace = false
		actualPhoneID = -1
		menu = -1
		currentChat = -1
		musicID = -1
		rot = 0
		rot2 = 0 
		rotObj = 0

		rotInicio = 0
		Emchamada = false	
		if isElement(sound) then
			stopSound(sound)
		end			
		triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
		if isTimer(chamada2) then
		killTimer(chamada2)
		end
		guiSetInputMode("no_binds_when_editing")
						 
		fac = nil	
		windowClosed()
		createGuis("destroy")
		local Block = getElementData(localPlayer, "Animando")
		if not Block then
		triggerServerEvent("tiraranimacao", localPlayer, localPlayer) 		
		else
		triggerServerEvent("BTCdroid.stopAnimation", localPlayer, localPlayer)
		end
		
		
		
		abrircelular()
						else
						createGuis("destroy")
						addContact = false
						menu = 1
						outputChatBox("#22A7F0[Contatos] #ffffffLimite de contatos foi atingido maximo 7 contatos",255,255,255,true)
						end
					end
				end
			else
				if isInSlot(sx*1295,sy*520, sx*31,sy*30) then
					addContact = true
					createGuis("destroy")
					createGuis("addContact")
				end
				local contactsCounter = 0
				 --currentContactPos = #phoneContacts
				for k, v in ipairs(phoneContacts) do
					--if k >= currentContactPos then
					if (k > nextPageContact and contactsCounter < maxElemContact) and v then
						--if k <= (currentContactPos + (6)) and v then
						chatY = sy*245+contactsCounter*(sy*44)
							if isInSlot(sx*1230.5,chatY+sy*20,sx*15,sy*15) then
								callMemberClient(v[2])
							end
							
						
							if isInSlot(sx*1190.5,chatY+sy*20,sx*15,sy*15) then
							if getElementData(localPlayer,"acc:id") == 1 or getElementData(localPlayer,"acc:id") == 39423 then
								menu = 14
								
								currentChat = v[2]
								contato = v[1]
								
								--createGuis("sms")
								--guiSetText(createdGuis[1], v[2])
								--triggerServerEvent("getChatFromServer", localPlayer, localPlayer, actualPhoneID)
								triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)								
							end
							end
							

							if isInSlot(sx*1270,chatY+sy*20,sx*15,sy*15) then
								editContact = true
								createGuis("addContact")
								editContactNumber = k
								editContactID = v[3]
								guiSetText(createdGuis[1], v[2])
								guiSetText(createdGuis[2], v[1])
								

							end
							if isInSlot(sx*1305,chatY+sy*20,sx*15,sy*15) then
							--triggerServerEvent("loadMessages", localPlayer, localPlayer, actualPhoneID)	
								triggerServerEvent("removeFromContactS", localPlayer, localPlayer, k, v[3])
							end	
							contactsCounter = contactsCounter + 1
						--end
					end	
				end
			end
			--[[
			for i = 1, 2 do		
				if isInSlot(pX+206, pY + 210 + (i) * 70 - 50, 210, 30) then
					if guiEditSetCaretIndex(createdGuis[i], string.len(guiGetText(createdGuis[i]))) then

					--	if guiEditSetCaretIndex(createdGuis[i], guiGetText(createdGuis[i])) then

						guiBringToFront(createdGuis[i])
					end
				end
			end]]--
		elseif (tonumber(menu) == 6) then
		
		
			if isInSlot(sx*1190,sy*515,sx*42,sy*41) then

				triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 2)
				if isElement(sound) then
					stopSound(sound)
				end			
				musicID = 0				
			end
			if isInSlot(sx*1273,sy*510,sx*51,sy*51) then

				if isElement(sound) then
					stopSound(sound)
				end	
				musicID = 0
				triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
			end
		elseif (tonumber(menu) == 7) then			
			if isInSlot(sx*1230,sy*491,sx*51,sy*51) then
			
				triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
				if isElement(sound) then
					stopSound(sound)
				end	
				musicID = 0
			end	




			
		elseif (tonumber(menu) == 8) then


		elem = 0
				for index, value in ipairs (celularobjetos_Table) do
				if (index > nextPage and elem < maxElem) then
				elem = elem + 1			
				if isInSlot(sx*1175.5,sy*215+elem*(sy*42), sx*161,sy*30) then 
				if value[1] == "Caixa de som na mão" then 
				triggerServerEvent("objetomaosom", localPlayer, localPlayer, value[1])
				elseif value[1] == "Caixa na mão" then 
				triggerServerEvent("objetomaocaixa", localPlayer, localPlayer, value[1])
				elseif value[1] == "Flor na mão" then 
				triggerServerEvent("objetomaoflor", localPlayer, localPlayer, value[1])
				elseif value[1] == "Guarda chuva na mão" then 
				triggerServerEvent("objetgchuva", localPlayer, localPlayer, value[1])
				elseif value[1] == "Barraca Lanche" then 
				triggerServerEvent("objetomaolanche", localPlayer, localPlayer, value[1])			


			end
		end
	end
end





		elseif (tonumber(menu) == 9) then
			for k, v in ipairs(settingsMenu) do
				if isInSlot(sx*1175.5,sy*215+k*(sy*42), sx*161,sy*30) then
					menu = (k + 9)
					if menu == 10 then
						currentChooser = wallPaperID
					end
				end
			end
		elseif (tonumber(menu) == 10) then
			if isInSlot(sx*1175.5,sy*400, sx*21,sy*20) then
				currentChooser = currentChooser - 1
				if currentChooser < 1 then
					currentChooser = 1
				end				
			end
			if isInSlot(sx*1315,sy*400, sx*21,sy*20) then
				currentChooser = currentChooser + 1
				if currentChooser > maxImage then
					currentChooser = 9
				end
			end
			
			
			if isInSlot(sx*1175.5,sy*495, sx*161,sy*30) then
				wallPaperID = currentChooser
				triggerServerEvent("editWallpaperInServer", localPlayer, localPlayer, actualPhoneID, wallPaperID)
				outputChatBox("Você definiu com sucesso como papel de parede.", 255, 255, 255, true)
			
			menu = 1
			currentChat = -1
			chats = {}
			editContactNumber = -1		
			addContact = false 
			editContactID = -1
			--removeEventHandler("onClientRender", getRootElement(), PlayedSound)
			if isElement(sound) then
				stopSound(sound)
			end	
			callMessages = {}
			currentCallMSG = -3
			createGuis("destroy")
			triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
			
			
			end
		elseif (tonumber(menu) == 11) then
			for i = 1, 10 do
				if isInSlot(sx*1175.5,sy*215+i*(sy*25), sx*161,sy*23) then
					currentRing = i
					if isElement(sound) then
						stopSound(sound)
					end
					sound = playSound("files/sounds/call/" .. i .. ".mp3")
				end
			end
			if isInSlot(sx*1175.5,sy*495, sx*161,sy*30) then
				musicID = currentRing
				triggerServerEvent("editRingInServer", localPlayer, localPlayer, actualPhoneID, currentRing)
				outputChatBox("Você definiu seu toque com sucesso.", 255, 255, 255, true)
				
			menu = 1
			currentChat = -1
			chats = {}
			editContactNumber = -1		
			addContact = false 
			editContactID = -1
			--removeEventHandler("onClientRender", getRootElement(), PlayedSound)
			if isElement(sound) then
				stopSound(sound)
			end	
			callMessages = {}
			currentCallMSG = -3
			createGuis("destroy")
			triggerServerEvent("answerPhoneS", localPlayer, localPlayer, inCallMember, 1)
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), onPhoneClick)

function editContactC(name, number, row, id)
	if (name) and (number) and (row) and (id) then
		if phoneContacts[row] then
			phoneContacts[row] = {name, number, id}
		end
		editContact = false
		createGuis("destroy")
		menu = 4
	end
end
addEvent("editContactC", true)
addEventHandler("editContactC", getRootElement(), editContactC)

function removeFromContactC(row)
	if phoneContacts[row] then
		table.remove(phoneContacts, row)
		currentContactPos = currentContactPos - 1
	end
end
addEvent("removeFromContactC", true)
addEventHandler("removeFromContactC", getRootElement(), removeFromContactC)

function getPhoneContactToClient(table)
	if (table) then
		phoneContacts = {}
		phoneContacts = table
		currentContactPos = #phoneContacts
	end
end
addEvent("getPhoneContactToClient", true)
addEventHandler("getPhoneContactToClient", getRootElement(), getPhoneContactToClient)	

function callMemberClient(number)
	if tonumber(number) then
		if tonumber(number) > 0 then
			if tonumber(number) then
			triggerServerEvent("callTargetInServer", localPlayer, localPlayer, tonumber(number), actualPhoneID)
			end
		else
			if tostring(number) then
			triggerServerEvent("callTargetInServer", localPlayer, localPlayer, tostring(number), actualPhoneID)
			end
		end
	end
end

function sendCallMessages(targetPlayer, message, ownerPhone, date, time)
	if message and ownerPhone and date and time then
		--[[if (tonumber(numberCall) == 911) then
			callMessages[#callMessages + 1] = {message, ownerPhone}
			currentCallMSG = currentCallMSG + 1	
			setTimer(function()
				callMessages[#callMessages + 1] = {"Rendben, küldjük az egységeket! Kérem maradjon a tett helyszínén!", 911}
				currentCallMSG = currentCallMSG + 1	
				triggerServerEvent("sendMessageToPD", localPlayer, localPlayer, callMessages[2][1])
				setTimer(function()
					numberCall = -1
					currentCallMSG = -3
					inCallMember = nil
					menu = 1
					callMessages = {}
				end, 5000, 1)
			end, 2000, 1)
		elseif (tonumber(numberCall) == 910) then
			callMessages[#callMessages + 1] = {message, ownerPhone}
			currentCallMSG = currentCallMSG + 1	
			setTimer(function()
				callMessages[#callMessages + 1] = {"Rendben, kérem maradjon a helyszínen, az egységeink máris úton vannak!", 910}
				currentCallMSG = currentCallMSG + 1	
				triggerServerEvent("sendMessageToES", localPlayer, localPlayer, callMessages[2][1])
				setTimer(function()
					numberCall = -1
					currentCallMSG = -3
					inCallMember = nil
					menu = 1
					callMessages = {}
				end, 6000, 1)
			end, 2000, 1)	
		elseif (tonumber(numberCall) == 909) then
			callMessages[#callMessages + 1] = {message, ownerPhone}
			currentCallMSG = currentCallMSG + 1	
			setTimer(function()
				callMessages[#callMessages + 1] = {"Rendben, kérem maradjon a helyszínen, az egységeink máris úton vannak!", 909}
				currentCallMSG = currentCallMSG + 1	
				triggerServerEvent("sendMessageToFD", localPlayer, localPlayer, callMessages[2][1])
				setTimer(function()
					numberCall = -1
					currentCallMSG = -3
					inCallMember = nil
					menu = 1
					callMessages = {}
				end, 6000, 1)
			end, 2000, 1)
		elseif (tonumber(numberCall) == 908) then
			callMessages[#callMessages + 1] = {message, ownerPhone}
			currentCallMSG = currentCallMSG + 1	
			setTimer(function()
				callMessages[#callMessages + 1] = {"a, a!", 908}
				currentCallMSG = currentCallMSG + 1	
				triggerServerEvent("sendMessageToLC", localPlayer, localPlayer, callMessages[2][1])
				setTimer(function()
					numberCall = -1
					currentCallMSG = -3
					inCallMember = nil
					menu = 1
					callMessages = {}
				end, 6000, 1)
			end, 2000, 1)]]			
		triggerServerEvent("sendCallMessages", localPlayer, localPlayer, targetPlayer, message, ownerPhone, date, time)	
	end
end

function addContactMemberC(name, number, id)
	if (name) and tonumber(number) and tonumber(id) then
		phoneContacts[#phoneContacts + 1] = {name, number, id}
		currentContactPos = currentContactPos + 1
	end
end
addEvent("addContactMemberC", true)
addEventHandler("addContactMemberC", getRootElement(), addContactMemberC)

function insertMessages(msg, type, number)
	if msg then
		if (tonumber(type) == 1) then
			callMessages[#callMessages + 1] = {msg, number}
			currentCallMSG = currentCallMSG + 1
		end
	end
end
addEvent("insertMessages", true)
addEventHandler("insertMessages", getRootElement(), insertMessages)

function getChatToClient(table)
	chats = {}
	currentChatPos = -3
	if table then
		for k, v in ipairs(table) do
			chats[#chats + 1] = {tonumber(v[1])}
			currentChatPos = currentChatPos + 1
		end
	end
end
addEvent("getChatToClient", true)
addEventHandler("getChatToClient", getRootElement(), getChatToClient)

function convertNumToColor(num)
	if num >= 70 then
		return 38, 194, 129
	elseif num < 70 and num >= 40 then
		return 255,112,66
	elseif num < 40 then
		return 255,57,57
	end
end

function isInSlot( posX, posY, width, height )
  if isCursorShowing( ) then
    local mouseX, mouseY = getCursorPosition( )
    local clientW, clientH = guiGetScreenSize( )
    local mouseX, mouseY = mouseX * clientW, mouseY * clientH
    if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
      return true
    end
  end
  return false
end


function sendMessagesInClient(from, to, number, msg, when, date, group, phoneID)
	if (from) and (to) and (number) and (msg) and (when) and (date) and (group) and (phoneID)  then
		if (tonumber(phoneID) == getElementData(localPlayer,"char:telefone")) then
			if (tonumber(menu) == 14) then
				if not messages[tonumber(group)] then
					messages[tonumber(group)] = {}
				end
				messages[tonumber(group)][tonumber(#messages[tonumber(group)]) + 1] = {from, to, number, msg, when, date}	
				
				if messages[currentChat] then
				nextPageMessage = (#messages[currentChat]-6)
				end
 			end
		end
	end
end
addEvent("sendMessagesInClient", true)
addEventHandler("sendMessagesInClient", getRootElement(), sendMessagesInClient)

function insertClientChat(id)
	if id then
		chats[#chats + 1] = {tonumber(id)}
	end
end
addEvent("insertClientChat", true)
addEventHandler("insertClientChat", getRootElement(), insertClientChat)

function loadMessagesInClient(table)
	if (table) then	
		messages = {}
		messages = table
	end
	
	if messages[currentChat] then
		nextPageMessage = (#messages[currentChat]-6)
	end
	
end
addEvent("loadMessagesInClient", true)
addEventHandler("loadMessagesInClient", getRootElement(), loadMessagesInClient)



function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function wasMessageSentToday(date)
	if date then
		local time = getRealTime()
		if time.month + 1 < 10 then
			time.month = "0"..time.month + 1
		end 
		if time.monthday < 10 then
			time.monthday = "0"..time.monthday
		end
	    local year = "20"..string.gsub(tostring(time.year+1900), "20", "")
		local currTime = year.." "..time.month.." "..time.monthday
		if tostring(currTime) == tostring(date) then
			return true
		else
			return false
		end
	end
end

function getDate()
	local time = getRealTime()
	if time.month + 1 < 10 then
		time.month = "0"..time.month + 1
	end
	if time.monthday < 10 then
		time.monthday = "0"..time.monthday
	end
	local year = "20"..string.gsub(tostring(time.year+1900), "20", "")
	local currTime = year.." "..time.month.." "..time.monthday
	return currTime
end

function getTime()
	local time = getRealTime()

	local hour = time.hour
	local min = time.minute

	if hour < 10 then
		hour = "0"..hour
	end 

	if min < 10 then
		min = "0"..min
	end 

	return hour..":"..min
end



function sortores(t)
	local array = {}
	for i=0, utfLen(t)-1 do
		array[#array+1] = utfSub( t, i+1, i+1 )
	end
	local tag = 25
	local kiteres = 5
	local ki = ""
	local szamlalo = 0
	for i,v in ipairs(array) do
		if(szamlalo==tag)then
			szamlalo=0
			v = "\n"..v
		elseif(szamlalo>tag-kiteres and szamlalo<tag and v==" ")then
			szamlalo=0
			v = "\n"	
		end
		szamlalo=szamlalo+1
		ki = ki..v
	end
	return ki
end






function chamadaNumero(fac)
	if isElement(window) then
	destroyElement( window ) 
	end
	
	window = dgs:dgsCreateWindow(0, 0, 300, 165, "Motivo", false)
	dgs:dgsSetProperty(window,"color",tocolor(0, 0, 0,155))
	dgs:dgsSetProperty(window, "sizable", false)
	dgs:dgsSetProperty(window, "font", "default-bold")
	edit = dgs:dgsCreateEdit ( 0.03, 0.1, 0.94, 0.41, "", true, window ,tocolor(255, 255, 255, 255), 1, 1, nil ,tocolor(40, 40, 40, 255), true )
	dgs:dgsBringToFront( edit )
	dgs:dgsFocus(edit)
	dgs:dgsSetFont ( edit, "default-bold" )
	dgs:dgsEditSetMaxLength ( edit, 50 )
	botao = dgs:dgsCreateButton(2, 101, 296, 35, "Chamar "..(fac or "N/A").."", false, window, tocolor(255, 255, 255, 255), false, false, false, false, false, tocolor(40, 40, 40, 255), tocolor(255, 90, 90,255))
	centerWindow(window)
	removeEventHandler("onDgsMouseClick", window, clicar)
	addEventHandler("onDgsMouseClick", window, clicar)
end


				
function clicar(button, state)
	if button == "left" and state == "down" then
		if source == botao then
		local motivo = dgs:dgsGetText ( edit )
             if (motivo == "") then
			     outputChatBox("#FFA000*BGO ERROR #FFFFFFAdicione um descrição para chamada.", 255,255,255, true)
			     return
			 end 
		         if (fac == "Policia") then
				    triggerServerEvent('SendMsgToTeamPolicia', localPlayer, localPlayer, motivo)
                    fac = nil	
					windowClosed()
		        elseif (fac == "Staff") then
				    triggerServerEvent('SendMsgToTeamstaff', localPlayer, localPlayer, motivo)						 
					fac = nil	
					windowClosed()
		        elseif (fac == "Resgate") then
					triggerServerEvent('SendMsgToTeammedic', localPlayer, localPlayer, motivo)						 
					fac = nil	
					windowClosed()
				elseif (fac == "taxi") then
					triggerServerEvent('SendMsgToTeamtaxi', localPlayer, localPlayer, motivo)						 
					fac = nil	
					windowClosed()
				elseif (fac == "mecanico") then
					triggerServerEvent('SendMsgToTeamMecanico', localPlayer, localPlayer, motivo)						 
					fac = nil	
					windowClosed()
				elseif (fac == "drvv") then
					triggerServerEvent('SendMsgToTeamDetran', localPlayer, localPlayer, motivo)						 
					fac = nil	
					windowClosed()
			end
		end
	end
end


function windowClosed()
		if isElement(window) then
		destroyElement( window ) 
		end
end



function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end









