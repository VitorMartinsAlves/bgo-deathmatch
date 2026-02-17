-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'copcarsf.txd' ) 
engineImportTXD( txd, 548 ) 
dff = engineLoadDFF('copcarsf.dff', 548) 
engineReplaceModel( dff, 548 )
end)
