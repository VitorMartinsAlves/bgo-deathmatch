-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'truth.txd' ) 
engineImportTXD( txd, 142 ) 
dff = engineLoadDFF('truth.dff', 142) 
engineReplaceModel( dff, 142 )
end)
