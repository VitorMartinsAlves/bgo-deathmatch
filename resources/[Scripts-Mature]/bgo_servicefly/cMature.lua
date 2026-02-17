addEvent ( "FLY>CarColision>true", true )
addEventHandler ( "FLY>CarColision>true", root, function ( veh ) 
     for index,vehicle in ipairs(getElementsByType("vehicle")) do
	     setElementCollidableWith ( vehicle, veh, true )
	     setElementCollidableWith ( localPlayer, veh, true )
	 end
end )


addEvent ( "FLY>CarColision>false", true )
addEventHandler ( "FLY>CarColision>false", root, function ( veh ) 
     for index,vehicle in ipairs(getElementsByType("vehicle")) do
	     setElementCollidableWith ( vehicle, veh, false )
	     setElementCollidableWith ( localPlayer, veh, false )
	 end
end )

addEvent ( "destroyMarker", true )
addEventHandler ( "destroyMarker", root, function ( veh ) 
     if isElement(marker) then
         destroyElement(marker)
		 x,y,z = getElementPosition(localPlayer)
		 triggerServerEvent("setaInfor", root, localPlayer, x,y,z)
		 pos = 0
	 end
end )

ped = createPed(61, 1717.38, 1617.008, 10.117)
setElementRotation(ped, 0, 0, 176)
setElementFrozen(ped, true)

addEventHandler ( "onClientPedDamage", ped,
function ( attacker )
	cancelEvent()
end)

local timers = {}

addEventHandler ( "onClientClick", root,
function ( button, state, _, _, _, _, _, clickPED)
     if button == "left" and state == "down" then
	     if ( clickPED ) then
			 if ( getElementType ( clickPED ) == "ped" ) then

				if isTimer(timers[localPlayer]) then return end
				timers[localPlayer] = setTimer(function() end, 2000, 1) 

			     if clickPED == ped then
	     	         local cx, cy, cz = getElementPosition ( clickPED )
	     	         local px, py, pz = getElementPosition ( localPlayer )
	     	         local distance	= getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz )
	                 if ( distance <= 5 ) then
			             triggerServerEvent("startService", localPlayer, localPlayer)
		             end
	             end
             end
         end
     end
end)

markerPos = {
     {1, 1477.8692626953,1509.8270263672,11.871885299683},
	 {2, 1475.9174804688,1164.8516845703,47.871887207031},
	 {3, 1221.572265625,743.86499023438,118.87188720703},
	 {4, 579.45104980469,618.71752929688,250.87188720703},
	 {5, 33.747257232666,73.657104492188,302.87188720703},
	 {6, -41.774154663086,-738.50634765625,322.87188720703},
	 {7, -156.49230957031,-1731.3218994141,322.87188720703},
	 {8, 164.69729614258,-2412.5688476563,322.87188720703},
	 {9, 1065.3348388672,-2579.0202636719,258.87188720703},

	 {10, 1692.8483886719,-2593.5510253906,14.371892929077}, 
	 {11, 1956.7512207031,-2430.1149902344,13.771911621094},
	 {12, 1868.8688964844,-2493.7883300781,13.771911621094},
	 {13, 1692.6340332031,-2493.6135253906,14.45468711853},
	 {14, 1242.8499755859,-2490.4372558594,74.454689025879},
	 {15, 444.32611083984,-2445.6674804688,183.45468139648},
	 {16, -309.98104858398,-1795.8082275391,333.45468139648},
	 {17, -378.81777954102,-1052.6641845703,386.45468139648},
	 {18, -32.549709320068,101.52205657959,426.45468139648},
	 {19, 156.52890014648,1064.6190185547,426.45468139648},
	 {20, 157.89105224609,2374.7841796875,426.45468139648},
	 {21, 517.04339599609,3087.1428222656,426.45468139648},
	 {22, 1176.0520019531,2953.5700683594,426.45468139648},
	 {23, 1462.4216308594,2408.3461914063,426.45468139648},
	 {24, 1477.2026367188,1671.2668457031,41.454681396484},
	 {25, 1477.7108154297,1458.9775390625,14.454681396484},
	 {26, 1427.548828125,1261.3549804688,11.454679489136},
	 {27, 1326.8509521484,1338.6372070313,11.454679489136},
}	 

pos = 0

function startMaker (hitPlayer)
if hitPlayer == getLocalPlayer() then
     local theVehicle = getPedOccupiedVehicle ( hitPlayer )
	 if not theVehicle then triggerEvent("destroyMarker", root, hitPlayer) return end
     if isElement(marker) then
	     destroyElement(marker)
	 end
	 pos = pos + 1
	 x,y,z = getElementPosition(hitPlayer)
	     for i,v in pairs(markerPos) do
		     if (pos == v[1]) then
     	         marker = createMarker(v[2], v[3], v[4], "corona", 13, 255, 0, 0, 255)
				 outputChatBox(""..(exports.bgo_color:getColorClient() or "#FFFFFF").."[BGO FLY] #FFFFFFPontos aereos recolhidos "..v[1]..""..(exports.bgo_color:getColorClient() or "#FFFFFF").."/28", 255,255,255, true)	
				 triggerServerEvent("setaInfor", root, hitPlayer, v[2], v[3], v[4])
    			 addEventHandler("onClientMarkerHit", marker, startMaker)
				 if v[1] == 10 then
				     outputChatBox(""..(exports.bgo_color:getColorClient() or "#FFFFFF").."[BGO FLY] #FFFFFFAtenção piloto, preparece para pousar", 255,255,255, true)	
				 end
				 if v[1] == 12 then
				     triggerServerEvent("loadFly", hitPlayer, hitPlayer)	
				 end
				 if v[1] == 27 then
				     triggerServerEvent("loadFly2", hitPlayer, hitPlayer)	
					 triggerServerEvent("setaInfor", root, hitPlayer, x,y,z)
                     if isElement(marker) then
	                     destroyElement(marker)
						 pos = 0
	                 end
				 end
			 end
		 end
	 end
end
addEvent ( "FLY>Start", true )
addEventHandler ( "FLY>Start", root, startMaker)
--[[
addCommandHandler("enter",
function ()
     startMaker () 
end)
--]]