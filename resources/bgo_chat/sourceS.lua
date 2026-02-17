

counter = {}
ptimer = {}


local flood = { }
local flood2 = 0

function chatMain(message, messageType)					
	local logged = getElementData(source, "loggedin")
	if not (isPedDead(source)) and (logged) and not (messageType==2) then 
	if isTimer(flood[source]) then outputChatBox("Aguarde 5 segundos para usar este comando novamente",source,255,255,255,true) return end

	if (messageType==1) then 
	meEmote(source, "me", message)
	
	--exports.bgo_discordlogs:sendDiscordMessage(1, false, "`[COMANDO /ME]: "..getPlayerName(source).." Utilizou o /me com a mensagem: "..message:gsub("#%x%x%x%x%x%x", "").."`")
	
	flood[source] = setTimer(function() flood = {} end, 5000, 1)
	end
	cancelEvent()
	end
end
addEventHandler("onPlayerChat", getRootElement(), chatMain)

function blockChatMessage()
	cancelEvent()
end
addEventHandler("onPlayerChat", getRootElement(), blockChatMessage)

function meEmote(source, cmd, ...)
	local logged = getElementData(source, "loggedin")
	if not(isPedDead(source) and (logged)) then
		local message = table.concat({...}, " ")
		if not (...) then
			outputChatBox("#7cc576Használat:#ffffff /me [atividade]", source, 255, 255, 255, true)
		else
			sendLocalMeAction(source, message)

		end
	end
end


function sendLocalMeAction(thePlayer, message)
	if getPlayerName(thePlayer) then 
		sendLocalText(thePlayer, " ***" .. ( message:sub( 1, 1 ) == "'" and "" or " " ) .. message, 194, 162, 218)
		triggerClientEvent("onMessageIncome",thePlayer,"***"..message,2)		
	end
end
addEvent("sendLocalMeAction",true)
addEventHandler("sendLocalMeAction",getRootElement(),sendLocalMeAction)


local showtime = 3000
local characteraddition = 50
local maxbubbles = 3
if maxbubbles == "false" then maxbubbles = false else maxbubbles = 3 end
local hideown = "true"
if hideown == "true" then hideown = true else hideown = false end



function returnSettings()
	local settings =
	{
	showtime,
	characteraddition,
	maxbubbles,
	hideown
	}
	triggerClientEvent(source,"onBubbleSettingsReturn",getRootElement(),settings)
end


addEvent("onAskForBubbleSettings",true)
addEventHandler("onAskForBubbleSettings",getRootElement(),returnSettings)








function OOC(thePlayer, commandName, ...)		
			
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
	
	if exports.bgo_admin:isPlayerDuty(thePlayer) then
	if (logged==true) and not (isPedDead(thePlayer)) then
		if not (...) then
		outputChatBox("#7cc576[Errado]:#ffffff /" .. commandName .. " [mensagem]", thePlayer, 255,0,0, true)
		else
			local message = table.concat({...}, " ")
			local x, y, z = getElementPosition(thePlayer)

			for index, nearbyPlayer in ipairs(getElementsByType("player")) do
						triggerClientEvent(nearbyPlayer, "onOOCMessageSend", nearbyPlayer, " "..getPlayerName(thePlayer) .. ": " .. table.concat({...}, " ") .. "", 0,nearbyPlayer)	
				end
			end
		end
		else
		outputChatBox("#7cc576[Errado]:#ffffffVocê não é policial para usar este comando, precisa estar fardado para usar o comando!", thePlayer, 255,0,0, true)
		end
end
--addCommandHandler("b", OOC, false, false)
addCommandHandler("copom", OOC)






function sendLocalText(root, message, r, g, b, distance, exclude)
	exclude = exclude or {}
	local x, y, z = getElementPosition(root)
		
	local shownto = 0
	for index, nearbyPlayer in ipairs(getElementsByType("player")) do
		if isElement(nearbyPlayer) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyPlayer)) < ( distance or 20 ) then
			local logged = getElementData(nearbyPlayer, "loggedin")
			if not exclude[nearbyPlayer] and not isPedDead(nearbyPlayer) and logged and getElementDimension(root) == getElementDimension(nearbyPlayer) then
				outputChatBox(message, nearbyPlayer, r, g, b,true)
				shownto = shownto + 1
			end
		end
	end
end
addEvent("sendLocalText", true)
addEventHandler("sendLocalText", getRootElement(), sendLocalText) --



function sendLocalDoAction(thePlayer, message) -- DO Export
	--sendLocalText(thePlayer, " * " .. message .. " * ((" .. getPlayerName(thePlayer):gsub("_", " ") .. "))", 255, 51, 102)
	sendLocalText(thePlayer, " * " .. message .. "", 255, 51, 102)
end


