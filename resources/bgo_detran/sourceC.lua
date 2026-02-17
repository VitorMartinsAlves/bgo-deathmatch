local s = {guiGetScreenSize()}
local kep = {408,248}
local panelP = {s[1]/2 - kep[1]/2,s[2]/2 - kep[2]/2}



local nev
local nev2
local lakc = "Cidade de Los Santos"
local azon
local erv
local keps
local igenyl = "BGO LV"

local hangs = false

local font = dxCreateFont("files/font.ttf",10)
local font2 = dxCreateFont("files/font2.otf",10)
local hand = dxCreateFont("files/hand.ttf",25) 
local hand2 = dxCreateFont("files/hand.ttf",18) 
setElementData(localPlayer,"showJogsi",false)
-- Felrajzol

local jogsimutat = false

function showJogsi(type,name,azonos,kepem,erveny)
	if type == 2 then
		jogsimutat = true
		azon = azonos
		erv = erveny
		nev = name
		nev2 = name
		keps = kepem
	end
end
addEvent("showJogsi",true)
addEventHandler("showJogsi",getRootElement(),showJogsi)

function destroyJogsi(type)
	if type == 2 then
		jogsimutat = false
		azon = ""
		erv = ""
		nev = ""
		nev2 = ""
		keps = ""
	end
end
addEvent("destroyJogsi",true)
addEventHandler("destroyJogsi",getRootElement(),destroyJogsi)

local id = {85,78}

function drawCard()
	if not jogsimutat then return end
	dxDrawImage(panelP[1]+15,panelP[2]+35,kep[1],kep[2],"files/bg.png")
	
	dxDrawText("Nome: "..nev.."\nEndereço: "..lakc.."\nExpiração: "..erv.."\nIdentificação: "..azon.."\nEmissor: "..igenyl.."\nÓrgão: BGO DRVV",panelP[1]+180,panelP[2]+116,0,0,tocolor(74, 74, 74,255),1,font2, 'left', 'top', false, false, false, true) 
	
	
	--[[
	
	dxDrawText("Nome: "..nev,panelP[1]+135,panelP[2]+76,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) -- Név
	dxDrawText("Nome: #00AEFF"..nev,panelP[1]+134,panelP[2]+75,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) -- Név
	
	dxDrawText("Endereço: "..lakc,panelP[1]+136,panelP[2]+96,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) -- Lakcím
	dxDrawText("Endereço: #FFA700"..lakc,panelP[1]+135,panelP[2]+95,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) -- Lakcím
	
	dxDrawText("Expiração: "..erv,panelP[1]+136,panelP[2]+116,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) -- Érvényesség
	dxDrawText("expiração: #D24D57"..erv,panelP[1]+135,panelP[2]+115,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) -- Érvényesség
	
	dxDrawText("Identificação: "..azon,panelP[1]+136,panelP[2]+136,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) -- Azonosító
	dxDrawText("identificação: #7cc576"..azon,panelP[1]+135,panelP[2]+135,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) -- Azonosító
	
	dxDrawText("Emissor: "..igenyl,panelP[1]+136,panelP[2]+156,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) -- Igénylő
	dxDrawText("Emissor: #00AEFF"..igenyl,panelP[1]+135,panelP[2]+155,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) -- Igénylő	
	
	dxDrawText("Órgão: BGO DRVV",panelP[1]+136,panelP[2]+176,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) -- Igénylő
	dxDrawText("Órgão: #D24D57BGO DRVV",panelP[1]+135,panelP[2]+175,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) -- Igénylő

	]]--

end
addEventHandler("onClientRender",getRootElement(),drawCard)


--



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

--[[
local igenylo = createPed(147,775.82891845703, -1433.5281982422, 13.535365104675,179.92855834961)
setElementFrozen(igenylo,true)
igenylo:setInterior(0)
igenylo:setDimension(0)
igenylo:setData("isJogsi",true)
igenylo:setData("Ped:Name","David")
setElementData(igenylo, 'ped >> death', true)
]]--

local box = {473,645}
local panels = {s[1]/2 - box[1]/2,s[2]/2 - box[2]/2}

local showedJogsi = false
local mehet = false
local lastClick = 0
local szoveghossz1 = 1

local honap = {
	{"janeiro"},
	{"fevereiro"},
	{"março"},
	{"abril"},
	{"maio"},
	{"Junho"},
	{"Julho"},
	{"Agosto"},
	{"setembro"},
	{"outubro"},
	{"novembro"},
	{"dezembro"},
}

local characters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y"}
function createNewKey(size)
	local code = math.random(100, 500)
	for i = 1, size do
		a = math.random(1,#characters)
		x=string.upper(characters[a])
		code = code .. x
	end
	return code
end


local monthDays = {
	[1] = 31, -- jan
	[2] = 28, -- feb
	[3] = 31, -- márc
	[4] = 30, -- ápr
	[5] = 31, -- máj
	[6] = 30, -- jún
	[7] = 31, -- júl
	[8] = 31, -- aug
	[9] = 30, -- szept
	[10] = 31, -- okt
	[11] = 30, -- nov
	[12] = 31, -- dec
}


function generateDate(year,month,day)
	local realTime = getRealTime()
	local year, month, day = year or realTime.year + 1900, month or realTime.month + 1, day or realTime.monthday
	if day+28 > monthDays[month] then
		if month+1 > 12 then
			year = year + 1
			month = month - 11
		else
			month = month + 1
		end
	else
		day = day + 28
	end
	if day > monthDays[month] then
		day = monthDays[month]
	elseif month > 12 then
		month = 12
	end
	if month < 10 then
		month = "0"..month
	end
	if day < 10 then
		day = "0"..day
	end
	return year.."."..month.."."..day.."."
end



local nev2 = getPlayerName(localPlayer):gsub("_"," ")

function onClientClickTOPed(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, element)
	if element and button == "right" and state == "down" and element:getData("isJogsi") then
		--if localPlayer:getData("license.car") == 1 then

			if not exports.bgo_items:hasItemS(localPlayer,28) then


			outputChatBox("#00AEFF[licença]:#ffffff Você solicitou com sucesso uma carta de condução!",255,255,255,true)
			triggerServerEvent("giveJogsi",localPlayer,localPlayer,getPlayerName(localPlayer):gsub("_"," "),createNewKey(4),getElementModel(localPlayer),generateDate())
		else
			outputChatBox("#00AEFF[licença]:#ffffff Você não tem licença!",255,255,255,true)
		end
	end
end
--addEventHandler ( "onClientClick", getRootElement(), onClientClickTOPed )



function drawIgenylo()
	if not showedJogsi then return end
	dxDrawImage(panels[1],panels[2],box[1],box[2],"files/igenylo.png")
	dxDrawText(getPlayerName(localPlayer):gsub("_"," "),panels[1]+120,panels[2]+70,0,0,tocolor(0,0,0,150),1,font)
	dxDrawText("Los Santos",panels[1]+120,panels[2]+90,0,0,tocolor(0,0,0,150),1,font)
	local rtime = getRealTime()
	dxDrawText("Los Santos",panels[1]+95,panels[2]+443,0,0,tocolor(0,0,0,150),1,font)
	dxDrawText(rtime.year+1900,panels[1]+180,panels[2]+443,0,0,tocolor(0,0,0,150),1,font)
	dxDrawText(honap[rtime.month+1][1],panels[1]+250,panels[2]+443,0,0,tocolor(0,0,0,150),1,font)
	dxDrawText(rtime.monthday,panels[1]+325,panels[2]+443,0,0,tocolor(0,0,0,150),1,font)
	szoveg = string.sub(getPlayerName(localPlayer):gsub("_"," "), 1,szoveghossz1)
	
		if(getTickCount() %4 == 0) then
			if mehet then
			local szovegHossz = utfLen(getPlayerName(localPlayer):gsub("_"," "))
			if szoveghossz1 < szovegHossz then
				szoveghossz1 = szoveghossz1 +0.2
			end
			if not hangs then
			hangs = true
				hang = playSound("files/sign.mp3")
			end
		end
	end
	if mehet then
		dxDrawText(szoveg,panels[1]+345,panels[2]+515,0,0,tocolor(0,161,255,150),1,hand2)
	end
	if isInSlot(panels[1]+290,panels[2]+510,150,30) then
		if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
			lastClick = getTickCount()
			mehet = true
			setTimer(function()
				mehet = false
				showedJogsi = false
				setElementData(localPlayer,"screen",false)
				triggerServerEvent("giveJogsi",localPlayer,localPlayer,getPlayerName(localPlayer):gsub("_"," "),createNewKey(4),getElementModel(localPlayer),generateDate())
				outputChatBox("#00AEFF[licença]:#ffffff você solicitou com sucesso uma carta de condução!",255,255,255,true)
			end,5000,1)
		end
	end
	if getKeyState("backspace") and lastClick+200 <= getTickCount() then
		lastClick = getTickCount()
		mehet = false
		showedJogsi = false
		setElementData(localPlayer,"screen",false)
	end
	--dxDrawRectangle(panels[1]+290,panels[2]+510,150,30,tocolor(255,0,0,255))
end
addEventHandler("onClientRender",getRootElement(),drawIgenylo)

addEventHandler("onClientPedDamage",  getRootElement(), function ()
	if (getElementData(source, "ped >> death")) then
		cancelEvent()
	end
end)

addEventHandler("onClientPlayerStealthKill", getRootElement(), function(targetPlayer) 
	if (getElementType(targetPlayer) == 'ped' and getElementData(targetPlayer, "ped >> death")) then  
		cancelEvent()
	end
end)
