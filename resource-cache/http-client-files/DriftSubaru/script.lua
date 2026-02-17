-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter )





--[[

addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),function () 
txd = engineLoadTXD ( 'subarao.txd' ) 
engineImportTXD ( txd, 558 ) 
dff = engineLoadDFF('subarao.dff', 558) 
engineReplaceModel ( dff, 558 )
end)
]]--





function carregamento()
txd = engineLoadTXD ( 'subarao.txd' ) 
engineImportTXD ( txd, 558 ) 
dff = engineLoadDFF('subarao.dff', 558) 
engineReplaceModel ( dff, 558 )
end
addEvent( "Carregar-mods", true )
addEventHandler( "Carregar-mods", root, carregamento )
