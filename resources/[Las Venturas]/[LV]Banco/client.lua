dff = engineLoadDFF ( "Banco2.dff" , 8419 )
engineReplaceModel ( dff, 8419 )

col = engineLoadCOL ( "Banco2.col", 8419 )
engineReplaceCOL ( col, 8419 )

txd = engineLoadTXD ( "Banco2.txd", 8419 )
engineImportTXD ( txd, 8419 )






