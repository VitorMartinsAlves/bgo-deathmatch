 --[[


 ################################################
 #                                              #                                                  
 #             SCRIPT DESENVOLVIDO POR:         #
 #             Facebook.com/FENIXMTA/           #
 #             Youtube.com/FENIXMTA             #
 #             Não retire os créditos !         #
 #                                              #
 ################################################




 --]]
 
addEventHandler ( 'onPlayerWeaponFire', getRootElement ( ),
	function (  )
	 local Weapon =  getPedWeapon (source )
	 if Weapon == 34 then
		toggleControl ( source, 'fire', false ) 
		toggleControl(source, "action", false)
		setTimer(function(source)
		toggleControl ( source, 'fire', true )
		toggleControl(source, "action", true)		
		end, 2500, 1, source)
	end
	end 
)

addEventHandler ( 'onPlayerWeaponFire', getRootElement ( ),
	function (  )
	 local Weapon =  getPedWeapon (source )
	 if Weapon == 23 then
		toggleControl ( source, 'fire', false ) 
		toggleControl(source, "action", false)
		setTimer(function(source)
		toggleControl ( source, 'fire', true )
		toggleControl(source, "action", true)		
		end, 10000, 1, source)
	end
	end 
)

