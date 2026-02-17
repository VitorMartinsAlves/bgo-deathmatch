dgs = exports.dgs

rentalGUI = {tab = {}, tabpanel = {}, label = {}, button = {}, window = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 492, 389
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 551, 242, 492, 389
--rentalGUI.window[1] = dgs:dgsCreateWindow(sX, sY, wX, wY, "BGO - VEICULOS", false)


rentalGUI.window[1] = dgs:dgsCreateWindow ( sX, sY-50, wX, wY, "BGO - VEICULOS", false, 0xFFFFFFFF, 25, nil, 0xC8141414, nil, 0x96141414, 5, true )



dgs:dgsWindowSetSizable(rentalGUI.window[1], false)
dgs:dgsSetAlpha(rentalGUI.window[1], 0.90)
-- Visibility
dgs:dgsSetVisible(rentalGUI.window[1], false)
-- Tab Panel
rentalGUI.tabpanel[1] = dgs:dgsCreateTabPanel(9, 0, 472, 359, false, rentalGUI.window[1])

-- Vehicles Tab
---------------->>

-- Tab
rentalGUI.tab[1] = dgs:dgsCreateTab("Veiculos", rentalGUI.tabpanel[1])
-- Gridlist
rentalGUI.gridlist[1] = dgs:dgsCreateGridList(23, 20, 210, 292, false, rentalGUI.tab[1])
dgs:dgsGridListAddColumn(rentalGUI.gridlist[1], "ID", 0.25)
dgs:dgsGridListAddColumn(rentalGUI.gridlist[1], "Veiculo", 0.4)
--dgs:dgsGridListAddColumn(rentalGUI.gridlist[1], "Preço", 0.25)
--dgs:dgsGridListSetSortingEnabled(rentalGUI.gridlist[1], false)
-- Label (Static)
rentalGUI.label[1] = dgs:dgsCreateLabel(250, 20, 202, 113, "Nota: aplicar o seguro terá \num custo de R$: 5.000 reais.", false, rentalGUI.tab[1])
dgs:dgsSetFont(rentalGUI.label[1], "default-bold-small")
dgs:dgsLabelSetHorizontalAlign(rentalGUI.label[1], "center", true)

-- Label (Dynamic)
rentalGUI.label[2] = dgs:dgsCreateLabel(251, 145, 199, 82, "Este veículo é restrito aos seguintes grupos:\nGrupo A, Grupo B, Grupo C", false, rentalGUI.tab[1])
dgs:dgsLabelSetHorizontalAlign(rentalGUI.label[2], "center", true)
-- Buttons


rentalGUI.button[5] = dgs:dgsCreateButton(250, 137, 201, 45, "Seguro", false, rentalGUI.tab[1])
dgs:dgsSetFont(rentalGUI.button[5], "default-bold-small")
dgs:dgsSetProperty(rentalGUI.button[5], "NormalTextColour", "FFAAAAAA")

rentalGUI.button[4] = dgs:dgsCreateButton(250, 187, 201, 45, "GPS no veiculo", false, rentalGUI.tab[1])
dgs:dgsSetFont(rentalGUI.button[4], "default-bold-small")
dgs:dgsSetProperty(rentalGUI.button[4], "NormalTextColour", "FFAAAAAA")

rentalGUI.button[1] = dgs:dgsCreateButton(250, 238, 201, 45, "Pegar veículo", false, rentalGUI.tab[1])
dgs:dgsSetFont(rentalGUI.button[1], "default-bold-small")
dgs:dgsSetProperty(rentalGUI.button[1], "NormalTextColour", "FFAAAAAA")
rentalGUI.button[2] = dgs:dgsCreateButton(250, 289, 99, 22, "Guardar veiculo", false, rentalGUI.tab[1])
dgs:dgsSetProperty(rentalGUI.button[2], "NormalTextColour", "FFAAAAAA")
rentalGUI.button[3] = dgs:dgsCreateButton(353, 289, 99, 22, "Cancelar", false, rentalGUI.tab[1])
dgs:dgsSetProperty(rentalGUI.button[3], "NormalTextColour", "FFAAAAAA")


