
addEventHandler("onClientRender", root, function()

	if not getElementData(localPlayer, "loggedin") then return end

	if(getTickCount() - (lastLocalHeadUpdate or 0) > 100) then
		local task = getElementData(localPlayer,"TASK")
		if(not task or task == "") then
			local x, y, z, lx, ly, lz = getCameraMatrix()
			local px, py, pz = getPedBonePosition(localPlayer, 4)
			local lookAtX = px - (x-lx) * 20.0
			local lookAtY = py - (y-ly) * 20.0
			local lookAtZ = pz - (z-lz) * 20.0
			setPedLookAt(localPlayer, lookAtX, lookAtY, lookAtZ, 3000)
			lastLocalHeadUpdate = getTickCount()
		end
	end

		if(getTickCount() - (lastRemoteHeadUpdate or 0) > 250) then
			-- Update LookAt
			local x, y, z, lx, ly, lz = getCameraMatrix()
			
			local lookAtOffsetX = math.ceil((x-lx)*20.0)
			local lookAtOffsetY = math.ceil((y-ly)*20.0)
			local lookAtOffsetZ = math.ceil((z-lz)*20.0)
			
			setElementData(localPlayer, "lookAtOffsetX", lookAtOffsetX)
			setElementData(localPlayer, "lookAtOffsetY", lookAtOffsetY)
			setElementData(localPlayer, "lookAtOffsetZ", lookAtOffsetZ)


			local streamInPlayers = getElementsByType("player", root, true)
			for k, v in pairs(streamInPlayers) do
				if not getElementData(v, "loggedin") then return end
				if isElement(v) and v ~= getLocalPlayer() then
					local px, py, pz = getPedBonePosition(v, 4)
					local lookAtX = px - (getElementData(v, "lookAtOffsetX") or 0)
					local lookAtY = py - (getElementData(v, "lookAtOffsetY") or 0)
					local lookAtZ = pz - (getElementData(v, "lookAtOffsetZ") or 0)
					setPedAimTarget(v, lookAtX, lookAtY, lookAtZ)
					setPedLookAt(v, lookAtX, lookAtY, lookAtZ, 3000)
				end
			end
			lastRemoteHeadUpdate = getTickCount()
	end
end
)