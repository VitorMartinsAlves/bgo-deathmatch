--local connection = exports["mx_connection"]:getConnection()
local ObjectPos = {}

local connection = exports.bgo_mysql:getConnection()

function onTrafiHit(thePlayer, Penz)
	--setElementData(thePlayer,"char:money",getElementData(thePlayer, "char:money") - math.floor(tonumber(Penz)))
	--exports.exg_dashboard:giveGroupBalance(29, math.floor(tonumber(Penz)))
end
addEvent("onTrafiHit", true)
addEventHandler("onTrafiHit", getRootElement(), onTrafiHit)

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

function syncSpeedCameras(x, y, z, rot,limit)
	
	local object = createObject(1337, x, y, z-1.65)
	
	setElementRotation(object, 0, 0, rot)
	object:setData("speedCamera", true)
	--object:setData("Object:Name", tostring("#87D37C"..limit.." #ffffffkm/h"))
end
addEvent("syncSpeedCameras", true)
addEventHandler("syncSpeedCameras", resourceRoot, syncSpeedCameras)


function createAmount (Player, element,amount, limit)
	if exports.bgo_admin:isPlayerDuty(element) then return end
	if getElementData(element,"char:dutyfaction") == 4  then return end

	outputChatBox("#22A7F0[BGO - RADAR] #ffffffVocê estava dirigindo mais rápido que a velocidade permitida: #22A7F0( " .. limit .." )#ffffff \nMulta: #7cc576$".. tonumber(amount), element,255, 255, 255, true)

         local vehicle = getPedOccupiedVehicle ( element ) 
         local plateText = getVehiclePlateText ( vehicle )
		 
		local sucesso = dbExec(connection, "INSERT INTO multas SET drvv = ?, dono = ?, motivo = ?, placa = ?, valor = ?, nome = ?", "RADAR", getElementData(element, "acc:id"), "Passou na velocidade acima de " .. limit .." no radar", plateText, tonumber(amount), getPlayerName(element))
		if sucesso then
			triggerEvent("getListDataMultas",element,element) 
			triggerClientEvent(element, "bgo>info", element,"DRVV Transito | Você foi multado!!", "Multado por RADAR | Placa: "..plateText.." | Valor da multa: "..tonumber(amount).." | Motivo: Passou na velocidade acima de " .. limit .." no radar!", "erro")
			--triggerClientEvent(element, "bgo>info", element,"DRVV Transito | Informa", "Para pagar suas multas pendentes é preciso ir até o departamento do DRVV", "info")
		end
	end

addEvent("createAmount",true)
addEventHandler("createAmount",root,createAmount)


function darMulta (thePlayer,limit, amount)
	outputChatBox("#22A7F0[BGO - RADAR] #ffffffVocê estava dirigindo mais rápido que a velocidade permitida: #22A7F0( " .. limit .." )#ffffff \nMulta: #7cc576$".. tonumber(amount), thePlayer,255, 255, 255, true)
         local vehicle = getPedOccupiedVehicle ( thePlayer ) 
         local plateText = getVehiclePlateText ( vehicle )
		local sucesso = dbExec(connection, "INSERT INTO multas SET drvv = ?, dono = ?, motivo = ?, placa = ?, valor = ?, nome = ?", "RADAR", getElementData(thePlayer, "acc:id"), "Passou na velocidade acima de " .. limit .." no radar", plateText, tonumber(amount), getPlayerName(thePlayer))
		if sucesso then
			triggerEvent("getListDataMultas",thePlayer,thePlayer) 
			triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | Você foi multado!!", "Multado por RADAR | Placa: "..plateText.." | Valor da multa: "..tonumber(amount).." | Motivo: Passou na velocidade acima de " .. limit .." no radar!", "erro")
			--triggerClientEvent(thePlayer, "bgo>info", thePlayer,"DRVV Transito | Informa", "Para pagar suas multas pendentes é preciso ir até o departamento do DRVV", "info")
		end
end
addEvent("darMulta",true)
addEventHandler("darMulta",root,darMulta)


addCommandHandler("delradar",function(p,c)
	--if exports["exg_dashboard"]:isPlayerInFaction(p, 7) or exports["exg_dashboard"]:isPlayerInFaction(p, 9) then
	if getElementData(p, "acc:admin") >= 1 or getElementData(p,"char:dutyfaction") == 1 then
		for k,v in ipairs(getElementsByType("object")) do
			if getElementData(v,"speedCamera") then
				x,y,z = getElementPosition(p)
				x1,y2,z2 = getElementPosition(v)
				if getDistanceBetweenPoints3D(x,y,z,x1,y2,z2) <= 1.5 then
					destroyElement(v)
				end
			end
		end
	end
end)