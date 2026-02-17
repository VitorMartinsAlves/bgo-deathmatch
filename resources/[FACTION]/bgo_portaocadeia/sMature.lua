PortD1 = createObject ( 1495, 1576.4, -1695, 12.6, -0, 0, 0 )
PortD2 = createObject ( 1495, 1580.9, -1695, 12.6, -0, 0, 0 )
PortD3 = createObject ( 1495, 1578.4, -1703.3, 12.6, -0, 0, 0 )
PortD4 = createObject ( 1495, 1574.2, -1703.3, 12.6, -0, 0, 0 )
PortD5 = createObject ( 1495, 1569.7, -1703.3, 12.6, -0, 0, 0 )
PortD6 = createObject ( 1495, 1571.9, -1694.9, 12.6, -0, 0, 0 )
setElementFrozen(PortD1, true)
setElementFrozen(PortD2, true)
setElementFrozen(PortD3, true)
setElementFrozen(PortD4, true)
setElementFrozen(PortD5, true)
setElementFrozen(PortD6, true)

Port1 = createObject ( 2930, 1582.707, -1703.241, 14.969, -0, 0, 90.43748474121 )
Port3 = createObject ( 2930, 1566.6624755859,-1674.2652832031,17.619312210083, -0, 0, 0)
setElementAlpha(Port1, 0)
setElementAlpha(Port3, 0)




Port21 = createObject ( 1499, 1582.907, -1703.241, 12.569, -0, 0, 0 )
Port22 = createObject ( 1495, 1582.907, -1703.241, 12.569, -0, 0, 0 )
Port31 = createObject ( 1499, 1566.6624755859,-1674.2652832031,14.459312210083, -0, 0, 270.48114013672 )
Port33 = createObject ( 1495, 1566.6624755859,-1674.2652832031,14.459312210083, -0, 0, 270.48114013672 )
setElementCollisionsEnabled(Port21, false)
setElementCollisionsEnabled(Port22, false)
setObjectScale(Port31, 1.25)
setObjectScale(Port33, 1.25)
setElementAlpha(Port21, 0)
setElementAlpha(Port31, 0)
setElementCollisionsEnabled(Port31, false)
attachElements ( Port22, Port21, 0, 0, 0 )
attachElements ( Port33, Port31, 0, 0, 0 )
setElementCollisionsEnabled(Port33, false)


colPort1 = createColSphere(1583.683, -1702.127, 13.569,1)
colPort2 = createColSphere(1582.487, -1699.11, 14.598,2)
colPort3 = createColSphere(1566.7580566406,-1675.1942138672,16.199312210083,1.5)

PortD = createObject ( 980, 1582.697, -1699.11, 13.598, 0, 0, 90 )

open1 = false
open2 = false
open3 = false

function gatePort1 (thePlayer)
     if isElementWithinColShape(thePlayer, colPort1) then
		 if (open1 == false) then
		     moveObject (Port1, 100, 1582.707, -1703.241, 10.969)
			 triggerClientEvent(root, "gateStatus", root, "fechar", 2)
			 setElementCollisionsEnabled(Port21, true)
			 open1 = true
			 else
			 moveObject (Port1, 100, 1582.707, -1703.241, 14.969)
			 if isElement(Port21) then
			     destroyElement(Port21)
			 end
			 if isElement(Port22) then
			     destroyElement(Port22)
			 end
			 Port21 = createObject ( 1499, 1582.907, -1703.241, 12.569, -0, 0, 0 )
			 Port22 = createObject ( 1495, 1582.907, -1703.241, 12.569, -0, 0, 0 )
			 setElementCollisionsEnabled(Port22, false)
			 setElementAlpha(Port21, 0)
			 triggerClientEvent(root, "gateStatus", root, "abrir", 2)
			 attachElements ( Port22, Port21, 0, 0, 0 )
			 setElementCollisionsEnabled(Port21, false)
			 open1 = false
		 end
	 end
	 
		if isElementWithinColShape(thePlayer, colPort2) then
			if (open2 == false) then
				moveObject (PortD, 100, 1582.487, -1699.11, 5.598)
				triggerClientEvent(root, "gateStatus", root, "fechar", 1)
				setElementCollisionsEnabled(Port31, true)
				open2 = true
				else
				triggerClientEvent(root, "gateStatus", root, "abrir", 1)
				moveObject (PortD, 100, 1582.697, -1699.11, 13.598)
				open2 = false
			end
		end	 
	 
		if isElementWithinColShape(thePlayer, colPort3) then
			if (open3 == false) then
				moveObject (Port3, 100, 1566.6624755859,-1674.2652832031,10.619312210083)
				triggerClientEvent(root, "gateStatus", root, "fechar", 3)
				setElementCollisionsEnabled(Port31, true)
				open3 = true
				else
				moveObject (Port3, 100, 1566.6624755859,-1674.2652832031,17.619312210083)
				if isElement(Port31) then
					destroyElement(Port31)
				end
				if isElement(Port33) then
					destroyElement(Port33)
				end
				triggerClientEvent(root, "gateStatus", root, "abrir", 3)
				Port31 = createObject ( 1499,  1566.6624755859,-1674.2652832031,14.459312210083, -0, 0, 270.48114013672 )
				Port33 = createObject ( 1495, 1566.6624755859,-1674.2652832031,14.459312210083, -0, 0, 270.48114013672 )
				setObjectScale(Port31, 1.25)
				setElementAlpha(Port31, 0)
				setObjectScale(Port33, 1.25)
				setElementCollisionsEnabled(Port31, false)
				attachElements ( Port33, Port31, 0, 0, 0 )
				setElementCollisionsEnabled(Port33, false)
				open3 = false
			end
		end



end




function enterZone3 (thePlayer)
	--if (getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 24 or  getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:adminduty") == 1) then
	   if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then

	   setElementData(thePlayer, "zoneInfo3", true)
		bindKey( thePlayer, "e","down", gatePort1)
	end
end
addEventHandler("onColShapeHit", colPort3, enterZone3)

function exitZone1 (thePlayer)
--	 if (getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 24 or  getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:adminduty") == 1) then
if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then
	   setElementData(thePlayer, "zoneInfo2", false)
		unbindKey( thePlayer, "e","down", gatePort1) 
	end
end
addEventHandler("onColShapeLeave", colPort2, exitZone1)

function enterZone11 (thePlayer)
	--if (getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 24 or  getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:adminduty") == 1) then
	   if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then

	   setElementData(thePlayer, "zoneInfo2", true)
		bindKey( thePlayer, "e","down", gatePort1)
	end
end
addEventHandler("onColShapeHit", colPort2, enterZone11)

function exitZone11 (thePlayer)
--	 if (getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 24 or  getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:adminduty") == 1) then
if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then
	   setElementData(thePlayer, "zoneInfo3", false)
		unbindKey( thePlayer, "e","down", gatePort1) 
	end
end
addEventHandler("onColShapeLeave", colPort3, exitZone11)

function enterZone2 (thePlayer)
--	 if (getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 24 or getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:adminduty") == 1) then

		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then
		setElementData(thePlayer, "zoneInfo1", true)
		 bindKey( thePlayer, "e","down", gatePort1)
	 end
end
addEventHandler("onColShapeHit", colPort1, enterZone2)

function exitZone2 (thePlayer)
--	 if (getElementData(thePlayer, "char:dutyfaction") == 17 or getElementData(thePlayer, "char:dutyfaction") == 16 or getElementData(thePlayer, "char:dutyfaction") == 24 or  getElementData(thePlayer, "char:dutyfaction") == 11 or getElementData(thePlayer, "char:dutyfaction") == 19 or getElementData(thePlayer, "char:dutyfaction") == 5 or getElementData(thePlayer, "char:dutyfaction") == 6 or getElementData(thePlayer, "char:dutyfaction") == 21 or getElementData(thePlayer, "char:dutyfaction") == 2 or getElementData(thePlayer, "char:dutyfaction") == 20 or getElementData(thePlayer, "char:dutyfaction") == 22 or getElementData(thePlayer, "char:adminduty") == 1) then

if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then
	
		setElementData(thePlayer, "zoneInfo1", false)
		 unbindKey( thePlayer, "e","down", gatePort1) 
	 end
end
addEventHandler("onColShapeLeave", colPort1, exitZone2)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



local con = exports.bgo_mysql:getConnection()

--[[
local randomPos = {
     {1580.346, -1693.076, 13.598},
     {1575.815, -1692.999, 13.598},
     {1571.704, -1693.013, 13.598},
     {1571.687, -1705.343, 13.598},
     {1576.417, -1705.606, 13.598},
	 {1579.982, -1705.234, 13.598},
}

]]--

local randomPos = {
     {3053.8581542969,-1972.6236572266,11.06875038147},
     {3052.5766601563,-1960.96875,11.06875038147},
     {3050.4875488281,-1993.8082275391,11.06875038147},
}


function prendendo(thePlayer, targetPlayer, timerP, reason)
	local reason = table.concat({reason}, " ")
    if getElementData(targetPlayer, "VIP") then
	     ido = tonumber(timerP) / 2
		 ido = math.floor(ido)
	else
	     ido = tonumber(timerP)
	end
	setElementData(targetPlayer, "player:preso", true)
	setElementData(targetPlayer,"char:moneysujo", 0)
	if getElementData(targetPlayer, "VIP") then
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 " .. getPlayerName(thePlayer) .. "#ffffff Prendeu #7cc576" .. getPlayerName(targetPlayer) .. " #ffffffpor #1a75ff" .. ido .. "#ffffff anos.", root ,255, 255, 255, true)
	outputChatBox("#dc143c[Decreto]:#FFFFFF Pelo fato do preso ser VIP a sentença foi alterada: #dc143c"..tonumber(timerP).." anos #ffffffpara #dc143c" .. ido .. " anos", root ,255, 255, 255, true)
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 Motivo:#ffffff Os artigos do preso se encontram em sigilo.", root ,255, 255, 255, true)
	else
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 " .. getPlayerName(thePlayer) .. "#ffffff Prendeu #7cc576" .. getPlayerName(targetPlayer) .. " #ffffffpor #1a75ff" .. ido .. "#ffffff anos.", root ,255, 255, 255, true)
	outputChatBox("#dc143c[Departamento de policia]:#7cc576 Motivo:#ffffff " .. reason, root ,255, 255, 255, true)
	end
   -- if not exports.serialVip:isPlayerVip(targetPlayer) then
	--end
	takeAllWeapons(targetPlayer)

	--_call(removeritems, targetPlayer)
	
	exports.bgo_admin:iniciarRemocaoItems(targetPlayer)
	
	if not exports.serialVip:isPlayerVip(targetPlayer) then
	--_call(removeritemsVIP, targetPlayer)
	exports.bgo_admin:iniciarRemocaoItemsVIP(targetPlayer)
	end
	
	
	
	local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
	local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
	if isTimer(theTimerCheck) then
		killTimer(theTimerCheck)
	end
	if isTimer(theTimerCheck2) then
		killTimer(theTimerCheck2)
	end
	if isPedInVehicle(targetPlayer) then
		removePedFromVehicle(targetPlayer)
	end
	setElementData(targetPlayer, "player:preso", true)
	fadeCamera(targetPlayer, false, 1.0)
	setElementFrozen(targetPlayer, true)
	if isPedInVehicle(targetPlayer) then
		toggleAllControls(targetPlayer, false, false, false)
	end
	if (getElementData(targetPlayer, "algemado")) then
	     setElementData(targetPlayer, "algemado", false)
	end
	setTimer(function()
		triggerClientEvent(targetPlayer, "triggerAdminjail", targetPlayer, thePlayer, reason, ido, 1, false)
	end, 500, 1)
	setTimer( function()
	    pos = math.random(#randomPos)
		--local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
		setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
		setElementData(targetPlayer, "idoTelik", ido)
		setElementData(targetPlayer, "idoLetelt", 0)
		setElementData(targetPlayer, "adminjail", 1)
		setElementData(targetPlayer, "adminjail:reason", reason)
		setElementData(targetPlayer, "adminjail:ido", ido)
		setElementData(targetPlayer, "adminjail:admin", getPlayerName(thePlayer))
		setElementData(targetPlayer, "adminjail:adminSerial", getPlayerSerial(thePlayer))
		
		setElementPosition(targetPlayer, randomPos[pos][1], randomPos[pos][2], randomPos[pos][3])
		setElementInterior(targetPlayer, 0)
		setElementDimension(targetPlayer, 0)
		exports.Script_futeis:setGPS(targetPlayer, "Coordenada",2996.2282714844,-1965.4440917969,11.06875038147)
		
	end, 1500, 1)
	local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 1, reason, ido, ido, getPlayerName(thePlayer), getPlayerSerial(thePlayer))

					
	setTimer(function()
		fadeCamera(targetPlayer, true, 2.5)
		setElementFrozen(targetPlayer, false)
		toggleAllControls(targetPlayer, true, true, true)
	end, 7500, 1)
end
addEvent ("prendendo",true)
addEventHandler ("prendendo", root,  prendendo)




function prendendoStaff(thePlayer, targetPlayer, ido, reason)
	takeAllWeapons(targetPlayer)
	local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
	local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
	if isTimer(theTimerCheck) then
		killTimer(theTimerCheck)
	end
	if isTimer(theTimerCheck2) then
		killTimer(theTimerCheck2)
	end
	if isPedInVehicle(targetPlayer) then
		removePedFromVehicle(targetPlayer)
	end
	setElementData(targetPlayer, "player:preso", true)
	fadeCamera(targetPlayer, false, 1.0)
	setElementFrozen(targetPlayer, true)
	if isPedInVehicle(targetPlayer) then
		toggleAllControls(targetPlayer, false, false, false)
	end
	if (getElementData(targetPlayer, "algemado")) then
	     setElementData(targetPlayer, "algemado", false)
	end
	setTimer(function()
		triggerClientEvent(targetPlayer, "triggerAdminjail", targetPlayer, thePlayer, reason, ido, 1, false)
	end, 500, 1)
	setTimer( function()
	    pos = math.random(#randomPos)
		--local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
		setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
		setElementData(targetPlayer, "idoTelik", ido)
		setElementData(targetPlayer, "idoLetelt", 0)
		setElementData(targetPlayer, "adminjail", 1)
		setElementData(targetPlayer, "adminjail:reason", reason)
		setElementData(targetPlayer, "adminjail:ido", ido)
		setElementData(targetPlayer, "adminjail:admin", getPlayerName(thePlayer))
		setElementData(targetPlayer, "adminjail:adminSerial", getPlayerSerial(thePlayer))
		
		setElementPosition(targetPlayer, randomPos[pos][1], randomPos[pos][2], randomPos[pos][3])
		setElementInterior(targetPlayer, 0)
		setElementDimension(targetPlayer, 0)
		exports.Script_futeis:setGPS(targetPlayer, "Coordenada",2996.2282714844,-1965.4440917969,11.06875038147)
	end, 1500, 1)

	
	local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 1, reason, ido, ido, getPlayerName(thePlayer), getPlayerSerial(thePlayer))

					
	setTimer(function()
		fadeCamera(targetPlayer, true, 2.5)
		setElementFrozen(targetPlayer, false)
		toggleAllControls(targetPlayer, true, true, true)
	end, 7500, 1)
end
addEvent ("prendendoStaff",true)
addEventHandler ("prendendoStaff", root,  prendendoStaff)



function bortonIdo(thePlayer, commandName)
	if getElementData(thePlayer, "adminjail") == 1 then
		
		local admin = getElementData(thePlayer, "adminjail:admin")
		local ido = getElementData(thePlayer, "adminjail:ido")
		local reason = getElementData(thePlayer, "adminjail:reason")
		local letelt = getElementData(thePlayer, "idoLetelt")
		local hatravan = getElementData(thePlayer, "idoTelik")
		
		outputChatBox("#dc143c[Preso - Informação]:#ffffff #7cc576" .. admin .. "#ffffff Prendeu você por #7cc576" .. ido .. " anos#ffffff.", thePlayer, 255, 255, 255, true)
		outputChatBox("#dc143c[Preso - Informação]:#ffffff Motivo: #7cc576" .. reason, thePlayer, 255, 255, 255, true)
		outputChatBox("#dc143c[Preso - Informação]:#ffffff Você vai sair ao entregar: #7cc576" .. hatravan .. " caixas #ffffff e você foi preso por: #7cc576" .. letelt .. " anos", thePlayer, 255, 255, 255, true)
	else
		outputChatBox("Você não está preso!", thePlayer, 255, 255, 255, true)
	end
end
addCommandHandler("tempo", bortonIdo, false, false)

local objetocaixa = {}
addEvent( "caixanamao", true )
addEventHandler( "caixanamao", root,
function (thePlayer)
if getElementData(thePlayer, "adminjail") == 1 then
			if isElement(objetocaixa[thePlayer]) then
				destroyElement(objetocaixa[thePlayer])
			end
			
		local rot = getElementRotation(thePlayer)
		objetocaixa[thePlayer] = createObject(3014, 0, 0, 0)
		setElementData(thePlayer,"Animando", true)
		
		setObjectScale(objetocaixa[thePlayer], 0.9)		
		exports.bone_attach:attachElementToBone(objetocaixa[thePlayer],thePlayer,3,-0.1, 0.45, 0.19, 0, rot, 0) 
		exports.bgo_anims:setJobAnimation(thePlayer, "CARRY", "crry_prtial", 500, false, false, true, true)
end
end
)

addEventHandler("onPlayerQuit", root, function()
	if isElement(objetocaixa[source]) then
		destroyElement(objetocaixa[source])
	end
end)


local tempo = {}
function idoTelikLe(targetPlayer)
	if isElement(targetPlayer) and (getElementType(targetPlayer) == "player") then
	--if isTimer(tempo[targetPlayer]) then return end
	
	
	
		local idoTelik = tonumber(getElementData(targetPlayer, "idoTelik")) or false
		local idoLetelt = tonumber(getElementData(targetPlayer, "idoLetelt")) or false
		if (idoTelik) and (idoLetelt) then
			setElementData(targetPlayer, "idoTelik", idoTelik-1)
			setElementData(targetPlayer, "idoLetelt", idoLetelt+1)
			--tempo[targetPlayer] = setTimer(function() end,5000,1)
			if isElement(objetocaixa[targetPlayer]) then
				destroyElement(objetocaixa[targetPlayer])
			end
			--outputChatBox("#dc143c[Preso - Informação]:#ffffff Você vai sair em: #7cc576" .. idoTelik .. " minutos#ffffff e você está preso há: #7cc576" .. idoLetelt .. " minutos", targetPlayer, 255, 255, 255, true)

			if (idoTelik) <= 1 then
			triggerClientEvent(targetPlayer, "bgo>info", targetPlayer,"Prisão BGO", "Obrigado por entregar as caixas, boa sorte nas ruas!", "info")
			else
			triggerClientEvent(targetPlayer, "bgo>info", targetPlayer,"Prisão BGO", "Você vai sair ao entregar: " .. idoTelik-1 .. " caixas", "info")
			end


			dbExec(con, "UPDATE characters SET adminjail_idoTelik = ?, adminjail_alapIdo = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", idoTelik, idoLetelt)
			if (idoTelik) <= 1 then
				outputChatBox("Sua sentença expirou e Você foi solto!.", targetPlayer, 255, 255, 255, true)
				setElementData(targetPlayer, "player:preso", false)
				setElementFrozen(targetPlayer, false)
				--[[
				local theTimer = getElementData(targetPlayer, "adminjail:theTimer")
				if not (theTimer) then
					return false
				end
				]]--
				--killTimer(theTimer)
				tempo[targetPlayer] = setTimer(function() end,5000,1)
				
							if (theTimerCheck) then
								killTimer(theTimerCheck)
								setElementData(targetPlayer, "adminjail:timer", false)
							end
							if (theTimerCheck2) then
								killTimer(theTimerCheck2)
								setElementData(targetPlayer, "adminjail:theTimerAccounts", false)
							end	
				if isElement(objetocaixa[targetPlayer]) then
				destroyElement(objetocaixa[targetPlayer])
				end
				setElementData(targetPlayer, "adminjail:theTimer", false)
				setElementData(targetPlayer, "adminjail", false)
				setElementData(targetPlayer, "adminjail:reason", false)
				setElementData(targetPlayer, "adminjail:ido", false)
				setElementData(targetPlayer, "adminjail:admin", false)
				setElementData(targetPlayer, "adminjail:adminSerial", false)
				setElementData(targetPlayer, "idoTelik", false)
				setElementData(targetPlayer, "idoLetelt", false)
				setTimer(setElementPosition, 2000, 1,targetPlayer, 2940.6088867188,-1964.1695556641,11.06875038147)
				--setElementPosition(targetPlayer, 2940.6088867188,-1964.1695556641,11.06875038147)
				
				setElementInterior(targetPlayer, 0)
				setElementDimension(targetPlayer, 0)

								--sql
				local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)

								
			end
		end
	end
end
addEvent ("entregarCaixa",true)
addEventHandler ("entregarCaixa", root,  idoTelikLe)

function saircadeia(thePlayer)
	if isElement(objetocaixa[thePlayer]) then
		destroyElement(objetocaixa[thePlayer])
		triggerClientEvent(thePlayer, "destruirCaixaMarca", thePlayer)
	end
end



--[[
local prision = createColCuboid(1569.63306, -1707.58179, 11.67501, 13.111083984375, 16.225463867188, 4.7000011444092)

function exitZ (thePlayer)
     --if (getElementData(thePlayer, "player:preso")) then
	 if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:adminduty") == 1 then 
	 outputChatBox("#FFA000[BGO INFO] #FFFFFFVocê entrou nas celas da prisão", thePlayer, 255,255,255, true)
	 return end
		if getElementData(thePlayer, "adminjail") == 1 then
	     pos = math.random(#randomPos)
         outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê ainda está preso!, Aguarde.", thePlayer, 255,255,255, true)
		 setElementPosition(thePlayer, randomPos[pos][1], randomPos[pos][2], randomPos[pos][3])
		 else
		 setElementPosition(thePlayer, 1565.038, -1677.821, 16.199)
		setElementInterior(thePlayer, 0)
		setElementDimension(thePlayer, 0)
		 --setElementFrozen(thePlayer, true)
	 end
end
addEventHandler("onColShapeLeave", prision, exitZ)

addEventHandler("onColShapeHit", prision, exitZ)
]]--


 local prisionadmin = createColCuboid(2993.69043, -2054.28247, 8.66815, 84.76025390625, 163.62487792969, 11.90005531311)
function exitZprisionadmin (thePlayer)


		if getElementData(thePlayer, "adminjail") == 1 then
	     pos = math.random(#randomPos)
         --outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê ainda está preso!, Aguarde.", thePlayer, 255,255,255, true)
		 setElementPosition(thePlayer, randomPos[pos][1], randomPos[pos][2], randomPos[pos][3])
		-- else
		-- setElementPosition(thePlayer, 1565.038, -1677.821, 16.199)
		--setElementInterior(thePlayer, 0)
		--setElementDimension(thePlayer, 0)
	 end
end
addEventHandler("onColShapeLeave", prisionadmin, exitZprisionadmin)