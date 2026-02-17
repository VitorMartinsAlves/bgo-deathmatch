function carregamento()
	setCameraMatrix( 1000000, 1000000, 1000000)
	setElementFrozen(localPlayer, true)
		setTimer(
			function()
txd = engineLoadTXD ( "hsp.txd" )
engineImportTXD ( txd, 1930 )

dff = engineLoadDFF ( "hsp.dff" , 1930 )
engineReplaceModel ( dff, 1930 )

col = engineLoadCOL ( "hsp.col" )
engineReplaceCOL ( col, 1930 )
	
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
--addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
--addCommandHandler ( "rr", replaceModel )


