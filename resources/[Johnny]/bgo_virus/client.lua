local screenW,screenH = guiGetScreenSize()
local px,py = 1600,900
local x,y = (screenW/px), (screenH/py)

local RobotoCondensed = dxCreateFont("files/RobotoCondensed.ttf", 21)
local RobotoCondensed2 = guiCreateFont("files/RobotoCondensed.ttf", 15)

function dxHud()
	--if getElementData(localPlayer,"char:id") == 1 then 
    local hungry = getElementData(localPlayer, "zaraza") or 0
    dxDrawText("Nível do Corona Vírus: "..math.floor(hungry).."%", 15*x, 1192*y, 255*x, 25*y, tocolor(255, 255, 255, 255), 0.5, RobotoCondensed, "center", "center", false, false, true, true, false)
	
	dxDrawRectangle(15*x, 600*y, 240*x, (16/y)*y, tocolor(0,0,0,180), false)
    dxDrawRectangle(15*x, 600*y, 2.4*x*hungry, (16/y)*y, tocolor(255,215,0,180), false)
	--end
	end

function renderDxHud()
	addEventHandler("onClientRender", getRootElement(), dxHud)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), renderDxHud)

function centerWindow ( center_window )
	local sx, sy = guiGetScreenSize ( )
	local windowW, windowH = guiGetSize ( center_window, false )
	local x, y = ( sx - windowW ) / 2, ( sy - windowH ) / 2
	guiSetPosition ( center_window, x, y, false )
end

if not getElementData(localPlayer, "zaraza") then
	setElementData(localPlayer, "zaraza", 0)
end


restoran = {
    button = {},
    window = {},
    label = {},
	image = {}
}

function createMacMenu ()
    if isElement (restoran.window[1]) then
	    destroyElement(restoran.window[1])
		showCursor(false)
		return
	end 
    restoran.window[1] = guiCreateWindow(0, 0, 600, 300, "Medicamentos contra vírus", false)
    centerWindow(restoran.window[1])
	
	restoran.image[1] = guiCreateStaticImage(45, 50, 150, 150, "files/1.png", false, restoran.window[1])
	
	restoran.label[1] = guiCreateLabel(70, 210, 118, 35, eat[1][1].." "..eat[1][2].."", false, restoran.window[1])
    guiSetFont(restoran.label[1], RobotoCondensed2)

    restoran.button[1] = guiCreateButton(55, 250, 118, 35, "comprar", false, restoran.window[1])
    guiSetFont(restoran.button[1], "default-bold-small")
	
	
	
	restoran.image[2] = guiCreateStaticImage(230, 50, 150, 150, "files/2.png", false, restoran.window[1])
	
	restoran.label[2] = guiCreateLabel(250, 210, 118, 35, eat[2][1].." "..eat[2][2].."", false, restoran.window[1])
    guiSetFont(restoran.label[2], RobotoCondensed2)

    restoran.button[2] = guiCreateButton(240, 250, 118, 35, "comprar", false, restoran.window[1])
    guiSetFont(restoran.button[2], "default-bold-small")
	
	
	
	restoran.image[1] = guiCreateStaticImage(410, 50, 150, 150, "files/3.png", false, restoran.window[1])
	
	restoran.label[3] = guiCreateLabel(430, 210, 118, 35, eat[3][1].." "..eat[3][2].."", false, restoran.window[1])
    guiSetFont(restoran.label[3], RobotoCondensed2)
	
    restoran.button[3] = guiCreateButton(420, 250, 118, 35, "comprar", false, restoran.window[1])
    guiSetFont(restoran.button[3], "default-bold-small")
    
    restoran.button[4] = guiCreateButton(565, 25, 25, 25, "Х", false, restoran.window[1])
	guiSetFont(restoran.button[4], "default-bold-small")
	
	showCursor(true)
end

function openMainMenu ()
--if getElementData(localPlayer,"char:id") == 1 then 
    createMacMenu ()
--end
end
addEvent("openMainMenu", true)
addEventHandler("openMainMenu", getRootElement(), openMainMenu)

function onClientGUIClick ()
    local row = false
    if source == restoran.button[1] then
	    row = eat[1]
	elseif source == restoran.button[2] then
	    row = eat[2]
	elseif source == restoran.button[3] then
	    row = eat[3]
	elseif source == restoran.button[4] then
	    createMacMenu ()
		setPedAnimation (localPlayer, false)
	end
	if row ~= false then
	    triggerServerEvent("onPlayerTakeEat", localPlayer, row)
	end
end
addEventHandler("onClientGUIClick", getRootElement(), onClientGUIClick)


function hill_Enter()

		if getElementData(localPlayer, "loggedin") then	
		for k, targetPlayer in ipairs(getElementsByType("player")) do 
		if targetPlayer ~= localPlayer then
		local px, py, pz = getElementPosition(localPlayer)
		vx, vy, vz = getElementPosition(targetPlayer)
		local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if dist <= 2 then
		--if not exports['bgo_Mask']:commascara(localPlayer) then
		
		if not getElementData(localPlayer, "mascara") then
		
		--if getElementData(localPlayer, "char:id") == 36803 then return end
		
		if exports.bgo_admin:isPlayerDuty(localPlayer) or (tonumber(getElementData(localPlayer,"char:adminduty") or 0) == 1) or getElementData(localPlayer, "char:dutyfaction") == 4 or getElementData(localPlayer, "char:dutyfaction") == 1 then return end
		
		local hungry = getElementData(localPlayer, "zaraza")
		if tonumber(hungry) > 90 then
        setElementHealth(localPlayer, getElementHealth(localPlayer) - 40 )
		setElementData(localPlayer, "zaraza", 100)
		end

		local rand = math.random(1,10)
		setElementData(localPlayer, "zaraza", getElementData(localPlayer, "zaraza") + rand)
		--outputChatBox("Você tem #FFFF00"..rand.." #FFFFFFunidades de infecção do corona virus", 255, 255, 255, true)
		--outputChatBox("Fique a 1 metro de distância das pessoas", 255, 255, 255, true)
		exports.JoinQuitGtaV:createNotification("corona", "*Você Pegou "..rand.." infecção do corona virus, Fique a 1 metro de distância das pessoas!", 5)
		--print("Contaminado por "..getPlayerName(targetPlayer).." ")
		--end
		end
				return
				end
			end
			end
		end
	--end
end
setTimer(hill_Enter, 30000,0)

function Spawn()
setElementData(localPlayer, "zaraza", 0)
end
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), Spawn )


--exports.JoinQuitGtaV:createNotification("corona", "*A cidade foi infectada com o vírus!!!  Caso você esteja com o vírus vá no hospital se curar!", 5)