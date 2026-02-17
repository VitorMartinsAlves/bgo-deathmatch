--[[addEvent("pedreiro.marker", true)
addEventHandler("pedreiro.marker", root, function()
local theVeh =  exports.bgo_rentals:getPlayerRentalVehicle(client)
if ( isElement(theVeh) ) and ( getElementModel(theVeh) == 408 ) then
local SX,SY,SZ = getElementPosition(theVeh)
triggerClientEvent ( client, "pedreiro.createmarker", resourceRoot, SX, SY, SZ, theVeh )
end
end )
]]--
	local blip = createBlip (2714.897, 844.693, 10.898, 42)
	setElementData(blip,"blipName", "Trabalho de Pedreiro")
	
	
addEvent("pedreiro.pay", true)
addEventHandler("pedreiro.pay", root, function()
	exports.bgo_admin:setPlayerPagamento(client)
end)

theArrow = createMarker ( 2714.897, 844.693, 10.898-0.9, "cylinder", 2, 51, 204, 0, 100 )
function takeTheTrash(thePlayer)
if getElementData(thePlayer, "job") == "Pedreiro" then
triggerClientEvent ( thePlayer, "pedreiro.onWasteEnter", resourceRoot )
exports.bgo_hud:dm("Vá até as caixas para começar!", thePlayer, 255, 200, 0)
end
end
addEventHandler("onMarkerHit",theArrow,takeTheTrash) 

--exports.bgo_employment:setPlayerJob(source, "Pedreiro", "Pedreiro", 0,true)



local objeto = { }
addEvent("pedreiro.objeto", true)
addEventHandler("pedreiro.objeto", root, function()
		local x1,y1,z1 = getElementPosition(client)
		if isElement(objeto[client]) then
		destroyElement(objeto[client])
		end
		
				
		objeto[client] = createObject(2960, x1, y1, z1)
		setObjectScale(objeto[client], 0.3)
		setElementCollisionsEnabled (objeto[client], false)
		
		
		--[[
		objeto[client] = createObject(2912,x1,y1,z1)
		setElementCollisionsEnabled(objeto[client],false)
		local rot = getElementRotation(client)
		exports.bone_attach:attachElementToBone(objeto[client],client,3,0, 0.55, -0.1, 0, rot, 0) 
		]]--
		
		
		
		exports.bone_attach:attachElementToBone(objeto[client],client,3, 0, 0.40, 0.19, 0, 0, 0)
		
end )

addEvent("pedreiro.removeobjeto", true)
addEventHandler("pedreiro.removeobjeto", root, function(id)
	if id == 1 then
		exports.bone_attach:detachElementFromBone(objeto[client])
	elseif id == 2 then 
		if isElement(objeto[client]) then
		destroyElement(objeto[client])
		end
	end
end )


function quitPlayer ()
		if isElement(objeto[source]) then
		destroyElement(objeto[source])
		end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )



addEvent("pedreiro.anim", true)
addEventHandler("pedreiro.anim", root, function(anim)
if anim == 1 then
    exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, false)
    exports.bgo_anims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, true)
elseif anim == 2 then 
    exports.bgo_anims:setJobAnimation(client, "CARRY", "liftup", 1000, true, false, false, false)
elseif anim == 3 then 
	exports.bgo_anims:setJobAnimation(client, "GRENADE", "WEAPON_throwu", 500, true, false, false, false)
end
end )






--[[




local zone = createColCuboid(583.07361, -1523.72534, 12.67776, 34.897399902344, 35.071411132813, 30.800079727173)
		
		
		
function shapeHit(hitElement)
	if getElementType (hitElement) == "player" then  
	--setElementDimension(hitElement,1)
	setElementData(hitElement,"protecaoPedreiro", true)
	elseif getElementType(hitElement) == "vehicle" then 
	setElementPosition(hitElement,633.292, -1576.982, 14.918)	
	end
end
addEventHandler ( "onColShapeHit", zone, shapeHit )

		
function shapeLeave(leaveElement)
	if getElementType (leaveElement) == "player" then 
	--setElementDimension(leaveElement,0)	
	setElementData(leaveElement,"protecaoPedreiro", false)
	end
end
addEventHandler ( "onColShapeLeave", zone, shapeLeave )]]---