
burners = {}


function eject (thePlayer, commandName,  lib)
	if getElementData(thePlayer,"acc:id") == 1 then
		eX, eY, eZ = getElementPosition( thePlayer )

			local x,y,z = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x, y, z, 6, "player" )
			local targetPlayer = nil
			for i = 1, #tabela do
			targetPlayer = tabela[i] 
		if targetPlayer then
				removePedFromVehicle ( targetPlayer )
			speedx, speedy, speedz = 0,0,0 --getElementVelocity ( thePlayer ) -- get the velocity of the player
	
			setElementPosition (targetPlayer, eX + math.random(1,10), eY + math.random(1,10), eZ+600 )
			--setTimer (setElementVelocity , 50, 200, targetPlayer, speedx*0.5, speedy*0.5, 400 )
			giveWeapon ( targetPlayer, 46, 1, true )
			end
		end
	end
end
addCommandHandler('saltarall', eject)
