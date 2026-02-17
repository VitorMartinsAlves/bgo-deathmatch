------------------------------------------
-- Author: xXMADEXx						--
-- Name: 3D Speakers 2.0				--
-- File: client.lua						--
-- Copyright 2013 ( C ) Braydon Davis	--
------------------------------
-- Variables				--
------------------------------
local subTrackOnSoundDown = 0.1	-- The volume that goes down, when the player clicks "Volume -"
local subTrackOnSoundUp = 0.1	-- The volume that goes up, when the player clicks "Volume +"


function print ( message, r, g, b )
	outputChatBox ( message, r, g, b )
end

------------------------------
-- The GUI					--
------------------------------
local rx, ry = guiGetScreenSize ( )
button = { }
windowSound = guiCreateWindow( ( rx - 295 ), ( ry / 2 - 253 / 2 ), 293, 253, "BRASIL MATA-MATA - RADIO", false)
guiWindowSetSizable(windowSound, false)
guiSetVisible ( windowSound, false )
CurrentSpeaker = guiCreateLabel(8, 33, 254, 17, "Você não tem caixa criada", false, windowSound)
volume = guiCreateLabel(10, 50, 252, 17, "Volume: 100%", false, windowSound)
pos = guiCreateLabel(10, 66, 252, 15, "X: 0 | Y: 0 | Z: 0", false, windowSound)
guiCreateLabel(11, 81, 251, 15, "URL:", false, windowSound) 
url = guiCreateEdit(11, 96, 272, 23, "", false, windowSound)  
button["place"] = guiCreateButton(9, 129, 274, 20, "Criar caixa de som", false, windowSound)
button["remove"] = guiCreateButton(9, 159, 274, 20, "Destruir caixa de som", false, windowSound)
button["v-"] = guiCreateButton(9, 189, 128, 20, "Volume -", false, windowSound)
button["v+"] = guiCreateButton(155, 189, 128, 20, "Volume +", false, windowSound)
button["close"] = guiCreateButton(9, 219, 274, 20, "Exit", false, windowSound)  

--------------------------
-- My sweet codes		--
--------------------------
local isSound = false
addEvent ( "onPlayerViewSpeakerManagmentSound", true )
addEventHandler ( "onPlayerViewSpeakerManagmentSound", root, function ( current )
	local toState = not guiGetVisible ( windowSound ) 
	guiSetVisible ( windowSound, toState )
	showCursor ( toState ) 
	if ( toState == true ) then
		guiSetInputMode ( "no_binds_when_editing" )
		local x, y, z = getElementPosition ( localPlayer )
		guiSetText ( pos, "X: "..math.floor ( x ).." | Y: "..math.floor ( y ).." | Z: "..math.floor ( z ) )
		if ( current ) then guiSetText ( CurrentSpeaker, "Do you currently have a speaker: Yes" ) isSound = true
		else guiSetText ( CurrentSpeaker, "Não tem caixa criada" ) end
	end
end )

addEventHandler ( "onClientGUIClick", root, function ( )
	if ( source == button["close"] ) then
		guiSetVisible ( windowSound, false ) 
		showCursor ( false )
	elseif ( source == button["place"] ) then
		if ( isURL ( ) ) then
			triggerServerEvent ( "onPlayerPlacespeakerBoxSound22", localPlayer, guiGetText ( url ), isPedInVehicle ( localPlayer ) )
			guiSetText ( CurrentSpeaker, "tem uma caixa criada" )
			isSound = true
			guiSetText ( volume, "Volume: 100%" )
		else
			print ( "Você precisa digitar uma URL.", 255, 0, 0 )
		end
	elseif ( source == button["remove"] ) then
		triggerServerEvent ( "onPlayerDestroyspeakerBoxSound22", localPlayer )
		guiSetText ( CurrentSpeaker, "Não tem caixa criada" )
		isSound = false
		guiSetText ( volume, "Volume: 100%" )
	elseif ( source == button["v-"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) - subTrackOnSoundDown, 2 )
			if ( toVol > 0.0 ) then
				print ( "Volume: "..math.floor ( toVol * 100 ).."%!", 0, 255, 0 )
				triggerServerEvent ( "onPlayerChangespeakerBoxSoundVolumeaa", localPlayer, toVol )
				guiSetText ( volume, "Volume: "..math.floor ( toVol * 100 ).."%" )
			else
				print ( "O volume ja está no minimo.", 255, 0, 0 )
			end
		end
	elseif ( source == button["v+"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) + subTrackOnSoundUp, 2 )
			if ( toVol < 3 ) then
				print ( "Volume set to "..math.floor ( toVol * 100 ).."%!", 0, 255, 0 )
				triggerServerEvent ( "onPlayerChangespeakerBoxSoundVolumeaa", localPlayer, toVol )
				guiSetText ( volume, "Volume: "..math.floor ( toVol * 100 ).."%" )
			else
				print ( "O volume ja está no maximo.", 255, 0, 0 )
			end
		end
	end
end )

speakerSound = { }
addEvent ( "onPlayerStartspeakerBoxSound22", true )
addEventHandler ( "onPlayerStartspeakerBoxSound22", root, function ( who, url, isCar )
	if ( isElement ( speakerSound [ who ] ) ) then destroyElement ( speakerSound [ who ] ) end
	local x, y, z = getElementPosition ( who )
	speakerSound [ who ] = playSound3D ( url, x, y, z, true )
	--speakerSound [ who ] = playSound3D ("http://www.youtubeinmp3.com/fetch/?video="..url, x, y, z, true )


	setElementInterior(speakerSound [ who ],getElementInterior(who))
	setElementDimension(speakerSound [ who ],getElementDimension(who))


	setSoundVolume ( speakerSound [ who ], 2 )
	setSoundMaxDistance ( speakerSound [ who ], 20 )
	if ( isCar ) then
		local car = getPedOccupiedVehicle ( who )
		attachElements ( speakerSound [ who ], car, 0, 5, 1 )
	end
end )

addEvent ( "onPlayerDestroyspeakerBoxSound22", true )
addEventHandler ( "onPlayerDestroyspeakerBoxSound22", root, function ( who ) 
	if ( isElement ( speakerSound [ who ] ) ) then 
		destroyElement ( speakerSound [ who ] ) 

	end
end )

--------------------------
-- Volume				--
--------------------------
addEvent ( "onPlayerChangespeakerBoxSoundVolumeC", true )
addEventHandler ( "onPlayerChangespeakerBoxSoundVolumeC", root, function ( who, vol ) 
	if ( isElement ( speakerSound [ who ] ) ) then
		setSoundVolume ( speakerSound [ who ], tonumber ( vol ) )
	end
end )

function isURL ( )
	if ( guiGetText ( url ) ~= "" ) then
		return true
	else
		return false
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end




