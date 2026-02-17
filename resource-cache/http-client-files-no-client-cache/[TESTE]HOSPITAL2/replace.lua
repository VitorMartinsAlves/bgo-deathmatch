function carregamento()
	setCameraMatrix( 1000000, 1000000, 1000000)
	setElementFrozen(localPlayer, true)
		setTimer(
			function()
txd = engineLoadTXD("Fund.txd", 6341 )
engineImportTXD(txd, 6341)
dff = engineLoadDFF("Fund.dff", 6341 )
engineReplaceModel(dff, 6341)
col = engineLoadCOL ( "Fund.col" )
engineReplaceCOL ( col, 6341 )
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


