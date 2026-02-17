local object = { }
local ped = { }
local timer = { }
local timer2 = { }
function cadeira (thePlayer)
if tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 4 
	or  exports.bgo_admin:beneficiario(thePlayer) then 
	local v = getPedOccupiedVehicle ( thePlayer )
		if v then return end
	if getElementData(thePlayer,"cadeiraativa") == false then
		local x,y,z = getElementPosition(thePlayer)
		object[thePlayer] = createObject(1369, x,y,z)
		setElementCollisionsEnabled(object[thePlayer], false)
		attachElements (object[thePlayer], thePlayer, 0, 0, -0.46, 0, 0, -180)
		local rotx,roty,rotz = getElementRotation(thePlayer)
		ped[thePlayer] = createPed ( getElementModel(thePlayer), x,y,z )
		
		if (getElementModel(thePlayer) == 0) then
			getClothes(thePlayer)
		end
		
		
		attachElements (ped[thePlayer], thePlayer, 0, 0, 0, rotx,roty,rotz)
		setElementRotation(ped[thePlayer], rotx,roty,rotz )
		setElementAlpha(thePlayer, 0)
		setElementData(thePlayer, "samu:cadeira", true)
		setElementData(thePlayer, "cadeiraativa", true)
		if isTimer(timer[thePlayer]) then
		killTimer(timer[thePlayer])
		end
		
		
		timer[thePlayer] = setTimer(function()
		if isElement(object[thePlayer]) then
		local x,y,z = getElementPosition ( thePlayer )
		local rotx,roty,rotz = getElementRotation(thePlayer)
		setElementPosition(ped[thePlayer], x,y,z)
		setElementRotation(ped[thePlayer], rotx,roty,rotz)
		setPedAnimation( ped[thePlayer], "ped", "SEAT_idle", 1, true, true, true, true)
		setPedAnimationProgress( ped[thePlayer], "SEAT_idle", 0.2 )
		setPedAnimationSpeed(ped[thePlayer], "SEAT_idle", 0)	
		else
		if isElement(object[thePlayer]) then
		destroyElement(object[thePlayer])
		end
		if isElement(ped[thePlayer]) then
		destroyElement(ped[thePlayer])
		end
		if isTimer(timer[thePlayer]) then
		killTimer(timer[thePlayer])
		end
		end	
		end, 70, 0)
		
		
		else
		
	--	timer2[thePlayer] = setTimer(function()
		if isElement(object[thePlayer]) then
		destroyElement(object[thePlayer])
		end
		if isElement(ped[thePlayer]) then
		destroyElement(ped[thePlayer])
		end
		if isTimer(timer[thePlayer]) then
		killTimer(timer[thePlayer])
		end
		setElementData(thePlayer, "cadeiraativa", false)
		setElementData(thePlayer, "samu:cadeira", false)
		setElementAlpha(thePlayer, 255)
		
		end
		--end, 120000, 1)
	end
end
addCommandHandler("cadeira", cadeira )

function enterMec (player, seat, jacked)
		if (getElementData(player, "samu:cadeira") == true) then
			 cancelEvent()
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox(" ", player, 255,255,255, true)
			 outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê está de cadeira de rodas não pode entrar no veiculo, aguarde 1 minuto", player, 255,255,255, true)
			 else
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterMec)

for i, player in pairs (getElementsByType("player")) do
	setElementAlpha(player, 255)
	setElementData(player, "samu:cadeira", false)
end

addEventHandler("onPlayerQuit", root,
function ()
		if isElement(object[source]) then
		destroyElement(object[source])
		end
		if isElement(ped[source]) then
		destroyElement(ped[source])
		end
		if isTimer(timer[source]) then
		killTimer(timer[source])
		end
end
)



function getClothes(thePlayer)
	local texture = {}
	local model = {}
	for i=0, 17, 1 do
		local clothesTexture, clothesModel = getPedClothes(thePlayer, i)
		if ( clothesTexture ~= false ) then
			table.insert(texture, clothesTexture)
			table.insert(model, clothesModel)
		else
			table.insert(texture, " ")
			table.insert(model, " ")
		end	
	end
	local allTextures = table.concat(texture, ",")
	local allModels = table.concat(model, ",")
	clothesallTextures = allTextures
	clothesallModels = allModels
	texture = {}
	model = {}	
	setPedClothes(thePlayer)
end



function setPedClothes(thePlayer)
	local textureString = clothesallTextures
	local modelString = clothesallModels
	local textures2 = split(textureString, 44)
	local models2 = split(modelString, 44)
	for i=0, 17, 1 do
		if ( textures2[i+1] ~= " " ) then
			if isElement(ped[thePlayer]) then
			addPedClothes(ped[thePlayer], textures2[i+1], models2[i+1], i)
			end
		end
	end
	textures2 = {}
	models2 = {}
end