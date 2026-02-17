object = {}
my     = {}
MACA = {}
aream  = {}
saida  = {}
marker = {}

function exitCar (player)
local vehicle = getPedOccupiedVehicle (player)
     if (vehicle) then
	     if (getElementModel(vehicle) == 416) then
		     if isElement(my[player]) then 
                 destroyElement(my[player])
             end
	     end
	 end
end


--[[


function startCar (player)
local vehicle = getPedOccupiedVehicle (player)
     if (vehicle) then
		 if (getElementModel(vehicle) == 416 or getElementModel(vehicle) == 488)  then
			if (getElementData(player, "char:dutyfaction") == 4) then
	        local xX, yY, zZ = getElementPosition(vehicle)
		    if isElement(my[vehicle]) then 
            destroyElement(my[vehicle])
            end
		    my[vehicle] = createColSphere (xX, yY, zZ, 1.5)
			setElementData(my[vehicle], "col:mec", true)
			attachElements (my[vehicle], vehicle, 0 + 1.5, 0 + 0.5, 0 - 0.5)
		    removeEventHandler("onColShapeHit", my[vehicle], enterCol)
			addEventHandler("onColShapeHit", my[vehicle], enterCol)
			setVehicleDoorOpenRatio (vehicle, 4, 1, 2500)
			setVehicleDoorOpenRatio (vehicle, 5, 1, 2500)
			addEventHandler( "onElementDestroy", vehicle,
			function ()
			if isElement(my[source]) then 
			destroyElement(my[source])
			end
			end
            )
		 	end
		end
	end
end
addEventHandler("onVehicleStartExit", getRootElement(), startCar)
]]--

addEventHandler("onVehicleEnter", getRootElement(),
function ( playerSource )
	local vehicle = getPedOccupiedVehicle ( playerSource )
	if vehicle then
			setVehicleDoorOpenRatio ( vehicle, 2, 0, 1000 )
			setVehicleDoorOpenRatio ( vehicle, 3, 0, 1000 )
			setVehicleDoorOpenRatio ( vehicle, 4, 0, 1000 )
			setVehicleDoorOpenRatio ( vehicle, 5, 0, 1000 )
	end
end )




function exitCar22 (player)
	local vehicle = getPedOccupiedVehicle (player)
		 if (vehicle) then
			if (getElementModel(vehicle) == 416) then
				if (getElementData(player, "char:dutyfaction") == 4) then
					setVehicleDoorOpenRatio (vehicle, 4, 0, 2500)
					setVehicleDoorOpenRatio (vehicle, 5, 0, 2500)
				end
			end
		end
	end
addEventHandler("onVehicleEnter", getRootElement(), exitCar22)

local maca = createColSphere (315.88629150391,-1503.7647705078,36.032508850098, 2)
local maca2 = createColSphere (329.93792724609,-1493.9774169922,71.464645385742, 2)


--setElementData(my, "col:mec", true)

function enterCol (thePlayer)
		if (getElementData(thePlayer, "char:dutyfaction") == 4) then
		if (getElementData(thePlayer, "maca:chao") == true) then return end
		if (getElementData(thePlayer, "maca:acolher") == true) then return end
		if (getElementData(thePlayer, "acolhido") == true) then return end
		local vehicle = getPedOccupiedVehicle (thePlayer)
		if (vehicle) then return end
		--if not isPedInVehicle ( thePlayer ) then
		if (getElementData(thePlayer, "samu:maca") == true) then
	     if isElement(object[thePlayer]) then
		 destroyElement(object[thePlayer])
		 end
         setElementData(thePlayer, "samu:maca", false)
		 else
		 object[thePlayer] = createObject(1997, 0, 0, 0)
		 setElementCollisionsEnabled(object[thePlayer], false)
		 attachElements (object[thePlayer], thePlayer, 0 , 1.5, -1 )
		 setElementData(thePlayer, "samu:maca", true)
		 setElementData(thePlayer, "maca:area", false)
		end
	end
end
addEventHandler("onColShapeHit", maca, enterCol)
addEventHandler("onColShapeHit", maca2, enterCol)
addEvent("GiveMaca", true)
addEventHandler("GiveMaca", root, enterCol)

local timer = {}

function soltarMACA(thePlayer)
	 if (getElementData(thePlayer, "char:dutyfaction") == 4) then
		if (getElementData(thePlayer, "maca:chao") == true) then outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê ja tem uma MACA no chão.", thePlayer, 255,255,255, true) return end
		 if (getElementData(thePlayer, "samu:maca") == false) then
		     outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê precisa de uma para solta-la.", thePlayer, 255,255,255, true)
			 else
			     local x,y,z = getElementPosition(object[thePlayer])
				detachElements ( object[thePlayer], thePlayer )
				local x2,y2,z2 = getElementRotation(thePlayer)
				setElementPosition(object[thePlayer], x, y , z)
				setElementRotation(object[thePlayer], x2,y2,z2 -0.5)
				aream[thePlayer] = createColSphere (x, y, z, 5)

				marker[thePlayer] = createMarker ( x, y, z-6, "cylinder", 10, 0, 0, 255, 50 )


				setPedAnimation(thePlayer, "BOMBER","BOM_Plant_2Idle", -1, false, false, true)
				setTimer(function()
				setPedAnimation(thePlayer)
				end, 1000,1)
				setElementData(thePlayer, "maca:soltar", true)
				setElementData(thePlayer, "maca:chao", true)
				setElementData(thePlayer, "maca:area", true)
				saida[thePlayer] = createColSphere (x, y + 1, z, 16)
		 end
	 end
end
addCommandHandler("soltar", soltarMACA)

for _, player in ipairs(getElementsByType("player")) do
	setElementData(player, "maca:soltar", false)
	setElementData(player, "maca:chao", false)
	setElementData(player, "maca:area", false)
	setElementData(player, "samu:maca", false)
	setElementData(player, "maca:acolher", false)
end


local timer2 = {}
addEvent("AcolherNaMaca", true)
addEventHandler("AcolherNaMaca",root, function(thePlayer, player)
	--if getElementData(thePlayer, "char:dutyfaction") == 4 then --or getElementData(thePlayer, "acc:admin") > 7 then 


		--print("teste")


		if isTimer(timer2[thePlayer]) then return end
		timer2[thePlayer] = setTimer(function() end, 5000, 1)

		if (getElementData(thePlayer, "maca:chao") == false) then
			outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê precisa de uma MACA para usar este comando", thePlayer, 255,255,255, true)
		return 
		end

		if (getElementData(thePlayer, "maca:area") == false) then
			outputChatBox("#FFA000[BGO ERROR] #FFFFFFSua MACA está muito longe para acolher o paciente", thePlayer, 255,255,255, true)
		return 
		end


	if getElementData(thePlayer, "acolhendo") == false then 
				if not getElementData(player, "PlayerAnimo") then outputChatBox("#bebebeVocê só pode ajudar pessoas desanimadas!",thePlayer,255,255,255,true) return end
				setPedAnimation( thePlayer, "POLICE", "CopTraf_Stop", -1, false, false, true, false)
				--setTimer ( function()
					setElementData(thePlayer, "maca:acolher", true)
					removePedFromVehicle ( player ) 
					setElementData(player, "acolhido", true) 
					attachElements (player, object[thePlayer], 0 , 0, 1.8 )	
					setElementData(thePlayer, "acolhendo", true)
					outputChatBox("#bebebePaciente acolhida em sua maca!",thePlayer,255,255,255,true) 

					if isTimer(timer[thePlayer]) then
						killTimer(timer[thePlayer])
					end
					timer[thePlayer] = setTimer(function()
							--if isElement(object[thePlayer]) then
							if isElement(player) then
							if not player then return end
							local x,y,z = getElementPosition ( object[thePlayer] )
							local x2,y2,z2 = getElementRotation ( object[thePlayer] )
							setElementPosition(player, x,y,z +1.8)
							setElementRotation(player, x2,y2,z2+90)
							setPedAnimation( player, "CRACK", "crckidle2", 1, true, true, true, true)
							setPedAnimationSpeed(player, "crckidle2", 0)
							if not isElement(thePlayer) then
							if isTimer(timer[thePlayer]) then
							killTimer(timer[thePlayer])
							detachElements ( player, object[thePlayer] )
							end
							end
						end	
					end, 500, 0)
				else
					if not getElementData(player, "PlayerAnimo") then outputChatBox("#bebebeVocê só pode ajudar pessoas desanimadas!",thePlayer,255,255,255,true) return end
					detachElements (player, object[thePlayer] )
					setElementData(thePlayer, "maca:acolher", false)
					setTimer ( setPedAnimation, 100, 1, player,  "GHANDS", "gsign2", 5000, false, false, false)
					setTimer ( setPedAnimation, 250, 1, player, nil)
					setElementData(player, "acolhido", false) 
					setElementData(thePlayer, "acolhendo", false)
					outputChatBox("#bebebePaciente saiu de sua maca!",thePlayer,255,255,255,true) 
					local x,y,z = getElementPosition ( object[thePlayer] )
					setElementPosition(player, x+1,y,z+1)
				if isTimer(timer[thePlayer]) then
						killTimer(timer[thePlayer])
			end
		end
	end
)


addEvent("ColocarNoVeiculo", true)
addEventHandler("ColocarNoVeiculo",root, function(thePlayer, player)
			if not getElementData(player, "PlayerAnimo") then outputChatBox("#bebebeVocê só pode ajudar pessoas desanimadas!",thePlayer,255,255,255,true) return end
					detachElements (player, object[thePlayer] )
					setElementData(thePlayer, "maca:acolher", false)
					setTimer ( setPedAnimation, 100, 1, player,  "GHANDS", "gsign2", 5000, false, false, false)
					setTimer ( setPedAnimation, 250, 1, player, nil)
					setElementData(player, "acolhido", false) 
					setElementData(thePlayer, "acolhendo", false)
					outputChatBox("#bebebePaciente saiu de sua maca!",thePlayer,255,255,255,true) 
					local x,y,z = getElementPosition ( object[thePlayer] )
					setElementPosition(player, x+1,y,z+1)
					if isTimer(timer[thePlayer]) then
						killTimer(timer[thePlayer])
					end
					local pX,pY,pZ = getElementPosition(player)
					for k,v in ipairs(getElementsByType("vehicle")) do
					if (getElementModel(v) == 416) then
					vX,vY,vZ = getElementPosition(v)
					local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
					if dist <= 10 then
					if (warpPedIntoVehicle(player, v, 3)) then
					exports.bgo_chat:sendLocalMeAction(thePlayer, "implantando o homem no veículo.")
				end
			end
		end
	end
end				
)


addEventHandler("onColShapeLeave", getRootElement(),
function(thePlayer)
	if (source == saida[thePlayer]) then
			if isElement(saida[thePlayer]) then
				destroyElement(saida[thePlayer])
            end
            if isElement(aream[thePlayer]) then 
                destroyElement(aream[thePlayer])
            end
            if isElement(object[thePlayer]) then
                destroyElement(object[thePlayer])
               -- setElementData(thePlayer, "samu:maca", false)
			end
			
			if isElement(marker[thePlayer]) then
				destroyElement(marker[thePlayer])
			end

			setElementData(thePlayer, "maca:soltar", false)
			setElementData(thePlayer, "maca:chao", false)
			setElementData(thePlayer, "maca:area", false)
			setElementData(thePlayer, "samu:maca", false)
			setElementData(thePlayer, "maca:acolher", false)


			--setElementData(thePlayer, "maca:chao", false)
			--setElementData(thePlayer, "maca:area", false)

			if isTimer(timer[thePlayer]) then
				killTimer(timer[thePlayer])
			end
	end
end)



addEventHandler("onColShapeLeave", getRootElement(),
function (thePlayer)
     if (source == aream[thePlayer]) then
	     outputChatBox("#FFA000[BGO MACA] #FFFFFFVocê está ficando distante da sua maca!.", thePlayer, 255,255,255, true)
		 setElementData(thePlayer, "maca:area", false)
	 end
end)

addEventHandler("onColShapeHit", getRootElement(),
function (thePlayer)
     if (source == aream[thePlayer]) then
		 setElementData(thePlayer, "maca:area", true)
	 end
end)

function pegarMACA(thePlayer)
     if (getElementData(thePlayer, "char:dutyfaction") == 4) then
	     if (getElementData(thePlayer, "samu:maca") == false) then
		     outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê precisa de uma maca para pega-la.", thePlayer, 255,255,255, true)
			 else
			 	 if (getElementData(thePlayer, "maca:soltar") == false) then
		         outputChatBox("#FFA000[BGO ERROR] #FFFFFFSua MACA ainda está em sua mão.", thePlayer, 255,255,255, true)
			     else
				     if (getElementData(thePlayer, "maca:area") == false) then
					 outputChatBox("#FFA000[BGO ERROR] #FFFFFFSua MACA está muito longe para pega-la.", thePlayer, 255,255,255, true)
					 else
					    outputChatBox("#FFA000[BGO] #FFFFFFMACA recuperada.", thePlayer, 255,255,255, true)
						if isElement(aream[thePlayer]) then 
							destroyElement(aream[thePlayer])
						end
						if isElement(saida[thePlayer]) then
							destroyElement(saida[thePlayer])
						end
						if isElement(marker[thePlayer]) then
							destroyElement(marker[thePlayer])
						end
						
						setPedAnimation(thePlayer, "BOMBER","BOM_Plant_2Idle", -1, false, false, true)
						setTimer(function()
						setPedAnimation(thePlayer)
						end, 1000,1)
						attachElements (object[thePlayer], thePlayer, 0 , 1.5, -1 )
						setElementData(thePlayer, "maca:chao", false)
						setElementData(thePlayer, "maca:area", false)
			     end
		     end
	     end
	 end
end
addCommandHandler("pegar", pegarMACA)


function enterMec (player, seat, jacked)
     if (getElementModel(source) == 416) then
	     if (getElementData(player, "samu:maca") == true) then
		      cancelEvent()
		      outputChatBox("#FFA000[BGO ERROR] #FFFFFFVocê não pode embarcar no veiculo com a MACA na mão.", player, 255,255,255, true)
		      else
		 end
	 end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterMec)


addEventHandler("onPlayerQuit", root,
function ()
		if isElement(my[source]) then 
			destroyElement(my[source])
		end
		if isElement(object[source]) then 
			destroyElement(object[source])
		end
		if isElement(aream[source]) then 
			destroyElement(aream[source])
		end
		if isElement(saida[source]) then 
			destroyElement(saida[source])
		end
		if isElement(marker[source]) then
			destroyElement(marker[source])
		end


		if isTimer(timer[source]) then
			killTimer(timer[source])
			detachElements ( player, object[source] )
		end
end
)


