

addEvent("onClientSyncVOZ", true )
addEventHandler("onClientSyncVOZ", root,
    function()
--setPedAnimation(thePlayer, "ped", "factalk", -1, true, true, false )

	--setPedAnimation(source, "GHANDS", "gsign2LH", 0, true, false, false)

	setPedAnimation(source, "GHANDS", "gsign1", 0, true, false, false)
	setTimer ( setPedAnimationProgress, 100, 1, source, "gsign1", 1.46)
	setTimer ( setPedAnimationSpeed, 100, 1, source, "gsign1", 0)

--	setTimer ( setPedAnimationProgress, 100, 1, source, "gsign2LH", 1.16)
--	setTimer ( setPedAnimationSpeed, 100, 1, source, "gsign2LH", 0)
	
    end
)


addEvent("onClientSyncVOZparar", true )
addEventHandler("onClientSyncVOZparar", root,
    function()
		--setTimer ( setPedAnimationSpeed, 50, 1, source, "gsign2LH", 1.0)
		--setTimer ( setPedAnimationProgress, 100, 1, source, "gsign2LH", 0.5)
		setTimer ( setPedAnimation, 100, 1, source,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, source, nil)
		
    end
)



addEvent("onClientDesmaiarON", true )
addEventHandler("onClientDesmaiarON", root,
    function()
		setPedAnimation(source, "KNIFE", "KILL_Knife_Ped_Die", -1, false, true, false)
	
    end
)











addEvent("removerarma", true )
addEventHandler("removerarma", root,
    function()
		takeWeapon( source, 22 )
		toggleControl (source, "fire", true )
		toggleControl (source, "action", true ) 
	--	triggerClientEvent(getRootElement(), "removeWeaponStickerC", getRootElement(), source)
    end
)

addEvent("dararma", true )
addEventHandler("dararma", root,
	function()
		giveWeapon (source,22,1, true )
		toggleControl (source, "action", false ) 
		toggleControl (source, "fire", false )
		--triggerClientEvent(getRootElement(), "setWeaponStickerC", getRootElement(), source, colt45, glock1)
		--local weapon = givePedWeapon (source,22,1, true )
		--setElementAlpha(weapon, 0) 
    end
)




