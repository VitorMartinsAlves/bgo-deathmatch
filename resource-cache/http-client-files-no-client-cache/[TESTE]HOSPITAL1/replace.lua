function carregamento()
	setCameraMatrix( 1000000, 1000000, 1000000)
	setElementFrozen(localPlayer, true)
		setTimer(
			function()
txd = engineLoadTXD("fora.txd", 3671 )
engineImportTXD(txd, 3671)
dff = engineLoadDFF("fora.dff", 3671 )
engineReplaceModel(dff, 3671)
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




