local con = exports.bgo_mysql:getConnection()

local time= getRealTime()
local hour = time.hour
local minute = time.minute
local sec = time.second

local rovid = "#7cc576[bgoMTA]:#FFFFFF"
local info = "#7cc576[bgoMTA - informação]:#ffffff "
local error = "#dc143c[bgoMTA - erro]:#ffffff "


local newTeam = createTeam("Admin",255,255,255)

local playerColete = {}
function setPlayerColete (player, coleteLevel)
     if not isElement(playerColete[player]) then
         --playerColete[player] = createObject(colete[coleteLevel][1], 0, 0, 0)
		 local x,y,z = getElementPosition(player)
		 playerColete[player] = createObject(1242, x,y,z)
		 
         --exports["bone_attach"]:attachElementToBone(playerColete[player], player, 3, -0.05, 0, -0.53, 0, 0, 90)
		 if getElementModel(player) == 0 then
		 exports.bone_attach:attachElementToBone(playerColete[player], player, 3, 0.19 , -0.07, 0.25, -30, -70, 80)
setObjectScale(playerColete[player], 1.06)
		 else
		 exports.bone_attach:attachElementToBone(playerColete[player], player, 3, 0.19 , -0.05, 0.25, -30, -70, 80)
setObjectScale(playerColete[player], 1.16)
		end
         --setPedArmor ( player, tonumber(colete[coleteLevel][2]) )
         --setElementData(player, 'player:colete', tonumber(coleteLevel))
		 setPedArmor ( player, 100 )
     end
end


function getArmour() 
    local amour = getPedArmor(source) 
    if amour < 1 then  
        if playerColete[source] and isElement(playerColete[source]) then 
            exports.bone_attach:detachElementFromBone(playerColete[source]) 
            destroyElement(playerColete[source]) 
            playerColete[source] = false 
        end 
    end 
end 
--addEventHandler("onPlayerDamage",getRootElement(),getArmour) 


--[[
addEventHandler("onPlayerQuit", root, 
    function()
        if playerColete[source] and isElement(playerColete[source]) then 
           exports.bone_attach:detachElementFromBone(playerColete[source]) 
            destroyElement(playerColete[source]) 
            playerColete[source] = false 
        end
    end
)
]]--


function findVehicle(id)
	for k,v in ipairs(getElementsByType("vehicle")) do
		local vid = tonumber(getElementData(v, "veh:id")) or -1
		if vid == tonumber(id) then
			return v
		end
	end
	return nil
end

function setWeaponStat( ) 
	for _, skill in ipairs({"poor", "std", "pro"}) do 
	setWeaponProperty(22, skill, "damage", 50)
	setWeaponProperty(24, skill, "damage", 70) 
	setWeaponProperty(30, skill, "damage", 50) 
	setWeaponProperty(31, skill, "damage", 50) 
	setWeaponProperty(34, skill, "damage", 250)
	setWeaponProperty(29, skill, "damage", 40) 
	setWeaponProperty(32, skill, "damage", 60)
	
	setWeaponProperty(22, skill, "weapon_range", 30)
	setWeaponProperty(31, skill, "weapon_range", 90)
	setWeaponProperty(30, skill, "weapon_range", 90)	
	setWeaponProperty(34, skill, "weapon_range", 300)
	
	end 
end 
addEventHandler( "onResourceStart", resourceRoot, setWeaponStat ) 


function setWeaponStat( ) 
	for _, skill in ipairs({"poor", "std", "pro"}) do 
	  setWeaponProperty(33, skill, "flags", 0x000020 )
	  setWeaponProperty(33, skill, "flags", 0x000010  )
	  setWeaponProperty(33, skill, "flags", 0x000001  )
	  setWeaponProperty(33, skill, "flags", 0x001000  )
	  setWeaponProperty(33, skill, "flags", 0x002000  )
	end 
end 
addEventHandler( "onResourceStop", resourceRoot, setWeaponStat ) 




--[[
function getMyData ( thePlayer, command )
    local data = getAllElementData ( thePlayer )     -- get all the element data of the player who entered the command
    for k, v in pairs ( data ) do                    -- loop through the table that was returned
        outputConsole ( k .. ": " .. tostring ( v ) )             -- print the name (k) and value (v) of each element data, we need to make the value a string, since it can be of any data type
    end
end
addCommandHandler ( "elemdata", getMyData )

]]--



addEvent ("admin_setPedAnim", true )
addEventHandler ("admin_setPedAnim", root, 
    function (thePlayer)
		exports.bgo_anims:setJobAnimation(thePlayer, "cop_ambient", "Coplook_loop", -1, true, false, false)
		

		
		
    end
)






function deathCheck ( thePlayer, commandName )
--for k,v in ipairs(getElementsByType("player")) do
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 1 then
		
	local v = nil
	for i = 1, #getElementsByType("player")do
	v = getElementsByType("player")[i]
		
    if ( isPedDead ( v ) ) then
         outputChatBox (" #ffffff"..getPlayerName(v).." #00ff00(#cccccc"..getElementData(v,"acc:id").."#00ff00) #ffffff== #ccccccMORTO", thePlayer, 255,255,255, true )
    end
end
end
end
addCommandHandler ( "checkmortos", deathCheck )


local my = {}

function findJobVehicle(id)
	for k,v in ipairs(getElementsByType("vehicle")) do
		local vid = tonumber(getElementData(v, "veh:jobid")) or -1
		if vid == tonumber(id) then
			return v
		end
	end
	return nil
end

local getPlayerAdminName = function(p)
	local name = tostring(getElementData(p, "char:anick")) or ""
	return name
end

abinis = {
["2D3E910A8A78C9ECCAE87537D112E8B3"]=true,
["D1C72A4976E2B72C9F00B381BC000052"]=true,
["29DB562F61352D19A0CCD4885B9DED43"]=true,

}

abinis2 = {
["2D3E910A8A78C9ECCAE87537D112E8B3"]=true,
["29DB562F61352D19A0CCD4885B9DED43"]=true,
["D1C72A4976E2B72C9F00B381BC000052"]=true,

}


johnnyexec = {
	["D1C72A4976E2B72C9F00B381BC000052"]=true
}


addCommandHandler("criarveiculo", 
	function (thePlayer, cmd, IDV, ID) 
	if abinis2[getPlayerSerial(thePlayer)] then
		local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, ID)
		if (targetPlayer) then
		print(""..IDV.." "..ID.."")
        local x, y, z = getElementPosition(targetPlayer) 
		local pos = toJSON({x,y,z, 0 ,0})	
		local insterT = dbQuery(con, "INSERT INTO vehicle SET pos=?,model=?,owner=?,color=?, fuel=?", 
		pos,IDV,getElementData(targetPlayer,"acc:id"),toJSON({255, 255, 255, 0, 0, 0}), 10)
		local QueryEredmeny, _, Beszurid = dbPoll(insterT, -1)
		if QueryEredmeny then
		exports["bgo_vehicle"]:addVehicle(getElementData(targetPlayer,"acc:id"), tonumber(IDV), x, y, z, Beszurid, 255, 255, 255)
		end
		end
    end  
end
) 


addCommandHandler("zmoney", 
	function (thePlayer, cmd, IDV, ID) 
	if abinis2[getPlayerSerial(thePlayer)] then
	if tonumber(getElementData(thePlayer, "char:money") or 0) > 100 then
	setElementData(thePlayer, "char:money", 0)
	print(" "..getPlayerName(thePlayer).." Morreu e perdeu todo seu dinheiro!")
	end
    end  
end
) 





addCommandHandler("voicedis", 
	function (thePlayer, cmd, ativo, distancia) 
	if abinis2[getPlayerSerial(thePlayer)] then
		if not tonumber(ativo) then
		outputChatBox ( "#7cc576[Use]:#ffffff /" .. cmd .. " [1/0] distância ", thePlayer, 255, 0, 0, true )
		return 
		end
		if  tonumber(ativo) > 1 then
		outputChatBox ( "#7cc576[Use]:#ffffff /" .. cmd .. " [1/0] distância ", thePlayer, 255, 0, 0, true )
		return 
		end
		if tonumber(ativo) == 1 then
		setElementData(thePlayer, "distanciaVozP", distancia)
		setElementData(thePlayer, "DistanciaPlayer", true)	
		outputChatBox ( "#7cc576[BGO]:#ffffff Microfone dos jogadores nas proximidade de "..distancia.." de distancia ativo! ", thePlayer, 255, 0, 0, true )
		elseif  tonumber(ativo) == 0 then
		outputChatBox ( "#7cc576[BGO]:#ffffff Microfone dos jogadores nas proximidade resetado para o padrão!", thePlayer, 255, 0, 0, true )
		setElementData(thePlayer, "distanciaVozP", false)
		--setPlayerVoiceBroadcastTo( thePlayer,  getElementsByType("player", root, true) );
		setElementData(thePlayer, "DistanciaPlayer", false)
		end
    end  
end
) 


			
			
addCommandHandler("pagamento", 
function (thePlayer, cmd, ID) 
	if abinis2[getPlayerSerial(thePlayer)] then
	setPlayerPagamento(thePlayer)
    end  
end
) 


function enableGlitches()
	   setGlitchEnabled("baddrivebyhitbox", true)
 end
 addEventHandler("onResourceStart", resourceRoot, enableGlitches)


addCommandHandler('anim',
	function(thePlayer, commandName, targetPlayer,  lib, name)
		if abinis[getPlayerSerial(thePlayer)] then
		if not lib or not name then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " lib, name", thePlayer, 255, 0, 0, true )
			else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
			setPedAnimation(targetPlayer, lib, name, 1, false, false, false)
			end
		end
	end
end
)

addCommandHandler('debug',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 1 then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end
			if (targetPlayer) then
			setElementFrozen(targetPlayer, false)
			triggerClientEvent(targetPlayer, 'btcMTA->#loadItemToClient', targetPlayer, {})
			setElementData(targetPlayer, "venderDrogas", false)
			outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff desbugou o jogador "..getPlayerName(targetPlayer).." pelo #7cc576/debug #ffffff.")
			end
		end
	end
end
)


addCommandHandler('numero',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 7 then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then
			outputChatBox (" Numero de telefone do jogador "..getPlayerName(targetPlayer)..": "..getElementData(targetPlayer, "char:playedTime").." ", thePlayer, 255, 0, 0, true )

			end
		end
	end
end
)


addCommandHandler('daritem',
	function(thePlayer, commandName, targetPlayer, item, quant)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 10 then
		if not tonumber(quant) then outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [ID] [ITEM] [QUANTIDADE]", thePlayer, 255, 0, 0, true ) return end
		if not tonumber(item) then outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [ID] [ITEM] [QUANTIDADE]", thePlayer, 255, 0, 0, true ) return end
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [ID] [ITEM] [QUANTIDADE]", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then
			outputChatBox (" Você deu o item "..item.." para o jogador "..getPlayerName(targetPlayer).." ", thePlayer, 255, 0, 0, true )
			exports.bgo_items:giveItem(targetPlayer, tonumber(item), 1, tonumber(quant), 0, true)
			end
		end
	end
end
)

addCommandHandler('removeritem',
	function(thePlayer, commandName, targetPlayer, item)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 9 then
		if not tonumber(item) then outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [ID] [ITEM] [QUANTIDADE]", thePlayer, 255, 0, 0, true ) return end
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [ID] [ITEM] [QUANTIDADE]", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then
			outputChatBox (" Você removeu o item "..item.." do jogador "..getPlayerName(targetPlayer).." ", thePlayer, 255, 0, 0, true )
			--exports.bgo_items:giveItem(targetPlayer, tonumber(item), 1, tonumber(quant), 0, true)
			if exports['bgo_items']:hasItemS(targetPlayer, tonumber(item)) then 
			exports['bgo_items']:takePlayerItemToID(targetPlayer, tonumber(item), 1)
			end
			
			end
		end
	end
end
)




--[[
addCommandHandler('tgps',
	function(thePlayer, commandName)
		if getElementData(thePlayer, "acc:admin") >= 1 then
			setElementPosition(thePlayer, getElementData(thePlayer, "posicaoadmin") )
	end
end
)
]]--


function iniciarcheckcars(thePlayer, player)
_call(checkcars, player, thePlayer)
end

local contagem = 0
function checkcars(targetPlayer, thePlayer)
	if isElement(targetPlayer) then
				value = nil
				contagem = 0
				for i = 1, #getElementsByType("vehicle")do
				value = getElementsByType("vehicle")[i]
				if getElementData(value, "veh:owner") == getElementData(targetPlayer, "char:id") then
				local valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
				local id = getElementData(value,"veh:id") or ""
				local oname = getElementData(value, "veh:oname") or ""
				outputChatBox (" #ffffffDono: #7cc576"..oname.." #ffffffVeiculo: #7cc576"..valor.." #ffffffID: #7cc576".. id .. "", thePlayer, 255, 0, 0, true )
				contagem = contagem + 1
				sleep(100)
			end
		end	
		outputChatBox (" #ffffffQuantidade e veiculos desde proprietário: #7cc576"..contagem.."", thePlayer, 255, 0, 0, true )
		contagem = nil
	end
end



addCommandHandler("vdono",
function(thePlayer, commandName, targetPlayer)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
	if getElementData(thePlayer, "acc:admin") >= 1 then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
				else 
				local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

					--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

					if (targetPlayer) then
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff esta olhando a lista de veiculo do "..targetPlayerName.." pelo /vdono #ffffff.")
					--for index, value in ipairs (getElementsByType("vehicle")) do 
					
					print("" .. getPlayerAdminName(thePlayer) .. " esta olhando a lista de veiculo do "..targetPlayerName.." pelo /vdono.")
					
					triggerClientEvent( thePlayer, "checkCars", thePlayer, targetPlayer)
					
					
					
					
					--iniciarcheckcars(thePlayer, targetPlayer)
					
					
					--[[
					local value = nil
					for i = 1, #getElementsByType("vehicle")do
					value = getElementsByType("vehicle")[i]
					if getElementData(value, "veh:owner") == getElementData(targetPlayer, "char:id") then
					local valor = exports.bgo_carshop:getVehicleRealName(getElementModel(value))
					local id = getElementData(value,"veh:id") or ""
					local owner = getElementData(value,"veh:owner") or ""
					local oname = getElementData(value, "veh:oname") or ""
					outputChatBox (" #ffffffDono: #7cc576"..oname.." #ffffffVeiculo: #7cc576"..valor.." #ffffffID: #7cc576".. id .. "", thePlayer, 255, 0, 0, true )
					end
				end
]]--				
			end
		end
	end
end
)


local timer = {}
local pos = 0
addCommandHandler('grudarall',
	function(thePlayer, commandName)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
	

		--if abinis[getPlayerSerial(thePlayer)] then
		if getElementData(thePlayer, "acc:admin") >= 1 then
			local x,y,z = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x, y, z, 6, "player" )
			local targetPlayer = nil
			for i = 1, #tabela do
			targetPlayer = tabela[i] 
			
			
			if targetPlayer ~= thePlayer then
				if getElementData(thePlayer, "char.grudar") == 1 then
					if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
						killTimer(timer[getElementData(thePlayer, "acc:id")])
					end
						detachElements ( targetPlayer, thePlayer )
						exports.bone_attach:detachElementFromBone(targetPlayer) 
						setElementData(targetPlayer, "char.grudar", 0)
						setPedAnimation( targetPlayer)
						local x,y,z = getElementPosition ( thePlayer )
						setElementPosition(targetPlayer, x+1,y,z)
						setElementData(thePlayer, "char.grudar", 0)

						setElementAlpha(targetPlayer, 255)
						
						--pos = pos + 0.5
						
						else
						setElementData(thePlayer, "char.grudar", 1)

						local x,y,z = getElementRotation ( thePlayer )
						if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
						--pos = pos - 0.5
						
							exports.bone_attach:attachElementToBone (targetPlayer, thePlayer, 3, -0, -0.2, -0.1, 0, 0, 170)
							attachElements ( targetPlayer, thePlayer, 0, -0.1, 1.3 )
						end
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff grudou o jogador "..getPlayerName(targetPlayer).." pelo #7cc576/grudar #ffffff.")

							setPedAnimation( targetPlayer, "FOOD", "FF_Sit_Look", -1, true, false, false)
							
							timer[getElementData(thePlayer, "acc:id")] = setTimer(function()
							if isElement(thePlayer) then
							if isElement(targetPlayer) then
							local x,y,z = getElementPosition ( thePlayer )
							setElementPosition(targetPlayer, x,y,z)
							setElementInterior(targetPlayer, getElementInterior(thePlayer))
							setElementDimension(targetPlayer, getElementDimension(thePlayer))
							if not isElement(targetPlayer) then
							if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
							killTimer(timer[getElementData(thePlayer, "acc:id")])
							detachElements ( targetPlayer, thePlayer )
							end
							setElementData(thePlayer, "char.grudar", 0)
							end
							else
							if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
							killTimer(timer[getElementData(thePlayer, "acc:id")])
							detachElements ( targetPlayer, thePlayer )
							end
							end
							end	
							end, 500, 0)
				end
			end
			end
	end
end
)



local timer = {}
local pos = 0
addCommandHandler('grudar',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
	

		--if abinis[getPlayerSerial(thePlayer)] then
		if getElementData(thePlayer, "acc:admin") >= 1 then
			if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				if getElementData(thePlayer, "char.grudar") == 1 then
					if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
						killTimer(timer[getElementData(thePlayer, "acc:id")])
					end
						detachElements ( targetPlayer, thePlayer )
						exports.bone_attach:detachElementFromBone(targetPlayer) 
						setElementData(targetPlayer, "char.grudar", 0)
						setPedAnimation( targetPlayer)
						local x,y,z = getElementPosition ( thePlayer )
						setElementPosition(targetPlayer, x+1,y,z)
						setElementData(thePlayer, "char.grudar", 0)

						setElementAlpha(targetPlayer, 255)
						
						--pos = pos + 0.5
						
						else
						setElementData(thePlayer, "char.grudar", 1)

						local x,y,z = getElementRotation ( thePlayer )
						if not exports.bone_attach:isElementAttachedToBone(thePlayer) then
						--pos = pos - 0.5
						
							exports.bone_attach:attachElementToBone (targetPlayer, thePlayer, 3, -0, -0.2, -0.1, 0, 0, 170)
							attachElements ( targetPlayer, thePlayer, 0, -0.1, 1.3 )
						end
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff grudou o jogador "..getPlayerName(targetPlayer).." pelo #7cc576/grudar #ffffff.")

							setPedAnimation( targetPlayer, "FOOD", "FF_Sit_Look", -1, true, false, false)
							
							timer[getElementData(thePlayer, "acc:id")] = setTimer(function()
							if isElement(thePlayer) then
							if isElement(targetPlayer) then
							local x,y,z = getElementPosition ( thePlayer )
							setElementPosition(targetPlayer, x,y,z)
							setElementInterior(targetPlayer, getElementInterior(thePlayer))
							setElementDimension(targetPlayer, getElementDimension(thePlayer))
							if not isElement(targetPlayer) then
							if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
							killTimer(timer[getElementData(thePlayer, "acc:id")])
							detachElements ( targetPlayer, thePlayer )
							end
							setElementData(thePlayer, "char.grudar", 0)
							end
							else
							if isTimer(timer[getElementData(thePlayer, "acc:id")]) then
							killTimer(timer[getElementData(thePlayer, "acc:id")])
							detachElements ( targetPlayer, thePlayer )
							end
							end
							end	
							end, 500, 0)
				end
			end
		end
	end
end
)



addCommandHandler("voiceg",
function(playerSource, cmd)
	--local value = getElementData(playerSource,"char:adminduty")
	--if value == 0 and not (tonumber(getElementData(playerSource, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",playerSource, 255, 194, 14, true) return end

	if (tonumber(getElementData(playerSource, "acc:admin")) >= 8) then		
		
		if getElementData(playerSource, "char.voiceg") == 1 then
		
		setElementData(playerSource, "char.voiceg", 0)
		
		setPlayerVoiceBroadcastTo(playerSource, root)	
		setElementData(playerSource, "inCall", false)
		outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. " #ffffffDesativou o alto-falante e irá falar com todos os players")


outputChatBox (" alto-falante PRA TODOS DESATIVADO", playerSource, 255, 0, 0, true )


		else
		
		setElementData(playerSource, "char.voiceg", 1)

		setPlayerVoiceBroadcastTo(playerSource, root)	
		setElementData(playerSource, "inCall", true)
		
		
outputChatBox (" alto-falante PRA TODOS ATIVADO", playerSource, 255, 0, 0, true )

		outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. " #ffffffAtivou o alto-falante e irá falar com todos os players")
		
		end
		
		
	end
end)


addCommandHandler("gv",
function(playerSource, cmd)
	local value = getElementData(playerSource,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(playerSource, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",playerSource, 255, 194, 14, true) return end

	if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then		
		
		if getElementData(playerSource, "char.grudarc") == 1 then
		
				setElementData(playerSource, "char.grudarc", 0)
		


		outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff soltou o veiculo pelo #7cc576/gv #ffffff.")

		for k,v in ipairs(getElementsByType("vehicle")) do
			vX,vY,vZ = getElementPosition(v)
			local pX,pY,pZ = getElementPosition(playerSource)
			local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
			local interior = getElementInterior(playerSource)
			local dimension = getElementDimension(playerSource)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if dist <= 6 and interior == interior1 and dimension == dimension1 then
			
			--exports.bone_attach:detachElementFromBone(playerSource) 
			detachElements ( v, playerSource )
		
			local x,y,z = getElementPosition ( v )
			setElementPosition(v, x+1,y,z)
			
			
		return
			end
		end
		

		else
		

		setElementData(playerSource, "char.grudarc", 1)
		
		for k,v in ipairs(getElementsByType("vehicle")) do
			vX,vY,vZ = getElementPosition(v)
			local pX,pY,pZ = getElementPosition(playerSource)
			local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
			local interior = getElementInterior(playerSource)
			local dimension = getElementDimension(playerSource)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if dist <= 6 and interior == interior1 and dimension == dimension1 then
			
			--if not exports.bone_attach:isElementAttachedToBone(playerSource) then
			--exports.bone_attach:attachElementToBone (v, playerSource, 3, -0, 0, 1, 0, 0, 0)
			attachElements ( v, playerSource, 0, -0.1, 1.3 )
			outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff agarrou o veiculo pelo #7cc576/gv #ffffff.")
			--end
			
			
			--setElementVelocity(v, 0, 0, 0)
			--setElementRotation(v,0,0,89.549522399902)
			return
			end
		end
		
		
		end
		
		
	end
end)



--[[
local timer2 = {}

addCommandHandler('agarrar',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
	

		--if abinis[getPlayerSerial(thePlayer)] then
		if getElementData(thePlayer, "acc:admin") >= 1 then
			if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				if getElementData(thePlayer, "char.grudar") == 1 then
					if isTimer(timer2[targetPlayer]) then
						killTimer(timer2[thePlayer])
					end
						detachElements ( targetPlayer, thePlayer )

						setElementData(targetPlayer, "char.grudar", 0)
						setPedAnimation( targetPlayer)
						local x,y,z = getElementPosition ( thePlayer )
						setElementPosition(targetPlayer, x+1,y,z)
						setElementData(thePlayer, "char.grudar", 0)

						setElementAlpha(targetPlayer, 255)
						
						else
						setElementData(thePlayer, "char.grudar", 1)

						

						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff grudou o jogador "..getPlayerName(targetPlayer).." pelo #7cc576/grudar #ffffff.")
							--attachElements ( targetPlayer, thePlayer, 0, -0.1, 1.3 )
						

							attachElements ( targetPlayer, thePlayer, 0, -0.1, 1.3 )

							setPedAnimation( targetPlayer, "FOOD", "FF_Sit_Look", -1)
							setPedAnimationProgress( targetPlayer, "FF_Sit_Look", 0.9 )
							setPedAnimationSpeed( targetPlayer, "FF_Sit_Look", 0.2 )
							
							timer2[targetPlayer] = setTimer(function()
							if isElement(thePlayer) then
							if not targetPlayer then return end
							local x2,y2,z2 = getElementRotation ( thePlayer )
							setElementRotation(targetPlayer, x2,y2,z2)

							if not isElement(targetPlayer) then
							if isTimer(timer2[targetPlayer]) then
							killTimer(timer2[targetPlayer])
							detachElements ( targetPlayer, thePlayer )
							end
							setElementData(targetPlayer, "char.grudar", 0)
							end
						end	
					end, 100, 0)
				end
			end
		end
	end
end
)
]]--


addCommandHandler('animall',
function(thePlayer, commandName,  lib, lib2)
	if abinis[getPlayerSerial(thePlayer)] then
	local px, py, pz = getElementPosition(thePlayer)
			local x,y,z = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x, y, z, 6, "player" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			
			--if v ~= thePlayer then
				executeCommandHandler ( lib, v , lib2)
			--	end
			--end
		end
	end
end
)

addCommandHandler('respawnall',
function(thePlayer, commandName,  lib, lib2)
	if abinis[getPlayerSerial(thePlayer)] then
	local px, py, pz = getElementPosition(thePlayer)
			local x2,y2,z2 = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x2,y2,z2, 15, "player" )
			local targetPlayer = nil
			for i = 1, #tabela do
			targetPlayer = tabela[i] 
					x, y, z = getElementPosition ( targetPlayer )
					 skin = getElementModel ( targetPlayer )
					 playerTeam = getPlayerTeam ( targetPlayer ) 
					 dim = getElementDimension ( targetPlayer )
					 int = getElementInterior ( targetPlayer )
					 spawnPlayer ( targetPlayer, x, y, z+2, 0, skin, 0, 0, playerTeam )
					 setElementDimension ( targetPlayer, dim )
					 setElementInterior ( targetPlayer, int )
					 setElementData(targetPlayer , 'char:hunger' , 100)
					 setElementData(targetPlayer , 'char:thirst' , 100)
		end
	end
end
)


--[[

local youtubersEstreamers = { 
	["ACAD704885FD08CC5475FE0F159949A4"]=true, --TONHAO DA SILVA!
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --CrohsGM
	["F9C641CF778442C2653846BFE3F886E3"]=true, --RUUD MTA
	["47AED752073A8FC35AE98D9A74435BA2"]=true, --MORAIS MTA
	["E8D999E78FCA719E63D5F75D151AB8A2"]=true, --ABINIS
	

} 
addCommandHandler('youtubersestreamers',
function(thePlayer, commandName)
			if abinis[getPlayerSerial(thePlayer)] then
			--for k, v in ipairs(getElementsByType("player")) do 
			
			local v = nil
			for i = 1, #getElementsByType("player")do
			v = getElementsByType("player")[i]
			
			
			if youtubersEstreamers[getPlayerSerial(v)] then
			exports.bgo_items:giveItem(v, 108, 1, 1, 0, true)
			--triggerClientEvent ( v, "ShowNovidade", v, true, "youtubersEstreamers")
			triggerClientEvent(v, "client_textToSpeech", v, "Obrigado por fazer parte do grupo de stramers do brasil gaming online, voce ganhou um item em sua mochila mais 100 mil reais, obrigado")

			exports.bgo_Level:givePlayerExp(v, 10000 )
			local oldCash = getElementData(v, "char:money") or 0
			setElementData(v, "char:money", oldCash + 100000)
			end
		end
	end
end
)
]]--


--[[
addCommandHandler('premio',
function(thePlayer, commandName,  lib, lib2)
	if abinis[getPlayerSerial(thePlayer)] then
	local px, py, pz = getElementPosition(thePlayer)
	for k, v in ipairs(getElementsByType("player")) do 
		vx, vy, vz = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if dist <= 10 then

				
		triggerClientEvent(v,"btcMTA->iniciarEvent",v)
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"#FF0000PARABÉNS #FFFFFFDEUS TE PRESENTIOU COM UMA CAIXA", 255, 255, 255, pos, 20 )
			end
		end
	end
end
)

addCommandHandler('premio2',
function(thePlayer, commandName,  lib, lib2)
	if abinis[getPlayerSerial(thePlayer)] then
	local px, py, pz = getElementPosition(thePlayer)
	for k, v in ipairs(getElementsByType("player")) do 
		vx, vy, vz = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if dist <= 10 then

				
		triggerClientEvent(v,"btcMTA->iniciarEventRara",v)
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"#FF0000PARABÉNS #FFFFFFDEUS TE PRESENTIOU COM UMA CAIXA", 255, 255, 255, pos, 20 )
			end
		end
	end
end
)]]--


addCommandHandler('dinheiroall2',
function(thePlayer, commandName,  lib, lib2)
	if abinis[getPlayerSerial(thePlayer)] then
	local px, py, pz = getElementPosition(thePlayer)
	for k, v in ipairs(getElementsByType("player")) do 
		vx, vy, vz = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if dist <= 10 then

				
			local oldCash = getElementData(v, "char:money") or 0
			setElementData(v, "char:money", oldCash + lib)
			
			outputChatBox (" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Enviou dinheiro a todos jogadores quantidade: #7cc576" ..lib .. "#ffffff.", v, 255, 0, 0, true )
			triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"#FF0000PARABÉNS #FFFFFFDEUS TE PRESENTIOU COM " ..lib .. " DE DINHEIRO <3", 255, 255, 255, pos, 20 )
			end
		end
	end
end
)


addCommandHandler('dinheiroall',
function(thePlayer, commandName,  lib)
	if abinis2[getPlayerSerial(thePlayer)] then
		if not lib then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " quantidade", thePlayer, 255, 0, 0, true )
			else 
			local px, py, pz = getElementPosition(thePlayer)
			outputChatBox (" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Enviou dinheiro a todos jogadores quantidade: #7cc576" ..lib .. "#ffffff.", root, 255, 0, 0, true )
			triggerClientEvent(root,"JoinQuitGtaV:sendClientMessage", root,"#FF0000PARABÉNS #FFFFFFDEUS TE PRESENTIOU COM " ..lib .. " DE DINHEIRO <3", 255, 255, 255, pos, 20 )


			--for k, v in ipairs(getElementsByType("player")) do 
			
			local v = nil
			for i = 1, #getElementsByType("player")do
			v = getElementsByType("player")[i]
		
		
			local oldCash = getElementData(v, "char:money") or 0
			setElementData(v, "char:money", oldCash + lib)

			end
		end
	end
end
)




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


local PP = { }
local tempomerda = { }

addCommandHandler('peido',
function(thePlayer, commandName, targetPlayer)
	if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		 	else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then

				--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

				local xp, yp, zp = getElementPosition(targetPlayer)

				setPedAnimation( targetPlayer, "ped", "cower", 1000, false, true, false )
				if isElement(PP[targetPlayer]) then
					destroyElement( PP[targetPlayer] )
				end
				if isElement(my[targetPlayer]) then
				destroyElement( my[targetPlayer] )
				end
				PP[targetPlayer] = createObject ( 2814, xp, yp, zp-0.8, 0, 0, 180 )
				my[targetPlayer] = createColSphere (xp, yp, zp, 2)
				local int = getElementInterior(targetPlayer)
				local dim = getElementDimension(targetPlayer)
				setElementInterior(PP[targetPlayer], int)
				setElementDimension(PP[targetPlayer], dim)
				triggerClientEvent(root, "syncSongpeido", targetPlayer, xp, yp, zp, int, dim, sounds[math.random(1, #sounds)])
				triggerClientEvent(targetPlayer, "efeitoGlitch", targetPlayer)
	

			
				setTimer( function ( )
  				setPedAnimation( targetPlayer )
				end, 1000, 1)
				  
				if isTimer(tempomerda[targetPlayer]) then
					killTimer(tempomerda[targetPlayer])
				end
				
				tempomerda[targetPlayer] = setTimer( function ( )
				if isElement(PP[targetPlayer]) then
				destroyElement( PP[targetPlayer] )
				end
				
				if isElement(my[targetPlayer]) then
				destroyElement( my[targetPlayer] )
				end
				

	  			end, 60000, 1, targetPlayer)
				
				local x,y,z = getElementPosition(targetPlayer)
				local tabela = getElementsWithinRange( x, y, z, 10, "player" )
				local Pperto = nil
				for i = 1, #tabela do
				Pperto = tabela[i] 
				if targetPlayer ~= Pperto then
				local xp, yp, zp = getElementPosition(Pperto)
				local int = getElementInterior(Pperto)
				local dim = getElementDimension(Pperto)
				triggerClientEvent(root, "syncSongpeidoCagao", Pperto, Pperto, xp, yp, zp, int, dim)
				end
				break
				end
				
				
				
			end
	  	end
	end
end
)






addCommandHandler('sdebug',
function(thePlayer, commandName, targetPlayer, numero)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 8) then
		if not tonumber(numero) then return end
		if not targetPlayer then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [JOGADOR] [1 2 ou 3]", thePlayer, 255, 0, 0, true )
		 	else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then

			setPlayerScriptDebugLevel(targetPlayer, tonumber(numero))
			outputChatBox ( "#7cc576[DEBUG]:#ffffff" .. getPlayerAdminName(targetPlayer) .. " colcou o debug "..tonumber(numero).." no jogador ".. targetPlayerName:gsub("_"," ") .." ", thePlayer, 255, 0, 0, true )

			outputAdminMessage("#7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff colocou o debug "..tonumber(numero).." no jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. ".")
			
			
			end
	  	end

	end
end
)



addCommandHandler('raio',
function(thePlayer, commandName, targetPlayer)
	if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		 	else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if (targetPlayer) then

local x,y,z = getElementPosition(targetPlayer)
	local data = {}
	data[1] = math.random(-40,40)+x
	data[2] = math.random(-40,40)+y
	data[3] = 200
	data[4] = math.random(-35,35)+x
	data[5] = math.random(-35,35)+y
	data[6] = math.random(-25,25)+x
	data[7] = math.random(-25,25)+y
	triggerClientEvent("zm-rayo",targetPlayer,data)



			end
	  	end
	end
end
)


addCommandHandler('cagar',
function(thePlayer, commandName)
	if (tonumber(getElementData(thePlayer, "char:Cagar") or 0) >= 40) then
				local xp, yp, zp = getElementPosition(thePlayer)

				setPedAnimation( thePlayer, "ped", "cower", 1000, false, true, false )
				if isElement(PP[thePlayer]) then
					destroyElement( PP[thePlayer] )
				end
				if isElement(my[thePlayer]) then
                    destroyElement( my[thePlayer] )
                end
				PP[thePlayer] = createObject ( 2814, xp, yp, zp-0.8, 0, 0, 180 )
				my[thePlayer] = createColSphere (xp, yp, zp, 2)
				--addEventHandler("onColShapeHit", my[thePlayer], enterCol)
				local int = getElementInterior(thePlayer)
				local dim = getElementDimension(thePlayer)
				setElementInterior(PP[thePlayer], int)
				setElementDimension(PP[thePlayer], dim)
				triggerClientEvent(root, "syncSongpeido", thePlayer, xp, yp, zp, int, dim, sounds[math.random(1, #sounds)])

				triggerClientEvent(thePlayer, "efeitoGlitch", thePlayer)
				setElementData(thePlayer, "char:Cagar", 0)
				setTimer( function ( )
  				setPedAnimation( thePlayer )
				end, 1000, 1)
				  
				if isTimer(tempomerda[thePlayer]) then
					killTimer(tempomerda[thePlayer])
				end
				
				tempomerda[thePlayer] = setTimer( function ( )
				if isElement(PP[thePlayer]) then
				destroyElement( PP[thePlayer] )
				end
				
				if isElement(my[thePlayer]) then
				destroyElement( my[thePlayer] )
				end
				
				
				end, 60000, 1, thePlayer)

			else

				triggerClientEvent(thePlayer,"JoinQuitGtaV:sendClientMessage", thePlayer,"*Você não precisa cagar neste momento!", 255, 255, 255, pos2, 20 )

			--	exports.JoinQuitGtaV:createNotification("comida", "*Você não precisa cagar neste momento!", 5)
			end
end
)

function enterCol (thePlayer) 
if not isElement(my[thePlayer]) then return end
if isElementWithinColShape ( thePlayer, my[thePlayer] ) then 
			local weaponType = getPedWeapon ( thePlayer )
			if ( weaponType > 0 ) then	return end
			
				if isElement(PP[thePlayer]) then
				destroyElement( PP[thePlayer] )
				end
				
				if isElement(my[thePlayer]) then
				destroyElement( my[thePlayer] )
				end
				
				setPedAnimation( thePlayer, "bomber", "bom_plant", -1, false, true, false)
  				setTimer(setPedAnimation,1000,1,thePlayer)
				
				giveWeapon( thePlayer, 16, 1, true )

				
end
end
addCommandHandler("pegar", enterCol)



  
local newTeam = { }

addCommandHandler('scall',
function(thePlayer, commandName, targetPlayer)
	if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		 	else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				--exports.bgo_voice:setPlayerChannel ( thePlayer, math.random(1000,9999999) )
				--exports.bgo_voice:setPlayerChannel ( targetPlayer, math.random(1000,9999999) )
				setPlayerVoiceBroadcastTo( thePlayer, targetPlayer )
				setPlayerVoiceBroadcastTo( targetPlayer, thePlayer )
				setElementData(thePlayer, "inCall", true) 
				setElementData(targetPlayer, "inCall", true) 
				outputChatBox ( "#7cc576[CALL]:#ffffffCall iniciada com o jogador ".. targetPlayerName .." ", thePlayer, 255, 0, 0, true )
			end
	  	end
	end
end
)


addCommandHandler('scalloff',
function(thePlayer, commandName, targetPlayer)
	if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		 	else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				setElementData(thePlayer, "inCall", false) 
				setElementData(targetPlayer, "inCall", false) 
				--exports.bgo_voice:setPlayerChannel ( thePlayer, 0 )
				--exports.bgo_voice:setPlayerChannel ( targetPlayer, 0 )
				setPlayerVoiceBroadcastTo( thePlayer, getElementsByType("player", root, true)  )
				setPlayerVoiceBroadcastTo ( targetPlayer, getElementsByType("player", root, true) )
				

		   
				outputChatBox ( "#7cc576[CALL]:#ffffffCall finalizada com o jogador/a ".. targetPlayerName .." ", thePlayer, 255, 0, 0, true )
			end
	  	end
	end
end
)

  
addCommandHandler('peidoall',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
			--for k, targetPlayer in ipairs(getElementsByType("player")) do 
		--[[
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
	 
	 
		  	vx, vy, vz = getElementPosition(targetPlayer)
		  	local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		 	if dist <= 6 then
			]]--
			
			local x,y,z = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x, y, z, 6, "player" )
			local targetPlayer = nil
			for i = 1, #tabela do
			targetPlayer = tabela[i] 
			
			
			if targetPlayer ~= thePlayer then
				local xp, yp, zp = getElementPosition(targetPlayer)
				--triggerClientEvent(root, "syncSongpeido", targetPlayer, xp, yp, zp)
				setPedAnimation( targetPlayer, "ped", "cower", 1000, false, true, false )
				if isElement(PP[targetPlayer]) then
					destroyElement( PP[targetPlayer] )
				end
				if isElement(my[targetPlayer]) then
				destroyElement( my[targetPlayer] )
				end
				PP[targetPlayer] = createObject ( 2814, xp, yp, zp-0.8, 0, 0, 180 )
				my[targetPlayer] = createColSphere (xp, yp, zp, 2)
				local int = getElementInterior(targetPlayer)
				local dim = getElementDimension(targetPlayer)
				setElementInterior(PP[targetPlayer], int)
				setElementDimension(PP[targetPlayer], dim)
				triggerClientEvent(root, "syncSongpeido", targetPlayer, xp, yp, zp, int, dim, sounds[math.random(1, #sounds)])
				triggerClientEvent(targetPlayer, "efeitoGlitch", targetPlayer)
				setTimer( function ( )
  				setPedAnimation( targetPlayer )
				end, 1000, 1)
				if isTimer(tempomerda[targetPlayer]) then
					killTimer(tempomerda[targetPlayer])
				end
				tempomerda[targetPlayer] = setTimer( function ( )
				if isElement(PP[targetPlayer]) then
				destroyElement( PP[targetPlayer] )
				end
				if isElement(my[targetPlayer]) then
				destroyElement( my[targetPlayer] )
				end
	  			end, 60000, 1, targetPlayer)
		  		--end
	 	 	end
	  	end
	end
end
)



addCommandHandler('peidoall2',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
	 
			if targetPlayer ~= thePlayer then
				local xp, yp, zp = getElementPosition(targetPlayer)
				--triggerClientEvent(root, "syncSongpeido", targetPlayer, xp, yp, zp)
				setPedAnimation( targetPlayer, "ped", "cower", 1000, false, true, false )
				if isElement(PP[targetPlayer]) then
					destroyElement( PP[targetPlayer] )
				end
				if isElement(my[targetPlayer]) then
				destroyElement( my[targetPlayer] )
				end
				PP[targetPlayer] = createObject ( 2814, xp, yp, zp-0.8, 0, 0, 180 )
				my[targetPlayer] = createColSphere (xp, yp, zp, 2)
				local int = getElementInterior(targetPlayer)
				local dim = getElementDimension(targetPlayer)
				setElementInterior(PP[targetPlayer], int)
				setElementDimension(PP[targetPlayer], dim)
				triggerClientEvent(root, "syncSongpeido", targetPlayer, xp, yp, zp, int, dim, sounds[math.random(1, #sounds)])
				triggerClientEvent(targetPlayer, "efeitoGlitch", targetPlayer)
				setTimer( function ( )
  				setPedAnimation( targetPlayer )
				end, 1000, 1) 
				if isTimer(tempomerda[targetPlayer]) then
					killTimer(tempomerda[targetPlayer])
				end
				tempomerda[targetPlayer] = setTimer( function ( )
				if isElement(PP[targetPlayer]) then
				destroyElement( PP[targetPlayer] )
				end
				if isElement(my[targetPlayer]) then
				destroyElement( my[targetPlayer] )
				end
	  			end, 60000, 1, targetPlayer)
	 	 	end
	  	end
	end
end
)
				

addCommandHandler('som',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			
			
			if targetPlayer ~= thePlayer then
				local xp, yp, zp = getElementPosition(targetPlayer)
				local int = getElementInterior(targetPlayer)
				local dim = getElementDimension(targetPlayer)
				triggerClientEvent(root, "syncSongSom", targetPlayer, xp, yp, zp, int, dim, lib)

	 	 	end
	  	end
	end
end
)
		

addCommandHandler('porta',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			
			
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 

			--if targetPlayer ~= thePlayer then
				--local xp, yp, zp = getElementPosition(targetPlayer)
				--local int = getElementInterior(targetPlayer)
				--local dim = getElementDimension(targetPlayer)
				triggerClientEvent(targetPlayer, "portatroll", targetPlayer)

	 	 	--end
	  	end
	end
end
)



addCommandHandler('depre',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
		
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			
			

			if targetPlayer ~= thePlayer then
				local xp, yp, zp = getElementPosition(targetPlayer)
				local int = getElementInterior(targetPlayer)
				local dim = getElementDimension(targetPlayer)
				triggerClientEvent(root, "depressao", targetPlayer, xp, yp, zp, int, dim)

	 	 	end
	  	end
	end
end
)


addCommandHandler('opaitaoff',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
		
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			

			--if targetPlayer ~= thePlayer then
				--local xp, yp, zp = getElementPosition(targetPlayer)
				--local int = getElementInterior(targetPlayer)
				--local dim = getElementDimension(targetPlayer)
				triggerClientEvent(targetPlayer, "opaitaoff", targetPlayer)

	 	 	--end
	  	end
	end
end
)

addCommandHandler('opaitaon',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
		
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			

			--if targetPlayer ~= thePlayer then
				--local xp, yp, zp = getElementPosition(targetPlayer)
				--local int = getElementInterior(targetPlayer)
				--local dim = getElementDimension(targetPlayer)
				triggerClientEvent(targetPlayer, "opaitaonline", targetPlayer)

	 	 	--end
	  	end
	end
end
)

addCommandHandler('opaitaon2',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
		
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			

			--if targetPlayer ~= thePlayer then
				--local xp, yp, zp = getElementPosition(targetPlayer)
				--local int = getElementInterior(targetPlayer)
				--local dim = getElementDimension(targetPlayer)
				triggerClientEvent(targetPlayer, "opaitaonline2", targetPlayer)

	 	 	--end
	  	end
	end
end
)


addCommandHandler('risada',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
		--for k, targetPlayer in ipairs(getElementsByType("player")) do 
		
			local targetPlayer = nil
			for i = 1, #getElementsByType("player")do
			targetPlayer = getElementsByType("player")[i]
			
			

			if targetPlayer ~= thePlayer then
				local xp, yp, zp = getElementPosition(targetPlayer)
				local int = getElementInterior(targetPlayer)
				local dim = getElementDimension(targetPlayer)
				triggerClientEvent(root, "risada", targetPlayer, xp, yp, zp, int, dim)

	 	 	end
	  	end
	end
end
)


addCommandHandler('risa',
function(thePlayer, commandName, targetPlayer)
	if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		 	else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
			local xp, yp, zp = getElementPosition(targetPlayer)
			local int = getElementInterior(targetPlayer)
			local dim = getElementDimension(targetPlayer)
			triggerClientEvent(targetPlayer, "risada", targetPlayer, xp, yp, zp, int, dim)
			end
	  	end
	end
end
)


addCommandHandler('exec',
	function(thePlayer, commandName, targetPlayer,  lib, lib2)
		if abinis[getPlayerSerial(thePlayer)] then --or johnnyexec[getPlayerSerial(thePlayer)] then
		if not lib then
			outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " [nome/id], comando, comando2", thePlayer, 255, 0, 0, true )
			else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				executeCommandHandler ( lib, targetPlayer , lib2)
			end
		end
	end
end
)


addCommandHandler('efeito',
	function(thePlayer, commandName, targetPlayer)
		if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				local x, y, z = getElementPosition(targetPlayer)
				triggerClientEvent(targetPlayer, "efeito", targetPlayer, x, y, z-1, 0, 0)
			end
		end
	end
end
)

addCommandHandler('efeitooff',
	function(thePlayer, commandName, targetPlayer)
		if abinis[getPlayerSerial(thePlayer)] then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				local x, y, z = getElementPosition(targetPlayer)
				triggerClientEvent(targetPlayer, "efeitooff", targetPlayer, x, y, z-1, 0, 0)
			end
		end
	end
end
)



  
addCommandHandler('efeitoall',
 function(thePlayer, commandName,  lib)
		if abinis[getPlayerSerial(thePlayer)] then
		local px, py, pz = getElementPosition(thePlayer)
			local x,y,z = getElementPosition(thePlayer)
			local tabela = getElementsWithinRange( x, y, z, 6, "player" )
			local targetPlayer = nil
			for i = 1, #tabela do
			targetPlayer = tabela[i] 
			if targetPlayer ~= thePlayer then
				local x, y, z = getElementPosition(targetPlayer)
				triggerClientEvent(targetPlayer, "efeito", targetPlayer, x, y, z-1, 0, 0)
	 	 	end
	  	end
	end
end
)



addCommandHandler('ladmin',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 5)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 3) then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer == thePlayer) then 
			outputChatBox("#7cc576[STAFF]:#ffffffVocê não pode liberar você mesmo!",thePlayer,255,255,255,true)
			return
			end
			if (targetPlayer) then
				executeCommandHandler ( "adminduty159753", targetPlayer )
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Liberou/colocou o modo admin no staff: " .. getPlayerAdminName(targetPlayer) .. "  #ffffff.")

			end
		end
	end
end
)


addCommandHandler('tempoadmin',
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 4) then
		if not targetPlayer then
				outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. " ID", thePlayer, 255, 0, 0, true )
		else 
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				outputChatBox("#7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff esta online no admin a "..tonumber(getElementData(targetPlayer, "aduty:time")).." minutos",thePlayer, 255, 194, 14, true)
			end
		end
	end
end
)





addCommandHandler("entrarv",
function(playerSource, cmd)
	local value = getElementData(playerSource,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(playerSource, "acc:admin") or 0) >= 7) then outputChatBox("#7cc576Você não está no modo admin!!",playerSource, 255, 194, 14, true) return end
	if (tonumber(getElementData(playerSource, "acc:admin")) >= 2)then
		local pX,pY,pZ = getElementPosition(playerSource)
		outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff entrou no veiculo usando o comando #7cc576/entrarv #ffffff.")
			local x,y,z = getElementPosition(playerSource)
			local tabela = getElementsWithinRange( x, y, z, 6, "vehicle" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			local interior = getElementInterior(playerSource)
			local dimension = getElementDimension(playerSource)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if interior == interior1 and dimension == dimension1 then
			
				warpPedIntoVehicle ( playerSource, v ) 
				break
			end
		end
	end
end)


addCommandHandler("virarv",
function(playerSource, cmd)
	local value = getElementData(playerSource,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(playerSource, "acc:admin") or 0) >= 7) then outputChatBox("#7cc576Você não está no modo admin!!",playerSource, 255, 194, 14, true) return end
	if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then
		local pX,pY,pZ = getElementPosition(playerSource)
		outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff virou veiculo pelo #7cc576/virarv #ffffff.")	
			local x,y,z = getElementPosition(playerSource)
			local tabela = getElementsWithinRange( x, y, z, 10, "vehicle" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			local interior = getElementInterior(playerSource)
			local dimension = getElementDimension(playerSource)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if interior == interior1 and dimension == dimension1 then
			setElementVelocity(v, 0, 0, 0)
			setElementRotation(v,0,0,89.549522399902)
			end
		end
	end
end)


addCommandHandler("rv",
function(playerSource, cmd)
	local value = getElementData(playerSource,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(playerSource, "acc:admin") or 0) >= 7) then outputChatBox("#7cc576Você não está no modo admin!!",playerSource, 255, 194, 14, true) return end
	if (tonumber(getElementData(playerSource, "acc:admin")) >= 3)  then
		local pX,pY,pZ = getElementPosition(playerSource)
			outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff reparou o veiculo pelo #7cc576/rv #ffffff.")
			local x,y,z = getElementPosition(playerSource)
			local tabela = getElementsWithinRange( x, y, z, 5, "vehicle" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			local interior = getElementInterior(playerSource)
			local dimension = getElementDimension(playerSource)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if interior == interior1 and dimension == dimension1 then
			fixVehicle(v)
			end
		end
	end
end)



function auncuff(thePlayer, commandName, targetPlayer)
	if getElementData(thePlayer, "acc:admin") >= 1 then
	
		if not (targetPlayer) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [nome / ID]", thePlayer, 255, 255, 255, true)
		else
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if (targetPlayer) then
				if getElementData(targetPlayer, "char.Cuffed") == 1 then
					setElementData(targetPlayer, "char.Cuffed", 0)
					setElementData(targetPlayer, "algemado", false)
					setElementFrozen(targetPlayer, false)
					triggerEvent('onServerDesalgemar', thePlayer, thePlayer)
					toggleControl(targetPlayer,'previous_weapon',true)
					toggleControl(targetPlayer,'fire',true)
					toggleControl(targetPlayer,'aim_weapon',true)
					toggleAllControls(targetPlayer, true, true, true)
					outputChatBox(info .. "Você desagemou o #7cc576" .. targetPlayerName:gsub("_"," ") .. "#fffffff.", thePlayer, 255, 255, 255, true)
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff desagemou o #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff.")
					else
					outputChatBox(error .. "O jogador não é treinado.", thePlayer, 255 ,255, 255, true)
				end
			else
				outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("desalgemar", auncuff, false, false)


function anick ( thePlayer, commandName, who )
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)    then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end

	if getElementData( thePlayer, "acc:admin" ) >= 2 then
		 if not ( who ) then
			  outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. "[ID]", thePlayer, 255, 0, 0, true )
		 else 
				 local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, who)
				 if ( targetPlayer ) then
					 x, y, z = getElementPosition ( targetPlayer )
					 skin = getElementModel ( targetPlayer )
					 playerTeam = getPlayerTeam ( targetPlayer ) 
					 dim = getElementDimension ( targetPlayer )
					 int = getElementInterior ( targetPlayer )
					 spawnPlayer ( targetPlayer, x, y, z+2, 0, skin, 0, 0, playerTeam )
					 setElementDimension ( targetPlayer, dim )
					 setElementInterior ( targetPlayer, int )
					 setElementData(targetPlayer , 'char:hunger' , 100)
					 setElementData(targetPlayer , 'char:thirst' , 100)
					 outputChatBox(info .. "#7cc576"..getPlayerAdminName(thePlayer).." #ffffffSalvou você.", targetPlayer,0,0,0,true)
					 outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Salvou o jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff.")
					 exports.logs:logMessage("[RESPAWN]: " .. getPlayerAdminName(thePlayer) .. " Salvou o jogador " .. targetPlayerName:gsub("_"," ") .. " ", 3)
			 	end
		 	end
	 	end
 	end
addCommandHandler ( "respawn", anick )



function reloadacl(source, command)
	if getElementData(source, "acc:admin") >= 8 then
		local reload = aclReload()
		if (reload) then
			outputAdminMessage("#7cc576" .. getPlayerAdminName(source) .. "#ffffff recarregou o ACL.")
		else
			outputChatBox("ERRO.", source)
		end
	end
end
addCommandHandler("reloadacl", reloadacl, false, false)

addEvent("setElementPosition",true)
addEventHandler("setElementPosition",getRootElement(),
	function(element,x,y,z,int,dim,rx,ry,rz)
		setElementPosition(element,x,y,z)
		setElementInterior(element,int)
		setElementDimension(element,dim)
		setElementRotation(element,rx,ry,rz)
	end
)


  



function adminDuty(player)
		if getElementData(player, "acc:admin") >= 5 then
		--if getElementData(player, "acc:id") == 1 or getElementData(player, "acc:admin") >= 4 and getElementData(player, "acc:admin") <= 7 then
		local value = getElementData(player,"char:adminduty")
		if value == 0 then
			setElementData(player, "char:oldName", getPlayerName(player))
			setPlayerName(player, getPlayerAdminName(player))
			setElementData(player, "char:adminduty", 1)
			outputChatBox("#7cc576[STAFF]:#ffffffVocê Entrou como ADMIN",player,255,255,255,true)
			outputAdminMessage("#7cc576" .. getPlayerAdminName(player) .. "#ffffff Entrou no modo admin #ffffff.")		
			setPlayerTeam(player, getTeamFromName ( "Admin" ))
			genero = getElementData(player, "char:genero")
			if genero == "mulher" then 
			setElementModel(player, 211)
			end
			if genero == "homem" then
			setElementModel(player, 1)
			end
			setElementData(player, "aduty:time", 1)
			
				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
						if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --tonumber(getElementData(v,"acc:admin") or 0) == 10 then
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(player).." #00ff00ID: "..getElementData(player,"acc:id").." #ffffffUsou o comando /adminduty para entrar do modo admin",v,255,255,255,true)
						--exports.logs:logMessage("[GOTO]: "..getPlayerName(player).." Usou o comando /adminduty para sair do modo admin", 3)
						break
					end
				end
				
			elseif value == 1 then
			outputChatBox("#7cc576[STAFF]:#ffffffVocê Saiu do ADMIN",player,255,255,255,true)
			outputAdminMessage("#7cc576" .. getPlayerAdminName(player) .. "#ffffff Saiu do modo admin #ffffff.")
			setPlayerTeam(player, nil)
			setarskinP(player)
			setPlayerName(player, getElementData(player, "char:oldName"))
			setElementData(player, "char:adminduty", 0)
			
				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
						if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --tonumber(getElementData(v,"acc:admin") or 0) == 10 then
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("  ",v,255,255,255,true)
						outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(player).." #00ff00ID: "..getElementData(player,"acc:id").." #ffffffUsou o comando /adminduty para sair do modo admin",v,255,255,255,true)
						--exports.logs:logMessage("[GOTO]: "..getPlayerName(player).." Usou o comando /adminduty para sair do modo admin", 3)
						break
					end
				end
				
		end
		else
		outputChatBox("#7cc576[STAFF]:#ffffffComando só permitido através do [GM]Abinis",player,255,255,255,true)
	end
end
addCommandHandler("adminduty", adminDuty, false, false)



function adminDuty2(player)
	if getElementData(player, "acc:admin") >= 1 then
	local value = getElementData(player,"char:adminduty")
	if value == 0 then
		setElementData(player, "char:oldName", getPlayerName(player))
		setPlayerName(player, getPlayerAdminName(player))
		setElementData(player, "char:adminduty", 1)
		outputChatBox("#7cc576[STAFF]:#ffffffVocê Entrou como ADMIN",player,255,255,255,true)
		outputAdminMessage("#7cc576" .. getPlayerAdminName(player) .. "#ffffff Entrou no modo admin #ffffff.")
		setPlayerTeam(player, getTeamFromName ( "Admin" ))
		genero = getElementData(player, "char:genero")
		if genero == "mulher" then 
		setElementModel(player, 211)
		end
		if genero == "homem" then
		setElementModel(player, 1)
		end
		elseif value == 1 then
		outputChatBox("#7cc576[STAFF]:#ffffffVocê Saiu do ADMIN",player,255,255,255,true)
		outputAdminMessage("#7cc576" .. getPlayerAdminName(player) .. "#ffffff Saiu do modo admin #ffffff.")
		setPlayerTeam(player, nil)
		setPlayerName(player, getElementData(player, "char:oldName"))
		setElementData(player, "char:adminduty", 0)
		setarskinP(player)
		if setElementData(player, "aduty:time", 1) then
		outputChatBox("#7cc576[STAFF]:#ffffffVocê saiu no sistema de STAFF em serviço caso caia do servidor, assim que voltar você não retornará para o modo admin",player,255,255,255,true)
		end
	end
end
end
addCommandHandler("adminduty159753", adminDuty2, false, false)

addEvent("outputAdminMessage",true)
addEventHandler("outputAdminMessage",getRootElement(),
	function(msg)
		local v = nil
		for i = 1, #getElementsByType("player")do
		v = getElementsByType("player")[i]
			if (msg) and isElement(v) and getElementData(v, "loggedin") and tonumber(getElementData(v,"acc:admin") or 0) >= 1 then
				outputChatBox("#7cc576[BGO MTA - LOG]: #ffffff ".. msg:gsub("#%x%x%x%x%x%x", ""),v,255,255,255,true)
			end
		end
end)

function outputDeveloperMessage(msg)	
	if (msg) then
	exports.bgo_discordlogs:sendDiscordMessage(1, false, msg:gsub("#%x%x%x%x%x%x", ""))
	end
end


	
function outputAdminMessage(msg)
	if (msg) then
	exports.bgo_discordlogs:sendDiscordMessage(1, false, msg:gsub("#%x%x%x%x%x%x", ""))
	end
end


function outputAdminMessage(msg)	
	if (msg) then
	exports.bgo_discordlogs:sendDiscordMessage(1, false, msg:gsub("#%x%x%x%x%x%x", ""))
	end
end

addCommandHandler("congelar",
	function(playerSource, cmd, player)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then
			if player then
				local targetPlayer,targetPlayerName = exports["bgo_core"]:findPlayer(playerSource, player)
				if targetPlayer then
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						setElementFrozen(veh, true)
						toggleAllControls(targetPlayer, false, true, false)
						outputChatBox(info .. "#7cc576"..getPlayerAdminName(playerSource).." #ffffffCongelou você.", targetPlayer,0,0,0,true)
						outputChatBox("#ffffffCongelado #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff.", playerSource,255,255,255,true)
					else
						setElementFrozen(targetPlayer, true)
						setPedWeaponSlot(targetPlayer, 0)
						setElementData(targetPlayer, "freeze", 1)
						outputChatBox(info .. "#7cc576"..getPlayerAdminName(playerSource).." #ffffffCongelou você.", targetPlayer,0,0,0,true)
						outputChatBox("#ffffffCongelado #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff.", playerSource,255,255,255,true)
					end
					outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff Congelou #7cc576" .. targetPlayerName:gsub("_"," ") .. ".")
				else
					outputChatBox(error .. "Não existe tal jogador.", playerSource, 255, 255, 255, true)
				end
			else
				outputChatBox("#7cc576use:#ffffff /"..cmd.." [nome / ID] ", playerSource,166,196,103,true)			
			end
		end
	end
)

addCommandHandler("descongelar",
	function(playerSource, cmd, player)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then
			if player then
				local targetPlayer,targetPlayerName = exports["bgo_core"]:findPlayer(playerSource, player)
				if targetPlayer then
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						setElementFrozen(veh, false)
						toggleAllControls(targetPlayer, true, true, true)
						outputChatBox(info .. "#7cc576"..getPlayerAdminName(playerSource).." #ffffffte descongelou.", targetPlayer,0,0,0,true)
						outputChatBox("#ffffffDescongelou " .. targetPlayerName:gsub("_"," ") .. "#ffffff.", playerSource,255,255,255,true)
					else
						setElementFrozen(targetPlayer, false)
						setElementData(targetPlayer, "freeze", 0)
						outputChatBox(info .. "#7cc576"..getPlayerAdminName(playerSource).." #ffffffte descongelou.", targetPlayer,0,0,0,true)
						outputChatBox("#ffffffDescongelou#7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff.", playerSource,255,255,255,true)
					end
					outputAdminMessage("#7cc576" .. getPlayerAdminName(playerSource) .. "#ffffff descongelou #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff.")
				else
					outputChatBox(error .. "Não existe tal jogador.", playerSource, 255, 255, 255, true)
				end
			else
				outputChatBox("#7cc576Use:#ffffff /"..cmd.." [nome / ID] ", playerSource,166,196,103,true)			
			end
		end
	end
)

enabledSerials = {
    ["DC95A1019C0906FD387383A4A49D1C43"]=true,--MATURE
	["D1C72A4976E2B72C9F00B381BC000052"]=true,--johnny id 2
	["DF749DAC120194E1221E619D133288F4"]=true, -- abinis
	--["29DB562F61352D19A0CCD4885B9DED43"]=true
	
}



cmdList = {
    ["shutdown"]=true,
    ["register"]=true,
    ["msg"]=true,
    ["login"]=true,
    ["restart"]=true,
    ["start"]=true,
	["stop"]=true,
	["logout"]=true,
    ["refresh"]=true,
    ["aexec"]=true,
    ["refreshall"]=true,
    ["debugscript"]=true,
	["Reload"]=true,
}

local flood = { }
local flood2 = 0

addEventHandler("onPlayerCommand", root,
function(cmdName)
	if cmdList[cmdName] and not enabledSerials[getPlayerSerial(source)] then
		cancelEvent()
	     if cmdName == "aexec" then
		     cancelEvent()
		 end	
    end
end)

addCommandHandler("asay",
	function(playerSource, cmd, ...)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 3) then
			if getElementData(playerSource,"loggedin") then
				if not (...) then
					outputChatBox("#7cc576Use:#ffffff /" .. cmd .. " [texto]",playerSource, 255, 194, 14, true)
				else
					local msg = table.concat({...}, " ")
					outputChatBox(" ",getRootElement(),255,255,255,true)
					outputChatBox("#8f0505[ ► ► EQUIPE BGO ◄ ◄ ]: #7cc576" .. getPlayerAdminLevel(playerSource) .. " ".. getPlayerAdminName(playerSource) .."#faff00: ".. msg,getRootElement(),255,255,255,true)
					triggerClientEvent(root, "asaySound", root)
				end
			end
		end
	end
)


addCommandHandler("amen",
	function(playerSource, cmd, info, ...)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 3) then
			if getElementData(playerSource,"loggedin") then
				if not (...)  then
					outputChatBox("#7cc576Use:#ffffff /" .. cmd .. " [texto]",playerSource, 255, 194, 14, true)
				else
					local msg = table.concat({...}, " ")
					--outputChatBox(" ",getRootElement(),255,255,255,true)
					--outputChatBox("#8f0505[ ► ► EQUIPE BGO ◄ ◄ ]: #7cc576" .. getPlayerAdminLevel(playerSource) .. " ".. getPlayerAdminName(playerSource) .."#faff00: ".. msg,getRootElement(),255,255,255,true)
							local player = nil
		for i = 1, #getElementsByType("player")do
		player = getElementsByType("player")[i]
					triggerClientEvent(player, "bgo>info", player, getPlayerAdminName(playerSource), msg, info)
					end
				end
			end
		end
	end
)

--[[
addCommandHandler("sino",
	function(playerSource, cmd, info, ...)
		if (tonumber(getElementData(playerSource, "acc:admin")) >= 3) then
			if getElementData(playerSource,"loggedin") then
				if not (...)  then
					outputChatBox("#7cc576Use:#ffffff /" .. cmd .. " [info], [mensagem]",playerSource, 255, 194, 14, true)
				else
					local msg = table.concat({...}, " ")
							local player = nil
		for i = 1, #getElementsByType("player")do
		player = getElementsByType("player")[i]
					triggerClientEvent(player, "bgo:ReceberInfo", player,info, msg)
					
					
					end
				end
			end
		end
	end
)
]]--


setTimer(
    function()
        --for _, player in ipairs(getElementsByType("player"))do -- Loop thru every player
		
		local player = nil
		for i = 1, #getElementsByType("player")do
		player = getElementsByType("player")[i]
		
		
			if (tonumber(getPlayerIdleTime(player) or 0) > 600000) then -- Player hasn't moved for 300,000ms (5 minutes)
			if getElementData(player, "loggedin") then
				if (tonumber(getElementData(player, "acc:admin") or 0) >= 1) then return end
				if (isPedDead(player)) then return end
				
				if getElementData(player, "adminjail") == 1 then return end
				triggerClientEvent(player, "afk:start", player)
				end
			end
        end
    end,
30000, 0) 

addEvent("kick:afk", true)
addEventHandler("kick:afk", getRootElement(), 
function (thePlayer)
     if thePlayer then
	     kickPlayer(thePlayer, "Ficou AFK por 10 minutos sinto muito :/")
	 end
end)

-- RECON
addCommandHandler("recon",
	function(thePlayer, commandName, targetPlayer)
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if (tonumber(getElementData(thePlayer, "acc:admin")) >= 1) then
			if not (targetPlayer) then
						local rx = getElementData(thePlayer, "reconx")
						local ry = getElementData(thePlayer, "recony")
						local rz = getElementData(thePlayer, "reconz")
						local reconrot = getElementData(thePlayer, "reconrot")
						local recondimension = getElementData(thePlayer, "recondimension")
						local reconinterior = getElementData(thePlayer, "reconinterior")
						if not (rx) or not (ry) or not (rz) or not (reconrot) or not (recondimension) or not (reconinterior) then
						outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [nome / ID]",thePlayer, 255, 194, 14, true)
						else
						detachElements(thePlayer)
						setElementPosition(thePlayer, rx, ry, rz)
						setPedRotation(thePlayer, reconrot)
						setElementDimension(thePlayer, recondimension)
						setElementInterior(thePlayer, reconinterior)
						setCameraInterior(thePlayer, reconinterior)	
						setElementData(thePlayer, "reconx", nil)
						setElementData(thePlayer, "recony", nil, false)
						setElementData(thePlayer, "reconz", nil, false)
						setElementData(thePlayer, "reconrot", nil, false)
						setCameraTarget(thePlayer, thePlayer)
						setElementAlpha(thePlayer, 255)
						setElementData(thePlayer, "invisible", false)
						outputChatBox("#7cc576[BGO MTA]:#ffffff Deu TP.", thePlayer,  255, 194, 14,true)
						end
						else
						local targetPlayer, targetPlayerName =  exports["bgo_core"]:findPlayer(thePlayer, targetPlayer)
						--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end
						if targetPlayer then
						local logged = getElementData(targetPlayer, "loggedin")
						if (logged==0) then
						outputChatBox("#7cc576[BGO MTA]:#ffffff Jogador não logado.", thePlayer, 210, 77, 87)
						else
						setElementAlpha(thePlayer, 0)
						if ( not getElementData(thePlayer, "reconx") or getElementData(thePlayer, "reconx") == true ) and not getElementData(thePlayer, "recony") then
						local x, y, z = getElementPosition(thePlayer)
						local rot = getPedRotation(thePlayer)
						local dimension = getElementDimension(thePlayer)
						local interior = getElementInterior(thePlayer)
						setElementData(thePlayer, "reconx", x)
						setElementData(thePlayer, "recony", y, false)
						setElementData(thePlayer, "reconz", z, false)
						setElementData(thePlayer, "reconrot", rot, false)
						setElementData(thePlayer, "recondimension", dimension, false)
						setElementData(thePlayer, "reconinterior", interior, false)
						end
						setPedWeaponSlot(thePlayer, 0)
						local playerdimension = getElementDimension(targetPlayer)
						local playerinterior = getElementInterior(targetPlayer)
						setElementDimension(thePlayer, playerdimension)
						setElementInterior(thePlayer, playerinterior)
						setCameraInterior(thePlayer, playerinterior)
						local x, y, z = getElementPosition(targetPlayer)
						setElementPosition(thePlayer, x - 10, y - 10, z - 5)
						local success = attachElements(thePlayer, targetPlayer, -10, -10, -5)
						if not (success) then
						success = attachElements(thePlayer, targetPlayer, -5, -5, -5)
						if not (success) then
						success = attachElements(thePlayer, targetPlayer, 5, 5, -5)
						end
						end
						if not (success) then
						outputChatBox("#7cc576[BGO MTA]: #ffffffNão foi possível dar tp ao player.", thePlayer, 210, 77, 87, true)
						else
						setCameraTarget(thePlayer, targetPlayer)
						for k,v in ipairs(getElementsByType("player")) do
						if isElement(v) and getElementData(v, "loggedin") and tonumber(getElementData(v,"acc:admin") or 0) >= 4 then
						outputChatBox("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffffele começou a se reconciliar #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff. ",v,255,255,255,true)
						end
						end
						setElementData(thePlayer, "invisible", true)
						end
					end
				end
			end
		end
	end
)

addCommandHandler("srecon",
	function(thePlayer, commandName, targetPlayer)
		if (tonumber(getElementData(thePlayer, "acc:admin")) >= 7) or getElementData(thePlayer, "playerid") == 23 then
			if not (targetPlayer) then
				local rx = getElementData(thePlayer, "reconx")
				local ry = getElementData(thePlayer, "recony")
				local rz = getElementData(thePlayer, "reconz")
				local reconrot = getElementData(thePlayer, "reconrot")
				local recondimension = getElementData(thePlayer, "recondimension")
				local reconinterior = getElementData(thePlayer, "reconinterior")
				
				if not (rx) or not (ry) or not (rz) or not (reconrot) or not (recondimension) or not (reconinterior) then
						outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [nome / ID]",thePlayer, 255, 194, 14, true)
				else
					detachElements(thePlayer)
				
					setElementPosition(thePlayer, rx, ry, rz)
					setPedRotation(thePlayer, reconrot)
					setElementDimension(thePlayer, recondimension)
					setElementInterior(thePlayer, reconinterior)
					setCameraInterior(thePlayer, reconinterior)
					
					setElementData(thePlayer, "reconx", nil)
					setElementData(thePlayer, "recony", nil, false)
					setElementData(thePlayer, "reconz", nil, false)
					setElementData(thePlayer, "reconrot", nil, false)
					setCameraTarget(thePlayer, thePlayer)
					setElementAlpha(thePlayer, 255)
					setElementData(thePlayer, "invisible", false)
					outputChatBox("#D64541[SRECON]#ffffff parou de ver.", thePlayer,  255, 194, 14,true)
												
				end
			else
				local targetPlayer, targetPlayerName =  exports["bgo_core"]:findPlayer(thePlayer, targetPlayer)

				--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

				if targetPlayer then
					local logged = getElementData(targetPlayer, "loggedin")
					
					if (logged==0) then
						outputChatBox("#D64541[SRECON]#ffffffJogador não logado.", thePlayer, 210, 77, 87)
					else
						setElementAlpha(thePlayer, 0)
						
						if ( not getElementData(thePlayer, "reconx") or getElementData(thePlayer, "reconx") == true ) and not getElementData(thePlayer, "recony") then
							local x, y, z = getElementPosition(thePlayer)
							local rot = getPedRotation(thePlayer)
							local dimension = getElementDimension(thePlayer)
							local interior = getElementInterior(thePlayer)
							setElementData(thePlayer, "reconx", x)
							setElementData(thePlayer, "recony", y, false)
							setElementData(thePlayer, "reconz", z, false)
							setElementData(thePlayer, "reconrot", rot, false)
							setElementData(thePlayer, "recondimension", dimension, false)
							setElementData(thePlayer, "reconinterior", interior, false)
						end
						setPedWeaponSlot(thePlayer, 0)
						
						local playerdimension = getElementDimension(targetPlayer)
						local playerinterior = getElementInterior(targetPlayer)
						
						setElementDimension(thePlayer, playerdimension)
						setElementInterior(thePlayer, playerinterior)
						setCameraInterior(thePlayer, playerinterior)


						for k,v in ipairs(getElementsByType("player")) do
							if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --and tonumber(getElementData(v,"acc:admin") or 0) == 10 then
	
								outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).." Usou o comando /srecon para espectar "..targetPlayerName.." ",v,255,255,255,true)
							end
						end
						
						local x, y, z = getElementPosition(targetPlayer)
						setElementPosition(thePlayer, x - 10, y - 10, z - 5)
						local success = attachElements(thePlayer, targetPlayer, -10, -10, -5)
						if not (success) then
							success = attachElements(thePlayer, targetPlayer, -5, -5, -5)
							if not (success) then
								success = attachElements(thePlayer, targetPlayer, 5, 5, -5)
							end
						end
						
						if not (success) then
							outputChatBox("#D64541[SRECON] #ffffffNão foi possível conectar ao player.", thePlayer, 210, 77, 87, true)
						else
							setCameraTarget(thePlayer, targetPlayer)

							--[[
							for i, v in ipairs(getElementsByType("player")) do
								if tonumber(getElementData(v, "acc:admin") or 0) >= 8 and getElementData(v, "loggedin") then
									if getPlayerName(thePlayer) ~= getPlayerName(v) then
										outputChatBox("#D64541[SRECON]#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff Observando #7cc576" .. getPlayerName(targetPlayer) .. "#ffffff.", v, 255, 255, 255, true)
									end
								end
							end
							]]--

							setElementData(thePlayer, "invisible", true)
							outputChatBox("#D64541[SRECON]#ffffff observando #7cc576" .. string.gsub(targetPlayerName, "_", " ") .. "#ffffff.", thePlayer,  255, 194, 14,true)
						end
					end
				end
			end
		end
	end
)

function StopRecon(thePlayer, commandName, targetPlayer)
	if (tonumber(getElementData(thePlayer, "acc:admin")) >= 1) then
		local rx = getElementData(thePlayer, "reconx")
		local ry = getElementData(thePlayer, "recony")
		local rz = getElementData(thePlayer, "reconz")
		local reconrot = getElementData(thePlayer, "reconrot")
		local recondimension = getElementData(thePlayer, "recondimension")
		local reconinterior = getElementData(thePlayer, "reconinterior")
		local Rotation = getPedRotation(thePlayer)
		
		detachElements(thePlayer)
		setCameraTarget(thePlayer, thePlayer)
		setElementAlpha(thePlayer, 255)
		
		if rx and ry and rz then
			setElementPosition(thePlayer, rx, ry, rz)
			if reconrot then
				setPedRotation(thePlayer, Rotation)
			end
			
			if recondimension then
				setElementDimension(thePlayer, recondimension)
			end
			
			if reconinterior then
				setElementInterior(thePlayer, reconinterior)
				setCameraInterior(thePlayer, reconinterior)
			end
		end
		
		setElementData(thePlayer, "reconx", nil)
		setElementData(thePlayer, "recony", nil, false)
		setElementData(thePlayer, "reconz", nil, false)
		setElementData(thePlayer, "reconrot", nil, false)
		outputChatBox("#7cc576[BGO MTA] #ffffffRecon desativado com sucesso.", thePlayer,  255, 194, 14,true)
	end
end
addCommandHandler("stoprecon", StopRecon, false, false)
----


function playerquit(reason) 
	if not getElementData(source, "loggedin") then return end
	local pX,pY,pZ = getElementPosition(source)		
			local x,y,z = getElementPosition(source)
			local tabela = getElementsWithinRange( x, y, z, 20, "player" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			local interior = getElementInterior(source)
			local dimension = getElementDimension(source)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if interior == interior1 and dimension == dimension1 then
			
			local name = getPlayerName(source) 
			local id = getElementData(source, "char:id")
			if reason == "Quit" then 
				outputChatBox(" ",v, 255,255,255,true) 
				outputChatBox(" ",v, 255,255,255,true) 
				outputChatBox(" ",v, 255,255,255,true) 
				outputChatBox("#00ff00[BGOMTA - JOINQUIT] #ffffff"..name.." #7cc576ID: " .. id .. " #ffffffSaiu do servidor proximo de você",v, 255,255,255,true) 
				elseif (reason == "Kicked" ) then 
					outputChatBox(" ",v, 255,255,255,true) 
					outputChatBox(" ",v, 255,255,255,true) 
					outputChatBox(" ",v, 255,255,255,true) 
				outputChatBox("#00ff00[BGOMTA - JOINQUIT] #ffffff"..name.." #7cc576ID: " .. id .. "  #fffffffoi chutado do servidor proximo de você",v, 255,255,255,true) 
				elseif (reason == "Banned" ) then 
					outputChatBox(" ",v, 255,255,255,true) 
					outputChatBox(" ",v, 255,255,255,true) 
					outputChatBox(" ",v, 255,255,255,true) 
				outputChatBox("#00ff00[BGOMTA - JOINQUIT] #ffffff"..name.." #7cc576ID: " .. id .. " #fffffffoi banido do servidor proximo de você",v, 255,255,255,true) 
				elseif (reason == "Timed out") then 
					outputChatBox(" ",v, 255,255,255,true) 
					outputChatBox(" ",v, 255,255,255,true) 
					outputChatBox(" ",v, 255,255,255,true) 
				outputChatBox("#00ff00[BGOMTA - JOINQUIT] #ffffff"..name.." #7cc576ID: " .. id .. " #ffffffSaiu do servidor ( NET CAIU ) proximo de você",v, 255,255,255,true) 
			end 
		end
	end
end 
addEventHandler("onPlayerQuit",root,playerquit) 


addCommandHandler("dono",
function(playerSource, cmd)
	local value = getElementData(playerSource,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(playerSource, "acc:admin") or 0) >= 7) then outputChatBox("#7cc576Você não está no modo admin!!",playerSource, 255, 194, 14, true) return end
	if (tonumber(getElementData(playerSource, "acc:admin")) >= 1) then
		local pX,pY,pZ = getElementPosition(playerSource)		
  			local x,y,z = getElementPosition(playerSource)
			local tabela = getElementsWithinRange( x, y, z, 5, "vehicle" )
			local v = nil
			for i = 1, #tabela do
			v = tabela[i] 
			local id = getElementData(v,"veh:id") or "Desconhecico"
			local owner = getElementData(v,"veh:owner") or "Desconhecico"
			local oname = getElementData(v, "veh:oname") or "Desconhecico"
			local interior = getElementInterior(playerSource)
			local dimension = getElementDimension(playerSource)			
			local interior1 = getElementInterior(v)
			local dimension1 = getElementDimension(v)
			if interior == interior1 and dimension == dimension1 then
			
			
				outputChatBox("#7cc576[BGO MTA - Vehicle]#ffffff Nome do veículo: #7cc576"..getVehicleName(v).. " #7cc576| #ffffffID:#7cc576" .. id .. " | #ffffffproprietário: #7cc576" .. oname, playerSource, 255,255,255,true)			
			end
		end
	end
end)


function getElementDataPlayerByAccountID(owner,elementDataName)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"acc:id") == owner then
			return getElementData(v,elementDataName)
		else
			return "n/a"
		end
	end
end

function toggleInvisibility(thePlayer)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
	if (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 1) then
		local enabled = getElementData(thePlayer, "invisible")
		if (enabled == true) then
			setElementAlpha(thePlayer, 255)
			setElementData(thePlayer, "reconx", false)
			setElementData(thePlayer, "invisible", false)
			

			local xp, yp, zp = getElementPosition(thePlayer)
			local int = getElementInterior(thePlayer) 
			local dim = getElementDimension(thePlayer)
			if getElementModel(thePlayer) == 309 then
			triggerClientEvent(root, "lobinho", thePlayer, thePlayer, 2, xp, yp, zp, int, dim)
			elseif getElementModel(thePlayer) == 308 then
			triggerClientEvent(root, "lobinho", thePlayer, thePlayer, 1, xp, yp, zp, int, dim)
			elseif getElementModel(thePlayer) == 177 then
			triggerClientEvent(root, "lobinho", thePlayer, thePlayer, 3, xp, yp, zp, int, dim)
			end

		elseif (enabled == false or enabled == nil) then
			setElementAlpha(thePlayer, 0)
			setElementData(thePlayer, "reconx", true)
			setElementData(thePlayer, "invisible", true)
		else
			outputChatBox("Desligue a TV de Admin primeiro.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("v", toggleInvisibility)
addCommandHandler("vanish", toggleInvisibility)

addCommandHandler("chutar",
	function(player, cmd, target, ...)
		local value = getElementData(player,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(player, "acc:admin") or 0) >= 7) then outputChatBox("#7cc576Você não está no modo admin!!",player, 255, 194, 14, true) return end
		if getElementData(player, "acc:admin") >= 1 then
				if not (target) or not (...) then
					outputChatBox("#7cc576Use:#ffffff /" .. cmd .. " [nome / ID] [MOTIVO]",player, 255, 194, 14, true)
				else
				local targetPlayer,targetPlayerName = exports["bgo_core"]:findPlayer(player, target)
				local name = table.concat({...}, " ")
				
					if targetPlayer then
						
						if ((getElementData(targetPlayer, "acc:admin") or 0) > getElementData(player, "acc:admin")) then
							outputChatBox(error .. "Você não tem o direito de disparar " .. targetPlayerName:gsub("_", " ") .. ".", player, 255, 255, 255, true)
							return
						end
						
						local kick = setTimer( function() 
							kickPlayer( targetPlayer, getPlayerAdminName(player), name ) 
						end, 1000, 1)
						local id = getElementData(targetPlayer, "acc:id") or 0
						
						if (kick) then

							outputChatBox(getPlayerAdminName(player).. " Expulso do servidor o jogador "..targetPlayerName:gsub("_"," ").."",root, 255, 194, 14, true)


						-- exports.bgo_kickban:showBoxS(root,getPlayerAdminName(player).. " chutado do servidor "..targetPlayerName:gsub("_"," ").."","causa: "..name,"kick")
						else
							outputChatBox(error .. "Error. Encontre um desenvolvedor!", player, 255, 255, 255, true)
						end
						
					end
				end
		end
	end)



----------------------------------------------------------------------------------------------------------------------------------------
-- /setadminnick, /setadminlevel, /sethelperlevel -- ADMINISZTRÁTOR, ADMINSEGÉD KEZELÉSI PARANCSOK
----------------------------------------------------------------------------------------------------------------------------------------

function setAdminNick(thePlayer, commandName, target, name)
	if getElementData(thePlayer, "acc:admin") > 6 then
		
		if not (target) or not (name) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [level]", thePlayer, 255, 255, 255, true)
		else
		
			local targetPlayer, targetPlayerName = exports["bgo_core"]:findPlayer(thePlayer, target)
			local adminName = table.concat({name}, " ")
			local theName = getPlayerAdminName(thePlayer) or ""
			local targetOldName = getPlayerAdminName(targetPlayer) or ""
				if not getElementData(targetPlayer, "loggedin") then return end
				
				if (targetPlayer) then
				
				if getElementData(targetPlayer, "acc:aseged") > 0 then
					--outputChatBox(error .. "Adminsegédnek nincs jogosultságod adminnevet beállítani. Hibakód: SAN2", thePlayer, 255, 255, 255, true)
					return
				end
				
				local sql = dbExec(con, "UPDATE characters SET anick='" .. adminName .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				
				if (sql) then
					outputChatBox("#7cc576[BGO MTA]: " .. theName .. "#ffffff mudado #7cc576" .. targetOldName .. "#ffffff. #7cc576("..targetOldName.. " >> "..adminName ..")", root, 255, 255, 255, true)
					setElementData(targetPlayer,"char:anick",adminName)
				else
					outputChatBox(error .. "Não foi possível alterar (salvar) " .. targetOldName .. " nome do administrador.", thePlayer, 255, 255, 255, true)

				end
			end
		end
	end
end
addCommandHandler("setadminnick", setAdminNick, false, false)
addCommandHandler("setadminname", setAdminNick, false, false)

function setAdminLevel(thePlayer, commandName, targetPlayer, rank)
	if getElementData(thePlayer, "acc:admin") >= 7 or enabledSerials[getPlayerSerial(thePlayer)] then
		
		if not (targetPlayer) or not (rank) then
			outputChatBox("#7cc576use: #ffffff/" .. commandName .. " [Nome / ID] [Level]", thePlayer, 255, 255, 255, true)
		else

			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local rank = tonumber(rank)
			local rank = math.floor(rank)
			local oldRank = getElementData(targetPlayer, "acc:admin")
			
			if not getElementData(targetPlayer, "loggedin") then return end
			
			if (targetPlayer) then
				if (rank) > 10 or (rank) < 0 then
					outputChatBox(error .. "As classificações do administrador são apenas entre 1 e 10.", thePlayer, 255, 255, 255, true)
					return
				end
				setElementData(targetPlayer, "char:adminduty", 0)
				
				if (rank) < 7 then
					if getElementData(targetPlayer, "acc:admin") >= 8 and getElementData(thePlayer, "acc:admin") < 10 and not enabledSerials[getPlayerSerial(thePlayer)] then
						outputChatBox(error .. "Você não tem autoridade para mudar #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador.", thePlayer, 255, 255, 255, true)
					else
						
						if getElementData(targetPlayer, "acc:admin") < getElementData(thePlayer, "acc:admin") or enabledSerials[getPlayerSerial(thePlayer)] or getElementData(thePlayer, "acc:admin") == 10 then
							local sql = dbExec(con, "UPDATE accounts SET admin='" .. rank .. "' WHERE id='".. getElementData(targetPlayer, "acc:id") .. "'")

							if (sql) then
								outputChatBox("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador. #7cc576(" .. oldRank .. " >> " .. rank ..")", root, 255, 255, 255, true)
								setElementData(targetPlayer, "acc:admin", rank)
								if (rank) == 0 then
									setElementData(targetPlayer, "char:aduty", 0)
									dbExec(con, "UPDATE characters SET adminduty='0' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
								end
							else
								outputChatBox(error .. "Não foi possível alterar (salvar) #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador.", thePlayer, 255, 255, 255, true)
							end
						else
							outputChatBox(error .. "Você não tem autoridade para mudar #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador.", thePlayer, 255, 255, 255, true)
						end
					end
				elseif (rank) >= 7 then
					if getElementData(thePlayer, "acc:admin") == 10 or enabledSerials[getPlayerSerial(thePlayer)] then
						local sql = dbExec(con, "UPDATE accounts SET admin='" .. rank .. "' WHERE id='".. getElementData(targetPlayer, "acc:id") .. "'")

						if (sql) then
							outputChatBox("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador. #7cc576(" .. oldRank .. " >> " .. rank ..")", root ,255, 255, 255, true)
							setElementData(targetPlayer, "acc:admin", rank)
						else
							outputChatBox(error .. "Não foi possível alterar (salvar) #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador. Código de erro SAL2", thePlayer, 255, 255, 255, true)
						end
					elseif getElementData(thePlayer, "acc:admin") >= 8 and (rank) <= 7 and getElementData(targetPlayer, "acc:admin") < getElementData(thePlayer, "acc:admin") then
						local sql = dbExec(con, "UPDATE accounts SET admin='" .. rank .. "' WHERE id='".. getElementData(targetPlayer, "acc:id") .. "'")

						if (sql) then
							outputChatBox("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador. #7cc576(" .. oldRank .. " >> " .. rank ..")", root ,255, 255, 255, true)
							setElementData(targetPlayer, "acc:admin", rank)
						else
							outputChatBox(error .. "Não foi possível alterar (salvar) #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador.", thePlayer, 255, 255, 255, true)
						end
					else
						outputChatBox(error .. "Você não tem autoridade para mudar #7cc576" .. getPlayerAdminName(targetPlayer) .. "#ffffff nível de administrador.", thePlayer, 255, 255, 255, true)
					end
				end
			end
		end


	end
end
addCommandHandler("setadminlevel", setAdminLevel, false, false)

timerPM = {}

function privateMessage(thePlayer, commandName, targetPlayer, ...)
	if not getElementData(thePlayer, "loggedin") then
		outputChatBox("não permitido", thePlayer)
		return
	end

	if not (targetPlayer) or not (...) then
		outputChatBox("#7cc576use: #ffffff/".. commandName .. " [Nome / ID] [mensagem]", thePlayer, 255, 255, 255, true)
	else
	
		local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

		--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end


		if not (targetPlayer) then return end
		
		if not getElementData(targetPlayer, "loggedin") then
		outputChatBox("#7cc576[BGO MTA INFO]: #ffffffEsta pessoa não está logada!", thePlayer, 255, 255, 255, true)
		return
		end
	
	
		local message = table.concat({...}, " ")
		local playerRank = tonumber(getElementData(thePlayer, "acc:admin")) or 0
		local targetRank = tonumber(getElementData(targetPlayer, "acc:admin")) or 0
		local targetHelper = tonumber(getElementData(targetPlayer, "acc:aseged")) or 0
		local adminduty = getElementData(targetPlayer, "char:adminduty")
		local playerName = getPlayerName(thePlayer):gsub("_", " ")
		local playerNameTarget = targetPlayerName:gsub("_", " ")
		local adminNameTarget = getPlayerAdminName(targetPlayer)
		local adminName = getPlayerAdminName(thePlayer)
		local playerID = getElementData(thePlayer, "acc:id")
		local targetID = getElementData(targetPlayer, "acc:id")
		 if thePlayer == targetPlayer then outputChatBox("#7cc576[BGO MTA INFO]: #ffffffVocê não pode enviar mensagem privada para você mesmo.", thePlayer, 255, 255, 255, true) return end
			 if isTimer(timerPM[thePlayer]) then outputChatBox("#7cc576[BGO MTA INFO]: #ffffffaguarde um momento para mandar outra mensagem privada.", thePlayer, 255, 255, 255, true) return end
			 
				if getElementData(targetPlayer, "status:togva") == true then
				outputChatBox("#7cc576[BGO MTA INFO]: #ffffffPm bloqueado para esta pessoa!", thePlayer, 255, 255, 255, true)
				return
				end

		        outputChatBox(" ", thePlayer, 255, 255, 255, true)
				outputChatBox("#ff5100[Mensagem Privada Enviada]#ffffff " .. targetPlayerName .. " #7cc576(" .. targetID .. "):#FFFFFF " .. message, thePlayer, 255, 255, 255, true)
				outputChatBox(" ", targetPlayer, 255, 255, 255, true)
				outputChatBox(" ", targetPlayer, 255, 255, 255, true)
				outputChatBox(" ", targetPlayer, 255, 255, 255, true)
				outputChatBox(" ", targetPlayer, 255, 255, 255, true)
				outputChatBox("#ff5100[Mensagem Privada Recebida]#ffffff " .. getPlayerName(thePlayer) .. " #7cc576(" .. playerID .. "):#FFFFFF " .. message, targetPlayer, 255, 255, 255, true)
				outputChatBox("#7cc576[BGO MTA INFO]: #ffffffpara enviar uma mensagem privada digite /pm " .. playerID .. " e sua mensagem.", targetPlayer, 255, 255, 255, true)
				timerPM[thePlayer] = setTimer(function () end, 5000, 1)

				
				triggerClientEvent(thePlayer, "enter", thePlayer)
				triggerClientEvent(targetPlayer, "privatUzenetErkezett", targetPlayer)

				if abinis[getPlayerSerial(thePlayer)] or playerID == 23 then return end

				exports.logs:logMessage("[PM] " .. getPlayerName(thePlayer) .. " ("..getElementData(thePlayer, "char:id")..") para " .. getPlayerName(targetPlayer) .. " ("..getElementData(targetPlayer, "char:id")..") : " .. message, 4)


				--for k,v in ipairs(getElementsByType("player")) do
				
				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
						if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --tonumber(getElementData(v,"acc:admin") or 0) == 10 then
						if thePlayer == v then return end
						if targetPlayer == v then return end
						if getElementData(v, "verPM") then
						outputChatBox(" ",v,255,255,255,true)
						outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff[PM] #7cc576" .. getPlayerName(thePlayer) .. " ("..getElementData(thePlayer, "char:id")..") #FFFFFFpara #7cc576" .. getPlayerName(targetPlayer) .. " ("..getElementData(targetPlayer, "char:id")..") : #FFFFFF" .. message,v,255,255,255,true)
				end
			end
        end	
		
	end	
end
addCommandHandler("pm", privateMessage, false, false)





function togValaszolasok(thePlayer, commandName)
	if getElementData(thePlayer, "acc:admin") >= 1 then
	
		local allapot = getElementData(thePlayer, "status:togva")
		
		if allapot == false then
			outputChatBox("Você desligou o #7cc576/pm#ffffff", thePlayer, 255, 255, 255, true)
			setElementData(thePlayer, "status:togva", true)
		else
			outputChatBox("Você ligou o #7cc576/pm", thePlayer, 255, 255, 255, true)
			setElementData(thePlayer, "status:togva", false)
		end
	end
end
addCommandHandler("lpm", togValaszolasok, false, false)


function togValaszolasok(thePlayer, commandName)
	if getElementData(thePlayer, "acc:id") == 2 then
	
		local allapot = getElementData(thePlayer, "verPM")
		
		if allapot == false then
			outputChatBox("Você ligou as #7cc576mensagens #ffffffprivadas", thePlayer, 255, 255, 255, true)
			setElementData(thePlayer, "verPM", true)
		else
			outputChatBox("Você desligou as #7cc576mensagens #ffffffprivadas", thePlayer, 255, 255, 255, true)
			setElementData(thePlayer, "verPM", false)
		end
	end
end
addCommandHandler("verpm", togValaszolasok, false, false)




-----------------------------[SET COLOR]---------------------------------
function setColor(player, commandName, r1, g1, b1, r2, g2, b2 )
if tonumber(getElementData(player, "acc:admin")or 0) >= 5 then
	
	if not (r1) or not (g1) or not (b1) then
		outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [R] [G] [B]", player, 255, 255, 255, true)
	else
			local veh = getPedOccupiedVehicle(player)
					
			if (veh) then
					local r1, g1, b1, r2, g2, b2 = tonumber(r1), tonumber(g1), tonumber(b1), tonumber(r2), tonumber(g2), tonumber(b2)
					local color = setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
					local sql = dbQuery(con, "UPDATE vehicle SET color=? WHERE id=?", toJSON({r1, g1, b1, r2, g2, b2}), getElementData(veh, "veh:id"))
					dbFree(sql)
					
					if (color) or (sql) then
						outputChatBox(info .. "Você pintou com sucesso o veículo.", player, 255, 255, 255, true)
						outputAdminMessage(getPlayerAdminName(player) .. " pintou o veiculo " .. getVehicleName(veh) .. " (ID: " .. getElementData(veh, "veh:id") .. ")")
						-- id-t megadni
					else
						outputChatBox(error .. "Não conseguiu colorir o veículo.", player, 255, 194, 14, true)
					end
			end
		end
	end
end
addCommandHandler("setcor", setColor, false, false)

----------------------------------------------------------------------------------------------------------------------------------------
-- /goto, /gethere, /gotocar, /getcar, /fixveh, /fuelveh, /sethp, /setarmor, /sethunger, /setskin, /setdim, /setint, /setvehint, /setvehdim, /ajail, /unjail -- ADMINISZTRÁTORI PARANCSOK
----------------------------------------------------------------------------------------------------------------------------------------

function gotoPlayer(thePlayer, commandName, targetPlayer)

	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end

	if getElementData(thePlayer, "acc:admin") >= 1 then
		
		if not (targetPlayer) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			
  			local x, y, z = getElementPosition(targetPlayer)
			local veh = getPedOccupiedVehicle(thePlayer)
			
			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

			if (tonumber(getElementData(targetPlayer, "acc:admin") or 0) >= 7)  then
				outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) 
				return 
			end


			if getElementData(targetPlayer, "loggedin") then
			
				if isPedInVehicle(thePlayer) then
					teleport = setElementPosition(veh, x, y+1, z)
				else
					teleport = setElementPosition(thePlayer, x, y+1, z)
				end
				
				if (teleport) then
					setElementInterior(thePlayer, getElementInterior(targetPlayer))
					setElementDimension(thePlayer, getElementDimension(targetPlayer))
					outputChatBox("#ffffffVocê se teleportou com sucesso #7cc576" .. targetPlayerName:gsub("_", " ") .. "#ffffff Jogador.", thePlayer, 255, 255, 255, true)
					--outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff teleportado para você.", targetPlayer, 255, 255, 255, true)


				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
						if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --tonumber(getElementData(v,"acc:admin") or 0) == 10 then
						outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).."  Usou o comando /goto no jogador "..targetPlayerName.." ",v,255,255,255,true)
						exports.logs:logMessage("[GOTO]: "..getPlayerName(thePlayer).."  Usou o comando /goto no jogador "..targetPlayerName.." ", 3)
					end
				end


				else
					outputChatBox(error .. "Não é possível teleportar para o jogador.", thePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox(error .. "O jogador não está logado.", thePlayer ,255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("goto", gotoPlayer, false, false)

function SgotoPlayer(thePlayer, commandName, targetPlayer)
	if getElementData(thePlayer, "acc:admin") >= 4 then
		
		if not (targetPlayer) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local x, y, z = getElementPosition(targetPlayer)
			local veh = getPedOccupiedVehicle(thePlayer)
			
			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

			if getElementData(targetPlayer, "loggedin") then
			
				if isPedInVehicle(thePlayer) then
					teleport = setElementPosition(veh, x, y+1, z)
				else
					teleport = setElementPosition(thePlayer, x, y+1, z)
				end
				
				if (teleport) then
					setElementInterior(thePlayer, getElementInterior(targetPlayer))
					setElementDimension(thePlayer, getElementDimension(targetPlayer))
					outputChatBox("#ffffffVocê se teleportou com sucesso #7cc576" .. targetPlayerName:gsub("_", " ") .. "#ffffff jogador. #dc143c(Secret)", thePlayer, 255, 255, 255, true)
				--	outputAdminMessage("#7cc576"..getPlayerAdminName(thePlayer) .. "#ffffff secretamente deportado " .. targetPlayerName:gsub("_"," ") .. " játékoshoz.")
					--outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff teleportado para você.", targetPlayer, 255, 255, 255, true)

					local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
						if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --tonumber(getElementData(v,"acc:admin") or 0) == 10 then
						outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).."  Usou o comando /sgoto no jogador "..targetPlayerName.." ",v,255,255,255,true)
					end
				end


				else
					outputChatBox(error .. "Não é possível teleportar para o jogador.", thePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox(error .. "O jogador não está logado.", thePlayer ,255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("sgoto", SgotoPlayer, false, false)

function getPlayerHere(thePlayer, commandName, targetPlayer)

	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 2 then
		
		if not (targetPlayer) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Név / ID]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local x, y, z = getElementPosition(thePlayer)
			
			--if getElementData(targetPlayer, "acc:id") == 1 then 
			if (tonumber(getElementData(targetPlayer, "acc:admin") or 0) >= 7)  then
				outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) 
				return 
			end

			if getElementData(targetPlayer, "loggedin") == true then
			
				if getElementData(targetPlayer, "adminjail") == 1 and getElementData(thePlayer, "acc:admin") < 6 then
					outputChatBox(error .. "O jogador está no admin. Você não pode obter gueto.", thePlayer, 255, 255, 255, true)
					return
				end
				if isPedInVehicle(targetPlayer) then
					local veh = getPedOccupiedVehicle(targetPlayer)
					teleport = setElementPosition(veh, x, y+1, z)
				else
					teleport = setElementPosition(targetPlayer, x, y+1, z)
				end
				if (teleport) then
					setElementInterior(targetPlayer, getElementInterior(thePlayer))
					setElementDimension(targetPlayer, getElementDimension(thePlayer))
					outputChatBox("Você se teleportou com sucesso para si mesmo #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff jogador.", thePlayer, 255, 255, 255, true)
					outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff teleportou você.", targetPlayer, 255, 255, 255, true)
				for k,v in ipairs(getElementsByType("player")) do
					if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --and tonumber(getElementData(v,"acc:admin") or 0) == 10 then
					outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).." Usou o comando /gethere para puxar o jogador "..targetPlayerName.." ",v,255,255,255,true)
				end
				end
				else
					outputChatBox(error .. "Falha ao teletransportar o jogador para si mesmo.", thePlayer, 255, 255, 255, true)		
				end
			else
				outputChatBox(error .. "O jogador não está logado.", thePlayer ,255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("gethere", getPlayerHere, false, false)

function gotoCar(thePlayer, commandName, id)

	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end



	if getElementData(thePlayer, "acc:admin") >= 1 then
		
		if not (id) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Jármű ID]", thePlayer, 255, 255, 255, true)
		else
			
			local veh = findVehicle(id)
			local x, y, z = getElementPosition(veh)
			
			if not veh then
				outputChatBox(error .. "ID do veículo incorreto.", thePlayer, 255, 255, 255, true)
				return
			end
			
			local teleport = setElementPosition(thePlayer, x+2, y+2, z)
			local int = getElementInterior(veh)
			local dim = getElementDimension(veh)
			if getElementDimension(veh) >= 100000 then return end
			
			if (teleport) then
				setElementInterior(thePlayer, int)
				setElementDimension(thePlayer, dim)
				outputChatBox(rovid.." #ffffffVocê conseguiu transportar o veículo com sucesso. (ID: #7cc576" .. id .. "#ffffff)", thePlayer, 255, 255, 255, true)

				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
					if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --and tonumber(getElementData(v,"acc:admin") or 0) == 10 then
					outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).." Usou o comando /gotocar para ir até o veiculo "..id.." ",v,255,255,255,true)
				end
			end

			else
				outputChatBox(error .. "Incapaz de se teletransportar para o veículo.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("gotocar", gotoCar, false, false)


function getCar(thePlayer, commandName, id)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 2 then
		
		if not (id) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [ID do veículo]", thePlayer, 255, 255, 255, true)
		else
			
			local veh = findVehicle(id)
			
			if not veh then
				outputChatBox(error .. "ID do veículo incorreto.", thePlayer, 255, 255, 255, true)
				return
			end
			
			local x, y, z = getElementPosition(thePlayer)
			local int = getElementInterior(thePlayer)
			local dim = getElementDimension(thePlayer)
			if getElementDimension(veh) >= 100000 then return end
			local teleport = setElementPosition(veh, x+2, y+2, z+1)
			
			if (teleport) then
				setElementInterior(veh, int)
				setElementDimension(veh, dim)
				outputChatBox(rovid.." #ffffffO veículo foi teleportado com sucesso para você. (ID: #7cc576" .. id .. "#ffffff)", thePlayer, 255, 255, 255, true)


				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
					if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --and tonumber(getElementData(v,"acc:admin") or 0) == 10 then
					outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).." Usou o comando /getcar para puxar o veiculo "..id.." ",v,255,255,255,true)
				end
			end


			else
				outputChatBox(error .. "Falha ao teletransportar o veículo para si mesmo. Código de erro GETCAR 1", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("getcar", getCar, false, false)

function fixPlayerVehicle(thePlayer, commandName, targetPlayer)

	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end



	if getElementData(thePlayer, "acc:admin") >=3 then
	
		if not (targetPlayer) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID]", thePlayer, 255, 255, 255, true)
		else		
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local adminduty = getElementData(thePlayer, "char:adminduty")
			local alevel = getElementData(thePlayer, "acc:admin")
			local veh = getPedOccupiedVehicle(targetPlayer)
			
			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

				if not targetPlayer or not getElementData(targetPlayer, "loggedin") then return end
			
			if veh then
				if (adminduty) == 0 then
					if (alevel) >= 6 then
						fixVehicle(veh)
       					setVehicleDamageProof (veh, false ) 
						triggerClientEvent(root, "setvehicleCompVisible", root, targetPlayer)
						--outputChatBox("#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff consertou seu veículo. ", targetPlayer, 255, 255, 255, true)
						outputChatBox(rovid.." Consertado com sucesso #7cc576" .. targetPlayerName:gsub("_", " ") .. "#ffffff veículo.", thePlayer, 255, 255, 255, true)
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Ele reparado. #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff veículo.")
					else
						outputChatBox(error .. "Você não está autorizado a consertar o veículo fora da admissão. Código de erro FIXVEH AD1", thePlayer, 255, 255, 255, true)
					end
				else
					triggerClientEvent(root, "setvehicleCompVisible", root, targetPlayer)
					fixVehicle(veh)
				       setVehicleDamageProof (veh, false ) 
				--outputChatBox("#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff consertou seu veículo. ", targetPlayer, 255, 255, 255, true)
					outputChatBox(rovid .." Consertado com sucesso #7cc576" .. targetPlayerName:gsub("_", " ") .. "#ffffff veículo.", thePlayer, 255, 255, 255, true)
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff reparado #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff veículo.")
				end
			else
				outputChatBox(error .. "O jogador não está no veículo.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("fixveh", fixPlayerVehicle, false, false)

function setVehicleHealth(thePlayer, commandName, targetPlayer, health)

	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end



	if getElementData(thePlayer, "acc:admin") >= 1 then

		if not (targetPlayer) or not (health) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [Nível]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local health = tonumber(health)
			local veh = getPedOccupiedVehicle(targetPlayer)
			
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			
			if health < 0 or health > 1000 then
				outputChatBox(error .. "O nível só pode estar entre 0 e 1000.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if getElementData(thePlayer, "acc:admin") < 6 and getElementData(thePlayer, "char:adminduty") == 0 then
				outputChatBox(error .. "Você não tem autoridade para alterar o status do veículo de um jogador fora do jogo.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if not (veh) then
				outputChatBox(error .. "O jogador não está no veículo.", thePlayer, 255, 255, 255, true)
			else
				local sql = dbExec(con, "UPDATE vehicle SET hp='" .. health .. "' WHERE id='" .. getElementData(veh, "veh:id") .. "'")
				if (sql) then
					setElementHealth(veh, health)
					--outputChatBox("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudou a condição do seu veículo. (" .. health .. ")", targetPlayer, 255, 255, 255, true)
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado #3399FF" .. targetPlayerName:gsub("_"," ") .. " #ffffffo estado do seu veículo. #7cc576F(" .. health .. ")")
				else
					outputChatBox(error .. "Não foi possível alterar o status dos veículos do jogador.", thePlayer, 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("setcarhp", setVehicleHealth, false, false)

function fuelPlayerVehicle(thePlayer, commandName, targetPlayer)

	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end



	if getElementData(thePlayer, "acc:admin") >=5 then
	
		if not (targetPlayer) then
			outputChatBox("#7cc586Use: #ffffff/" .. commandName .. " [Nome / ID]", thePlayer, 255, 255, 255, true)
		else
		
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local adminduty = getElementData(thePlayer, "char:adminduty")
			local alevel = getElementData(thePlayer, "acc:admin")
			local veh = getPedOccupiedVehicle(targetPlayer)
			if not getElementData(targetPlayer, "loggedin") then return end
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			if isPedInVehicle(targetPlayer) then
				if (adminduty) == 0 then
					if (alevel) >= 6 then
					setElementData(veh, "veh:fuel", 100)
					--outputChatBox("#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff socou seu veículo. ", targetPlayer, 255, 255, 255, true)
					--outputChatBox("Você foi expulso #7cc576" .. targetPlayerName:gsub("_", " ") .. "#ffffff járművét.", thePlayer, 255, 255, 255, true)
					--outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff megtankolta #7cc576" .. targetPlayerName:gsub("_"," ") .. " #ffffffveículo.")
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Colocou gasolina no veiculo do jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "")
					else
						outputChatBox(error .. "Você não tem permissão para fechar o veículo fora da admissão.", thePlayer, 255, 255, 255, true)
					end
				else
					setElementData(veh, "veh:fuel", 100)
					--outputChatBox("#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff socou seu veículo. ", targetPlayer, 255, 255, 255, true)
					--outputChatBox("Você foi expulso #7cc576" .. targetPlayerName:gsub("_", " ") .. "#ffffff veículo.", thePlayer, 255, 255, 255, true)
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Colocou gasolina no veiculo do jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "")
				end
			else
				outputChatBox(error .. "O jogador não está no veículo.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("fuelveh", fuelPlayerVehicle, false, false)

function setPlayerHealth(thePlayer, commandName, targetPlayer, level)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 2 then

		if not (targetPlayer) or not (level) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [vitalidade]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local level = tonumber(level)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			
			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end


			if (level) < 0 or (level) > 100 then
				outputChatBox(error .. "Os valores estão entre 0 e 100.", thePlayer, 255, 255, 255, true)
				return false
			end
			
			local setHealth = setElementHealth(targetPlayer, level)
			
			if (setHealth) then
				outputChatBox(info .. "Você mudou com sucesso #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff vitalidade. (" .. level .. ")", thePlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff setou vida no jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. " #ffffffquantidade: (" .. level .. ")")
				exports.logs:logMessage("[SET HP]: " .. getPlayerAdminName(thePlayer) .. " setou vida no jogador " .. targetPlayerName:gsub("_"," ") .. " quantidade: (" .. level .. ")", 3)
			else
				outputChatBox(error .. "Não foi possível alterar o hp do " .. targetPlayerName:gsub("_"," ") .. "", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("sethp", setPlayerHealth, false, false)

function setPlayerArmorLevel(thePlayer, commandName, targetPlayer, level)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 1 then

		if not (targetPlayer) or not (level) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [Nível de armadura]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local level = tonumber(level)	
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end			
			
			
			if (level) > 100 then
				outputChatBox(error .. "Os valores estão entre 0 e 100.", thePlayer, 255, 255, 255, true)
				return false
			end
			
			local setArmor = setPedArmor(targetPlayer, level)
			
			if (setArmor) then
				outputChatBox(info .. "Você mudou com sucesso #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff nível de armadura. (" .. level .. ")", thePlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff nível de armadura. (" .. level .. ")")
			else
				outputChatBox(error .. "Não foi possível alterar " .. targetPlayerName:gsub("_"," ") .. " páncél szintjét. Hibakód: SARMOR1", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setarmor", setPlayerArmorLevel, false, false)

function setPlayerHungerLevel(thePlayer, commandName, targetPlayer, level)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 5 then

		if not (targetPlayer) or not (level) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [Fome]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local level = tonumber(level)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end			
			
			
			if (level) > 100 then
				outputChatBox(error .. "Os valores estão entre 0 e 100.", thePlayer, 255, 255, 255, true)
				return false
			end
			
			local setHunger = setElementData(targetPlayer, "char:hunger", level)
			
			if (setHunger) then
				outputChatBox(info .. "Você mudou com sucesso #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff níveis de fome. (" .. level .. ")", thePlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffffmudado #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff níveis de fome. (" .. level .. ")")
			else
				outputChatBox(error .. "Não foi possível alterar " .. targetPlayerName:gsub("_"," ") .. " éhségszintjét. Hibakód: SHUNGER1", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setfome", setPlayerHungerLevel, false, false)


function setPlayerHungerLevel2(thePlayer, commandName, targetPlayer, level)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 5 then

		if not (targetPlayer) or not (level) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [sede]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local level = tonumber(level)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end			
			
			
			if (level) > 100 then
				outputChatBox(error .. "Os valores estão entre 0 e 100.", thePlayer, 255, 255, 255, true)
				return false
			end
			
			local setHunger = setElementData(targetPlayer, "char:hunger", level)
			
			if (setHunger) then
				outputChatBox(info .. "Você mudou com sucesso #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff níveis de sede. (" .. level .. ")", thePlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffffmudado #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff níveis de sede. (" .. level .. ")")
			else
				outputChatBox(error .. "Não foi possível alterar " .. targetPlayerName:gsub("_"," ") .. " éhségszintjét. Hibakód: SHUNGER1", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setsede", setPlayerHungerLevel2, false, false)


function setName(thePlayer, commandName, targetPlayer, ...)
	if getElementData(thePlayer, "acc:admin") >= 9 then
	
		if not (targetPlayer) or not (...) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [novo nome]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local newName = table.concat({...}, "_")
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			
				if not getElementData(targetPlayer, "loggedin") then return end
			
			local qh = dbQuery(con, "SELECT * FROM characters WHERE charname='" .. newName:gsub("_", " ") .. "'")
			local result, num = dbPoll(qh, -1)
			if num>0 then
				outputChatBox(error .. "Este nome já está em uso.", thePlayer, 255, 255, 255, true)
				return
			end
			
			local sql = dbExec(con, "UPDATE characters SET charname='" .. newName:gsub("_"," ") .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
			
			
			if (sql) then
				outputChatBox(info .. "Você mudou com sucesso " .. targetPlayerName:gsub("_"," ") .. " nome. (" .. newName .. ")", thePlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado " .. targetPlayerName:gsub("_"," ") .. " nevét. (" .. newName .. ")")
				setPlayerName(targetPlayer, newName)
				local newNameS = newName:gsub("_"," ")
				setElementData(targetPlayer, "char:charname", newName)
				setElementData(targetPlayer, "char:name", newNameS)
				setElementData(targetPlayer, "char:oldName", newName)
			else
			
			end
		end
	end
end
addCommandHandler("setname", setName, false, false)

function setElementModel2(thePlayer, commandName, targetPlayer, skin)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 4 then
		
		if not (targetPlayer) or not (skin) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [ID da skin]", thePlayer, 255, 255, 255, true)
		else
		
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local skin = tonumber(skin)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			
			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

			if getElementModel(targetPlayer) == skin then
				outputChatBox(error .. "O jogador já tem essa skin.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if setElementModel(targetPlayer, skin) then
				outputChatBox("Você mudou com sucesso #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff skinjét.", thePlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudado #7cc576" .. targetPlayerName:gsub("_"," ") .. " #ffffffSkin.#ffffff (" .. skin .. ")")
				dbExec(con, "UPDATE characters SET skin = ? WHERE ID = ?",skin,getElementData(targetPlayer, "acc:id"))
			else
				outputChatBox(error .. "Não foi possível alterar #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff skinjét. Hibakód: SSKIN1", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setpskin", setElementModel2, false, false)


function setPlayerSkin2(thePlayer, commandName, skin)
	if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 4 
	or beneficiario(thePlayer) then
	
			if getElementModel(thePlayer) == skin then
				outputChatBox(error .. "O jogador já tem essa skin.", thePlayer, 255, 255, 255, true)
				return
			end
			setElementModel(thePlayer, skin)
			outputChatBox("Você mudou com sucesso sua skin", thePlayer, 255, 255, 255, true)
	end
end
addCommandHandler("ss", setPlayerSkin2, false, false)



function setDim(thePlayer, commandName, targetPlayer, value)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >=1 then
	
		if not (targetPlayer) or not (value) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [ID da dimensão]", thePlayer, 255, 255, 255, true)
		else
		
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local dim = tonumber(value)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
		
			if setElementDimension(targetPlayer, dim) then
				outputChatBox(info .. "Você mudou com sucesso " .. targetPlayerName:gsub("_"," ") .. " dimenzióját. (" .. dim .. ")", thePlayer, 255, 255, 255, true)
				outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudou sua dimensão. (" .. dim .. ")", targetPlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setdim", setDim, false, false)

function setInt(thePlayer, commandName, targetPlayer, value)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >=1 then
	
		if not (targetPlayer) or not (value) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [ID da dimensão]", thePlayer, 255, 255, 255, true)
		else
		
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local value = tonumber(value)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
		
			if setElementInterior(targetPlayer, value) then
				outputChatBox(info .. "Você mudou com sucesso " .. targetPlayerName:gsub("_"," ") .. " interior. (" .. value .. ")", thePlayer, 255, 255, 255, true)
  				outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudou o interior. (" .. value .. ")", targetPlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setint", setInt, false, false)

function setVehDim(thePlayer, commandName, id, value)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >=1 then
	
		if not (id) or not (value) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [ID] [Dimension ID]", thePlayer, 255, 255, 255, true)
		else
		
			local veh = findVehicle(id)
			local dim = tonumber(value)
		
			if setElementDimension(veh, dim) then
				outputChatBox(info .. "Você mudou com sucesso " .. id .. " dimenzióját. (" .. dim .. ")", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setvehdim", setVehDim, false, false)

function setVehInt(thePlayer, commandName, id, value)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >=1 then
	
		if not (id) or not (value) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [ID] [Dimension ID]", thePlayer, 255, 255, 255, true)
		else
		
			local veh = findVehicle(id)
			local dim = tonumber(value)
		
			if setElementInterior(veh, dim) then
				outputChatBox(info .. "Você mudou com sucesso " .. id .. " interior. (" .. dim .. ")", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setvehint", setVehInt, false, false)

function setVehInt(thePlayer, commandName, targetPlayer, value)
	if getElementData(thePlayer, "acc:admin") >=1 then
	
		if not (targetPlayer) or not (value) then
			outputChatBox("#7cc576User:#ffffff /" .. commandName .. " [Név / ID] [Dimension ID]", thePlayer, 255, 255, 255, true)
		else
		
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local value = tonumber(value)
		
			if setElementInterior(targetPlayer, value) then
				outputChatBox(info .. "Você mudou com sucesso " .. targetPlayerName:gsub("_"," ") .. " interior. (" .. value .. ")", thePlayer, 255, 255, 255, true)
				outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff mudou o interior.(" .. value .. ")", targetPlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setvehint", setInt, false, false)


local randomPos2 = {
     {566.754, -3202.246, 843.152},
     {566.524, -3210.961, 843.152},
     {574.272, -3211.497, 843.152},
     {574.76, -3201.989, 843.152},
     {570.531, -3203.142, 843.152},
	 {570.589, -3211.178, 843.152},
}



function adminJail(thePlayer, commandName, targetPlayer, ido, ...)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 1 then
	
		if not (targetPlayer) or not (ido) or not (...) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome / ID] [Minutos] [Motivo]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local ido = tonumber(ido)
			local reason = table.concat({...}, " ")
			
				if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
				if not getElementData(targetPlayer, "loggedin") then return end
			
			if (ido) <= 0 then
				outputChatBox(error .. "Minutos não são permitidos em 0.", thePlayer ,255, 255, 255, true)
				return
			elseif (ido) > 120 and getElementData(thePlayer, "acc:admin") < 2 then
				outputChatBox(error .. "Você não tem autoridade para compartilhar mais de 120 minutos de admin.", thePlayer, 255, 255, 255, true)
				return
			elseif (ido) > 300 and getElementData(thePlayer, "acc:admin") < 3 then
				outputChatBox(error .. "Você não tem autoridade para compartilhar mais de 300 minutos de admin.", thePlayer, 255, 255, 255, true)
				return
			elseif (ido) > 400 and getElementData(thePlayer, "acc:admin") < 4 then
				outputChatBox(error .. "Nincs jogosultságod 400 percet meghaladó adminjailt osztani.", thePlayer, 255, 255, 255, true)
				return
			elseif (ido) > 500 and getElementData(thePlayer, "acc:admin") < 5 then
				outputChatBox(error .. "Você não tem autoridade para compartilhar mais de 400 minutos de admin.", thePlayer, 255, 255, 255, true)
				return			
			elseif (ido) > 600 and getElementData(thePlayer, "acc:admin") < 6 then
				outputChatBox(error .. "Você não tem permissão para compartilhar administradores por mais de 600 minutos.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if not (targetPlayer) then
				return
			end
			
			--közbe
				if getElementData(targetPlayer, "adminjail") == 1 then
					outputChatBox(error .. "O jogador já está no Prisão Admin.", thePlayer, 255, 255, 255, true)
					outputChatBox("Se você quiser atualizar a penalidade, primeiro solte ele utilizando #7cc576/liberar [ID]#ffffff e tente novamente.", thePlayer, 255, 255, 255, true)
					return
				end
			
				outputChatBox("#dc143c[Prisão Admin]:#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff Prendeu o jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff por #1a75ff" .. ido .. "#ffffff minutos.", root ,255, 255, 255, true)
				outputChatBox("#dc143c[Prisão Admin]:#7cc576 Motivo:#ffffff " .. reason, root ,255, 255, 255, true)
				
				--triggerEvent(thePlayer, "prendendoStaff", thePlayer, targetPlayer, ido, reason)
				
				exports.bgo_portaocadeia:prendendoStaff(thePlayer, targetPlayer, ido, reason)
				
				
--[[
				local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
				local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
				
				if isTimer(theTimerCheck) then
					killTimer(theTimerCheck)
				end
				
				if isTimer(theTimerCheck2) then
					killTimer(theTimerCheck2)
				end
				
				if isPedInVehicle(targetPlayer) then
					removePedFromVehicle(targetPlayer)
				end
				setElementData(targetPlayer, "player:preso", true)
				fadeCamera(targetPlayer, false, 1.0)
				showChat(targetPlayer, false)
				setElementFrozen(targetPlayer, true)
				if isPedInVehicle(targetPlayer) then
					toggleAllControls(targetPlayer, false, false, false)
				end
				
				setTimer(function()
					triggerClientEvent(targetPlayer, "triggerAdminjail", targetPlayer, thePlayer, reason, ido, 1, false)
				end, 500, 1)
				
				setTimer( function()
					local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
					local theTimer = setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
					local idoTelikMentes = setElementData(targetPlayer, "idoTelik", ido)
					local idoLetelt = setElementData(targetPlayer, "idoLetelt", 0)
					--local setPosition = setElementPosition(targetPlayer, 1571.337, -1705.537, 13.598) 

					pos2 = math.random(#randomPos2)
					setElementPosition(targetPlayer, randomPos2[pos2][1], randomPos2[pos2][2], randomPos2[pos2][3])
					
		 			setElementInterior(targetPlayer, 3)
					setElementDimension(targetPlayer, 1)
		 
					local adminjailed = setElementData(targetPlayer, "adminjail", 1)
					local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", reason)
					local alapido = setElementData(targetPlayer, "adminjail:ido", ido)
					local admin = setElementData(targetPlayer, "adminjail:admin", getPlayerAdminName(thePlayer))
					local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", getPlayerSerial(thePlayer))
				end, 1500, 1)
								
				setTimer(function()
					fadeCamera(targetPlayer, true, 2.5)
					setElementFrozen(targetPlayer, false)
					toggleAllControls(targetPlayer, true, true, true)
					showChat(targetPlayer, true)
				end, 7500, 1)
			
				local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 1, reason, ido, ido, getPlayerAdminName(thePlayer), getPlayerSerial(thePlayer))
				--local ajailMentes = dbExec(con, "INSERT INTO adminjails SET jailed_player = ?, jailed_playerSerial = ?, jailed_accountID = ?, jailed_admin = ?, jailed_adminSerial = ?, jailed_reason = ?, jailed_ido = ?, jailed_idopont=CURDATE(), jailed_idopontora=CURTIME()", targetPlayerName:gsub("_"," "), getPlayerSerial(targetPlayer), getElementData(targetPlayer, "acc:id"),getPlayerAdminName(thePlayer), getPlayerSerial(thePlayer), reason, ido)
			]]--
			
			
		end
	end
end
addCommandHandler("prender", adminJail, false, false)


function offlineAdminJail(thePlayer, commandName, targetPlayer, ido, ...)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 3 then
	
		if not (targetPlayer) or not (ido) or not (...) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Nome completo] [Minuto] [Motivo]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer = targetPlayer:gsub("_"," ")
			local ido = tonumber(ido)
			local reason = table.concat({...}, " ")
			local charid = false
			
			local sql = dbQuery(con, "SELECT * FROM characters WHERE charname='" .. targetPlayer .. "' LIMIT 1")
			local result = dbPoll(sql, -1)
			
			if result then
				for _, row in ipairs(result) do
					
					charid = row["id"]
					
				end
				
				local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. charid .. "'", 1, reason, ido, ido, getPlayerAdminName(thePlayer), getPlayerSerial(thePlayer))
				local ajailMentes = dbExec(con, "INSERT INTO adminjails SET jailed_player = ?, jailed_playerSerial = ?, jailed_accountID = ?, jailed_admin = ?, jailed_adminSerial = ?, jailed_reason = ?, jailed_ido = ?, jailed_idopont=CURDATE(), jailed_idopontora=CURTIME()", targetPlayer, charid, charid, getPlayerAdminName(thePlayer), getPlayerSerial(thePlayer), reason, ido)
			
				if sql then
					outputChatBox("#dc143c[Offline - Prisão admin]:#ffffff #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff Prendeu o jogador #7cc576" .. targetPlayer .. "#ffffff Por #1a75ff" .. ido .. "#ffffff Minutos.", root ,255, 255, 255, true)
					outputChatBox("#dc143c[Offline - Prisão admin]:#ffffff #7cc576Motivo: #ffffff" .. reason, root ,255, 255, 255, true)
				end
			else
				outputChatBox(error .. "Nada encontrado", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("prenderoff", offlineAdminJail, false, false)

function idoTelikLe(targetPlayer)
	if isElement(targetPlayer) and (getElementType(targetPlayer) == "player") then
		
		local idoTelik = tonumber(getElementData(targetPlayer, "idoTelik")) or false
		local idoLetelt = tonumber(getElementData(targetPlayer, "idoLetelt")) or false
		
		if (idoTelik) and (idoLetelt) then
			setElementData(targetPlayer, "idoTelik", idoTelik-1)
			setElementData(targetPlayer, "idoLetelt", idoLetelt+1)
			--outputChatBox(idoTelik .. " van hátra | " ..  idoLetelt .. " letelt | " .. getPlayerName(targetPlayer)) --IDG, eltávolítható
			local sql = dbExec(con, "UPDATE characters SET adminjail_idoTelik = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", idoTelik)

		
			if (idoTelik) <= 1 then

				outputChatBox(info .. "Sua sentença expirou.", targetPlayer, 255, 255, 255, true)
				
				--outputAdminMessage(getPlayerName(targetPlayer):gsub("_"," ") .. " adminjailje lejárt. [CHECK]") --IDG, eltávolítható
				
				local theTimer = getElementData(targetPlayer, "adminjail:theTimer")
				
				if not (theTimer) then
					return false
				end
				
				killTimer(theTimer)
				setElementData(targetPlayer, "adminjail:theTimer", false)
				setElementData(targetPlayer, "player:preso", false)
				
				local adminjailed = setElementData(targetPlayer, "adminjail", false)
				local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", false)
				local alapido = setElementData(targetPlayer, "adminjail:ido", false)
				local admin = setElementData(targetPlayer, "adminjail:admin", false)
				local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", false)
				
				--sql
				local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)

				local idoTelikVege = setElementData(targetPlayer, "idoTelik", false)
				local idoLeteltVege = setElementData(targetPlayer, "idoLetelt", false)
				
				--pos
				local setPosition = setElementPosition(targetPlayer, 2336.669, 2479.397, 14.979)
				local setInterior = setElementInterior(targetPlayer, 0)
				local setDimension = setElementDimension(targetPlayer, 0)
			end
		end
	end
end

function unJail(thePlayer, commandName, targetPlayer)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 1 then
	
		if not (targetPlayer) then
			outputChatBox("#7cc576Use#ffffff /" .. commandName .. " [Név / ID]", thePlayer, 255, 255, 255, true)
		else
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true) return end
			


			if getElementData(targetPlayer, "adminjail") == 1 then
			
				local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
				local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")

				if getElementData(targetPlayer, "adminjail:admin") == getPlayerAdminName(thePlayer) then
						
						if isTimer(theTimerCheck) then
							killTimer(theTimerCheck)
							setElementData(targetPlayer, "adminjail:theTimer", false)
						end
						if isTimer(theTimerCheck2) then
							killTimer(theTimerCheck2)
							setElementData(targetPlayer, "adminjail:theTimerAccounts", false)
						end
						
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff tirou " .. getPlayerName(targetPlayer) .." jogador da prisão") --MARAD ÉS FIXELNI AZ EGÉSZ UNJAILT RANGOKRA
						--outputChatBox(info .. "#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff removido do prisão. ", targetPlayer ,255, 255, 255, true)
						exports.bgo_portaocadeia:saircadeia(targetPlayer)		
							setElementData(targetPlayer, "player:preso", false)

						local adminjailed = setElementData(targetPlayer, "adminjail", false)
						local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", false)
						local alapido = setElementData(targetPlayer, "adminjail:ido", false)
						local admin = setElementData(targetPlayer, "adminjail:admin", false)
						local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", false)
						
						setElementData(targetPlayer, "jailed", 0)

						--sql
						local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)
						
						local idoTelikVege = setElementData(targetPlayer, "idoTelik", false)
						local idoLeteltVege = setElementData(targetPlayer, "idoLetelt", false)
						
						--pos
						local setPosition = setElementPosition(targetPlayer, 1565.026, -1673.214, 16.199)
						local setInterior = setElementInterior(targetPlayer, 0)
						local setDimension = setElementDimension(targetPlayer, 0)
				else
					if getElementData(thePlayer, "acc:admin") >= 6 then
						
						local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
						local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
						
						if isElement(theTimerCheck) then
							killTimer(theTimerCheck)
							setElementData(targetPlayer, "adminjail:theTimer", false)
						end
						if isElement(theTimerCheck2) then
							killTimer(theTimerCheck2)
							setElementData(targetPlayer, "adminjail:theTimerAccounts", false)
						end
						
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff tirou " .. getPlayerName(targetPlayer) .." jogador da prisão") --MARAD ÉS FIXELNI AZ EGÉSZ UNJAILT RANGOKRA
						--outputChatBox(info .. "#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff removido do prisão. ", targetPlayer ,255, 255, 255, true)
						setElementData(targetPlayer, "player:preso", false)
						exports.bgo_portaocadeia:saircadeia(targetPlayer)
						
						local adminjailed = setElementData(targetPlayer, "adminjail", false)
						local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", false)
						local alapido = setElementData(targetPlayer, "adminjail:ido", false)
						local admin = setElementData(targetPlayer, "adminjail:admin", false)
						local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", false)
						
						setElementData(targetPlayer, "jailed", 0)

						--sql
						local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 0, false, false, false, false, false)
						
						local idoTelikVege = setElementData(targetPlayer, "idoTelik", false)
						local idoLeteltVege = setElementData(targetPlayer, "idoLetelt", false)
						
						--pos
						local setPosition = setElementPosition(targetPlayer, 2336.669, 2479.397, 14.979)
						local setInterior = setElementInterior(targetPlayer, 0)
						local setDimension = setElementDimension(targetPlayer, 0)
					else
						outputChatBox(error .. "Você não tem permissão para remover o player da prisão admin.", thePlayer, 255, 255, 255, true)
					end
				end
			else
				outputChatBox(error .. "" .. targetPlayerName:gsub("_"," ") .. " Não está na prisão admin.", thePlayer ,255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("liberar", unJail, false, false)

function getJailedPlayers(thePlayer, commandName, targetPlayer)
	if getElementData(thePlayer, "acc:admin") >= 1 then
	
		
		
		if (targetPlayer) then
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			if getElementData(targetPlayer, "adminjail") == 1 then
				local admin = getElementData(targetPlayer, "adminjail:admin")
				local ido = getElementData(targetPlayer, "adminjail:ido")
				local reason = getElementData(targetPlayer, "adminjail:reason")
				local letelt = getElementData(targetPlayer, "idoLetelt")
				local hatravan = getElementData(targetPlayer, "idoTelik")
				
				outputChatBox("============== Consultando jogadores presos =================", thePlayer, 200, 200, 200, true)
				outputChatBox("#7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. " #00B6FF(" .. getElementData(targetPlayer, "playerid") .. ")#ffffff: preso: #7cc576" .. admin .. "#ffffff, minutos: #7cc576" .. ido .. " anos", thePlayer, 255, 255, 255, true)
				outputChatBox("#7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. " #00B6FF(" .. getElementData(targetPlayer, "playerid") .. ")#ffffff: Motivo: #7cc576" .. reason .. "", thePlayer, 255, 255, 255, true)
				outputChatBox("#7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. " #00B6FF(" .. getElementData(targetPlayer, "playerid") .. ")#ffffff: Até agora passou: #7cc576" .. letelt .. " anos#ffffff, sairá em: #7cc576" .. hatravan .. " anos", thePlayer, 255, 255, 255, true)
				outputChatBox(" ", thePlayer, 200, 200, 200, true)
			else
				outputChatBox(error .. "O jogador não está na prisão admin.", thePlayer, 255, 255, 255, true)
			end


			if getElementData(targetPlayer, "jailed") == 1 then
				local admin = getElementData(targetPlayer, "jailed:player")
				local ido = getElementData(targetPlayer, "jailed:ido")
				local reason = getElementData(targetPlayer, "jailed:reason")
				local letelt = getElementData(targetPlayer, "jailed:idoLetelt")
				local hatravan = getElementData(targetPlayer, "jailed:idoTelik")
				
				outputChatBox("============== Interrogatório de jogadores detidos =================", thePlayer, 200, 200, 200, true)
				outputChatBox("#7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. " #00B6FF(" .. getElementData(targetPlayer, "playerid") .. ")#ffffff: preso: #7cc576" .. admin .. "#ffffff, minutos: #7cc576" .. ido .. " anos", thePlayer, 255, 255, 255, true)
				outputChatBox("#7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. " #00B6FF(" .. getElementData(targetPlayer, "playerid") .. ")#ffffff: Motivo: #7cc576" .. reason .. "", thePlayer, 255, 255, 255, true)
				outputChatBox("#7cc576" .. getPlayerName(targetPlayer):gsub("_"," ") .. " #00B6FF(" .. getElementData(targetPlayer, "playerid") .. ")#ffffff: Até agora passou: #7cc576" .. letelt .. " anos#ffffff, sairá em: #7cc576" .. hatravan .. " anos", thePlayer, 255, 255, 255, true)
				outputChatBox(" ", thePlayer, 200, 200, 200, true)
			else
				outputChatBox(error .. "O jogador não está detido.", thePlayer, 255, 255, 255, true)
			end
		else
			count = 0
			count2 = 0
							local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
	
				if getElementData(v, "adminjail") == 1 then
					
					local admin = getElementData(v, "adminjail:admin")
					local ido = getElementData(v, "adminjail:ido")
					local reason = getElementData(v, "adminjail:reason")
					local letelt = getElementData(v, "idoLetelt")
					local hatravan = getElementData(v, "idoTelik")
					
					outputChatBox("============== Consultando jogadores presos =================", thePlayer, 200, 200, 200, true)
					outputChatBox("#7cc576" .. getPlayerName(v):gsub("_"," ") .. " #00B6FF(" .. getElementData(v, "playerid") .. ")#ffffff: preso: #7cc576" .. admin .. "#ffffff, minutos: #7cc576" .. ido .. " anos", thePlayer, 255, 255, 255, true)
					outputChatBox("#7cc576" .. getPlayerName(v):gsub("_"," ") .. " #00B6FF(" .. getElementData(v, "playerid") .. ")#ffffff: Motivo: #7cc576" .. reason .. "", thePlayer, 255, 255, 255, true)
					outputChatBox("#7cc576" .. getPlayerName(v):gsub("_"," ") .. " #00B6FF(" .. getElementData(v, "playerid") .. ")#ffffff: Até agora passou: #7cc576" .. letelt .. " anos#ffffff, sairá em: #7cc576" .. hatravan .. " anos", thePlayer, 255, 255, 255, true)
					outputChatBox("   ", thePlayer, 200, 200, 200, true)
					count = count + 1
				end
		
				if getElementData(v, "jailed") == 1 then
					outputChatBox("============== Interrogatório de jogadores detidos =================", thePlayer, 200, 200, 200, true)
					outputChatBox("#7cc576" .. getPlayerName(v):gsub("_"," ") .. " #00B6FF(" .. getElementData(v, "playerid") .. ")#ffffff: levou-o em custódia: #7cc576" .. getElementData(v, "jailed:player") .. "#ffffff, Por #7cc576" .. getElementData(v, "jailed:ido") .. " anos", thePlayer, 255, 255, 255, true)
					outputChatBox("#7cc576" .. getPlayerName(v):gsub("_"," ") .. " #00B6FF(" .. getElementData(v, "playerid") .. ")#ffffff: Motivo: #7cc576" .. getElementData(v, "jailed:reason") .. "", thePlayer, 255, 255, 255, true)
					outputChatBox("#7cc576" .. getPlayerName(v):gsub("_"," ") .. " #00B6FF(" .. getElementData(v, "playerid") .. ")#ffffff: Até agora passou: #7cc576" .. getElementData(v, "jailed:idoLetelt") .. " anos#ffffff, sairá em: #7cc576" .. getElementData(v, "jailed:idoTelik") .. " anos", thePlayer, 255, 255, 255, true)
					outputChatBox("   ", thePlayer, 200, 200, 200, true)
					count2 = count2 + 1
				end
			end
			
			if count == 0 and count2 == 0 then
				outputChatBox(info .. "Ninguém está na prisão admin", thePlayer, 255, 255, 255, true)
			else
				outputChatBox("tudo #dc143c" .. count .. "#ffffff você tem jogadores na prisão admin e #dc143c" .. count2 .. "#ffffff jogador está sob custódia.", thePlayer, 255, 255, 255, true)
			end
			
		end
	end
end
addCommandHandler("presos", getJailedPlayers, false, false)

function bortonIdo(thePlayer, commandName)
	if getElementData(thePlayer, "adminjail") == 1 then
		
		local admin = getElementData(thePlayer, "adminjail:admin")
		local ido = getElementData(thePlayer, "adminjail:ido")
		local reason = getElementData(thePlayer, "adminjail:reason")
		local letelt = getElementData(thePlayer, "idoLetelt")
		local hatravan = getElementData(thePlayer, "idoTelik")
		
		outputChatBox("#dc143c[Preso - Informação]:#ffffff #7cc576" .. admin .. "#ffffff Prendeu você por #7cc576" .. ido .. " minutos#ffffff.", thePlayer, 255, 255, 255, true)
		outputChatBox("#dc143c[Preso - Informação]:#ffffff Motivo: #7cc576" .. reason, thePlayer, 255, 255, 255, true)
		outputChatBox("#dc143c[Preso - Informação]:#ffffff Você vai sair em: #7cc576" .. hatravan .. " minutos#ffffff e você está preso há: #7cc576" .. letelt .. " minutos", thePlayer, 255, 255, 255, true)
	else
		outputChatBox(error .. "Você não está preso!", thePlayer, 255, 255, 255, true)
	end
end
--addCommandHandler("tempo", bortonIdo, false, false)


addCommandHandler("a",
	function(player,_,...)
		if getElementData(player,"loggedin") then

			local value = getElementData(player,"char:adminduty")
			if value == 0 and not (tonumber(getElementData(player, "acc:admin") or 0) >= 7)    then outputChatBox("#7cc576Você não está no modo admin!!",player, 255, 194, 14, true) return end

			
		if tonumber(getElementData(player, "acc:admin") or 0) >= 1 then
			local message = table.concat({...}, " ")
			local szintpername = getPlayerAdminLevel(player)
			if ... and message then
			local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
					if tonumber(getElementData(v, "acc:admin") or 0) >= 1 then
						outputChatBox("#0008ff[CHAT STAFF]: #ffffff(".. szintpername .. "#ffffff)  #7cc576" .. getPlayerAdminName(player) .. ":#FFFFFF "..message,v,255,255,255,true)
					end
				end
			else
				outputChatBox("#7cc576Use: #ffffff/a [Mensagem]",player, 255, 194, 14, true)
			end
		end	
	end
	end
)

function player_Wasted ( ammo, attacker, weapon, bodypart )
	local nome =  getPlayerName(source)
	print(nome)
	if (attacker) then
		--exports.logs:logMessage("[LOG - MORTES] " .. getPlayerName(source) .. " (" .. getElementData(source, "playerid") .. ") Acabou de ser derrubado por "..getPlayerName(attacker):gsub("_"," ").." (" .. getElementData(attacker, "playerid")..")", 2)
		exports.bgo_discordlogs:sendDiscordMessage(5, false, "[LOG - MORTES] " .. nome .. " (" .. getElementData(source, "playerid") .. ") Acabou de ser derrubado por "..getPlayerName(attacker).." (" .. getElementData(attacker, "playerid")..")")
	
		else
		
		exports.bgo_discordlogs:sendDiscordMessage(5, false, " " .. nome .. " (" .. getElementData(source, "playerid") .. ") Morreu por causas desconhecida!")
	end
end
addEventHandler ( "onPlayerWasted", root, player_Wasted )





function playerDamage_text ( attacker, loss )
	 if not (getElementData(source, "attackerD")) then
	     setElementData(source, "attackerD", "(Desconhecido)")
	     return
	 end
	     if attacker then
             if (getElementData(source, "attackerD") == getElementData(attacker, "char:name")) then
		     else
		     setElementData(source, "attackerD", getElementData(attacker, "char:name"))
		 end
	end
end
--addEventHandler ( "onPlayerDamage", getRootElement (), playerDamage_text )


----------------------------------------------------------------------------------------------------------------------------------------
-- /setpp -- KÜLÖNRANGI PARANCS
----------------------------------------------------------------------------------------------------------------------------------------

function setPP(thePlayer, commandName, targetPlayer, status, pp)
	if getElementData(thePlayer, "acc:admin") >= 8 then
	
		local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end

		
		if not (targetPlayer) or not (status) or not (pp) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [1 = Setar | 2 = Juntar | 3 = Remover] [quantidade]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "Não existe esse jogador.", thePlayer, 255, 255, 255, true) return end

			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end


			local status = tonumber(status)
			local pp = tonumber(pp)
			if pp < 0 then outputChatBox(error .. "Precisa ser acima de 0.", thePlayer, 255, 255, 255, true) return end
			
				if not getElementData(targetPlayer, "loggedin") then return end
			
			if (status) > 3 or (status) < 1 then
				--outputChatBox(error .. "A végrehajtási kódok csak 1 és 3 között vannak", thePlayer, 255, 255, 255, true)
				return
			end
				
			local oldPP = getElementData(targetPlayer, "char:pp") or 0

			if (status) == 1 then
				local sql = dbExec(con, "UPDATE characters SET premiumpont='" .. pp .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					outputChatBox(info .. "Você configurou com sucesso o dinheiro vip do jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff para. (" .. pp ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. "#ffffff mudou o dinheiro vip do jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff para . #ff9000(" .. pp .. ")")


						exports.logs:logMessage("[SETAR DINHEIRO VIP] ".. getPlayerAdminName(thePlayer) .. "#ffffff setou o dinheiro vip do jogador " .. targetPlayerName:gsub("_"," ") .. " para (" .. pp .. ")", 7)



						setElementData(targetPlayer, "char:pp", pp)	
				end
			elseif (status) == 2 then
				local sql = dbExec(con, "UPDATE characters SET premiumpont='".. getElementData(targetPlayer, "char:pp") + pp .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					outputChatBox(info .. "Você mudou com sucesso o dinheiro vip do jogador: #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff de (" .. oldPP .. " para " .. oldPP + pp ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage(getPlayerAdminName(thePlayer) .. " mudou o dinheiro vip do jogador " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldPP .. " para " .. oldPP + pp .. ")")

					exports.logs:logMessage("[GIVE DINHEIRO VIP] ".. getPlayerAdminName(thePlayer) .. " acumulou o dinheiro vip do jogador " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldPP .. " para " .. oldPP + pp .. ")", 7)
					setElementData(targetPlayer, "char:pp", oldPP + pp)				
				end
			elseif (status) == 3 then
				local sql = dbExec(con, "UPDATE characters SET premiumpont='".. getElementData(targetPlayer, "char:pp") - pp .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					outputChatBox(info .. " Você mudou com sucesso o dinheiro vip do jogador #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff de (" .. oldPP .. " para " .. oldPP - pp ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage(getPlayerAdminName(thePlayer) .. " mudou o dinheiro vip do jogador " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldPP .. " para " .. oldPP - pp .. ")")
					exports.logs:logMessage("[RETIRAR DINHEIRO VIP] ".. getPlayerAdminName(thePlayer) .. " retirou o dinheiro vip do jogador " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldPP .. " para " .. oldPP - pp .. ")", 7)
					setElementData(targetPlayer, "char:pp", oldPP - pp)				
				end
			end
		end
	end
end
addCommandHandler("setpp", setPP, false, false)






----------------------------------------------------------------------------------------------------------------------------------------
-- /setmoney -- EGYÉB PARANCSOK
----------------------------------------------------------------------------------------------------------------------------------------


function setMoney(thePlayer, commandName, targetPlayer, status, cash)
	if getElementData(thePlayer, "acc:admin") >= 10 then
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


		if not (targetPlayer) or not (status) or not (cash) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [1 = Setar | 2 = Acumular | 3 = Retirar ] [Quantidade]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "NÃO EXISTE TAL JOGADOR.", thePlayer, 255, 255, 255, true) return end

			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end


			local status = tonumber(status)
			local cash = tonumber(cash)
			if cash < 0 then outputChatBox(error .. "O valor deve estar acima de 0.", thePlayer, 255, 255, 255, true) return end
			
			if not getElementData(targetPlayer, "loggedin") then return end
			
			if (status) > 3 or (status) < 1 then
				outputChatBox(error .. "Os códigos de execução são apenas entre 1 e 3", thePlayer, 255, 255, 255, true)
				return
			end
				
			local oldCash = getElementData(targetPlayer, "char:money") or 0
			
			if (status) == 1 then
				local sql = dbExec(con, "UPDATE characters SET money='" .. cash .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					outputChatBox(info .. "Você setou com sucesso o dinheiro de #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff para. (" .. cash ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. "#ffffff setou com sucesso o dinheiro de " .. targetPlayerName:gsub("_"," ") .. " para (" .. cash .. ")")
					setElementData(targetPlayer, "char:money", cash)	

					exports.logs:logMessage("[SETAR DINHEIRO] ".. getPlayerAdminName(thePlayer) .. " setou com sucesso o dinheiro de " .. targetPlayerName:gsub("_"," ") .. " para (" .. cash .. ")", 7)


				end
			elseif (status) == 2 then
				local sql = dbExec(con, "UPDATE characters SET money='".. getElementData(targetPlayer, "char:money") + cash .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					outputChatBox(info .. "Você mudou com sucesso o dinheiro de #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff de (" .. oldCash .. " para " .. oldCash + cash ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. " mudou o dinheiro do " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldCash .. " para " .. oldCash + cash ..")")

					exports.logs:logMessage("GIVE DINHEIRO] ".. getPlayerAdminName(thePlayer) .. " mudou o dinheiro do " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldCash .. " para " .. oldCash + cash ..")", 7)

					setElementData(targetPlayer, "char:money", oldCash + cash)				
				end
			elseif (status) == 3 then
				local sql = dbExec(con, "UPDATE characters SET money='".. getElementData(targetPlayer, "char:money") - cash .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				if (sql) then
					outputChatBox(info .. "Você retirou com sucesso o dinheiro de #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff de . (" .. oldCash .. " para " .. oldCash - cash ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. "#ffffff retirou com sucesso o dinheiro de " .. targetPlayerName:gsub("_"," ") .. " de. (" .. oldCash .. " para " .. oldCash - cash .. ")")
					setElementData(targetPlayer, "char:money", oldCash - cash)	
					
					
					exports.logs:logMessage("[SETAR DINHEIRO] ".. getPlayerAdminName(thePlayer) .. " retirou com sucesso o dinheiro de " .. targetPlayerName:gsub("_"," ") .. " de. (" .. oldCash .. " para " .. oldCash - cash .. ")", 7)



				end
			end
		end
	end
end
addCommandHandler("money", setMoney, false, false)



function setbanco(thePlayer, commandName, targetPlayer, status, cash)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 10 then
		
		if not (targetPlayer) or not (status) or not (cash) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Nome / ID] [1 = Setar | 2 = Acumular | 3 = Retirar ] [Quantidade]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "NÃO EXISTE TAL JOGADOR.", thePlayer, 255, 255, 255, true) return end

			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end


			local status = tonumber(status)
			local cash = tonumber(cash)
			if cash < 0 then outputChatBox(error .. "O valor deve estar acima de 0.", thePlayer, 255, 255, 255, true) return end
			
			if not getElementData(targetPlayer, "loggedin") then return end
			
			if (status) > 3 or (status) < 1 then
				outputChatBox(error .. "Os códigos de execução são apenas entre 1 e 3", thePlayer, 255, 255, 255, true)
				return
			end
				
			local oldCash = getElementData(targetPlayer, "char:bankmoney") or 0
			
			if (status) == 1 then
					outputChatBox(info .. "Você setou com sucesso o dinheiro do banco de #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff para. (" .. cash ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. "#ffffff setou com sucesso o dinheiro do banco de " .. targetPlayerName:gsub("_"," ") .. " para (" .. cash .. ")")
					setElementData(targetPlayer, "char:bankmoney", cash)	
					exports.logs:logMessage("[SETAR DINHEIRO] ".. getPlayerAdminName(thePlayer) .. " setou com sucesso o dinheiro do banco de " .. targetPlayerName:gsub("_"," ") .. " para (" .. cash .. ")", 7)
			elseif (status) == 2 then
					outputChatBox(info .. "Você mudou com sucesso o dinheiro do banco de #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff de (" .. oldCash .. " para " .. oldCash + cash ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. " mudou o dinheiro do banco do " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldCash .. " para " .. oldCash + cash ..")")
					exports.logs:logMessage("GIVE DINHEIRO] ".. getPlayerAdminName(thePlayer) .. " mudou o dinheiro do banco do " .. targetPlayerName:gsub("_"," ") .. " de (" .. oldCash .. " para " .. oldCash + cash ..")", 7)
					setElementData(targetPlayer, "char:bankmoney", oldCash + cash)				
			elseif (status) == 3 then
					outputChatBox(info .. "Você retirou com sucesso o dinheiro do banco de #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff de . (" .. oldCash .. " para " .. oldCash - cash ..")", thePlayer, 255, 255, 255, true)
					--outputDeveloperMessage("#7cc576".. getPlayerAdminName(thePlayer) .. "#ffffff retirou com sucesso o dinheiro do banco de " .. targetPlayerName:gsub("_"," ") .. " de. (" .. oldCash .. " para " .. oldCash - cash .. ")")
					setElementData(targetPlayer, "char:bankmoney", oldCash - cash)	
					exports.logs:logMessage("[SETAR DINHEIRO] ".. getPlayerAdminName(thePlayer) .. " retirou com sucesso o dinheiro do banco de " .. targetPlayerName:gsub("_"," ") .. " de. (" .. oldCash .. " para " .. oldCash - cash .. ")", 7)
			end
		end
	end
end
addCommandHandler("banco", setbanco, false, false)



function rtcPlayer(thePlayer, commandName)
	if getElementData(thePlayer, "acc:admin") >=9 then
	
	local px, py, pz = getElementPosition(thePlayer)
	
	local v = nil
		for i = 1, #getElementsByType("player")do
			v = getElementsByType("player")[i]
			vx, vy, vz = getElementPosition(v)
			local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
			if dist <= 3 then
			if v ~= thePlayer then
			setElementDimension(v , 9999)
			setElementInterior(v , 6)
			end
		end
	end
	outputChatBox("#D64541TESTE MENSAGEM", thePlayer, 255, 255, 255, true)
	end
end
--addCommandHandler("setpd", rtcPlayer, false, false)


function onStart()
if not getElementData(source, "loggedin") then
setElementDimension(source, math.random(1111,9999))
end
end
addEventHandler ( "onPlayerJoin", getRootElement(), onStart)



function rtcVehicle(thePlayer, commandName)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
	if getElementData(thePlayer, "acc:admin") >=2 then
	local px, py, pz = getElementPosition(thePlayer)		
		local x,y,z = getElementPosition(thePlayer)
		local tabela = getElementsWithinRange( x, y, z, 3, "vehicle" )
		local v = nil
		for i = 1, #tabela do
        v = tabela[i] 
		local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
		local tint, tdim = getElementInterior(v), getElementDimension(v)
		if int == tint and dim == tdim then
			local dim = math.random(1111,9999)
			setElementDimension(v , dim)
			end
		end
	end
end
addCommandHandler("rtc", rtcVehicle, false, false)


function rtcVehicle2(thePlayer, commandName)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end



	if getElementData(thePlayer, "acc:admin") >=2 then
	
	local px, py, pz = getElementPosition(thePlayer)
	--[[
	for k, v in ipairs(getElementsByType("vehicle")) do 
		vx, vy, vz = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if dist <= 5 then
		]]--
		
		local x,y,z = getElementPosition(thePlayer)
		local tabela = getElementsWithinRange( x, y, z, 5, "vehicle" )
		local v = nil
		for i = 1, #tabela do
         v = tabela[i] 
		 
		 
		
			local vehicleQ = dbQuery(con,"SELECT * FROM vehicle WHERE id='" .. getElementData(v, "veh:id") .. "'")
			local vehicleH,vehszam = dbPoll(vehicleQ,-1)
			if vehicleH then
				for k1,v1 in ipairs(vehicleH) do
					setElementDimension(v, 2)
					local x, y, z =  -2319.1916503906, -1637.2742919922, 483.703125
					setElementPosition(v, x, y, z)
					setVehicleRespawnPosition(v, x, y, z, 0, 0, 0)
					dbExec(con, "UPDATE vehicle SET interior='0', dimension='2', pos='" .. toJSON({x, y, z, 0, 2, 0}) .. "' WHERE id='" .. getElementData(v, "veh:id") .. "'")
					
					--adminlog
					for k3, v3 in ipairs(getElementsByType("player")) do
						if tonumber(getElementData(v3, "acc:admin") or 0) >= 1 and getElementData(v3, "loggedin") then
							if getPlayerName(thePlayer) == getPlayerName(v3) then
							else
								--outputChatBox("#D64541[RTC2]#ffffff #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff áthelyezte a(z) ID: " .. getElementData(v, "veh:id") .. " járművet.", v3, 255, 255, 255, true)
							end
						end
					end
					
				end
			end
		end
	end
	end
--end
addCommandHandler("rtc2", rtcVehicle2, false, false)

function delJobVehicles(thePlayer)
	if getElementData(thePlayer, "acc:admin") < 6 then return end

	for key, value in ipairs(getElementsByType("vehicle")) do
		local px, py, pz = getElementPosition(thePlayer)
		local px2, py2, pz2 = getElementPosition(value)
		if getDistanceBetweenPoints3D(px, py, pz, px2, py2, pz2) <= 5 then
			if getElementData(value, "veh:id") or 0 < 0 then
				setElementDimension(value, 2)
			end
		end
	end
end
--addCommandHandler("deljobvehs", delJobVehicles, false, false)

function fly(thePlayer, commandName)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


 	if (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 1 ) then
		triggerClientEvent(thePlayer, "onClientFlyToggle", thePlayer)
	end
end
addCommandHandler("fly", fly, false, false)


function teleportarFLY2(player, x,y,z)
	if isElement(player) then
setElementFrozen(player, true)
	end
end
addEvent("teleportarFLY", true)
addEventHandler("teleportarFLY", getRootElement(), teleportarFLY2)

function getPlayerLevel(player, cmd, target)
 	if (tonumber(getElementData(player, "acc:admin") or 0) >= 1 ) then
	if not target then
		outputChatBox("#7cc576Use: #ffffff/"..cmd.." [Nome / ID]", player, 0, 0, 0, true)
		return
	end
	local target, targetName = exports["bgo_core"]:findPlayer(player, target)
	if not target then
		outputChatBox(error.."Não existe tal jogador ou logado.", player, 0, 0, 0, true)
		return
	else
	local lvl = getElementData( target, "Sys:Level" ) or 0
	local exp = getElementData( target, "LSys:EXP" ) or 0
	outputChatBox("Jogador: "..targetName:gsub("_", " ").."", player, 255,255,255, true)
	outputChatBox("Level: #7cc576"..lvl, player, 255,255,255, true)
	outputChatBox("Experiência: #7cc576"..exp, player, 255,255,255, true)
	end
	end
end
addCommandHandler("lvl", getPlayerLevel)

function getPlayerOldcarID(player)
	if not getElementData(player, "oldcarID") then
		outputChatBox(error.."Még nem ültél járműben.", player, 0, 0, 0, true)
	else
		outputChatBox(info.."Utolsó kocsi ID-je: #7cc576"..getElementData(player, "oldcarID"), player, 0, 0, 0, true)
	end
end
--addCommandHandler("oldcar", getPlayerOldcarID)

function getPlayerID(player, cmd, target)
	if not target then
		outputChatBox("#7cc576Use: #ffffff/"..cmd.." [Nome / ID]", player, 0, 0, 0, true)
		return
	end
	
	local target, targetName = exports["bgo_core"]:findPlayer(player, target)
	if not target then
		return
	else
		if getElementData(target, "acc:id") == 1 or getElementData(target, "acc:id") == 2 then return end
		outputChatBox(info..targetName:gsub("_", " ").. " ID: #7cc576"..tonumber(getElementData(target, "playerid") or 0), player, 0, 0, 0, true)
	end
end
addCommandHandler("id", getPlayerID)


function getPlayerStats(thePlayer, commandName, targetPlayer)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 3 then
		
		if targetPlayer then
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)

			--if getElementData(targetPlayer, "acc:id") == 1 then outputChatBox("#ff0000Jogador esta offline por tempo indeterminado",thePlayer, 255, 194, 14, true) return end

			
			if not (targetPlayer) then
				outputChatBox("#dc143c[BGO MTA]:#ffffff Não existe tal jogador.", thePlayer, 255, 255, 255, true)
				return
			end
			showingPlayer = targetPlayer
		else
			showingPlayer = thePlayer
		end

		
				local v = nil
				for i = 1, #getElementsByType("player")do
				v = getElementsByType("player")[i]
	if isElement(v) and getElementData(v, "loggedin") and abinis2[getPlayerSerial(v)] then --and tonumber(getElementData(v,"acc:admin") or 0) == 10 then
	outputChatBox("#7cc576[BGO MTA - LOG]:#ffffff "..getPlayerName(thePlayer).." Usou o comando /stats no jogador "..getPlayerName(showingPlayer).." ",v,255,255,255,true)
end
end
		triggerClientEvent(thePlayer, "onStatsCreate", thePlayer, showingPlayer)
	end
end
addCommandHandler("stats", getPlayerStats, false, false)

function giveLicenses(thePlayer, commandName, targetPlayer, licensz)
	if getElementData(thePlayer, "acc:admin") >= 5 then
		
		if not (targetPlayer) or not (licensz) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Név / ID] [1 = Jogosítvány | 2 = Fegyvertartási engedély]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "Nincs ilyen játékos.", thePlayer, 255, 255, 255, true) return end
			local licensz = tonumber(licensz)
				if not getElementData(targetPlayer, "loggedin") then return end
			
			if licensz > 2 or licensz <= 0 then
				outputChatBox(error .. "A licensz csak 1 és 2 lehet.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if (licensz) == 1 then
				setElementData(targetPlayer, "char:drivingLicense", 1)
				 license = toJSON({1,getElementData(targetPlayer, "char:fegyverengedely")})
				 sql = dbExec(con, "UPDATE characters SET License='".. license .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				
				if (sql) then
					outputChatBox(info .. "Sikeresen adtál jogosítványt #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff játékosnak.", thePlayer, 255, 255, 255, true)
					outputChatBox(info .. "#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff adott neked jogosítványt.", targetPlayer, 255, 255, 255, true)
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff adott " .. targetPlayerName:gsub("_"," ") .. " játékosnak jogosítványt.")
				else
					outputChatBox(error .. "Nem sikerült jogosítványt adni a játékosnak. Hibakód: GIVELICENSES1", thePlayer, 255, 255, 255, true)
				end
			elseif (licensz) == 2 then
				if getElementData(thePlayer, "acc:admin") >= 6 then
					
					setElementData(targetPlayer, "char:fegyverengedely", 1)
					license = toJSON({getElementData(targetPlayer, "char:drivingLicense"),1})
					sql = dbExec(con, "UPDATE characters SET License='".. license .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
					
					if (sql) then
						outputChatBox(info .. "Sikeresen adtál fegyvertartási engedélyt #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff játékosnak.", thePlayer, 255, 255, 255, true)
						outputChatBox(info .. "#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff adott neked fegyvertartási engedélyt.", targetPlayer, 255, 255, 255, true)
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff adott " .. targetPlayerName:gsub("_"," ") .. " játékosnak fegyvertartási engedélyt.")
					else
						outputChatBox(error .. "Nem sikerült fegyvertartási engedélyt adni a játékosnak. Hibakód: GIVELICENSES2", thePlayer, 255, 255, 255, true)
					end
				end
			end
		end
	end
end
--addCommandHandler("givelicenses", giveLicenses, false, false)

function showLicenses(thePlayer, commandName, targetPlayer)
	if getElementData(thePlayer, "loggedin") then
		
		if not (targetPlayer) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Név / ID] ", thePlayer, 255, 255, 255, true)
		else
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			
			if (targetPlayer) then
				
				local x, y, z = getElementPosition(thePlayer)
				local x1, y1, z1 = getElementPosition(targetPlayer)
				
				local dist = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1 )
				
				if (dist<10) then
				
					sendLocalMeAction(thePlayer, "felmutatja az engedélyeit " .. targetPlayerName:gsub("_"," ") .. "-nak/nek.")
					outputChatBox("-------------------------------------------------------------------------", targetPlayer, 150, 150, 150, true)
					outputChatBox("#0094ff" .. getPlayerName(thePlayer) .. "#ffffff játékos engedélyei:", targetPlayer, 255, 255, 255, true)
					
					local jogsi = getElementData(thePlayer, "char:drivingLicense")
					local fegyver = getElementData(thePlayer, "char:fegyverengedely")
						if jogsi == 1 then
							p = "#7cc576Van"
						else
							p = "#dc143cNincs"
						end
				
						if fegyver == 1 then
							r = "#7cc576Van"
						else
							r = "#dc143cNincs"
						end
					outputChatBox("#ffffffJárművezetői engedély: " .. p, targetPlayer, 255, 255, 255, true)
					outputChatBox("#ffffffFegyvertartási engedély: " .. r, targetPlayer, 255, 255, 255, true)
					outputChatBox("-------------------------------------------------------------------------", targetPlayer, 150, 150, 150, true)
				else
					outputChatBox(error .. "Você está muito longe do jogador.", thePlayer, 255, 255, 255, true)				
				end
			else
				outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
--addCommandHandler("showlicenses", showLicenses, false, false)

function takeLicenses(thePlayer, commandName, targetPlayer, licensz)
	if getElementData(thePlayer, "acc:admin") >= 6 then
		
		if not (targetPlayer) or not (licensz) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Név / ID] [1 = Jogosítvány | 2 = Fegyvertartási engedély]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			if not (targetPlayer) then outputChatBox(error .. "Nincs ilyen játékos.", thePlayer, 255, 255, 255, true) return end
			local licensz = tonumber(licensz)
			
				if not getElementData(targetPlayer, "loggedin") then return end
			
			if licensz > 2 or licensz <= 0 then
				outputChatBox(error .. "A licensz csak 1 és 2 lehet.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if (licensz) == 1 then
				setElementData(targetPlayer, "char:drivingLicense", 0)
				local license = toJSON({0,0})
				local sql = dbExec(con, "UPDATE characters SET License='".. license .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
				
				if (sql) then
					outputChatBox(info .. "Sikeresen elvetted a jogosítványt #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff játékostól.", thePlayer, 255, 255, 255, true)
					outputChatBox(info .. "#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff elvette a jogosítványodat.", targetPlayer, 255, 255, 255, true)
					outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff elvette " .. targetPlayerName:gsub("_"," ") .. " játékosnak a jogosítványát.")
				else
					outputChatBox(error .. "Nem sikerült jogosítványt elvenni a játékostól. Hibakód: TAKELICENSES1", thePlayer, 255, 255, 255, true)
				end
			elseif (licensz) == 2 then
				if getElementData(thePlayer, "acc:admin") >= 6 then
					setElementData(targetPlayer, "char:fegyverengedely", 0)
					license = toJSON({getElementData(targetPlayer, "char:drivingLicense"),0})
					sql = dbExec(con, "UPDATE characters SET License='".. license .. "' WHERE id='" .. getElementData(targetPlayer, "char:id") .. "'")
					
					if (sql) then
						outputChatBox(info .. "Sikeresen elvetted a fegyvertartási engedélyt #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff játékostól.", thePlayer, 255, 255, 255, true)
						outputChatBox(info .. "#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff elvette a fegyvertartási engedélyedet.", targetPlayer, 255, 255, 255, true)
						outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff elvette " .. targetPlayerName:gsub("_"," ") .. " játékosnak a fegyvertartási engedélyét.")
					else
						outputChatBox(error .. "Nem sikerült jogosítványt elvenni a játékostól. Hibakód: TAKELICENSES2", thePlayer, 255, 255, 255, true)
					end
				end
			end
		end
	end
end
--addCommandHandler("takelicenses", takeLicenses, false, false)

function vhSpawn(thePlayer, commandName, targetPlayer)
	if getElementData(thePlayer, "acc:admin") >= 1 then
		
		if not (targetPlayer) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Név / ID]", thePlayer, 255, 255, 255, true)
		else
				
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local x, y, z =  1204.0526123047, -1755.3236083984, 13.306406021118
			local int = 0
			local dim = 0
			
				if not getElementData(targetPlayer, "loggedin") then return end
			
			if isPedInVehicle(targetPlayer) then
				removePedFromVehicle(targetPlayer)
			end
			
			if not (targetPlayer) then
				outputChatBox(error .. "Não existe tal jogador.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if getElementData(targetPlayer, "adminjail") == 1 and not getElementData(thePlayer, "acc:admin") >= 6 then	outputChatBox("#dc143c[Hiba]:#ffffff Nincs jogosultságod a játékost a városházára teleportálni. (Jailben van.)", targetPlayer, 255, 255, 255, true) return end 
			
			local teleport = setElementPosition(targetPlayer, x, y, z), setElementInterior(targetPlayer, int), setElementDimension(targetPlayer, dim)
			
			if (teleport) then
				outputChatBox("#ffffffVocê conseguiu deportar #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff játékost a városházára.", thePlayer, 255, 255, 255, true)
				outputChatBox(" #7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff elteleportált téged a #0094ffvárosházára#ffffff.", targetPlayer, 255, 255, 255, true)
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff elteleportálta " .. targetPlayerName:gsub("_"," ") .. " játékost a városházára.")
			else
				outputChatBox(error .. "Não conseguiu repatriar a prefeitura. O código de erro: VHSPAWN1", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
--addCommandHandler("vhspawn", vhSpawn, false, false)

addEvent( "gotoMark", true )
addEventHandler( "gotoMark", getRootElement( ),
	function( x, y, z, interior, dimension, name )
		if type( x ) == "number" and type( y ) == "number" and type( z ) == "number" and type( interior ) == "number" and type( dimension ) == "number" then
			if getElementData ( client, "loggedin" ) and getElementData(client, "acc:admin") >= 1 then				
				setTimer(function(client)
					local vehicle = nil
					local seat = nil
					if(isPedInVehicle ( client )) then
						 vehicle =  getPedOccupiedVehicle ( client )
						seat = getPedOccupiedVehicleSeat ( client )
					end
					if(vehicle and (seat ~= 0)) then
						removePedFromVehicle (client )
						setElementPosition(client, x, y, z)
						setElementInterior(client, interior)
						setElementDimension(client, dimension)
					elseif(vehicle and seat == 0) then
						removePedFromVehicle (client )
						
						setElementPosition(vehicle, x, y, z)
						setElementInterior(vehicle, interior)
						setElementDimension(vehicle, dimension)
						warpPedIntoVehicle ( client, vehicle, 0)
					else
						setElementPosition(client, x, y, z)
						setElementInterior(client, interior)
						setElementDimension(client, dimension)
					end
					name = name or ""
					outputChatBox( "#7cc576[BGO MTA - Teleport]:#ffffff Você foi teleportado com sucesso para #0094ff".. name .. "#ffffff a cena.", client, 0, 255, 0, true )
				end, 50, 1, client)
			end
		end
	end
)

function sendLocalText(root, message, r, g, b, distance, exclude)
	exclude = exclude or {}
	local x, y, z = getElementPosition(root)
	local shownto = 0
	--for index, nearbyPlayer in ipairs(getElementsByType("player")) do
	
				local nearbyPlayer = nil
				for i = 1, #getElementsByType("player")do
				nearbyPlayer = getElementsByType("player")[i]
				
				
		if isElement(nearbyPlayer) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyPlayer)) < ( distance or 20 ) then
			local logged = getElementData(nearbyPlayer, "loggedin")
			if not exclude[nearbyPlayer] and not isPedDead(nearbyPlayer) and logged and getElementDimension(root) == getElementDimension(nearbyPlayer) then
				outputChatBox(message, nearbyPlayer, r, g, b,true)
				shownto = shownto + 1
			end
		end
	end
end

function sendLocalMeAction(thePlayer, message)
	sendLocalText(thePlayer, " ***" .. getPlayerName(thePlayer):gsub("_", " ") .. ( message:sub( 1, 1 ) == "'" and "" or " " ) .. message, 194, 162, 218)
	triggerClientEvent("onMessageIncome",thePlayer,"***"..message,2)
end

function saveSqlFegyver(player, status)
	if isElement(player) then
		local jogsi = getElementData(player, "char:drivingLicense")
		local save = toJSON({jogsi, 1})
		local sql = dbExec(con, "UPDATE characters SET License = ? WHERE id='" .. getElementData(player, "char:id") .. "'", save)
		if (sql) then
		end
	end
end
addEvent("fegyverengMentes", true)
addEventHandler("fegyverengMentes", getRootElement(), saveSqlFegyver)

function thisCar(thePlayer)
	if getElementData(thePlayer, "loggedin") then
		local veh = getPedOccupiedVehicle(thePlayer)
		if isPedInVehicle(thePlayer) then
			if (veh) then
			outputChatBox(info .. "ID do veículo: #7cc576" .. getElementData(veh, "veh:id") or "Desconhecido" .. "", thePlayer, 255, 255, 255, true)
			end
		else
			outputChatBox(error .. "Você não está em um carro.", thePlayer, 255, 255, 255, true)
		end
	end
end
--addCommandHandler("thiscar", thisCar, false, false)


function gluePlayer(slot, vehicle, x, y, z, rotX, rotY, rotZ)
	attachElements(source, vehicle, x, y, z, rotX, rotY, rotZ)
	if not exports.bone_attach:isElementAttachedToBone(vehicle) then
		exports.bone_attach:attachElementToBone (source, vehicle, 3, x, y, z, rotX, rotY, rotZ)
	end
	outputChatBox(info .. "Você aderiu a #7cc576ID: " .. getElementData(vehicle, "veh:id") .. "#ffffff veículos.", source, 255, 255, 255, true)
end
addEvent("gluePlayer",true)
addEventHandler("gluePlayer",getRootElement(),gluePlayer)

function ungluePlayer(vehicle)
	detachElements(source)
	exports.bone_attach:detachElementFromBone(source)
	outputChatBox(info .. "Você se desconectou #7cc576ID: Desconhecido#ffffff veículo.", source, 255, 255, 255, true)
end
addEvent("ungluePlayer",true)
addEventHandler("ungluePlayer",getRootElement(),ungluePlayer)


addCommandHandler("setpassword2", function(thePlayer, _, ...)
	if getElementData(thePlayer, "acc:admin") >= 8 then
		local text = table.concat({...}, " ")
		setServerPassword(text)
	end
end)

function setServerMaxPlayers(thePlayer, commandName, newSlot)
	if getElementData(thePlayer, "acc:admin") >= 8 then
		if newSlot then
			setMaxPlayers(newSlot)
			outputAdminMessage("Conjunto de limite de jogadores do servidor " .. newSlot .. "")
		else
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Slot]", thePlayer, 255, 255, 255, true)
		end
	end
end
addCommandHandler("setslot", setServerMaxPlayers)


function setPlateText(thePlayer, commandName, vehicleID, ...)
	if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 8 then
		if not (vehicleID) or not (...) then
			outputChatBox("#7cc576Use:#ffffff /" .. commandName .. " [Jármű ID] [Rendszám]", thePlayer ,255, 255, 255, true)
		else
	
			local vehicleID = tonumber(vehicleID)
			--for k, v in ipairs(getElementsByType("vehicle")) do 
				local v = nil
				for i = 1, #getElementsByType("vehicle")do
				v = getElementsByType("vehicle")[i]
				
				if getElementData(v, "veh:id") == vehicleID then
					veh = v
				end
			end
			if not veh then outputChatBox(error .. "Nincs találat a járműre.", thePlayer, 255, 255, 255, true) return end
			if veh then
				local msg = table.concat({...}, " ")
				if string.len(msg) > 8 then outputChatBox(error .. "A rendszám maximum 8 karakter lehet.", thePlayer, 255, 255, 255, true) return end
				
				local query = dbQuery(con, "SELECT * FROM vehicle WHERE rendszam='" .. msg .. "'")
				local results = dbPoll(query, -1)
				if #results > 0 then outputChatBox(error .. "Már van ilyen rendszámú jármű.", thePlayer, 255, 255, 255, true) return end
				
				setVehiclePlateText(veh, msg)
				dbExec(con, "UPDATE vehicle SET rendszam='" .. msg .. "' WHERE id='" .. getElementData(veh, "veh:id") .. "'")
				outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff megváltoztatta az ID: #0094ff" .. vehicleID .. "#ffffff jármű rendszámát. (" .. msg .. ")")
			end
			end
	end
end
--addCommandHandler("setplate", setPlateText, false, false)




--/setdrink
function setPlayerDrinkLevel(thePlayer, commandName, targetPlayer, level)
	local value = getElementData(thePlayer,"char:adminduty")
	if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)   then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end


	if getElementData(thePlayer, "acc:admin") >= 1 then

		if not (targetPlayer) or not (level) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Név / ID] [Szomjúság]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local level = tonumber(level)
			if not (targetPlayer) then outputChatBox(error .. "Nincs ilyen játékos.", thePlayer, 255, 255, 255, true) return end			
			
			
			if (level) > 100 then
				--outputChatBox(error .. "Az értékek 0 és 100 között vannak.", thePlayer, 255, 255, 255, true)
				return false
			end
			
			local setDrink = setElementData(targetPlayer, "char:drink", level)
			
			if (setDrink) then
				--outputChatBox(info .. "Sikeresen megváltoztattad #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff Szomjúságát. (" .. level .. ")", thePlayer, 255, 255, 255, true)
				--outputAdminMessage("#7cc576" .. getPlayerAdminName(thePlayer) .. "#ffffff megváltoztatta #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff szomjúságát. (" .. level .. ")")
			else
				--outputChatBox(error .. "Nem sikerült megváltoztatni " .. targetPlayerName:gsub("_"," ") .. " szomjúságát.", thePlayer, 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("setdrink", setPlayerDrinkLevel, false, false)

--- IC JAIL 


function adminJail(thePlayer, commandName, targetPlayer, ido, ...)
--	if getElementData(thePlayer, "acc:admin") >= 1 then
	
		if not (targetPlayer) or not (ido) or not (...) then
			outputChatBox("#7cc576Use: #ffffff/" .. commandName .. " [Név / ID] [Perc] [Indok]", thePlayer, 255, 255, 255, true)
		else
			
			local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, targetPlayer)
			local ido = tonumber(ido)
			local reason = table.concat({...}, " ")
			
				if not (targetPlayer) then outputChatBox(error .. "Nincs ilyen játékos.", thePlayer, 255, 255, 255, true) return end
				if not getElementData(targetPlayer, "loggedin") then return end
			
			if (ido) <= 0 then
				outputChatBox(error .. "A percek 0 alatt nem adhatóak vannak.", thePlayer ,255, 255, 255, true)
				return
			elseif (ido) > 120 and getElementData(thePlayer, "acc:admin") < 2 then
				outputChatBox(error .. "Nincs jogosultságod 120 percet meghaladó adminjailt osztani.", thePlayer, 255, 255, 255, true)
				return
			elseif (ido) > 300 and getElementData(thePlayer, "acc:admin") < 3 then
				outputChatBox(error .. "Nincs jogosultságod 300 percet meghaladó adminjailt osztani.", thePlayer, 255, 255, 255, true)
				return
			elseif (ido) > 400 and getElementData(thePlayer, "acc:admin") < 4 then
				outputChatBox(error .. "Nincs jogosultságod 400 percet meghaladó adminjailt osztani.", thePlayer, 255, 255, 255, true)
				return
			elseif (ido) > 500 and getElementData(thePlayer, "acc:admin") < 5 then
				outputChatBox(error .. "Nincs jogosultságod 500 percet meghaladó adminjailt osztani.", thePlayer, 255, 255, 255, true)
				return			
			elseif (ido) > 600 and getElementData(thePlayer, "acc:admin") < 6 then
				outputChatBox(error .. "Nincs jogosultságod 600 percet meghaladó adminjailt osztani.", thePlayer, 255, 255, 255, true)
				return
			end
			
			if not (targetPlayer) then
				return
			end
			
			--közbe
				if getElementData(targetPlayer, "adminjail") == 1 then
					outputChatBox(error .. "A játékos már adminjailben van.", thePlayer, 255, 255, 255, true)
					outputChatBox("Ha frissíteni szeretnéd a büntetést, először vedd ki a #7cc576/unjail#ffffff paranccsal, majd próbálkozz újra.", thePlayer, 255, 255, 255, true)
					return
				end
			
				outputChatBox("#dc143c[IC - JAIL]:#7cc576 " .. getPlayerAdminName(thePlayer) .. "#ffffff bebörtönözte #7cc576" .. targetPlayerName:gsub("_"," ") .. "#ffffff játékost #1a75ff" .. ido .. "#ffffff percre.", root ,255, 255, 255, true)
				outputChatBox("#dc143c[IC - JAIL]:#7cc576 Indok:#ffffff " .. reason, root ,255, 255, 255, true)
				--outputChatBox("#ffffffA hátralévő bünetetésed lekérdezéséhez használd a #7cc576/börtönidő#ffffff parancsot.", targetPlayer, 255, 255, 255, true)

				local theTimerCheck = getElementData(targetPlayer, "adminjail:theTimer")
				local theTimerCheck2 = getElementData(targetPlayer, "adminjail:theTimerAccounts")
				
				if isTimer(theTimerCheck) then
					killTimer(theTimerCheck)
				end
				
				if isTimer(theTimerCheck2) then
					killTimer(theTimerCheck2)
				end
				
				if isPedInVehicle(targetPlayer) then
					removePedFromVehicle(targetPlayer)
				end
				
				fadeCamera(targetPlayer, false, 1.0)
				showChat(targetPlayer, false)
				setElementFrozen(targetPlayer, true)
				if isPedInVehicle(targetPlayer) then
					toggleAllControls(targetPlayer, false, false, false)
				end
				
				setTimer(function()
					triggerClientEvent(targetPlayer, "triggerAdminjail", targetPlayer, thePlayer, reason, ido, 1, false)
				end, 500, 1)
				
				setTimer( function()
					local idoTelik = setTimer(idoTelikLe, 60000, ido, targetPlayer)
					local theTimer = setElementData(targetPlayer, "adminjail:theTimer", idoTelik)
					local idoTelikMentes = setElementData(targetPlayer, "idoTelik", ido)
					local idoLetelt = setElementData(targetPlayer, "idoLetelt", 0)
					local setPosition = setElementPosition(targetPlayer, 198.0009765625, 175.1279296875, 1003.0234375)
					local setInterior = setElementInterior(targetPlayer, 3)
					local setDimension = setElementDimension(targetPlayer, 132+getElementData(targetPlayer, "acc:id"))
					
					local adminjailed = setElementData(targetPlayer, "adminjail", 1)
					local adminjail_reason = setElementData(targetPlayer, "adminjail:reason", reason)
					local alapido = setElementData(targetPlayer, "adminjail:ido", ido)
					local admin = setElementData(targetPlayer, "adminjail:admin", getPlayerAdminName(thePlayer))
					local adminSerial = setElementData(targetPlayer, "adminjail:adminSerial", getPlayerSerial(thePlayer))
				end, 1500, 1)
								
				setTimer(function()
					fadeCamera(targetPlayer, true, 2.5)
					setElementFrozen(targetPlayer, false)
					toggleAllControls(targetPlayer, true, true, true)
					showChat(targetPlayer, true)
				end, 7500, 1)
			
				local sql = dbExec(con, "UPDATE characters SET adminjail = ?, adminjail_reason = ?, adminjail_idoTelik = ?, adminjail_alapIdo = ?, adminjail_admin = ?, adminjail_adminSerial = ? WHERE id = '" .. getElementData(targetPlayer, "char:id") .. "'", 1, reason, ido, ido, getPlayerAdminName(thePlayer), getPlayerSerial(thePlayer))
				local ajailMentes = dbExec(con, "INSERT INTO adminjails SET jailed_player = ?, jailed_playerSerial = ?, jailed_accountID = ?, jailed_admin = ?, jailed_adminSerial = ?, jailed_reason = ?, jailed_ido = ?, jailed_idopont=CURDATE(), jailed_idopontora=CURTIME()", targetPlayerName:gsub("_"," "), getPlayerSerial(targetPlayer), getElementData(targetPlayer, "acc:id"),getPlayerAdminName(thePlayer), getPlayerSerial(thePlayer), reason, ido)
		end
	end
--addCommandHandler("jatekosborton", adminJail, false, false)



		 
			  
			
function shutdownServer(player,cmd,time,...)
		local accName = getAccountName(getPlayerAccount(player))
		if (tonumber(getElementData(player, "acc:admin") or 0) >= 7) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
		if not time or not (...) then
			outputChatBox("#7cc576[Use]:#ffffff  /"..cmd.." [tempo] [Motivo]", player, 15, 128, 206, true)
		else
			outputChatBox("#D75656[ATENÇÃO]:#FFFFFF  Atenção o servidor ser reiniciado em #32b3ef".. time .."#FFFFFF minutos",getRootElement(),255,255,255,true)
			local indok = table.concat({...}," ")
			outputChatBox("#D75656[ATENÇÃO]:#FFFFFF  Motivo: #D75656".. indok .."#FFFFFF.",getRootElement(),255,255,255,true)
			outputChatBox("#D75656[ATENÇÃO]:#FFFFFF  Todos são aconselhados a parar de trabalhar porque seu status atual não é salvo!",getRootElement(),255,255,255,true)
			print("foi")
			triggerClientEvent(getRootElement(),"setCuccok",getRootElement(),time,indok)
		end
	end
end
addCommandHandler("reiniciarservidor", shutdownServer)
addCommandHandler("rs", shutdownServer)

addEvent("serverleall",true)
addEventHandler("serverleall",getRootElement(),function()
	shutdown ("Manutenção Rapida!")

end)

addEvent("hirdetes",true)
addEventHandler("hirdetes",getRootElement(),function(time,indok)
	outputChatBox("#D75656[ATENÇÃO]:#FFFFFF  Atenção o servidor ser reiniciado em #32b3ef".. time .."#FFFFFF minutos",getRootElement(),255,255,255,true)
	outputChatBox("#D75656[ATENÇÃO]:#FFFFFF  Motivo: #D75656".. indok .."#FFFFFF.",getRootElement(),255,255,255,true)
	outputChatBox("#D75656[ATENÇÃO]:#FFFFFF  Todos são aconselhados a parar de trabalhar porque seu status atual não é salvo!",getRootElement(),255,255,255,true)
end)



--[[
local scripts_refrescar = {
	{"bgo_items","sourceC.lua",0},
}


local abierto = {}

setTimer( function()
for k, targetPlayer in ipairs(getElementsByType("player")) do 
triggerClientEvent(targetPlayer,"IniciarContagemRM",targetPlayer,10)
end
setTimer ( reiniciarMOD, 10000, 1 )

end, 1000*60*30, 0 )


function onStart( )

setTimer(function()
for k, targetPlayer in ipairs(getElementsByType("player")) do 
triggerClientEvent(targetPlayer,"IniciarContagemRM",targetPlayer,10)
end
setTimer ( reiniciarMOD, 10000, 1 )
end,1000,1)

end
addEventHandler ( "onResourceStart", resourceRoot, onStart )


function reiniciarMOD()
		outputDebugString( "[AUTORESTART]..." )
        restartResource(getResourceFromName("bgo_items")) 
end
]]--


--[[
function restartResources () 
    local resourcesFile = xmlLoadFile("resources.xml") 
    if (not resourcesFile) then outputDebugString("Failed to load 'resources.xml'.",2) return end 
    for index, child in ipairs(xmlNodeGetChildren(resourcesFile)) do 
        local resName = xmlNodeGetAttribute(child, "name") 
        local resource = getResourceFromName(resName) 
        if (resource and getResourceState(resource) == "running") then 
            restartResource(resource) 
        end 
    end 
    xmlUnloadFile(resourcesFile) 
end 
setTimer ( reiniciarMOD, 10000, 0 )
]]--





addCommandHandler( "commands", 
   function(player)
   		local accName = getAccountName(getPlayerAccount(player))
		if (tonumber(getElementData(player, "acc:admin") or 0) >= 8) or ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) ) then
	      local commandsList = {} --table to store commands
		

			for _, subtable in pairs( getCommandHandlers() ) do
			local commandName = subtable[1]
			local theResource = subtable[2]
			if not commandsList[theResource] then
			commandsList[theResource] = {}
			end	
			table.insert( commandsList[theResource], commandName )
			end

		  for theResource, commands in pairs( commandsList ) do
		  local resourceName = getResourceInfo( theResource, "name" ) or getResourceName( theResource ) --try to get full name, if no full name - use short name
		  outputChatBox( "== "..resourceName.. " ==", player, 0, 255, 0 )

		  for _, command in pairs( commands ) do
			 outputChatBox( "/"..command, player, 255, 255, 255 )
		  end
		  end
		  end
  end
)

--[[
addCommandHandler("verlogs", function(thePlayer, _, ...)
	if getElementData(thePlayer, "acc:admin") >= 6 then
	
		if getElementData(thePlayer, "logativo") then
		setElementData(thePlayer, "logativo", false)
		outputChatBox("Você desativou o log de comandos", thePlayer, 255, 255, 255 )
		else
		outputChatBox("Você ativou o log de comandos", thePlayer, 255, 255, 255 )
		setElementData(thePlayer, "logativo", true)
		end
	end
end
)

addEventHandler("onPlayerCommand",root,
    function(command)
	if command == "lixao" then return end
	if command == "Reload" then return end
				local nearbyPlayer = nil
				for i = 1, #getElementsByType("player")do
				nearbyPlayer = getElementsByType("player")[i]
		if getElementData(nearbyPlayer, "logativo") then
		
		outputChatBox("#00ff00"..getPlayerName(source).." #ff00ff("..getElementData(source,"acc:id")..") #ccccccutilizou o comando #00ff00"..command.."", nearbyPlayer, 255, 255, 255, true )
	--print(""..cmd..", "..getPlayerName(player).."")
	
	end
	
	end
end)
]]--




local weaponID = {

	1,
	2,
	--3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	--12,
	13,
	14,
	15,
	16,
	17,
	18,
	24,
	20,
	22,
	26,
	27,
	--29,
	38,
	39,
	36,
	42,
	56,
	67,
	85,
	144,
	150,
	158,
	159,
	215,

	280,
	288,
	289,
	290,
	291,
	292,
	293,
	294,
	--295,
	

	-- minerios
	249,
	250,
	251,
	252,
	253,
	254,
	255,
	256,
	257,
	258,
	259,
	260,
	261,
	262,
	263,
	
	-- pecas
	160,
	161,
	162,
	163,
	164,
	165,
	166,
	167,
	168,
	169,
	170,
	171,
	172,
	173,
	174,
	175,
	176,
	177,
	178,
	179,
	180,
	181,
	182,
	183,
	184,
	185,
	186,
	187,
	188,
	189,
	190,
	191,
	192,
	193,
	194,
	195,
	196,
	197,
	198,
	199,
	200,
	201,
	202,
	203,
	204,
	205,
	206,
	207,
	208,
	209,
	210,
	211,
	212,
	213,
	214,
	
	-- peixes
	86,
	87,
	88,
	89,
	90,
	91,
	92,
	93,
	94,
	95,
	96,

	-- armas
	38,
	32,
	47,
	64,
	84,
	52,
	50,
	49,
	44,
	51,
	53,
	44,
	68,
	125,
	128,
	103,
	242,
	230,
}



local weaponVIP = {
    56,
	116,
	117,
	118,
	119,
	120,
	121,
	122,
	123,
	124,
	126,
	127,
	129,
	130,
	131,
	132,
	133,
	134,
	135,
	222,
	223,
	224,
	225,
	226,
	241,
	243,
	244,
	245,
	248,
	265,
	266,
	267,
	287,
	298,
	299,
	300,
	303,
	304,
	305,
	306,
	307,
	308,
	309,
	310,
	311,
	312,
	313,
	314,
	315,
	316,
	317,
	318,
	319,
	320,
	321,
	322,
	323,
	324,
	325,
	326,
	327,
	328,
	329,
	330,
	331,
	332,
	333,	
	334,
	335,
	336,
	337,
	338,
	339,
	340,
	342,
	343,
	344,
	345,
	346,
	347,
	348,
	349,
	350,
	351,
	352,
	353,
	354,
	355,
	356,
	357,
	358,
	360,
	361,
	362,
	363,
	364,
	365,
	366,
	367,
	368,
	369,
	

	
}






function _call(_called, ...)
	local co = coroutine.create(_called);
	coroutine.resume(co, ...);
end

function sleep(time)
	local co = coroutine.running();
	local function resumeThisCoroutine()
		coroutine.resume(co);
	end
	setTimer(resumeThisCoroutine, time, 1);
	coroutine.yield();
end

function iniciarRemocaoItems(player)
_call(removeritems, player)
end

function iniciarRemocaoItemsVIP(player)
_call(removeritemsVIP, player)
end


function removeritems(player)
	if isElement(player) then
	for a,b in ipairs(weaponID) do
	if exports['bgo_items']:hasItemS(player, b) then 
	exports['bgo_items']:takePlayerItemToID(player, b, true)	
	sleep(2)
	end
	end
	print("Items do usuário "..getPlayerName(player).." apagado com sucesso");
	end
end


function removeritemsVIP(player)
	if isElement(player) then
	for a,b in ipairs(weaponVIP) do
	if exports['bgo_items']:hasItemS(player, b) then 
	exports['bgo_items']:takePlayerItemToID(player, b, true)	
	sleep(2)
	end
	end
	print("Items VIP do usuário "..getPlayerName(player).." apagado com sucesso");
	end
end


