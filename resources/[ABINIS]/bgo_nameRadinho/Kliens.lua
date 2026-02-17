--BGOMTA 2017

if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end
if fileExists("Kliens.luac") then
	fileDelete("Kliens.luac")
end

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)


addEventHandler("onClientRender", root, function()
if not getElementData(localPlayer, "loggedin") then return end
	--if getElementData(localPlayer, "acc:id") == 1 then
	--if tonumber(getElementData(localPlayer, "acc:admin") or 0) >= 1 then
		local theTeam = getPlayerTeam(localPlayer)
			if ( theTeam ) then
						local value = getElementData(localPlayer,"char:adminduty")
						if value == 1 then
						dxDrawText("#ff9100Radinho Staff ", sx*0, sy*260, sx*1359, sy*90, tocolor(255,255,255,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
						local players = getPlayersInTeam ( theTeam )
						local playerValue = nil
						for playerKey = 1, #players do
						playerValue = players[playerKey]
						if getElementData(playerValue, "inCall") then
						dxDrawText("● "..getPlayerName(playerValue).."", sx*0, sy*260+playerKey*22, sx*1359, sy*90, tocolor(255,0,0,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
						else
						dxDrawText("● "..getPlayerName(playerValue).."", sx*0, sy*260+playerKey*22, sx*1359, sy*90, tocolor(255,255,255,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
						end
						end
						else
						if exports.bgo_admin:isPlayerDuty(localPlayer) then
						dxDrawText("#ff9100Radinho "..getTeamName(theTeam).." ", sx*0, sy*260, sx*1359, sy*90, tocolor(255,255,255,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
						else
						dxDrawText("#ff9100Radinho:", sx*0, sy*260, sx*1359, sy*90, tocolor(255,255,255,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
						end
						local players = getPlayersInTeam ( theTeam )
						local playerValue = nil
						for playerKey = 1, #players do
						playerValue = players[playerKey]
						
						if getElementData(playerValue, "inCall") then
						if getElementData(playerValue, "acc:admin") < 1 then
						playerKey = 1
						dxDrawText("● "..getPlayerName(playerValue).."", sx*0, sy*260+playerKey*22, sx*1359, sy*90, tocolor(255,0,0,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
						end
						else
						if getElementData(playerValue, "acc:admin") < 1 then
						if playerKey < 20 then
							if not exports.bgo_admin:isPlayerDuty(localPlayer) then
						dxDrawText("● "..getPlayerName(playerValue).."", sx*0, sy*275+playerKey*22, sx*1359, sy*90, tocolor(255,255,255,255), sy/1.3, "default-bold", "right", "top", false, false, false, true)
							--end
						end
						end
					end
				end
			end
		end
	end
end
)



