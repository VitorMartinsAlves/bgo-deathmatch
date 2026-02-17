function AndrixxClient ()
txd = engineLoadTXD("des_nwtown.txd") 
engineImportTXD(txd, 11455 )
end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )