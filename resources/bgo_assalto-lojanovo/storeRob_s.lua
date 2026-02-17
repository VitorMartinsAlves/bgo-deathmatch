----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: storeRob_s.lua
-- Version: 1.0
----------------------------------------->>

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

local bags = {}

addEvent ("GTIstoreRob_setPedAnim", true )
addEventHandler ("GTIstoreRob_setPedAnim", root, 
    function ( )
        exports.bgo_anims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
)

addEvent ("GTIstoreRob_payoutForSafe", true )
addEventHandler ("GTIstoreRob_payoutForSafe", root,
    function ( )
        pay = math.random(30000, 50000) --math.random(3925*LOWER_BOUND, 3925*UPPER_BOUND)
		name = getPlayerName ( client )
        --givePlayerMoney(client, pay)
        --setElementData(client, "char:money", getElementData(client, "char:money") + pay)
        setElementData(client, "char:moneysujo", (getElementData(client,"char:moneysujo") or 0) + pay)

	triggerClientEvent(client, "onClientPlayerGiveMoney", client, pay)
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)

addEvent ("GTIstoreRob_moneyBag", true )
addEventHandler ("GTIstoreRob_moneyBag", root, 
    function ( )
        bags[client] = createObject ( 1550, 2168.279, 1099.348, 0, -90, 0, 0, true )
        setElementDoubleSided ( bags[client], true )
        exports.bone_attach:attachElementToBone(bags[client],client,2,0,-0.25,-0.2,20,0,0)
    end
)

addEvent ("GTIstoreRob_payOutForCashRegister", true )
addEventHandler ("GTIstoreRob_payOutForCashRegister", root,
    function ( player )
        moneyfor = math.random ( 200, 400 )
        --givePlayerMoney(client, moneyfor)
		setElementData(client, "char:money", getElementData(client, "char:money") + moneyfor)
	triggerClientEvent(client, "onClientPlayerGiveMoney", client, moneyfor)
    end
)

local isPlayerNotAllowedToRob = {}
local myBlip = {}

addEvent ("GTIstoreRob_WantedLevel", true )
addEventHandler ("GTIstoreRob_WantedLevel", root,
    function ( )
		   	local x, y, z = getElementPosition ( client )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )
			
       --exports.bgo_policeWanted:chargePlayer ( client, 24 )
	   --[[
	   			local x, y, z = getElementPosition ( client )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )
			for _, players in ipairs(getElementsByType("player")) do
			exports.bgo_hud:drawNote("assalto" .. location .. "", "[Denuncia Anônima]: Esta tendo um assalto no bairro " .. location .. " " .. city, players, 255, 255, 255, 20000)
			end
			]]--
			
	for _, players in ipairs(getElementsByType("player")) do		
		if getPlayerTeam(players) == getTeamFromName("Policia")  then
			triggerClientEvent(players, "TESTE22", players, "Assalto a lojinha iniciado!")
			triggerClientEvent(players, "bgo>info", players,"Assalto à loja!", "Um assalto a loja foi iniciado no bairro " .. location .. " " .. city.." ", "info")
			myBlip[client] = createBlipAttachedTo (client, 1 )
			setElementData(myBlip[client] ,"blipName", "Assalto a lojinha em andamento!")
			setBlipColor ( myBlip[client], 255, 0, 0, 255 )
			setBlipSize ( myBlip[client], 2 )
			setElementVisibleTo ( myBlip[client], root, false )
			setTimer(destroyElement, 60000, 1, myBlip[client])
			setElementVisibleTo ( myBlip[client], players, true )
			end
			
		if tonumber(getElementData(players, "acc:admin") or 0) >= 1 then
			setElementVisibleTo ( myBlip[client], players, true )
			triggerClientEvent(players, "TESTE22", players, "Assalto a lojinha iniciado!")
			triggerClientEvent(players, "bgo>info", players,"Assalto à loja!", "Assalto em " .. location .. " " .. city.." | ID: "..getElementData(client, "acc:id").." ", "info")
		end
		
		
	end
			
			
	   --	local wantedLvl = getPlayerWantedLevel ( client )
		--setPlayerWantedLevel ( client, wantedLvl + 3 )
		
        local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = false
        end, 360000, 1, serial)
    end
)

function onArrestCancelTheRob()
    triggerClientEvent ( source, "GTIstoreRob_CancelOnArrest", source )
end
addEventHandler ("onPlayerArrested", root, onArrestCancelTheRob)
addEventHandler ("onPlayerJailed", root, onArrestCancelTheRob)

addEvent ("GTIstoreRob_stopMission", true )
addEventHandler ("GTIstoreRob_stopMission", root,
    function()
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)

function onPlayerQuit ( )
    if ( bags[source] and isElement ( bags[source] ) ) then
        destroyElement (bags[source] )
        bags [source] = nil
    end
end
addEventHandler ("onPlayerQuit",root,onPlayerQuit )
