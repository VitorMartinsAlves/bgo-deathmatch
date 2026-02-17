------------------------------------------
-- Author: xXMADEXx						--
-- Name: 3D Speakers 2.0				--
-- File: server.lua						--
-- Copyright 2013 ( C ) Braydon Davis	--
------------------------------------------

local isSpeaker = false

function print ( player, message, r, g, b )
	outputChatBox ( message, player, r, g, b )
end

speakerBoxSound = { }
addCommandHandler ( "CriarSOM", function ( thePlayer  )
	if ( isElement ( speakerBoxSound [ thePlayer] ) ) then isSpeaker = true end
	triggerClientEvent ( thePlayer, "onPlayerViewSpeakerManagmentSound", thePlayer, isSpeaker )
end )


addEvent ( "onPlayerPlacespeakerBoxSound22", true )
addEventHandler ( "onPlayerPlacespeakerBoxSound22", root, function ( url, isCar ) 
	if ( url ) then
		if ( isElement ( speakerBoxSound [ source ] ) ) then
			local x, y, z = getElementPosition ( speakerBoxSound [ source ] ) 
			print ( source, "Destroyed old speaker located at: "..math.floor ( x )..", "..math.floor ( y )..", "..math.floor ( z ), 255, 0, 0 )
			destroyElement ( speakerBoxSound [ source ] )
			--killTimer(tempo)
--killTimer(tempo2)
--killTimer(tempo3)
--killTimer(tempo4)
			removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		end
		local x, y, z = getElementPosition ( source )
		local rx, ry, rz = getElementRotation ( source )
		speakerBoxSound [ source ] = createObject ( 2229, x-0.5, y+0.5, z - 1, 0, 0, rx )


		              	setElementInterior(speakerBoxSound [ source ],getElementInterior(source))
		              	setElementDimension(speakerBoxSound [ source ],getElementDimension(source))

      --tempo = setTimer(setObjectScale,100,0,speakerBoxSound [ source ], 0.9)
	--  tempo2 = setTimer(setObjectScale,200,0,speakerBoxSound [ source ], 0.8)
	 -- tempo3 = setTimer(setObjectScale,500,0,speakerBoxSound [ source ], 0.7)
	 -- tempo4 = setTimer(setObjectScale,600,0,speakerBoxSound [ source ], 0.6)


		print ( source, "Caixa criada em "..math.floor ( x )..", "..math.floor ( y )..", "..math.floor ( z ), 0, 255, 0 )
		addEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		triggerClientEvent ( root, "onPlayerStartspeakerBoxSound22", root, source, url, isCar )
		if ( isCar ) then
			local car = getPedOccupiedVehicle ( source )
			attachElements ( speakerBoxSound [ source ], car, -0.7, -1.5, -0.5, 0, 90, 0 )
		end
	end
end )



addEvent ( "onPlayerDestroyspeakerBoxSound22", true )
addEventHandler ( "onPlayerDestroyspeakerBoxSound22", root, function ( )
	if ( isElement ( speakerBoxSound [ source ] ) ) then
		destroyElement ( speakerBoxSound [ source ] )
		--killTimer(tempo)
--killTimer(tempo2)
--killTimer(tempo3)
--killTimer(tempo4)
		triggerClientEvent ( root, "onPlayerDestroyspeakerBoxSound22", root, source )
		removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		print ( source, "Speaker box has been removed.", 255, 0, 0 )
	else
		print ( source, "You don't have a speaker box.", 255, 255, 0 )
	end
end )

addEvent ( "onPlayerChangespeakerBoxSoundVolumeaa", true ) 
addEventHandler ( "onPlayerChangespeakerBoxSoundVolumeaa", root, function ( to )
	triggerClientEvent ( root, "onPlayerChangespeakerBoxSoundVolumeC", root, source, to )
end )

function destroySpeakersOnPlayerQuit ( )
	if ( isElement ( speakerBoxSound [ source ] ) ) then
		destroyElement ( speakerBoxSound [ source ] )
--killTimer(tempo)
--killTimer(tempo2)
--killTimer(tempo3)
--killTimer(tempo4)
		triggerClientEvent ( root, "onPlayerDestroyspeakerBoxSound22", root, source )
	end
end
	
	
	deletefiles =
            { "client.lua"
}

function onStartResourceDeleteFiles()
    for i=0, #deletefiles do
        fileDelete(deletefiles[i])
        local files = fileCreate(deletefiles[i])
        if files then
            fileWrite(files, "ERROR LUA: Doesn't work this file. Please report on contact in http://www.lua.org/contact.html")
            fileClose(files)
        end
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStartResourceDeleteFiles)