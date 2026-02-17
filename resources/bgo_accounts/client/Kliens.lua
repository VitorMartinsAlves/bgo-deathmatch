if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end



local screenSize = Vector2(guiGetScreenSize())
local logoTexture
local logoSize
local logoPosition
local BACKGROUND_COLOR = 0xFF151515
local CIRCLE_COLOR = {185, 74, 0} --{0, 200, 200} --
local CIRCLE_COLOR2 = {163, 0, 185}  --{0, 70, 70} --

local CIRCLE_ANIM_TIME = 5000
local CIRCLE_ANIM_DELAY = 100




local monitorSite = {guiGetScreenSize()}
local sx,sy = guiGetScreenSize()



local dim = math.random(1, 10000)
local camID = 0
local lastCamTick = 0
local createdGuis = {}
local data = {}
local panelType = "Nincs"
local showLogin = false
local PanelState = false
local serverColor = "#FFA600"
local nem = nil

local opensansB =  dxCreateFont("files/OpenSansB.ttf",22)
local opensansB2 =  dxCreateFont("files/OpenSansB.ttf",17)
local opensansL =  dxCreateFont("files/OpenSansL.ttf",16)
local opensansL2 =  dxCreateFont("files/OpenSansL.ttf",14)
local opensans = dxCreateFont("files/OpenSans.ttf",15)

--local fonte = dxCreateFont("files/fonte.ttf",10)

local fonte = dxCreateFont('files/fonte.ttf', 30, false, 'proof') or 'default'
local manSkins = {
	2,3
}
local womanSkins = {
	9,10
}




local screenX, screenY = guiGetScreenSize()

login = {}

login.font = {
	["RB"] = guiCreateFont("RB.ttf", 12),
	["RL"] = guiCreateFont("RL.ttf", 11),
	["RR"] = guiCreateFont("RR.ttf", 10),
	["chek_r"] = guiCreateFont("RR.ttf", 10),
	["chek_b"] = guiCreateFont("RB.ttf", 10),
	["RL_warning"] = guiCreateFont("RL.ttf", 10),
	["RR_editbox"] = guiCreateFont("RR.ttf", 12)
}



--guiSetVisible(reg.back_ground, false)



function eletkorCheck(megadott)
	if (18==tonumber(megadott)) or (19==tonumber(megadott)) or (20==tonumber(megadott)) or (21==tonumber(megadott)) or (22==tonumber(megadott)) or (23==tonumber(megadott)) or (24==tonumber(megadott)) or (25==tonumber(megadott)) or (26==tonumber(megadott)) or  (27==tonumber(megadott)) or (28==tonumber(megadott)) or  (29==tonumber(megadott)) or
	(30==tonumber(megadott)) or (31==tonumber(megadott)) or (32==tonumber(megadott)) or (33==tonumber(megadott)) or (34==tonumber(megadott)) or (35==tonumber(megadott))
	or (36==tonumber(megadott)) or  (37==tonumber(megadott)) or (38==tonumber(megadott)) or (39==tonumber(megadott)) or  (40==tonumber(megadott)) or (41==tonumber(megadott)) or (42==tonumber(megadott)) or (43==tonumber(megadott)) or (44==tonumber(megadott)) or (45==tonumber(megadott)) or (46==tonumber(megadott)) or  (47==tonumber(megadott)) or (48==tonumber(megadott)) or (49==tonumber(megadott)) or (50==tonumber(megadott)) or  (51==tonumber(megadott)) or (52==tonumber(megadott)) or (53==tonumber(megadott)) or
	(54==tonumber(megadott)) or (55==tonumber(megadott)) or (56==tonumber(megadott)) or (57==tonumber(megadott)) or  (58==tonumber(megadott)) or  (59==tonumber(megadott)) or
	(60==tonumber(megadott)) then
		return true
	else 
		return false
	end
end

--addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 


function startShowingLoginPanel()
	if (isTransferBoxActive()) then	
		setTimer(startShowingLoginPanel, 1000, 1)
	return end
	triggerServerEvent("showLoginPanelServer", resourceRoot)
end
--addEventHandler("onClientResourceStart", resourceRoot, startShowingLoginPanel)


--function showLoginPanel()

local sounds = {
	"361822874"
} 



local webBrowser
addEventHandler("onClientResourceStart", resourceRoot, 
function()
	if getElementData(localPlayer, "loggedin") == false then
	setCameraTarget(localPlayer)
	setElementData(localPlayer, "loggedin", false)
	setElementData(localPlayer, "saiudaespera", false)
	setCloudsEnabled ( false )
	showChat(false)
	fadeCamera(false, 1)
	dim = math.random(1, 10000)

	webBrowser = createBrowser(screenSize, false, false)
--[[
	setTimer(function()
	sound = playSound("http://api.soundcloud.com/tracks/"..sounds[math.random(1, #sounds)].."/stream?client_id=N2eHz8D7GtXSl6fTtcGHdSJiS74xqOUI", true)
	setSoundVolume(sound, 0.3)
	end,5000,1)
	]]--
		
		
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()

	loadBrowserURL(webBrowser, "https://www.youtube-nocookie.com/embed/2PJGOE-kgTg?vq=hd1080&autoplay=1&loop=1&modestbranding=1&showinfo=0&rel=0&cc_load_policy=1&iv_load_policy=3&theme=light&fs=0&color=white&autohide=0&controls=0&disablekb=1")



--	loadBrowserURL(webBrowser, "https://www.youtube-nocookie.com/embed/BKNztH2Vcu8?vq=hd1080&autoplay=1&loop=1&modestbranding=1&showinfo=0&rel=0&cc_load_policy=1&iv_load_policy=3&theme=light&fs=0&color=white&autohide=0&controls=0&disablekb=1")



									   
	video = setTimer(reloadBrowserPage,145800,0,webBrowser )

	end
	)
	
	
	

	
	
	
	    logoTexture = dxCreateTexture("files/login/logoBGO.png", "dxt5", true, "clamp", "3d")
        dxSetTextureEdge(logoTexture, "clamp")
        logoSize = Vector2(250, 261)
		
	
        logoPosition = Vector2(screenSize.x / 1 - 635 - logoSize.x / 2, screenSize.y / 1 - 700 - logoSize.y )

	
		setElementData(localPlayer, "EntrouFilaDeEspera", false)
	
		fadeCamera(true, 1)
		removeEventHandler("onClientRender", root, createLogin)
		addEventHandler("onClientRender",  root, createLogin, true, "high") 
		setElementData(localPlayer,"saiudaespera", false)
		triggerServerEvent("prioridade", localPlayer, localPlayer)
		
		setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
		
		
		--removeEventHandler("onClientPreRender", root, updateCamPosition)
		--addEventHandler("onClientPreRender", root, updateCamPosition)		
		lastCamTick = getTickCount () 
		camID = 1
		
		removeEventHandler("onClientClick", root, loginClickFunction)
		addEventHandler("onClientClick", root, loginClickFunction)
		blurShader, blurTec = dxCreateShader("files/BlurShader.fx")
		setElementInterior(localPlayer, 0)


	showCursor(true)
	setElementDimension(localPlayer, dim)
	--createGui("login")
	
	setBrowserVolume (webBrowser, 0.5)
	
end
end
)



	
function proximodafila()
	panelType = "login"
	--outputDebugString ( "Aviso: " .. getPlayerName ( localPlayer ) .. " acaba de sair da fila de espera!" )
	--zenes = playSound("bgo.mp3", false)
end

local quantidadeFila = "00"
function QuantidadeFila2(quant)
	quantidadeFila = quant
end
addEvent("login:QuantidadeFila", true)
addEventHandler("login:QuantidadeFila", root, QuantidadeFila2)

local tempo = 0

local suafila = "00"
function vocenafila(quant)
	suafila = quant
	
	tempo = suafila*5
	
	timerTempo = setTimer(tempofila, 1000,1)
	
end
addEvent("login:QuantidadeFila2", true)
addEventHandler("login:QuantidadeFila2", root, vocenafila)

function tempofila()

if tempo > 0 then
tempo = tempo - 1
timerTempo = setTimer(tempofila, 1000,1)
else

if isTimer(timerTempo) then
killTimer(timerTempo)
end

end 
end

--[[
function convertTime(ms) 
    local min = math.floor ( ms/60000 ) 
    local sec = math.floor( (ms/1000)%60 ) 
    return min, sec 
end 
]]--



local blurStrength = 10
local myScreenSource = dxCreateScreenSource(monitorSite[1], monitorSite[2])


function blurCreate()
    if (blurShader) then
		dxUpdateScreenSource(myScreenSource)
			
		dxSetShaderValue(blurShader, "ScreenSource", myScreenSource);
		dxSetShaderValue(blurShader, "BlurStrength", blurStrength);
		dxSetShaderValue(blurShader, "UVSize", monitorSite[1], monitorSite[2]);

		dxDrawImage(0, 0, monitorSite[1], monitorSite[2], blurShader)
    end
end


function createGui(type)
	if tostring(type) == "destroy" then
		for i = 1, 6 do
			if isElement(createdGuis[i]) then
				destroyElement(createdGuis[i])
			end
		end
		nem = ""
		--[[
	elseif tostring(type) == "login" then
		user = loadLoginFromXML()
		createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, user, false)
		guiEditSetMaxLength(createdGuis[1], 20)		
		createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[2], 20)
		
	elseif tostring(type) == "register" then
		createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[1], 20)		
		createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[2], 20)		
		createdGuis[4] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[4], 29)	
		]]--
	elseif tostring(type) == "charCreate" then
		createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[1], 25)		
		createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[2], 60)		
		addEventHandler("onClientGUIChanged", createdGuis[1], function()
			if string.find(guiGetText(createdGuis[1]),"_") then
				guiSetText(createdGuis[1],"")
				exports.bgo_infobox:addNotification("Não use um sinal _ no nome do seu personagem!","error")
			end
			if string.find(guiGetText(createdGuis[1]),"á") or string.find(guiGetText(createdGuis[1]),"é") or string.find(guiGetText(createdGuis[1]),"í") or string.find(guiGetText(createdGuis[1]),"ú") or string.find(guiGetText(createdGuis[1]),"ó") or string.find(guiGetText(createdGuis[1]),"?") or string.find(guiGetText(createdGuis[1]),"Á") or string.find(guiGetText(createdGuis[1]),"É") or string.find(guiGetText(createdGuis[1]),"Í") or string.find(guiGetText(createdGuis[1]),"Ó") or string.find(guiGetText(createdGuis[1]),"?") then
				guiSetText(createdGuis[1],"")
				exports.bgo_infobox:addNotification("Não use caracteres acentuados no nome do seu personagem.","error")
			end
		end)		
		
		createdGuis[3] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(createdGuis[3], 2)	
	end
end

local NomeNaFila = "Ninguém"

function setPlayerPanelState(state)
	panelType = state
			state2 = false
		--guiSetVisible(login.back_ground, false)
		guiSetVisible(reg.back_ground, false)
end
addEvent("login:setPlayerPanelState", true)
addEventHandler("login:setPlayerPanelState", root, setPlayerPanelState)


function setPlayerPanelStateESPERA(state)
	panelType = state
	state2 = false
	--guiSetVisible(login.back_ground, false)
	guiSetVisible(reg.back_ground, false)
	--if isElement(zenes) then 
	--	stopSound(zenes)
	--end
	setElementData(localPlayer, "saiudaespera", true)
	--zenes = playSound("bgo.mp3", false)
end
addEvent("login:setPlayerPanelStateESPERA", true)
addEventHandler("login:setPlayerPanelStateESPERA", root, setPlayerPanelStateESPERA)



function setPlayerPanelStateESPERAVIP(state)
	panelType = state
	state2 = false
	--guiSetVisible(login.back_ground, false)
	guiSetVisible(reg.back_ground, false)
	--if isElement(zenes) then 
	--	stopSound(zenes)
	--end
	setElementData(localPlayer, "saiudaespera", true)
	--zenes = playSound("bgo.mp3", false)
	end
addEvent("login:setPlayerPanelStateESPERAVIP", true)
addEventHandler("login:setPlayerPanelStateESPERAVIP", root, setPlayerPanelStateESPERAVIP)


state2 = false


local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx2,sy2 = (screenW/resW), (screenH/resH)


function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end


function createLogin ()
--if not getElementData(localPlayer, "banned") then
	if panelType == "espera" then 
	dxSetBlendMode("modulate_add")


	--dxDrawImage(sx2*1-50,sy2*1-250, sx2*1450,sy2*1120, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
	

	dxDrawImage(sx2*1-2,sy2*1-2, sx2*1390,sy2*800, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
	
	--dxDrawImage(sx2,sy2, sx2*1450,sy2*1120, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
    dxDrawRectangle(sx2*1-50,sy2*1-250, sx2*1450,sy2*1120, tocolor(0,0,0,130))



	local texto = Vector2(screenSize.x/1, screenSize.y/0.95)
	local texto2 = Vector2(screenSize.x/1, screenSize.y/0.7)
	local texto3 = Vector2(screenSize.x/1, screenSize.y/0.85) 
	dxDrawText("Você está na fila de espera!\n\n Vai sair da fila em "..tempo.." segundos", Vector2(screenSize.x/1.001, screenSize.y/0.7), 2, 0, tocolor(0,0,0, 255), 3, "default-bold-small", "center", "center",nil,nil,nil,true)
	dxDrawText("Você está na fila de espera!\n\n Vai sair da fila em "..tempo.." segundos", texto2, 2, 0, tocolor(255,255,255, 255), 3, "default-bold-small", "center", "center",nil,nil,nil,true)



		local circleAnimProgress, _, _ = interpolateBetween ( 
		1, 0 ,0,
		2, 0, 0,
		(getTickCount()-lastCamTick)/2000, "CosineCurve")
		


	dxDrawText(suafila, Vector2(screenSize.x/1.001, screenSize.y/0.95), 2, 0, tocolor(0,0,0, 255), circleAnimProgress, fonte, "center", "center",nil,nil,nil,true)
	dxDrawText(suafila, texto, 2, 0, tocolor(255,255,255, 255), circleAnimProgress, fonte, "center", "center",nil,nil,nil,true)


    local circleAnimProgress = getEasingValue(math.abs(math.sin((getTickCount() - (CIRCLE_ANIM_DELAY )) / 1000)), "InQuad")
    local alph = 120 + (255 - 120) * circleAnimProgress
    --dxDrawImage(sx2*10,sy2*10, sx2*150,sy2*120 , logoTexture, 0, 0, 0, tocolor(255,255,255,alph))
	
	
    dxSetBlendMode("blend")

		--dxDrawText("#FFFFFFVocê está na fila de espera #FFA600aguarde #FFFFFFa sua vez!\n\nVocê é o #FFA600"..suafila.." #ffffffda fila\n\n\n#ffffffA fila é atualizada a cada 20 segundos ",sx/2,sy/2+400,sx/2,sy/2-50,tocolor(255,255,255,255),1,opensansB,"center","center",nil,nil,nil,true)

	elseif panelType == "login" then 

    dxSetBlendMode("modulate_add")

	dxDrawImage(sx2*1-2,sy2*1-2, sx2*1390,sy2*800, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
	
	--dxDrawImage(sx2*1-50,sy2*1-250, sx2*1450,sy2*1120, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
    dxDrawRectangle(sx2*1-50,sy2*1-250, sx2*1450,sy2*1120, tocolor(0,0,0,130))
	
	--if getTickCount()-lastCamTick >= 7500 then
	local pos = Vector2(screenSize.x / 1 - 830, screenSize.y / 1 - 450)
	local tamanho = Vector2(screenSize.x/1 - 900, screenSize.y/1 - 970)
	local texto = Vector2(screenSize.x/1, screenSize.y/0.96)
	local texto2 = Vector2(screenSize.x/1, screenSize.y/0.7)
	local texto3 = Vector2(screenSize.x/1, screenSize.y/0.85)
	dxDrawRectangle(sx2*470,sy2*435, sx2*430,sy2*30, tocolor(200,200,200,250))
	
	
	dxDrawText("Digite sua senha\nPressione 'Enter' para entrar", Vector2(screenSize.x/1.001, screenSize.y/0.96), 2, 0, tocolor(0,0,0, 255), 2, "default", "center", "center", false, false, false, false)
	dxDrawText("Digite sua senha\nPressione 'Enter' para entrar", texto, 2, 0, tocolor(255,255,255, 255), 2, "default", "center", "center", false, false, false, false)
	if not isElement(contabancaria) then
	contabancaria = guiCreateEdit(-1000,-1000,0,0,"",false)
	if guiEditSetCaretIndex(contabancaria, string.len(guiGetText(contabancaria))) then
	guiEditSetMaxLength(contabancaria, 28)
	end
	end
	guiBringToFront(contabancaria)
	--dxDrawText(string.gsub ( guiGetText(contabancaria), ".", "*" ) , Vector2(screenSize.x/1.001, screenSize.y/0.85), 2, 0, tocolor(0,0,0, 255), 2, "default", "center", "center", false, false, false, false)
	dxDrawText(string.gsub ( guiGetText(contabancaria), ".", "*" ) , texto3, 2, 0, tocolor(0,0,0, 255), 2, "default", "center", "center", false, false, false, false)
	dxDrawText("Você já possui uma conta registrada neste computador\nCaso esqueceu a senha contacte o suporte de contas BGO no discord\n\nNosso Discord: http://discord.gg/HRYTfG8", Vector2(screenSize.x/1.001, screenSize.y/0.7), 2, 0, tocolor(0,0,0, 255), 2, "default", "center", "center", false, false, false, false)
	dxDrawText("Você já possui uma conta registrada neste computador\nCaso esqueceu a senha contacte o suporte de contas BGO no discord\n\nNosso Discord: http://discord.gg/HRYTfG8", texto2, 2, 0, tocolor(255,255,255, 255), 2, "default", "center", "center", false, false, false, false)
    local circleAnimProgress = getEasingValue(math.abs(math.sin((getTickCount() - (CIRCLE_ANIM_DELAY )) / 1000)), "Linear")
    local alph = 120 + (255 - 120) * circleAnimProgress
    --dxDrawImage(sx2*10,sy2*10, sx2*150,sy2*120 , logoTexture, 0, 0, 0, tocolor(255,255,255,alph))
    dxSetBlendMode("blend")
	
	--end


	elseif panelType == "register" then 
	dxSetBlendMode("modulate_add")
	dxDrawImage(sx2*1-2,sy2*1-2, sx2*1390,sy2*800, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
	--dxDrawImage(sx2*1-50,sy2*1-250, sx2*1450,sy2*1120, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
    dxDrawRectangle(sx2*1-50,sy2*1-250, sx2*1450,sy2*1120, tocolor(0,0,0,130))
	dxSetBlendMode("blend")
	
		state = true
		if state2 == false then
		state2 = true
		guiSetVisible(reg.back_ground, state)
		end


	elseif panelType == "charCreate" then 
		dxDrawRectangle(sx/2-180,sy/2-200,360,400,tocolor(0,0,0,140))

		dxDrawRectangle(sx/2-140,sy/2-150,280,30,tocolor(0,0,0,180))
		dxDrawText("Nome do personagem",sx/2-135,sy/2-175,sx,sy,tocolor(255,255,255,255),1,opensansL2,"left")
		dxDrawText(guiGetText(createdGuis[1]),sx/2-135,sy/2-135,sx,sy/2-135,tocolor(255,255,255,255),1,opensansL,"left","center",false,false,false,true,true)
		
		dxDrawRectangle(sx/2-140,sy/2-75,280,30,tocolor(0,0,0,180))
		dxDrawText("Descreva seu personagem",sx/2-135,sy/2-100,sx,sy,tocolor(255,255,255,255),1,opensansL2,"left")
		dxDrawText(guiGetText(createdGuis[2]),sx/2-135,sy/2-60,sx,sy/2-60,tocolor(255,255,255,255),1,opensansL,"left","center",false,false,false,true,true)
		
		
		dxDrawRectangle(sx/2-140,sy/2,280,30,tocolor(0,0,0,180))
		dxDrawText("Idade",sx/2-135,sy/2-25,sx,sy,tocolor(255,255,255,255),1,opensansL2,"left")
		dxDrawText(guiGetText(createdGuis[3]),sx/2-135,sy/2+15,sx,sy/2+15,tocolor(255,255,255,255),1,opensansL,"left","center",false,false,false,true,true)
		
		dxDrawRectangle(sx/2-140,sy/2+75,30,30,tocolor(255,145,0,180)) --Férfi
		dxDrawRectangle(sx/2-50,sy/2+75,30,30,tocolor(255,145,0,180)) --N?
		dxDrawText("Gênero:",sx/2-135,sy/2+50,sx,sy,tocolor(255,255,255,255),1,opensansL2,"left")
		dxDrawText("Homem",sx/2-105,sy/2+77,sx,sy,tocolor(255,255,255,255),1,opensansL2,"left")
		dxDrawText("Mulher",sx/2-15,sy/2+77,sx,sy,tocolor(255,255,255,255),1,opensansL2,"left")
		
		if nem == "ferfi" then
			dxDrawImage(sx/2-140,sy/2+75,30,30,"files/login/pipa.png")
		elseif nem == "no" then
			dxDrawImage(sx/2-50,sy/2+75,30,30,"files/login/pipa.png")
		end
		if isCursorOnBox(sx/2-140,sy/2+160,280,30) then
			dxDrawRectangle(sx/2-140,sy/2+160,280,30,tocolor(124, 197, 118,180))
		else
			dxDrawRectangle(sx/2-140,sy/2+160,280,30,tocolor(0,0,0,180))
		end
		dxDrawText("Criar um personagem",sx/2,sy/2+175,sx/2,sy/2+175,tocolor(255,255,255,255),1,opensansB2,"center","center",nil,nil,nil,true)
	end
end



	


addEventHandler( "onClientKey", root, 
function(button,press) 
    if button == "enter" or button == "num_enter" then
	 if (press) then -- Only output when they press it down
	if getElementData(localPlayer, "loggedin") == false then
	if panelType == "login" then 
	
	if isTimer(timerLogin) then
	return
	end
	timerLogin = setTimer(function() end, 5000, 1)
	
	if guiGetText(contabancaria) == "" then
	exports.bgo_infobox:addNotification("Campos são obrigatórios!","error")
	else
	triggerServerEvent("onLoginClick", localPlayer, localPlayer, guiGetText(contabancaria))
	end
			end
		end
		end
	end
end 
)


				



function passwordHash(password)
    local length = utfLen(password)

    if length > 23 then
        length = 23
    end
    return string.rep("*", length)
end

local elem = 0

function loginClickFunction(button, state, cursorx, cursory)
	if button == "left" and state == "down" then --and not getElementData(localPlayer, "banned") then 
		showLogin = false
		if panelType == "login" then 
		--[[
			if isCursorOnBox(sx/2-256+125,sy/2-7,262,30) then --Felhasználónév
				if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
					guiBringToFront(createdGuis[1])
				end
			end
			if isCursorOnBox(sx/2-256+125,sy/2+40,262,30) then --Jelszó
				if guiEditSetCaretIndex(createdGuis[2], string.len(guiGetText(createdGuis[2]))) then
					guiBringToFront(createdGuis[2])
				end
			end	
			if isCursorOnBox(sx/2-256+125,sy/2+120,262,30) then --Bejelentkezés
				if guiGetText(createdGuis[1]) == "" and guiGetText(createdGuis[2]) == "" then
					exports.bgo_infobox:addNotification("Campos são obrigatórios!","error")
				else
					if isTimer(timer) then 
						--exports.bgo_infobox:addNotification("AGUARDE 1 SEGUNDO!","error")
						return end
						timer = setTimer(function() end, 3000, 1)

					triggerServerEvent("onLoginClick", localPlayer, localPlayer, guiGetText(createdGuis[1]), guiGetText(createdGuis[2]))
				end
			end
			if isCursorOnBox(sx/2-256+125,sy/2+165,262,30) then --Regisztráció
				createGui("register")
				panelType = "register"
			end
			]]--
		elseif panelType == "register" then 
		--[[
			if PanelState then return end 
			if isCursorOnBox(sx/2-256+125,sy/2-7,262,30) then --Felhasználónév
				if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
					guiBringToFront(createdGuis[1])
				end
			end
			if isCursorOnBox(sx/2-256+125,sy/2+40,262,30) then --Jelszó
				if guiEditSetCaretIndex(createdGuis[2], string.len(guiGetText(createdGuis[2]))) then
					guiBringToFront(createdGuis[2])
				end
			end	
			if isCursorOnBox(sx/2-256+125,sy/2+90,262,30) then --e-mail
				if guiEditSetCaretIndex(createdGuis[4], string.len(guiGetText(createdGuis[4]))) then
					guiBringToFront(createdGuis[4])
				end
			end	
			if isCursorOnBox(sx/2-256+125,sy/2+165,262,30) then
				if guiGetText(createdGuis[1]) == "" and guiGetText(createdGuis[2]) == "" and guiGetText(createdGuis[4]) == "" then
					exports.bgo_infobox:addNotification("Campos são obrigatórios!","error")
				else



					if guiGetText(createdGuis[2]) ~= guiGetText(createdGuis[4]) then
							exports.bgo_infobox:addNotification("A senha não corresponde com a primeira, confirme a senha novamente","error")
							return
					end


					--if not (string.find(guiGetText(createdGuis[4]), "@") or string.find(guiGetText(createdGuis[4]), ".")) then 
					--	exports.bgo_infobox:addNotification("Endereço de email incorreto!","error")
					--	return
					--end
					if string.find(guiGetText(createdGuis[1]), " ") or string.find(guiGetText(createdGuis[2]), " ") or string.find(guiGetText(createdGuis[4]), " ") then
							exports.bgo_infobox:addNotification("Preencha os campos sem espaços.","error")
							return
					end

					if isTimer(timer2) then 
						--exports.bgo_infobox:addNotification("AGUARDE 1 SEGUNDO!","error")
						return end
					timer2 = setTimer(function() end, 5000, 1)

					triggerServerEvent("onRegisterClick", localPlayer, localPlayer, guiGetText(createdGuis[1]), guiGetText(createdGuis[2])) --, guiGetText(createdGuis[4]))
				end
			end
			bindKey("backspace","down",function()
				createGui("destroy")
				createGui("login")
				panelType = "login"
			end)]]--
		elseif panelType == "charCreate" then
			if isCursorOnBox(sx/2-135,sy/2-150,270,30) then --Karakternév
				if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
					guiBringToFront(createdGuis[1])
				end	
			end
			if isCursorOnBox(sx/2-140,sy/2-75,280,30) then --Vizuális leírás
				if guiEditSetCaretIndex(createdGuis[2], string.len(guiGetText(createdGuis[2]))) then
					guiBringToFront(createdGuis[2])
				end	
			end
			if isCursorOnBox(sx/2-140,sy/2,280,30) then --Életkor
				if guiEditSetCaretIndex(createdGuis[3], string.len(guiGetText(createdGuis[3]))) then
					guiBringToFront(createdGuis[3])
				end	
			end
			-- NEM VÁLASZTÁS
			if isCursorOnBox(sx/2-140,sy/2+75,30,30) then
				nem = "ferfi"
			end
			if isCursorOnBox(sx/2-50,sy/2+75,30,30) then
				nem = "no"
			end
			---------------
			if isCursorOnBox(sx/2-140,sy/2+160,280,30) then --Karakter Létrehozás gomb
			
				if guiGetText(createdGuis[1]) == "" and guiGetText(createdGuis[2]) == "" and guiGetText(createdGuis[3]) == "" then
					exports.bgo_infobox:addNotification("Os Campos são obrigatórios!","error")
				else
					if nem == "ferfi" then 
						skinID = math.random(1, #manSkins)
					elseif nem == "no" then
						skinID = math.random(1, #womanSkins)
					else 
						exports.bgo_infobox:addNotification("Selecione o gênero do seu personagem!","error")
						return
					end
					 if string.find(guiGetText(createdGuis[1]), '%d+') then
							exports.bgo_infobox:addNotification("Não pode ter números no nome do personagem!","error")
						return
					end
					if string.find(guiGetText(createdGuis[1]), "%p+") then
						exports.bgo_infobox:addNotification("Você não pode ter um personagem especial com o seu nome!","error")
						return
					end
					if not eletkorCheck(guiGetText(createdGuis[3])) then
						guiSetText(createdGuis[3],"")
						exports.bgo_infobox:addNotification("Infelizmente não aceitamos personagem com menos de 18! (Idade adequada: 18 a 60)","error")
						return
					end
					if isTimer(timer3) then 
						--exports.bgo_infobox:addNotification("AGUARDE 1 SEGUNDO!","error")
						return end
						timer3 = setTimer(function() end, 5000, 1)
					triggerServerEvent("onCharCreateClick", localPlayer, localPlayer, guiGetText(createdGuis[1]), guiGetText(createdGuis[2]), guiGetText(createdGuis[3]), 170, tostring(nem), skinID)
				end
			end
		end
	end
end

function charSpawnEnter()
	triggerServerEvent("loadCharacter", localPlayer, localPlayer)
	--triggerServerEvent("checkCharacter", localPlayer, localPlayer)
	
	removeEventHandler("onClientRender", root, createLogin)
	removeEventHandler("onClientClick", root, loginClickFunction)
	--if isElement(zenes) then 
	--	stopSound(zenes)
	--end


		setElementFrozen(localPlayer, true)
		playSound("files/bong.mp3")
		if not isEventHandlerAdded("onClientPreRender",getRootElement(),spawnChar1) then
		addEventHandler("onClientPreRender",getRootElement(),spawnChar1)
		end
		spawntimer = setTimer(function()
			playSound("files/bong.mp3")
			if not isEventHandlerAdded("onClientPreRender",getRootElement(),spawnChar2) then
			addEventHandler("onClientPreRender",getRootElement(),spawnChar2)
			end
		end, 1000,1)
		spawntimer1 = setTimer(function()
			playSound("files/bong.mp3")
			if not isEventHandlerAdded("onClientPreRender",getRootElement(),spawnChar3) then
			addEventHandler("onClientPreRender",getRootElement(),spawnChar3)
			end
		end, 2000,1)
		spawntimer2 = setTimer(function()
			playSound("files/bong.mp3")
			if not isEventHandlerAdded("onClientPreRender",getRootElement(),spawnChar4) then
			addEventHandler("onClientPreRender",getRootElement(),spawnChar4)
			end
		end, 3000,1)
			spawntimer3 = setTimer(function()
			playSound("files/bong.mp3") 
			finish()
		end, 4000,1)
		
		--finish()
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if 
        type( sEventName ) == 'string' and 
        isElement( pElementAttachedTo ) and 
        type( func ) == 'function' 
    then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end

    return false
end


function checkPlayer(type)
	if type == "charCreate" then 
		state2 = false
		guiSetVisible(reg.back_ground, false)
		
		if isElement(webBrowser) then
		destroyElement(webBrowser)
		end
		if isElement(sound) then
		destroyElement(sound)
		end
		
		
		createGui("destroy")
		createGui(type)
		Tick = getTickCount()
		panelType = type
		if isElement(ped) then destroyElement(ped) end
		ped = createPed(math.random(#manSkins), 2660.4655761719, -1458.8054199219, 79.38053894043, -65)
		setElementDimension(ped, getElementDimension(localPlayer))
		setCameraMatrix(2664.8759765625, -1456.5216064453, 80.772903442383, 2664.0266113281, -1456.9836425781, 80.517936706543)
		--removeEventHandler("onClientPreRender", root, updateCamPosition)
	elseif type == "charSpawn" then 
		createGui("destroy")
		createGui(type)
		
		state2 = false
		guiSetVisible(reg.back_ground, false)
		
		if isElement(ped) then destroyElement(ped) end
		
		if isElement(contabancaria) then
		destroyElement(contabancaria)
		enter = false	
		end
		
		if isElement(webBrowser) then
		destroyElement(webBrowser)
		if isTimer(video) then
		killTimer(video)
		end
		end
		if isElement(sound) then
		destroyElement(sound)
		end
	
		
		Tick = getTickCount()
		panelType = ""
		--panelType = type
		--[[
		if isElement(ped) then destroyElement(ped) end
		if isElement(peds) then destroyElement(peds) end
		peds = createPed(getElementData(localPlayer, "char:skin"), 382.29190063477, -2028.4780273438, 7.8359375, 90)
		setPedAnimation(peds, "ON_LOOKERS", "wave_loop")
		setElementFrozen(peds,true)
		setElementDimension(peds, getElementDimension(localPlayer))
		setCameraMatrix(376.70678710938, -2028.5461425781, 8.8381004333496, 377.70413208008, -2028.5339355469, 8.7662878036499)
		removeEventHandler("onClientPreRender", root, updateCamPosition)
		data = {
			{"Nome: ".. serverColor .. getElementData(localPlayer,"char:name")},
			{"Conta ID:".. serverColor ..getElementData(localPlayer,"acc:id")},
			--{"Minutos jogados: ".. serverColor .. tonumber(getElementData(localPlayer,"char:playedTime"))},
			{"Vida: ".. serverColor .. tonumber(getElementHealth(localPlayer)).."%"},
			{"Colete: ".. serverColor .. tonumber(getPedArmor(localPlayer)).."%"},
			{"Fome: ".. serverColor .. tonumber(getElementData(localPlayer,"char:hunger") or 100).."%"},
			{"Dinheiro: R$: ".. serverColor .. penz_darabolas(tonumber(getElementData(localPlayer,"char:money"))).. ""},
			{"Saldo bancário: R$: ".. serverColor .. penz_darabolas(tonumber(getElementData(localPlayer,"char:bankmoney"))).. ""},
		}
		bindKey("enter","down",charSpawnEnter)
		]]--
		--removeEventHandler("onClientPreRender", root, updateCamPosition)
		charSpawnEnter()
		
	end
end
addEvent("checkPlayerCharacter", true)
addEventHandler("checkPlayerCharacter", root, checkPlayer)

function penz_darabolas(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isCursorOnBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
			return true
		else
			return false
		end
	end	
end


-- Camera Animáció
local camPos = {}
camPos[1] = {} 
camPos[1]["start"] = {989.42987060547, -1145.4051513672, 50.296298980713, 990.40814208984, -1145.4158935547, 50.089214324951}
camPos[1]["end"] = {1289.6910400391, -1145.3928222656, 60.02209854126, 1290.6010742188, -1145.3928222656, 59.607643127441}
camPos[1]["speed"] = 70000
camPos[1]["type"] = "Linear"


function updateCamPosition ()
	if camPos[camID] then
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = camPos[camID]["speed"]
		local easing = camPos[camID]["type"]
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				local cx,cy,cz = interpolateBetween (
					camPos[camID]["start"][1],camPos[camID]["start"][2],camPos[camID]["start"][3],
					camPos[camID]["end"][1],camPos[camID]["end"][2],camPos[camID]["end"][3],
					progress,easing
				)
				local tx,ty,tz = interpolateBetween (
					camPos[camID]["start"][4],camPos[camID]["start"][5],camPos[camID]["start"][6],
					camPos[camID]["end"][4],camPos[camID]["end"][5],camPos[camID]["end"][6],
					progress,easing
				)
				
				setCameraMatrix (cx,cy,cz,tx,ty,tz)
			else
				local nextID = false
				
				while nextID == false do
					local id = camID + 1
					if id ~= camID then
						nextID = id
					end
					if id > # camPos then 
						nextID = 1
					end
				end
				
				camFading = 2
				lastCamTick = getTickCount ()
				camID = nextID
				
				setCameraMatrix (camPos[camID]["start"][1],camPos[camID]["start"][2],camPos[camID]["start"][3],camPos[camID]["start"][4],camPos[camID]["start"][5],camPos[camID]["start"][6])
			end
		end
	end
end

function finish()

	removeEventHandler("onClientPreRender",getRootElement(),spawnChar1)
	removeEventHandler("onClientPreRender",getRootElement(),spawnChar2)
	removeEventHandler("onClientPreRender",getRootElement(),spawnChar3)
	removeEventHandler("onClientPreRender",getRootElement(),spawnChar4)
	spawnChar5()
	panelType = " "
	showCursor(false)
	showChat(true)
	--triggerServerEvent("playerLoadItemsToServer", localPlayer, localPlayer)
	setElementFrozen(localPlayer,false)
	if not getElementData(localPlayer, "adminjail") == 1 then
		setElementDimension(localPlayer, getElementData(localPlayer, "spawnPos")[5])
		setElementInterior(localPlayer, getElementData(localPlayer, "spawnPos")[4])
		setElementData(localPlayer,"loggedin",true)
	end
	--unbindKey("enter","down",charSpawnEnter)
end


function spawnChar1()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+45,x,y,z)
end

function spawnChar2()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+25,x,y,z)
end

function spawnChar3()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+15,x,y,z)
end

function spawnChar4()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+5,x,y,z)
end


function spawnChar5()
setCameraTarget(localPlayer)
setElementFrozen(localPlayer, false)
end





--[[
function loadLoginFromXML()
	local XML = xmlLoadFile ("userdata.xml")
    if not XML then
        XML = xmlCreateFile("userdata.xml", "login")
    end
	
    local usernameNode = xmlFindChild (XML, "username", 0)
    if usernameNode then
        return xmlNodeGetValue(usernameNode)
    else
		return ""
    end
    xmlUnloadFile ( XML )
end

function saveLoginToXML(username)
    local XML = xmlLoadFile ("userdata.xml")
    if not XML then
        XML = xmlCreateFile("userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (XML, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(XML, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
    xmlSaveFile(XML)
    xmlUnloadFile (XML)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", root, saveLoginToXML)





function loadLoginFromXML()
	local xml_save_log_File = xmlLoadFile ("userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("userdata.xml", "login")
    end
    local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
		return "", ""
    end
    xmlUnloadFile ( xml_save_log_File )
end

function saveLoginToXML(username, password)
    local xml_save_log_File = xmlLoadFile ("userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end		
		xmlNodeSetValue (passwordNode, tostring(password))
	end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile (xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

]]--







addEventHandler("onClientMouseEnter", getRootElement(), function()
	if (source == login.button_reg) then
		guiLabelSetColor(login.button_reg, 255, 185, 41)
	elseif (source == login.button_login) then
		guiStaticImageLoadImage(source, "assets/button_login_a.png")
	end
end)
	
addEventHandler("onClientMouseLeave", getRootElement(), function()
	if (source == login.button_reg) then
		guiLabelSetColor(login.button_reg, 153, 156, 175)
	elseif (source == login.button_login) then
		guiStaticImageLoadImage(source, "assets/button_login.png")
	end
end)

addEventHandler ("onClientGUIClick", getRootElement(), function(button)
	if button == "left" then
		if source == login.button_login then
		
				if editBox[1].text == "" and editBox[2].text == "" then
					--exports.bgo_infobox:addNotification("Campos são obrigatórios!","error")
					
				errorChek = true
				setEditBoxWarning(1, "Campos são obrigatórios!", false)
				setEditBoxWarning(2, "Campos são obrigatórios!", false)
				
					--print("CAMPOS OFF")
				else

					if isTimer(timer) then 
						--exports.bgo_infobox:addNotification("AGUARDE 1 SEGUNDO!","error")
						return end
						timer = setTimer(function() end, 3000, 1)

					triggerServerEvent("onLoginClick", localPlayer, localPlayer, editBox[1].text, editBox[2].text)
			
			end
			
			
			--triggerServerEvent("onRequestLogin", getLocalPlayer(), editBox[1].text, editBox[2].text, chekBox[1].active)



		--elseif source == login.button_reg then
		--	guiSetVisible(login.back_ground, false)
 		--	guiSetVisible(reg.back_ground, true)
		end
	end 
end)

local function showWarning(id, chek, message)
	setEditBoxWarning(id, message, chek)
end
addEvent("showWarning", true)
addEventHandler("showWarning", getRootElement(), showWarning)



local function loginPanelVisible(state) 
	guiSetVisible(reg.back_ground, state)
	--guiSetVisible(login.back_ground1, state)
	showCursor(state)
end
addEvent ("setLoginPanelVisible", true)
addEventHandler ( "setLoginPanelVisible", getRootElement(), loginPanelVisible)


function loadLoginFromXML() 
	local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
    end
    local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
		return "", ""
    end
    xmlUnloadFile ( xml_save_log_File )
end

function saveLoginToXML(username, password) --Сохрание логина и пароля в XML
    local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end		
		xmlNodeSetValue (passwordNode, tostring(password))
	end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile (xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

function resetSaveXML() --Сохрание логина и пароля в XML
	local xml_save_log_File = xmlLoadFile ("files/xml/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("files/xml/userdata.xml", "login")
	end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end		
		xmlNodeSetValue (passwordNode, "")
	end
	xmlSaveFile(xml_save_log_File)
	xmlUnloadFile(xml_save_log_File)
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

local username, password = loadLoginFromXML()
--if not( username == "" or password == "") then
	setChekBoxActive(1, true)
	setEditBoxText(1, tostring(username))
	setEditBoxText(2, tostring(password))
--else
--	setChekBoxActive(1, false)
--end




