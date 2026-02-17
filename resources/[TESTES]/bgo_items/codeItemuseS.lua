--local connection = exports.mysql:getConnection()
local szinez = "#88D373"
local r,g,b = 136,211,115

--[[

addEvent("checkCarKey",true)
addEventHandler("checkCarKey",getRootElement(),function(player,dbid,value)
	dbQuery(function(qh)
		local result = dbPoll(qh,0)
		if #result > 0 then
			outputChatBox(szinez.."[Inventorio]:#FFFFFF Não há ação para este item!",player,255,255,255,true)
		else
			outputChatBox(szinez.."[Inventorio]:#FFFFFF Eu não consegui encontrar um veículo assim, então eu deletei sua chave!",player,255,255,255,true)
			dbExec(connection,"DELETE FROM items WHERE id = ?",dbid)
			setTimer(function()
			exports["bgo_items"]:loadPlayerItems(player)end,500,1)
		end	
	end,connection,"SELECT * FROM vehicles WHERE id = ?",value)
end)
]]--
addEvent("fixCardUse",true)
addEventHandler("fixCardUse",getRootElement(),function(vehicle)
	fixVehicle(vehicle);
	setVehicleDamageProof(vehicle, false);
end)

addEvent("giveArmor",true)
addEventHandler("giveArmor",getRootElement(),function(player, amount)
	setPedArmor(player, amount)
end)

addEvent("addpp",true)
addEventHandler("addpp",getRootElement(),function(player)
	--dbExec(connection,"UPDATE accounts SET btcpp = ? WHERE id = ?",getElementData(player,"acc:pp"),getElementData(player,"acc:id"))
end)

addEvent("addgordura",true)
addEventHandler("addgordura",getRootElement(),function(player)
	local stat = getPedStat ( player, 21 )
	if ( stat <= 999 ) then
	local ran = math.random(50, 100)
	setPedStat(player, 21, getPedStat ( player, 21 ) + ran) 
	end
	if ( stat > 980 ) then
		outputChatBox ( getPlayerName ( source ) .. " Precisa perder um pouco de peso!!", player, 255,255,255, true )
	end
end)

addEvent("mask", true)
addEventHandler("mask", root,
	function(player, id)
		triggerClientEvent("addMask", player, id)
	end
)


addEvent("fixveh", true)
addEventHandler("fixveh", root,
	function()
		local theVehicle = getPedOccupiedVehicle ( source )
		if theVehicle then
		fixVehicle(theVehicle)
		end
	end
)




addEvent("bgo:energeticoON",true)
addEventHandler("bgo:energeticoON",root,
function(thePlayer)
local modo = getPedWalkingStyle(thePlayer)
setElementData(thePlayer,"modo:andar",modo )
setPedWalkingStyle(thePlayer, 0)
end)

addEvent("bgo:energeticoOFF",true)
addEventHandler("bgo:energeticoOFF",root,
function(thePlayer)
local modo = getElementData(thePlayer,"modo:andar") or 128
setPedWalkingStyle(thePlayer, modo)
end)






local atmBag = {}
local atmTimer = {}



addEvent("bgo:iniciarC4",true)
addEventHandler("bgo:iniciarC4",root,function(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		local dim = getElementDimension(thePlayer)
		local int = getElementInterior(thePlayer)
		atmBag [ thePlayer ] = createObject( 1654, x+0.3, y, z-0.9, -90, 0, 0)
		setElementDimension(atmBag [ thePlayer ], dim)
		setElementInterior(atmBag [ thePlayer ], int)
		triggerClientEvent(root, "setObjectUnbreakableMochila", root, atmBag[thePlayer] )
		exports.bgo_anims:setJobAnimation(thePlayer, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
		local x, y, z = getElementPosition( atmBag[thePlayer] )	
		atmTimer[thePlayer] = setTimer(explodir, 10000, 1, thePlayer)
		--local ms = getTimerDetails(atmTimer[thePlayer])
		triggerClientEvent(root, "plantarBomba", root, 10000, atmBag[thePlayer], dim, int)
		end
)


function explodir ( player )
		x, y, z = getElementPosition( atmBag[player] )
		ran = math.random(1, 10)
		if ran == 3 then
		createExplosion(x, y, z, 6)
		else
		createExplosion(x, y, z, 11)
		end
		
			destroyElement(atmBag[player])
			atmBag[player] = nil
			local tabela = getElementsWithinRange( x, y, z, 6, "object" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			if isElement(v) and tonumber(getElementData(v, 'bankID') or 0) > 0 then 
			local playerx, playery, playerz = getElementPosition(v)
			if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 6 then
			local hit = math.random(250, 700)
			local health = getElementData(v, 'atm >> Health') or 1000
			setElementData(v, 'atm >> Health', health - hit)
			end
		end
	end
end