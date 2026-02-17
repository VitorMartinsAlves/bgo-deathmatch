availablePaintJobs = {
	[490] = {
			{'*Plotagem*', 'textures/bope.png'}, -- 1
			{'*Plotagem*', 'textures/choque.png'}, -- 2
			{'*Plotagem*', 'textures/core.png'},  -- 3
			{'*Plotagem*', 'textures/exercito.png'}, -- 4
			{'*Plotagem*', 'textures/federal.png'}, -- 5
			{'*Plotagem*', 'textures/forca.png'}, -- 6
			{'*Plotagem*', 'textures/marinha.png'}, -- 7
			{'*Plotagem*', 'textures/PMRJ_1BPM.png'}, -- 8
			{'*Plotagem*', 'textures/PMRJ_6BPM.png'}, -- 9
			{'*Plotagem*', 'textures/PMRJ_7BPM.png'}, -- 10
			{'*Plotagem*', 'textures/PMRJ_RECOM.png'}, -- 11
			{'*Plotagem*', 'textures/PMRJ_UPP.png'}, -- 12
	},	
};

local shaders = {}
local elementShaders = {}
local textureCache = {}
local textureCount = {}
local textureSize = 768

function applyShader(texture, img, distance, element)
	if element then
		destroyShaderCache(element)
	end
	local this = #shaders + 1
	shaders[this] = {}
	shaders[this][1] = dxCreateShader("texturechanger.fx",0,distance,layered)
	if not textureCount[img] then
		textureCount[img] = 0
	end
	if textureCount[img] == 0 then
		textureCache[img] = dxCreateTexture(img)
	end
	textureCount[img] = textureCount[img] + 1
	shaders[this][2] = textureCache[img]
	shaders[this][3] = texture
	if element then
		if not elementShaders[element] then
			elementShaders[element] = {shaders[this], img}
		end
	end
	if shaders[this][1] and shaders[this][2] then
		dxSetShaderValue(shaders[this][1], "TEXTURE", shaders[this][2])
		engineApplyShaderToWorldTexture(shaders[this][1], texture, element)
	end
end

function destroyShaderCache(element)
	if elementShaders[element] then
		destroyElement(elementShaders[element][1][1])
		local old_img = elementShaders[element][2]
		textureCount[old_img] = textureCount[old_img] - 1
		if textureCount[old_img] == 0 then
			destroyElement(elementShaders[element][1][2])
		end
		elementShaders[element] = nil
	end
end
addEvent("destroyShaderCache", true)
addEventHandler("destroyShaderCache", root, destroyShaderCache)


addEventHandler("onClientResourceStart", resourceRoot, function()
	for k,v in ipairs(getElementsByType("vehicle", root, true)) do
		local pj = tonumber(getElementData(v, "tuning.paintjob")) or 0
		if pj > 0 then
			addVehiclePaintJob(v, getElementModel(v), pj)
		end
	end
end)

function getVehiclePaintJobs(model)
	if availablePaintJobs[model] then
		return #availablePaintJobs[model]
	else
		return 0
	end
end

function addVehiclePaintJob(veh, model, id)
	local pj = availablePaintJobs[model]
	if pj then
		local pj = pj[id]
		if pj then
			applyShader(pj[1], pj[2], 100, veh)
		end
	end
end
addEvent("addVehiclePaintJob", true)
addEventHandler("addVehiclePaintJob", root, addVehiclePaintJob)

addEventHandler("onClientElementDestroy", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		destroyShaderCache(source)
	end
end)

addEventHandler("onClientElementStreamIn", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		local pj = tonumber(getElementData(source, "tuning.paintjob")) or 0
		if pj > 0 then
			addVehiclePaintJob(source, getElementModel(source), pj)
		end
	end
end)

addEventHandler("onClientElementStreamOut", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		destroyShaderCache(source)
	end
end)

addCommandHandler("t", function(cmd,id)
	if tonumber(getElementData(localPlayer, "acc:admin")) > 9 then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then
			local id = tonumber(id) or 0
			local model = getElementModel(veh)
			if availablePaintJobs[model] and availablePaintJobs[model][id] then
				setElementData(veh, "tuning.paintjob", id)
				triggerServerEvent("addVehiclePaintJob", localPlayer, veh, model, id, true)
			end
		end
	end
end)