--[[
addCommandHandler("push",
function(thePlayer)
		local pX,pY,pZ = getElementPosition(thePlayer)
		for k,v in ipairs(getElementsByType("vehicle")) do
			vX,vY,vZ = getElementPosition(v)
			local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
			if dist <= 3 then

									x,y,z=getElementVelocity(v) 
	  
				                   setElementVelocity ( v, x+0.009, y, z) 
		end
	end
end)
]]--
