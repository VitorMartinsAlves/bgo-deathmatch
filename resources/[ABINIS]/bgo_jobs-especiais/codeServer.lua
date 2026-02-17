--local connection = exports["bgo_mysql"]:getConnection()

--addEvent("updateJobToServer", true)
--addEventHandler("updateJobToServer", root, function (JobID)
--	dbPoll ( dbQuery( connection, "UPDATE characters SET job='?' WHERE id = '?'", JobID, getElementData(source, "acc:id")), -1 )
--end)


addEvent("trabalhoespecial", true)
addEventHandler("trabalhoespecial", root, function (thePlayer, a, b)

if exports.bgo_admin:isPlayerDuty(thePlayer) or exports.bgo_admin:isPlayerFaccao(thePlayer) then
exports.bgo_infobox:addNotification(thePlayer, "Você esta utilizando /trabalhar e não pode pegar emprego aqui! ","error")
return
end


demitir(thePlayer)
     if a ~= 222 then
		 setElementModel(thePlayer, b)
		 else
		 exports.Script_futeis:setGPS(thePlayer, "Coordenada", 1715.3203125,1613.7020263672,10.015625)
		 setElementData(thePlayer, "fly:skin", getElementModel(thePlayer))
		 setElementModel(thePlayer, b)
	 end
	 setElementData(thePlayer, "char:dutyfaction", a)
	 if getElementData(thePlayer, "char:dutyfaction") == 12 then
	 
	     exports.Script_futeis:setGPS(thePlayer, "Coordenada", -42.928, -1153.647, 1.078)
	 end
end)

addEvent("trabalhoespecialskin0", true)
addEventHandler("trabalhoespecialskin0", root, function (thePlayer, a, b)
    x,y,z = getElementPosition(thePlayer)
	if getElementModel(thePlayer) == 294 then
	     exports.Script_futeis:setGPS(thePlayer, "Coordenada", x,y,z)
	end
	--setElementModel(thePlayer, 0)
	exports.bgo_admin:setarskinP(thePlayer)
end)

function demitir(player)

	if getElementData(player, "char:dutyfaction") == 17 
	or getElementData(player, "char:dutyfaction") == 16 
	or getElementData(player, "char:dutyfaction") == 24 
	or getElementData(player, "char:dutyfaction") == 11
	or getElementData(player, "char:dutyfaction") == 19 
	or getElementData(player, "char:dutyfaction") == 5 
	or getElementData(player, "char:dutyfaction") == 6 
	or getElementData(player, "char:dutyfaction") == 21 
	or getElementData(player, "char:dutyfaction") == 2 
	or getElementData(player, "char:dutyfaction") == 20 
	or getElementData(player, "char:dutyfaction") == 22 then return end
	
	--if getElementData(player, "job") == "Mecânico" then 
	if getElementData(player, "char:dutyfaction") == 3 then
	--setElementModel(player, 0)
	exports.bgo_admin:setarskinP(player)

	setElementData(player, "char:dutyfaction", nil)
	setElementData(player, "job", "SemEmprego")
	end
	--elseif getElementData(player, "job") == "Taxista" then 
	if getElementData(player, "char:dutyfaction") == 12 then

	--setElementModel(player, 0)
	exports.bgo_admin:setarskinP(player)

	setElementData(player, "char:dutyfaction", nil)
	setElementData(player, "job", "SemEmprego")
end
end
--addCommandHandler("demitir",demitir)

