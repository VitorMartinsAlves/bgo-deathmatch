

--restartResource(getThisResource())
--[[
function carregamento()

	setCameraMatrix( 1000000, 1000000, 1000000)
	setElementFrozen(localPlayer, true)
		setTimer(
			function()

txd = engineLoadTXD("dpls.txd", 14846 )
engineImportTXD(txd, 14846)
dff = engineLoadDFF("dpls.dff", 14846 )
engineReplaceModel(dff, 14846)
col = engineLoadCOL("dpls.col", 14846 )
engineReplaceCOL(col, 14846)

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



]]--


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ( startedRes )
txd = engineLoadTXD("dpls.txd", 14846 )
engineImportTXD(txd, 14846)
dff = engineLoadDFF("dpls.dff", 14846 )
engineReplaceModel(dff, 14846)
col = engineLoadCOL("dpls.col", 14846 )
engineReplaceCOL(col, 14846)
    end
);