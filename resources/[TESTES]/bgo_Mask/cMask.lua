
mask = {}
mask2 = {}
maskTable = {
	[1] = {ID = 1667, size = 1, dff = "mask/joker.dff", txd = "mask/joker.txd", posX = 0, posY = -0.002, posZ = -0.599, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
	[2] = {ID = 1666, size = 1, dff = "mask/botfan.dff", txd = "mask/botfan.txd", posX = 0, posY = 0, posZ = -0.6, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
	[3] = {ID = 1455, size = 1, dff = "mask/halloween.dff", txd = "mask/halloween.txd", posX = 0, posY = -0.002, posZ = -0.62, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
	[4] = {ID = 1484, size = 1, dff = "mask/gasmask.dff", txd = "mask/gasmask.txd", posX = 0, posY = -0.002, posZ = -0.60, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
	[5] = {ID = 1880, size = 1, dff = "mask/doge.dff", txd = "mask/doge.txd", posX = -0.03, posY = -0.001, posZ = -0.55, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
	[6] = {ID = 1665, size = 1, dff = "mask/horse.dff", txd = "mask/horse.txd", posX = 0, posY = -0.002, posZ = -0.60, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
	[7] = {ID = 1486, size = 1, dff = "mask/majora.dff", txd = "mask/majora.txd", posX = 0, posY = -0.002, posZ = -0.60, rotX = 0, rotY = 0, rotZ = 180, altura = -0.60},
	[8] = {ID = 1747, size = 1, dff = "mask/helmet3.dff", txd = "mask/helmet3.txd", posX = 0, posY = 0.03, posZ = 0.07, rotX = 0.75, rotY = 0, rotZ = 180, altura = -0.60},	
	--[9] = {ID = 2228, dff = "mask/helmet.dff", txd = "mask/helmet.txd", posX = 0, posY = 0.03, posZ = 0.07, rotX = 0.75, rotY = 0, rotZ = 180}
	
	[9] = {ID = 2228, size = 1, dff = "mask/helmet.dff", txd = "mask/helmet.txd", posX = 0, posY = -0.002, posZ = -0.60, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},
		
	[10] = {ID = 2890, size = 1, dff = "mask/abobora.dff", txd = "mask/abobora.txd", posX = 0, posY = -0.002, posZ = -0.60, rotX = 0, rotY = 0, rotZ = 90, altura = -0.60},

	[11] = {ID = 1920, size = 1.01,  dff = "mask/gorro.dff", txd = "mask/gorro.txd", staffy = 0.009, posX = 0.009, posY = -0.04, posZ = -0.59, rotX = -0.5, rotY = 0, rotZ = 89, altura = -0.60, frente = 0},


	[12] = {ID = 1905, size = 1.19,  dff = "mask/coelho.dff", txd = "mask/coelho.txd",  posX = -0.001, posY = -0.05, posZ = -0.4, rotX = 100, rotY = 0, rotZ = 180, altura = -0.33, lado = -0.002},

	[13] = {ID = 1899, size = 0.9,  dff = "mask/Rena.dff", txd = "mask/Rena.txd",  posX = 0.85, posY = 0.01, posZ = -0.49, rotX = 0, rotY = 0, rotZ = 180, altura = -0.56, lado = 0.942},
}

addEventHandler("onClientResourceStart", resourceRoot,
function()
	for i, mask in pairs(maskTable) do
		--[[
		local dff = engineLoadDFF(mask.dff, mask.ID)
		local txd = engineLoadTXD(mask.txd)
		if (txd) then
			engineImportTXD(txd, mask.ID)
		end
		if (dff) then
			engineReplaceModel(dff, mask.ID)
		end]]-- 
		dff = engineLoadDFF(mask.dff, mask.ID)
		txd = engineLoadTXD(mask.txd)
		engineImportTXD(txd, mask.ID)
		engineReplaceModel(dff, mask.ID)

		--engineSetModelLODDistance(mask.ID, 200)
	end
end)

function addMask(player, id)
	local id = tonumber(id)
	if (player) and (id) then
	if getElementModel(player) == 0 then
		removeMask(player)
		local x, y, z = getElementPosition(player)
		mask[player] = createObject(maskTable[id].ID, x, y, z)				
				
		setObjectScale(mask[player], 1)
		setElementData(mask[player], "id:mask", id)
		
		exports.bone_attach:attachElementToBone(
		mask[player], 
		player, 
		1, 
		maskTable[id].lado, 
		maskTable[id].frente, 
		maskTable[id].altura,
		maskTable[id].rotX,
		maskTable[id].rotY,
		maskTable[id].rotZ
		)

	else
		if getElementModel(player) == 217 then
		removeMask(player)
		local x, y, z = getElementPosition(player)
		mask[player] = createObject(maskTable[id].ID, x, y, z)
		setObjectScale(mask[player], maskTable[id].size)
		setElementData(mask[player], "id:mask", id)
		exports.bone_attach:attachElementToBone(
		mask[player], 
		player, 
		1, 
		maskTable[id].posX, 
		maskTable[id].staffy, 
		maskTable[id].posZ,
		maskTable[id].rotX,
		maskTable[id].rotY,
		maskTable[id].rotZ
		)
		else
		removeMask(player)
		local x, y, z = getElementPosition(player)
		mask[player] = createObject(maskTable[id].ID, x, y, z)
		setObjectScale(mask[player], maskTable[id].size)
		setElementData(mask[player], "id:mask", id)
		exports.bone_attach:attachElementToBone(
		mask[player], 
		player, 
		1, 
		maskTable[id].posX, 
		maskTable[id].posY, 
		maskTable[id].posZ,
		maskTable[id].rotX,
		maskTable[id].rotY,
		maskTable[id].rotZ
		)
		end
		end
	end
end

function removeMask(player)
	if (player) then
		if (mask[player]) then
			if (exports.bone_attach:isElementAttachedToBone(mask[player])) then
				setElementData(mask[player], "id:mask", nil)
				exports.bone_attach:detachElementFromBone(mask[player])
				if isElement(mask[player]) then destroyElement(mask[player]) end
				mask[player] = nil
			end
		end
	end
end

addEvent("removeMask", true)
addEventHandler("removeMask", root,
function()
	removeMask(source)
end)

addEvent("addMask", true)
addEventHandler("addMask", root,
function(id)
	if (id == 0) then return removeMask(source); end
	if (maskTable[id]) then
		addMask(source, id)
	end
end)




function cairmask(player)
	if (player) then
		if (mask[player]) then
			if (exports.bone_attach:isElementAttachedToBone(mask[player])) then
				exports.bone_attach:detachElementFromBone(mask[player])
				if isElement(mask[player]) then 
				destroyElement(mask[player])
				end
			end
		end
	end
end
 

addEvent("cairmask", true)
addEventHandler("cairmask", root,
function()
	cairmask(source)
end)






function commascara(p)
	if (mask[p]) then
		return true
	end
	return false
end
