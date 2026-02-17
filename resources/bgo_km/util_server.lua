local rovid = "#7cc576[BGOMTA - Veiculo]:#FFFFFF"
local tempo = {}		
function greetingHandler(seat)
    local thePlayer = getPedOccupiedVehicle(source)
    if(thePlayer) then
	
		if getElementData(source, "veh:ov") == false then
		
		outputChatBox(rovid.." Você foi removido do veiculo por não está de cinto de segurança!", source, 255, 255, 255, true)
		--[[
		removePedFromVehicle ( source ) 
		local x,y,z = getElementPosition(source)
		setElementPosition(source, x,y,z+3)	
		setPedAnimation( source, "CRACK", "crckidle2", -1, true, false, false)
		setTimer(setPedAnimation,2000,1, source)
		setTimer(setPedAnimation,2100,1, source)
		
		]]--
		
		playerHealth = getElementHealth ( source )		
		colete = getPedArmor ( source )
		x, y, z = getElementPosition ( source )
		skin = getElementModel ( source )
		playerTeam = getPlayerTeam ( source ) 
		dim = getElementDimension ( source )
		int = getElementInterior ( source )
			speedx, speedy, speedz = getElementVelocity ( source ) -- get the velocity of the player
		setElementVelocity(source, speedx*0.2, speedy*0.2, 0.2)
		
		
		tempo[source] = setTimer (setElementVelocity , 50, 10, source, speedx*0.2, speedy*0.2, 0.2 )
			
		spawnPlayer ( source, x, y, z+1, 0, skin, int, dim, playerTeam )
		
		setElementHealth ( source, playerHealth )
		setPedArmor ( source, colete )
		
		setTimer(setPedAnimation,1000,5, source,"CRACK", "crckidle2", -1, true, false, false)			 
		--setPedAnimation( source, "CRACK", "crckidle2", -1, true, false, false)
		setTimer(setPedAnimation,5000,1, source)
		setTimer(setPedAnimation,5100,1, source)

		
	end
	
	
	end
end
addEvent( "removerdoveiculo", true )
addEventHandler( "removerdoveiculo", root, greetingHandler ) 



function greetingHandler2(seat)
    local thePlayer = getPedOccupiedVehicle(source)
    if(thePlayer) then
	

		outputChatBox(rovid.." Você foi removido do veiculo", source, 255, 255, 255, true)
		--removePedFromVehicle ( source )
		--local x,y,z = getElementPosition(source)
		--setElementPosition(source, x,y,z+2)
		playerHealth = getElementHealth ( source )		
		colete = getPedArmor ( source )
		x, y, z = getElementPosition ( source )
		skin = getElementModel ( source )
		playerTeam = getPlayerTeam ( source ) 
		dim = getElementDimension ( source )
		int = getElementInterior ( source )
			speedx, speedy, speedz = getElementVelocity ( source ) -- get the velocity of the player
		setElementVelocity(source, speedx*0.2, speedy*0.2, 0.2)
		
		
		tempo[source] = setTimer (setElementVelocity , 50, 10, source, speedx*0.2, speedy*0.2, 0.2 )
			
		spawnPlayer ( source, x, y, z+1, 0, skin, int, dim, playerTeam )
		
		setElementHealth ( source, playerHealth )
		setPedArmor ( source, colete )
		
		setTimer(setPedAnimation,1000,5, source,"CRACK", "crckidle2", -1, true, false, false)			 
		--setPedAnimation( source, "CRACK", "crckidle2", -1, true, false, false)
		setTimer(setPedAnimation,5000,1, source)
		setTimer(setPedAnimation,5100,1, source)

	

	
	
	end
end
addEvent( "removerdoveiculoMoto", true )
addEventHandler( "removerdoveiculoMoto", root, greetingHandler2 ) 




