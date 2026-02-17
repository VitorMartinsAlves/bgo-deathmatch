local myBlip = {}
local tempo = {}

local desman = {}


local tempoo = {}

function checktempoON( player )
	return isTimer(desman[player])
end

function checktempo ( player )
	if isTimer ( desman[player] ) then
		local miliseconds = getTimerDetails ( desman[player] )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end


function atmSetTimeOut ( thePlayer )
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
		if checktempoON( theVehicle ) then
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Informação", "Este carro está com "..checktempo ( theVehicle ).." segundos para sair do sistema do desmanche!", "info")
		else
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Informação", "Este carro não está no sistema do desmanche!", "info")
		end
	end
end
addCommandHandler("tempod", atmSetTimeOut)


addEventHandler("onElementDataChange", root, function(dataName)
	if source and getElementType(source) == 'vehicle' then 
		if tostring(dataName) == 'veh:desmanche' then 
			if getElementData(source, dataName) then 
			desman[source] = setTimer(function()
			setElementData(source, "veh:desmanche", false)
			end,7200000,1)
			end
		end	
	end
end
)


addEventHandler("onResourceStop", getResourceRootElement(),
	function ()
		for k, v in pairs(getElementsByType("vehicle")) do
			removeElementData(v, "veh:desmanche")
		end
	end
)



function SellOre(thePlayer, droga, veiculo, vehName)
	local policiaTeam = getTeamFromName ( "Policia" )
        local groveCount = #getAlivePlayersInTeam(policiaTeam) --countPlayersInTeam ( policiaTeam )
        if tonumber(groveCount) >= 5 then
		
		randomok = math.random(10,200)
		if tonumber(randomok) > 100 then

		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Lock Pick", "Veiculo "..vehName.." roubado com sucesso!", "sucesso")
		triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, droga, false)
		
		if isTimer(tempoo[thePlayer]) then
		killTimer(tempoo[thePlayer])
		end
		tempoo[thePlayer] = setTimer(acionarAlarme,800,20,thePlayer, veiculo)
		
		
		setVehicleLocked(veiculo, false)
		setElementData(veiculo, "veh:status", false)
		
		--if not isTimer(desman[veiculo]) then
		if not checktempoON( veiculo ) then
		setElementData(veiculo, "veh:desmanche", true)
		end
		
	
		local x,y,z = getElementPosition(thePlayer)
		local tabela = getElementsWithinRange( x, y, z, 20, "player" )
		local targetPlayer = nil
		for i = 1, #tabela do
		targetPlayer = tabela[i] 	
		x,y,z = getElementPosition(veiculo)
		triggerClientEvent(targetPlayer, "PlaySoundVehC", thePlayer, veiculo, "lockout", false, x,y,z)
		end
		
		else
		
		if isTimer(tempoo[thePlayer]) then
		killTimer(tempoo[thePlayer])
		end
		tempoo[thePlayer] =  setTimer(acionarAlarme,800,20,thePlayer, veiculo)

		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Lock Pick", "A policia foi acionada! fuja do local!!", "info")
		triggerClientEvent(thePlayer, "bgo->#darfuga", thePlayer)
		triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, droga, false)

		
	   	local x, y, z = getElementPosition ( thePlayer )
		local location = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		
		if isTimer(tempo[thePlayer]) then
		killTimer(tempo[thePlayer])
		end
		if isElement(myBlip[thePlayer]) then
		destroyElement(myBlip[thePlayer])
		end
		myBlip[thePlayer] = createBlipAttachedTo (thePlayer, 1 )
		setElementData(myBlip[thePlayer] ,"blipName", "Negociação de droga!!")
		setBlipColor ( myBlip[thePlayer], 255, 0, 0, 255 )
		setBlipSize ( myBlip[thePlayer], 2 )
		setBlipVisibleDistance(myBlip[thePlayer], 2000)
		setElementVisibleTo ( myBlip[thePlayer], root, false )
		tempo[thePlayer] = setTimer(destroyElement, 300000, 1, myBlip[thePlayer])
		
		local players2 = getPlayersInTeam(getTeamFromName ( "Policia" ))
		for i,players in pairs(players2) do
		triggerClientEvent(players, "bgo>info", players,"Tentativa de Roubo", "Possivel Roubo ao veiculo "..vehName.." na região " .. location .. " " .. city .." ", "sucesso")
		setElementVisibleTo ( myBlip[thePlayer], players, true )
		end
		
		local players2 = getPlayersInTeam(getTeamFromName ( "Admin" ))
		for i,players in pairs(players2) do
		setElementVisibleTo ( myBlip[thePlayer], players, true )
		triggerClientEvent(players, "bgo>info", players,"Tentativa de Roubo", "Possivel Roubo ao veiculo "..vehName.." na região " .. location .. " " .. city .." | ID: "..getElementData(thePlayer, "acc:id").." ", "sucesso")
		end
		end
		
	else
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Ops!", "É preciso de 10 policiais para fluir o RP de lock pick!", "info")
	end
end
addEvent("bgoMTA->#tentarLP", true)
addEventHandler("bgoMTA->#tentarLP", root, SellOre)



function removerLP(thePlayer, droga)

triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, droga, false)
end
addEvent("bgoMTA->#removerLP", true)
addEventHandler("bgoMTA->#removerLP", root, removerLP)




function acionarAlarme(thePlayer, veiculo)
	
    if ( getVehicleOverrideLights ( veiculo ) ~= 2 ) then 
    setVehicleOverrideLights ( veiculo, 2 )
    else
    setVehicleOverrideLights ( veiculo, 1 ) 
    end
	
		local x,y,z = getElementPosition(thePlayer)
		local int = getElementInterior(thePlayer)
		local dim = getElementDimension(thePlayer)
		local tabela = getElementsWithinRange( x, y, z, 30, "player" )
		local targetPlayer = nil
		for i = 1, #tabela do
		targetPlayer = tabela[i] 	
		x,y,z = getElementPosition(veiculo)
		triggerClientEvent(targetPlayer, "acionaralarm", thePlayer, veiculo, x,y,z, int,dim)
		end
	
end


function quitPlayer ( quitType )
	if isElement(myBlip[source]) then
		destroyElement(myBlip[source])
		end
		if isTimer(tempo[source]) then
		killTimer(tempo[source])
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )


function getAlivePlayersInTeam(theTeam)
    local theTable = { }
    local players = getPlayersInTeam(theTeam)

    for i,v in pairs(players) do
        if not isPedDead(v) and exports.bgo_items:atmIsAbleToRob(v) then
            theTable[#theTable+1]=v
        end
    end

    return theTable
end

