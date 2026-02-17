
--------------------
---SZERVER BLIPEK---
--------------------

local _createBlip = createBlip
function createBlip(x,y,z,i,tooltip,value,screens)
	local blip = _createBlip(x,y,z,i)
	setBlipColor(blip, 255, 255, 255, 255)
	setBlipOrdering(blip,  -1)
	setElementData(blip, "blip.nev", tooltip)
	setElementData(blip, "blip:maxVisible", value)
	setElementData(blip, "blip >> blipOnScreen",screens)
	return blip
end
addEvent("createBlip",true)
addEventHandler("createBlip",getRootElement(),createBlip)