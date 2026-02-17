------------------------------------------
-- 	      Painel de DJ em DX	     	--
------------------------------------------
-- Desenvolvedor: Flavio - (#Flavio)	--
-- Arquivo: server.lua			    	--
-- Copyright 2016 (C) Flavio    		--
-- All rights reserved.					--
------------------------------------------
Audio = {}

local abrirpainel = createMarker(1875.3341064453, -1682.1488037109, 14.957812309265-0.9,"cylinder", 1, 0 ,255, 0, 25) --- GROVE

--local abrirpainel = createMarker(2417.9792480469,-1189.9522705078,24.545425415039,"cylinder", 1.5, 0 ,255, 0, 155)


function mostrarpainel(thePlayer)
	triggerClientEvent(thePlayer, "Dj", thePlayer)
end
addEventHandler("onMarkerHit", abrirpainel, mostrarpainel)

function atmGetTimeOut ()
	if isTimer ( timer ) then
		local miliseconds = getTimerDetails ( timer )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end

function desmanchado2()
desmanche = false
end


addEvent ( "CrioDJ", true )
addEventHandler ( "CrioDJ", root, function ( Link )

		if desmanche == true then 
		outputChatBox("Alguem ja colocou uma musica aguarde "..atmGetTimeOut().." segundos para mudar de musica novamente!!", source, 255,255,255, true)
		return
		end
		
		if ( Link ) then
		if ( isElement ( Audio [ source ] ) ) then
			local x, y, z = getElementPosition ( Audio [ source ] ) 
			destroyElement ( Audio [ source ] )
		end
		
		desmanche = true
		
		timer = setTimer(desmanchado2, 60000,1)
	
	
		local x, y, z = getElementPosition ( source )
		Audio [ source ] = createMarker(x-0.5, y+0.5, z - 1,"cylinder", 1, 0, 255, 255, 0)
		triggerClientEvent ( root, "CrioDJ", source, source, Link )
		triggerClientEvent(root, "Djay", root, getPlayerName( source ) )
	end
end)


addEvent ( "cancelarTimer", true ) 
addEventHandler ( "cancelarTimer", root, function ( )
	if isTimer(timer) then
	killTimer(timer)
	desmanche = false
	end
end )




addEvent ( "VolumealteradoDJ", true ) 
addEventHandler ( "VolumealteradoDJ", root, function ( to )
	triggerClientEvent ( root, "VolumeDJ", source, source, to )
end )

addEvent ( "DestruiDJ", true )
addEventHandler ( "DestruiDJ", root, function ( )
	if ( isElement ( Audio [ source ] ) ) then
		destroyElement ( Audio [ source ] )
		triggerClientEvent ( root, "DestruiDJ", source, source )
	end
end )