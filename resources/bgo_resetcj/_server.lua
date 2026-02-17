function getClothes (thePlayer)
    for i=0,17 do      
        removePedClothes (thePlayer, i )          
    end
end
addCommandHandler ( "resetcj", getClothes )