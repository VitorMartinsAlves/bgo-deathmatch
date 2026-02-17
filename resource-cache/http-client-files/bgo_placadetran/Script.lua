function AndrixxClient ()
txd = engineLoadTXD("vgsssignage03.txd") 
engineImportTXD(txd, 8332 )
end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )