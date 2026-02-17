local odimension = getElementDimension(localPlayer)

local ointerior = getElementInterior(localPlayer)

local screenSize = {guiGetScreenSize()}
screenSize.x, screenSize.y = screenSize[1], screenSize[2]
local myScreenSource = dxCreateScreenSource(screenSize.x, screenSize.y)
blurShader, blurTec = dxCreateShader("files/shaders/shader.fx")

function infoSound(file)
	playSound("files/sounds/"..file..".mp3")
end
function infoBox(text, type)
	if not text then return end
	if not tonumber(type) then type = 4 end
	exports["bgo_infobox"]:addNotification(text, type)
end


function isCursorHover(startX, startY, sizeX, sizeY)
	if isCursorShowing() then
		local cursorPosition = {getCursorPosition()}
		cursorPosition.x, cursorPosition.y = cursorPosition[1] * screenSize.x, cursorPosition[2] * screenSize.y
		if cursorPosition.x >= startX and cursorPosition.x <= startX + sizeX and cursorPosition.y >= startY and cursorPosition.y <= startY + sizeY then
			return true
		else
			return false
		end
	else
		return false
	end
end

local dashboardOpened = false
local dutyskinOpened = false
local width, height = 800, 450
local startX, startY = (screenSize.x - width) / 2, (screenSize.y - height) / 2
local bgColor = tocolor(0, 0, 0, 155)
local slotColor = tocolor(0, 0,0, 200)
local hoverColor = tocolor(255, 0, 0, 155)
local secondColor = tocolor(255, 255, 240, 125)
local cancelColor = tocolor(255, 0, 0, 155)
local spacer = 2
local spacerBig = 5
local roboto = "default-bold-small" --dxCreateFont("files/fonts/Roboto.ttf", 8, false, "proof")
local robotoBold = "default-bold-small" --dxCreateFont("files/fonts/Roboto.ttf", 10, true, "proof")
local robotoBig = "default-bold-small"--dxCreateFont("files/fonts/Roboto.ttf", 11, false, "proof")
local robotoGui = "default-bold-small"-- guiCreateFont("files/fonts/Roboto.ttf", 9)
--local menuPoints = {{"Informações", "informations"}, {"Grupos", "groups"}, {"     Administradores", "administrator"}}

local menuPoints = {{"Grupos", "groups"}}
local onlineText = {"#65ba05Online"}
onlineText[0] = "#cc0000Offline"
local leaderText = {"#65ba05Sim"}
leaderText[0] = "#cc0000Não"
local menuPointsWidth = (width - (#menuPoints - 1) * spacerBig) / #menuPoints

local factionMenu = {"Membros",  "Gerenciar Cargos"}
local factionRowWidth = width / 4 - spacerBig
local groupStartX, groupStartY = startX + factionRowWidth + spacerBig + spacer, startY + spacerBig
local groupManaging = {}
local groups = {}
local playerGroups = {}
local playerRanksInGroups = {}
local groupMembers = {}
local groupVehicles = {}
local meInGroup = {}
local editGuis = {}
local admins = {}

local openedTick = getTickCount() - 2000
function changeState()
	if getTickCount() - openedTick <= 2000 and not dashboardOpened then
		infoBox("Você só pode abrir o painel a cada 2 segundos.", 2)
		cancelEvent()
		return
	end
	dashboardOpened = not dashboardOpened
	for key, value in ipairs(editGuis) do
		if isElement(value) then destroyElement(value) end
	end
	setElementData(localPlayer, "toggle-->All", not dashboardOpened)
	showChat(not dashboardOpened)
	if dashboardOpened then
		currentPage = 1
		openedTick = getTickCount()
		fetchGroups()
		triggerServerEvent("requestGroups", localPlayer)
		fetchGroups()
		selectedGroup = 1	--fk
		selectedMenu = 1	--menü  (players/ranks etc)
		selectedKey = 1		--érték (player/vehicle etc)
		maxRowG = 14
		currentRowG = 1
		latestRowG = 1
		maxKey = 1
	end
end


local skinCollision = createColCuboid(1235.1965332031, -1518.3608398438, 18.753824234009, 16, 7, 9)
addEventHandler("onClientKey", root, function(button, pressed)
	if pressed and getElementData(localPlayer, "loggedin") then
		if button == "home" then
			changeState()
			cancelEvent()
		end
		if button == "F3" then
			changeState()
			cancelEvent()
		end
		if dashboardOpened then
			if button == "mouse1" then
				for key, value in ipairs(menuPoints) do
					local forX = startX + (key - 1) * (menuPointsWidth + spacerBig)
					if isCursorHover(forX, startY - 50 - spacerBig, menuPointsWidth, 50) and key ~= currentPage then
						currentPage = key
						infoSound("info")
						for key, value in ipairs(editGuis) do
							if isElement(value) then destroyElement(value) end
						end
						if currentPage == 1 then
							fetchGroups()
							triggerServerEvent("requestGroups", localPlayer)
						end
					end
				end		
			end
			if currentPage == 1 then
				if selectedMenu == 1 then
					if button == "mouse_wheel_down" then
						if currentRowG < #groupMembers[groupId] - (maxRowG - 1) then
							currentRowG = currentRowG + 1
						end
					elseif button == "mouse_wheel_up" then
						if currentRowG > 1 then
							currentRowG = currentRowG - 1
						end
					end
				end
				if button == "mouse1" then
					groupStartX, groupStartY = startX + factionRowWidth + spacerBig + spacer, startY + spacerBig
					if #playerGroups > 0 then
						for key = 1, #playerGroups do
							local forY = startY + 2 * spacerBig + (key - 1) * 30
							if isCursorHover(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26) then
								selectedGroup = key
								selectedMenu = 1
								selectedKey = 1
								for key, value in ipairs(editGuis) do
									if isElement(value) then destroyElement(value) end
								end
							end
						end
					end

					for key = 0, maxKey or 1 do
						local forY = groupStartY + 2 + key * 22
						if isCursorHover(groupStartX + 2, forY, factionRowWidth - 2 * spacer, 20) then
							selectedMenu = key + 1
							selectedKey = 1
						end
					end

					if button == "mouse1" and meInGroup[groupId]["isLeader"] == 1 then
						if selectedMenu == 1 then
							if isCursorHover(groupStartX + spacer, groupStartY + 22 * 17 + 2 * spacer, factionRowWidth - spacer, 22) and not isElement(editGuis.desc) then
								editGuis.desc = guiCreateEdit(groupStartX + spacer, groupStartY + 22 * 18 + 3 * spacer, ((startX + width - spacer) - groupStartX) - 2 * spacer - spacerBig, 18, groups[groupId]["description"], false)
								guiSetFont(editGuis.desc, robotoGui)
								guiSetAlpha(editGuis.desc, 0)	
							end
							if isElement(editGuis.desc) then
								if isCursorHover(groupStartX + factionRowWidth + 2 * spacer, groupStartY + 22 * 17 + 2 * spacer, factionRowWidth - spacer, 22) then
									triggerServerEvent("setGroupDescription", localPlayer, guiGetText(editGuis.desc), groupId)
									destroyElement(editGuis.desc)
								end
							end
						end
					end
					groupStartX = groupStartX + factionRowWidth + spacerBig
					if selectedMenu == 1 then
						for key = 0, 14 do
							local forY = groupStartY + 2 + key * 22
							if isCursorHover(groupStartX + 2, forY, factionRowWidth - 4, 20) and groupMembers[groupId][key + 1 - maxRowG + latestRowG] then
								selectedKey = key + 1 - maxRowG + latestRowG
							end
						end
					elseif selectedMenu == 2 then
						for key = 0, 14 do
							local forY = groupStartY + 2 + key * 22

							if isCursorHover(groupStartX + 2, forY, factionRowWidth - 4, 20) then
								selectedKey = key + 1
							end
						end					
					end
					groupStartX = groupStartX + factionRowWidth + spacerBig
					if meInGroup[groupId]["isLeader"] == 1 and selectedMenu == 1 then
						if isCursorHover(groupStartX, groupStartY + 22 * 4 + spacer + spacerBig, factionRowWidth, 22) then
							local thisMembers = groupMembers[groupId]
							local member = thisMembers[selectedKey]
							triggerServerEvent("modifyRankForPlayer", localPlayer, member["id"], member["rank"], groupId, "up", member["online"], playerGroups)
							infoBox("Você promoveu com sucesso o jogador "..member["characterName"].."")		
						elseif isCursorHover(groupStartX, groupStartY + 22 * 5 + spacer + 2 * spacerBig, factionRowWidth, 22) then
							local thisMembers = groupMembers[groupId]
							local member = thisMembers[selectedKey]
							triggerServerEvent("modifyRankForPlayer", localPlayer, member["id"], member["rank"], groupId, "down", member["online"], playerGroups)
							infoBox("Você rebaixou com sucesso o jogador "..member["characterName"].."")
						elseif isCursorHover(groupStartX, groupStartY + 22 * 6 + spacer + 3 * spacerBig, factionRowWidth, 22) then
							local member = groupMembers[groupId][selectedKey]
							if member["isLeader"] == 1 then
								infoBox("Você não pode expulsar o líder. Procure um GM", 2)
								return
							end
							triggerServerEvent("deletePlayerFromGroup", localPlayer, member["id"], groupId, member["online"], playerGroups)
							infoBox("Você chutou com sucesso o jogador "..member["characterName"].."")
							table.remove(meInGroup, groupId)
						elseif isCursorHover(groupStartX, groupStartY + 22 * 7 + spacer + 4 * spacerBig, factionRowWidth, 22) then
							editGuis.addMember = guiCreateEdit(groupStartX, groupStartY + 22 * 8 + spacer + 5 * spacerBig, factionRowWidth, 22, "", false)
							guiSetFont(editGuis.addMember, robotoGui)
							guiSetAlpha(editGuis.addMember, 0)								
						end
						if isCursorHover(groupStartX, groupStartY + 22 * 9 + spacer + 6 * spacerBig, factionRowWidth, 22) and isElement(editGuis.addMember) then
					local invitingText = guiGetText(editGuis.addMember)
					if string.len(invitingText) < 1 then
						infoBox("Você não pode deixar o campo vazio!", 2)
					else
						local found = false
						local multipleFounds = false
						local invitingText = string.lower(string.gsub(invitingText, " ", "_"))

						for k, v in ipairs(getElementsByType("player")) do
							if getElementData(v, "loggedin") then
								local id = getElementData(v, "playerid")
								local name = string.lower(getPlayerName(v):gsub(" ", "_"))

								if id == tonumber(invitingText) or string.find(name, invitingText) then
									if found then
										found = false
										multipleFounds = true
										break
									else
										found = v
									end
								end
							end
						end
						if multipleFounds then							
							infoBox("Mais resultados!", 2)
						elseif isElement(found) then
							local name = getPlayerName(found)

							infoBox("" .. name:gsub("_", " ") .. " Gravado com sucesso!", 2)
							triggerServerEvent("invitePlayer", localPlayer, getElementData(found, "acc:id"), groupId, found, playerGroups)
						else
							infoBox("Nenhum resultado encontrado!", 2)
						end
					end


						elseif isCursorHover(groupStartX, groupStartY + 22 * 10 + spacer + 7 * spacerBig, factionRowWidth, 22) and isElement(editGuis.addMember) then
							destroyElement(editGuis.addMember)
						end

					elseif meInGroup[groupId]["isLeader"] == 1 and selectedMenu == 2 then
						if isCursorHover(groupStartX, groupStartY + 22 * 2 + spacer + spacerBig, factionRowWidth, 22) and not isElement(editGuis.rangName) then
							editGuis.rangName = guiCreateEdit(groupStartX, groupStartY + 22 * 3 + spacer + spacerBig, factionRowWidth, 22, "Patente", false)
							guiSetFont(editGuis.rangName, robotoGui)
							guiSetAlpha(editGuis.rangName, 0)

							editGuis.rangPay = guiCreateEdit(groupStartX, groupStartY + 22 * 4 + spacer + spacerBig, factionRowWidth, 22, "Salário", false)
							guiSetFont(editGuis.rangPay, robotoGui)
							guiSetAlpha(editGuis.rangPay, 0)
						end

						if isCursorHover(groupStartX, groupStartY + 22 * 5 + spacer + spacerBig, factionRowWidth, 22) then
							if groups[groupId]["type"] == (5 or 6) then
								guiSetText(editGuis.rangPay, 0)
							end
							if tostring(guiGetText(editGuis.rangName)) and tonumber(guiGetText(editGuis.rangPay)) then
								if guiGetText(editGuis.rangName) ~= "" and guiGetText(editGuis.rangName) ~= " " then
									if tonumber(guiGetText(editGuis.rangPay)) >= 0 or tonumber(guiGetText(editGuis.rangPay)) <= 1000 then
										groups[groupId]["rank_" .. selectedKey] = guiGetText(editGuis.rangName)
										groups[groupId]["rank_" .. selectedKey .. "_pay"] = math.floor(guiGetText(editGuis.rangPay))
										
										infoBox("Você alterou as configurações")
										
										triggerServerEvent("renameRank", localPlayer, selectedKey, guiGetText(editGuis.rangName), groupId)
										triggerServerEvent("setRankPayment", localPlayer, selectedKey, math.floor(tonumber(guiGetText(editGuis.rangPay))), groupId)
										fetchGroups()
										
										destroyElement(editGuis.rangName)
										destroyElement(editGuis.rangPay)
									end
								end
							end
						elseif isCursorHover(groupStartX, groupStartY + 22 * 6 + spacer + spacerBig, factionRowWidth, 22) then
							destroyElement(editGuis.rangName)
							destroyElement(editGuis.rangPay)
						end
					elseif meInGroup[groupId]["isLeader"] == 1 and selectedMenu == 3 then
						groupStartX = groupStartX - factionRowWidth - spacerBig
						if isCursorHover(groupStartX, groupStartY + 3 * 22 + 2 * spacer, 2 * factionRowWidth, 20) then
							if isElement(editGuis.addMoney) then
								local money = guiGetText(editGuis.addMoney)
								if not tonumber(money) then
									infoBox("Quantia inválida (numero)", 2)
									return
								end
								if tonumber(money) < 1 then
									infoBox("Você deve pagar pelo menos 1", 2)
									return
								end
								local money = tonumber(money)
								local current = groups[groupId]["balance"]
								local after = current + money
								if getElementData(localPlayer, "char:money") >= money then
									triggerServerEvent("setGroupBalance", localPlayer, groupId, after)
									groups[groupId]["balance"] = after
									fetchGroups()
									infoBox("Você depositou com sucesso na conta do grupo " .. money .. "")
									destroyElement(editGuis.addMoney)
								else
									infoBox("Você não tem dinheiro suficiente", 2)
								end
							elseif isElement(editGuis.takeMoney) then
								local money = guiGetText(editGuis.takeMoney)
								if not tonumber(money) then
									infoBox("Quantia inválida (numero)", 2)
									return
								end
								
								if tonumber(money) < 1 then
									infoBox("Você deve pagar pelo menos 1", 2)
									return
								end
								
								local money = tonumber(money)
								local current = groups[groupId]["balance"]
								local after = current - money
								
								if groups[groupId]["balance"] >= money then
									triggerServerEvent("setGroupBalance", localPlayer, groupId, after)
									groups[groupId]["balance"] = after
									fetchGroups()
									
								--	setElementData(localPlayer, "char:money", getElementData(localPlayer, "char:money") + money)
									
									infoBox("Você pagou com sucesso a conta do jogador " .. money .. "")
									
									destroyElement(editGuis.takeMoney)
								else
									infoBox("Não há dinheiro suficiente na conta", 2)
								end
							end					
						elseif isCursorHover(groupStartX, groupStartY + 4 * 22 + 2 * spacer, 2 * factionRowWidth, 20) then
							if isElement(editGuis.addMoney) then destroyElement(editGuis.addMoney) end
							if isElement(editGuis.takeMoney) then destroyElement(editGuis.takeMoney) end
						end
					end
				end
			end
		end
	end
end
)


function fetchGroups()
	local groupCount = getElementData(localPlayer, "groupCount")
	if tonumber(groupCount) and groupCount >= 1 then
		playerGroups = {}
		for i = 0, groupCount - 1 do
			local groupID = getElementData(localPlayer, "group_" .. i)
			if groupID then
				for k, v in pairs(groups) do
					if groupID == v["groupID"] then
						table.insert(playerGroups, groupID)
					end
				end
			end
		end
	end
	if #playerGroups >= 1 and #playerGroups == groupCount then
		triggerServerEvent("requestGroupData", localPlayer, playerGroups)
	else
		playerGroups = {}
	end
	local groupsKeyed = {}
	for k, v in pairs(playerGroups) do
		groupsKeyed[v] = true
	end
end

local rankCount = {}
addEvent("sendGroupMembers", true )
addEventHandler("sendGroupMembers", root, function (members, playerID, groupID)
	local me = getElementData(localPlayer, "char:id")
	for k, v in pairs(members) do
		for k2, v2 in pairs(v) do
			if v2["id"] == me then
				meInGroup[k] = v2
			end
		end
	end
	local onlinePlayers = {}
	for k, v in pairs(getElementsByType("player")) do
		local id = getElementData(v, "char:id")
		onlinePlayers[id] = v
	end
	for k, v in pairs(members) do
		rankCount[k] = {}
		for k2, v2 in pairs(v) do
			local id = v2["id"]
			if onlinePlayers[id] then
				members[k][k2]["online"] = onlinePlayers[id]
			else
				members[k][k2]["online"] = false
			end
			local rank = v2["rank"]			
			local current = rankCount[k][rank] or 0
			rankCount[k][rank] = current + 1
			if k == groupID and id == playerID then
				selectedKey = k2
			end
		end
	end
	groupMembers = members
end)

addEvent("sendGroups", true)
addEventHandler("sendGroups", root, function (datas)
	groups = datas
	if currentPage == 1 then
		fetchGroups()
	end
end)

addEvent("renameGroupRank", true)
addEventHandler("renameGroupRank", root, function (name, rankName, groupId)
	if not groups[groupId][name] then return end
	groups[groupId][name] = rankName or ""
	if currentPage == 1 then
		fetchGroups()
	end
end)

	
addEvent("setDescription", true)
addEventHandler("setDescription", root, function (description, groupId)
	groups[groupId]["description"] = description or ""
	if currentPage == 1 then
		fetchGroups()
	end
end)

function isPlayerInFaction(groupID)
	fetchGroups()
	triggerServerEvent("requestGroups", localPlayer)
	if getElementData(localPlayer, "loggedin") then
		if meInGroup[groupID] then
			return true
		else
			return false
		end
	else
		return false
	end
end


function getPlayerRankInFaction(groupID)
	if isPlayerInFaction(groupID) then
		return meInGroup[groupID]["rank"]
	else
		return false
	end
end

function isPlayerLeaderInFaction(groupID)
	if isPlayerInFaction(groupID) then
		if meInGroup[groupID]["isLeader"] == 1 then
			return true
		else
			return false
		end
	else
		return false
	end	
end


function onlineByName(name)
	for _, player in ipairs(getElementsByType("player")) do
		if getElementData(player, "loggedin") then
			if getElementData(player, "char:name"):gsub("_", " ") == tostring(name) then
				return 1
			end
		else
			return 0
		end
	end
	return 0
end

function getFactionName(groupID)
	if groups[groupID] then
		return groups[groupID]["name"]
	else
		return ""
	end
end


function getFactionBalance(groupID)
	if groups[groupID] then
		return groups[groupID]["balance"]
	else
		return 0
	end
end


function getPlayerPayment()
	triggerServerEvent("getPlayerPayment", localPlayer, localPlayer)
end


function thousandsStepper(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if k == 0 then
			break
		end
	end
	return formatted
end






addEventHandler("onClientRender", root, function()
	if dashboardOpened then
		if isChatVisible() then showChat(false) end
		if getElementData(localPlayer, "toggle-->All") then setElementData(localPlayer, "toggle-->All", false) end
		dxDrawRectangle(startX, startY, width, height, bgColor)
		--dxDrawImage(startX+350, startY+30, width-390, height-50, "files/images/logo.png",0,0,0,tocolor(255, 255, 255,150))
		for key, value in ipairs(menuPoints) do
			local forX = startX + (key - 1) * (menuPointsWidth + spacerBig)
			dxDrawRectangle(forX, startY - 30 - spacerBig, menuPointsWidth, 30, tocolor(0, 0, 0,255))
			if key == currentPage then
				dxDrawRectangle(forX, startY - 30 - spacerBig, menuPointsWidth, 30, hoverColor)
			end
			dxDrawText(value[1], forX, startY - 30 - spacerBig, forX + menuPointsWidth, startY - spacerBig, tocolor(255, 255, 255), 1.2, robotoBig, "center", "center")
			if isCursorHover(forX, startY - 30 - spacerBig, menuPointsWidth, 50) then
				dxDrawText(value[1], forX, startY - 30 - spacerBig, forX + menuPointsWidth, startY - spacerBig, tocolor(255, 0, 0,105), 1.2, robotoBig, "center", "center")
			end
			dxDrawImage(forX + 2.5, startY - 30 - spacerBig + 2.5, 25, 25, "files/images/tabs/"..value[2]..".png")
		end
		if currentPage == 1 then
			if #playerGroups > 0 then
				factionRowWidth = width / 4 - spacerBig
				groupStartX, groupStartY = startX + factionRowWidth + spacerBig + spacer, startY + spacerBig
				dxDrawRectangle(startX + spacerBig, startY + spacerBig, factionRowWidth, 14 * 30 + spacerBig + 1, bgColor)

				--- groups
				for key = 1, 14 do --abner
					local forY = startY + 2 * spacerBig + (key - 1) * 30
					dxDrawRectangle(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26, slotColor)
					if isCursorHover(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26) or key == selectedGroup then
						dxDrawRectangle(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26, hoverColor)
					end
					local groupId = playerGroups[key]
					if tonumber(groupId) then
						dxDrawText(groups[groupId]["name"], startX, forY, startX + factionRowWidth, forY + 26, tocolor(255, 255, 255), 1, robotoBig, "center", "center")
						if isCursorHover(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26) or key == selectedGroup then
							dxDrawText(groups[groupId]["name"], startX, forY, startX + factionRowWidth, forY + 26, tocolor(255, 255, 255), 1, robotoBig, "center", "center")				
						end
					end
				end
				groupId = playerGroups[selectedGroup]
				if tonumber(groupId) and meInGroup[groupId] then
					local rank = meInGroup[groupId]["rank"]
					--- menus
					if meInGroup[groupId]["isLeader"] == 1 and groups[groupId]["type"] ~= (5 or 6) then
						maxKey = 1
					else
						maxKey = 1
					end
					dxDrawRectangle(groupStartX, groupStartY, factionRowWidth, 22 * (maxKey + 1) + spacer, bgColor)
					for key = 0, maxKey do
						local forY = groupStartY + 2 + key * 22
						dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, slotColor)
 						dxDrawText(factionMenu[key + 1], groupStartX, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "center", "center")
						if key + 1 == selectedMenu or isCursorHover(groupStartX + 2, forY, factionRowWidth - 2 * spacer, 20) then
							dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, hoverColor)
							dxDrawText(factionMenu[key + 1], groupStartX, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "center", "center")
						end
					end
				end
				if selectedMenu == 1 then
					groupStartX = groupStartX + factionRowWidth + spacerBig
					dxDrawRectangle(groupStartX, groupStartY, factionRowWidth, 22 * 17 + spacer, bgColor)
					for key = 0, 13 do
						local forY = groupStartY + spacer + key * 22		
						dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, slotColor)
					end
					latestRowG = currentRowG + maxRowG - 1
					if meInGroup[groupId] then
						for key, value in ipairs(groupMembers[groupId]) do
							if key >= currentRowG and key <= latestRowG then
								key = key - currentRowG+1
								local forY = groupStartY + spacer + (key - 1) * 22
								dxDrawText(value["characterName"]:gsub("_", " "), groupStartX + 2 * spacer, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "left", "center", false, false, false, true)
								dxDrawText(onlineText[onlineByName(value["characterName"]:gsub("_", " "))], groupStartX, forY, groupStartX + factionRowWidth - 2 * spacer, forY + 20, tocolor(255, 255, 255), 1, roboto, "right", "center", false, false, false, true)
								if key == selectedKey - currentRowG + 1 or isCursorHover(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20) then
									dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, hoverColor)
									dxDrawText(value["characterName"]:gsub("_", " "), groupStartX + 2 * spacer, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255,255,255), 1, roboto, "left", "center", false, false, false, true)
									dxDrawText(onlineText[onlineByName(value["characterName"]:gsub("_", " "))], groupStartX, forY, groupStartX + factionRowWidth - 2 * spacer, forY + 20, tocolor(255,255,255), 1, roboto, "right", "center", false, false, false, true)								
								end
							end
						end
						groupStartX = groupStartX + factionRowWidth + spacerBig
						dxDrawRectangle(groupStartX, groupStartY, factionRowWidth, 22 * 4 + spacer, bgColor)
						local currentMemberInf = {
							"Cargo: " .. groups[groupId]["rank_"..groupMembers[groupId][selectedKey]["rank"]],
							"Pagamento: $" .. groups[groupId]["rank_"..groupMembers[groupId][selectedKey]["rank"].."_pay"],
							"Líder: " .. leaderText[groupMembers[groupId][selectedKey]["isLeader"]],
							getLocalPlayer():getData("acc:lastlogin"),							
						}
						for key = 0, 3 do
							local forY = groupStartY + spacer + key * 22
							dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, slotColor)
							dxDrawText(currentMemberInf[key + 1], groupStartX, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "center", "center", false, false, false, true)
							if isCursorHover(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20) then
								dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, hoverColor)
								dxDrawText(currentMemberInf[key + 1], groupStartX, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255,255,255), 1, roboto, "center", "center", false, false, false, true)						
							end
						end
						if meInGroup[groupId]["isLeader"] == 1 then
							dxDrawButton("Promover", groupStartX, groupStartY + 22 * 4 + spacer + spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
							dxDrawButton("Rebaixar", groupStartX, groupStartY + 22 * 5 + spacer + 2 * spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
							dxDrawButton("Remover", groupStartX, groupStartY + 22 * 6 + spacer + 3 * spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))		
							dxDrawButton("Novo membro", groupStartX, groupStartY + 22 * 7 + spacer + 4 * spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
							if isElement(editGuis.addMember) then
								dxDrawEdit(groupStartX, groupStartY + 22 * 8 + spacer + 5 * spacerBig, factionRowWidth, 22, editGuis.addMember)
								dxDrawButton("Salvar", groupStartX, groupStartY + 22 * 9 + spacer + 6 * spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
								dxDrawButton("cancelar", groupStartX, groupStartY + 22 * 10 + spacer + 7 * spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
							end
						end
					end
				elseif selectedMenu == 2 then
					groupStartX = groupStartX + factionRowWidth + spacerBig
					dxDrawRectangle(groupStartX, groupStartY, factionRowWidth, 22 * 17 + spacer, bgColor)
					local rank = meInGroup[groupId]["rank"]
					for key = 0, 14 do
						local forY = groupStartY + spacer + key * 22
						dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, slotColor)
						dxDrawText(groups[groupId]["rank_" .. key + 1]:gsub("#%x%x%x%x%x%x", ""), groupStartX + spacer, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "center", "center")
						if isCursorHover(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20) or key == selectedKey - currentRowG then
							dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, hoverColor)
							dxDrawText(groups[groupId]["rank_" .. key + 1]:gsub("#%x%x%x%x%x%x", ""), groupStartX + spacer, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "center", "center")
						end
					end
					groupStartX = groupStartX + factionRowWidth + spacerBig
					dxDrawRectangle(groupStartX, groupStartY, factionRowWidth, 22 * 2 + spacer, bgColor)
					local currentRankInf = {
						groups[groupId]["rank_" .. selectedKey]:gsub("#%x%x%x%x%x%x", ""),
						"Pagamento: $" .. groups[groupId]["rank_" .. selectedKey .. "_pay"]
					}
					for key = 0, 1 do
						local forY = groupStartY + spacer + key * 22
						dxDrawRectangle(groupStartX + spacer, forY, factionRowWidth - 2 * spacer, 20, slotColor)
						dxDrawText(currentRankInf[key + 1], groupStartX, forY, groupStartX + factionRowWidth, forY + 20, tocolor(255, 255, 255), 1, roboto, "center", "center")
					end
					dxDrawButton("Editar patente", groupStartX, groupStartY + 22 * 2 + spacer + spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))		
					if isElement(editGuis.rangName) then
						dxDrawEdit(groupStartX, groupStartY + 22 * 3 + spacer + spacerBig, factionRowWidth, 22, editGuis.rangName)
						dxDrawEdit(groupStartX, groupStartY + 22 * 4 + spacer + spacerBig, factionRowWidth, 22, editGuis.rangPay)
						dxDrawButton("modificar", groupStartX, groupStartY + 22 * 5 + spacer + spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
						dxDrawButton("cancelar", groupStartX, groupStartY + 22 * 6 + spacer + spacerBig, factionRowWidth, 22, tocolor(0, 0, 0))
					end
				end
			else
				factionRowWidth = width / 4 - spacerBig
				groupStartX, groupStartY = startX + factionRowWidth + spacerBig + spacer, startY + spacerBig
				dxDrawText("Painel de Grupo\nVocê não é atualmente membro de uma facção", groupStartX, groupStartY, startX + width, startY + height, tocolor(255, 255, 255), 1, robotoBig, "center", "top")
				dxDrawRectangle(startX + spacerBig, startY + spacerBig, factionRowWidth, 14 * 30 + spacerBig + 1, bgColor)
				--- groups
				for key = 1, 14 do
					local forY = startY + 2 * spacerBig + (key - 1) * 30
					dxDrawRectangle(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26, slotColor)
					if isCursorHover(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26) or key == selectedGroup then
						dxDrawRectangle(startX + 2 * spacerBig, forY, factionRowWidth - 2 * spacerBig, 26, hoverColor)
					end
				end
			end
		end
	end
end
)



function dxDrawButton(text, startX, startY, width, height, color)
	dxDrawRectangle(startX - 1, startY, 1, height, bgColor) --left
	dxDrawRectangle(startX + width, startY, 1, height, bgColor) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, bgColor) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, bgColor) --bottom
	dxDrawRectangle(startX, startY, width, height, color)
	dxDrawText(text, startX, startY, startX + width, startY + height, tocolor(255, 255, 255), 1, roboto, "center", "center", false, false, false, true)
end

function dxDrawEdit(startX, startY, width, height, element)
	dxDrawRectangle(startX - 1, startY, 1, height, bgColor) --left
	dxDrawRectangle(startX + width, startY, 1, height, bgColor) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, bgColor) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, bgColor) --bottom
	dxDrawRectangle(startX, startY, width, height, tocolor(0, 0, 0,100))
	dxDrawText(guiGetText(element), startX + 4, startY, startX + width, startY + height, tocolor(255, 255, 255), 1, roboto, "left", "center")
end

