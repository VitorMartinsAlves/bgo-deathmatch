addEvent( "onChangeClothesCJC", true )
addEventHandler( "onChangeClothesCJC", root,
function ( CJClothesTable, CJClothesString )
    if ( CJClothesTable ) then
        for int, index in pairs( CJClothesTable ) do
            local texture, model = getClothesByTypeIndex ( int, index )
            if ( texture ) then
                addPedClothes ( source, texture, model, int )
		end
    end
end
end
)

addEvent( "onPlayerBougtSkinC", true )
addEventHandler( "onPlayerBougtSkinC", root,
function ( thePrice ) 
    if ( thePrice ) then
	setElementData(source,"char:money", getElementData(source,"char:money") - thePrice)
    end
end
)


addEvent( "AplicarRoupaSC", true )
addEventHandler( "AplicarRoupaSC", root,
function (thePlayer, texture, modelo, id )
    if ( thePlayer ) then
    addPedClothes ( thePlayer, texture, modelo, id )
end
end
)


addEvent( "ResetRoupaSC", true )
addEventHandler( "ResetRoupaSC", root,
function(player)
    if (isElement(player)) then

        if (getPedClothes(player, 1)) then
            removePedClothes(player, 1)
        end

    end
end 
)