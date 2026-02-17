function AndrixxClient ()

    local dff = engineLoadDFF ( "glenpark7_lae.dff")
engineReplaceModel ( dff, 5390 )


local txd = engineLoadTXD("glenpark7_lae.txd") 
engineImportTXD(txd, 5390 )


local col = engineLoadCOL ( "glenpark7_lae.col" )
engineReplaceCOL ( col, 5390 )


end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )




