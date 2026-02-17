if fileExists("selectC.lua") then
	fileDelete("selectC.lua")
end

local screenX, screenY = guiGetScreenSize()

local panelState = false
local panelData = {}

local mehet = true

addEventHandler("onClientRender",getRootElement(),function()
	if mehet == true then
		if getElementData(localPlayer,"loggedin") == 1 then
			local loadedFightStyles = {}

			local currentFightStyles = getElementData(localPlayer, "char.fightStyles")
			if currentFightStyles then
				local splittedData = split(currentFightStyles, ";")
				for k,v in ipairs(splittedData) do
					table.insert(loadedFightStyles, v)
				end
			end

			return loadedFightStyles
		end
	end
end)

function getCurrentFightStyles()
	local loadedFightStyles = {}

	local currentFightStyles = getElementData(localPlayer, "char.fightStyles")
	if currentFightStyles then
		local splittedData = split(currentFightStyles, ";")
		for k,v in ipairs(splittedData) do
			table.insert(loadedFightStyles, v)
		end
	end

	return loadedFightStyles
end
--[[
addCommandHandler("harcstilus",
	function ()
		toggleSelectPanel(not panelState)
	end
)]]--

function toggleSelectPanel(state)
	if state ~= panelState then

		if state then
			if isElement(panelData.mainWindow) then
				destroyElement(panelData.mainWindow)
			end

			panelData.mainWindow = guiCreateWindow((screenX / 2) - (458 / 2), (screenY / 2) - (416 / 2), 458, 415, "Harcstílusok", false)
			guiWindowSetSizable(panelData.mainWindow, false)

			panelData.infoLabel = guiCreateLabel(9, 25, 439, 60, "Na interface abaixo você tem a opção de selecionar,\nqual estilo de luta deseja usar!", false, panelData.mainWindow)
			guiSetFont(panelData.infoLabel, "default-bold-small")
			guiLabelSetHorizontalAlign(panelData.infoLabel, "center", false)

			panelData.fightStyleGrid = guiCreateGridList(17, 83, 421, 233, false, panelData.mainWindow)
			panelData.nameColumn = guiGridListAddColumn(panelData.fightStyleGrid, "name", 0.9)

			local loadedFightStyles = getCurrentFightStyles()

			for k,v in ipairs(loadedFightStyles) do

				local styleName = "fighting Style"
				for i,l in pairs(availableStyles) do
					if tostring(l[1]) == tostring(v) then
						styleName = tostring(l[2])
					end
				end

				local currentRow = guiGridListAddRow(panelData.fightStyleGrid)
				if currentRow then
					guiGridListSetItemText(panelData.fightStyleGrid, currentRow, panelData.nameColumn, styleName, false, false)
					guiGridListSetItemData(panelData.fightStyleGrid, currentRow, panelData.nameColumn, v)
				end
			end

			panelData.setButton = guiCreateButton(23, 324, 405, 33, "Use um estilo de luta selecionado", false, panelData.mainWindow)
			guiSetFont(panelData.setButton, "default-bold-small")
			guiSetProperty(panelData.setButton, "NormalTextColour", "FFAAAAAA")
			addEventHandler("onClientGUIClick", panelData.setButton, selectButtonActions)

			panelData.exitButton = guiCreateButton(23, 361, 405, 33, "Cancelar", false, panelData.mainWindow)
			guiSetFont(panelData.exitButton, "default-bold-small")
			guiSetProperty(panelData.exitButton, "NormalTextColour", "FFAAAAAA")
			addEventHandler("onClientGUIClick", panelData.exitButton, selectButtonActions)

			panelState = true  

		else
			if isElement(panelData.mainWindow) then
				destroyElement(panelData.mainWindow)
			end
			panelState = false
		end
	end
end

function selectButtonActions()
	if source == panelData.setButton then
		local selectedItem = guiGridListGetSelectedItem(panelData.fightStyleGrid)
		if selectedItem then
			local fightStyleId = guiGridListGetItemData(panelData.fightStyleGrid, selectedItem, panelData.nameColumn)
			if fightStyleId then
				triggerServerEvent("updateFightStyle", localPlayer, fightStyleId)
				toggleSelectPanel(false)
			end
		end
	elseif source == panelData.exitButton then
		toggleSelectPanel(false)
	end
end