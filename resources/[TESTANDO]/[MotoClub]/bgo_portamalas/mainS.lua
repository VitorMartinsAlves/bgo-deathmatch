addEvent("BGO.onRequestACLAlgemado", true)
addEvent("BGO.onButtonPortaMalas", true)
local tempo = {}
addEventHandler("BGO.onRequestACLAlgemado", root,
    function(vehicle)
	
        if exports.bgo_admin:isPlayerDuty(source) then
		if isTimer(tempo[source]) then return end
            local x, y, z = getElementPosition(source)
            local players = getElementsWithinRange(x, y, z, 10, "player") or nil
			tempo[source] = setTimer(function() end, 2000,1)
            triggerClientEvent(source, "BGO.onPortaMalasAlgemado", resourceRoot, players, vehicle)
        end
    end
)

addEventHandler("BGO.onButtonPortaMalas", root,
    function(name, vehicle, type)
        local player = getPlayerFromPartialName(name)
        if player then
            local x, y, z = getElementPosition(source)
            local px, py, pz = getElementPosition(player)
            if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 5 then
                if not isPedInVehicle(player) then
                    if type == 1 then
                        if not getElementData(player, "navtr") then
                            colocarVeh(player, vehicle)
                            triggerClientEvent(source, "BGO.onClosePortaMalasAlgemado", resourceRoot)
                        else
                            outputChatBox("O Jogador já está no Veículo!", source, 255,0,0)
                        end
                    elseif type == 2 then
                        if getElementData(player, "navtr") then
                            retirarVeh(player, vehicle, {x, y, z})
                            triggerClientEvent(source, "BGO.onClosePortaMalasAlgemado", resourceRoot)
                        else
                            outputChatBox("O Jogador não está no Veículo!", source, 255,0,0)
                        end
                    end
                else
                    outputChatBox("O Jogador está em um Veículo!", source, 255,0,0)
                end
            else
                outputChatBox("O Jogador não está Perto de Você!", source, 255,0,0)
            end
        else
            outputChatBox("O Jogador não foi Identificado!", source, 255,0,0)
        end
    end
)
local rotz = {}
function colocarVeh(source, vehicle)
    local vrx, vry, vrz = getElementRotation(vehicle)
    local px, py, pz = getElementPosition(vehicle)
    setElementData(source, "navtr", true)
    attachElements(source, vehicle, 0.2, -1.5, 0, 0,0,90)
	triggerClientEvent ( "ClientRemoveCol",  getRootElement(), source )
    setPedAnimation(source, "ped", "CAR_dead_LHS")
    setElementRotation(source, vrx, vry, vrz + 83)
	rotz[source] = setTimer(function()
	if isElement(rotz[source]) then
	if isTimer(rotz[source]) then
		killTimer(rotz[source])
	end
	return 
	end
	if isElement(vehicle) then
	x, y, z = getElementPosition(source)
	--setElementPosition(source, x, y, z)
	rx,ry,rz = getElementRotation ( source )
	setElementRotation(source,  vrx, vry, vrz + 83)
	setPedAnimation(source, "ped", "CAR_dead_LHS", -1, true, false, false, true)
	else
	if isTimer(rotz[source]) then
		killTimer(rotz[source])
	end
	end
	end, 600, 0)
    local preso1 = getElementData(vehicle, "PresoMalas1")
    local preso2 = getElementData(vehicle, "PresoMalas2")
    if not preso1 and not isElement(preso1) then
        setElementData(vehicle, "PresoMalas1", source)
    elseif not preso2 and not isElement(preso2) then
        setElementData(vehicle, "PresoMalas2", source)
    end
end

function retirarVeh(source, vehicle, pos)
    setElementData(source, "navtr", nil)
    detachElements(source, getElementAttachedTo(source))
    setElementPosition(source, pos[1] + 1, pos[2] + 0.5, pos[3])
    setPedAnimation(source)
	
	triggerClientEvent ( "ClientAddCol",  getRootElement(), source )
	
	if isTimer(rotz[source]) then
	killTimer(rotz[source])
	end
    local preso1 = getElementData(vehicle, "PresoMalas1")
    local preso2 = getElementData(vehicle, "PresoMalas2")
    if preso1 and isElement(preso1) and getElementType(preso1) == "player" and preso1 == source then
        setElementData(vehicle, "PresoMalas1", nil)
    end
    if preso2 and isElement(preso2) and getElementType(preso2) == "player" and preso2 == source then
        setElementData(vehicle, "PresoMalas2", nil)
    end
end


addEventHandler("onPlayerQuit", root,
function ()
			if isTimer(rotz[source]) then
				killTimer(rotz[source])
			end
end
)



function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end