local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25
local bags = {}
local atmCooldown = {}
local atmSerial = {}


addEvent ("GTIstoreRob_setPedAnim", true )
addEventHandler ("GTIstoreRob_setPedAnim", root, 
    function ( )
        exports.bgo_anims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
)

addEvent ("GTIstoreRob_payoutForSafe", true )
addEventHandler ("GTIstoreRob_payoutForSafe", root,
    function ( )
        pay = math.random(30000, 50000)
		--name = getPlayerName ( client )
       -- setElementData(client, "char:moneysujo", (getElementData(client,"char:moneysujo") or 0) + pay)
		--triggerClientEvent(client, "onClientPlayerGiveMoney", client, pay)
		
		
		if exports.bgo_items:giveItem(client, 230, 1, pay, 0, true) then 
        local linha = math.random(1, 255 )
        exports.bgo_hud:drawNote("Sujo"..linha.."", "+ "..pay.." em blocos de dinheiro!", client, 255, 255, 255, 7000) 
		triggerClientEvent(client, "onClientPlayerGiveMoney", client, pay)
        end
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)

local myBlip = {}
addEvent ("GTIstoreRob_moneyBag", true )
addEventHandler ("GTIstoreRob_moneyBag", root, 
    function ( )
			bags[client] = createObject ( 1550, 2168.279, 1099.348, 0, -90, 0, 0, true )
			setElementDoubleSided ( bags[client], true )
			exports.bone_attach:attachElementToBone(bags[client],client,2,0,-0.25,-0.2,20,0,0)
			setPedAnimation(client)
			setElementFrozen(client, false)
			executeCommandHandler ( "stopanim", client )
			if isElement(myBlip[client]) then
			destroyElement( myBlip[client] )
			end
			myBlip[client] = createBlipAttachedTo (client, 1 )
			setElementData(myBlip[client] ,"blipName", "ASSALTANTE EM FUGA!")
			setBlipColor ( myBlip[client], 255, 255, 255, 255 )
			setBlipSize ( myBlip[client], 3 )
			setElementVisibleTo ( myBlip[client], root, false )
			setTimer(destroyElement, 300000, 1, myBlip[client])
			for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[client], v, true )
			end
		end
    end
)

addEvent ("GTIstoreRob_payOutForCashRegister", true )
addEventHandler ("GTIstoreRob_payOutForCashRegister", root,
    function ( player )
    moneyfor = math.random ( 200, 400 )
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
	for _, players in ipairs(getElementsByType("player")) do		
		if getPlayerTeam(players) == getTeamFromName("Policia")  then
			triggerClientEvent(players, "TESTE22", players, "Assalto a lojinha em andamento!")
			triggerClientEvent(players, "bgo>info", players,"Assalto à loja!", "Um assalto ao lojinha foi iniciado no bairro " .. location .. " " .. city.." ", "info")
			triggerClientEvent(players, "bgo>info", players,"Informação", "Marcado no BGO", "info")
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
			triggerClientEvent(players, "TESTE22", players, "Assalto a lojinha em andamento!")
			triggerClientEvent(players, "bgo>info", players,"Assalto à loja!", "Assalto em " .. location .. " " .. city.." | ID: "..getElementData(client, "acc:id").." ", "info")
		end
		
		
	end
		triggerClientEvent(client, "bgo>info", client,"Assalto à loja!", "Você iniciou o assalto! Os Policiais Foram acionados!", "sucesso")
		triggerClientEvent(client, "bgo>info", client,"Assalto à loja!", "Lembrando que essa ação só envolve Pistola!", "aviso")
		setPedAnimation(client, "rob_bank", "cat_safe_rob", -1, true, false, false, false)
		setElementData(client, "char:moneysujo", (getElementData(client,"char:moneysujo") or 0) + 1)
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
		triggerClientEvent(client, "bgo>info", client,"Assalto à loja!", "você falhou no assalto!", "erro")
		setElementData(client, "char:moneysujo", (getElementData(client,"char:moneysujo") or 0) - 1)
		setPedAnimation(client)
		setElementFrozen(client, false)
		executeCommandHandler ( "stopanim", client )
		setElementData(client, "Exercicio", false)
    end
)

function onPlayerQuit ( )
	if isElement(myBlip[source]) then
		destroyElement( myBlip[source] )
	end
    if ( bags[source] and isElement ( bags[source] ) ) then
        destroyElement (bags[source] )
        bags [source] = nil
    end
end
addEventHandler ("onPlayerQuit",root,onPlayerQuit )


playerMarker = createMarker(1348.9094238281,-1760.7908935547,13.549824714661 -0.9, "cylinder", 1, 10, 244, 23, 100)
playerMarker2 = createMarker(2549.7722167969,1973.8732910156,10.821425437927 -0.9, "cylinder", 1, 10, 244, 23, 100)

addEventHandler("onMarkerHit", playerMarker2, function(hitElement)
triggerClientEvent(hitElement, "bgo>info", hitElement, "Informação", "Mentalize /roubar para iniciar o roubo!", "aviso")
end)

addEventHandler("onMarkerHit", playerMarker, function(hitElement)
triggerClientEvent(hitElement, "bgo>info", hitElement, "Informação", "Mentalize /roubar para iniciar o roubo!", "aviso")
end)


local zone = createColCuboid(1322.72729, -1842.33203, 9.84693, 61.3876953125, 120.47265625, 24.300007247925)
local zone2 = createColCuboid(2497.87524, 1940.57178, 7.70745, 102.052734375, 110.89819335938, 38.800029182434)

function headShot(attacker, weapon, bodypart, loss)
if attacker then
if isElementWithinColShape(attacker, zone) or isElementWithinColShape(attacker, zone2) then
	if (bodypart == 9) then
			killPed(source, attacker, weapon, bodypart)
			end
		end
	end
end
addEventHandler("onPlayerDamage", getRootElement(), headShot)

addEvent ("bgo>>RouboTempo", true )
addEventHandler ("bgo>>RouboTempo", root, 
    function ( thePlayer )
		if ( atmIsAbleToRob2(thePlayer) ) then
				triggerClientEvent(thePlayer, "bgo>IniciandoRoubo", thePlayer)
			for _, player in ipairs(getElementsByType("player")) do
				atmSetTimeOut2(player, 1800000)
				end
			else
				drawNote('ATMRobbery', 'Você não pode roubar essa lojinha, você deve esperar '.. atmGetTimeOut2 ( thePlayer ) .. ' segundos', thePlayer, 255, 0, 0, 5000)
				triggerClientEvent(thePlayer, "bgo>informartempo", thePlayer)
			end
    end
)


addEvent ("bgo>>PoliciaisVivos", true )
addEventHandler ("bgo>>PoliciaisVivos", root, 
    function ( thePlayer )
	local policiaTeam = getTeamFromName ( "Policia" )
        local groveCount = #getAlivePlayersInTeam(policiaTeam) --countPlayersInTeam ( policiaTeam )
        if groveCount > 20 then
		triggerClientEvent(thePlayer, "bgo>VivosConfirma", thePlayer)
		else
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Informação", "Não tem policia na cidade ( minimo 20 policiais ), vaza daqui!", "erro")
		end
    end
)





function drawNote(id, text, player, r, g, b, time)
	exports.bgo_hud:drawNote(id, text, player, r, g, b, time)
end


function atmIsAbleToRob2 ( player )
	return not isTimer(atmCooldown[player])
end


function atmGetTimeOut2 ( player )
	if isTimer ( atmCooldown[player] ) then
		local miliseconds = getTimerDetails ( atmCooldown[player] )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end


function atmSetTimeOut2 ( player, time )
	atmCooldown[player] = setTimer( 
	function (player) 
	atmCooldown[player] = nil 
	end, time, 1, player)
end



addEventHandler("onPlayerQuit", root,
	function ()
		if ( atmGetTimeOut2(source) ) then
			atmSerial[getPlayerSerial(source)] = atmGetTimeOut2(source)
		end
	end
)


addEventHandler("onPlayerJoin", root,
	function ()
		for serial, cooldown in pairs ( atmSerial ) do
			if ( getPlayerSerial(source) == serial ) then
				atmSetTimeOut2(source, cooldown*1000)
				atmSerial[serial] = nil
			end
		end
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

