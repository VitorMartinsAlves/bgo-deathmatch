local streamedOut = {}
local tem = false
--[[
function teste()
if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
bgoadmin = true --exports.bgo_admin:AntiComandTempo(player) --or (getElementData(localPlayer,"acc:id") == 1)
else	
bgoadmin = false
end
end
setTimer(teste, 200, 0)	
]]--


function voiceradio()

if getResourceFromName( "bgo_admin" ) and getResourceState ( getResourceFromName( "bgo_admin" ) ) == "running" then
bgoadmin = true --exports.bgo_admin:AntiComandTempo(player) --or (getElementData(localPlayer,"acc:id") == 1)
else	
bgoadmin = false
end

		if not bgoadmin then return end
					local x, y, z = getElementPosition ( localPlayer )
					local players = getElementsByType("player")
					local v = nil
					for i = 1, #players do
					v = players[i] 
					if v ~= localPlayer then
					if getElementData(v, "inCall") then
						
						if exports.bgo_admin:isPlayerDuty(localPlayer) then
		
						local x, y, z = getElementPosition ( localPlayer )
						local veiculo = getElementsWithinRange(x, y, z, 100, "vehicle")
						local veh = nil
						for i = 1, #veiculo do
						veh = veiculo[i]


					
						local id = getElementModel ( veh )
						if id == 597 
						or id == 439
						or id == 479
						or id == 470
						or id == 596
						or id == 598
						or id == 585
						or id == 497
						or id == 426
						or id == 523
						or id == 445
						or id == 597
						or id == 546
						or id == 466 then
						--if getElementDimension(veh) == 0 then
						local theVehicle = getPedOccupiedVehicle ( localPlayer )
						if theVehicle then
						setSoundVolume(v, 3)
						setSoundPan(v, 0)
						else
						local vecSoundPos = veh.position
						local vecCamPos = Camera.position
						local fDistance = (vecSoundPos - vecCamPos).length
						local fMaxVol = 1.5
						local fMinDistance = 1
						local fMaxDistance = 40
						local fPanSharpness = 1.0
						if (fMinDistance ~= fMinDistance * 2) then
							fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / ((fMinDistance * 2) - fMinDistance)))
						end
						local fPanLimit = (0.65 * fPanSharpness + 0.35)
						local vecLook = Camera.matrix.forward.normalized
						local vecSound = (vecSoundPos - vecCamPos).normalized
						local cross = vecLook:cross(vecSound)
						local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))
						local fDistDiff = fMaxDistance - fMinDistance;
						local fVolume
						if (fDistance <= fMinDistance) then
						fVolume = fMaxVol
						elseif (fDistance >= fMaxDistance) then
						fVolume = 0.0
						else
						fVolume = math.exp(-(fDistance - fMinDistance) * (5.0 / fDistDiff)) * fMaxVol
						end
						setSoundPan(v, fPan)
						setSoundVolume(v, fVolume)
						end
						--end
						end
						end
						else
						setSoundVolume(v, 5)
						setSoundPan(v, 0)
						end
						
						
						--setSoundVolume(v, 5)
						--setSoundPan(v, 0)
						else
						setSoundVolume(v, 0)
						setSoundPan(v, 0)
					end
			end
	end
end
setTimer(voiceradio,500,0)
						


function voice()
			if getElementData(localPlayer, "loggedin") then			
						
					if getElementData(localPlayer, "DistanciaPlayer") == true then 
					local players = getElementsByType("player")
					local v = nil
					for i = 1, #players do
					v = players[i] 
					if isElement(v) then
					if v ~= localPlayer then
					tem = true
					local x, y, z = getElementPosition ( localPlayer )
					local x1, y1, z1 = getElementPosition ( v )
					distance = getDistanceBetweenPoints3D (x1, y1, z1,  x, y, z )
					local dis = localPlayer:getData("distanciaVozP") or 20
					if distance < tonumber(dis) then
					setSoundVolume(v, 5)
					setSoundPan(v, 0)
					else
					setSoundVolume(v, 0)
					setSoundPan(v, 0)
					end
					end
					end
					end
					
					else	
					--[[
					local x, y, z = getElementPosition ( localPlayer )
					local players = getElementsByType("player")
					local v = nil
					for i = 1, #players do
					v = players[i] 

					if getElementData(v, "inCall") then
						setSoundVolume(v, 6)
						setSoundPan(v, 0)
						else
						setSoundVolume(v, 0)
						setSoundPan(v, 0)
						end
					
					end
					]]--
					
						--if getElementData(v, "inCall") then 
						--setSoundVolume(v, 6)
						--setSoundPan(v, 0)
						--else
						local x, y, z = getElementPosition ( localPlayer )
						local players = getElementsWithinRange(x, y, z, 30, "player")
						local v = nil
						for i = 1, #players do
						v = players[i]
						if v ~= localPlayer then
						if getElementData(v, "inCall") == false then 
						local x, y, z = getElementPosition ( localPlayer )
						local x1, y1, z1 = getElementPosition ( v )
						distance = getDistanceBetweenPoints3D ( x1, y1, z1, x, y, z )
						if distance < 20 then
						
						if ( isPedDead ( v ) ) then 
						setSoundVolume(v, 0)
						else	

						
						if tem then 
						setSoundVolume(v, 0)
						setSoundPan(v, 0)
						tem = false
						end
					
						

						
						local vecSoundPos = v.position
						local vecCamPos = Camera.position
						local fDistance = (vecSoundPos - vecCamPos).length
						local fMaxVol = v:getData("maxVol") or 10
						local fMinDistance = v:getData("minDist") or 1
						local fMaxDistance = v:getData("maxDist") or 20
						local fPanSharpness = 1.0
						if (fMinDistance ~= fMinDistance * 2) then
							fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / ((fMinDistance * 2) - fMinDistance)))
						end
						local fPanLimit = (0.65 * fPanSharpness + 0.35)
						local vecLook = Camera.matrix.forward.normalized
						local vecSound = (vecSoundPos - vecCamPos).normalized
						local cross = vecLook:cross(vecSound)
						local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))
						local fDistDiff = fMaxDistance - fMinDistance;
						local fVolume
						if (fDistance <= fMinDistance) then
						fVolume = fMaxVol
						elseif (fDistance >= fMaxDistance) then
						fVolume = 0.0
						else
						fVolume = math.exp(-(fDistance - fMinDistance) * (5.0 / fDistDiff)) * fMaxVol
						end
						setSoundPan(v, fPan)
						setSoundVolume(v, fVolume)
						end
						else
						setSoundVolume(v, 0)
						setSoundPan(v, 0)
						end
					end
				end
			end
		end
	end
	end
addEventHandler("onClientPreRender", root,voice)

		
			
function voice2()
	if getElementData(localPlayer, "loggedin") then	
		if getElementData(localPlayer, "inCall") == false then 
			local x, y, z = getElementPosition ( localPlayer )
			
		local players = getElementsWithinRange(x, y, z, 30, "player")
		local jogadores = nil
		local temsim = false
		for i = 1, #players do
			jogadores = players[i]
		if jogadores ~= localPlayer then
			if not temsim then
			temsim = true
			end
		end
		end
		if temsim then
		triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, localPlayer, getElementsByType("player", root, true))  
		temsim = false
		--print("Voice Colocado para pessoas ")
		end
		end
	end
end
setTimer(voice2,1000,0)


--[[
addEventHandler("onClientElementStreamIn", root,
    function ()
        if source:getType() == "player" then
			if getElementData(localPlayer, "loggedin") then	
		if not getElementData(localPlayer, "inCall") then 
            triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))  
        end	
		end
		end
    end
)


addEventHandler("onClientElementStreamOut", root,
    function ()
        if source:getType() == "player" then	
	if getElementData(localPlayer, "loggedin") then			
		if not getElementData(localPlayer, "inCall") then 
           triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
           setSoundPan(source, 0)
           setSoundVolume(source, 0)
		  end
		  end
        end
		
    end
)


]]--


addEventHandler("onClientResourceStart", resourceRoot,
    function ()
        triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, localPlayer, getElementsByType("player", root, true)) -- request server to start broadcasting voice data once the resource is loaded (to prevent receiving voice data while this script is still downloading)
    end
, false)

