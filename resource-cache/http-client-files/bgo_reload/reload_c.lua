local blockedTasks =
{
	"TASK_SIMPLE_IN_AIR", -- We're falling or in a jump.
	"TASK_SIMPLE_JUMP", -- We're beginning a jump
	"TASK_SIMPLE_LAND", -- We're landing from a jump
	"TASK_SIMPLE_GO_TO_POINT", -- In MTA, this is the player probably walking to a car to enter it
	"TASK_SIMPLE_NAMED_ANIM", -- We're performing a setPedAnimation
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE", -- Opening a car door
	"TASK_SIMPLE_CAR_GET_IN", -- Entering a car
	"TASK_SIMPLE_CLIMB", -- We're climbing or holding on to something
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD", -- When we try to jump but something hits us on the head
	"TASK_SIMPLE_FALL", -- We fell
	"TASK_SIMPLE_GET_UP" -- We're getting up from a fall
}

local function reloadWeapon()
   local theVehicle = getPedOccupiedVehicle ( localPlayer )
   if theVehicle then return end
	-- Usually, getting the simplest task is enough to suffice
	local task = getPedSimplestTask (localPlayer)

	-- Iterate through our list of blocked tasks
	for idx, badTask in ipairs(blockedTasks) do
		-- If the player is performing any unwanted tasks, do not fire an event to reload
		if (task == badTask) then
			return
		end
	end

	if ( not getPedAnimation( localPlayer ) ) then
triggerServerEvent("relWep", resourceRoot)
	end
	
	
end


controlTable = { "fire", "aim_weapon", "next_weapon", "previous_weapon", "forwards", "backwards", "left", "right", "zoom_in", "zoom_out",
 "change_camera", "jump", "sprint", "look_behind", "crouch", "action", "walk", "conversation_yes", "conversation_no",
 "group_control_forwards", "group_control_back", "enter_exit", "vehicle_fire", "vehicle_secondary_fire", "vehicle_left", "vehicle_right",
 "steer_forward", "steer_back", "accelerate", "brake_reverse", "radio_next", "radio_previous", "radio_user_track_skip", "horn", "sub_mission",
 "handbrake", "vehicle_look_left", "vehicle_look_right", "vehicle_look_behind", "vehicle_mouse_look", "special_control_left", "special_control_right",
 "special_control_down", "special_control_up" }
 
 
local function tirar()
block = false
end

block = false
addCommandHandler("Reload weapon", function()
   local theVehicle = getPedOccupiedVehicle ( localPlayer )
   if theVehicle then return end
   
local weaponType = getPedWeapon ( localPlayer )
if ( weaponType ) then
if not block then
block = true

	setTimer(tirar, 2000, 1)
	setTimer(reloadWeapon, 500, 1)
	end
end
end
)
bindKey("r", "down", "Reload weapon")



keyTable = {"mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b", "e", "f", "g", "h", "i", "j", "k",
 "l", "n", "o", "p", "q", "r", "t", "u", "v", "x", "y", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "num_enter", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "escape", "backspace", "tab", "lalt", "ralt", "enter", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=" }

addEventHandler("onClientKey", root, function(button, press) 
     if block then
	     for i,bindsK in ipairs(keyTable) do
             if (button == bindsK) then
                 cancelEvent() 
			 end
		 end
     end 
end) 
