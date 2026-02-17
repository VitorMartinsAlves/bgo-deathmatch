local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25
local serials = {}
local tempTable = {}
local myBlip = {}
addEvent("GTIBettingStoreRob.rob", true)
addEventHandler("GTIBettingStoreRob.rob", root, function(tablec)
	tempTable[client] = tablec
	for i,v in ipairs(tempTable[client]) do
		local serial = getPlayerSerial(v)
		if not isElement(v) or (getPlayerIdleTime(v) > 300000) or serials[serial] then
			table.remove(tempTable[client],i)
		end
	end
	if (#tempTable[client]) < 5 then--3
		exports.bgo_hud:dm("Não há criminosos suficientes para roubar..", client, 200, 10, 0 )
		tempTable[client] = nil
		return false
	end
	local name = getPlayerName(client)
	for i,v in ipairs(tempTable[client]) do
		if isElement(v) then
			local serial = getPlayerSerial(v)
			if not serials[serial] then
				serials[serial] = true
				setTimer(function(serial)
				serials[serial] = nil
				end, 360000, 1, serial)
				triggerClientEvent(v,"GTIBettingStoreRob.start",resourceRoot,name)
			end
		end
	end

			local x, y, z = getElementPosition ( client )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )
		for _, players in ipairs(getElementsByType("player")) do		
			if getPlayerTeam(players) == getTeamFromName("Policia")  then
				triggerClientEvent(players, "TESTE22", players, "Assalto a Shopping LV em andamento!")
				triggerClientEvent(players, "bgo>info", players,"Assalto à loja!", "Um assalto ao shopping foi iniciado no bairro " .. location .. " " .. city.." ", "info")
				myBlip[client] = createBlipAttachedTo (client, 1 )
				setElementData(myBlip[client] ,"blipName", "Assalto a lojinha em andamento!")
				setBlipColor ( myBlip[client], 255, 0, 0, 255 )
				setBlipSize ( myBlip[client], 2 )
				setElementVisibleTo ( myBlip[client], root, false )
				setTimer(destroyElement, 60000, 1, myBlip[client])
				setElementVisibleTo ( myBlip[client], players, true )
				end
				
			if tonumber(getElementData(players, "char:adminduty") or 0) == 1 then
				setElementVisibleTo ( myBlip[client], players, true )
				triggerClientEvent(players, "TESTE22", players, "Assalto a Shopping LV em andamento!")
				triggerClientEvent(players, "bgo>info", players,"Assalto à loja!", "Assalto em " .. location .. " " .. city.." | ID: "..getElementData(client, "acc:id").." ", "info")
				end
			end
			
    exports.bgo_anims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
	tempTable[client] = nil
end
)

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



addEvent ("Shop>>PoliciaisVivos", true )
addEventHandler ("Shop>>PoliciaisVivos", root,
    function(thePlayer, target)
	local policiaTeam = getTeamFromName ( "Policia" )
        local groveCount = #getAlivePlayersInTeam(policiaTeam) --countPlayersInTeam ( policiaTeam )
        if groveCount > 20 then
		triggerClientEvent(thePlayer, "Shop>>PoliciaisConfima", thePlayer, target)
		else
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Informação", "Não tem policia na cidade ( minimo 20 policiais ), vaza daqui!", "erro")
		end	
		
	end
)





addEvent ("GTIBettingStoreRob.pay", true )
addEventHandler ("GTIBettingStoreRob.pay", root,
    function()
		--local pay = math.random(985*LOWER_BOUND, 985*UPPER_BOUND)
		
		local pay = math.random(10000, 25000)
		
		--setElementData(source, "char:moneysujo", (getElementData(source, "char:moneysujo") or 0) + pay)
		
		if exports.bgo_items:giveItem(source, 230, 1, pay, 0, true) then 
        local linha = math.random(1, 255 )
        exports.bgo_hud:drawNote("Sujo"..linha.."", "+ "..pay.." em blocos de dinheiro!", source, 255, 255, 255, 7000) 
		triggerClientEvent(source, "onClientPlayerGiveMoney", source, pay)
        end
		
	end
)



addEvent ("assalto2", true )
addEventHandler ("assalto2", root,
    function()
			triggerClientEvent(getRootElement(), "assalto", source)
	end
)


addEvent ("assalto3", true )
addEventHandler ("assalto3", root,
    function()
			triggerClientEvent(getRootElement(), "assalto4", source)
	end
)



addEvent ("GTIBettingStoreRob.store", true )
addEventHandler ("GTIBettingStoreRob.store", root,
    function()
	end
)

addEventHandler("onClientResourceStart", resourceRoot, function()

			for _, players in ipairs(getElementsByType("player")) do
setElementData(players, "isPlayerRobbing", false)
isRobbing = false
			end
end)

