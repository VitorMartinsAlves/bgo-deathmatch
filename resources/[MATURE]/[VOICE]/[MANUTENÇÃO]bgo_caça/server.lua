local sellCol = {}
local sellPos = {
	{156, -2816.373046875, -1525.140625, 140.84375, "Josh", 180, 10, 6, 3}
}

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function ()
	for index, value in ipairs (sellPos) do 		
		sellCol[index] = createColCuboid(value[2]-value[7]/2, value[3]-value[8], value[4]-1, value[7], value[8], value[9])
		setElementData(sellCol[index], "sell >> hunter", true)
	end
end)

addEventHandler("onResourceStart", resourceRoot,
    function()
	    for k,v in ipairs(animalPositions) do
		    local x,y,z = v[1], v[2], v[3]
			local skin = v[4]
			local rot = v[5]
			local name = v[6]
			local maxHealth = v[7]
			local ped = createPed(skin, x,y,z, rot)
			setElementData(ped, "Ped:Name", name)
			setElementData(ped, "name:tags", "Animal")
			setElementData(ped, "hunter:animal", true)
			setElementData(ped, "hunter:canRob", false)
			setElementData(ped, "hunter:health", maxHealth)
			setElementData(ped, "hunter:maxHealth", maxHealth)
			setElementData(ped, "hunter:autoAttack", v[8])
			setElementData(ped, "hunter:attack", false)
			setElementData(ped, "hunter:target", nil)
			setElementData(ped, "hunter:defPos", {x,y,z})
			setElementData(ped, "hunter:use", false)
			setElementData(ped, "hunter:clicks", 0)
			--createBlip(x, y, z, 1, 0, 0, 0, 255)
		end
	end
)

addEvent("hunter:startAttack", true)
addEventHandler("hunter:startAttack", root, 
    function(e1, ped)
	    setElementData(ped, "hunter:attack", true)
		setElementData(ped, "hunter:target", e1)
	end
)

addEvent("hunter:stopAttack", true)
addEventHandler("hunter:stopAttack", root, 
    function(e1, ped)
	    --outputChatBox("asd3")
	    setElementData(ped, "hunter:attack", false)
		setElementData(ped, "hunter:target", nil)
	end
)

addEvent("hunter:destroyAnimal", true)
addEventHandler("hunter:destroyAnimal", root, 
    function(ped)
	    setElementFrozen(ped, true)
        local op = {getElementPosition(ped)}
		setElementPosition(ped, op[1], op[2], op[3]-50)
		setTimer(
		    function()
			    local p = getElementData(ped, "hunter:defPos")
				setElementFrozen(ped, false)
				--setPedAnimation(ped, "", "")
				triggerEvent("server:changeAnimation", root, source, "", "")
				setElementData(ped, "hunter:health", getElementData(ped, "hunter:maxHealth"))
				setElementData(ped, "hunter:use", false)
				setElementData(ped, "hunter:clicks", 0)
				setElementPosition(ped, p[1], p[2], p[3])
			end, 5 * 60 * 10000, 1
		)
	end
)

addEventHandler("onElementDataChange", root,
   function(dName, oldValue)
       if getElementType(source) == "ped" and getElementData(source, "hunter:animal") then
	       if dName == "hunter:health" then
		       local newValue = getElementData(source, dName)
			   if newValue <= 0 then
			      setElementFrozen(source, true)
				  --setPedAnimation(source, "ped", "FLOOR_hit", -1, false, false, false)
				  triggerEvent("server:changeAnimation", root, source, "ped", "FLOOR_hit")
			   end
		   end
	   end
   end
)

addEvent("server:changeAnimation", true)
addEventHandler("server:changeAnimation", root, 
    function(ped, b, a)
	    setElementFrozen(ped, true)
        setPedAnimation(ped, b, a, -1, false, false, false)
	end
)
			   
--[[addEvent("server:sound", true)
addEventHandler("server:sound", root, 
    function(ped, sound)
	    for _, localPlayer in ipairs(getElementsByType("player")) do
		    local x,y,z = getElementPosition(ped)
			local px,py,pz = getElementPosition(localPlayer)
			local d = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			--outputChatBox(maxInteract)
		    if d < maxDist and sound ~= nil then
				triggerClientEvent(localPlayer, "hunter:sound", localPlayer, sound, x,y,z)
			    --local soundElement = playSound3D(sound, x,y,z)
				 --setSoundMaxDistance(soundElement, maxInteract)
			end
		 end
	end
)--]]

addEvent("server:frozenChange", true)
addEventHandler("server:frozenChange", root, 
    function(ped, b)
	    setElementFrozen(ped, b)
        --setPedAnimation(ped, b, a, -1, false, false, false)
	end
)

addEvent("server:giveItem", true)
addEventHandler("server:giveItem", root, 
    function(ped, b,skin)
	    exports.bgo_items:giveItem(ped, b, skin)
        --setPedAnimation(ped, b, a, -1, false, false, false)
	end
)

local hunIds = {
	{97, 2000},
	{98, 3000},
	{99, 4000},
	{100, 6000},
	{101, 8000},
	{102, 10000},
}

function sellFishing(element)
	for key, value in ipairs(hunIds) do
		exports["bgo_items"]:deleteItemById(element, value[1], value[2])
	end
end
addEvent("sell:hunter", true)
addEventHandler("sell:hunter", root, sellFishing)