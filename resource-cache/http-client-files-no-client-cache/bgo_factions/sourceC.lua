local dutyBlip = {}

function createDutyPickup()

	local dutyplaces = {
		--x,y,z,int,dim


		{2558.052, -2593.58, 13.794,0,0}, -- 1º BPM RADIO PTR RIO
		{2839.614, -2484.526, 11.806,0,0}, -- MARINHA RIO
		{2779.419, -2346.947, 13.694,0,0}, -- FORÇA NACIONAL RIO
		{2661.274, -2363.808, 13.694, 0, 0}, --BOPE RIO
		--{2661.1433105469,-1430.2841796875,30.484001159668,0,0}, --mecanico
		{2434.521, -2373.803, 13.694,0,0}, -- CHOQUE RIO
		{2554.975, -2434.175, 13.694,0,0}, -- RECOM RIO
		{1579.615, -1635.507, 13.561,0,0}, -- PF RIO
		{2380.409, -2519.211, 13.694,0,0}, -- 7 BATALHÃO DE RADIO PATRULHA
		{2404.934, -2636.789, 13.694,0,0}, -- 6  BATALHÃO DE RADIO PATRULHA
		{615.482, -610.617, 17.227,0,0},   -- UPP RIO
		{2745.515, -2471.671, 13.694,0,0},  -- POLICIA CIVIL CORE RIO 
		{2795.793, -2560.16, 13.694,0,0}, -- EXERCITO RIO
		{2495.1, 919.935, 11.023,0,0}, -- SAMU RIO
		{1132.292, -2037.284, 69.008,0,0}, -- PCC RIO
		--{1417.1518554688,-2281.9921875,13.3828125,0,0}, --DETRAN
		{2468.072265625,-2105.4484863281,13.546875,0,0}, --DETRAN
		{2458.561, -942.02, 80.655,0,0}, --CV RIO
		{2396.827, -1703.095, 13.455,0,0}, -- RODO RIO
		{1264.715, 308.012, 19.655,0,0}, -- moto club rio
		{2791.056, -1319.958, 34.8,0,0}, -- FDN RIO   MOVER AINDA
		{-164.739, -1710.206, 2.855,0,0}, -- ADA RIO
		{953.296, -870.195, 95.455,0,0}, -- BDM RIO
		{297.096, -1151.345, 81.055,0,0}, -- TCP RIO
		{1624.19, -763.947, 61.041,0,0}, -- ODR  RIO MOVER AINDA
		{760.315, -574.645, 20.613,0,0},  -- MLC RIO
		--{-1577.2551269531,702.78179931641,26.555364608765,0,0}, --
		--{-223.273, 1410.955, 27.773,18,2},
		--{-1820.623, 1291.955, 31.852,0,0},
		--{-1082.297, -675.757, 32.013,0,0},
		--{-113.729, -1580.106, 3.355,0,0},
		--{1224.672, 168.425, 20.269,0,0},
		--{2321.8664550781,-1245.2320556641,27.9765625,0,0}, -- 
	
	}

	
	

	-- icone no hospital
	--createPickup (319.722, -1519.272, 36.039, 3, 1318)
	--createPickup (322.669, -1499.051, 71.469, 3, 1318)
	

	--createMarker (1911.7416992188,4220.0424804688,3.0389802455902-1, "cylinder", 1.5, 55, 100, 0, 100 )
	
local dutyPickup = {}
	
	for k, v in ipairs(dutyplaces) do
		dutyBlip[k] = createPickup (dutyplaces[k][1], dutyplaces[k][2], dutyplaces[k][3], 3, 1314)
		setElementInterior(dutyBlip[k], dutyplaces[k][4])
		setElementDimension(dutyBlip[k], dutyplaces[k][5])
	end

end
addEventHandler("onClientResourceStart", getResourceRootElement(), createDutyPickup)


addEventHandler ("onClientKey", getRootElement(), function (button, state) -- Executa essa função quando o jogador pressionar ou soltar qualquer tecla.
	if not state then return end -- Não verifica ao soltar a tecla, somente ao pressionar.
		local keys = getBoundKeys ("gov") -- Obtém uma lista com todas as teclas com binds de texto.
		if keys then -- Se existe alguma tecla com bind de texto, então:
			for keyName, keyState in pairs (keys) do -- Para cada tecla com bind de texto, faça:
				if button == keyName then -- Se a tecla pressionada está com bind de texto, então:
					outputChatBox ("Tecla bloqueada: "..keyName, 255, 0, 0) -- Avisa o jogador que essa tecla foi bloqueada.
					cancelEvent () -- Cancela o efeito dessa tecla como se ela nem tivesse sido usada.
					break -- Sai do loop do FOR para não precisar verificar as demais teclas com bind de texto.
				end
		end
	end
end)


local factionNames = {
	[1]="Recruta",
	[2]="Soldado",
	[3]="Cabo",
	[4]="3° Sargento",
	[5]="2° Sargento",
	[6]="1° Sargento",
	[7]="Sub Tenente",
	[8]="2° Tenente",
	[9]="1° Tenente",
	[10]="Capitão",
	[11]="Major",
	[12]="Tenente - Coronel",
	[13]="Coronel",
	[14]="Sub Comandante Geral",
	[15]="Comandante Geral",
}


function seurankPolicia(groupID)
	local rank = exports.bgo_dashboard:getPlayerRankInFaction(groupID)
	local nome = exports.bgo_dashboard:getFactionName(groupID)
	
	setElementData(localPlayer, "job", " "..nome.." - "..factionNames[rank] )
end
addEvent("seurankPolicia", true)
addEventHandler("seurankPolicia", getRootElement(), seurankPolicia)



local factionNames2 = {
	[1]="Fogueteiro",
	[2]="Olheiro",
	[3]="Avião",
	[4]="Vapor",
	[5]="Soldado",
	[6]="Gerente da boca",
	[7]="Gerente Geral",
	[8]="Braço esquerdo",
	[9]="Braço direito",
	[10]="Sub Patrão",
	[11]="Patrão",
	[12]="",
	[13]="",
	[14]="",
	[15]="Patrão",
}


function seurankGS(groupID)
	local rank = exports.bgo_dashboard:getPlayerRankInFaction(groupID)
	local nome = exports.bgo_dashboard:getFactionName(groupID)
	
	setElementData(localPlayer, "job", " "..nome.." - "..factionNames2[rank] )
end
addEvent("seurankG", true)
addEventHandler("seurankG", getRootElement(), seurankGS)


function playGovSound()

	local sound = playSound("files/gov.mp3")
	setSoundVolume(sound, 0.5)

end
addEvent("playGovSound", true)
addEventHandler("playGovSound", getRootElement(), playGovSound)



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

function showHealthPanel(player, state)
	if state == 1 then
		addEventHandler("onClientRender", root, renderHealthPanel)
		showingHealth = true
		showCursor(true)
		
	else
		removeEventHandler("onClientRender", root, renderHealthPanel)
		showingHealth = false
			showCursor(false)

	end
end
addEvent("showHealthPanel", true)
addEventHandler("showHealthPanel", getRootElement(), showHealthPanel)

local monitorSize = {guiGetScreenSize()}
local panelSize = {400, 200}
local panelX, panelY = monitorSize[1]/2-panelSize[1]/2, monitorSize[2]/2-panelSize[2]/2
local cost = 1000
local buttons = {{"Curar"}, {"Fechar"}}
local font = "default-bold" 
function renderHealthPanel()
	if showingHealth then		
		
		dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2], tocolor(0, 0, 0, 180))
		dxDrawRectangle(panelX, panelY, panelSize[1], 25, tocolor(0, 0, 0, 230))
		
		dxDrawText("#737373BTC MTA - #00aeefHospital", panelX+400/2, panelY+12.5, panelX+400/2, panelY+12.5, tocolor(0, 0, 0, 230), 1, font, "center", "center", false, false, true, true)
		dxDrawText("#ffffffSe você quer se curar, clique em #00aeefCurar#ffffff\nO serviço custará #0094ffR$: " .. cost .. "$#ffffff.", panelX+400/2, panelY+50, panelX+400/2, panelY+50, tocolor(0, 0, 0, 230), 1.0, font, "center", "center", false, false, true, true)
		
		for k, v in ipairs(buttons) do
			
			if isInSlot(panelX-175+(k*200), panelY+130, 150, 50) then
				dxDrawRectangle(panelX-175+(k*200), panelY+130, 150, 50, tocolor(0, 174, 235, 230))
			else
				dxDrawRectangle(panelX-175+(k*200), panelY+130, 150, 50, tocolor(0, 0, 0, 230))
			end
			
			dxDrawText(v[1],panelX-301+(k*200)+400/2, panelY+153, panelX-302+(k*200)+400/2, panelY+153, tocolor(255, 255, 255, 230), 1.0, font, "center", "center", false, false, true, true)
		end
	end
end

addEventHandler("onClientClick", root,
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
		
		if button == "left" and state == "down" and showingHealth then
			
			for k, v in ipairs(buttons) do
			
				if dobozbaVan(panelX-175+(k*200), panelY+130, 150, 50, absoluteX, absoluteY) then
					if v[1] == "Fechar" then	
						showHealthPanel(localPlayer, 2)
					elseif v[1] == "Curar" then
						triggerServerEvent("gyogyitPlayer", localPlayer, localPlayer)
						showHealthPanel(localPlayer, 2)
					end
				end
			
			end
		
	
		end
	
	end
)



]]--







local scx,scy = guiGetScreenSize()
local sizeX, sizeY = 408, 200
local posX, posY = (scx-sizeX)/2, (scy-sizeY)/2

local ui = {}
local tex = {}

local function CreateFonts()
	fonts = {
		OpenSans20  = "default" --exports.nrp_fonts:DXFont( "OpenSans/OpenSans-Regular.ttf", 20, true );
	}
end

local DGS = exports.dgs
function ShowUI(img)
		if getElementData(localPlayer, "loggedin") then
		
		CreateFonts()
		local teste = dxCreateTexture("img/"..img..".png")
		ui.black_bg = DGS:dgsCreateImage( 0, 0, scx, scy, nil, false, nil, tocolor(255, 255, 255, 0) )
		ui.main = DGS:dgsCreateImage( posX*50, posY-50, sizeX, sizeY, teste, false, ui.black_bg)
		exports.dgs:dgsSetVisible (ui.black_bg, true)
		--local texto = DGS:dgsCreateLabel(0.02,0.3,1.94,1.92,texto,true,ui.main)
		--DGS:dgsSetFont ( texto, "clear" )
		for k,v in pairs(ui) do
		DGS:dgsSetAlpha(v,0)
		DGS:dgsAlphaTo(v,200,false,"OutQuad",600)
		end

		DGS:dgsMoveTo(ui.main,posX*2, posY,false,false,"OutQuad",600)


		
		
		setTimer(function()
		for k,v in pairs(ui) do
			if isElement(v) then 
			windowClosed()
			destroyElement( v ) 
			end
		end
		for k,v in pairs(tex) do
			if isElement(v) then 
			destroyElement( v ) 
			end
		end
		tex = {}
		ui = {}
		end,20000,1)
	end
end
--addCommandHandler("teste", ShowUI)
addEvent("ShowPatrulhar", true)
addEventHandler("ShowPatrulhar", root, ShowUI)



function windowClosed()
		cancelEvent()
		exports.dgs:dgsSetVisible (ui.black_bg, false)
end









addEventHandler("onClientVehicleDamage", root, function(attacker, weapon, loss, x, y, z, tire)
    if (weapon and getElementModel(source) == 548) then
        if weapon ~= 34 then
            cancelEvent()
        end
    end
end)