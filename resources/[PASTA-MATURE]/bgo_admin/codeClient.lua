

-- Kliens fájlok törlése a kliens gépről --
if fileExists("codeClient.lua") then
	fileDelete("codeClient.lua")
end
if fileExists("codeClient.luac") then
	fileDelete("codeClient.luac")
end
-------------------------------------------

--[[
addCommandHandler("scp", -- short for 'set component position'
    function()
        local theVeh = getPedOccupiedVehicle(localPlayer)
	local getComponent = getVehicleComponents(theVeh) -- returns table with all the components of the vehicle
        if (theVeh) then
            for k in pairs (getComponent) do
		local x, y, z = getVehicleComponentPosition(theVeh, k) --get the position of the component
                setVehicleComponentPosition(theVeh, k, x+1, y+1, z+1) -- increases by 1 unit
            end
        end
    end
)]]--


local dgs = exports.dgs
local painel = {window={}, tab={}, button={}, grid={}, column={}, edit={}}

function startPanel()
if not isElement(painel.window[1])  then
	painel.window[1] = dgs:dgsCreateWindow(0, 0, 500, 400, "Analizando lista de veiculos", false)
	centerWindow(painel.window[1])
	dgs:dgsSetProperty(painel.window[1], "sizable", false)
	dgs:dgsSetProperty(painel.window[1], "font", "arial")
	painel.tab[1] = dgs:dgsCreateTabPanel(2, 2, 496, 369, false, painel.window[1])
	painel.tab[2] = dgs:dgsCreateTab("Lista", painel.tab[1])
	painel.grid[1] = dgs:dgsCreateGridList(2, 2, 492, 345, false, painel.tab[2])
	painel.column[1] = dgs:dgsGridListAddColumn(painel.grid[1], "Veiculos", 0.4)
	painel.column[2] = dgs:dgsGridListAddColumn(painel.grid[1], "ID", 0.2)
	painel.column[3] = dgs:dgsGridListAddColumn(painel.grid[1], "Preso", 0.2)
	painel.column[4] = dgs:dgsGridListAddColumn(painel.grid[1], "Dono", 0.3)
	end
end



local open = false
function fecharPainel()
		--cancelEvent()
	if isElement(painel.window[1]) then
	removeEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
		playSoundFrontEnd(20)
		destroyElement(painel.window[1])
		--showCursor(false)
		open = false
	end
end



function centerWindow(center_window)
    local screenW, screenH = dgs:dgsGetScreenSize()
    local windowW, windowH = dgs:dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgs:dgsSetPosition(center_window, x, y, false)
end




function getMyVehicles(target)	
	if not isElement(painel.window[1]) then
	startPanel()
	end
	addEventHandler("onDgsWindowClose",painel.window[1],fecharPainel)
	--showCursor(true)
	playSoundFrontEnd(20)

	myVehicles = {}
	for key, value in ipairs(getElementsByType("vehicle")) do
		if getElementData(value, "veh:owner") == getElementData(target, "acc:id") then
			table.insert(myVehicles, value)
		end
	end
	if myVehicles then
	if isElement(painel.window[1]) then
		dgs:dgsGridListClear(painel.grid[1])
		
		for key, value in ipairs(myVehicles) do
		local row = dgs:dgsGridListAddRow(painel.grid[1])
		valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
		id = getElementData(value, "veh:id")
		condicao = getElementData(value, "detranAP") --getElementData(value, "veh:oname") or ""
		
		if condicao then
		detido = "Sim"
		else
		detido = "Não"
		end
		
		dono = getElementData(value, "veh:oname") or ""
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[1], valor)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[2], id)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[3], detido)
		dgs:dgsGridListSetItemText(painel.grid[1], row, painel.column[4], dono)
		end
	end
	end
end
addEvent("checkCars", true)
addEventHandler("checkCars", root,getMyVehicles)







addEventHandler("onClientPlayerDamage", getRootElement(), --Nem sebződsz admindutyban
	function() 
		if getElementData(source, "char:adminduty") == 1 then
			cancelEvent()
		end
	end
)

function playerNotDamageinAJ() --Nem sebződsz adminjail ben.
	if getElementData(source, "adminjail") == 1 then
		cancelEvent()
		return
	end
end
addEventHandler("onClientPlayerDamage", getRootElement(), playerNotDamageinAJ)



function stopMinigunDamage ( attacker, weapon, bodypart )
	if ( weapon == 22 and getElementData(attacker, "apontararma") == true ) then
		cancelEvent() 
	elseif ( weapon == 3 ) then
		cancelEvent() 	
	elseif ( weapon == 5 ) then
		cancelEvent() 
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )


	
addEvent("lobinho", true)
addEventHandler("lobinho", root,
	function(jogador, type, xp, yp, zp, int, dim)
		if type == 1 then
		song2 = playSound3D("susp.ogg", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundMaxDistance(song2, 20)
		setSoundVolume(song2, 0.6)
		setElementInterior(song2, int)
		setElementDimension(song2, dim)
		elseif type == 2 then
		song2 = playSound3D("lobinho.ogg", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundMaxDistance(song2, 20)
		setSoundVolume(song2, 0.1)
		setElementInterior(song2, int)
		setElementDimension(song2, dim)
		elseif type == 3 then
		song2 = playSound3D("pam.ogg", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundMaxDistance(song2, 20)
		setSoundVolume(song2, 0.3)
		setElementInterior(song2, int)
		setElementDimension(song2, dim)
		end
		

	end)
	
	
local blips = {}
function facgps(commandName, numero)
		if tonumber(getElementData(localPlayer, "acc:admin") or 0) >= 7 then
		
		local value = getElementData(localPlayer,"char:adminduty")
		if value == 1 and not (tonumber(getElementData(localPlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não pode usar esta função no modo admin", 255, 194, 14, true) return end
	
		if not tonumber(numero) then return end
		local allapot = getElementData(localPlayer, "ver:facs")
		if allapot == false then			
			numerofac = tonumber(numero)
			outputChatBox("Você agora está vendo pessoas da fac "..numero.." no gps ", 255, 255, 255, true)
			setElementData(localPlayer, "ver:facs", true)
			local AllPeds = getElementsByType ( "player" ) 
			for i, v in ipairs ( AllPeds ) do 
			if getElementData(v, "char:dutyfaction") == numerofac then
			blips[i] = createBlipAttachedTo (v, 23 )
			end
			end
			
			
		else
			outputChatBox("Você não está mais vendo pessoas de facs no gps!", 255, 255, 255, true)
			setElementData(localPlayer, "ver:facs", false)
			numerofac = nil
			for i = 0,500 do
			if isElement(blips[i]) then
			destroyElement(blips[i])
			end
			end
			
			
		end
		end
end
addCommandHandler("verfac", facgps, false, false)





addEvent("portatroll", true)
addEventHandler("portatroll", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound("data/porta.wav", false) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 1)

	end)
	
	
	
addEvent("efeito", true)
function PlaySlotSound(x, y, z, int, dim)
			--fxAddSparks(x, y, z, 0, 0, 2, 5, 20, 0, 0, 0, false, 0.5, 5)
			--local randomColor, randomAmount = math.random(100, 255), math.random(1, 8)
			--fxAddDebris(x, y, z, randomColor, randomColor, randomColor, 255, 0.6, randomAmount)
			--fxAddGlass(x,y,z,randomColor, randomColor, randomColor,255,0.7,randomAmount)

			--fxAddWaterHydrant(x + math.random(-5,5), y + math.random(-5,5), z)

			--setTimer (fxAddGlass, 100, 8, x, y, z, randomColor, randomColor, randomColor, 150, 0.05)
			local rand = math.random(1,3)
			exports["bgo_death"]:enableLSD(4)
			setTimer(function()
				exports["bgo_death"]:disableLSD()
			end,rand*60*1000,1)

end
addEventHandler("efeito",root,PlaySlotSound)


addEvent("efeitooff", true)
function PlaySlotSound(x, y, z, int, dim)
				exports["bgo_death"]:disableLSD()
end
addEventHandler("efeitooff",root,PlaySlotSound)



local lastSeat = 0

function toggleDriveBy()
		-- check if guy is in vehicle
		if (not isPedInVehicle(localPlayer)) then
			return
		end
		local weaponType = getPedWeapon (localPlayer)
		-- If a weapon type was returned then
		if ( weaponType == 24 or weaponType == 23 ) then


		--if (isTimer(injekcioTimer)) then 
		--	return 
		--end		
		-- check if guy is passenger
		if (lastSeat == 0) then
			return
		end
		-- check if guy has ammo for slot 4 weapon
		if (getPedTotalAmmo(localPlayer, 24) == 0 or getPedTotalAmmo(localPlayer, 23) == 0) then
			return
		end
	
		-- Stolen from wiki --
		----------------------
        -- we check if local player isn't currently doing a gang driveby
        if not isPedDoingGangDriveby ( getLocalPlayer () ) then
                -- if he got driveby mode off, turn it on
                setPedWeaponSlot ( getLocalPlayer (), 2 )
                setPedDoingGangDriveby ( getLocalPlayer (), true )
        else
                -- otherwise, turn it off
                setPedWeaponSlot ( getLocalPlayer (), 0 )
                setPedDoingGangDriveby ( getLocalPlayer (), false )
		end
	end
		----------------------
end

bindKey("mouse2", "down", toggleDriveBy)

addEventHandler("onClientPlayerVehicleEnter", localPlayer,
function (veh, seat)
	lastSeat = seat
end
)


function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if weapon == 24 or weapon == 23 then 
		if (isPedInVehicle(localPlayer)) then
		--setPedDoingGangDriveby (hitElement, false )
		injekcioTimer = setTimer(function() 
			toggleControl ( "vehicle_fire", true )
		end, 20000, 1)
		toggleControl ( "vehicle_fire", false ) 
	end
    end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )

addEventHandler("onClientKey", root, function(k, state)
	if k == "num_0" then
		cancelEvent()
	end
end)



function pedNfale ( ) 
    local AllPeds = getElementsByType ( "player" ) 
    for _, ped in ipairs ( AllPeds ) do 
        setPedVoice ( ped, "PED_TYPE_DISABLED" ) 
	end 

	setPedTargetingMarkerEnabled(false) 
end 
--addEventHandler("onClientRender", root, pedNfale)
addEventHandler ( "onClientResourceStart", resourceRoot, pedNfale ) 


local SHADER_CODE = base64Decode("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AAAAAAcAAAAAAAAAAAAAAAcAAAAEAAAAAAAAAAcAAAAIAAAAAQBQoAIAAAAAAAAABwAAAAgAAAAAAAAAAQAAABkAAAAAAAAABAAAAAgAAAABAFCgAgAAAAAAAAAHAAAACAAAAAAAAAABAAAACQAAAAAAAAAHAAAAAAAAAAEAQBABAAAAAAAAAAcAAAAAAAAAAAAAAAcAAAAEAAAAAQAQEAEAAAAAAAAABwAAAAQAAAAAAAAABwAAAAEAAAABAECgAgAAAAAAAAAHAAAAAQAAAAAAAAAHAAAAAAAAAAAAAAAHAAAABAAAAAEAUKACAAAAAAAAAAcAAAAEAAAAAAAAAAEAAAAKAAAAAAAAAAcAAAAAAAAAAgBQoAIAAAAAAAAABwAAAAAAAAAAAAAAAQAAAAwAAAAAAAAABwAAAAQAAAABAECgAgAAAAAAAAAHAAAABQAAAAAAAAAHAAAABAAAAAAAAAAHAAAAAAAAAAEAUKACAAAAAAAAAAcAAAAAAAAAAAAAAAEAAAALAAAAAAAAAAcAAAAEAAAAAQBAoAIAAAAAAAAABwAAAAQAAAAAAAAAAQAAAA4AAAAAAAAABwAAAAAAAAABAEAQAQAAAAAAAAAHAAAAAAAAAAAAAAAHAAAABAAAAAEAUKACAAAAAAAAAAcAAAAEAAAAAAAAAAEAAAAPAAAAAAAAAAcAAAAAAAAAAQBAoAIAAAAAAAAABwAAAAAAAAAAAAAAAQAAABAAAAAAAAAABwAAAAQAAAABAIAQAQAAAAAAAAAHAAAABAAAAAAAAAAHAAAAAQAAAAEAUKACAAAAAAAAAAcAAAABAAAAAAAAAAEAAAARAAAAAAAAAAcAAAAEAAAAAQBAEAEAAAAAAAAABwAAAAQAAAAAAAAABwAAAAAAAAABAECgAgAAAAAAAAACAAAABAAAAAAAAAABAAAAGgAAAAAAAAAHAAAAAQAAAAEAEKACAAAAAAAAAAcAAAABAAAAAAAAAAEAAAAbAAAAAAAAAAcAAAAEAAAAAQAAEAEAAAAAAAAABwAAAAEAAAAAAAAABAAAABAAAAABAACgAgAAAAAAAAAHAAAABAAAAAAAAAABAAAACAAAAAAAAAAHAAAAAQAAAAEAEBABAAAAAAAAAAcAAAABAAAAAAAAAAcAAAAEAAAAAQBQoAIAAAAAAAAABwAAAAEAAAAAAAAAAQAAAA4AAAAAAAAABAAAAAwAAAABAECgAgAAAAAAAAAHAAAABAAAAAAAAAABAAAACAAAAAAAAAAHAAAAAQAAAAEAUKACAAAAAAAAAAcAAAABAAAAAAAAAAEAAAASAAAAAAAAAAcAAAAEAAAAAQBAoAIAAAAAAAAABwAAAAAAAAAAAAAABwAAAAQAAAAAAAAABwAAAAgAAAABABAQAQAAAAAAAAAHAAAAAAAAAAAAAAAHAAAABAAAAAEAQKACAAAAAAAAAAcAAAAEAAAAAAAAAAEAAAAOAAAAAAAAAAcAAAAAAAAAAQAAMAMAAAAAAAAABwAAAAAAAAAAAAAAAQAAABQAAAAAAAAAAQAAABUAAAAAAAAABAAAABgAAAABAACgAgAAAAAAAAAHAAAACAAAAAAAAAABAAAACAAAAAAAAAAHAAAAAAAAAAEAUKACAAAAAAAAAAcAAAAAAAAAAAAAAAEAAAATAAAAAAAAAAcAAAAEAAAAAQAwEAEAAAAAAAAABwAAAAQAAAAAAAAABAAAAAQAAAABAAAQAQAAAAAAAAAHAAAABAAAAAAAAAAEAAAAAAAAAPDw8PAPDw8P//8AAFEAAAUHAA+gOdZPQUx3nEIAAAAAjO4qR1EAAAUIAA+gg/kiPgAAAD/bD8lA2w9JwFEAAAUJAA+gvTeGNs3MTD9mZmY/zcxMPVEAAAUKAA+gzczMPQAAgD8AAAAAzcxMPlEAAAULAA+gmpmZPs3MzD6amRk/MzMzP1EAAAUMAA+gdMlsPv3fWD5WAZo+zczMPVEAAAUNAA+gAAAAPwAAAL8AAIA/AAAgQlEAAAUOAA+gd/RKP2HLKD8AAAAAAACAP1EAAAUPAA+gtxoUP42vWT8AAAAAAACAP1EAAAUQAA+gYAd0P+TFsz4AAAAAAACAPx8AAAIFAACAAAADkB8AAAIAAACQAAgPoAUAAAMAAAGAAAAAoAAAVZATAAACAAACgAAAAIACAAADAAABgAAAVYEAAACABQAAAwAAAYAAAACAAQAAoAEAAAIAAAKAAgAAoFoAAAQAAAGAAADkgAcA5KAHAKqgBAAABAAAAYAAAACACAAAoAgAVaATAAACAAABgAAAAIAEAAAEAAABgAAAAIAIAKqgCAD/oCUAAAIBAAKAAAAAgAUAAAMAAAGAAQBVgAcA/6ATAAACAAABgAAAAIACAAADAAARgAAAAIAJAFWgAgAAAwAAAYAAAACBCQCqoAUAAAMAAAGAAAAAgAQAAKAEAAAEAAAIgAAAAIAKAACgAABVkAUAAAMBAAGAAAAAoAAAAJATAAACAQACgAEAAIACAAADAQABgAEAVYEBAACABQAAAwEAAYABAACAAQAAoAEAAAIBAAqAAgAAoFoAAAQBAAGAAQDkgAcA5KAHAKqgBAAABAEAAYABAACACAAAoAgAVaATAAACAQABgAEAAIAEAAAEAQABgAEAAIAIAKqgCAD/oCUAAAICAAKAAQAAgAUAAAMBAAGAAgBVgAcA/6ATAAACAQABgAEAAIACAAADAQABgAEAAIADAAChAgAAAwEAA4ABAACADQDkoAIAAAMBAAGAAQAAgQ0AqqAFAAADAQABgAEAAIANAP+gWAAABAEAAYABAFWACQAAoAEAAIAFAAADAQACgAEAAIAAAFWQBgAAAgEAAYABAACAEwAAAgIAAYABAFWAAgAAAwEAAoABAFWAAgAAgQUAAAMBAASAAQAAgAEAVYBaAAAEAQABgAEA7oAHAOSgBwCqoAQAAAQBAAGAAQAAgAgAAKAIAFWgEwAAAgEAAYABAACABAAABAEAAYABAACACACqoAgA/6AlAAACAgACgAEAAIAFAAADAQABgAIAVYAHAP+gEwAAAgEAAYABAACABQAAAwEAAYABAACABAAAoAUAAAMBAAGAAQAAgAkA/6AFAAADAQABgAEAAIAGAACgAgAAAwEABoACAACgAADQkFoAAAQBAAKAAQDpgAcA5KAHAKqgBAAABAEAAoABAFWACAAAoAgAVaATAAACAQACgAEAVYAEAAAEAQACgAEAVYAIAKqgCAD/oCUAAAICAAKAAQBVgAUAAAMBAAKAAgBVgAcA/6ATAAACAQACgAEAVYAFAAADAQACgAEAVYABAACABAAABAEAAYABAFWACABVoAEAAIABAAACAAAUgAAAAJAEAAAEAAASgAEAAIAKAACgAACqgEIAAAMCAA+AAADugAAI5KBCAAADAwAPgAAA7YAACOSgBAAABAAAEYABAACACgD/oAAAVYAFAAADAwAPgAMA5IAKAGmgBAAABAIAD4ACAOSACgBpoAMA5IBCAAADAwAPgAAA7IAACOSgBAAABAAAFIABAACACwAAoAAAAIAEAAAEAgAPgAMA5IAQAOSgAgDkgEIAAAMDAA+AAADugAAI5KAEAAAEAAASgAEAAIALAFWgAACqgAQAAAQCAA+AAwDkgA4A5KACAOSAQgAAAwMAD4AAAO2AAAjkoAQAAAQAABGAAQAAgAgAVaAAAFWABAAABAIAD4ADAOSADwDkoAIA5IBCAAADAwAPgAAA7IAACOSgBAAABAAAFIABAACACwCqoAAAAIAEAAAEAgAPgAMA5IAKAGagAgDkgEIAAAMDAA+AAADugAAI5KAEAAAEAAASgAEAAIALAP+gAACqgAQAAAQCAA+AAwDkgA8AxqACAOSAQgAAAwMAD4AAAO2AAAjkoAQAAAQAABGAAQAAgAkAVaAAAFWABAAABAEAEYABAACACQCqoAAAAIBCAAADBAAPgAAA7IAACOSgAQAAAgEAAoAAAP+AQgAAAwAAD4ABAOSAAAjkoAQAAAQBAA+AAwDkgA4AxqACAOSABAAABAEAD4AEAOSAEADGoAEA5IAEAAAEAAAPgAAA5IAKAFqgAQDkgAUAAAMACA+AAADkgAwA5KD//wAAAAAAAAAAAAD/////AAAAAAAAAABwAQAAAAL+//7/NQBDVEFCHAAAAJ8AAAAAAv7/AQAAABwAAAAAAAAgmAAAADAAAAACAAAABAAAAEgAAABYAAAAZ1dvcmxkVmlld1Byb2plY3Rpb24Aq6urAwADAAQABAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB2c18yXzAATWljcm9zb2Z0IChSKSBITFNMIFNoYWRlciBDb21waWxlciA5LjI3Ljk1Mi4zMDIyAFEAAAUEAA+gAACAPwAAAAAAAAAAAAAAAB8AAAIAAACAAAAPkB8AAAIFAACAAQAPkAQAAAQAAA+AAAAkkAQAQKAEABWgCQAAAwAAAcAAAOSAAADkoAkAAAMAAALAAADkgAEA5KAJAAADAAAEwAAA5IACAOSgCQAAAwAACMAAAOSAAwDkoAEAAAIAAAPgAQDkkP//AAD/////AwAAAAAAAAAAAAAAAQAAAA8AAABteVNjcmVlblNvdXJjZQAA")

-- export to mta and writted code by: XaskeL
-- shader code from glsl by: Coolok

CGlitch = {
	GlitchPower = 0.001; -- Glitch Power (0.0f to 1.0f);
	ScreenSize = { guiGetScreenSize() }; -- default screen size

	-- example[1]: CGlitch:destroy()
	-- example[2]: CGlitch.destroy()
	-- function for destroy glitch effects
	destroy = function(self)
		if CGlitch.AlreadyHandlered then
			removeEventHandler('onClientHUDRender', root, CGlitch.draw);
			removeEventHandler('onClientPreRender', root, CGlitch.update);
			CGlitch.AlreadyHandlered = false;
		end
		if self.Shader then
			destroyElement(self.Shader);
			self.Shader = false;
		end
		if self.MyScreenSource then
			destroyElement(self.MyScreenSource);
			self.MyScreenSource = false;
		end
		return true;
	end;
	
	-- function for update screen source
	update = function()
		if CGlitch.MyScreenSource then
			dxUpdateScreenSource(CGlitch.MyScreenSource);
		end
	end;

	-- function for draw glitch effect
	draw = function()
		if CGlitch.Shader then
			dxDrawImage(0, 0, CGlitch.ScreenSize[1], CGlitch.ScreenSize[2], CGlitch.Shader)
		end
		if (CGlitch.fTime and CGlitch.fTime < getTickCount()) then
			CGlitch:destroy();
		end
	end;
	
	-- example [1]: CGlitch:show(500);
	-- example [2]: CGlitch.show(CGlitch, 500); 
	-- params: @self (table CGlitch), 500 (time in milliseconds or false for permanently drawing)
	show = function(self, fTime)
		-- create screen source & shader
		if not self.Shader then
			self.MyScreenSource = dxCreateScreenSource(CGlitch.ScreenSize[1], CGlitch.ScreenSize[2]);
			self.Shader = dxCreateShader(SHADER_CODE);
			-- set default parametres
			dxSetShaderValue(self.Shader, 'GlitchPower', self.GlitchPower);
			dxSetShaderValue(self.Shader, 'myScreenSource', self.MyScreenSource);
		end
		-- set work time
		if fTime then self.fTime = getTickCount() + fTime; else self.fTime = false; end
		-- create event handlers
		if (not self.AlreadyHandlered) then
			addEventHandler('onClientPreRender', root, CGlitch.update);
			addEventHandler('onClientHUDRender', root, CGlitch.draw);
			self.AlreadyHandlered = true;
		end
	end;
};

--[[ example:
	CGlitch:show(500); -- show 500 ms
--]]

--[[ example:
	CGlitch:show(false); -- show permanently
	
	addCommandHandler('disableglitch', function()
		CGlitch:destroy();
	end )
--]]

-- CGlitch:show(500); -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 400, 1) -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 800, 1) -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 1200, 1) -- show 500 ms
-- setTimer(function() CGlitch:show(500); end, 800, 1) -- show 500 ms



--[[

local MarkerPos = { x = 2485.861; y = -1659.619; z = 13.336; };
local theMarker = createMarker(MarkerPos.x, MarkerPos.y, MarkerPos.z, "cylinder", 1.5, 255, 255, 0, 170)

addEventHandler('onClientMarkerHit', theMarker, function() 
	CGlitch:show(500); 
end);]]--



addEvent("syncSongpeidoCagao", true)
addEventHandler("syncSongpeidoCagao", root,
	function(jogador, xp, yp, zp, int, dim)
		local song = playSound3D("data/cagao.ogg", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.2)
		setSoundMaxDistance(song, 20)
		setElementInterior(song, int)
		setElementDimension(song, dim)
		
		attachElements ( song, jogador, 0, 0, 2 )
		

	end)
	
	
	
	

local sounds = {
	"sound.mp3",
	"Track01.mp3",
	"Track02.mp3",
	"Track03.mp3",
	"Track04.mp3",
	"Track05.mp3",
	"Track06.mp3",
	"Track07.mp3",
	"Track08.mp3",
	"Track10.mp3",
	"Track11.mp3",
	"Track12.mp3"
} 



addEvent("syncSongpeido", true)
addEventHandler("syncSongpeido", root,
	function(xp, yp, zp, int, dim, peido)
		local song = playSound3D("data/"..peido.."", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.9)
		setElementInterior(song, int)
		setElementDimension(song, dim)
		
		--CGlitch:show(1000); 
		

	end)



		--local song = playSound3D("http://api.soundcloud.com/tracks/143604641/stream?client_id=N2eHz8D7GtXSl6fTtcGHdSJiS74xqOUI", 117.47831726074,-1771.1060791016,5.7094731330872, true) --playSound3D("data/sound.mp3", xp, yp, zp)
		--setSoundVolume(song, 0.9)
		--setSoundDistance(song, 10)


addEvent("efeitoGlitch", true)
addEventHandler("efeitoGlitch", root,
	function()		
		CGlitch:show(1000); 
	end)
	




addEvent("syncSongSom", true)
addEventHandler("syncSongSom", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound3D("data/"..som..".wav", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.9)
		setElementInterior(song, int)
		setElementDimension(song, dim)

	end)

addEvent("risada", true)
addEventHandler("risada", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound3D("data/risada.mp3", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.9)
		setElementInterior(song, int)
		setElementDimension(song, dim)

	end)
	
addEvent("depressao", true)
addEventHandler("depressao", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound3D("data/depre.mp3", xp, yp, zp) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.9)
		setElementInterior(song, int)
		setElementDimension(song, dim)

	end)


addEvent("opaitaoff", true)
addEventHandler("opaitaoff", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound("data/paioff.mp3", false) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.6)

	end)
	
	
addEvent("opaitaonline", true)
addEventHandler("opaitaonline", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound("data/pai.mp3", false) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.6)

	end)
	
	addEvent("opaitaonline2", true)
addEventHandler("opaitaonline2", root,
	function(xp, yp, zp, int, dim, som)
		local song = playSound("data/pai2.mp3", false) --playSound3D("data/sound.mp3", xp, yp, zp)
		setSoundVolume(song, 0.8)

	end)
	
	
addEvent("calloff", true)
addEventHandler("calloff", root,
	function()
		setSoundPan(localPlayer, 0)
		setSoundVolume(localPlayer, 0)
	end)

	
	
function Skin() 
	txd = engineLoadTXD("data/dynamite.txd", 2814 )
	engineImportTXD(txd, 2814)
	dff = engineLoadDFF("data/dynamite.dff", 2814 )
	engineReplaceModel(dff, 2814)
  end 
  addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), Skin)


function onStatsCreate(showP)
	if showStats then
		showStats = false
		showingPlayer = false
		showingPlayer = nil
		removeEventHandler("onClientRender", root, renderStatsPanel)
	else
		showStats = true
		
		if showP ~= localPlayer then
			showingPlayer = showP
		else
			showingPlayer = localPlayer
		end
		
		addEventHandler("onClientRender", root, renderStatsPanel)
	end
		
end
addEvent("onStatsCreate", true)
addEventHandler("onStatsCreate", root, onStatsCreate)


function renderStatsPanel()
		if not showingPlayer then removeEventHandler("onClientRender", root, renderStatsPanel) showStats = false return end
		if tonumber(getElementData(showingPlayer, "acc:admin") or 0) > 0 then
			admin = "tem [" .. getElementData(showingPlayer, "acc:admin") .. "]"
		else
			admin = "não [0]"
		end
		
		if (getElementData(showingPlayer, "adminjail") or 0) == 1 then
			ajailed = "sim"
		else
			ajailed = "não"
		end
	
	local monitorSize = {guiGetScreenSize()}
	local panelSize = {500, 500}
	local panelX, panelY = monitorSize[1]/2-panelSize[1]/2, monitorSize[2]/2-panelSize[2]/2
	--- Lekérések --
local sx, sy = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(sx/2, sy/2)
--dxDrawRectangle(sx/2-250,sy/2-95,500,30,tocolor(0,0,0,150))
dxDrawRectangle(sx/2-250,sy/2-230,500,300,tocolor(0,0,0,100))
	local texts = {
	{"Conta ID: #7cc576" .. getElementData(showingPlayer, "acc:id") .. ""}, 
	{"Nome do personagem: #7cc576" .. getElementData(showingPlayer, "char:name") .. ""}, 
	{"Dinheiro do jogador: #7cc576R$: " .. convertNumber(getElementData(showingPlayer, "char:money")) .. ""}, 
	{"Saldo bancário: #7cc576R$: " .. convertNumber(getElementData(showingPlayer, "char:bankmoney")) .. ""}, 
	{"Nível de Administrador: #7cc576" .. admin .. ""}, 
	{"Slot de Veículo: #7cc576" .. getElementData(showingPlayer, "char:vehSlot") .. " db"}, 
	{"Slot de Imóveis: #7cc576" .. getElementData(showingPlayer, "char:houseSlot") .. " db"}, 
	{"PP disponível: #7cc576" .. convertNumber(getElementData(showingPlayer, "char:pp")) .. " pontos"},
	{"Prisão: #7cc576" .. ajailed .. ""},}
		
		--dxDrawRectangle(panelX, panelY, panelSize[1], panelSize[2], tocolor(0, 0, 0, 180))
		--dxDrawRectangle(panelX, panelY, panelSize[1], 25, tocolor(0, 0, 0, 230))
		

		for i, v in ipairs(texts) do
		
		--	dxDrawRectangle(panelX+10, panelY+32-30+(i*30), panelSize[1]-20, 25, tocolor(0, 0, 0, 230))
			dxDrawText(v[1], panelX+10+5, panelY+32-30+(i*30)+12.5, panelX+10, panelY+32-30+(i*30)+12.5, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "center", false, false, true, true)

		end

end



local getPlayerAdminName = function(p)
	local name = tostring(getElementData(p, "char:anick")) or ""
	return name
end

-- /fly
---- FLY ----
local Superman = {}
local flyingState = false
local keys = {}
keys.up = "up"
keys.down = "up"
keys.f = "up"
keys.b = "up"
keys.l = "up"
keys.r = "up"
keys.a = "up"
keys.s = "up"
keys.m = "up"

addEvent("onClientFlyToggle",true)
addEventHandler("onClientFlyToggle",getLocalPlayer(),function()
	flyingState = not flyingState
	
	if flyingState then
		addEventHandler("onClientRender",getRootElement(),flyingRender)
		bindKey("lshift","both",keyH)
		bindKey("rshift","both",keyH)
		bindKey("lctrl","both",keyH)
		bindKey("rctrl","both",keyH)
		
		bindKey("forwards","both",keyH)
		bindKey("backwards","both",keyH)
		bindKey("left","both",keyH)
		bindKey("right","both",keyH)
		
		bindKey("lalt","both",keyH)
		bindKey("space","both",keyH)
		bindKey("ralt","both",keyH)
		bindKey("mouse1","both",keyH)
		setElementFrozen(getLocalPlayer(),true)
		setElementCollisionsEnabled(getLocalPlayer(),false)
	else
		--Superman:restorePlayer(localPlayer)
		removeEventHandler("onClientRender",getRootElement(),flyingRender)
		unbindKey("mouse1","both",keyH)
		unbindKey("lshift","both",keyH)
		unbindKey("rshift","both",keyH)
		unbindKey("lctrl","both",keyH)
		unbindKey("rctrl","both",keyH)
		
		unbindKey("forwards","both",keyH)
		unbindKey("backwards","both",keyH)
		unbindKey("left","both",keyH)
		unbindKey("right","both",keyH)
		
		unbindKey("space","both",keyH)
		
		keys.up = "up"
		keys.down = "up"
		keys.f = "up"
		keys.b = "up"
		keys.l = "up"
		keys.r = "up"
		keys.a = "up"
		keys.s = "up"
		setElementFrozen(getLocalPlayer(),false)
		setElementCollisionsEnabled(getLocalPlayer(),true)
	end
end)

local IDLE_ANIMLIB = "cop_ambient"
local IDLE_ANIMATION = "Coplook_loop"
local IDLE_ANIM_LOOP = true







function flyingRender()
	local x,y,z = getElementPosition(getLocalPlayer())
	local speed = 10
	if keys.a=="down" then
		speed = 3
	elseif keys.s=="down" then
		speed = 50
	elseif keys.m=="down" then
		speed = 300
	end
	
	if keys.f=="down" then
		a = rotFromCam(0)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	elseif keys.b=="down" then
		a = rotFromCam(180)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	end
	
	if keys.l=="down" then
		a = rotFromCam(-90)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	elseif keys.r=="down" then
		a = rotFromCam(90)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed

	end
	
	if keys.up=="down" then
		z = z + 0.1*speed

	elseif keys.down=="down" then
		z = z - 0.1*speed

	end
	setElementPosition(getLocalPlayer(),x,y,z)
end



function keyH(key,state)
	if key=="lshift" or key=="rshift" then
		keys.s = state
	end	
	if key=="lctrl" or key=="rctrl" then
		keys.down = state
	end	
	if key=="forwards" then
		keys.f = state
	end	
	if key=="backwards" then
		keys.b = state
	end	
	if key=="left" then
		keys.l = state
	end	
	if key=="right" then
		keys.r = state
	end	
	if key=="lalt" or key=="ralt" then
		keys.a = state
	end	
	if key=="space" then
		keys.up = state
	end	
	if key=="mouse1" then
		keys.m = state
	end	
end

function rotFromCam(rzOffset)
	local cx,cy,_,fx,fy = getCameraMatrix(getLocalPlayer())
	local deltaY,deltaX = fy-cy,fx-cx
	local rotZ = math.deg(math.atan((deltaY)/(deltaX)))
	if deltaY >= 0 and deltaX <= 0 then
		rotZ = rotZ+180
	elseif deltaY <= 0 and deltaX <= 0 then 
		rotZ = rotZ+180
	end
	return -rotZ+90 + rzOffset
end

function dirMove(a)
	local x = math.sin(math.rad(a))
	local y = math.cos(math.rad(a))
	return x,y
end


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end




function privateMessage(player)

	--local sound = playSound("files/pm.mp3")
	--setSoundVolume(sound, 0.5)

end
addEvent("privatUzenetErkezett", true)
addEventHandler("privatUzenetErkezett", getRootElement(), privateMessage)

function valasz(player)

	--local sound = playSound("files/cool_sms.mp3")
	--setSoundVolume(sound, 0.5)

end
addEvent("valaszKuldes", true)
addEventHandler("valaszKuldes", getRootElement(), valasz)

function enter(player)

	--local sound = playSound("files/enter.mp3")
	--setSoundVolume(sound, 0.5)

end
addEvent("enter", true)
addEventHandler("enter", getRootElement(), enter)

function asaySound(player)

--	local sound = playSound("files/asay.wav")
--	setSoundVolume(sound, 0.5)

end
addEvent("asaySound", true)
addEventHandler("asaySound", getRootElement(), asaySound)



local showaj = false
local admin
local reason
local ido
local state

function triggerAdminjail(admin, reason, ido, state, ido2)
	
	showaj = true
	addEventHandler("onClientRender", root, showAjPanel)
	
	--if state == 1 then
	--	adminName = getElementData(admin, "char:anick")
	--else
		adminName = getPlayerName(admin)
	--end
	
	Reason = reason
	Ido = ido
	Ido2 = ido2 or 0
	State = state
	
	setTimer(function()
		showaj = false
		removeEventHandler("onClientRender", root, showAjPanel)
	end, 8000, 1)

end
addEvent("triggerAdminjail", true)
addEventHandler("triggerAdminjail", getRootElement(), triggerAdminjail)

function showAjPanel()
	if showaj then
		local monitorSize = {guiGetScreenSize()}
		local panelX, panelY = monitorSize[1]/2, monitorSize[2]/2

			if State == 1 then
				text = "#D64541Departamento de policia#ffffff \n\n#7cc576" .. adminName .. "#ffffff prendeu você #0094ff" .. Ido .. "#ffffff minutos.\nMotivo: #7cc576" .. Reason .. "\n\n#ffffffPara ver seu tempo preso, use o #7cc576/tempo #ffffff."
			elseif State == 2 then
				text = "#D64541Departamento de policia#ffffff \n\n#7cc576" .. adminName .. "#ffffff prendeu você #0094ff" .. Ido .. "#ffffff minutos. Vai sair em: #0094ff" .. Ido2 .. "#ffffff minuto.\ncausa: #7cc576" .. Reason .. "\n\n#ffffffPara ver seu tempo preso, use o #7cc576/tempo #ffffff."
			else
				text = "#D64541Departamento de policia#ffffff \n\n#7cc576" .. adminName .. "#ffffff prendeu você #0094ff" .. Ido .. "#ffffff minutos.\nMotivo: #7cc576" .. Reason .. "\n\n#ffffffPara ver seu tempo preso, use o #7cc576/tempo#ffffff ."
			end
		dxDrawText(text, panelX, panelY, panelX, panelY, tocolor(255, 255, 255, 255), 1.6, "default-bold", "center", "center", false, false, true, true)
	end
end

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

local showStats = false












local font = "default-bold" --dxCreateFont("roboto.ttf", 14)

function formatDate(sec)
	local min = math.floor(sec/60)
	sec = sec-(min*60)
	if(min<10)then
		min = "0"..min
	end
	if(sec<10)then
		sec = "0"..sec
	end
	return min..":"..sec
end

local alpha = 255
local shutdownTime = nil
local fadeState = "down"

addEvent("setCuccok",true)
addEventHandler("setCuccok",root,function(time,indok)
	shutdownTime = time*60
	
	shutdownTimer = setTimer(function()
		shutdownTime = shutdownTime -1
	end,1000,0)

	
end)


local sx,sy = guiGetScreenSize()




addEventHandler("onClientRender", root, function()
	if shutdownTime then
			if fadeState == "down" then
				if alpha > 0 then
					alpha = alpha - 15
				else
					alpha = 0
					fadeState = "up"
				end
			else
				if alpha < 255 then
					alpha = alpha + 15
				else
					fadeState = "down"
					alpha = 255
				end
			end
			

		
		dxDrawText("Servidor vai reiniciar em: ".. formatDate(shutdownTime), 2, 22, sx, 80, tocolor(0,0,0,alpha),2, font, "center", "center")
		dxDrawText("Servidor vai reiniciar em: ".. formatDate(shutdownTime), 0, 20, sx, 80, tocolor(215,86,86,alpha),2, font, "center", "center")
		alpha = 255
		dxDrawText("Servidor vai reiniciar em: ".. formatDate(shutdownTime), 2, 22, sx, 80, tocolor(0,0,0,alpha),2, font, "center", "center")
		dxDrawText("Servidor vai reiniciar em: ".. formatDate(shutdownTime), 0, 20, sx, 80, tocolor(215,86,86,alpha),2, font, "center", "center")
		if shutdownTime <= 0 then
			killTimer(shutdownTimer)
			killTimer(hirdTimer)
			shutdownTime = nil
			outputChatBox("#D75656[ATENÇÃO]:#FFFFFF O servidor vai #53bfdcreiniciar #FFFFFFem 5 segundos",255,255,255,true)
			setTimer(function()
				triggerServerEvent("serverleall",localPlayer,localPlayer)
			end,5000,1)
		end
	end
end)






function thaResourceStarting( )
	water = createWater ( 1866, -1444, 12.48, 1968, -1442, 12.48, 1866, -1372, 12.48, 1968, -1370, 12.48 )

	setElementData(water, "clicar", true)
	--setTimer(function()
	--setElementPosition(water, 1918.827, -1405.547,12.48)
	--end,1000,1)

	local uSound = playSound3D( 'http://stm13.conectastm.com:8526',1959.6535644531,-1380.8375244141,18.578125) 
	setSoundVolume(uSound, 0.5)
	setSoundMaxDistance( uSound, 60 )
end
addEventHandler("onClientResourceStart", resourceRoot, thaResourceStarting)









function glue()
	--if getElementData(localPlayer, "acc:admin") >= 6 then
		local player = getLocalPlayer()
		if getElementAttachedTo(player) then
			triggerServerEvent("ungluePlayer", player, getPedContactElement(player))
		else
			local vehicle = getPedContactElement(player)
			if isElement(vehicle) and getElementType(vehicle) == "vehicle" then
				
				local px, py, pz = getElementPosition(player)
				local vx, vy, vz = getElementPosition(vehicle)
				local sx = px - vx
				local sy = py - vy
				local sz = pz - vz
				
				local rotpX = 0
				local rotpY = 0
				local rotpZ = getPedRotation(player)
				
				local rotvX,rotvY,rotvZ = getElementRotation(vehicle)
				
				local t = math.rad(rotvX)
				local p = math.rad(rotvY)
				local f = math.rad(rotvZ)
				
				local ct = math.cos(t)
				local st = math.sin(t)
				local cp = math.cos(p)
				local sp = math.sin(p)
				local cf = math.cos(f)
				local sf = math.sin(f)
				
				local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
				local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
				local y = st*sz - sf*ct*sx + cf*ct*sy
				
				local rotX = rotpX - rotvX
				local rotY = rotpY - rotvY
				local rotZ = rotpZ - rotvZ
				
				local slot = getPedWeaponSlot(player)
				if getElementData(player, "acc:admin") >= 1 then 
				triggerServerEvent("gluePlayer", player, slot, vehicle, x, y, z, rotX, rotY, rotZ)
				else
				if getElementModel(vehicle) == 490 or getElementModel(vehicle) == 400 or getElementModel(vehicle) == 416 or getElementModel(vehicle) == 470 or getElementModel(vehicle) == 548 or getElementModel(vehicle) == 482 then
					triggerServerEvent("gluePlayer", player, slot, vehicle, x, y, z, rotX, rotY, rotZ)
				end
				end
			else
				return false
			end
			end
	--end
end
addCommandHandler("glue",glue)

local screenW2,screenH2  = guiGetScreenSize()
local resW2, resH2       = 1920, 1080
local xS, yS         =  (screenW2/resW2), (screenH2/resH2)

afk = false
cor = {}

addEventHandler("onClientRender", root,
    function()
	 if afk then
        cor[1] = tocolor(221, 0, 0, 154)
     	if isCursorOnElement(xS*889, yS*619, xS*165, yS*37) then cor[1] = tocolor(221, 0, 0, 200) end	 
	 
        dxDrawRectangle(xS*781, yS*508, xS*381, yS*173, tocolor(8, 8, 8, 154), false)
        dxDrawRectangle(xS*781, yS*508, xS*382, yS*39, tocolor(8, 8, 8, 154), false)
        dxDrawText("BRASIL GAMING ONLINE (AFK)", xS*781, yS*508, xS*1162, yS*547, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Você está AFK? Se não está pressione 'Continuar\npara manter-se conectado no BGO", xS*781, yS*547, xS*1162, yS*629, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(xS*889, yS*619, xS*165, yS*37, cor[1], false)
        dxDrawText("CONTINUAR", xS*890, yS*619, xS*1054, yS*655, tocolor(255, 255, 255, 255), 1.40, "default-bold", "center", "center", false, false, false, false, false)
	 end
	end
)

function startAfk ()
	if source == localPlayer then 
     if afk then
	     triggerServerEvent("kick:afk", localPlayer, localPlayer)
	 else
		if not afk then
		if isTimer(tempo) then killTimer(tempo) end
	     local tempo = setTimer(startAfk, 60000, 1)
		 afk = true
		end
	 end
end
end
addEvent("afk:start", true)
addEventHandler("afk:start", root, startAfk)


function click (button, state)
	if afk then 
		if  state == "down"  then 
			if isCursorOnElement(xS*889, yS*619, xS*165, yS*37) then
				afk = false
				if isTimer(tempo) then killTimer(tempo) end
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), click)

function isCursorOnElement(achx,achy,width,height)
if not isCursorShowing () then return end
    local cx, cy = getCursorPosition()
    local cx, cy = (cx*screenW2), (cy*screenH2)
    if (cx >= achx and cx <= achx + width) and (cy >= achy and cy <= achy + height) then
    return true
    else
    return false
    end
end





--[[
local isChatVisible = false 


function chat()
if isChatVisible then
showChat(false)
end
end
setTimer(chat, 100, 0)


function chat2()
    if isChatVisible then
        isChatVisible = false
		outputChatBox("#D75656[CHAT]:#FFFFFF CHAT OFF",255,255,255,true)
		showChat(true)
    else
		outputChatBox("#D75656[CHAT]:#FFFFFF CHAT ON",255,255,255,true) 
        isChatVisible = true
    end
end
addCommandHandler("ochat", chat2)
]]--



--[[

function scoreChangeTracker(theKey, oldValue, newValue)
    if (getElementType(source) == "player") and (theKey == "times") then
        --outputChatBox(getPlayerName(v).." mudou o time para "..newValue.."!")
		
		outputConsole(getPlayerName(source).." mudou o time para "..newValue.."!")
		
		
	end
end
addEventHandler("onClientElementDataChange", root, scoreChangeTracker)]]--

--[[

function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
    if functionName == 'setElementData' then
        local args = {...}
        if args[2] == 'times' then
            local resname = sourceResource and getResourceName(sourceResource)  
            
            outputChatBox(string.format('resource: %s, (arquivo: %s, linha: %s, args: %s)', tostring(resname), tostring(luaFilename), tostring(luaLineNumber), inspect{args}))
        end
    end
end
addDebugHook( "preFunction", onPreFunction)]]--








local shutdownTimeRM = nil
local alpha = 255
local shutdownTime = nil
local fadeState = "down"




addEvent("IniciarContagemRM",true)
addEventHandler("IniciarContagemRM",root,function(time)
	shutdownTimeRM = time --time*60	
	shutdownTimeRMr = setTimer(function()
		shutdownTimeRM = shutdownTimeRM -1
	end,1000,0)
end)


local sx,sy = guiGetScreenSize()




addEventHandler("onClientRender", root, function()
	if shutdownTimeRM then
			if fadeState == "down" then
				if alpha > 0 then
					alpha = alpha - 15
				else
					alpha = 0
					fadeState = "up"
				end
			else
				if alpha < 255 then
					alpha = alpha + 15
				else
					fadeState = "down"
					alpha = 255
				end
			end
			

		
		dxDrawText("Reiniciando Sistema Do inventário: ".. formatDate(shutdownTimeRM), 2, 22, sx, 80, tocolor(0,0,0,alpha),2, font, "center", "center")
		dxDrawText("Reiniciando Sistema Do inventário: ".. formatDate(shutdownTimeRM), 0, 20, sx, 80, tocolor(215,86,86,alpha),2, font, "center", "center")
		alpha = 255
		dxDrawText("Reiniciando Sistema Do inventário: ".. formatDate(shutdownTimeRM), 2, 22, sx, 80, tocolor(0,0,0,alpha),2, font, "center", "center")
		dxDrawText("Reiniciando Sistema Do inventário: ".. formatDate(shutdownTimeRM), 0, 20, sx, 80, tocolor(215,86,86,alpha),2, font, "center", "center")
		if shutdownTimeRM <= 0 then
			killTimer(shutdownTimeRMr)
			killTimer(hirdTimer)
			shutdownTimeRM = nil
			--outputChatBox("#D75656[ATENÇÃO]:#FFFFFF Reiniciando Sistema Do inventário #FFFFFFem 5 segundos",255,255,255,true)
			--setTimer(function()
			--	triggerServerEvent("restartMOD",resourceRoot)
			--end,5000,1)
		end
	end
end)






------------------------------------------------------------------------
-- Girar 360 Motos / Bikes

function boostBike()
	if handled == false then
	handled = true
		addEventHandler("onClientRender", getRootElement(), boostVehBike)
		if (isPedInVehicle(localPlayer)) then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			rotX, rotYTO, rotZTO = getElementRotation(vehicle)
		end
	end
end
function unboostBike()
	removeEventHandler("onClientRender", getRootElement(), boostVehBike)
	handled = false
end
bindKey("arrow_d", "up", unboostBike)
bindKey("arrow_d", "down", boostBike)
bindKey("arrow_u", "up", unboostBike)
bindKey("arrow_u", "down", boostBike)

function boostVehBike()
	if (isPedInVehicle(localPlayer)) then
	local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
			if not (isVehicleOnGround(vehicle)) then
				if (getPedControlState("steer_back")) then
					if (getVehicleType(vehicle) == "Bike") or (getVehicleType(vehicle) == "BMX") or (getVehicleType(vehicle) == "Quad") then
						local vehicle = getPedOccupiedVehicle(localPlayer)
						rotX, rotY, rotZ = getElementRotation(vehicle)
						setElementRotation(vehicle, rotX+4, tostring(rotYTO), tostring(rotZTO), "default", false, true)
					end
				elseif (getPedControlState("steer_forward")) then
					local vehicle = getPedOccupiedVehicle(localPlayer)
					if (getVehicleType(vehicle) == "Bike") or (getVehicleType(vehicle) == "BMX") or (getVehicleType(vehicle) == "Quad") then
						if not (isVehicleOnGround(vehicle)) then
							local vehicle = getPedOccupiedVehicle(localPlayer)
							rotX, rotY, rotZ = getElementRotation(vehicle)
							setElementRotation(vehicle, rotX-4, tostring(rotYTO), tostring(rotZTO), "default", false, true)
						end
					end
				end
			end
		end
	end
end


function Skin() 
	txd = engineLoadTXD("armour.txd", 1242 )
	engineImportTXD(txd, 1242)
	dff = engineLoadDFF("armour.dff", 1242 )
	engineReplaceModel(dff, 1242)
  end 
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), Skin)





--[[





addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
        if getElementType( source ) == "ped" then
		if getElementData(source, 'deadped') then

		
		local x = getElementData(source,"pos1" )
		local y = getElementData(source,"pos2" )
		local z = getElementData(source,"pos3" )
		setElementPosition(source, x, y, z )
		
				setPedAnimation(source, "SWEET", "Sweet_injuredloop", 1000, false, false, false, true)
		end
        end
    end
);


]]--






--[[

addEventHandler ("onClientKey", getRootElement(), function (button, state)
	if not state then return end
	if not getElementData (localPlayer, "bindPermission") then
		--local keys = getBoundKeys ("lixao")
		--if keys then
		if getBoundKeys ("fall")  then
	
			for keyName, keyState in pairs (keys) do
				if button == keyName then
					outputChatBox ("Tecla bloqueada: "..keyName, 255, 0, 0)
					cancelEvent ()
					break
				end
			end
		end
	end
end)
]]--

