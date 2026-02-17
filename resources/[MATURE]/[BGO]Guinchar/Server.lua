local con = exports.bgo_mysql:getConnection()

--[[
local my = {}

function exitCar (player)
local vehicle = getPedOccupiedVehicle (player)
	 if (vehicle) then
		if (getElementData(player, "char:dutyfaction") == 1 or getElementData(player, "char:dutyfaction") == 21) then
	     if (getElementModel(vehicle) == 578 or getElementModel(vehicle) == 495) then
	        local xX, yY, zZ = getElementPosition(vehicle)
		    if isElement(my[vehicle]) then
                destroyElement(my[vehicle])
            end
		    my[vehicle] = createColSphere (xX + 2.5, yY + 7, zZ, 3)
		    attachElements (my[vehicle], vehicle, 0, -8, -0.5 )
		    removeEventHandler("onColShapeHit", my[vehicle], exitCar)
			addEventHandler("onColShapeHit", my[vehicle], exitCar)			 
			addEventHandler( "onElementDestroy", vehicle,
			function ()
				setElementData(vehicle, "mec:veh", nil)
				removeElementData(vehicle, "mec:veh")
				if isElement(my[vehicle]) then 
				destroyElement(my[vehicle])
				end
			end
			)
			end
		end
	end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitCar)

function exitCar (thePlayer)
  	 if (source == my[thePlayer]) then
	     if (getElementData(thePlayer, "char:dutyfaction") == 1) then
            outputChatBox("#FFA000[GUINCHO] #FFFFFFUtilize #FFA000/guinchar #FFFFFFpara guinchar o veiculo.", thePlayer, 255,255,255, true)
		 end
	 end
end

local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } } 

function generateString ( len )
    if tonumber ( len ) then
        math.randomseed ( getTickCount () )
        local str = ""
        for i = 1, len do
            local charlist = allowed[math.random ( 1, 3 )]
            str = str .. string.char ( math.random ( charlist[1], charlist[2] ) )
        end
        return str
    end
    return false
    
end

function warpVehicle (player)
	if (getElementData(player, "char:dutyfaction") == 1 or getElementData(player, "char:dutyfaction") == 21) then
	if (getElementData(player, "char:guinchado") == true) then return end
	local vehicle = getPedOccupiedVehicle (player)
	local vehicleP = generateString (20)
	for index, isEvent in pairs(getElementsWithinColShape(my[vehicle], "vehicle")) do
		if (getElementModel(isEvent) == 578 or getElementModel(isEvent) == 495) then 
			outputChatBox("#FFA000[GUINCHO] #FFFFFFVocê não pode usar o #FFA000/guinchar #FFFFFFneste tipo de veiculo!.", player, 255,255,255, true) 
			return 
		end
		outputChatBox("#FFA000[GUINCHO] #FFFFFFVeiculo guinchado!", player, 255,255,255, true)
		setElementData(player, "char:guinchado", true)
		setElementData(player, "mec:reboque", vehicleP)
		attachElements(isEvent, vehicle, 0, -2, 0.4)
		setElementData(isEvent, "mec:veh", vehicleP)
		end
	end
end
addCommandHandler("guinchar", warpVehicle)


addCommandHandler("dguinchar",
function(player)
local vehicle2 = getPedOccupiedVehicle (player)
     if (getElementData(player, "char:dutyfaction") == 1 or getElementData(player, "char:dutyfaction") == 21) then
	 local vehP = getElementData(player, "mec:reboque")
	     if (vehP) then
		     for _, vehicle in ipairs(getElementsByType("vehicle")) do
			     if (getElementData(vehicle, "mec:veh") == vehP) then
					attachElements (vehicle, my[vehicle2], 0, -8, -0.5 )
					detachElements ( vehicle )
					local xX, yY, zZ = getElementPosition(my[vehicle2])
					setElementPosition(vehicle, xX, yY, zZ)
					setElementData(player, "char:guinchado", false)
					setElementData(vehicle, "mec:veh", nil)
					removeElementData(vehicle, "mec:veh")
					setElementData(player, "mec:reboque", nil)
					removeElementData(player, "mec:reboque")
				 end
			 end
		 end
	 end
end)


addEventHandler("onPlayerQuit", root,
function ()
     if (getElementData(source, "char:dutyfaction") == 1 or getElementData(source, "char:dutyfaction") == 21) then
	 local vehP = getElementData(source, "mec:reboque")
	     if (vehP) then
		     for _, vehicle in ipairs(getElementsByType("vehicle")) do
			     if (getElementData(vehicle, "mec:veh") == vehP) then
				     detachElements ( vehicle )
				 end
			 end
		 end
	 end
end)
]]--



local my = {}

function exitCar (player)
local vehicle = getPedOccupiedVehicle (player)
	 if (vehicle) then
		if (getElementData(player, "char:dutyfaction") == 1 or getElementData(player, "char:dutyfaction") == 21) then
	     if (getElementModel(vehicle) == 578 or getElementModel(vehicle) == 495) then
	        local xX, yY, zZ = getElementPosition(vehicle)
		    if isElement(my[player]) then
                destroyElement(my[player])
            end
		    my[player] = createColSphere (xX + 2.5, yY + 7, zZ, 3)
		    attachElements (my[player], vehicle, 0, -8, -0.5 )
		    removeEventHandler("onColShapeHit", my[player], exitCar)
			addEventHandler("onColShapeHit", my[player], exitCar)	
			
			addEventHandler( "onElementDestroy", vehicle,
			function ()
				setElementData(vehicle, "mec:veh", nil)
				removeElementData(vehicle, "mec:veh")
				if isElement(my[source]) then 
				destroyElement(my[source])
				end
			end
			)
			end
		end
	end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitCar)

function exitCar (thePlayer)
  	 if (source == my[thePlayer]) then
	     if (getElementData(thePlayer, "char:dutyfaction") == 1) then
            outputChatBox("#FFA000[GUINCHO] #FFFFFFUtilize #FFA000/guinchar #FFFFFFpara guinchar o veiculo.", thePlayer, 255,255,255, true)
		 end
	 end
end

local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } } 

function generateString ( len )
    if tonumber ( len ) then
        math.randomseed ( getTickCount () )
        local str = ""
        for i = 1, len do
            local charlist = allowed[math.random ( 1, 3 )]
            str = str .. string.char ( math.random ( charlist[1], charlist[2] ) )
        end
        return str
    end
    return false
    
end

function warpVehicle (player)
	if (getElementData(player, "char:dutyfaction") == 1 or getElementData(player, "char:dutyfaction") == 21) then
	if (getElementData(player, "char:guinchado") == true) then return end

	local vehicle = getPedOccupiedVehicle (player)
	local vehicleP = generateString (20)
	
	if not isElement(my[player]) then return end
		
	for index, isEvent in pairs(getElementsWithinColShape(my[player], "vehicle")) do
		if getElementDimension(isEvent) == 0 then
		if (getElementModel(isEvent) == 578 or getElementModel(isEvent) == 495) then 
			outputChatBox("#FFA000[GUINCHO] #FFFFFFVocê não pode usar o #FFA000/guinchar #FFFFFFneste tipo de veiculo!.", player, 255,255,255, true) 
			return 
		end
		outputChatBox("#FFA000[GUINCHO] #FFFFFFVeiculo guinchado!", player, 255,255,255, true)
		setElementData(player, "char:guinchado", true)
		setElementData(player, "mec:reboque", vehicleP)
		attachElements(isEvent, vehicle, 0, -2, 0.4)
		setElementData(isEvent, "mec:veh", vehicleP)
		
		setElementData(isEvent, "veh:detran", true)
		
		local dbid = getElementData(isEvent, "veh:id")
		local detran = 1
		--if dbPoll ( dbQuery( con, "UPDATE vehicle SET paintjob=?, WHERE id=?",detran, dbid), -1 ) then
		

		dbExec(con, "UPDATE vehicle SET paintjob = ? WHERE id = ?", detran, dbid)

		
		
		outputDebugString("[Veiculo]: id do veiculo: "..dbid.." PRESO...")
		--end
		


		 
		 
		end
	end
	end
end
addCommandHandler("guinchar", warpVehicle)


addCommandHandler("dguinchar",
function(player)
local vehicle2 = getPedOccupiedVehicle (player)
     if (getElementData(player, "char:dutyfaction") == 1 or getElementData(player, "char:dutyfaction") == 21) then
	 local vehP = getElementData(player, "mec:reboque")
	     if (vehP) then
		     for _, vehicle in ipairs(getElementsByType("vehicle")) do
			     if (getElementData(vehicle, "mec:veh") == vehP) then
					attachElements (vehicle, my[player], 0, -8, -0.5 )
					detachElements ( vehicle )
					local xX, yY, zZ = getElementPosition(my[player])
					setElementPosition(vehicle, xX, yY, zZ)
					setElementData(player, "char:guinchado", false)
					setElementData(vehicle, "veh:detran", false)
					removeElementData(vehicle, "veh:detran")
					setElementData(vehicle, "mec:veh", nil)
					removeElementData(vehicle, "mec:veh")
					setElementData(player, "mec:reboque", nil)
					removeElementData(player, "mec:reboque")
					
					--local dbid = tonumber(getElementData(vehicle, "veh:id")) or 0
					--dbExec(con, "UPDATE vehicle SET paintjob = ? WHERE id = ?", 0, dbid)
		
		
				 end
			 end
		 end
	 end
end)


addEventHandler("onPlayerQuit", root,
function ()
     if (getElementData(source, "char:dutyfaction") == 1 or getElementData(source, "char:dutyfaction") == 21) then
	 local vehP = getElementData(source, "mec:reboque")
	     if (vehP) then
		     for _, vehicle in ipairs(getElementsByType("vehicle")) do
			     if (getElementData(vehicle, "mec:veh") == vehP) then
				     detachElements ( vehicle )
					 local dbid = tonumber(getElementData(vehicle, "veh:id")) or 0
					dbExec(con, "UPDATE vehicle SET paintjob = ? WHERE id = ?", 0, dbid)
				 end
			 end
		 end
	 end
end) 