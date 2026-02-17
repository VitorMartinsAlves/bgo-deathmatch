function AndrixxClient ()
txd = engineLoadTXD("cadeira.txd") 
engineImportTXD(txd, 1369 )
end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )