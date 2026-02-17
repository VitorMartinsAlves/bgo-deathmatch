local myBlip = {}
local tempo = {}
function SellOre(thePlayer, droga)
	local policiaTeam = getTeamFromName ( "Policia" )
        local groveCount = #getAlivePlayersInTeam(policiaTeam) --countPlayersInTeam ( policiaTeam )
        if tonumber(groveCount) >= 10 then
		
		randomok = math.random(10,200)
		if tonumber(randomok) > 100 then
		
		local sujo = math.random(500, 1000)
		if exports.bgo_items:giveItem(thePlayer, 230, 1, sujo, 0, true) then 
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Americano!", "Obrigado irmão garanto que vai ser util pra mim", "sucesso")
		triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, droga, false)
		local x,y,z = getElementPosition(thePlayer)
		triggerClientEvent(root, "bgo->#agradece", thePlayer, x,y,z)
        local linha = math.random(1, 255 )
        exports.bgo_hud:drawNote("Sujo"..linha.."", "+ "..sujo.." em blocos de dinheiro!", thePlayer, 255, 255, 255, 7000) 
		triggerClientEvent(thePlayer, "onClientPlayerGiveMoney", thePlayer, sujo)
        end	
		
		else
		
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Americano!", "Isso é bosta de cavalo? SOCORRO POLICIA!", "erro")
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Americano!", "A policia foi acionada! fuja do local!!", "info")
		triggerClientEvent(thePlayer, "bgo->#darfuga", thePlayer)
		local x,y,z = getElementPosition(thePlayer)
		triggerClientEvent(root, "bgo->#somedaqui", thePlayer, x,y,z)
		
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
		triggerClientEvent(players, "bgo>info", players,"Negociação de droga", "Possivel negociação de droga na região " .. location .. " " .. city .." ", "sucesso")
		setElementVisibleTo ( myBlip[thePlayer], players, true )
		end
		
		local players2 = getPlayersInTeam(getTeamFromName ( "Admin" ))
		for i,players in pairs(players2) do
		setElementVisibleTo ( myBlip[thePlayer], players, true )
		triggerClientEvent(players, "bgo>info", players,"Negociação de droga!!", "Negociação de droga em " .. location .. " " .. city .." | ID: "..getElementData(thePlayer, "acc:id").." ", "sucesso")
		end
		end
		
	else
		local x,y,z = getElementPosition(thePlayer)
		triggerClientEvent(root, "bgo->#somedaqui", thePlayer, x,y,z)
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Ops!", "É preciso de 10 policiais para fluir o RP de negociação de droga!", "info")
	end
end
addEvent("bgoMTA->#vendadedroga", true)
addEventHandler("bgoMTA->#vendadedroga", root, SellOre)


function quitPlayer ( quitType )
	if isElement(myBlip[source]) then
		destroyElement(myBlip[source])
		end
		if isTimer(tempo[source]) then
		killTimer(tempo[source])
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )


--[[
function acionarpolicia(thePlayer)
	   	local x, y, z = getElementPosition ( thePlayer )
		local location = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		
		myBlip[thePlayer] = createBlipAttachedTo (thePlayer, 1 )
		setElementData(myBlip[thePlayer] ,"blipName", "Negociação de droga!!")
		setBlipColor ( myBlip[thePlayer], 255, 0, 0, 255 )
		setBlipSize ( myBlip[thePlayer], 2 )
		setElementVisibleTo ( myBlip[thePlayer], root, false )
		setTimer(destroyElement, 60000, 1, myBlip[thePlayer])
			
		local players2 = getPlayersInTeam(getTeamFromName ( "Policia" ))
		for i,players in pairs(players2) do
				triggerClientEvent(players, "bgo>info", players,"Negociação de droga", "Possivel negociação de droga na região " .. location .. " " .. city.." ", "info")
				setElementVisibleTo ( myBlip[thePlayer], players, true )
		end
		
		local players2 = getPlayersInTeam(getTeamFromName ( "Admin" ))
		for i,players in pairs(players2) do
		setElementVisibleTo ( myBlip[thePlayer], players, true )
		triggerClientEvent(players, "bgo>info", players,"Negociação de droga!!", "Negociação de droga em " .. location .. " " .. city.." | ID: "..getElementData(thePlayer, "acc:id").." ", "info")
		end
end
addEvent("bgoMTA->#acionarpolicia", true)
addEventHandler("bgoMTA->#acionarpolicia", root, acionarpolicia)

]]--




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

