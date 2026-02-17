function AndrixxClient ()
txd = engineLoadTXD("vgsn_billboard.txd") 
engineImportTXD(txd, 7301 )
end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )