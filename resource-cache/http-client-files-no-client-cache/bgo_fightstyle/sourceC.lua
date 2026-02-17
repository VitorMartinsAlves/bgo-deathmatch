if fileExists("sourceC.lua") then
	fileDelete("sourceC.lua")
end

local screenX, screenY = guiGetScreenSize()


local pedElement = false

local panelState = false
local panelData = {}

local learningProcess = false
local learningProcessStage = 1
local learningProcessSelectedStyle = false

availableStyles = {
	-- id, név, alapértelmezett
	{4, "Tradicional", true},
	{5, "Box", false},
	{6, "Kung-Fu", false},
	{7, "Knee-Head", false},
	{15, "Grab-Kick", false},
	{16, "Elbows", false},
}


local jobPed = {}

local job_PedPos = {
	{80, 2252.6362304688,-1712.6898193359,13.587435722351, "Sensei",93.113777160645},
}
local startTick = getTickCount()
local progress = ""
local elements = ""

local maxElem = 5
local nextPage = 0
local show = false

function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:Luta", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:Luta") then
			cancelEvent ()
		end
	end
)



addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:Luta") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(localPlayer)
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
			togglePanel(not panelState)
			elements = element
		end
	end
	end
	end
)













function togglePanel(state)
	if state ~= panelState then

		if state then
			if isElement(panelData.mainWindow) then
				destroyElement(panelData.mainWindow)
			end

			panelData.mainWindow = guiCreateWindow((screenX / 2) - (458 / 2), (screenY / 2) - (416 / 2), 458, 415, "Estilos de luta", false)
			guiWindowSetSizable(panelData.mainWindow, false)

			panelData.infoLabel = guiCreateLabel(9, 25, 439, 60, "Bem-vindo meu filho.\nEu sou o Sensei que tem todo o conhecimento das artes marciais.\nQual estilo de artes marciais interessa a você, meu filho?", false, panelData.mainWindow)
			guiSetFont(panelData.infoLabel, "default-bold-small")
			guiLabelSetHorizontalAlign(panelData.infoLabel, "center", false)

			panelData.fightStyleGrid = guiCreateGridList(17, 83, 421, 233, false, panelData.mainWindow)
			panelData.nameColumn = guiGridListAddColumn(panelData.fightStyleGrid, "name", 0.9)

			local loadedFightStyles = getCurrentFightStyles()

			for k,v in ipairs(availableStyles) do

				local isAvailable = true
				for i,l in pairs(loadedFightStyles) do
					if tostring(l) == tostring(v[1]) then
						isAvailable = false
					end
				end

				if isAvailable then
					local currentRow = guiGridListAddRow(panelData.fightStyleGrid)
					if currentRow then
						guiGridListSetItemText(panelData.fightStyleGrid, currentRow, panelData.nameColumn, v[2], false, false)
						guiGridListSetItemData(panelData.fightStyleGrid, currentRow, panelData.nameColumn, v[1])
					end
				end
			end

			panelData.learnButton = guiCreateButton(23, 324, 405, 33, "Dominar o estilo de luta", false, panelData.mainWindow)
			guiSetFont(panelData.learnButton, "default-bold-small")
			guiSetProperty(panelData.learnButton, "NormalTextColour", "FFAAAAAA")
			addEventHandler("onClientGUIClick", panelData.learnButton, buttonActions)

			panelData.exitButton = guiCreateButton(23, 361, 405, 33, "Cancelar", false, panelData.mainWindow)
			guiSetFont(panelData.exitButton, "default-bold-small")
			guiSetProperty(panelData.exitButton, "NormalTextColour", "FFAAAAAA")
			addEventHandler("onClientGUIClick", panelData.exitButton, buttonActions)

			panelState = true  

		else
			if isElement(panelData.mainWindow) then
				destroyElement(panelData.mainWindow)
			end
			panelState = false
		end
	end
end

function buttonActions()
	if source == panelData.learnButton then
		local selectedItem = guiGridListGetSelectedItem(panelData.fightStyleGrid)
		if selectedItem then
			local fightStyleId = guiGridListGetItemData(panelData.fightStyleGrid, selectedItem, panelData.nameColumn)
			if fightStyleId then
				learningProcessSelectedStyle = fightStyleId
				startLearningProcess()
			end
		end
	elseif source == panelData.exitButton then
		togglePanel(false)
	end
end

function startLearningProcess()
	learningProcess = true
	outputChatBox("#edc937Sensei: #FFFFFFMeu filho está bem, vou te ensinar em 2 etapas.", 255, 255, 255, true)

	togglePanel(false)

	setTimer(
		function ()
			firstLearningStage()
		end,
	3000, 1)

end

function firstLearningStage()
	learningProcessStage = 1
	outputChatBox("#edc937Sensei: #FFFFFFNa primeira fase, vamos testar seus reflexos.", 255, 255, 255, true)

	setTimer(
		function ()
			showLearningQuiz(true)
		end,
	6000, 1)
end

function secondLearningStage()
	learningProcessStage = 2

	setBalanceQTEState(true, 0.5)
end

function finishLearningProcess(isSucceed)
	learningProcess = false

	if isSucceed then

		local isAvailable = true

		local loadedFightStyles = getCurrentFightStyles()
		for k,v in pairs(loadedFightStyles) do
			if v == learningProcessSelectedStyle then
				isAvailable = false
			end
		end

		if isAvailable then
			local currentFightStyles = getElementData(localPlayer, "char.fightStyles")
			if currentFightStyles then
				local modifiedFightStyles = currentFightStyles .. ";" .. learningProcessSelectedStyle

				setElementData(localPlayer, "char.fightStyles", modifiedFightStyles)
			end
		end

		triggerServerEvent('updateFightStyle', localPlayer, localPlayer, learningProcessSelectedStyle)
		
		
		outputChatBox("#edc937Sensei: #FFFFFFParabéns meu filho. Você dominou com sucesso esta arte marcial.", 255, 255, 255, true)
	else
		outputChatBox("#edc937Sensei: #FFFFFFVocê falhou no ensaio. Quando estiver pronto, comece tudo de novo.", 255, 255, 255, true)
	end
end