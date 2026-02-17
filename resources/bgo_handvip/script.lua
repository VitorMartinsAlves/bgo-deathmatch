function loadHandling2(v)
		


                    --doger
			 if getElementModel(v) == 504 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 200)
				setVehicleHandling(v, "engineAcceleration", 30)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.60)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end


                           --AUDI
			 if getElementModel(v) == 477 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 260)
				setVehicleHandling(v, "engineAcceleration", 60)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.60)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end	



			 -- camaro
			 if getElementModel(v) == 603 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 240)
				setVehicleHandling(v, "engineAcceleration", 30)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.60)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end	
			  -- CARRO DOS VIPS
			 if getElementModel(v) == 507 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 200)
				setVehicleHandling(v, "engineAcceleration", 25)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.60)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end				

			         --LAMBO
			 if getElementModel(v) == 561 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 225)
				setVehicleHandling(v, "engineAcceleration", 35)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.60)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end	
		
                       --ferrari
			 if getElementModel(v) == 541 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 245)
				setVehicleHandling(v, "engineAcceleration", 60)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.60)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end	
                          --MOTO NINJA
			if getElementModel(v) == 521 then
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 25)
				setVehicleHandling(v, "engineInertia", 5.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "driveType", "fwd")
				setVehicleHandling(v, "steeringLock", 45.0)
				setVehicleHandling(v, "tractionMultiplier", 1.51)
				setVehicleHandling(v, "tractionLoss", 1.15)
				setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "brakeDeceleration", 12)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "dragCoeff",0.0)
			 end	
			 
			
end

function loadHandlings2()
	setTimer(function()
	for k, v in ipairs(getElementsByType("vehicle")) do
		loadHandling2(v)
	end
	end,60000,1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadHandlings2)


	
	
addEventHandler("onVehicleEnter", root, function(player)
	local veh = getPedOccupiedVehicle(player)
	if player:getOccupiedVehicle() and player:getOccupiedVehicleSeat() == 0 then
    loadHandling2(source)
	
	local level = source:getData("tuning.airRideActive")
	if tonumber(level) == 0 then
		setVehicleHandling(source, "suspensionLowerLimit", getOriginalHandling(getElementModel(source))["suspensionLowerLimit"])
	elseif tonumber(level) == 1 then
		setVehicleHandling(source, "suspensionLowerLimit", 0.01)
	elseif tonumber(level) == 2 then
		setVehicleHandling(source, "suspensionLowerLimit", -0.1)
	elseif tonumber(level) == 3 then
		setVehicleHandling(source, "suspensionLowerLimit", -0.2)
	elseif tonumber(level) == 4 then
		setVehicleHandling(source, "suspensionLowerLimit", -0.3)
	elseif tonumber(level) == 5 then
		setVehicleHandling(source, "suspensionLowerLimit", -0.45)
	end
	
	
	end
end
)


--[[
function resetHandling()
	 for k, v in ipairs(getElementsByType("vehicle")) do
		 for k1,v1 in ipairs(setModelHandling(getVehicleModel(v))) do
			-- setVehicleHandling(v, k1, nil)
		 end
	 end
 end
 addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), resetHandling)]]--