-- ID rendszer


local charID = {}

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
	function()
		local players = getElementsByType("player")
		for key, value in ipairs(players) do
			local id = getElementData(value, "acc:id")
			setElementData(value, "playerid", id)
		end
	end
)

function onPlayerNameChange()
	cancelEvent()
end
addEventHandler("onPlayerChangeNick", getRootElement(), onPlayerNameChange)

cmdList = { 
    ["nick"]=true
} 
  
-- Disable unwanted commands 
addEventHandler("onPlayerCommand", root, 
function(cmdName) 
     if cmdList[cmdName] then 
          cancelEvent() 
     end 
end)

local policia = createTeam("Policia", 255, 255, 255)
local mecanico = createTeam("Mecanico", 255, 255, 255)
local samu = createTeam("Samu", 255, 255, 255)
local drvv = createTeam("DRVV", 255, 255, 255)
local taxi = createTeam("TAXI", 255, 255, 255)

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),function()
setGameType("100% RolePlay")
setMapName("RolePlay")
setFPSLimit(59)
end)


function getFreeVehicleSlot(jatekos)
	if isElement(jatekos) then
		maxSlot = getElementData(jatekos,"maxvehicles") or 4
		usedSlot = getElementData(jatekos,"hasznaltkocsislot") or 0
		calcFreeSlot = maxSlot-usedSlot
		if calcFreeSlot ~= 0 then
			return true,calcFreeSlot,maxSlot,usedSlot
		else
			return false,calcFreeSlot,maxSlot,usedSlot
		end
	end
end



function resourceStart()
    local realtime = getRealTime()

    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)
end
--addEventHandler("onResourceStart", getResourceRootElement(), resourceStart)