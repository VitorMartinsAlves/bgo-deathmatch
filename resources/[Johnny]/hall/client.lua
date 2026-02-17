local shader
local sound
local signTroll = {}
local signLastTick = getTickCount()
local signIds = 1
local cena=false

local function renderCena()

	if getTickCount() - signLastTick < 100 then return end
	signIds = signIds + 1
	if signIds > 20 then
		signIds = 1
	end
	dxSetShaderValue ( shader, "gTexture", signTroll[signIds] )
	signLastTick = getTickCount()

end

local function stopCena()

	if not cena then return end
	removeEventHandler( "onClientHUDRender",root,renderCena)
	if isElement(shader) then destroyElement(shader) end
	if isElement(sound) then destroyElement(sound) end
	cena = false
	
end

local function startCena()

	if cena then return end
	signLastTick = getTickCount()
	signIds = 1
	shader = dxCreateShader("shader.fx")
	engineApplyShaderToWorldTexture ( shader, "*" )
	addEventHandler( "onClientHUDRender",root,renderCena)
	sound = playSound("sounds/cena.mp3", true)
	setSoundVolume(sound, 1.0)
	cena=true

end

local function initCena()

	for i=1,20 do
		local texture = dxCreateTexture("images/"..tostring(i)..".JPG")
		table.insert(signTroll,texture)
	end
	
	addEvent("startCena",true)
	addEvent("stopCena",true)
	addEventHandler("startCena",localPlayer,startCena)
	addEventHandler("stopCena",localPlayer,stopCena)

end

addEventHandler("onClientResourceStart",resourceRoot,initCena)