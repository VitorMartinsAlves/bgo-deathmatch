setDevelopmentMode(true)

local maskFX = [[
texture MainTexture;
texture MaskTexture;
texture FoamTexture;

float4 MainColor = float4(1, 1, 1, 1);
float4 MaskColor = float4(1, 1, 1, 0);

sampler SamplerTexture = sampler_state
{
	Texture = (MainTexture);
	MinFilter = Linear;
	MagFilter = Linear;
	MipFilter = Linear;
};

sampler SamplerMask = sampler_state
{
	Texture = (MaskTexture);
	MinFilter = Linear;
	MagFilter = Linear;
	MipFilter = Linear;
	AddressU	= Clamp;
	AddressV = Clamp;
};

sampler SamplerFoam = sampler_state
{
	Texture = (FoamTexture);
	MinFilter = Linear;
	MagFilter = Linear;
	MipFilter = Linear;
	AddressU	= Clamp;
	AddressV = Clamp;
};

struct PSInput
{
	float2 TextureCoordinate : TEXCOORD0;
};

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
	float2 mainPosition = PS.TextureCoordinate.xy;

	float4 mainPixel = tex2D(SamplerTexture, mainPosition);
	float4 maskPixel = tex2D(SamplerMask, mainPosition);
	float4 foamPixel = tex2D(SamplerFoam, mainPosition);

	float4 finalColor = mainPixel + foamPixel;

	float4 color1 = MaskColor * maskPixel.r;
	float4 color2 = MainColor * (1 - maskPixel.r);

	finalColor *= (color1 + color2);

	return saturate(finalColor);
}

technique Mask
{
	pass P0
	{
		AlphaBlendEnable = true;
		SrcBlend = SrcAlpha;
		DestBlend = InvSrcAlpha;
		PixelShader = compile ps_2_0 PixelShaderFunction();
	}
}

technique Fallback
{
	pass P0
	{

	}
}
]]

local screenX, screenY = guiGetScreenSize()



local jobNPC = nil
local jobActive = false

local platform = nil
local platformHead = nil
local platformCol = nil

local buttons = {}
local activeButton = nil

local windowW = 500
local windowH = 350
local windowX = screenX / 2 - windowW / 2
local windowY = screenY / 2 - windowH / 2

local dirtyTextureId = false
local dirtyTextures = {
	[1] = dxCreateTexture("files/dirty1.png", "argb", true, "clamp"),
	[2] = dxCreateTexture("files/dirty2.png", "argb", true, "clamp"),
	[3] = dxCreateTexture("files/dirty3.png", "argb", true, "clamp"),
	[4] = dxCreateTexture("files/dirty4.png", "argb", true, "clamp"),
	[5] = dxCreateTexture("files/dirty5.png", "argb", true, "clamp")
}

local maskRenderTarget = dxCreateRenderTarget(windowW, windowH, true)
local maskShader = dxCreateShader(maskFX, 0, 0, false, "other")
local maskTexture = dxCreateTexture("files/mask.png")
local maskWidth = 195
local maskHeight = 60

local foamRenderTarget = dxCreateRenderTarget(windowW, windowH, true)
local foamTexture = dxCreateTexture("files/foam.png")
local foamWidth = 100
local foamHeight = 100

local lastCursorX = 0
local lastCursorY = 0

local lastProgressCheck = 0
local lastFoamCheck = 0

local cleaningProgress = 0
local dirtnessProgress = 0
local foamProgress = 0
local requiredProgress = 95

local currentPlaySound = false
local currentSoundType = false

local successNotificationState = false


function createPlatform(dim)
	platform = createObject(10872, defaultPosition[1], defaultPosition[2], defaultPosition[3], 0, 0, 90)
	setElementDimension(platform, dim)

	platformCol = createColCuboid(defaultPosition[1] - 1.265624 / 2, defaultPosition[2] - 5.19531 / 2, defaultPosition[3] - 2.78906 / 2, 1.265624, 5.19531, 2.78906)
	setElementDimension(platformCol, dim)	

	attachElements(platformCol, platform, -5.19531 / 2, 1.265624 / 2, -2.78906 / 2)

	setElementPosition(localPlayer, defaultPosition[1], defaultPosition[2], defaultPosition[3] + 0.2)

	addEventHandler("onClientRender", root, renderPlatformLine)
end

function destroyPlatform()
	if isElement(platform) then
		destroyElement(platform)
	end

	if isElement(platformHead) then
		destroyElement(platformHead)
	end

	if isElement(platformCol) then
		destroyElement(platformCol)
	end

	removeEventHandler("onClientRender", root, renderPlatformLine)
end

function generateDirtyWindow()
	local newTextureId = dirtyTextureId

	while newTextureId == dirtyTextureId do
		newTextureId = math.random(1, #dirtyTextures)
	end

	dirtyTextureId = newTextureId
	cleaningProgress = 0
	dirtnessProgress = 0
	foamProgress = 0

	if dirtyTextureId then
		dxSetRenderTarget(maskRenderTarget, true)
		dxSetRenderTarget()

		dxSetRenderTarget(foamRenderTarget, true)
		dxSetRenderTarget()

		dxSetShaderValue(maskShader, "MainTexture", dirtyTextures[dirtyTextureId])
		dxSetShaderValue(maskShader, "MaskTexture", maskRenderTarget)
		dxSetShaderValue(maskShader, "FoamTexture", foamRenderTarget)

		dirtnessProgress = checkDirtiness()
		successNotificationState = false
	end
end

function checkDirtiness()
	local pixelCounter = 0

	if isElement(dirtyTextures[dirtyTextureId]) then
		local pixels = dxGetTexturePixels(dirtyTextures[dirtyTextureId])

		for i = 0, 1, 0.1 do
			for j = 0, 1, 0.1 do
				local r, g, b, a = dxGetPixelColor(pixels, i * windowW, j * windowH)

				if r ~= 0 or g ~= 0 or b ~= 0 or a ~= 0 then
					pixelCounter = pixelCounter + 1

					if pixelCounter > 100 then
						pixelCounter = 100
						break
					end
				end
			end
		end
	end

	return pixelCounter
end

function checkCleaningProgress()
	if isElement(maskRenderTarget) then
		if getTickCount() - lastProgressCheck > 100 then
			local pixels = dxGetTexturePixels(maskRenderTarget)

			cleaningProgress = 0

			for i = 0, 1, 0.1 do
				for j = 0, 1, 0.1 do
					local r, g, b, a = dxGetPixelColor(pixels, i * windowW, j * windowH)

					if r == 255 and g == 255 and b == 255 and a == 255 then
						cleaningProgress = cleaningProgress + 1
					end
				end
			end

			lastProgressCheck = getTickCount()
		end
	end
end

function checkFoam()
	if isElement(foamRenderTarget) then
		if getTickCount() - lastFoamCheck > 100 then
			local pixels = dxGetTexturePixels(foamRenderTarget)

			foamProgress = 0

			for i = 0, 1, 0.1 do
				for j = 0, 1, 0.1 do
					local r, g, b, a = dxGetPixelColor(pixels, i * windowW, j * windowH)

					if r == 255 and g == 255 and b == 255 and a == 255 then
						foamProgress = foamProgress + 1
					end
				end
			end

			lastFoamCheck = getTickCount()
		end
	end
end

local generatedPosition = {}

local Roboto = dxCreateFont("files/Roboto.ttf", 12)

local panelW, panelH = 200, 230
local panelX, panelY = 10, (screenY - panelH) * 0.5

local iconS = 70

function renderPlatformController()
	if not showWindow and isElementWithinColShape(localPlayer, platformCol) and jobActive then
		local absX, absY = getCursorPosition()

		if isCursorShowing() then
			absX = absX * screenX
			absY = absY * screenY
		else
			absX, absY = -1, -1
		end

		buttons = {}

		dxDrawRectangle(panelX, panelY, panelW, panelH, tocolor(46, 46, 46))
		dxDrawRectangle(panelX, panelY, panelW, 20, tocolor(35, 35, 35))
		dxDrawText("operador de elevador", panelX, panelY + 2, panelX + panelW, panelY + panelH, tocolor(255, 255, 255), 0.75, Roboto, "center")

		local iconX, iconY = panelX + 10, panelY + (panelH - iconS) * 0.5 - 10

		dxDrawImage(iconX, iconY, iconS, iconS, "files/arrow.png", 180, 0, 0, activeButton == "left" and tocolor(35, 115, 148) or tocolor(255, 255, 255))
		buttons["left"] = {iconX, iconY, iconS, iconS}
		dxDrawImage(iconX + panelW - iconS - 20, iconY, iconS, iconS, "files/arrow.png", 0, 0, 0, activeButton == "right" and tocolor(35, 115, 148) or tocolor(255, 255, 255))
		buttons["right"] = {iconX + panelW - iconS - 20, iconY, iconS, iconS}

		iconX = panelX + (panelW - iconS) * 0.5
		iconY = panelY + 20

		dxDrawImage(iconX, iconY, iconS, iconS, "files/arrow.png", 270, 0, 0, activeButton == "up" and tocolor(35, 115, 148) or tocolor(255, 255, 255))
		buttons["up"] = {iconX, iconY, iconS, iconS}
		dxDrawImage(iconX, iconY + iconS + 30, iconS, iconS, "files/arrow.png", 90, 0, 0, activeButton == "down" and tocolor(35, 115, 148) or tocolor(255, 255, 255))
		buttons["down"] = {iconX, iconY + iconS + 30, iconS, iconS}

		if isElement(platform) then
			local oX, oY, oZ = getElementPosition(platform)

			dxDrawText("Coordenadas atuais:\n Largura: " .. math.floor(oY) .. " - altura: " .. math.floor(oZ), panelX, panelY, panelX + panelW, panelY + panelH - 5, tocolor(255, 255, 255), 0.75, Roboto, "center", "bottom")
			
			dxDrawText("Vá em frente" .. generatedPosition[1] .. " (largura), " .. generatedPosition[2] .. " (altura)#ffffff coordenadas", 0, screenY - 50, screenX, screenY, tocolor(255, 255, 255), 1, Roboto, "center", "top", false, false, false, true)
		end

		activeButton = false

		if isCursorShowing() then
			for k, v in pairs(buttons) do
				if absX >= v[1] and absX <= v[1] + v[3] and absY >= v[2] and absY <= v[2] + v[4] then
					activeButton = k
					break
				end
			end
		end
	end
end


				
				
local tempCol = createColSphere (2495.7087402344,-1642.3995361328,13.782609939575, 2 )

function onClientColShapeHit( theElement, matchingDimension )
    if ( theElement == localPlayer ) then
		addEventHandler("onClientRender", root, renderWindow)
		generateDirtyWindow()
		showWindow = true
		--showCursor (true)
		triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GRAFFITI", "spraycan_fire", 20000, false, false)
		setElementRotation(localPlayer, 0, 0, 0.85879820585251)
    end
end
addEventHandler("onClientColShapeHit", tempCol, onClientColShapeHit)


function onClientColShapeLeave( theElement, matchingDimension )
    if ( theElement == localPlayer ) then
			removeEventHandler("onClientRender", root, renderWindow)
			showWindow = false
			--showCursor(false)
			triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GRAFFITI", "spraycan_fire", 100, false, false)
    end
end
addEventHandler("onClientColShapeLeave", tempCol, onClientColShapeLeave)




local windowW, windowH = 500, 350
local windowX, windowY = (screenX - windowW) * 0.5, (screenY - windowH) * 0.5

function renderWindow()
	dxDrawRectangle(windowX, windowY, windowW, windowH, tocolor(0, 174, 255, 100)) -- üveg

	dxDrawRectangle(windowX - 4, windowY - 4, windowW + 8, 4, tocolor(0, 0, 0)) -- felső
	dxDrawRectangle(windowX - 4, windowY + windowH, windowW + 8, 4, tocolor(0, 0, 0)) -- alsó
	dxDrawRectangle(windowX - 4, windowY, 4, windowH, tocolor(0, 0, 0)) -- bal
	dxDrawRectangle(windowX + windowW, windowY, 4, windowH, tocolor(0, 0, 0)) -- jobb

	dxSetBlendMode("add")
	dxDrawImage(windowX, windowY, windowW, windowH, maskShader)
	dxSetBlendMode("blend")

	local cursorX, cursorY = getCursorPosition()

	if cursorX then
		cursorX = cursorX * screenX
		cursorY = cursorY * screenY

		local spriteRotation = math.deg(math.atan2(-cursorY, cursorX - windowX - windowW / 2)) + 90

		if getDistanceBetweenPoints2D(cursorX, cursorY, lastCursorX, lastCursorY) > 1 then
			local cleanKeyState = getKeyState("mouse1")
			local sprayKeyState = getKeyState("mouse2")

			if cleanKeyState or sprayKeyState then
				local cursorMiddleX = cursorX + (lastCursorX - cursorX) / 2
				local cursorMiddleY = cursorY + (lastCursorY - cursorY) / 2

				if cleanKeyState then
					if foamProgress >= 75 then
						local x = cursorMiddleX - windowX - maskWidth / 2
						local y = cursorMiddleY - windowY - maskHeight / 2

						dxSetRenderTarget(maskRenderTarget)
						dxSetBlendMode("modulate_add")
						dxDrawImage(x, y, maskWidth, maskHeight, maskTexture, spriteRotation)
						dxSetBlendMode("blend")
						dxSetRenderTarget()
						dxSetShaderValue(maskShader, "MaskTexture", maskRenderTarget)

						if currentSoundType ~= "wiping" then
							currentSoundType = "wiping"

							if isElement(currentPlaySound) then
								destroyElement(currentPlaySound)
							end

							currentPlaySound = playSound("files/wiping.mp3", true)
						end
					end
				elseif sprayKeyState then
					local x = cursorMiddleX - windowX - foamWidth / 2
					local y = cursorMiddleY - windowY - foamHeight / 2

					dxSetRenderTarget(maskRenderTarget)
					dxDrawImage(x, y, foamWidth, foamHeight, foamTexture, spriteRotation, 0, 0, tocolor(0, 0, 0))
					dxSetRenderTarget()
					dxSetShaderValue(maskShader, "MaskTexture", maskRenderTarget)

					dxSetRenderTarget(foamRenderTarget)
					dxSetBlendMode("modulate_add")
					dxDrawImage(x, y, foamWidth, foamHeight, foamTexture, spriteRotation)
					dxSetBlendMode("blend")
					dxSetRenderTarget()
					dxSetShaderValue(maskShader, "FoamTexture", foamRenderTarget)

					if currentSoundType ~= "spraying" then
						currentSoundType = "spraying"

						if isElement(currentPlaySound) then
							destroyElement(currentPlaySound)
						end

						currentPlaySound = playSound("files/spraying.mp3", true)
					end
				else
					if isElement(currentPlaySound) then
						destroyElement(currentPlaySound)
						currentPlaySound = nil
					end

					currentSoundType = false

				end

				checkCleaningProgress()
				checkFoam()
			else
				if isElement(currentPlaySound) then
					destroyElement(currentPlaySound)
					currentPlaySound = nil
				end

				currentSoundType = false
			end
		end

		if currentSoundType == "wiping" then
			local rotatedX, rotatedY = rotateAround(spriteRotation, 0, 64)

			dxDrawImage(cursorX - 104 + rotatedX, cursorY - 104 + rotatedY, 208, 208, "files/wiper.png", spriteRotation)
		elseif currentSoundType == "spraying" then
			local rotatedX, rotatedY = rotateAround(spriteRotation, 50, 75)

			dxDrawImage(cursorX - 104 + rotatedX, cursorY - 104 + rotatedY, 208, 208, "files/spray.png", spriteRotation)
		end

		lastCursorX = cursorX
		lastCursorY = cursorY
	end

	local remainingProgress = math.max(0, requiredProgress - cleaningProgress)
	
	if foamProgress == 0 then
		tippText = "Primeiro, jogue na janela o detergente, pelo menos 75% para começar a limpar"
	elseif cleaningProgress > 0 then
		tippText = "Status de limpeza: " .. cleaningProgress .. "%"
	elseif foamProgress >= 75 then
		tippText = "Comece a limpar a janela, pelo menos " .. requiredProgress .. "%"
	elseif foamProgress > 0 then
		tippText = "Status da limpeza: " .. foamProgress .. "%"
	end

	dxDrawText("" .. tippText, 0, screenY - 150 - dxGetFontHeight(1, Roboto) - 5, screenX, screenY, tocolor(255, 255, 255), 1, Roboto, "center", "top", false, false, false, true)
	dxDrawText("Você pode jogar detergente na janela com o botão direito do mouse, você pode limpar a janela com o botão direito do mouse", 0, screenY - 150, screenX, screenY, tocolor(255, 255, 255), 1, Roboto, "center", "top", false, false, false, true)
	

	if remainingProgress == 0 then
		if not successNotificationState then
			successNotificationState = true
			outputChatBox("Você limpou a janela com sucesso!", 0, 255, 0)
			setPedAnimation(localPlayer)
			triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GRAFFITI", "spraycan_fire", 100, false, false)
			removeEventHandler("onClientRender", root, renderWindow)
			showWindow = false
			if isElement(currentPlaySound) then
				destroyElement(currentPlaySound)
			end
		end
	end
end


local hydrSound = nil


function stopJob()
	jobActive = false

	removeEventHandler("onClientRender", root, renderPlatformController)
	removeEventHandler("onClientPreRender", root, preRenderMove)

	if showWindow then
		showWindow = false
		removeEventHandler("onClientRender", root, renderWindow)
	end
end



function rotateAround(angle, offsetX, offsetY, baseX, baseY)
	angle = math.rad(angle)

	offsetX = offsetX or 0
	offsetY = offsetY or 0

	baseX = baseX or 0
	baseY = baseY or 0

	return baseX + offsetX * math.cos(angle) - offsetY * math.sin(angle),
			 baseY + offsetX * math.sin(angle) + offsetY * math.cos(angle)
end
