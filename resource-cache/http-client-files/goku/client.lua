txd = engineLoadTXD ( "Dodge.txd" )
engineImportTXD ( txd, 2 )
dff = engineLoadDFF ( "Dodge.dff" )
engineReplaceModel ( dff, 2 )
