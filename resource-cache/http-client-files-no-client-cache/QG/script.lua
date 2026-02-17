addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'chao.txd' ) 
engineImportTXD( txd, 6490 ) 
dff = engineLoadDFF('chao.dff', 6490) 
engineReplaceModel( dff, 6490 )
local col = engineLoadCOL ("chao.col" )
engineReplaceCOL ( col, 6490)
end)


