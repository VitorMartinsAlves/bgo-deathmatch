local object = {}

local c4 = {}

local mec = {}
local mec2 = {}

local coldri = {}


function setElementBolsa2(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	if not isElement(object[thePlayer]) then
	if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	object[thePlayer] = createObject(1511, 0, 0, 0)
    exports["bone_attach"]:attachElementToBone(object[thePlayer],thePlayer,3,0,-0.005,-0.18,0,0,90)
	setElementData(thePlayer, "setElementBolsa2OFF", false)
	--print("Mochila adicionada!")
	end
	end
end
addEvent("setElementBolsa2",true)
addEventHandler("setElementBolsa2",getRootElement(),setElementBolsa2)


function setElementBolsa2OFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "setElementBolsa2OFF") then
	setElementData(thePlayer, "setElementBolsa2OFF", true)
	--print("Mochila removida!")
	if isElement(object[thePlayer]) then
	destroyElement(object[thePlayer])
	end
	end

end
addEvent("setElementBolsa2OFF",true)
addEventHandler("setElementBolsa2OFF",getRootElement(),setElementBolsa2OFF)


function setElementBolsa(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	if not isElement(object[thePlayer]) then
	if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	object[thePlayer] = createObject(1548, 0, 0, 0)
    exports["bone_attach"]:attachElementToBone(object[thePlayer],thePlayer,3,0,-0.005,-0.18,0,0,90)
	setElementData(thePlayer, "setElementBolsaOFF", false)
	--print("Mochila adicionada!")
	end
	end
end
addEvent("setElementBolsa",true)
addEventHandler("setElementBolsa",getRootElement(),setElementBolsa)


function setElementBolsaOFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "setElementBolsaOFF") then
	setElementData(thePlayer, "setElementBolsaOFF", true)
	if isElement(object[thePlayer]) then
	destroyElement(object[thePlayer])
	end
	end

end
addEvent("setElementBolsaOFF",true)
addEventHandler("setElementBolsaOFF",getRootElement(),setElementBolsaOFF)



function setAttachC4(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	if not isElement(c4[thePlayer]) then
	if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	local x,y,z = getElementPosition(thePlayer)
	c4[thePlayer] = createObject(1654, x,y,z)
	setObjectScale(c4[thePlayer],0.5)
    exports["bone_attach"]:attachElementToBone(c4[thePlayer],thePlayer, 14, 0.1, -0.02, 0.4, 0, 0, 90)
	setElementData(thePlayer, "AttachC4OFF", false)
	end
	end
end
addEvent("setAttachC4",true)
addEventHandler("setAttachC4",getRootElement(),setAttachC4)


function setAttachC4OFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "AttachC4OFF") then
	setElementData(thePlayer, "AttachC4OFF", true)
	if isElement(c4[thePlayer]) then
	destroyElement(c4[thePlayer])
	end
	end

end
addEvent("setAttachC4OFF",true)
addEventHandler("setAttachC4OFF",getRootElement(),setAttachC4OFF)


function setAttachMec(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not isElement(mec[thePlayer]) then
	if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	local x,y,z = getElementPosition(thePlayer)
	mec[thePlayer] = createObject(1083, x,y,z)
	--mec2[thePlayer] = createObject(1665, x,y,z)
	setObjectScale(mec[thePlayer],0.7)
    --exports["bone_attach"]:attachElementToBone(mec[thePlayer],thePlayer, 14, -0.12, 0.02, 0.05, 190, 0, 190)
	--local rot = getElementRotation(thePlayer)
	exports.bone_attach:attachElementToBone(mec[thePlayer],thePlayer,3,-0.01, 0.5, 0.35, 0, 0, 275) 
    --exports["bone_attach"]:attachElementToBone(mec2[thePlayer],thePlayer, 13, 0.12, 0.06, 0.06, 190, 0, 190)
	
	
	setElementData(thePlayer, "setAttachMecOFF", false)
	end
	else
	--setPedAnimation(thePlayer, "CARRY", "crry_prtial", 300, false, false, true, true)
	setPedAnimation(thePlayer, "CARRY", "crry_prtial", 0, true, false, false)
	end
end
addEvent("setAttachMec",true)
addEventHandler("setAttachMec",getRootElement(),setAttachMec)



function setAttachMecOFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "setAttachMecOFF") then
	setElementData(thePlayer, "setAttachMecOFF", true)
		setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, thePlayer)
	if isElement(mec[thePlayer]) then
	destroyElement(mec[thePlayer])
	end
	if isElement(mec2[thePlayer]) then
	destroyElement(mec2[thePlayer])
	end
	end

end
addEvent("setAttachMecOFF",true)
addEventHandler("setAttachMecOFF",getRootElement(),setAttachMecOFF)



local skin = {
	[0] = {-0.15, -0.06, 0.05, 190, 0, 190},
	[126] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[221] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[296] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[184] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[158] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[195] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[202] = {-0.13, -0.06, 0.09, 190, 0, 170},
	[165] = {-0.13, -0.06, 0.09, 190, 0, 170},
	[189] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[160] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[239] = {-0.11, -0.06, 0.09, 190, 0, 170},
	[146] = {-0.15, -0.06, 0.09, 190, 0, 170},
	[34] = {-0.14, -0.06, 0.09, 190, 0, 170},
	[236] = {-0.16, -0.02, 0.09, 190, 0, 170},
	[162] = {-0.16, -0.02, 0.09, 190, 0, 170},
	[94] = {-0.16, -0.02, 0.09, 190, 0, 170},
}

function setAttachColdri(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	if not isElement(coldri[thePlayer]) then
	--if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	local model = getElementModel(thePlayer)
	if skin[model] then
			local x,y,z = getElementPosition(thePlayer)
			coldri[thePlayer] = createObject(1510, x,y,z)
			exports["bone_attach"]:attachElementToBone(coldri[thePlayer],thePlayer, 14, skin[model][1],skin[model][2],skin[model][3],skin[model][4],skin[model][5],skin[model][6])
			setElementData(thePlayer, "setAttachColdriOFF", false)
		else
			local x,y,z = getElementPosition(thePlayer)
			coldri[thePlayer] = createObject(1510, x,y,z)
			exports["bone_attach"]:attachElementToBone(coldri[thePlayer],thePlayer, 14, -0.13, -0.06, 0.09, 190, 0, 170)
			setElementData(thePlayer, "setAttachColdriOFF", false)
			end
		end
	--end
end
addEvent("setAttachColdri",true)
addEventHandler("setAttachColdri",getRootElement(),setAttachColdri)



function setAttachColdriOFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "setAttachColdriOFF") then
	setElementData(thePlayer, "setAttachColdriOFF", true)
	if isElement(coldri[thePlayer]) then
	destroyElement(coldri[thePlayer])
	end
	end

end
addEvent("setAttachColdriOFF",true)
addEventHandler("setAttachColdriOFF",getRootElement(),setAttachColdriOFF)


local LockPick = {}

function setAttachLockPick(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not isElement(LockPick[thePlayer]) then
	if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	local x,y,z = getElementPosition(thePlayer)
	LockPick[thePlayer] = createObject(2060, x,y,z)
	setObjectScale(LockPick[thePlayer],0.7)
	exports.bone_attach:attachElementToBone(LockPick[thePlayer],thePlayer,3,-0.01, 0.5, 0.09, 0, 0, 190) 
	setElementData(thePlayer, "setAttachLockOFF", false)
	end
	else
	--setPedAnimation(thePlayer, "CARRY", "crry_prtial", 300, false, false, true, true)
	setPedAnimation(thePlayer, "CARRY", "crry_prtial", 0, true, false, false)
	end
end
addEvent("setAttachLockPick",true)
addEventHandler("setAttachLockPick",getRootElement(),setAttachLockPick)



function setAttachLockOFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "setAttachLockOFF") then
	setElementData(thePlayer, "setAttachLockOFF", true)
		setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, thePlayer)
	if isElement(LockPick[thePlayer]) then
	destroyElement(LockPick[thePlayer])
	end

	end

end
addEvent("setAttachLockOFF",true)
addEventHandler("setAttachLockOFF",getRootElement(),setAttachLockOFF)



local maconha = {}

function setAttachMaconha(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not isElement(maconha[thePlayer]) then
	if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
	local x,y,z = getElementPosition(thePlayer)
	maconha[thePlayer] = createObject(2901, x,y,z)
	setObjectScale(maconha[thePlayer],0.7)
	exports.bone_attach:attachElementToBone(maconha[thePlayer],thePlayer,3,-0.01, 0.5, 0.09, 0, 0, 190) 
	setElementData(thePlayer, "setAttachMaconhaOFF", false)
	end
	else
	--setPedAnimation(thePlayer, "CARRY", "crry_prtial", 300, false, false, true, true)
	setPedAnimation(thePlayer, "CARRY", "crry_prtial", 0, true, false, false)
	end
end
addEvent("setAttachMaconha",true)
addEventHandler("setAttachMaconha",getRootElement(),setAttachMaconha)



function setAttachMaconhaOFF(thePlayer)
	if not getElementData(thePlayer, "loggedin") then return end
	
	if not getElementData(thePlayer, "setAttachMaconhaOFF") then
	setElementData(thePlayer, "setAttachMaconhaOFF", true)
	--setPedAnimation(thePlayer)
		setTimer ( setPedAnimation, 100, 1, thePlayer,  "GHANDS", "gsign2", 5000, false, false, false)
		setTimer ( setPedAnimation, 250, 1, thePlayer)
	if isElement(maconha[thePlayer]) then
	destroyElement(maconha[thePlayer])
	end

	end

end
addEvent("setAttachMaconhaOFF",true)
addEventHandler("setAttachMaconhaOFF",getRootElement(),setAttachMaconhaOFF)




function playerquit(reason) 
	if isElement(maconha[source]) then
	destroyElement(maconha[source])
	end
	if isElement(object[source]) then
		destroyElement(object[source])
	end
	if isElement(LockPick[source]) then
	destroyElement(LockPick[source])
	end
	if isElement(mec[source]) then
	destroyElement(mec[source])
	end
	if isElement(mec2[source]) then
	destroyElement(mec2[source])
	end
	if isElement(c4[source]) then
	destroyElement(c4[source])
	end
	if isElement(coldri[source]) then
	destroyElement(coldri[source])
	end
end 
addEventHandler("onPlayerQuit",root,playerquit) 