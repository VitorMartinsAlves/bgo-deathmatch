txd = engineLoadTXD ( "igreja.txd" )
engineImportTXD ( txd, 8130 )

dff = engineLoadDFF ( "igreja.dff" , 8130 )
engineReplaceModel ( dff, 8130 )
	
col = engineLoadCOL ( "igreja.col" )
engineReplaceCOL ( col, 8130 )

engineSetModelLODDistance(8130, 200)
