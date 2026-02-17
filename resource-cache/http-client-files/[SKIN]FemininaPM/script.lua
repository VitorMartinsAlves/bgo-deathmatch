-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'copcarsf.txd' ) 
engineImportTXD( txd, 246 ) 
dff = engineLoadDFF('copcarsf.dff', 246) 
engineReplaceModel( dff, 246 )
end)
