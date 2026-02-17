function carregamento()

	setCameraMatrix( 1000000, 1000000, 1000000)
	setElementFrozen(localPlayer, true)
		setTimer(
			function()
txd = engineLoadTXD("predio.txd", 6342 )
engineImportTXD(txd, 6342)
dff = engineLoadDFF("predio.dff", 6342 )
engineReplaceModel(dff, 6342)
col = engineLoadCOL ( "predio.col" )
engineReplaceCOL ( col, 6342 )
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



