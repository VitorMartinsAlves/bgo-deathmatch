local kepS = {guiGetScreenSize()}
local celkereszt = getElementData(localPlayer,"char >> weaponk") or 5

function celkeresztRender()
	if getElementData(getLocalPlayer(), "loggedin") == false then return end -- Csak akkor rendereljük ha a játékos belépett :)
	local fegyverSlot = getPedWeaponSlot ( localPlayer )
	local weaponType = getPedWeapon (localPlayer )

	if(fegyverSlot > 1 and fegyverSlot < 7) then
	
	if weaponType == 22 then 
	setPlayerHudComponentVisible ("crosshair", false)
	return end
	if weaponType == 34 then 
	setPlayerHudComponentVisible ("crosshair", true)
	return end
	
		setPlayerHudComponentVisible ("crosshair", false)
	
		local celkeresztMeret = 0.3
		local celkeresztP = {25,25}
		local hX,hY,hZ = getPedTargetEnd ( getLocalPlayer() )
		local kep1, kep2 = getScreenFromWorldPosition ( hX,hY,hZ )
		if(kep1 and kep2) then
			celkereszt = getElementData(localPlayer,"char >> weaponk") or 5
			dxDrawImage(kep1-celkeresztP[1]/2,kep2-celkeresztP[2]/2,celkeresztP[1],celkeresztP[2], "img/"..celkereszt..".png")
		end
		else
		setPlayerHudComponentVisible ("crosshair", true)
	end
end

function getCelkereszt()
	celk = getElementData(localPlayer,"char >> weaponk") or 5
	return ":bgo_mira/img/"..celk..".png"
end

local function amikorAJatekosCeloz (_, statusz)
	if statusz == "down" then 
		addEventHandler ("onClientHUDRender", getRootElement (), celkeresztRender)
	else 
		removeEventHandler ("onClientHUDRender", getRootElement (), celkeresztRender)
	end
end

addEventHandler ("onClientResourceStart", getResourceRootElement (getThisResource ()),
	function () 
		bindKey ("aim_weapon", "both", amikorAJatekosCeloz)
	end)
	
addEventHandler ("onClientResourceStop", getResourceRootElement (getThisResource ()),
	function ()
		unbindKey ("aim_weapon", "both", amikorAJatekosCeloz)
	end)
	
	