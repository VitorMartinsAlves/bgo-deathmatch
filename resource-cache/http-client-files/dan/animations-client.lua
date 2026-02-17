newFont1 = guiCreateFont("customfont.ttf", 12)

local resX, resY = guiGetScreenSize()


function makeAnimationGUI()
	animationWindow =  guiCreateWindow(488, 164, 357, 250, "Painel De Animaçoes Criado Por #Charada", false) 
	guiSetVisible(animationWindow,false)
	guiSetProperty(animationWindow, "CaptionColour", "FF06B7F8")    
	animationCategoryList = guiCreateGridList(0.01,0.1,0.45,0.6,true,animationWindow)
	animationList = guiCreateGridList(0.47,0.1,0.45,0.6,true,animationWindow)
	column1 = guiGridListAddColumn(animationCategoryList,"Modelos",0.8)
	column2 = guiGridListAddColumn(animationList,"Danças",0.8)
	stopButton = guiCreateButton(0.01,0.8,0.9,0.3,"Stop Animaçao",true,animationWindow)
	addEventHandler("onClientGUIClick",stopButton,function() setPedAnimation(getLocalPlayer(),nil,nil) end)
	guiSetProperty(stopButton, "NormalTextColour", "FF06B7F8")
		for k, v in ipairs (getElementsByType("animationCategory")) do
			local row = guiGridListAddRow(animationCategoryList)
			guiGridListSetItemText(animationCategoryList,row,column1,getElementID(v),false,false)
		end
addEventHandler("onClientGUIClick",animationCategoryList,getAnimations)
addEventHandler("onClientGUIClick",animationList,setAnimation)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),makeAnimationGUI)

function toggleVisible()
	if (guiGetVisible(animationWindow) == false) then
		guiSetVisible(animationWindow,true)
		showCursor(true)
		
	else
		guiSetVisible(animationWindow,false)
		showCursor(false)
		playSound("music.wav")
	end
end
bindKey("F4","down",toggleVisible)


function getAnimations()
	selectedCategory = guiGridListGetItemText(animationCategoryList,guiGridListGetSelectedItem(animationCategoryList),1)
		if (selectedCategory ~= "") then
			guiGridListClear(animationList)
				for k, v in ipairs (getElementChildren(getElementByID(selectedCategory))) do
					local row = guiGridListAddRow(animationList)
					guiGridListSetItemText(animationList,row,column1,getElementID(v),false,false)
				end
		end
		if (selectedCategory == "") then
			guiGridListClear(animationList)
		end
end

function setAnimation()
	selectedAnimation = guiGridListGetItemText(animationList,guiGridListGetSelectedItem(animationList),1)
		if (selectedAnimation ~= "") then
			if (not isPlayerDead(getLocalPlayer())) then
				if (isPedInVehicle(getLocalPlayer()) == false) then
					local animationBlock = getElementData(getElementByID(selectedAnimation),"block")
					local animationID = getElementData(getElementByID(selectedAnimation),"code")
					triggerServerEvent("setAnimation",getLocalPlayer(),animationBlock,animationID)
				else
					outputChatBox("You cannot use animations while in a vehicle.",255,0,0)
				end
			else
				outputChatBox("You cannot use animations while you are dead.",255,0,0)
			end
		end
end