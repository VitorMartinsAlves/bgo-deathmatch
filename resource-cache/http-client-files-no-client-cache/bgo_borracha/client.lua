--[[
if fileExists("client.lua") then 
	fileDelete("client.lua")
end

if fileExists("client.luac") then 
	fileDelete("client.luac")
end


function loadTaser()

	engineImportTXD (engineLoadTXD("data/taser.txd"), 347)
	engineReplaceModel(engineLoadDFF("data/taser.dff", 347), 347)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), loadTaser)
--]]


addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), 
function (weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if weapon == 27 and getElementType(localPlayer)=="player" then 
		local px, py, pz = getElementPosition(localPlayer)
		local distance = getDistanceBetweenPoints3D(hitX, hitY, hitZ, px, py, pz)
		
		if (distance<10) then
			fxAddSparks(hitX, hitY, hitZ, 1, 1, 1, 1, 10, 0, 0, 0, true, 3, 1)
		end
		playSoundFrontEnd(38)
		triggerServerEvent("CombatFired", localPlayer, hitX, hitY, hitZ, hitElement) 
	end
end)

function showCombatEffect(x, y, z, player)
	fxAddSparks(x, y, z, 1, 1, 1, 1, 100, 0, 0, 0, true, 3, 2)
end
addEvent("showCombatEffect", true )
addEventHandler("showCombatEffect", getRootElement(), showCombatEffect)


function cancelCombatDamage(attacker, weapon, bodypart, loss)
	if (weapon == 27 or weapon == 50) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, cancelCombatDamage)
