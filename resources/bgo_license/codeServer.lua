exitCar = {}
vehicleCar = {}

function createLicenseVehicle(player)
	x, y, z = 2433.3330078125,-2072.3896484375,13.546875
	vehicleCar[player] = createVehicle(483, x, y, z,0,0,180)
	exitCar[player] = true
	setElementData(vehicleCar[player], "carDetran", true)
	addEventHandler ("onVehicleExit", vehicleCar[player], removeHelmetOnExit )
    addEventHandler ("onVehicleEnter", vehicleCar[player], enterCar)
	setElementHealth(vehicleCar[player], 1000)
	setVehicleColor (vehicleCar[player], 255, 255, 0, 255, 255, 255)
	setVehicleHeadLightColor ( vehicleCar[player], 255, 255, 0 )
	
	setElementData(vehicleCar[player], "enginebroke", 0)
	setElementData(vehicleCar[player], "dbid", -1)
	setElementData(vehicleCar[player], "owner", -1)
	setElementData(vehicleCar[player], "fuel", 100)
	setElementData(vehicleCar[player], "engine", 0)
	setElementData(vehicleCar[player], "lights", 0)
	setElementData(vehicleCar[player], "faction", -1)
	setElementInterior(vehicleCar[player], 0)
	setElementDimension(vehicleCar[player], 0)
	setElementInterior(vehicleCar[player], 0)
	setElementInterior(player, 0)
	setElementData(vehicleCar[player], "interior", 0)	
	setElementDimension(vehicleCar[player], 0)
	setElementDimension(player, 0)
	setElementData(vehicleCar[player], "dimension", 0)
	setVehicleEngineState(vehicleCar[player], false)
	setVehiclePlateText(vehicleCar[player], "TanulÃ³")
	setVehicleRespawnPosition(vehicleCar[player], x,y,z,0,0,90)
	
	warpPedIntoVehicle(player, vehicleCar[player])
end 
addEvent("createLicenseVehicle", true)
addEventHandler("createLicenseVehicle", getRootElement(), createLicenseVehicle)

addEvent("finishLicense", true)
addEventHandler("finishLicense", getRootElement(), 
	function(player)
		if player then
			--setTimer(deletVehicle, 500, 1, player)

			if isElement(vehicleCar[player]) then
				destroyElement(vehicleCar[player])
				exitCar[player] = nil
				vehicleCar[player] = nil
   
				--triggerClientEvent(thePlayer, "finishLicense2", thePlayer)
   
			end

			-- destroyElement(getPedOccupiedVehicle(player))
			-- exitCar[player] = nil
			-- vehicleCar[player] = nil
		end 
	end
)

function notifyAboutExplosion()
     if (getElementData(source, "carDetran")) then
	     destroyElement(source)
		 removeElementData(source, "carDetran")
	 end
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion)

function removeHelmetOnExit ( thePlayer, seat, jacked )
    if (exitCar[thePlayer]) then  
         outputChatBox("#FFA000*BGO DRVV #FFFFFFVocê tem #FFA00010 Segundos #FFFFFFpara entrar no veículo da auto escola novamente!", thePlayer, 255,255,255, true)
		 setTimer(deletVehicle, 10000, 1, thePlayer)
		 exitCar[thePlayer] = false
    end
end

function enterCar ( thePlayer, seat, jacked )
    if (exitCar[thePlayer] == false) then  
		 exitCar[thePlayer] = true
    end
end

function deletVehicle (thePlayer)
     if not (exitCar[thePlayer]) then
		 if isElement(vehicleCar[thePlayer]) then
		     destroyElement(vehicleCar[thePlayer])
			 exitCar[thePlayer] = nil
			 vehicleCar[thePlayer] = nil

			 triggerClientEvent(thePlayer, "finishLicense2", thePlayer)

		 end
	 end
end

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		 if (exitCar[source]) then
			 exitCar[source] = nil
			 vehicleCar[source] = nil
		     if isElement(vehicleCar[thePlayer]) then
				 destroyElement(vehicleCar[thePlayer])
				 
				 triggerClientEvent(thePlayer, "finishLicense2", thePlayer)

		     end
		 end 
	end
)


addEventHandler( "onPlayerQuit", getRootElement( ),
	function()
		 if (exitCar[source]) then
			 exitCar[source] = nil
			 vehicleCar[source] = nil
		     if isElement(vehicleCar[thePlayer]) then
				 destroyElement(vehicleCar[thePlayer])
				 
				 triggerClientEvent(source, "finishLicense2", source)

		     end
		 end 
	end
)