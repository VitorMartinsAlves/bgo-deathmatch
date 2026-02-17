local clientStick = {}
local clientFlat = {}
local clientReceive = {}
local move = {}
local Secure = 0

function createStick()
	if not isPedInVehicle(localPlayer) then 
		if clientStick[localPlayer] then 
			if not clientReceive[localPlayer] then
				triggerServerEvent("createandattachStick", localPlayer, localPlayer)
				if clientFlat[localPlayer] then 
					triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
				end
				if (isTimer(receiveTimer)) then
					killTimer(receiveTimer)
				end
				if (isTimer(flatTimer)) then
					killTimer(flatTimer)
				end
			end
		else
			triggerServerEvent("createandattachStick", localPlayer, localPlayer)
		end
	else
		outputChatBox("#D75555[informação]: #ffffffVocê não pode pegar a vara de pescar no carro!", 255, 255, 255, true)
	end
end

function Synchronization(flat, stick, receive)
	if stick then 
		clientStick = stick
	end
	if flat then 
		clientFlat = flat
	end	
	if receive then 
		clientReceive = receive
	end
end
addEvent("char:synchronization", true)
addEventHandler("char:synchronization", root, Synchronization)

addEventHandler('onClientResourceStart', resourceRoot,
function()
	txd = engineLoadTXD( "files/stick.txd" )
	dff = engineLoadDFF( "files/stick.dff" )
 
	engineImportTXD( txd, 338 )
	engineReplaceModel( dff, 338 )
	setElementData(localPlayer, "fishing", false)
end
)

addEventHandler("onClientReosurceStop", resourceRoot, function ()
	triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
	triggerServerEvent("createandattachStick", localPlayer, localPlayer)
	setElementData(localPlayer, "fishing", false)
end)

local tempCol = createColSphere (1887.833, -1423.615, 7.608, 25 )
local spawns = {
{ 1888.921, -1424.689, 13.308 },
{ 1894.238, -1427.96, 13.108 },
{ 1883.117, -1432.593, 13.108 },
{ 1891.939, -1413.358, 13.108 },
{ 1897.859, -1421.781, 13.108 },
{ 1881.984, -1417.502, 13.108 }
} 


local tempCol2 = createColSphere (1947.596, -1425.34, 8.208, 25 )
local spawns2 = {
{ 1950.36, -1430.317, 12.808 },
{ 1956.105, -1422.977, 12.808 },
{ 1944.82, -1420.797, 12.808 },
{ 1940.782, -1429.505, 12.808 },
{ 1947.258, -1433.642, 12.808 },
{ 1948.467, -1424.204, 12.808 },
{ 1932.644, -1428.08, 12.808 },
{ 1958.924, -1426.667, 12.808 }

} 





local tempCol3 = createColSphere (1907.95, -1388.114, 8.708, 20 )
local spawns3 = {
{ 1904.557, -1382.175, 12.908 },
{ 1901.297, -1388.921, 12.908 },
{ 1908.895, -1393.744, 12.908 },
{ 1915.051, -1388.035, 12.908 },
{ 1912.111, -1378.9, 12.908 },
{ 1905.019, -1381.33, 12.908 },
{ 1908.544, -1386.844, 12.908 },
{ 1911.071, -1383.883, 12.908 },
{ 1902.557, -1395.488, 12.908 }

} 



local tempCol4 = createColSphere (1918.358, -1427.667, 9.208, 15 )
local spawns4 = {
{ 1925.539, -1430.094, 12.908 },
{ 1924.601, -1422.652, 12.908 },
{ 1907.604, -1431.383, 12.908 },
{ 1908.06, -1424.206, 12.908 },
{ 1912.772, -1425.115, 12.908 },
{ 1923.779, -1426.977, 12.908 },
{ 1918.779, -1423.77, 12.908 },
{ 1917.629, -1430.473, 12.908 },
{ 1913.818, -1425.457, 12.908 }

} 



addEventHandler("onClientClick", root, function(button, state, x, y, wordx, wordy, wordz, clickedElement)
	if button == "left" and state == "down" and getElementData(localPlayer, "fishing") then 
			if (clientFlat[localPlayer] and not clientReceive[localPlayer]) then
				triggerServerEvent("createandattachStick", localPlayer, localPlayer, false)
				triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
			if (isTimer(receiveTimer)) then
				killTimer(receiveTimer)
			end
			if (isTimer(flatTimer)) then
				killTimer(flatTimer)
			end
			clientFlat[localPlayer] = false
		elseif not (clientFlat[localPlayer]) and (getTickCount()-Secure>=2500) then 
		
				if isElementWithinColShape ( localPlayer, tempCol ) then
				local rnd = math.random( 1, #spawns )
				wordx, wordy, wordz = spawns[rnd][1], spawns[rnd][2], spawns[rnd][3] --getWorldFromScreenPosition ( x, y, 20)
			--if testLineAgainstWater(wordx, wordy, wordz, wordx, wordy, wordz+500) then
				--if isLineOfSightClear(wordx, wordy, wordz, wordx, wordy, wordz+500) then
					Secure = getTickCount()
					triggerServerEvent("createTranslator", localPlayer, localPlayer, wordx, wordy,wordz)
					local randomReceive = math.random(1,10)
					if (randomReceive>4) then
						randomTime = math.random(15, 60)
					else
						randomTime = math.random(60, 120)
					end
					receiveTimer = setTimer(ReceiveTime, randomTime*1000, 1)
							
				
				elseif isElementWithinColShape ( localPlayer, tempCol2 ) then
				local rnd2 = math.random( 1, #spawns2 )
				wordx, wordy, wordz = spawns2[rnd2][1], spawns2[rnd2][2], spawns2[rnd2][3] --getWorldFromScreenPosition ( x, y, 20)
			--if testLineAgainstWater(wordx, wordy, wordz, wordx, wordy, wordz+500) then
				--if isLineOfSightClear(wordx, wordy, wordz, wordx, wordy, wordz+500) then
					Secure = getTickCount()
					triggerServerEvent("createTranslator", localPlayer, localPlayer, wordx, wordy,wordz)
					local randomReceive = math.random(1,10)
					if (randomReceive>4) then
						randomTime = math.random(15, 60)
					else
						randomTime = math.random(60, 120)
					end
					receiveTimer = setTimer(ReceiveTime, randomTime*1000, 1)

			
				
				elseif isElementWithinColShape ( localPlayer, tempCol3 ) then
				local rnd3 = math.random( 1, #spawns3 )
				wordx, wordy, wordz = spawns3[rnd3][1], spawns3[rnd3][2], spawns3[rnd3][3] --getWorldFromScreenPosition ( x, y, 20)
			--if testLineAgainstWater(wordx, wordy, wordz, wordx, wordy, wordz+500) then
				--if isLineOfSightClear(wordx, wordy, wordz, wordx, wordy, wordz+500) then
					Secure = getTickCount()
					triggerServerEvent("createTranslator", localPlayer, localPlayer, wordx, wordy,wordz)
					local randomReceive = math.random(1,10)
					if (randomReceive>4) then
						randomTime = math.random(15, 60)
					else
						randomTime = math.random(60, 120)
					end
					receiveTimer = setTimer(ReceiveTime, randomTime*1000, 1)							
				
				elseif isElementWithinColShape ( localPlayer, tempCol4 ) then
				local rnd4 = math.random( 1, #spawns4 )
				wordx, wordy, wordz = spawns4[rnd4][1], spawns4[rnd4][2], spawns4[rnd4][3] --getWorldFromScreenPosition ( x, y, 20)
			--if testLineAgainstWater(wordx, wordy, wordz, wordx, wordy, wordz+500) then
				--if isLineOfSightClear(wordx, wordy, wordz, wordx, wordy, wordz+500) then
					Secure = getTickCount()
					triggerServerEvent("createTranslator", localPlayer, localPlayer, wordx, wordy,wordz)
					local randomReceive = math.random(1,10)
					if (randomReceive>4) then
						randomTime = math.random(15, 60)
					else
						randomTime = math.random(60, 120)
					end
					receiveTimer = setTimer(ReceiveTime, randomTime*1000, 1)
					else
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox(" ", 255, 255, 255, true)
					outputChatBox("#53bfcd[Pescaria]: #ffffffVocê só pode pescar no parque BGO ( Icone coração no F11)", 255, 255, 255, true)
				end				
				
			--end
		end
	end
end)


function scriptGetLevel () --when getlevel is called
    local x, y, z = getElementPosition ( localPlayer ) -- get his position
    local level = getWaterLevel ( x, y, z )
	  if level then
        level = z - level 
        outputChatBox( "You are " .. level .. " units away from the water!" )
	  else outputChatBox ( "There's no sign of water" )
	  end
end
addCommandHandler( "gl", scriptGetLevel )

function ReceiveTime()
	if clientFlat[localPlayer] then 
		setElementData(localPlayer, "receive", true)
		triggerServerEvent("setPlayerAbimation", localPlayer, localPlayer, true ,"SWORD", "sword_IDLE")
		local x, y, z = getElementPosition(localPlayer)
		local tx, ty, tz = getElementPosition(clientFlat[localPlayer])
		local rotation = findRotation(x,y,tx,ty)
		setElementRotation(localPlayer, 0, 0, rotation)
		exports.bgo_info:addNotification("5 segundos e um minigame começa use as setas do teclado!!" ,"success")
		outputChatBox("#D75555[informação]: #ffffff5 segundos e um minigame começa use as setas do teclado!", 255, 255, 255, true)
		setTimer(function()
			triggerEvent('bgoMTA->#startMinigame', localPlayer, true, 10, 35, "entMinigameFishing")
		end, 5000, 1)
		if not isElement(sound) then 
			sound = playSound("Reel.mp3", true)
		else
			stopSound(sound)
			sound = playSound("Reel.mp3", true)
		end
	end
end

function giveFishing(type)
	if not type then return end
	if type == 1 then -- Nem sikerült
		clientFlat[localPlayer] = nil
		triggerServerEvent("setPlayerAbimation", localPlayer, localPlayer, false, nil, nil)
		outputChatBox("#53bfcd[Pescaria]: #ffffffBem, isso não funcionou...", 255, 255, 255, true)
		triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
		
	else -- Sikerült
		clientFlat[localPlayer] = nil
		triggerServerEvent("setPlayerAbimation", localPlayer, localPlayer, false, nil, nil)
		triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
		triggerServerEvent("giveFishintToServer", localPlayer, localPlayer)
	end
	setElementData(localPlayer, "receive", false)
	if isElement(sound) then 
		stopSound(sound)
	end
end 

function renderLine()
	--for k,v in ipairs(getElementsByType("player")) do
		local v = localPlayer
		if (clientStick[v]) then
			local kx, ky, kz = getPositionFromElementOffset(clientStick[v], 0.15, 0.05, 0.25)
			local px, py, pz = getPositionFromElementOffset(clientStick[v], 0.27, 0.05, 1.95)
			--dxDrawLine3D(kx, ky, kz, px, py, pz, tocolor(255, 255, 255, 150), 1, false)
			if (clientFlat[v]) then
				local floatX, floatY, floatZ = getElementPosition(clientFlat[v])
				--if (v==getLocalPlayer()) then
					local playerX, playerY, playerZ = getElementPosition(v)
					local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, floatX, floatY, floatZ)
					if (distance<3) then
						triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
						if (isTimer(receiveTimer)) then
							killTimer(receiveTimer)
						end
						if (isTimer(flatTimer)) then
							killTimer(flatTimer)
						end
						clientFlat[v] = false
					elseif (distance>30) then
						if (isTimer(receiveTimer)) then
							killTimer(receiveTimer)
						end
						if (isTimer(flatTimer)) then
							killTimer(flatTimer)
						end
						clientFlat[v] = false
						triggerServerEvent("createTranslator", localPlayer, localPlayer, _, _)
					end
				--end
				dxDrawLine3D(px, py, pz, floatX, floatY, floatZ, tocolor(255, 255, 255, 150), 1, false)
			end
		--end
	end
end
addEventHandler("onClientRender", getRootElement(), renderLine)

addEvent('bgoMTA->#entMinigameFishing', true)
addEventHandler('bgoMTA->#entMinigameFishing', root, function (win)
	if win then 
		giveFishing(2)
	else
		giveFishing(1)
	end
end)

function flatMove()
	for k,v in ipairs(getElementsByType("player")) do
		if (clientFlat[v]) then
			if not (move[v]) then
				move[v] = "-"
			end
			if (clientReceive[v]) then
				count = 0.03
			else
				count = 0.007
			end
			local x, y, z = getElementPosition(clientFlat[v])
			if (move[v]=="-") then
				z = z-count
			elseif (move[v]=="+") then
				z = z+count
			end
			if (z>=0) then
				move[v] = "-"
			elseif (clientReceive[v] and z<=-0.20) or (not clientReceive[v] and z<=-0.05) then
				move[v] = "+"
			end
			setElementPosition(clientFlat[v], x, y, z)
		end
	end
end
setTimer(flatMove, 110, 0)

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function getPositionFromElementOffset(element,offX,offY,offZ)
	if element then 
		local m = getElementMatrix(element)
		local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
		local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
		local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
		return x, y, z
	end
end

addEventHandler("onClientColShapeHit", getRootElement(),
	function(player)
		if player ~= getLocalPlayer() then return end
		if source and getElementData(source, "sell:fishing") then 
			getPlayerItem()
		end
	end
)

function getPlayerItem()
	triggerServerEvent("sell:Fishing", localPlayer, localPlayer)
end
