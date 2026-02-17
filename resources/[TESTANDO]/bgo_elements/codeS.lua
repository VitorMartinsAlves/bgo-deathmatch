local developers = {}

addEventHandler("onResourceStart", resourceRoot,
    function()
        for k,v in pairs(getElementsByType("player")) do
            local adminlevel = getElementData(v, "acc:admin") or 0
            if adminlevel >= 8 then
                developers[v] = true
            end
        end
    end
)

addEventHandler("onElementDataChange", root,
    function(dName, oValue)
        if getElementType(source) == "player" then
            if dName == "acc:admin" then
                local value = getElementData(source, dName)
                if value >= 8 then
                    developers[source] = true
                end
            end
        end
    end
)

addEventHandler("onPlayerQuit", root,
    function()
        if developers[source] then
            developers[source] = nil
        end
    end
)

local specialElementData = {
    --["dbid"] = true,
   -- ["acc:admin"] = true,
    --["playerid"] = true,
	
	["VoiceCor"] = true,
	
   -- ["char:pp"] = true,
	--["char:money"] = true,
	--["char:bankmoney"] = true,	
}



addCommandHandler("logs",
    function(source, cmd)
        if source and cmd then
            local adminlevel = getElementData(source, "acc:admin") or 0
            if adminlevel >= 8 then
                local notifications = getElementData(source, "notifications")
                setElementData(source, "notifications", not notifications)
                
                local notifications = getElementData(source, "notifications")
                if notifications then
                    outputChatBox("#3D7ABC[BGO]: #ffffffVocê ativou com sucesso as notificações!", source, 255,255,255, true)
                else
                    outputChatBox("#3D7ABC[BGO]: #ffffffVocê desativou com sucesso as notificações!", source, 255,255,255, true)
                end
            end
        end
    end
)

function sendMessageToDev(text)
    for v,k in pairs(developers) do
        local enabledNotifications = getElementData(v, "notifications")
        if enabledNotifications then
            outputChatBox(text, v, 255,255,255, true)
        end
    end
end


function outputChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") then -- check if the element is a player
	  if specialElementData[theKey] then
	local name2 = getPlayerName(source) or "Desconhecido"
        sendMessageToDev("Elemento alterados do"..name2.." '" .. tostring(theKey) .. "' has changed from '" .. tostring(oldValue) .. "' to '" .. tostring(newValue) .. "'")
        outputDebugString("Elemento alterados do "..name2.." '" .. tostring(theKey) .. "' has changed from '" .. tostring(oldValue) .. "' to '" .. tostring(newValue) .. "'",0,244,149,65)
 end
 end
end
addEventHandler("onElementDataChange", root, outputChange)
