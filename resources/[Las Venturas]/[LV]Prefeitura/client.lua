dff = engineLoadDFF ( "banco.dff" )
engineReplaceModel ( dff, 6966 )
txd = engineLoadTXD ( "banco.txd" )
engineImportTXD ( txd, 6966 )
col = engineLoadCOL ( "banco.col" )
engineReplaceCOL ( col, 6966 )



