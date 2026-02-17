local s = {guiGetScreenSize()}
local scx, scy = guiGetScreenSize()
local radarS = {s[1]-600, s[2]-300}
--local radarS = {s[1], s[2]}

local radarP = {s[1]/2-radarS[1]/2 - 200, s[2]/2-radarS[2]/2}



local vizSzin = tocolor(110, 158, 204,255)
local nagymap
local radarM = {3072,3072}
local blipMeret = {20,20}
local blipMeret2 = {30,30}
local jatekosMeret = {12,12}
local zoom = 1.3
local minZoom = 1
local maxZoom = 3
local zoomRadio = 0.16
local mozgatAdat = {0,0}
local honnanMozgat = {0,0}
local chatetRejtett = false
utiBlip = nil

gpsPontok = {}
radarMegjelenitve = false -- Ha ez igaz akkor a minimapot nem rendereli


local texture = dxCreateTexture( "gps/gfx/gtasa.png", "dxt5", true, "clamp", "3d")
local texture2 = dxCreateTexture( "gps/gfx/gtasaPoli.png", "dxt5", true, "clamp", "3d")


addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( resource )
		if resource ~= getThisResource() then return end

        toggleControl("radar", true)
		setPlayerHudComponentVisible("radar",false)
		nagymap=dxCreateRenderTarget(radarS[1], radarS[2],false)
end
);



addEventHandler("onClientKey", getRootElement(), function(gomb, statusz)
	if(gomb == "F11" and statusz) then
		togRadar()
		cancelEvent()
	end
end)

function togRadar()
	if getElementData(localPlayer, "SEQUESTRANDO:Vitima") == true then return end
	if(radarMegjelenitve) then
		radarMegjelenitve = false
		ujRadarElrejtes()
		showChat(true)
		--showCursor(false)
		fel_le = false
		
		removeEventHandler("onClientRender", root, asdada)	
		removeEventHandler("onClientKey",root,keyControl)

		setElementData(localPlayer,"hud", false)

	else
		fel_le = true
		radarMegjelenitve = true

addEventHandler("onClientRender", root, asdada)	
addEventHandler("onClientKey",root,keyControl)

		setElementData(localPlayer,"hud", true)
		ujRadarMegjelenites()
		showChat(false)
		mozgatAdat = {0,0}
		--showCursor(true,false)
	end
end

function ujRadarMegjelenites()
	if not radarMegjelenitve then return end
	addEventHandler("onClientRender", getRootElement(), ujRadarRender)
end

--[[
addEventHandler( "onClientMouseWheel", getRootElement( ),
    function ( fel_le )
		if not radarMegjelenitve then return end
		
        if(fel_le == 1) then
			if(zoom < maxZoom) then
				zoom = zoom + zoomRadio
			end
		elseif(fel_le == -1) then
			if(zoom > minZoom) then
				zoom = zoom - zoomRadio
			end
		end
    end
)]]--

function utvonalTervezes(x,y,z,hx,hy,hz)
	local utvonal = calculatePathByCoords(x,y,z,hx,hy,hu)
	if not utvonal then
		outputConsole('Nenhum destino encontrado.')
		return
	end
	gpsPontok = {}
	for i,node in ipairs(utvonal) do
		table.insert(gpsPontok, {x = node.x, y = node.y, id=i})
	end
end
addEvent("radargpsC", true)
addEventHandler("radargpsC", root, utvonalTervezes)

function nagyMapKattintas ( gomb, statusz, x, y, worldX, worldY, worldZ )
	--if panelState then 
	--if isTimer(timer) then return end
	--timer = setTimer(function() end, 3000, 1)

	if(radarMegjelenitve) then
	
	
		if(gomb == "right" and statusz == "down" and nagyMapKattintas) then
			if(x > radarP[1] and x < radarP[1]+radarS[1] and y > radarP[2] and y < radarP[2]+radarS[2]) then
			
			
			
			
				if #gpsPontok == 0 then
					local jx, jy, jz = getElementPosition(localPlayer)

					jx, jy = jx+mozgatAdat[1], jy+mozgatAdat[2], jz+mozgatAdat[2]
					local kx = jx+((((x-radarP[1])-(radarS[1]/2))*2)*zoom)
					local ky = jy-((((y-radarP[2])-(radarS[2]/2))*2)*zoom)
					
					
					local jx2, jy2, jz2 = getElementPosition(localPlayer)
					distance = getDistanceBetweenPoints3D(kx, ky, 0, jx2, jy2, jz2)
					if math.floor(distance) <= 1600 then

					

					
					local ejx, ejy, ejz = getElementPosition(localPlayer)
					local utvonal = calculatePathByCoords(ejx, ejy, ejz,kx,ky, 0)
					if not utvonal then
						return
					end
					gpsPontok = {}
					for i,node in ipairs(utvonal) do
						table.insert(gpsPontok, {x = node.x, y = node.y, id=i})
					end
					

					
					exports.bgo_hud:dm("GPS MARCADO A "..math.floor(distance).." METROS DE DISTÂNCIA", 255, 200, 0)
	
					
					--local position = toJSON({kx,ky,0})
					--setElementData(localPlayer, "posicaoadmin", kx,ky,0)

					if getPedOccupiedVehicle(localPlayer) then
					--exports.bgo_chat:sendLocalMeMessage(localPlayer, "Marcou no GPS um local")
					for seat, occupant in pairs(getVehicleOccupants(getPedOccupiedVehicle(localPlayer))) do -- Loop through the array
					triggerServerEvent("radargpsS", occupant, occupant, kx,ky,kz)
					if(utiBlip) then
						destroyElement(utiBlip)
						utiBlip = nil
					end
					utiBlip = createBlip(kx,ky, 0, 41, 2, 255, 255, 255, 255, 0)
					--setElementVisibleTo ( utiBlip, occupant, true )
					--setElementData(utiBlip,"blip >> blipOnScreen", true)
					end
					end

					if(utiBlip) then
						destroyElement(utiBlip)
						utiBlip = nil
					end
					utiBlip = createBlip(kx,ky, 0, 41, 2, 255, 255, 255, 255, 0)
					--setElementData(utiBlip,"blip >> blipOnScreen", true)
					else
					exports.bgo_hud:dm("Rota indisponível, não a sinal nessa distância marcada, tente marcar mais próximo", 255, 200, 0)
					end
				else
					gpsPontok = {}
					if(utiBlip) then
						destroyElement(utiBlip)
						utiBlip = nil
					end
			
				end
			end
			
		elseif(gomb == "left") then
			if(statusz == "down") then
			if isInSlot(0, 0, radarS[1], radarS[2]) then
				honnanMozgat = {x+mozgatAdat[1],y-mozgatAdat[2]}
				end
			end
			if(statusz == "up") then
			if isInSlot(0, 0, radarS[1], radarS[2]) then
				honnanMozgat = {0,0}
				end
			end
		
	end
end
end
addEventHandler ( "onClientClick", getRootElement(), nagyMapKattintas )

local blipNeve = "Destino"

local blipNames = {
	[41] = "Destino",
  
}
panelState = true
--[[
local panelState = true
function handleMinimize()
    panelState = false 
end
addEventHandler( "onClientMinimize", root, handleMinimize )

function handleRestore( didClearRenderTargets )
    panelState = true 
end
addEventHandler("onClientRestore",root,handleRestore)

]]--


addEventHandler("onClientKey", getRootElement(), 
	function(k, v)
		if not v then
			return
		end
		if radarMegjelenitve then
		if getElementData(localPlayer, 'loggedin') == false  then
			return
		end
		if isInSlot(0, 0, radarS[1], radarS[2]) then
		if (k == "mouse_wheel_down") and radarMegjelenitve then 
		if(zoom < maxZoom) then
			zoom = zoom + zoomRadio
		end		
		elseif (k == "mouse_wheel_up") and radarMegjelenitve then 
		if(zoom > minZoom) then
			zoom = zoom - zoomRadio
				end	
			end	
		end			
		end
	end
)


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


function facgps(commandName, numero)

		local value = getElementData(localPlayer,"char:adminduty")
		if value == 1 and not (tonumber(getElementData(localPlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não pode usar esta função no modo admin", 255, 194, 14, true) return end
	
		if not tonumber(numero) then return end
		local allapot = getElementData(localPlayer, "ver:facs")
		if allapot == false then			
				numerofac = tonumber(numero)
				outputChatBox("Você agora está vendo pessoas da fac "..numero.." no gps ", 255, 255, 255, true)
				setElementData(localPlayer, "ver:facs", true)
				setElementData(localPlayer, "fac:numero", numerofac)
		else
			outputChatBox("Você não está mais vendo pessoas de facs no gps!", 255, 255, 255, true)
			setElementData(localPlayer, "ver:facs", false)
			numerofac = nil
			setElementData(localPlayer, "fac:numero", numerofac)
		end
end
addCommandHandler("verfacgps", facgps, false, false)

local ficou = false
local maxElem = 20
local nextPage = 0
local numero = 0
local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local sx222,sy222 =  (screenW/resW), (screenH/resH)
function asdada()
--if not asdasd then return end
	if fel_le then
	if not nagymap then return end
		--local v = nil
		local elem = 0
		for index,v in ipairs(getElementsByType ("blip")) do
		numero = index
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			blipNeve = getElementData(v, "blipName") or "Desconhecido!"
			local szovegHossz = dxGetTextWidth(blipNeve, 1, "default-bold")+10
		
		
		if isInSlot(sx222*1035,sy222*55+elem*(sx222*30),sx222*290/200 * szovegHossz,sy222*25) then
		--setElementData(localPlayer,"piscar", v)
		if isTimer(tempo) then
		killTimer(tempo)
		end
		ficou = v
		
		tempo = setTimer(function()
		ficou = false
		end,5000,1)
		dxDrawRectangle(sx222*1035,sy222*55+elem*(sx222*30),sx222*290/200 * szovegHossz,sy222*25,tocolor(0,0,0,140))
		else
		--setElementData(localPlayer,"piscar", false)
		dxDrawRectangle(sx222*1035,sy222*55+elem*(sx222*30),sx222*290/200 * szovegHossz,sy222*25,tocolor(0,0,0,240))
		end
		
		
		dxDrawText(blipNeve, sx222*1065,sy222*60+elem*(sx222*30),sx222,sy222, tocolor(255, 255, 255, 215), sx222*0.8, "default-bold", "left", "top", false, false, false, true)
		
		dxDrawText("Scrool do mouse descer/subir a lista!", sx222*1065+1.5,sy222*700+1.5,sx222,sy222, tocolor(0, 0, 0, 215), sx222*1, "default-bold", "left", "top", false, false, false, true)
		dxDrawText("Scrool do mouse descer/subir a lista!", sx222*1065,sy222*700,sx222,sy222, tocolor(255, 255, 255, 215), sx222*1, "default-bold", "left", "top", false, false, false, true)
		
		
		
		local bcR, bcG, bcB = 255, 255, 255
		if getBlipIcon(v) == 0 or getBlipIcon(v) == 61 then
			bcR, bcG, bcB = getBlipColor(v)
		end
		local blip_icon = getBlipIcon  ( v)
		dxDrawImage ( sx222*1035,sy222*55+elem*(sx222*30),sx222*20,sy222*25, "tex/blip2/"..blip_icon..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, 245))
			end
		end
	end
end


function nagyMapKattintas222 ( gomb, statusz, x1, y1, worldX, worldY, worldZ )
	if fel_le then
		if isTimer(timer) then return end
		timer = setTimer(function() end, 3000, 1)
	
		if(gomb == "left" and statusz == "down" ) then
		local elem = 0
		for index,v in ipairs(getElementsByType ("blip")) do
		if (index > nextPage and elem < maxElem) then
			elem = elem + 1
			blipNeve = getElementData(v, "blipName") or "Desconhecido!"
			local szovegHossz = dxGetTextWidth(blipNeve, 1, "default-bold")+10
			
		if isInSlot(sx222*1035,sy222*55+elem*(sx222*30),sx222*290/200 * szovegHossz,sy222*25) then
		
		 local x,y,z = getElementPosition(v)
		
		exports.Script_futeis:setGPS("Coordenada", x, y, z)
		--print(" "..blipNeve..", "..x..", "..y..", "..z.."")

		exports.bgo_hud:dm("Você marcou o gps no destino: "..blipNeve.." boa viagem!", 255, 200, 0)


		radarMegjelenitve = false
		ujRadarElrejtes()
		showChat(true)
		--showCursor(false)
		fel_le = false
		
		removeEventHandler("onClientRender", root, asdada)	
		removeEventHandler("onClientKey",root,keyControl)

		setElementData(localPlayer,"hud", false)
		
		
		end

			end
		end
	end
end
end
addEventHandler ( "onClientClick", getRootElement(), nagyMapKattintas222 )

function keyControl(k, s)
if isInSlot(sx222*1015,sy222*0,sx222*360,sy222*1025) then
	if k == "mouse_wheel_up" then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif k == "mouse_wheel_down" then
			nextPage = nextPage + 1

		if(nextPage > numero-maxElem)then
			nextPage = numero-maxElem
		end
	end
	end
end	




			
local foi = false
function ujRadarRender()
	if panelState then
	if not nagymap then return end
	
				if not isInSlot(0, 0, radarS[1], radarS[2]) then
				honnanMozgat = {0,0}
				end
				
				
	--exports["zGPainelBlur"]:dxDrawBluredRectangle(radarP[1], radarP[2], radarS[1], radarS[2], tocolor(255, 255, 255, 255))
	if(honnanMozgat[1] ~= 0 or honnanMozgat[2] ~= 0) then
		local kx, ky = getCursorPosition ( )
		if(kx and ky) then
			kx, ky = kx*s[1], ky*s[2]
			mozgatAdat = {kx-honnanMozgat[1], ky-honnanMozgat[2]}
			mozgatAdat = {math.max(math.min(-mozgatAdat[1],6000),-6000), math.max(math.min(mozgatAdat[2], 6000), -6000)}
			
			--mozgatAdat = {math.max(math.min(-mozgatAdat[1], 3072),-3072), math.max(math.min(mozgatAdat[2], 3072), -3072)}
			
			
		end
	end
	if(getKeyState ( "num_add" )) then
		if(zoom > minZoom) then
			zoom = zoom - zoomRadio
		end
	end
	if(getKeyState ( "num_sub" )) then
		if(zoom < maxZoom) then
			zoom = zoom + zoomRadio
		end
	end
	
	
	
	if(getKeyState ( "num_4" )) then
		mozgatAdat[1] = mozgatAdat[1] - 5
	end
	if(getKeyState ( "num_6" )) then
		mozgatAdat[1] = mozgatAdat[1] + 5
	end

	
	

	
	dxSetRenderTarget(nagymap,true)
	dxDrawRectangle ( 0, 0, radarS[1], radarS[2], vizSzin, false )
	
	
	local jx, jy, _ = getElementPosition(localPlayer)
	jx, jy = jx+mozgatAdat[1], jy+mozgatAdat[2]
	local e1,e2,e3,e4=(((3000)+jx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom), ((3000-jy)/(6000)*radarM[2])-((radarS[2]/2)*zoom), radarS[1]*zoom, radarS[2]*zoom
	local xplussz, yplussz = 0, 0
	if(e2+(radarS[2]*zoom) >= radarM[2]) then
		yplussz = radarM[2]-(e2+(radarS[2]*zoom))
	end
	if(e2 <= 0) then
		yplussz = 0-e2
	end
	if(e1+(radarS[1]*zoom) >= radarM[1]) then
		xplussz = radarM[1]-(e1+(radarS[1]*zoom))
	end
	if(e1 <= 0) then
		xplussz = 0-e1
	end
	local axm, aym = 0, 0
	if exports.bgo_admin:isPlayerDuty(localPlayer) or getElementData(localPlayer, "char:adminduty") == 1 then
	dxDrawImageSection(0+(xplussz/zoom),0+(yplussz/zoom),radarS[1],radarS[2],e1+xplussz,e2+yplussz,e3,e4,texture2,0,0,0,tocolor(255, 255, 255, 255),false)
	else
	dxDrawImageSection(0+(xplussz/zoom),0+(yplussz/zoom),radarS[1],radarS[2],e1+xplussz,e2+yplussz,e3,e4,texture,0,0,0,tocolor(255, 255, 255, 255),false)
	end
	local ux, uy = nil, nil
	--local alapBeallitasok = exports['ace_rendszer']:getAlapBeallitasok()
	

	for i,utvonal in ipairs(gpsPontok) do

		local x,y = utvonal.x, utvonal.y
		local n_x = (((((3000)+x)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
		local n_y = ((((3000-y)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
		if(ux and uy) then
			dxDrawLine ( ux, uy, n_x, n_y, tocolor(124, 197, 118), 3 )
			ux, uy = n_x, n_y
		else
			ux, uy = n_x,n_y
		end
	end

--[[
	for k,v in ipairs(getElementsByType ("radararea")) do
        local sx, sy = getRadarAreaSize(v)
        local size = 2
        sx = sx / size
        sy = sy / size
        local jbx, jby, _ = getElementPosition(v)
        local jb_x = (((((3000)+jbx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
		local jb_y = ((((3000-jby)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
        local rr, gg, bb, alpha = 255,255,255,255
        rr, gg, bb, alpha = getRadarAreaColor(v)

        if (isRadarAreaFlashing(v)) then
            alpha = alpha*math.abs(getTickCount()%1000-500)/500
        end

        dxDrawRectangle ( jb_x-sx/size + sx/1.8, jb_y-sy/size - sy/1.8, sx, sy, tocolor(rr, gg, bb, alpha) )
    end
]]--


	for k,v in ipairs(getElementsByType ("blip")) do	


			
			
		local bIcon = getBlipIcon(v)
        local x,y = getElementPosition(v)
        local b_x = (((((3000)+x)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
		local b_y = ((((3000-y)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
        local blip_icon = getBlipIcon  ( v)
		--outputChatBox("X: "..b_x)
		b_x = math.min(math.max(b_x, blipMeret[1]/2), radarS[1]-blipMeret[2]/2)
		b_y = math.min(math.max(b_y, blipMeret[2]/2), radarS[2]-blipMeret[2]/2)
		
		local bcR, bcG, bcB = 255, 255, 255
		if getBlipIcon(v) == 0 or getBlipIcon(v) == 61 then
			bcR, bcG, bcB = getBlipColor(v)
		end
		if blip_icon == 0 then
			blipNeve = getElementData(v, "blipName")
		end
		
		local timeNow = getTickCount()
		local alpha = (timeNow % 510)
		if alpha > 255 then
			alpha = 255 - (alpha - 255)
		end
		local color = tocolor(255,255,255, alpha)

		if getBlipIcon(v) == 1 then
			bS = alpha * 0.4 --getBlipSize(v) --getBlipSize(v) * 0.7
			dxDrawImage ( b_x-bS/2,b_y-bS/2,bS,bS, "tex/blip2/1.png", 0, 0, 0, color)
		else
		


		--local ficou2 = getElementData(localPlayer,"piscar")
		if ficou == v then
		
		local timeNow = getTickCount()
		local alpha = (timeNow % 510)
		if alpha > 255 then
			alpha = 255 - (alpha - 255)
		end
		local color = tocolor(255,255,255, alpha)
		bS = alpha * 0.3
		dxDrawImage ( b_x-bS/2,b_y-bS/2,bS,bS, "tex/blip2/"..blip_icon..".png", 0, 0, 0, color)
		
		else
		if not ficou then
		dxDrawImage ( b_x-blipMeret[1]/2,b_y-blipMeret[2]/2,blipMeret[1],blipMeret[2], "tex/blip2/"..blip_icon..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, 255))
		end
		end
		

		end


		local kx, ky = getCursorPosition()
		if kx and ky then
			kx, ky = kx*s[1]-radarP[1], ky*s[2]-radarP[2]
			if (dobozbaVan(b_x-blipMeret[1]/2,b_y-blipMeret[2]/2,blipMeret[1],blipMeret[2], kx, ky)) then
				if getElementData(v, "blipName") or false then
					blipNeve = getElementData(v, "blipName")
				elseif blipNames[bIcon] then
					blipNeve = blipNames[bIcon]
				else
					blipNeve = "Nome indisponível"
				end
				--local szovegHossz =  dxGetTextWidth(blipNeve, 0.7, "default-bold")+40
				local szovegHossz = dxGetTextWidth(blipNeve, 1, "default-bold")+10
				
				formDobozRajzolasa( b_x-szovegHossz/2,b_y+blipMeret[2],szovegHossz,20, tocolor(20, 20, 20, 150), tocolor(0,0,0,200))
				fontSzovegRender(blipNeve,b_x-szovegHossz/2,b_y+blipMeret[2], szovegHossz, 20, tocolor(255,255,255,220), 1, "default-bold", "center", "center", true, true, false, 0, 0, 0)
			end
		end	
    end

	local rot = getPedRotation( localPlayer )
	local jbx, jby, _ = getElementPosition(localPlayer)
    local jb_x = (((((3000)+jbx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
	local jb_y = ((((3000-jby)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
	dxDrawImage ( jb_x-blipMeret[1]/2+1.5, jb_y-blipMeret[2]/2+1.5, blipMeret[1]+5, blipMeret[2]+5, "tex/blip2/2.png", -rot, 0, 0, tocolor(0, 0, 0,255) )
	dxDrawImage ( jb_x-blipMeret[1]/2, jb_y-blipMeret[2]/2, blipMeret[1]+5, blipMeret[2]+5, "tex/blip2/2.png", -rot, 0, 0, tocolor(255, 255, 255,255) )
	
	
	
		if getElementData(localPlayer,"char:adminduty") == 1 and getElementData(localPlayer, 'acc:admin') >= 1 then
			for k,v in ipairs(getElementsByType("player")) do

				if v ~= localPlayer then	
					if v ~= getLocalPlayer() and isElement(v) then
						if getElementData(v,"loggedin") then
						
							local tx,ty = getElementPosition(v)
							local rot = getPedRotation( v )
							local jbx, jby, _ = getElementPosition(v)
							local jb_x = (((((3000)+jbx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
							local jb_y = ((((3000-jby)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
							
							if getElementData(localPlayer,"char:adminduty") == 1 and getElementData(localPlayer,"ver:facs") then
							
							if getElementData(v, "char:dutyfaction") == getElementData(localPlayer, "fac:numero")  then
							if not foi then
							print("foi!")
							foi = true
							end
							local kx, ky = getCursorPosition()
							if kx and ky then
							kx, ky = kx*s[1]-radarP[1], ky*s[2]-radarP[2]
							if (dobozbaVan(jb_x-blipMeret[1]/2,jb_y-blipMeret[2]/2,blipMeret[1],blipMeret[2], kx, ky)) then
								isInti = ""
								if getElementDimension(v) > 0 then
									isInti = "{INTERIOR}"
								end
							local szoveg = "("..getElementData(v, "acc:id")..") "..getPlayerName(v):gsub("_", " ") .. " "..isInti
							local szovegHossz = dxGetTextWidth(szoveg, 1, "default-bold")+10
							formDobozRajzolasa( jb_x-szovegHossz/2,jb_y+blipMeret[2],szovegHossz,20, tocolor(20, 20, 20, 150), tocolor(0,0,0,200))
							fontSzovegRender(szoveg,jb_x-szovegHossz/2,jb_y+blipMeret[2], szovegHossz, 20, tocolor(255,255,255,220), 1, "default-bold", "center", "center", true, true, false, 0, 0, 0)
							end
							end
							
							end
							
							
							else

							if getElementData(v,"char:adminduty") == 1 and tonumber(getElementData(v, 'acc:admin') or 0) >= 1 and tonumber(getElementData(v, 'acc:admin') or 0) < 7 then
							dxDrawImage ( jb_x-blipMeret[1]/2, jb_y-blipMeret[2]/2, blipMeret[1], blipMeret[2], "tex/blip2/2.png", -rot, 0, 0, tocolor(0,255,13,255) )
							else

							if getElementData(v,"char:adminduty") == 0 then
							dxDrawImage ( jb_x-blipMeret[1]/2, jb_y-blipMeret[2]/2, blipMeret[1], blipMeret[2], "tex/blip2/2.png", -rot, 0, 0, tocolor(255,0,0,255) )
							end
							
							end
					
							if getElementData(v,"char:adminduty") == 1 and tonumber(getElementData(v, 'acc:admin') or 0) >= 7 then
							else
							local kx, ky = getCursorPosition()
							if kx and ky then
							kx, ky = kx*s[1]-radarP[1], ky*s[2]-radarP[2]
							if (dobozbaVan(jb_x-blipMeret[1]/2,jb_y-blipMeret[2]/2,blipMeret[1],blipMeret[2], kx, ky)) then
								isInti = ""
								if getElementDimension(v) > 0 then
									isInti = "{INTERIOR}"
								end
							local szoveg = "("..getElementData(v, "acc:id")..") "..getPlayerName(v):gsub("_", " ") .. " "..isInti
							local szovegHossz = dxGetTextWidth(szoveg, 1, "default-bold")+10
							formDobozRajzolasa( jb_x-szovegHossz/2,jb_y+blipMeret[2],szovegHossz,20, tocolor(20, 20, 20, 150), tocolor(0,0,0,200))
							fontSzovegRender(szoveg,jb_x-szovegHossz/2,jb_y+blipMeret[2], szovegHossz, 20, tocolor(255,255,255,220), 1, "default-bold", "center", "center", true, true, false, 0, 0, 0)
							end
							end
							end
							end
							

						end
					end
				end
			end
		end	
	
	
	
	 
	
	
	
	
	
	dxSetRenderTarget()
	
	dxCreateBorder(radarP[1], radarP[2], radarS[1], radarS[2], tocolor(0, 0, 0, 200)) 
	dxDrawImage ( radarP[1], radarP[2], radarS[1], radarS[2], nagymap, 0, 0, 0, tocolor(255,255,255,200) ) 



end
end




function fontSzovegRender(szoveg, x, y, b, f, szin, meret, font, ax, ay, clip, szotores, postgui, rot, rotx, roty, fszin)
	if not fszin then fszin = false end
	dxDrawText ( szoveg, x, y, x+b, y+f, szin, meret, "default-bold", ax, ay, clip, szotores, postgui, fszin, false, rot, rotx, roty )
end


function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
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

function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x-3,y-3,w+6,3,color) -- Fent
	dxDrawRectangle(x-3,y,3,h,color) -- Bal Oldal
	dxDrawRectangle(x-3,y+h,w+6,3,color) -- Lent Oldal
	dxDrawRectangle(x+w,y-3,3,h+3,color) -- Jobb Oldal
end

local dobozB = {15, 3}
local dobozS = {17, 1, 0, 5}

function formDobozRajzolasa(x, y, sz, m, hszin, kszin, elore)
	-- Keret
	dxDrawRectangle ( x, y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255), elore) -- Bal oldal
	dxDrawRectangle ( x+sz-(dobozS[1]-dobozB[1]-1), y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255), elore) -- Jobb oldal
	dxDrawRectangle ( x+dobozS[4]/2, y, sz-dobozS[4], 1, kszin or tocolor(60,63,63,255), elore) -- Teteje oldal
	dxDrawRectangle ( x+dobozS[4]/2, y+m-(dobozS[1]-dobozB[1]-1), sz-dobozS[4], 1, kszin or tocolor(60,63,63,255), elore) -- Alja oldal
	
	dxDrawRectangle(x+1, y+1, sz-2, m-2, hszin or tocolor(60,63,63,100), elore)
end

function ujRadarElrejtes()
	if radarMegjelenitve then return end
	removeEventHandler("onClientRender", getRootElement(), ujRadarRender)
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
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










addEventHandler("onClientRender",getRootElement(),function()
	--if getElementData(localPlayer,"char >> 3dBlip") then
		for k, i in ipairs(getElementsByType("blip")) do
			if getElementData(i,"blip >> blipOnScreen") then
			local blipX,blipY,blipZ = getElementPosition(i)
			local bIcon = getBlipIcon(i)
			local br, bg, bb = getBlipColor(i)
			local playerX,playerY = getElementPosition(localPlayer)
			local distance = getDistanceBetweenPoints2D(blipX, blipY, playerX, playerY)
				local x,y,z = getScreenFromWorldPosition ( blipX,blipY,blipZ )
				if x and y and tonumber(math.floor(distance)) < 1000 then
					dxDrawImage(x,y,30,30,"tex/blip/"..bIcon..".png",0,0,0,tocolor(br, bg, bb,255),true)					
					local text = tostring(math.floor(distance)) .. " m"
					--dxDrawText(blipNeve.. "\n"..text,x+15,y+30,x+15,y+30,tocolor(255,255,255,255),1,font,"center","top")
					dxDrawText(text,x+15,y+30,x+15,y+30,tocolor(255,255,255,255),1,"default-bold","center","top")
		--		end
			end
		end
	end
end)