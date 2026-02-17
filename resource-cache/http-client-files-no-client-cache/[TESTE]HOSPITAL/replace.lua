function carregamento()
	setCameraMatrix( 1000000, 1000000, 1000000)
	setElementFrozen(localPlayer, true)
		setTimer(
			function()
txd = engineLoadTXD("gara.txd", 6387 )
engineImportTXD(txd, 6387)
dff = engineLoadDFF("gara.dff", 6387 )
engineReplaceModel(dff, 6387)
col = engineLoadCOL ( "gara.col" )
engineReplaceCOL ( col, 6387 )
			end, 500, 1)



		setTimer(
			function()
				setCameraTarget(localPlayer)
				setElementFrozen(localPlayer, false)
				resetFarClipDistance( )
				resetFogDistance( )
				
			end, 1000, 1)
end
addEvent( "Carregar-mods", true )
addEventHandler( "Carregar-mods", root, carregamento )


