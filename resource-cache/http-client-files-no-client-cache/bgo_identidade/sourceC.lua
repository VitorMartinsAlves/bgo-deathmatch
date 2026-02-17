local s = {guiGetScreenSize()}
local kep = {408,248}
local panelP = {s[1]/2 - kep[1]/2,s[2]/2 - kep[2]/2}



local nev
local nev2
local lakc = "Los Santos"
local azon
local erv
local keps
local igenyl = "Brasileiro"

local hangs = false

local font = dxCreateFont("files/font.ttf",10)
local font2 = dxCreateFont("files/font2.otf",10)
local hand = dxCreateFont("files/hand.ttf",15) 
local hand2 = dxCreateFont("files/hand2.ttf",15) 
setElementData(localPlayer,"showCard",false)
-- Felrajzol

local szemelyimutat = false

function showCard(type,name,azonos,kepem,erveny)
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
addEvent("showCard",true)
addEventHandler("showCard",getRootElement(),showCard)

function destroyCard(type)
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
addEvent("destroyCard",true)
addEventHandler("destroyCard",getRootElement(),destroyCard)

local id = {85,78}

function drawCard()
	if not szemelyimutat then return end
	dxDrawImage(panelP[1]+15,panelP[2]+35,kep[1],kep[2],"files/bg.png")
	
	
 
	dxDrawText("Nome: "..nev.."\nEndereço: "..lakc.."\nExpedição: "..erv.."\nNumero do RG: "..azon.."\nNacionalidade: "..igenyl.."\nJuramento: Jurou seguir o roleplay.",panelP[1]+180,panelP[2]+116,0,0,tocolor(74, 74, 74,255),1,font2, 'left', 'top', false, false, false, true) 
	
	
	--[[
	--dxDrawText("Nome: "..nev,panelP[1]+135,panelP[2]+76,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true)
	--dxDrawText("Nome: #00AEFF"..nev.."\n#ffffffEndereço: #FFA700"..lakc.."\n#ffffffExpedição: #D24D57"..erv.."\n#ffffffNumero do RG: #7cc576"..azon.."\n#ffffffNacionalidade: #00AEFF"..igenyl.."\n#ffffffJuramento: #D24D57Jurou seguir o roleplay.",panelP[1]+179,panelP[2]+115,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) 
	
	
	dxDrawText("Endereço: "..lakc,panelP[1]+136,panelP[2]+96,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Endereço: #FFA700"..lakc,panelP[1]+135,panelP[2]+95,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true)
	
	dxDrawText("Expedição: "..erv,panelP[1]+136,panelP[2]+116,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Expedição: #D24D57"..erv,panelP[1]+135,panelP[2]+115,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) 
	
	dxDrawText("Número do RG: "..azon,panelP[1]+136,panelP[2]+136,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Numero do RG: #7cc576"..azon,panelP[1]+135,panelP[2]+135,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true)
	
	dxDrawText("Nacionalidade: "..igenyl,panelP[1]+136,panelP[2]+156,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Nacionalidade: #00AEFF"..igenyl,panelP[1]+135,panelP[2]+155,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true) 	
	
	dxDrawText("Juramento: Jurou seguir o roleplay.",panelP[1]+136,panelP[2]+176,0,0,tocolor(0,0,0,255),1,font, 'left', 'top', false, false, false, true) 
	dxDrawText("Juramento: #D24D57Jurou seguir o roleplay.",panelP[1]+135,panelP[2]+175,0,0,tocolor(255,255,255,255),1,font, 'left', 'top', false, false, false, true)
	

	]]--

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

local jobPed = {}
local job_PedPos = {
	{147, 2455.242, 2353.694, 12.298, "Identidade", 357.66049194336},
	
	{147, 1109.3682861328, -1681.8403320313, 13.538749694824, "Identidade", 270.84286499023},
	

}


function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setInterior(0)
		jobPed[index]:setDimension(0)
		jobPed[index]:setData("isSzemelyi", true)
		jobPed[index]:setData("Ped:Name",value[5])
		jobPed[index]:setData('ped >> death', true)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)


local box = {473,645}
local panels = {s[1]/2 - box[1]/2,s[2]/2 - box[2]/2}

local showed = false
local mehet = false
local marIgenyel = false
local lastClick = 0
local szoveghossz1 = 1

function onClientClickTOPed(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, element)
	if element and button == "right" and state == "down" and element:getData("isSzemelyi") then
		if not showed then
		if exports['bgo_items']:hasItem(localPlayer, 29) then 
		outputChatBox("#00AEFF[RG]:#FFFFFF Você ja tem uma identidade!",255,255,255,true)
		return 
		end
		
			showed = true
			mehet = false
			marIgenyel = false
			lastClick = 0
			szoveghossz1 = 1
			setElementData(localPlayer,"screen",true)
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
	return year.."."..month.."."..day.."."
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
					triggerServerEvent("giveItems",localPlayer,localPlayer,getPlayerName(localPlayer):gsub("_"," "),createNewKey(4),getElementModel(localPlayer),generateDate())
					outputChatBox("#00AEFF[RG]:#FFFFFF Eu solicitei com sucesso uma carteira de identificação!",255,255,255,true)
				end,5000,1)
			else
				outputChatBox("#00AEFF[RG]:#FFFFFF Por favor aguarde!",255,255,255,true)
			end	
		end
	end
	if getKeyState("backspace") and lastClick+200 <= getTickCount() then
		lastClick = getTickCount()
		mehet = false
		showed = false
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



