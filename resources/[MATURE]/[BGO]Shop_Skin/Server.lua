--[[
local binco1 = createPickup(2244.426, -1665.161, 15.477, 3, 1275, 1)
local binco2 = createPickup(479.576, -1538.432, 19.387, 3, 1275, 1)
local binco3 = createPickup(1457.609, -1138.833, 24.03, 3, 1275, 1)

createBlipAttachedTo ( binco1, 45 )
createBlipAttachedTo ( binco2, 45 )
createBlipAttachedTo ( binco3, 45 )

local exitT1 = createPickup(207.659, -110.713, 1005.133, 3, 1318, 1)
local exitT2 = createPickup(204.353, -168.358, 1000.523, 3, 1318, 1)
local exitT3 = createPickup(227.034, -8.164, 1002.211, 3, 1318, 1)


setElementInterior(exitT1, 15)
setElementInterior(exitT2, 14)
setElementInterior(exitT3, 5)

setElementDimension(exitT1, 1)
setElementDimension(exitT2, 2)
setElementDimension(exitT3, 3)

function bincoL1 (source)
fadeCamera(source, false, 1, 0, 0, 0)
setTimer(fadeCamera, 1000, 1, source, true, 1)
setTimer(setElementPosition, 1000, 1, source, 207.737991,-109.019996,1005.132812)
setTimer(setElementInterior, 1000, 1, source, 15, 207.737991,-109.019996,1005.132812)
setTimer(setElementDimension, 1000, 1, source, 1)
end
addEventHandler("onPickupHit", binco1, bincoL1)

function bincoL3 (source)
fadeCamera(source, false, 1, 0, 0, 0)
setTimer(fadeCamera, 1000, 1, source, true, 1)
setTimer(setElementPosition, 1000, 1, source, 226.293991,-7.431529,1002.210937)
setTimer(setElementInterior, 1000, 1, source, 5, 226.293991,-7.431529,1002.210937)
setTimer(setElementDimension, 1000, 1, source, 3)
end
addEventHandler("onPickupHit", binco3, bincoL3)

function bincoL2 (source)
fadeCamera(source, false, 1, 0, 0, 0)
setTimer(fadeCamera, 1000, 1, source, true, 1)
setTimer(setElementPosition, 1000, 1, source, 204.332992,-166.694992,1000.523437)
setTimer(setElementInterior, 1000, 1, source, 14, 204.332992,-166.694992,1000.523437)
setTimer(setElementDimension, 1000, 1, source, 2)
end
addEventHandler("onPickupHit", binco2, bincoL2)

function exitLJ (thePlayer)
local dim = getElementDimension(thePlayer)
  if (dim == 1) then
  setElementDimension(thePlayer, 0)
  setElementInterior(thePlayer, 0)
  setElementPosition(thePlayer, 2244.95, -1662.479, 15.469)
  else
     if (dim == 2) then
      setElementDimension(thePlayer, 0)
      setElementInterior(thePlayer, 0)
      setElementPosition(thePlayer, 490.617, -1540.724, 18.685)
     else
         if (dim == 3) then
           setElementDimension(thePlayer, 0)
           setElementInterior(thePlayer, 0)
           setElementPosition(thePlayer, 1454.978, -1144.331, 24.057)
         end
     end
   end
end
addEventHandler("onPickupHit", exitT1, exitLJ)
addEventHandler("onPickupHit", exitT2, exitLJ)
addEventHandler("onPickupHit", exitT3, exitLJ)
--]]

db = dbConnect("sqlite", "data.db")

addEventHandler("onResourceStart", resourceRoot,
function ()
   outputDebugString("Sistema Inicado! (Achievements)")
   dbExec(db, "CREATE TABLE IF NOT EXISTS SKIN_SHOP ( LOGIN TEXT, ID_1 TEXT, ID_2 TEXT, ID_3 TEXT, ID_4 TEXT, ID_5 TEXT, ID_6 TEXT, ID_7 TEXT, ID_8 TEXT, ID_9 TEXT, ID_10 TEXT, ID_11 TEXT, ID_12 TEXT, ID_13 TEXT, ID_14 TEXT, ID_15 TEXT, ID_16 TEXT, ID_17 TEXT, ID_18 TEXT, ID_19 TEXT, ID_20 TEXT)")  
end
)

addEventHandler("onResourceStart", resourceRoot,
	function()
			if (db) then
				outputDebugString("* Database connected.")
			else
				outputDebugString("* Failed to connect to database")
			end
	end
)

function getSQLConnection()
	if (db) then
		return db
	end
end

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

local connection = exports["bgo_mysql"]:getConnection()

addEvent("SaveSQL", true)
addEventHandler("SaveSQL", root,
function (thePlayer, ID, Money, Skins)
     local getLoginAcc = getAccountName(getPlayerAccount(thePlayer))
	 
	 	local money2 = getElementData(thePlayer, "char:money")
    if money2 >= Money then
	--[[
	local accId = getElementData(thePlayer, "acc:id")
	local spawnQuery = dbPoll(dbQuery(connection, "SELECT * FROM characters WHERE id = ?", accId), -1)
	if (#spawnQuery > 0) then
	for _, cRow in ipairs(spawnQuery) do
	genero = cRow["gender"]
	
	if genero == "no" then 
	
	
	
	setElementData(thePlayer, "char:money", money2 - Money)
     saveSK(getLoginAcc, ID)
	 setElementData(thePlayer, "SK"..ID, true)
	 setElementModel(thePlayer, Skins)
	 else
	triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"Feminina", "Roupas disponivel apenas para mulher!  ( se caso você for mulher e não conseguir comprar informe a algum administrador o problema! )", 15 )
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox(" ", thePlayer, 255, 255, 255, true)
	 outputChatBox("Roupas disponivel apenas para mulher!  ( se caso você for mulher e não conseguir comprar informe a algum administrador o problema!)", thePlayer, 255, 255, 255, true)

	 end
	 
	 
	 end
	 end
	 ]]--
	 
	 	
		local genero = getElementData(thePlayer, "char:genero")
		if genero == "mulher" then 
		setElementData(thePlayer, "char:money", money2 - Money)
		saveSK(getLoginAcc, ID)
		setElementData(thePlayer, "SK"..ID, true)
		setElementModel(thePlayer, Skins)
		else
		triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"Feminina", "Roupas disponivel apenas para mulher!  ( se caso você for mulher e não conseguir comprar informe a algum administrador o problema! )", 15 )
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox(" ", thePlayer, 255, 255, 255, true)
		outputChatBox("Roupas disponivel apenas para mulher!  ( se caso você for mulher e não conseguir comprar informe a algum administrador o problema!)", thePlayer, 255, 255, 255, true)
		end
		
		
		
	 
	 end
	 
	 
end)


addEvent("skinsetloja", true)
addEventHandler("skinsetloja", root,
function (thePlayer, ID)
	setElementModel(thePlayer, ID)
end)

function saveSK (LOGIN, ID)
    local qh = dbQuery(db, "SELECT * FROM SKIN_SHOP WHERE LOGIN=?", LOGIN)
	local result = dbPoll(qh, -1)
	if (#result == 0) then
		dbFree(dbQuery(db, "INSERT INTO SKIN_SHOP ( LOGIN, ID_"..ID..") VALUES ( '"..LOGIN.."', '"..ID.."')"))
	else
	    dbExec(db, "UPDATE SKIN_SHOP SET ID_"..ID.."=? WHERE LOGIN=?", ID, LOGIN)
	end
end

addEventHandler("onPlayerLogin", root,
function ()
local LOGIN = getAccountName(getPlayerAccount(source))
local qh = dbQuery(db, "SELECT * FROM SKIN_SHOP WHERE LOGIN=?", LOGIN)
	local result = dbPoll(qh, -1)
    if (#result ~= 0) then
	if (result[1]["ID_1"]) then
	  setElementData(source, "SK1", "1")
	  else
	end
	if (result[1]["ID_2"]) then
	  setElementData(source, "SK2", "2")
      else
	end
	if (result[1]["ID_3"]) then
	  setElementData(source, "SK3", "3")
	  else
	end
	if (result[1]["ID_4"]) then
	  setElementData(source, "SK4", "4")
	  else
	end
	if (result[1]["ID_5"]) then
	  setElementData(source, "SK5", "5")
	  else
	end
	if (result[1]["ID_6"]) then
	  setElementData(source, "SK6", "6")
	  else
	end
	if (result[1]["ID_7"]) then
	  setElementData(source, "SK7", "7")
	  else
	end
	if (result[1]["ID_8"]) then
	  setElementData(source, "SK8", "8")
	  else
	end
	if (result[1]["ID_9"]) then
	  setElementData(source, "SK9", "9")
      else
	end
	if (result[1]["ID_10"]) then
	  setElementData(source, "SK10", "10")
	  else
	end
	if (result[1]["ID_11"]) then
	  setElementData(source, "SK11", "11")
	  else
	end
	if (result[1]["ID_12"]) then
	  setElementData(source, "SK12", "12")
	  else
	end
	if (result[1]["ID_13"]) then
	  setElementData(source, "SK13", "13")
	  else
	end
	if (result[1]["ID_14"]) then
	  setElementData(source, "SK14", "14")
	  else
	end
	if (result[1]["ID_15"]) then
	  setElementData(source, "SK15", "15")
	  else
	end
	if (result[1]["ID_16"]) then
	  setElementData(source, "SK16", "16")
	  else
	end
	if (result[1]["ID_17"]) then
	  setElementData(source, "SK17", "17")
	  else
	end
	if (result[1]["ID_18"]) then
	  setElementData(source, "SK18", "18")
	  else
	end
	if (result[1]["ID_19"]) then
	  setElementData(source, "SK19", "19")
	  else
	end
	if (result[1]["ID_20"]) then
	  setElementData(source, "SK20", "20")
	  else
	end
	end
end
)



--[[

local zone = createColCuboid(1244.63330, -1446.08337, 12.56050, 5.647216796875, 4.905029296875, 3.1425508499146)

function contar(thePlayer) 
triggerClientEvent(thePlayer,"JoinQuitGtaV:notifications", thePlayer,"Feminina", "Bem vindo a Loja Feminina, Pressione M depois clique no NPC com botão esquerdo do mouse! Boa compra!", 15 )
end 
addEventHandler("onColShapeHit", zone, contar) ]]--

