function AndrixxClient ()
txd = engineLoadTXD("kmb_atmx.txd") 
engineImportTXD(txd, 2942 )
end
addEventHandler( "onClientResourceStart", resourceRoot, AndrixxClient )