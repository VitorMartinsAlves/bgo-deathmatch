addEvent("give:dipiroca",true)
addEventHandler("give:dipiroca",root,
function(quant)
    money = getElementData(source,"char:money") or 0
    if money >= quant * 800 then
               if exports.bgo_items:giveItem(source, 27, 1, quant, 0, true) then 
                local linha = math.random(1, 255 )
                exports.bgo_hud:drawNote("Dipiroca"..linha.."", "Dipiroca comprado com sucesso", source, 255, 255, 255, 7000)
                setElementData(source, "char:money", money - quant * 800)
               else
                   outputChatBox("", source)  
               end
       end


end)




amount = 3
local element = {}
allAmbiMarkers = {}
ambiMarkers = { 
	[1] = {309.96139526367, -1515.4154052734, 36.0390625},
}



for i = 1, #ambiMarkers, 1 do
element["MARKERPRO"..i] = createMarker(ambiMarkers[i][1], ambiMarkers[i][2],ambiMarkers[i][3]-0.9, "cylinder",1, 255, 0, 0, 100)
local m = element["MARKERPRO"..i]


--local myBlip = createBlipAttachedTo ( m, 56 )
--setElementData(myBlip ,"blipName", "Comércio")

addEventHandler("onMarkerHit",m,
function(hitElement)
if (getElementType(hitElement) == "player") then
		if not isPedInVehicle(hitElement) then
            triggerClientEvent(hitElement,"loja:remedioON",hitElement)
	end
end
end)

addEventHandler("onMarkerLeave",m,
function(hitElement)
if (getElementType(hitElement) == "player") then
		if not isPedInVehicle(hitElement) then
			triggerClientEvent(hitElement,"loja:remedioOFF",hitElement)
	end
end
end)
end