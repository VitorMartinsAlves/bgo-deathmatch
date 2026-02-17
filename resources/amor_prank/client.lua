local BSODTimer;

function renderBSOD()
 local x, y = guiGetScreenSize();
 dxDrawImage ( 0, 0, x, y, "bs.jpg", 0, 0, 0, _, true);
end

addEvent ( "showBSODToPlayeramar", true );
addEventHandler ( "showBSODToPlayeramar", getRootElement(),
 function ( thePlayer )
  if ( thePlayer == getLocalPlayer() ) then
   if ( isTimer ( BSODTimer ) ) then
    killTimer ( BSODTimer );
   end

	for i=1,100 do
		setWorldSoundEnabled(i, false)
	end
   setAmbientSoundEnabled("general", false)
   setAmbientSoundEnabled("gunfire", false)
   setInteriorSoundsEnabled(false)
   showChat ( false );
   --setPlayerHudComponentVisible ( "all", false );
   --local sound = playSound("s1.mp3") -- s1.mp3 for buzzing loop sound (common on BSODs @ Windows 7 +) or change to s2.mp3 for Windows XP bluescreen beep
   --setSoundVolume(sound, 0.2)

   removeEventHandler ( "onClientRender", getRootElement(), renderBSOD );
   addEventHandler ( "onClientRender", getRootElement(), renderBSOD );

   BSODTimer = setTimer ( function ()
     removeEventHandler ( "onClientRender", getRootElement(), renderBSOD );
     showChat ( true );
    -- setPlayerHudComponentVisible ( "all", true );
	 setAmbientSoundEnabled("general", true)
	 setAmbientSoundEnabled("gunfire", true)
	 setInteriorSoundsEnabled(true)
	 resetWorldSounds()
    end, 5000, 1
   );
  end
 end
);