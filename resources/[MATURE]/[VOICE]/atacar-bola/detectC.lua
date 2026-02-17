function removeDamageOnExplotion(_, _, _, theType) 
  if theType == 0 then 
    cancelEvent() 
  end 
end 
addEventHandler("onClientExplosion", root, removeDamageOnExplotion) 

addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
local txd = engineLoadTXD("grenade.txd")
			engineImportTXD(txd, 342)
local dff = engineLoadDFF("grenade.dff", 342)
			engineReplaceModel(dff, 342)
			
    end
);
