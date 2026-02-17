-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

--addEventHandler('onClientResourceStart',resourceRoot,function ()
function carregamento() 
txd = engineLoadTXD( 'camera.txd' ) 
engineImportTXD( txd, 367 ) 
dff = engineLoadDFF('camera.dff', 367) 
engineReplaceModel( dff, 367 )
end--)
addEvent( "Carregar-mods", true )
addEventHandler( "Carregar-mods", root, carregamento )
