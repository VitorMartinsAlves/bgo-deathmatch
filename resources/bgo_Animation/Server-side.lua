anim = {}

function anim.fuck()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation(source, "RIOT", "RIOT_FUKU", -1, false, false, true, false)
end
addEvent("anim.fuck", true)
addEventHandler("anim.fuck", root, anim.fuck)

function anim.chat()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation(source, "ped", "IDLE_chat")
end
addEvent("anim.chat", true)
addEventHandler("anim.chat", root, anim.chat)

function anim.smoke()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	--smoke = createObject ( 1485, 0, 0, 0 )
	--attachElements (smoke, source, 0.05, 0, 0.7, 0, 45, 118 )
	setPedAnimation( source, "BAR", "dnk_stndM_loop")
	--setTimer(destroyElement, 40000, 1, smoke)
	--setTimer(setPedAnimation, 3000, 1, source, nil, nil)
end
addEvent("anim.smoke", true)
addEventHandler("anim.smoke", root, anim.smoke)

function anim.sexy()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation( source, "STRIP", "STR_B2C")
end
addEvent("anim.sexy", true)
addEventHandler("anim.sexy", root, anim.sexy)

function anim.dance()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation( source, "DANCING", "dnce_M_d")
end
addEvent("anim.dance", true)
addEventHandler("anim.dance", root, anim.dance)

function anim.espere()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation( source, "POLICE", "CopTraf_Stop", -1, false, false, true, false)
end
addEvent("anim.espere", true)
addEventHandler("anim.espere", root, anim.espere)

function anim.sentar()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation( source, "ped", "SEAT_idle", -1, true, false, false )
end
addEvent("anim.sentar", true)
addEventHandler("anim.sentar", root, anim.sentar)


function anim.handsup()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation( source, "shop", "SHP_Rob_HandsUp", -1, true, false, false )
	setElementData(source, "handsup", true)
end
addEvent("anim.handsup", true)
addEventHandler("anim.handsup", root, anim.handsup)

function anim.smile()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation( source, "CASINO", "manwind", -1, false, false, true, false )
end
addEvent("anim.smile", true)
addEventHandler("anim.smile", root, anim.smile)

function anim.cancel()
   local theVehicle = getPedOccupiedVehicle ( source )
   if theVehicle then return end
	setPedAnimation(source)
		setElementData(source, "handsup", false)
end
addEvent("anim.cancel", true)
addEventHandler("anim.cancel", root, anim.cancel)
