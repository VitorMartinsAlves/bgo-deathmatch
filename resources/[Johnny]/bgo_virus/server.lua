--[[local hillArea = createColRectangle(-1896.5686035156,847.81958007813, 100, 100)

function hill_Enter(thePlayer, matchingDimension)
	if getElementType(thePlayer) == "player" then
		local rand = math.random(1,5)
		setElementData(thePlayer, "zaraza", getElementData(thePlayer, "zaraza") + rand)
		outputChatBox("Você tem #FFFF00"..rand.." #FFFFFFunidades de infecção do corona virus", thePlayer, 255, 255, 255, true)
	end
end
addEventHandler("onColShapeHit", hillArea, hill_Enter)
]]--


			

function onPlayerTakeEat (row)
    local name, price, healt = unpack(row)
	if getElementData(source,"char:money") >= price then
        outputChatBox("Você comprou com sucesso "..name.." por "..price..".",source,255,255,255,true)
		--takePlayerMoney(source, price)
		setElementData(source,"char:money", getElementData(source,"char:money") - price)
	
		--setElementHealth(source, getElementHealth(source) + healt)
		setElementData(source, "zaraza", getElementData(source,"zaraza") - healt )
		if getElementData(source,"zaraza") <= 0 then
		    setElementData(source, "zaraza", 0)
		end
		setPedAnimation (source,"FOOD","EAT_Burger", -1, false, false)
	else
        outputChatBox("Dinheiro insuficiente.",source,255,255,255,true)
	end
end
addEvent("onPlayerTakeEat", true)
addEventHandler("onPlayerTakeEat", getRootElement(), onPlayerTakeEat)

function onResourceStart ()
	 for i, v in ipairs (markers) do
	    local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", 1.5, 0, 150, 150, 150)
		setElementData(marker, "enter", true)
		--local blip = createBlipAttachedTo(marker, 10)
		--setBlipVisibleDistance(blip, 400)
	end
end
addEventHandler("onResourceStart", getResourceRootElement( getThisResource() ), onResourceStart)

function onMarkerHit (player)  
    if getElementType(player) ~= "player" then return end if isPedInVehicle(player) then return end
	if getElementData(source, "enter") then
        triggerClientEvent(player, "openMainMenu", player)
	end
end
addEventHandler("onMarkerHit", getRootElement(), onMarkerHit)

addEventHandler("onPlayerQuit", getRootElement(), 
    function ()
	    local account = getPlayerAccount(source)
	    setAccountData(account, "zaraza", getElementData(source, "zaraza") )
	end
)

addEventHandler("onPlayerLogin", getRootElement(), 
    function (_,account)
	   -- setElementData(source,"isPlayerLogin", true)
	    setElementData(source, "zaraza", (getAccountData(account, "zaraza") or 0))
	end
)