function checkForConsole()
	if isConsoleActive() then
		setElementData(getLocalPlayer(), "consoleTyping", true)	
	elseif not isConsoleActive() then
		setElementData(getLocalPlayer(), "consoleTyping", false)
	end
end
setTimer ( checkForConsole, 100, 0 )





addEventHandler ("onClientKey", getRootElement(), function (button, state)
	if not state then return end
	if not getElementData (localPlayer, "bindPermission") then
		local keys = getBoundKeys ("lixao") -- Obtém uma lista com todas as teclas com binds deste comando.
		if keys then
			for keyName, keyState in pairs (keys) do
				if button == keyName then
					outputChatBox ("Tecla bloqueada: "..keyName, 255, 0, 0)
					cancelEvent ()
					break
				end
			end
		end
	end
end)