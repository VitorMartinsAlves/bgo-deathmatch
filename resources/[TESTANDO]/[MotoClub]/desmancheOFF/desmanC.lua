

addEventHandler("onClientResourceStart", resourceRoot, function()

tempCol = createColSphere (-110.77703857422, 1132.9365234375, 19.7421875, 3 )



end)





bindKey('h', 'down', function()
	if getElementData(localPlayer, "char:dutyfaction") == 23 or getElementData(localPlayer, "acc:id") == 1 then
			local detection = isElementWithinColShape ( localPlayer, tempCol )
				if detection then
					if not isTimer(tempo) then
					if not getElementData(localPlayer,"desmanchado") then
					local v = getPedOccupiedVehicle ( localPlayer )
					if v then
					tempo = setTimer(function() end,5000,1)
					setElementData(localPlayer, "desmanchando", true)
					triggerServerEvent ( "desmancharV", localPlayer, localPlayer )
					end
				end
			end
		end
	end
end
)


