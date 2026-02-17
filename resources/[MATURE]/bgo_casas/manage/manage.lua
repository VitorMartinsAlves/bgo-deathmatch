----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 24 Dec 2014
-- Resource: GTIhousing/manage.lua
-- Version: 1.0
----------------------------------------->>

-- Toggle Manage Function
-------------------------->>

addEventHandler("onClientGUIClick", housingGUI.scrollpane[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	if (source == housingGUI.button[6]) then
		triggerServerEvent("GTIhousing.toggleLockState", resourceRoot, getHouseID())
		guiSetEnabled(housingGUI.button[6], false)
		setTimer(guiSetEnabled, 1000, 1, housingGUI.button[6], true)
	return end
	
	if (source == housingGUI.button[7]) then
		guiSetText(transferGUI.button[1], "Transferir (1)")
		guiBringToFront(transferGUI.window[1])
		guiSetVisible(transferGUI.window[1], true)
	return end
end)

-- Update Lock State
--------------------->>

addEvent("GTIhousing.updateLockState", true)
addEventHandler("GTIhousing.updateLockState", root, function(locked)
	if (locked) then
		guiSetText(housingGUI.button[6], "Desbloquear Casa")
		guiSetText(housingGUI.label[20], "Esta casa está bloqueada. Desbloquear??")
	else
		guiSetText(housingGUI.button[6], "Trancar Casa")
		guiSetText(housingGUI.label[20], "Esta casa está desbloqueada. Bloquear?")
	end
end)

-- Transfer House
------------------>>

addEventHandler("onClientGUIClick", transferGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(transferGUI.window[1], false)
end, false)

function openTransferHousePanel(button, state, cont)
	if (button ~= "left" or state ~= "up") then return end
	
	local account = guiGetText(transferGUI.edit[1])
	local password = guiGetText(transferGUI.edit[2])
	if (#account == 0) then
		exports.bgo_hud:dm("Digite o nome da conta da pessoa que você deseja transferir esta casa.", client, 255, 125, 0)
		return
	end
	if (#password == 0) then
		exports.bgo_hud:dm("Digite a senha da conta.", client, 255, 125, 0)
		return
	end
	
	if (guiGetText(transferGUI.button[1]) == "Transferir (1)") then
		guiSetText(transferGUI.button[1], "Transferir")
	else	
		triggerServerEvent("GTIhousing.transferHouse", resourceRoot, getHouseID(), account, password)
	end
end
addEventHandler("onClientGUIClick", transferGUI.button[1], openTransferHousePanel, false)
