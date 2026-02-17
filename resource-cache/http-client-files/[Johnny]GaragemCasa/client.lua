txd = engineLoadTXD ( "garagem.txd" )
engineImportTXD ( txd, 3604 )

dff = engineLoadDFF ( "garagem.dff" , 3604 )
engineReplaceModel ( dff, 3604 )

col = engineLoadCOL ( "garagem.col" )
engineReplaceCOL ( col, 3604 )
	
engineSetModelLODDistance(3604, 300)
