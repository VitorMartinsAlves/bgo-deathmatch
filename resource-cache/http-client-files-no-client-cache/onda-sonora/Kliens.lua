

local x, y = guiGetScreenSize ()
local samples = 156

function renderWave ()
    if (isElement (localPlayer)) then
        local waveData = getSoundWaveData (localPlayer, 2048)

        for i=0, samples-1 do
            if (waveData) then -- Avoid NaN values.
                dxDrawRectangle ((x-samples)+i, y-128, 1, waveData[i] * 128)
            end
		end
    end
end
addEventHandler ("onClientRender", root, renderWave)