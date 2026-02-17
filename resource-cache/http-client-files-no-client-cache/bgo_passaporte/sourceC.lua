local s = {guiGetScreenSize()}
local kep = {408,248}
local panelP = {s[1]/2 - kep[1]/2,s[2]/2 - kep[2]/2}



local nev
local nev2
local lakc = "Los Santos"
local azon
local erv
local keps
local igenyl = "Las Venturas"

local hangs = false

local font = dxCreateFont("files/font.ttf",10)
local hand = dxCreateFont("files/hand.ttf",15) 
local hand2 = dxCreateFont("files/hand2.ttf",15) 
setElementData(localPlayer,"showCard",false)
-- Felrajzol

local szemelyimutat = false

function showPassaporte(type,name,azonos,kepem,erveny)
	if type == 1 then
		szemelyimutat = true
		azon = azonos
		erv = erveny
		nev = name
		nev2 = name
		keps = kepem
		
		addEventHandler("onClientRender",getRootElement(),drawCard)
		
	end
end
addEvent("showPassaporte",true)
addEventHandler("showPassaporte",getRootElement(),showPassaporte)

function destroyPassaporte(type)
	if type == 1 then
		szemelyimutat = false
		azon = ""
		erv = ""
		nev = ""
		nev2 = ""
		keps = ""
		
		removeEventHandler("onClientRender",getRootElement(),drawCard)
		
		
	end
end
addEvent("destroyPassaporte",true)
addEventHandler("destroyPassaporte",getRootElement(),destroyPassaporte)

local id = {85,78}

function drawCard()
	if not szemelyimutat then return end
	dxDrawImage(panelP[1]+15,panelP[2]+35,kep[1],kep[2],"files/bg.png")
	
	
	dxDrawText("Nome: "..nev,panelP[1]+135,panelP[2]+76,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Nome: #00AEFF"..nev,panelP[1]+134,panelP[2]+75,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) 
	
	dxDrawText("Endereço: "..lakc,panelP[1]+136,panelP[2]+96,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Endereço: #FFA700"..lakc,panelP[1]+135,panelP[2]+95,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true)
	
	dxDrawText("Vencimento: "..erv,panelP[1]+136,panelP[2]+116,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Vencimento: #D24D57"..erv,panelP[1]+135,panelP[2]+115,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) 
	
	dxDrawText("Número do passaporte: "..azon,panelP[1]+136,panelP[2]+136,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Numero do passaporte: #7cc576"..azon,panelP[1]+135,panelP[2]+135,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true)
	
	dxDrawText("Nacionalidade: "..igenyl,panelP[1]+136,panelP[2]+156,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Nacionalidade: #00AEFF"..igenyl,panelP[1]+135,panelP[2]+155,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) 	
	
	--dxDrawText("Juramento: Jurou seguir o roleplay.",panelP[1]+136,panelP[2]+176,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	--dxDrawText("Juramento: #D24D57Jurou seguir o roleplay.",panelP[1]+135,panelP[2]+175,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true)

end





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


local igenylo = createPed(147,2471.243, 2387.93, 12.297, 91.297088623047)
setElementFrozen(igenylo,true)
igenylo:setInterior(0)
igenylo:setDimension(0)
igenylo:setData("Sys:Passaporte",true)
igenylo:setData("Ped:Name","Passaporte")
setElementData(igenylo, 'ped >> death', true)

local box = {473,645}
local panels = {s[1]/2 - box[1]/2,s[2]/2 - box[2]/2}

local showed = false
local mehet = false
local marIgenyel = false
local lastClick = 0
local szoveghossz1 = 1

function onClientClickTOPed(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, element)
	if element and button == "right" and state == "down" and element:getData("Sys:Passaporte") then
		if not showed then
		
		local lv = tonumber(getElementData(localPlayer, "Sys:Level" ) or 0)
		if lv < 3 then
		exports.bgo_hud:dm("Você precisa ter no mínimo level 3 para poder emitir o passaporte!", 255, 255, 255)
		return 
		end
		
		if exports['bgo_items']:hasItem(localPlayer, 111) then 
		outputChatBox("#00AEFF[Passaporte]:#FFFFFF Você ja tem um passaporte!",255,255,255,true)
		return 
		end
		
			showed = true
			mehet = false
			marIgenyel = false
			lastClick = 0
			szoveghossz1 = 1
			setElementData(localPlayer,"screen",true)
			addEventHandler("onClientRender",getRootElement(),drawIgenylo)
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), onClientClickTOPed )

local honap = {
	{"Janeiro"},
	{"Fefereiro"},
	{"Março"},
	{"Abril"},
	{"Maio"},
	{"Junho"},
	{"Julho"},
	{"Agosto"},
	{"Setemro"},
	{"Outubro"},
	{"Novembro"},
	{"Dezembro"},
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
	[1] = 31, 
	[2] = 28, 
	[3] = 31, 
	[4] = 30, 
	[5] = 31, 
	[6] = 30, 
	[7] = 31, 
	[8] = 31, 
	[9] = 30, 
	[10] = 31, 
	[11] = 30, 
	[12] = 31, 
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
	return (day+15).."."..(month-1).."."..year..""
end



local nev2 = getPlayerName(localPlayer):gsub("_"," ")

function drawIgenylo()
	if not showed then return end
	dxDrawImage(panels[1],panels[2],box[1],box[2],"files/igenylo.png")
	dxDrawText(getPlayerName(localPlayer):gsub("_"," "),panels[1]+1116,panels[2]+608,0,0,tocolor(0,0,0,255),1,hand,'center','center',false,false,false,true)
	dxDrawText(getPlayerName(localPlayer):gsub("_"," "),panels[1]+1115,panels[2]+607,0,0,tocolor(0,167,255,255),1,hand,'center','center',false,false,false,true)
	dxDrawText("Los Santos",panels[1]+161,panels[2]+225,0,0,tocolor(0,0,0,255),1,hand)
	dxDrawText("Los Santos",panels[1]+160,panels[2]+224,0,0,tocolor(255,167,0,255),1,hand)
	local rtime = getRealTime()
	dxDrawText("Los Santos",panels[1]+86,panels[2]+492,0,0,tocolor(0,0,0,255),1,hand)
	dxDrawText("Los Santos",panels[1]+85,panels[2]+491,0,0,tocolor(215,85,85,255),1,hand)
	dxDrawText(rtime.year+1900,panels[1]+51,panels[2]+521,0,0,tocolor(0,0,0,255),1,hand)
	dxDrawText(rtime.year+1900,panels[1]+50,panels[2]+520,0,0,tocolor(215,85,85,255),1,hand)
	dxDrawText(", "..honap[rtime.month+1][1],panels[1]+101,panels[2]+521,0,0,tocolor(0,0,0,255),1,hand)
	dxDrawText(", "..honap[rtime.month+1][1],panels[1]+100,panels[2]+520,0,0,tocolor(215,85,85,255),1,hand)
	dxDrawText(", "..rtime.monthday,panels[1]+171,panels[2]+521,0,0,tocolor(0,0,0,255),1,hand)
	dxDrawText(", "..rtime.monthday,panels[1]+170,panels[2]+520,0,0,tocolor(215,85,85,255),1,hand)
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
		dxDrawText(szoveg,panels[1]+321,panels[2]+401,0,0,tocolor(0,0,0,0),1,hand2)
		dxDrawText(szoveg,panels[1]+320,panels[2]+400,0,0,tocolor(0,161,255,255),1,hand2)
	end
	if isInSlot(panels[1]+320,panels[2]+400,150,30) then
		if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
			if not marIgenyel then
				lastClick = getTickCount()
				mehet = true
				marIgenyel = true
				setTimer(function()
					mehet = false
					showed = false
					marIgenyel = false
					setElementData(localPlayer,"screen",false)
					triggerServerEvent("giveItemsPassaporte",localPlayer,localPlayer,getPlayerName(localPlayer):gsub("_"," "),createNewKey(4),getElementModel(localPlayer),generateDate())
					removeEventHandler("onClientRender",getRootElement(),drawIgenylo)
					--outputChatBox("#00AEFF[Passaporte]:#FFFFFF Eu solicitei com sucesso uma carteira de passaporte!",255,255,255,true)
				end,5000,1) 
			else
				outputChatBox("#00AEFF[Passaporte]:#FFFFFF Por favor aguarde!",255,255,255,true)
			end	
		end
	end
	if getKeyState("backspace") and lastClick+200 <= getTickCount() then
		lastClick = getTickCount()
		mehet = false
		showed = false
		setElementData(localPlayer,"screen",false)
		removeEventHandler("onClientRender",getRootElement(),drawIgenylo)
	end
	--dxDrawRectangle(panels[1]+290,panels[2]+510,150,30,tocolor(255,0,0,255))
end



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



