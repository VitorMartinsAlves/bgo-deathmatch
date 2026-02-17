function AndrixxClient ()
txd = engineLoadTXD("a51_imy.txd") 
engineImportTXD(txd, 2928 )
end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )