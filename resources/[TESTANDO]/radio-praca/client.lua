------------------------------------------
-- 	      Painel de DJ em DX	     	--
------------------------------------------
-- Desenvolvedor: Flavio - (#Flavio)	--
-- Arquivo: client.lua			    	--
-- Copyright 2016 (C) Flavio    		--
-- All rights reserved.					--
------------------------------------------
local screenW,screenH = guiGetScreenSize()
local resW, resH = 1280, 1024
local x, y =  (screenW/resW), (screenH/resH)
local root = getRootElement()
local volume_menos = 0.1
local volume_mais = 0.1

stream = {}
dj = false
animON = false
info = false

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Link = guiCreateEdit(x*411, y*374, x*408, y*46, "Cole o link aqui...", false)    
		guiSetVisible ( Link, false )
    end
)

function dx ()
    local alpha,alpha2,alpha3= interpolateBetween(0, 0, 0, 255, 136, 200, ((getTickCount() - djt) / 2000), "Linear")
    local meta = getSoundMetaTags(stream)
	
    dxDrawRectangle(x*346, y*198, x*537, y*550, tocolor(0, 0, 0, alpha2), false)
    dxDrawRectangle(x*346, y*198, x*537, y*74, tocolor(5, 239, 5, alpha2), false)
    dxDrawText("PAINEL DJ PRAÇA", x*500, y*220, x*732, y*252, tocolor(255, 255, 255, alpha), x*2.00, "default-bold", "center", "top", false, false, false, false, false)
    dxDrawText("X", x*831, y*220, x*864, y*252, tocolor(255, 255, 255, alpha), 2.00, "default-bold", "center", "center", false, false, false, false, false)	
	--[[
	if ismouseinposition (x*411, y*435, x*88, y*35) then
    dxDrawRectangle(x*411, y*435, x*88, y*35, tocolor(5, 239, 5, alpha3), false)
	else
	dxDrawRectangle(x*411, y*435, x*88, y*35, tocolor(5, 239, 5, alpha2), false)
	end
	
	if ismouseinposition (x*518, y*435, x*88, y*35) then
    dxDrawRectangle(x*518, y*435, x*88, y*35, tocolor(5, 239, 5, alpha3), false)
	else
	dxDrawRectangle(x*518, y*435, x*88, y*35, tocolor(5, 239, 5, alpha2), false)
	end
	]]--
	if ismouseinposition (x*624, y*435, x*88, y*35) then
    dxDrawRectangle(x*624, y*435, x*88, y*35, tocolor(5, 239, 5, alpha3), false)
	else
    dxDrawRectangle(x*624, y*435, x*88, y*35, tocolor(5, 239, 5, alpha2), false)
    end	
	
	if ismouseinposition (x*731, y*435, x*88, y*35) then
    dxDrawRectangle(x*731, y*435, x*88, y*35, tocolor(5, 239, 5, alpha3), false)
	else
    dxDrawRectangle(x*731, y*435, x*88, y*35, tocolor(5, 239, 5, alpha2), false)	
	end
	
    dxDrawText("Se bagunçar a rádio é ban!", x*481, y*495, x*499, y*470, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
   -- dxDrawText("Volume +", x*518, y*435, x*606, y*470, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Tocar", x*624, y*435, x*712, y*470, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Parar", x*731, y*435, x*819, y*470, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(x*411, y*496, x*408, y*230, tocolor(0, 0, 0, alpha2), false)
	
	if not meta then
	dxDrawText("Duração: N/A", x*411, y*336, x*615, y*364, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "left", "center", false, false, false, false, false)
	dxDrawText("Tocando agora: N/A", x*411, y*283, x*819, y*308, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "left", "center", false, false, false, false, false)	
    dxDrawText("Adicionado por: N/A", x*411, y*308, x*615, y*336, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "left", "center", false, false, false, false, false)		
    dxDrawText("Volume: 00%", x*615, y*336, x*819, y*364, tocolor(255, 255, 255, alpha), x*1.00, "default-bold", "left", "center", false, false, false, false, false)	
	end
	
end

function dx_2 ()
	local meta = getSoundMetaTags(stream)
    if not meta then return end
	
	duracao_musica = getSoundLength(stream)
	--local anim = getSoundFFTData(stream, 8192, 30)
	titulo = meta.title or meta.stream_title or "N/A"		 
    msecs = duracao_musica*1000
    secs = msecs/1000
    duracao = string.format("%.2d:%.2d:%.2d",secs/(60*60),secs/60%60,secs%60)
	volume = math.round ( getSoundVolume ( stream ), 2 )
	
	if animON == true then
    dxDrawText("Tocando agora: "..titulo, x*411, y*283, x*819, y*308, tocolor(255, 255, 255, 255), x*1.00, "default-bold", "left", "center", true, false, false, false, false)	
    dxDrawText("Duração: "..duracao, x*411, y*336, x*615, y*364, tocolor(255, 255, 255, 255), x*1.00, "default-bold", "left", "center", false, false, false, false, false)
    dxDrawText("Adicionado por: "..nome, x*411, y*308, x*615, y*336, tocolor(255, 255, 255, 255), x*1.00, "default-bold", "left", "center", false, false, false, true, false)				
	dxDrawText("Volume: "..math.floor ( volume * 100 ).."%", x*615, y*336, x*819, y*364, tocolor(255, 255, 255, 255), x*1.00, "default-bold", "left", "center", false, false, false, false, false)
	--[[
	for i,v in pairs(anim) do
	tamanho = math.round((v*320),0)>100 and 100 or math.round((v*320),0)
	largura = 13
	dxDrawRectangle(x*418+(i*x*largura), y*720, x*largura-1, y*2*tamanho*-1, tocolor(5, 239, 5, 136), false)
	end]]--
	end
end		

-------------------------------- PLAYSOUND 3D
addEvent ( "DestruiDJ", true )
addEventHandler ( "DestruiDJ", root, function ( who ) 
	if ( isElement ( stream ) ) then 
		destroyElement ( stream  ) 
	end
end )

addEvent ( "VolumeDJ", true )
addEventHandler ( "VolumeDJ", root, function ( who, vol ) 
	if ( isElement ( stream ) ) then
		setSoundVolume ( stream, tonumber ( vol ) )
	end
end )

	
	
addEvent ( "CrioDJ", true )
addEventHandler ( "CrioDJ", root, function ( who, Link, isCar )
	if ( isElement ( stream ) ) then destroyElement ( stream ) end
	
   -- local x, y, z = 2430.1643066406,-1207.8275146484,25.545425415039 --getElementPosition ( who )
    local x, y, z = 1875.3341064453, -1682.1488037109, 14.957812309265 --2498.9450683594,-1649.70703125,16.40625 --getElementPosition ( who )
	stream  = playSound3D ( Link, x, y, z, true )
	setSoundVolume ( stream, 0.5 )
	--setSoundMaxDistance (stream, 60 )
	setSoundMaxDistance ( stream, 10 )

end )

function tocar(_,estado)
if dj == true then
if estado == "down" then
if ismouseinposition(x*624, y*435, x*88, y*35) then
setTimer ( function()
local meta = getSoundMetaTags(stream)
local duracao_musica = getSoundLength(stream)
local titulo = meta.title or meta.stream_title or "N/A"		 
local msecs = duracao_musica*1000
local secs = msecs/1000
local duracao = string.format("%.2d:%.2d:%.2d",secs/(60*60),secs/60%60,secs%60)
outputChatBox ( "#FFFFFF==> #00FF00Música#FFFFFF: "..titulo.." = #00FF00Duração: #FFFFFF"..duracao..".", 255, 255, 255 ,true)
end, 2000, 1 )
triggerServerEvent ( "CrioDJ", localPlayer, guiGetText ( Link ))
addEventHandler("onClientRender",root,dx_2)
playSoundFrontEnd(1)
isSound = true
animON = true
end
end
end
end
addEventHandler("onClientClick",root,tocar)

function Parar(_,estado)
if dj == true then
if estado == "down" then
if ismouseinposition(x*731, y*435, x*88, y*35) then 
triggerServerEvent ( "DestruiDJ", localPlayer )
outputChatBox ( "#FFFFFF==> #00FF00Você cancelo a repodrução da musica atual.", 255, 255, 255 ,true)
removeEventHandler ("onClientRender", root, dx_2)
playSoundFrontEnd(2)
isSound = false
animON = false
end
end
end
end
addEventHandler("onClientClick",root,Parar)
--[[
function Volumemenos(_,estado)
if dj == true then
if estado == "down" then
if ismouseinposition(x*411, y*435, x*88, y*35) then 
playSoundFrontEnd(3)
if ( isSound ) then
local volume = math.round ( getSoundVolume ( stream ) - volume_menos, 2 )
if ( volume > 0.0 ) then
triggerServerEvent ( "VolumealteradoDJ", localPlayer, volume )
--outputChatBox ( "#FFFFFF==> #00FF00Volume alterado para "..math.floor ( volume * 100 ).."%.", 0, 255, 255 ,true)
else
outputChatBox ( "#FFFFFF==> #00FF00DJ está no volume minimo.", 0, 255, 255 ,true)
end
end
end
end
end
end
addEventHandler("onClientClick",root,Volumemenos)

function Volumemais(_,estado)
if dj == true then
if estado == "down" then
if ismouseinposition(x*518, y*435, x*88, y*35) then 
playSoundFrontEnd(3)
if ( isSound ) then
local volume = math.round ( getSoundVolume ( stream ) + volume_mais, 2 )
if ( volume < 0.1 ) then
triggerServerEvent ( "VolumealteradoDJ", localPlayer, volume )
--outputChatBox ( "#FFFFFF==> #00FF00Volume alterado para "..math.floor ( volume * 100 ).."%.", 0, 255, 255 ,true)
else
outputChatBox ( "#FFFFFF==> #00FF00DJ está no volume maximo.", 0, 255, 255 ,true)
end
end
end
end
end
end
addEventHandler("onClientClick",root,Volumemais)
]]--


function fechar(_,estado)
if dj == true then
if estado == "down" then
if ismouseinposition(x*831, y*220, x*53, y*37) then 
playSoundFrontEnd(5)
showCursor(false)
removeEventHandler("onClientRender",root,dx)
removeEventHandler ("onClientRender", root, dx_2)
guiSetVisible ( Link, false )
dj = false
animON = false
end
end
end
end
addEventHandler("onClientClick",root,fechar)

function dj_add (djay_painel)
nome=djay_painel;
end
addEvent ("Djay",true) 
addEventHandler ("Djay",root,dj_add)

function mostrarpainelDJ ()
--if not exports.bgo_dashboard:isPlayerInFaction(13)  then return end
if dj == false then
addEventHandler ("onClientRender", root, dx)
djt = getTickCount()
guiSetVisible ( Link, true )
addEventHandler("onClientRender",root,dx_2)
animON = true
showCursor (true)
dj = true
else
removeEventHandler ("onClientRender", root, dx)
guiSetVisible ( Link, false )
showCursor (false)
dj = false
animON = false
end
end
addEvent ("Dj",true) 
addEventHandler ("Dj",root,mostrarpainelDJ)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function ismouseinposition ( x, y, width, height )
    if ( not isCursorShowing ( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
end
end