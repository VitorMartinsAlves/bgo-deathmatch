local weaponID = {
	36,
	38,
	39,
	40,
	43,
	44,
	46,
	47,
	48,
	49,
	50,
	51,
	52,
	53,
	113,
	114,
	115,
	116,
	117,
	118,
	119,
	120,
	121,
	122,
	123,
	124,
	125,
	126,
	127,
	128,
	129,
	130,
	131,
	132,
	133,
	134,
	135,
}


function vanilyenFegyvere()
	for index, value in ipairs(weaponID) do
		if exports["bgo_items"]:hasItem(localPlayer, value) then
			return true
		end
	end
	return false
end


function onc()
	local x,y,z = getElementPosition(localPlayer)
	 local location = getZoneName ( x, y, z )
	--outputChatBox(location)
end
--addEventHandler("onClientRender",getRootElement(),onc)

function onClientColShapeHit( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
		if not isPedInVehicle(theElement) then
			if source:getData("isDetector") then
				if exports.bgo_admin:isPlayerDuty(localPlayer) or tonumber(getElementData(localPlayer, "acc:admin") or 0) > 1 then
				else
					vane,nev = vanilyenFegyvere()
					if vane then
						local x,y,z = getElementPosition(localPlayer)
						local location = getZoneName ( x, y, z )
						triggerServerEvent("setPos",localPlayer, localPlayer, source:getData("isDetectorID"))					
						outputChatBox("#d24d57[Erro]:#FFFFFF O detector de metais encontrou algo ilegal com você!",255,255,255,true)
					else
						-- outputChatBox("#d24d57[Erro]:#FFFFFF O detector de metais encontrou algo ilegal com você!",255,255,255,true)
					end
				end
			end				
		end	
	end
end
addEventHandler("onClientColShapeHit",getRootElement(),onClientColShapeHit)

function playSounds(x,y,z)
	if isElement(sounds) then
		destroyElement(sounds)
	end
	sounds = playSound3D("detect.mp3",x,y,z,true)
	setSoundVolume(sounds,0.5)
	setSoundMaxDistance(sounds,30)
	
	setTimer(function()
		if isElement(sounds) then
			destroyElement(sounds)
		end
		end,10000,1)
	--end,1*60*1000,1)
end
addEvent("playSoundsMetal",true)
addEventHandler("playSoundsMetal",getRootElement(),playSounds)