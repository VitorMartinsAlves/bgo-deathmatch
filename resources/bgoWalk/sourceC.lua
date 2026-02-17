--[[addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), 
	function ()
		local stat = getPedStat (getLocalPlayer(), 22) -- sprint
	end
)
]]--

function onKey (button,press)
	if isCursorShowing () == false and isControlEnabled (button) == true then
		if press == "down" then
			local sprintKey = false
			for i,v in pairs(getBoundKeys ("sprint")) do
				if getKeyState (i) then
					sprintKey = true
					break
				end
			end
			if sprintKey == false then
				setPedControlState ("walk",true)
			end
		else
			local f = false
			local keys = {"forwards", "backwards", "left", "right"}
			for k,v in ipairs(keys) do
				local bound = getBoundKeys (v)
				for i,key in pairs(bound) do
					if getKeyState (i) then
						f = true
						break
					end
				end
			end
			if f == false then
				setPedControlState ("walk",false)
			end
		end
	end
end

addEventHandler ("onClientResourceStart",getResourceRootElement(),
function ()
	local keys = {"forwards", "backwards", "left", "right"}
	for k,v in ipairs(keys) do
		bindKey (v,"both",onKey)
	end
	
	bindKey ("walk","both",
	function ()
		setPedControlState ("walk", true)
	end)
	
	bindKey ("sprint","both",
	function (button,press)
		setPedControlState ("sprint", false)
		if isControlEnabled ("sprint") then
			setPedControlState ("walk", false)
		end

		if isControlEnabled ("sprint") then
			setPedControlState ("sprint", true)
		end

	end)
	
	bindKey ("sprint","up", function()
		sprintKey = false
		if not sprintKey then
			setPedControlState ("walk", true)
			setPedControlState ("sprint", false)
		end
	end)
end)