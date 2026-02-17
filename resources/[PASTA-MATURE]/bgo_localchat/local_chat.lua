--[[
chat_range=100
 
addEventHandler("onPlayerJoin",getRootElement(),
function ()
bindKey(source,"u","down","chatbox","Local")
end)
 
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
function ()
for index, player in pairs(getElementsByType("player")) do
bindKey(player,"u","down","chatbox","Local")
  end
end)
 
function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
 
function onChat(player,_,...)
  local px,py,pz=getElementPosition(player)
  local msg = table.concat({...}, " ")
  local nick=getPlayerName(player)


  for _,v in ipairs(getElementsByType("player")) do
local accountname = getAccountName(getPlayerAccount(player))
    if player ~= _ then

    if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then
      outputChatBox("(Local) "..nick..": "..msg,v,r,g,b,true)
    end
   end
  end
end
addCommandHandler("Local",onChat)
 

]]--

local tempo = { }

function sendMessage (message)
	sendOptions = {
          queueName = "dcq",
          connectionAttempts = 3,
          connectTimeout = 500,
          formFields = {
               content="__**"..message.."**__"
          },
     }
	fetchRemote ('https://discord.com/api/webhooks/819478233002278965/2Pzd1daLYop2-CdFLgRCxA4daGZ9BsvuluddJpFKiuSGwPlXQ0rCX6sruAntdWE88q2Z', sendOptions, callback )
end

function callback()
end

function localChat(player, _, ...)
if getElementData(player, "loggedin") then
	if (isPlayerMuted(player)) then
		outputChatBox("Você Esta Mutado!!", player, 255, 0, 0)
		return
	end
	
	if (isTimer(tempo[player])) then
		outputChatBox("Aguarde 5 segundos!", player, 255, 0, 0)
		return
	end
	tempo[player] = setTimer(function() end, 5000, 1)
	
	
	local message = table.concat({...}, " ")
	if (not message) then return end
	message = message:gsub("#%x%x%x%x%x%x", "")
	if (message == "") then return end
	local r, g, b = getPlayerNametagColor(player)
	local hex = getHexFromRGB(r, g, b)
	local posX, posY, posZ = getElementPosition(player)
	local recipients = {}
	--exports.btc_chat:sendLocalMeAction(player, message)
	triggerClientEvent("onMessageIncome",player,message,2)
	for index, player2 in pairs(getElementsByType("player")) do
		local posX2, posY2, posZ2 = getElementPosition(player2)
		if (--[[player ~= player2 and ]]getDistanceBetweenPoints3D(posX, posY, posZ, posX2, posY2, posZ2)) <= 10 then
		--if getElementData(player2,"char:id") == 1 then 
		--	teste = tonumber(player2-1)
		--	else
		--	teste = tonumber(player2)
		--	end
			table.insert(recipients, player2)
	end
end

	sendMessage ('[CHAT LOCAL] '..getPlayerName(player)..' '..message)
	for index, player2 in pairs(recipients) do
		--if getElementData(player2,"char:id") == 1 then 
		--teste = tonumber(index-1)
		--else
		--teste = tonumber(index)
		--end
		--#FFFFFF("..teste..")
		outputChatBox("#7cc576[CHAT LOCAL BGO]: #7cc576"..getPlayerName(player)..": #FFFFFF"..message, player2, r or 255, g or 255, b or 255, true)
		
		--end
	--	exports.btc_admin:outputAdminMessage("#02CEFC[CHAT][LOCAL] #FFFFFF"..getPlayerName(player).." #FFFFFFfalou: #02CEFC"..message)
	--	return
	end

end
end
addCommandHandler("localc", localChat)


function getHexFromRGB(r, g, b)
	return ("#%02X%02X%02X"):format(r, g, b)
end

function bindLocalChat()
	bindKey(source, "u", "down", "chatbox", "localc")
end
addEventHandler("onPlayerJoin", root, bindLocalChat)

function bindLocalChatForAll()
	for index, player in pairs(getElementsByType("player")) do
		bindKey(player, "u", "down", "chatbox", "localc")
	end
end
addEventHandler("onResourceStart", resourceRoot, bindLocalChatForAll)











--[[

function onGroupChat(player,_,...)
	local group = getElementData(player, "gang")
	if group then
			local msg = table.concat({...}, " ")
			local nick=getPlayerName(player)
			r,g,b = 255, 255, 255
			for _,v in ipairs(getElementsByType("player")) do
				if isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(v)),aclGetGroup("Console")) and getElementData(v ,"gang") ~= group then 
					outputChatBox(" ", v, 255, 255, 255, true)
					outputChatBox("#00FF82Stalkeador: #ccccccFacção #FFFFFF("..group..") - #FF00FF"..nick.." : #FFFF00"..msg, v, 255, 255, 255, true)
					outputChatBox(" ", v, 255, 255, 255, true)
				end
			end
		end
end
addCommandHandler("GroupChat",onGroupChat)]]--



