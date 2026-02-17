function loadHandling(v)






	-- onibus
	if getElementModel(v) == 431 then
		setVehicleHandling(v, "maxVelocity", 60)
		setVehicleHandling(v, "engineAcceleration", 10)
	end	
	
	--DRIFT
	if getElementModel(v) == 558 then
		setVehicleHandling(v, "mass", 1600)
		setVehicleHandling(v, "turnMass", 3000)
		setVehicleHandling(v, "dragCoeff", 1.8)
		setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
		setVehicleHandling(v, "percentSubmerged", 75)
		setVehicleHandling(v, "tractionMultiplier", 1.1)
		setVehicleHandling(v, "tractionLoss", 0.9)
		setVehicleHandling(v, "tractionBias", 0.497)
		setVehicleHandling(v, "numberOfGears", 5)
		setVehicleHandling(v, "maxVelocity", 170)
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
			
			   -- RAM
				if getElementModel(v) == 470 then
				setVehicleHandling(v, "mass", 15600)
				setVehicleHandling(v, "turnMass", 19000)
				setVehicleHandling(v, "dragCoeff", 1.9)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.2)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 500)
				setVehicleHandling(v, "engineAcceleration", 30)
				setVehicleHandling(v, "engineInertia", 50)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 38)
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
			
			
			
                 --VIATURA DAS CORPS
			 if getElementModel(v) == 490 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 205)
				setVehicleHandling(v, "engineAcceleration", 15)
				setVehicleHandling(v, "engineInertia", 15)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 15)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1.8)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.3)
				setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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
			
			
			--bmw x6
			 if getElementModel(v) == 438 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 1.1)
				setVehicleHandling(v, "tractionLoss", 0.9)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 203)
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


	

       --FIAT TORO
if getElementModel(v) == 400 then
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
	setVehicleHandling(v, "engineAcceleration", 15)
	setVehicleHandling(v, "engineInertia", 15)
	setVehicleHandling(v, "driveType", "awd")
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "ABS", false)
	setVehicleHandling(v, "steeringLock", 35)
	setVehicleHandling(v, "suspensionForceLevel", 1.8)
	setVehicleHandling(v, "suspensionDamping", 0.5)
	setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
	setVehicleHandling(v, "suspensionUpperLimit", 0.3)
	setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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
     --outlander
if getElementModel(v) == 418 then
	setVehicleHandling(v, "mass", 1600)
	setVehicleHandling(v, "turnMass", 3000)
	setVehicleHandling(v, "dragCoeff", 1.8)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "percentSubmerged", 75)
	setVehicleHandling(v, "tractionMultiplier", 1.1)
	setVehicleHandling(v, "tractionLoss", 0.9)
	setVehicleHandling(v, "tractionBias", 0.497)
	setVehicleHandling(v, "numberOfGears", 5)
	setVehicleHandling(v, "maxVelocity", 205)
	setVehicleHandling(v, "engineAcceleration", 15)
	setVehicleHandling(v, "engineInertia", 15)
	setVehicleHandling(v, "driveType", "awd")
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "ABS", false)
	setVehicleHandling(v, "steeringLock", 35)
	setVehicleHandling(v, "suspensionForceLevel", 1.8)
	setVehicleHandling(v, "suspensionDamping", 0.5)
	setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
	setVehicleHandling(v, "suspensionUpperLimit", 0.3)
	setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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


       --AMBULANCIA
if getElementModel(v) == 416 then
	setVehicleHandling(v, "mass", 1600)
	setVehicleHandling(v, "turnMass", 3000)
	setVehicleHandling(v, "dragCoeff", 1.8)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "percentSubmerged", 75)
	setVehicleHandling(v, "tractionMultiplier", 1.1)
	setVehicleHandling(v, "tractionLoss", 0.9)
	setVehicleHandling(v, "tractionBias", 0.497)
	setVehicleHandling(v, "numberOfGears", 5)
	setVehicleHandling(v, "maxVelocity", 130)
	setVehicleHandling(v, "engineAcceleration", 20)
	setVehicleHandling(v, "engineInertia", 15)
	setVehicleHandling(v, "driveType", "awd")
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "ABS", false)
	setVehicleHandling(v, "steeringLock", 35)
	setVehicleHandling(v, "suspensionForceLevel", 1.8)
	setVehicleHandling(v, "suspensionDamping", 0.5)
	setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
	setVehicleHandling(v, "suspensionUpperLimit", 0.3)
	setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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

      --JEEP
if getElementModel(v) == 547 then
	setVehicleHandling(v, "mass", 2000)
	setVehicleHandling(v, "turnMass", 3000)
	setVehicleHandling(v, "dragCoeff", 1.8)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "percentSubmerged", 75)
	setVehicleHandling(v, "tractionMultiplier", 1.1)
	setVehicleHandling(v, "tractionLoss", 0.9)
	setVehicleHandling(v, "tractionBias", 0.497)
	setVehicleHandling(v, "numberOfGears", 5)
	setVehicleHandling(v, "maxVelocity", 180)
	setVehicleHandling(v, "engineAcceleration", 15)
	setVehicleHandling(v, "engineInertia", 15)
	setVehicleHandling(v, "driveType", "awd")
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "ABS", false)
	setVehicleHandling(v, "steeringLock", 35)
	setVehicleHandling(v, "suspensionForceLevel", 1.8)
	setVehicleHandling(v, "suspensionDamping", 0.5)
	setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
	setVehicleHandling(v, "suspensionUpperLimit", 0.3)
	setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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

    --capitiva
if getElementModel(v) == 466 then
	setVehicleHandling(v, "mass", 1600)
	setVehicleHandling(v, "turnMass", 3000)
	setVehicleHandling(v, "dragCoeff", 1.8)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "percentSubmerged", 75)
	setVehicleHandling(v, "tractionMultiplier", 1.1)
	setVehicleHandling(v, "tractionLoss", 0.9)
	setVehicleHandling(v, "tractionBias", 0.497)
	setVehicleHandling(v, "numberOfGears", 5)
	setVehicleHandling(v, "maxVelocity", 180)
	setVehicleHandling(v, "engineAcceleration", 20)
	setVehicleHandling(v, "engineInertia", 15)
	setVehicleHandling(v, "driveType", "awd")
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "ABS", false)
	setVehicleHandling(v, "steeringLock", 35)
	setVehicleHandling(v, "suspensionForceLevel", 1.8)
	setVehicleHandling(v, "suspensionDamping", 0.5)
	setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
	setVehicleHandling(v, "suspensionUpperLimit", 0.3)
	setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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


    --VELOSTER
if getElementModel(v) == 562 then
	setVehicleHandling(v, "mass", 1600)
	setVehicleHandling(v, "turnMass", 3000)
	setVehicleHandling(v, "dragCoeff", 1.8)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "percentSubmerged", 75)
	setVehicleHandling(v, "tractionMultiplier", 1.1)
	setVehicleHandling(v, "tractionLoss", 0.9)
	setVehicleHandling(v, "tractionBias", 0.497)
	setVehicleHandling(v, "numberOfGears", 5)
	setVehicleHandling(v, "maxVelocity", 170)
	setVehicleHandling(v, "engineAcceleration", 15)
	setVehicleHandling(v, "engineInertia", 15)
	setVehicleHandling(v, "driveType", "awd")
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "ABS", false)
	setVehicleHandling(v, "steeringLock", 35)
	setVehicleHandling(v, "suspensionForceLevel", 1.8)
	setVehicleHandling(v, "suspensionDamping", 0.5)
	setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
	setVehicleHandling(v, "suspensionUpperLimit", 0.3)
	setVehicleHandling(v, "suspensionLowerLimit", -0.05)
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


     --MOTO POLICIA
if getElementModel(v) == 523 then
	setVehicleHandling(v, "maxVelocity", 220)
	setVehicleHandling(v, "engineAcceleration", 35)
	setVehicleHandling(v, "engineInertia", 5.0)
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "driveType", "fwd")
	setVehicleHandling(v, "steeringLock", 45.0)
	setVehicleHandling(v, "tractionMultiplier", 1.51)
	setVehicleHandling(v, "tractionLoss", 1.15)
	setVehicleHandling(v, "tractionBias", 0.5)
	setVehicleHandling(v, "brakeDeceleration", 15)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "dragCoeff",0.0)
end	
	
  --moto do vips
 if getElementModel(v) == 463 then
	setVehicleHandling(v, "maxVelocity", 150)
	setVehicleHandling(v, "engineAcceleration", 15)
	setVehicleHandling(v, "engineInertia", 5.0)
	setVehicleHandling(v, "engineType", "petrol")
	setVehicleHandling(v, "driveType", "fwd")
	setVehicleHandling(v, "steeringLock", 45.0)
	setVehicleHandling(v, "tractionMultiplier", 1.51)
	setVehicleHandling(v, "tractionLoss", 1.15)
	setVehicleHandling(v, "tractionBias", 0.5)
	setVehicleHandling(v, "brakeDeceleration", 31.0)
	setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
	setVehicleHandling(v, "dragCoeff",0.0)
 end

 
 
 		-- brasilia
	if getElementModel(v) == 500 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 112)
		setVehicleHandling(v, "engineAcceleration", 5)
		setVehicleHandling(v, "brakeDeceleration", 3)
	end
	
				-- GOLF
	if getElementModel(v) == 436 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 162)
		setVehicleHandling(v, "engineAcceleration", 8)
		setVehicleHandling(v, "brakeDeceleration", 3)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
	

					--  chevett
	if getElementModel(v) == 401 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 165 )
		setVehicleHandling(v, "engineAcceleration", 9)
		setVehicleHandling(v, "brakeDeceleration", 3)
		setVehicleHandling(v, "engineInertia", 50)
	end

		
						--  gol quadrado
	if getElementModel(v) == 496 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 150 )
		setVehicleHandling(v, "engineAcceleration", 6)
		setVehicleHandling(v, "brakeDeceleration", 3)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
					--  Mercedes
	if getElementModel(v) == 560 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 210 )
		setVehicleHandling(v, "engineAcceleration", 20)
		setVehicleHandling(v, "brakeDeceleration", 7)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
	
							--  audi rs7
	if getElementModel(v) == 405 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 250 )
		setVehicleHandling(v, "engineAcceleration", 15)
		setVehicleHandling(v, "brakeDeceleration", 7)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
					--SONATA
	if getElementModel(v) == 580 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 210 )
		setVehicleHandling(v, "engineAcceleration", 15)
		setVehicleHandling(v, "brakeDeceleration", 7)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
					--  XJ6
	if getElementModel(v) == 522 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 215 )
		setVehicleHandling(v, "engineAcceleration", 23)
		setVehicleHandling(v, "brakeDeceleration", 12)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
	
							--  160
	if getElementModel(v) == 468 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 151 )
		setVehicleHandling(v, "engineAcceleration", 20)
		setVehicleHandling(v, "brakeDeceleration", 12)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
								--  ifood
	if getElementModel(v) == 448 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 70 )
		setVehicleHandling(v, "engineAcceleration", 14)
		setVehicleHandling(v, "brakeDeceleration", 12)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
	
				-- mecanico
	if getElementModel(v) == 525 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 130)
		setVehicleHandling(v, "engineAcceleration", 10)
		setVehicleHandling(v, "brakeDeceleration", 4)
		setVehicleHandling(v, "engineInertia", 50)
	end
	
					-- bgo express
	if getElementModel(v) == 413 then	
		--setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )		
		setVehicleHandling(v, "maxVelocity", 130)
		setVehicleHandling(v, "engineAcceleration", 6)
		setVehicleHandling(v, "brakeDeceleration", 4)
		setVehicleHandling(v, "engineInertia", 50)
	end
	

end

function loadHandlings()
	setTimer(function()
	for k, v in ipairs(getElementsByType("vehicle")) do
		loadHandling(v)
	end
	end,60000,1)
end
--addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadHandlings)



addEventHandler("onVehicleEnter", root, function(player)
	if player:getOccupiedVehicleSeat() == 0 then
    loadHandling(source)
	
		
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
