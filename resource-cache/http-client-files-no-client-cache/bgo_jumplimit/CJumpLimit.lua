local MAX_JUMP_LENGTH = 0.12
local JUMP_TIMER

function ParseJump()
    local move_state = getPedMoveState( localPlayer )

    if move_state ~= "jump" then return end
	
	if getElementData(localPlayer, "char:energetico") then return end
	
    local side_vector = Vector2( localPlayer.velocity.x, localPlayer.velocity.y )
    if side_vector:getLength() > MAX_JUMP_LENGTH then
        side_vector = side_vector:getNormalized() * MAX_JUMP_LENGTH
        localPlayer.velocity = Vector3( side_vector.x, side_vector.y, localPlayer.velocity.z )
    end
end

function StartJumpCheck()
	if getElementData(localPlayer, "char:energetico") then return end
    if isTimer( JUMP_TIMER ) then killTimer( JUMP_TIMER ) end
    JUMP_TIMER = setTimer( ParseJump, 50, 10 )
end

function antibug()
local bound_keys = getBoundKeys("jump")
if bound_keys then
	for k, v in pairs( bound_keys ) do
		unbindKey( k, "down", StartJumpCheck )
		bindKey( k, "down", StartJumpCheck )
	end
end
end
setTimer( antibug, 500, 0 )