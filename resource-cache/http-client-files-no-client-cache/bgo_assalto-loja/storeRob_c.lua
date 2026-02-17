local theRobbery = false
local robCashRegister = false
local robberyStarted = false
local hasBag = false
local cancelRobb = false
local intLeave = false
local saiuzona = false
local screenSize = Vector2(guiGetScreenSize())

local webBrowser
addEventHandler("onClientResourceStart", resourceRoot, 
function()
	webBrowser = createBrowser(screenSize, true, true)
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
	loadBrowserURL(webBrowser, "http://mta/local/hacking/hack.html")
	end
	)	
end
)

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx2,sy2 = (screenW/resW), (screenH/resH)

function createLogin ()
if not getElementData (localPlayer, "loggedin") then return end
	dxDrawImage(0,0, screenW,screenH, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
end

addEvent ("bgo>assaltoinfo",true)
addEventHandler ("bgo>assaltoinfo",getRootElement(),
	function (clase)
	if clase == "sucesso" then
        if (not robberyStarted) then
		triggerServerEvent ("bgo>>RouboTempo", localPlayer, localPlayer )
	end
	elseif clase == "erro" then
		setElementFrozen(localPlayer, false)
		setElementData(localPlayer, "Exercicio", false)
		showCursor(false)
		exports.bgo_hud:drawStat("storeRobTimer", "", "", 200, 0, 0)
	end
	end
)


function execute(eval)
  executeBrowserJavascript(webBrowser, eval)
end

function rouboiniciadosucesso ()
		triggerServerEvent ("GTIstoreRob_WantedLevel", localPlayer )
		theRobbery = true
		isDX = true
		setTimer(function() isDX = false end, 10000, 1)
		robberyStarted = true
		setElementData(localPlayer, "isPlayerRobbing", true)
		cancelRobb = true
		intLeave = true
		seconds = 120
		countDown = setTimer ( cDown, 1000, 120 )
		showCursor(false)
		setElementFrozen(localPlayer, true)
		--bindKey ( "N", "down", cancelRobbery2 )
		--exports.bgo_hud:dm("Pressione 'N' para cancelar o assalto!", 200, 0, 0 )
		--triggerEvent("bgo>info", localPlayer,"Importante!", "Caso a policia chegar rapido de mais, Pressione 'N' para cancelar o assalto! ", "info")
end
addEvent ("bgo>IniciandoRoubo", true )
addEventHandler ("bgo>IniciandoRoubo", root,rouboiniciadosucesso)



function infotempo ()
	showCursor(false)
	setElementFrozen(localPlayer, false)
	setElementData(localPlayer, "Exercicio", false)
end
addEvent ("bgo>informartempo", true )
addEventHandler ("bgo>informartempo", root,infotempo)

local ass = createBlip(1349.9395751953,-1765.5631103516,13.549824714661, 58)
setElementData(ass ,"blipName", "Assalto a lojinha LS")
local ass2 = createBlip(2550.6032714844,1975.5737304688,10.821425437927, 58)
setElementData(ass2 ,"blipName", "Assalto a lojinha LV")

function secsToMin(seconds)
        local hours = 0
        local minutes = 0
        local secs = 0
        local theseconds = seconds
        if theseconds >= 60*60 then
            hours = math.floor(theseconds / (60*60))
            theseconds = theseconds - ((60*60)*hours)
        end
        if theseconds >= 60 then
            minutes = math.floor(theseconds / (60))
            theseconds = theseconds - ((60)*minutes)
        end
        if theseconds >= 1 then
            secs = theseconds
        end 
        if minutes < 10 then
            minutes = "0"..minutes
        end
        if secs < 10 then
            secs = "0"..secs
        end
    return minutes,secs
end


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

local teste1 = createColSphere(1348.8229980469,-1761.3900146484,13.549824714661,1.5)
local teste2 = createColSphere(2549.6899414063,1974.2779541016,10.821425437927,1.5)
function detectAim( target )
    if getPlayerTeam(localPlayer) == getTeamFromName("Policia") then return end	
	

		if isElementWithinColShape(localPlayer, teste1) then
		
        local pedSlot = getPedWeaponSlot ( localPlayer )
        if (pedSlot == 0) then triggerEvent("bgo>info", localPlayer,"Informação!", "Você precisa de pelo menos um pistola em mãos para assaltar!", "info") return end
        local arma = getPedWeapon ( localPlayer )
        if (arma == 22)	then return end
		triggerServerEvent ("bgo>>PoliciaisVivos", localPlayer, localPlayer )

		
		elseif isElementWithinColShape(localPlayer, teste2) then

        local pedSlot = getPedWeaponSlot ( localPlayer )
        if (pedSlot == 0) then triggerEvent("bgo>info", localPlayer,"Informação!", "Você precisa de pelo menos um pistola em mãos para assaltar!", "info") return end
        local arma = getPedWeapon ( localPlayer )
        if (arma == 22)	then return end
		triggerServerEvent ("bgo>>PoliciaisVivos", localPlayer, localPlayer )

    end
end
addCommandHandler("roubar", detectAim)



addEvent ("bgo>VivosConfirma", true )
addEventHandler ("bgo>VivosConfirma", root,
    function ()
		for _, player in ipairs(getElementsByType("player")) do
		if isElementWithinColShape(player, teste2) then
		if ( getElementHealth ( player ) < 20 ) then
		triggerEvent("bgo>info", localPlayer,"Informação!", "Não podem assaltar lojinha com pessoas morta ou desanimada no local!", "info")
		return
		end
		end
		break
		end
		
        local pedSlot = getPedWeaponSlot ( localPlayer )
        if (pedSlot == 0) then triggerEvent("bgo>info", localPlayer,"Informação!", "Você precisa de pelo menos um pistola em mãos para assaltar!", "info") return end
        local arma = getPedWeapon ( localPlayer )
        if (arma == 22)	then return end
		painel = true
		removeEventHandler("onClientRender", root, createLogin)
		addEventHandler("onClientRender",  root, createLogin) 
        exports.bgo_hud:drawStat("storeRobTimer", "", "", 200, 0, 0)
		exports.bgo_hud:drawStat("storeRobTimer2", "", "", 200, 0, 0)
		--setElementPosition(localPlayer,2549.7722167969,1973.8732910156,10.821425437927)
		setElementRotation(localPlayer, 0,0, 1.8907668590546)
		setElementFrozen(localPlayer, true)
		setElementData(localPlayer, "Exercicio", true)
		showCursor(true)
		execute("startGame(3, 60)")
		focusBrowser(webBrowser)
		triggerEvent("bgo>info", localPlayer,"Tutorial", "Espaço confirma o Esquerdo, Enter confirma o Direito", "info")
		triggerEvent("bgo>info", localPlayer,"Tutorial", "W A S D para mover o esquerdo, ← → ↑ ↓ para mover o direito ( tem que fazer os 2 )", "info")
	end
)





function cDown ( )
    seconds = seconds - 1
    local mins,secds = secsToMin(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer( countDown )
        createMoneyBag()
        setElementData(localPlayer, "isPlayerRobbing", false)
        exports.bgo_hud:drawStat("storeRobTimer", "", "", 200, 0, 0)
		--exports.bgo_hud:drawStat("storeRobTimer2", "", "", 200, 0, 0)
		setElementData(localPlayer, "Exercicio", false)
		showCursor(false)
    else
        exports.bgo_hud:drawStat("storeRobTimer", "Tempo restante: ", mins..":"..secds, 200, 0, 0)
    end
end

function cDown2 ( )
    seconds2 = seconds2 - 1
    local mins,secds = secsToMin(seconds2)
    if mins == "00" and secds == "00" then --time is up

	if ( not isTimer(payTimer) )then
	killTimer( countDown2 )
	payTimer = setTimer(function()
	if (getElementInterior(localPlayer) ~= 0) or (getElementDimension(localPlayer) ~= 0) then return end
        if ( robberyStarted == false ) then return end
		if ( hasBag == false ) then return end
		exports.bgo_hud:drawStat("storeRobTimer2", "", "", 200, 0, 0)
        triggerServerEvent ("GTIstoreRob_payoutForSafe", localPlayer )
        c = setTimer ( isRobberyFalseAgain, 3600000, 1 )
		saiuzona = false
	   -- destroyElement ( colshape )
	   -- destroyElement ( leaveAreaRadar )
		end, 500, 1 )
	end
    else
        exports.bgo_hud:drawStat("storeRobTimer2", "Tempo restante para fugir: ", mins..":"..secds, 200, 0, 0)
    end
end



function createMoneyBag ( )
    triggerServerEvent ("GTIstoreRob_moneyBag", localPlayer )
	--x, y, z = getElementPosition ( localPlayer )
    --colshape = createColCuboid ( x-200, y-200, z-50, 400, 400, 100 )
    --exports.bgo_hud:dm("Assalto com sucesso saia da zona verde que apareceu no radar para receber o dinheiro!", 200, 0, 0)
    --leaveAreaRadar = createRadarArea ( x-200, y-200, 400, 450, 0, 200, 0, 150 )
    --addEventHandler ("onClientColShapeLeave", colshape, payoutForSafe )
	hasBag = true
	setElementFrozen(localPlayer, false)
	unbindKey ( "N", "down", cancelRobbery2 )	
	triggerEvent("bgo>info", localPlayer,"Sucesso!", "Você conseguiu pegar o dinheiro!", "sucesso")
	triggerEvent("bgo>info", localPlayer,"Importante!", "Você precisa fugir por 2 minutos, dentro desse tempo os policiais saberão onde você está!", "info")
	seconds2 = 300
	saiuzona = true
    countDown2 = setTimer ( cDown2, 1000, 300 )
end

function payoutForSafe ( player )
	if ( player == localPlayer ) and not isTimer(payTimer) then
	payTimer = setTimer(function()
	if (getElementInterior(localPlayer) ~= 0) or (getElementDimension(localPlayer) ~= 0) then return end
        if ( robberyStarted == false ) then return end
		if ( hasBag == false ) then return end
        triggerServerEvent ("GTIstoreRob_payoutForSafe", localPlayer )
        c = setTimer ( isRobberyFalseAgain, 3600000, 1 )
	    destroyElement ( colshape )
	    destroyElement ( leaveAreaRadar )
		end, 500, 1 )
	end
end

function cancelRobbery2 ( jobName )
    if ( intLeave == false ) then return end
    if ( robberyStarted == false) then return end
	if ( theRobbery == false ) then return end
	    triggerServerEvent ("GTIstoreRob_stopMission", localPlayer )
        unbindKey ( "N", "down", cancelRobbery2 )
        exports.bgo_hud:drawStat("storeRobTimer", "", "", 200, 0, 0)
		exports.bgo_hud:drawStat("storeRobTimer2", "", "", 200, 0, 0)
        exports.bgo_hud:drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
        if (not recieved[localPlayer]) then
            exports.bgo_hud:dm("Você falhou no assalto!", 200, 0, 0)
            recieved[localPlayer] = true
        end   
        robCashRegister = true
        theRobbery = false
		hasBag = false
		setElementFrozen(localPlayer, false)
		setElementData(localPlayer, "Exercicio", false)
		if isElement ( colshape ) then destroyElement ( colshape ) end
	    if isElement ( leaveAreaRadar ) then destroyElement ( leaveAreaRadar ) end
        setElementData(localPlayer, "isPlayerRobbing", false)
        if isTimer ( countDown ) then killTimer ( countDown ) end
		if isTimer ( countDown2 ) then killTimer ( countDown2 ) end
        if isTimer ( timer ) then killTimer ( timer ) end
		if isTimer ( c ) then killTimer ( c ) end
        c = setTimer ( isRobberyFalseAgain, 3600000, 1 )
end

local recieved = {}
function cancelRobbery ( jobName )
    if ( source == localPlayer ) then
    if ( intLeave == false ) then return end
    if ( robberyStarted == false) then return end
	if ( theRobbery == false ) then return end
	    triggerServerEvent ("GTIstoreRob_stopMission", localPlayer )
        unbindKey ( "N", "down", cancelRobbery2 )
        exports.bgo_hud:drawStat("storeRobTimer", "", "", 200, 0, 0)
		exports.bgo_hud:drawStat("storeRobTimer2", "", "", 200, 0, 0)
        exports.bgo_hud:drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
        if (not recieved[localPlayer]) then
            exports.bgo_hud:dm("Você falhou no assalto!", 200, 0, 0)
            recieved[localPlayer] = true
        end   
        robCashRegister = true
        theRobbery = false
		hasBag = false
		if isElement ( colshape ) then destroyElement ( colshape ) end
	    if isElement ( leaveAreaRadar ) then destroyElement ( leaveAreaRadar ) end
        setElementData(localPlayer, "isPlayerRobbing", false)
        if isTimer ( countDown ) then killTimer ( countDown ) end
		if isTimer ( countDown2 ) then killTimer ( countDown2 ) end
        if isTimer ( timer ) then killTimer ( timer ) end
		if isTimer ( c ) then killTimer ( c ) end
        c = setTimer ( isRobberyFalseAgain, 3600000, 1 )
    end
end

addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName )
    if not jobName then 
        return true
    else
        return cancelRobbery ( )
    end
end
)

addEventHandler ("onClientPlayerGetJob", root, 
function ( jobName ) 
    if jobName == "Criminal" then
        return true
    else
        return cancelRobbery ( )
    end
end

)

addEventHandler ("onClientPlayerWasted", localPlayer,
    function ( )
        cancelRobbery(localPlayer)
    end

)


addEvent ("GTIstoreRob_CancelOnArrest", true )
addEventHandler ("GTIstoreRob_CancelOnArrest", root,
    function ()
        cancelRobbery()
	end
)

function robberyCancelOnMarkerHit ( player )
    if ( player == localPlayer ) then
    if ( intLeave == false ) then return end
	if ( hasBag == true ) then return end
        exports.bgo_hud:drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
		if ( cancelRobb == false ) then return end
		if ( robberyStarted == false) then return end
        exports.bgo_hud:drawStat("storeRobTimer", "", "", 200, 0, 0)
		exports.bgo_hud:drawStat("storeRobTimer2", "", "", 200, 0, 0)
        if (not recieved[localPlayer]) then
            exports.bgo_hud:dm("Você falhou no assalto!", 200, 0, 0)
            recieved[localPlayer] = true
        end
        setElementData(localPlayer, "isPlayerRobbing", false)
		unbindKey ( "N", "down", cancelRobbery2 )
        theRobbery = false
        cancelRobb = false
		hasBag = false
		robCashRegister = true
		triggerServerEvent ("GTIstoreRob_stopMission", localPlayer )
		if isElement ( colshape ) then destroyElement ( colshape ) end
	    if isElement ( leaveAreaRadar ) then destroyElement ( leaveAreaRadar ) end
        if isTimer ( countDown ) then killTimer ( countDown ) end
        if isTimer ( timer ) then killTimer ( timer ) end
		if isTimer ( c ) then killTimer ( c ) end
        c = setTimer ( isRobberyFalseAgain, 3600000, 1 )
    end
end


function isRobberyFalseAgain ( )
    robberyStarted = false
    robCashRegister = false
    theRobbery = false
    cancelRobb = false
    intLeave = false
	hasBag = false
    if isTimer ( timer ) then killTimer ( timer ) end
	if isTimer ( c ) then killTimer ( c ) end
end