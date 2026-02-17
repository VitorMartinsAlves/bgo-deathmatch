----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/manage_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Manage Buttons
------------------>>

local manage_tab = {
	{"Trancar casa",		"Esta casa está desbloqueado. trancar?"},
	{"Transferir casa",	"Transfira esta casa para outra pessoa como um presente."},
}

for i,v in ipairs(manage_tab) do
	-- Buttons
	housingGUI.button[i+5] = guiCreateButton(3, 8+(35*(i-1)), 115, 20, v[1], false, housingGUI.scrollpane[1])
	-- Labels
	housingGUI.label[i+19] = guiCreateLabel(125, 0+(35*(i-1)), 222, 30, v[2], false, housingGUI.scrollpane[1])
	guiLabelSetHorizontalAlign(housingGUI.label[i+19], "left", true)
	guiLabelSetVerticalAlign(housingGUI.label[i+19], "center")
end

-- Transfer House
------------------>>
guiSetInputMode("no_binds_when_editing")

transferGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 227, 212
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 685, 353, 227, 212
transferGUI.window[1] = guiCreateWindow(685, 353, 227, 212, "Transfereir de casa", false)
guiWindowSetSizable(transferGUI.window[1], false)
guiSetAlpha(transferGUI.window[1], 1.00)
guiSetVisible(transferGUI.window[1], false)
-- Labels
transferGUI.label[1] = guiCreateLabel(12, 29, 202, 24, "Você está prestes a dar a esta casa para outra pessoa de forma gratuita. Certifique-se de que você quer fazer isso!", false, transferGUI.window[1])
guiSetFont(transferGUI.label[1], "default-small")
guiLabelSetHorizontalAlign(transferGUI.label[1], "center", true)
transferGUI.label[2] = guiCreateLabel(22, 65, 180, 15, "ID da conta para transferir:", false, transferGUI.window[1])
guiSetFont(transferGUI.label[2], "default-bold-small")
guiLabelSetColor(transferGUI.label[2], 15, 142, 242)
guiLabelSetHorizontalAlign(transferGUI.label[2], "center", false)
transferGUI.label[3] = guiCreateLabel(42, 112, 137, 15, "A senha da sua conta:", false, transferGUI.window[1])
guiSetFont(transferGUI.label[3], "default-bold-small")
guiLabelSetColor(transferGUI.label[3], 15, 142, 242)
guiLabelSetHorizontalAlign(transferGUI.label[3], "center", false)
-- Edits
transferGUI.edit[1] = guiCreateEdit(22, 82, 181, 21, "", false, transferGUI.window[1])	-- Transfer Acc Name
transferGUI.edit[2] = guiCreateEdit(21, 131, 181, 21, "", false, transferGUI.window[1])	-- Acc Password
guiEditSetMasked(transferGUI.edit[2], true)
-- Buttons
transferGUI.button[1] = guiCreateButton(31, 162, 76, 23, "Transferir (1)", false, transferGUI.window[1])
transferGUI.button[2] = guiCreateButton(114, 162, 76, 23, "Cancelar", false, transferGUI.window[1])


