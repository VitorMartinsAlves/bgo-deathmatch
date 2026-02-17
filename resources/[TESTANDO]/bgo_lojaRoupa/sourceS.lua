addEvent( "onChangeClothesCJ", true )
addEventHandler( "onChangeClothesCJ", root,
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

addEvent( "onPlayerBougtSkin", true )
addEventHandler( "onPlayerBougtSkin", root,
function ( thePrice ) 
    if ( thePrice ) then
	setElementData(source,"char:money", getElementData(source,"char:money") - thePrice)
    end
end
)


addEvent( "AplicarRoupaS", true )
addEventHandler( "AplicarRoupaS", root,
function (thePlayer, texture, modelo, id )
    if ( thePlayer ) then
    addPedClothes ( thePlayer, texture, modelo, id )
end
end
)


addEvent( "ResetRoupaS", true )
addEventHandler( "ResetRoupaS", root,
function(player)
    if (isElement(player)) then
        if (getPedClothes(player, 0)) then
            removePedClothes(player, 0)
        end 
        if (getPedClothes(player, 1)) then
            removePedClothes(player, 1)
        end
        if (getPedClothes(player, 2)) then
            removePedClothes(player, 2)
        end 
        if (getPedClothes(player, 3)) then
            removePedClothes(player, 3)
        end
        if (getPedClothes(player, 4)) then
            removePedClothes(player, 4)
        end
        if (getPedClothes(player, 5)) then
            removePedClothes(player, 5)
        end
        if (getPedClothes(player, 6)) then
            removePedClothes(player, 6)
        end
        if (getPedClothes(player, 7)) then
            removePedClothes(player, 7)
        end
        if (getPedClothes(player, 8)) then
            removePedClothes(player, 8)
        end
        if (getPedClothes(player, 9)) then
            removePedClothes(player, 9)
        end
        if (getPedClothes(player, 10)) then
            removePedClothes(player, 10)
        end
        if (getPedClothes(player, 11)) then
            removePedClothes(player, 11)
        end
        if (getPedClothes(player, 12)) then
            removePedClothes(player, 12)
        end
        if (getPedClothes(player, 13)) then
            removePedClothes(player, 13)
        end 
        if (getPedClothes(player, 14)) then
            removePedClothes(player, 14)
        end
        if (getPedClothes(player, 15)) then
            removePedClothes(player, 15)
        end
        if (getPedClothes(player, 16)) then
            removePedClothes(player, 16)
        end
        if (getPedClothes(player, 17)) then
            removePedClothes(player, 17)
        end
    end
end 
)