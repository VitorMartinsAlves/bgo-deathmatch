
--local blip = createBlip(1961.795, 2306.932, 17.358, 54)
--setElementData(blip, "blipName", "Academia")

local my = createColCuboid(1951.46252, 2296.22485, 14.21761, 20.742919921875, 21.825927734375, 6.4000028610229)
peso = {}
peso2 = {}

--[[
addEventHandler("onColShapeHit", getRootElement(),
function (thePlayer)
     if (source == my) then
   	         outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox(" ", thePlayer, 255,255,255, true)
		 outputChatBox("#7cc576[BGO Academia] #FFFFFFBem vindo a academia no BGO!", thePlayer, 255,255,255, true)
		 outputChatBox("#7cc576[ATENÇÂO] #FFFFFFcaso queira desligar ou desativar a rádio digite /acradio.", thePlayer, 255,255,255, true)
                 radio[thePlayer] = true
	 end
end)

addEventHandler("onColShapeLeave", getRootElement(),
function (thePlayer)
     if (source == my) then
         radio[thePlayer] = false
	 end
end)
]]--


local players = getElementsByType ( "object" )
for theKey,obj in ipairs(players) do 
		if (getElementModel(obj) == 2627) then
			setElementData(obj, "Esteira:Ocupada", false)
			setElementCollisionsEnabled(obj, true)

		end
		if (getElementModel(obj) == 2630) then
			setElementData(obj, "Bike:Ocupada", false)
			setElementCollisionsEnabled(obj, true)

		end
		if (getElementModel(obj) == 2629) then
			setElementCollisionsEnabled(obj, true)
			setElementData(obj, "Peso:Ocupada", false)
		end
end


function esteira (thePlayer, Esteira)
local x,y,z = getElementPosition(Esteira) 
     --if not isElementWithinColShape ( thePlayer, my ) then return end
     if (getElementData(Esteira, "Esteira:Ocupada") == true) then
	 outputChatBox("#7cc576[ACADEMIA] #FFFFFFEssa esteira está sendo usada.", thePlayer, 255,255,255, true)
     else
		 if not (getElementData(thePlayer, "char:money") >= 50) then
		 outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê não possui dinheiro sulficiente para utilizar o aparelho.", thePlayer, 255,255,255, true)
		 else 
			 if  (getElementData(thePlayer, "Exercicio") == true) then
		     outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê já está fazendo um exercicio.", thePlayer, 255,255,255, true)
		     else 
		         setElementData(Esteira, "Esteira:Ocupada", true)
				 setElementData(thePlayer, "academia:obj", Esteira)
				 local rotx, roty, rotz = getElementRotation(Esteira)
			     setElementRotation(thePlayer, 0, 0, rotz)
				 
		     	 setElementPosition(thePlayer, x + 1.4, y , z + 0.5)
				 
				attachElements ( thePlayer, Esteira, 0, -1.5, 1, rotx, roty, rotz )
				 setTimer(detachElements, 60000, 1,thePlayer, Esteira )
				 
				 
				 
		    	 setPedAnimation(thePlayer, "GYMNASIUM", "gym_tread_geton", -1, true, false, false )
		    	 setTimer(setPedAnimation, 2000, 1,thePlayer, "GYMNASIUM", "gym_tread_walk", -1, true, false, false )
				 setTimer(setPedAnimation, 20000, 1,thePlayer, "GYMNASIUM", "gym_tread_jog", -1, true, false, false )
				 setTimer(setPedAnimation, 40000, 1,thePlayer, "GYMNASIUM", "gym_tread_sprint", -1, true, false, false )
				 setTimer(setPedAnimation, 50000, 1,thePlayer, "GYMNASIUM", "gym_tread_jog", -1, true, false, false )
				 setTimer(setPedAnimation, 55000, 1,thePlayer, "GYMNASIUM", "gym_tread_walk", -1, true, false, false )
		    	 setTimer(setElementFrozen, 1900, 1, thePlayer, true)
				 setTimer(triggerClientEvent, 1900, 1,thePlayer, "progressService", root, 60, "[ACADEMIA] #FFFFFFRealizando #7cc576Esteira #FFFFFF, Aguarde. ")
				 setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - 50)
				 setTimer(function (thePlayer)
				  setElementFrozen(thePlayer, false)
				  setElementData(thePlayer, "Exercicio", false)
				  setPedAnimation(thePlayer, "GYMNASIUM", "gym_tread_getoff", -1, true, false, false )
				  setTimer(setPedAnimation, 3000, 1,thePlayer)
				  setElementData(Esteira, "Esteira:Ocupada", false)
				  setPedStat(thePlayer, 21, getPedStat ( thePlayer, 21 ) - 250)
				 end, 61900, 1, thePlayer)
		    	 setElementData(thePlayer, "Exercicio", true)
		    	-- outputChatBox("#7cc576[ACADEMIA] #FFFFFFFazendo Esteira. Treinos ("..getElementData(thePlayer, "academia:exercicio").."#FFA000/10#FFFFFF).", thePlayer, 255,255,255, true)
			 end
	     end
	 end
end
addEvent("Academia:Esteira", true)
addEventHandler("Academia:Esteira", getRootElement(), esteira)

function bike (thePlayer, Bike)
local x,y,z = getElementPosition(Bike)
     --if not isElementWithinColShape ( thePlayer, my ) then return end
     if (getElementData(Bike, "Bike:Ocupada") == true) then
	 outputChatBox("#7cc576[ACADEMIA] #FFFFFFEssa Bicicleta está sendo usada.", thePlayer, 255,255,255, true)
     else
		 if not (getElementData(thePlayer, "char:money") >= 50) then
		 outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê não possui dinheiro sulficiente para utilizar o aparelho.", thePlayer, 255,255,255, true)
		 else 
			 if  (getElementData(thePlayer, "Exercicio") == true) then
		     outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê já está fazendo um exercicio.", thePlayer, 255,255,255, true)
		     else 
		         setElementData(Bike, "Bike:Ocupada", true)
				 setElementData(thePlayer, "academia:obj", Bike)
				 local rotx, roty, rotz = getElementRotation(Bike)
			     setElementRotation(thePlayer, 0, 0, rotz + 180)
		     	 --setElementPosition(thePlayer, 1970.481, 2306.292, 16.449)
		     	 setElementPosition(thePlayer, x - 0.5, y - 0.6, z + 0.8)
				 
				 
				 attachElements ( thePlayer, Bike, 0.4, 0.5, 1, rotx, roty, rotz )
				 setTimer(detachElements, 60000, 1,thePlayer, Bike )
				 
				 
				 setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - 50)
		    	 setPedAnimation(thePlayer, "GYMNASIUM", "gym_bike_geton", -1, true, false, false )
		    	 setTimer(setPedAnimation, 1500, 1,thePlayer, "GYMNASIUM", "gym_bike_pedal", -1, true, false, false )
				 setTimer(setPedAnimation, 20000, 1,thePlayer, "GYMNASIUM", "gym_bike_slow", -1, true, false, false )
				 setTimer(setPedAnimation, 40000, 1,thePlayer, "GYMNASIUM", "gym_bike_fast", -1, true, false, false )
				 setTimer(setPedAnimation, 50000, 1,thePlayer, "GYMNASIUM", "gym_bike_slow", -1, true, false, false )
				 setTimer(setPedAnimation, 52000, 1,thePlayer, "GYMNASIUM", "gym_bike_still", -1, true, false, false )
				 setTimer(setPedAnimation, 60000, 1,thePlayer, "GYMNASIUM", "gym_bike_celebrate", -1, true, false, false )
		    	 setTimer(setElementFrozen, 1400, 1, thePlayer, true)
				 setTimer(triggerClientEvent, 1000, 1,thePlayer, "progressService", root, 60, "[ACADEMIA] #FFFFFFRealizando #7cc576Bicicleta #FFFFFF, Aguarde. ")
				 setTimer(function (thePlayer)
				  setElementFrozen(thePlayer, false)
				  setElementData(thePlayer, "Exercicio", false)
				  setPedAnimation(thePlayer, "GYMNASIUM", "gym_bike_getoff", -1, true, false, false )
				  setTimer(setPedAnimation, 800, 1,thePlayer)
				  setElementData(Bike, "Bike:Ocupada", false)
				  setPedStat(thePlayer, 21, getPedStat ( thePlayer, 21 ) - 250)
				 end, 61900, 1, thePlayer)
		    	 setElementData(thePlayer, "Exercicio", true)
			 end
	     end
	 end
end
addEvent("Academia:Bike", true)
addEventHandler("Academia:Bike", getRootElement(), bike)

peso  = {}
peso2 = {}


local zone = createColCuboid(2995.73730, -1899.89063, 9.14885, 15.794189453125, 5.132080078125, 5.8000024795532)
		
		
addEvent("Academia:Malhar", true)
addEventHandler("Academia:Malhar", getRootElement(),
function (thePlayer, malhar)

		 
		 if not (getElementData(thePlayer, "char:money") >= 50) then
		 outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê não possui dinheiro sulficiente para utilizar o aparelho.", thePlayer, 255,255,255, true)
		 else 
			 if (getElementData(thePlayer, "Exercicio") == true) then
		     outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê já está fazendo um exercicio.", thePlayer, 255,255,255, true)
		     return
             end	
				  if isElement(peso[thePlayer]) then
				     destroyElement(peso[thePlayer])
				  end
				  if isElement(peso2[thePlayer]) then
				     destroyElement(peso2[thePlayer])
				  end
				  
		     peso[thePlayer]  = createObject(3071, 0, 0, 0)
			 peso2[thePlayer] = createObject(3071, 0, 0, 0)
			 setElementData(thePlayer, "Exercicio", true)
			 setTimer(function(thePlayer)
			 exports.bone_attach:attachElementToBone(peso[thePlayer],thePlayer,11, 0,0,0,0,-90,0) 
			 exports.bone_attach:attachElementToBone(peso2[thePlayer],thePlayer,12, 0,0,0,0,-90,0)	
             setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - 50)			 
			 triggerClientEvent(thePlayer, "progressService", root, 60, "[ACADEMIA] #FFFFFFRealizando #7cc576Bicpes #FFFFFF, Aguarde. ")
			 end, 2000, 1, thePlayer)
			 setElementFrozen(thePlayer, true)
			 setPedAnimation(thePlayer, "Freeweights", "gym_free_pickup", -1, true, false, false )
			 setTimer(setPedAnimation, 2000, 1,thePlayer, "Freeweights", "gym_free_up_smooth", -1, true, false, false )
			 
		      setTimer(function (thePlayer)
				  setElementFrozen(thePlayer, false)
				  setElementData(thePlayer, "Exercicio", false)
				  setPedAnimation(thePlayer, "Freeweights", "gym_free_putdown", -1, true, false, false )
				  if isElement(peso[thePlayer]) then
				     destroyElement(peso[thePlayer])
				  end
				  if isElement(peso2[thePlayer]) then
				     destroyElement(peso2[thePlayer])
				  end
	
				  setPedStat(thePlayer, 23, getPedStat ( thePlayer, 23 ) + 250)
				  setTimer(setPedAnimation, 1500, 1,thePlayer)
		     end, 62000, 1, thePlayer)
		 end
	 --end
end)


function malharPeso (thePlayer, Peso)
local x,y,z = getElementPosition(Peso)
--if not isElementWithinColShape ( thePlayer, my ) then return end
     if (getElementData(Peso, "Peso:Ocupada") == true) then
	 outputChatBox("#7cc576[ACADEMIA] #FFFFFFEsse Peitoral está sendo usada.", thePlayer, 255,255,255, true)
     else
	 
		 --if not (getElementData(thePlayer, "char:money") >= 50) then
		-- outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê não possui dinheiro sulficiente para utilizar o aparelho.", thePlayer, 255,255,255, true)
		-- else 
			 if  (getElementData(thePlayer, "Exercicio") == true) then
		     outputChatBox("#7cc576[ACADEMIA] #FFFFFFVocê já está fazendo um exercicio.", thePlayer, 255,255,255, true)
             else
			 
		         setElementData(Peso, "Peso:Ocupada", true)
				 setElementData(thePlayer, "academia:obj", Peso)
				 triggerClientEvent(thePlayer, "progressService", root, 60, "[ACADEMIA] #FFFFFFRealizando #7cc576Peitoral #FFFFFF, Aguarde. ")
				 local rotx, roty, rotz = getElementRotation(Peso)
			     setElementRotation(thePlayer, 0, 0, tonumber(rotz))
				 --setElementPosition(thePlayer, x, y + 0.7, z + 1.1)
				 
				 attachElements ( thePlayer, Peso, 0, -0.7, 1, rotx, roty, rotz )
				 setTimer(detachElements, 60000, 1,thePlayer, Peso )
				 
				 
				-- setElementRotation(thePlayer, -0, 0, 357.219)
				  if isElement(peso[thePlayer]) then
				     destroyElement(peso[thePlayer])
				  end
				  if isElement(peso2[thePlayer]) then
				     destroyElement(peso2[thePlayer])
				  end
				  
		         peso[thePlayer]  = createObject(3071, 0, 0, 0)
			     peso2[thePlayer] = createObject(3071, 0, 0, 0)
			     exports.bone_attach:attachElementToBone(peso[thePlayer],thePlayer,11, 0,0,0,0,-90,0) 
			     exports.bone_attach:attachElementToBone(peso2[thePlayer],thePlayer,12, 0,0,0,0,-90,0) 
				 setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - 50)
				 setElementCollisionsEnabled(Peso, false)
				 setTimer(setElementRotation, 1000,1,thePlayer, -0, 0, tonumber(rotz))
				 
				 setTimer(setElementFrozen, 1100, 1,thePlayer, true)
		    	 setTimer(setPedAnimation, 1500, 1,thePlayer, "benchpress", "gym_bp_down", -1, true, false, false )
				 setTimer(function (thePlayer)
				  setElementFrozen(thePlayer, false)
				  setElementData(thePlayer, "Exercicio", false)
				  setPedAnimation(thePlayer, "benchpress", "gym_bp_getoff", -1, true, false, false )
				  --[[
				  if isElement(peso[thePlayer]) then
				     setTimer(destroyElement, 2000, 1,peso[thePlayer])
				  end
				  if isElement(peso2[thePlayer]) then
				     setTimer(destroyElement, 2000, 1,peso2[thePlayer])
				  end]]--
				  
				  if isElement(peso[thePlayer]) then
				     destroyElement(peso[thePlayer])
				  end
				  if isElement(peso2[thePlayer]) then
				     destroyElement(peso2[thePlayer])
				  end
				  
				if getElementData(thePlayer, "adminjail") == 1 then
				if isElementWithinColShape (thePlayer, zone) then
				for prisao = 1, 3 do
				triggerEvent("entregarCaixa", thePlayer, thePlayer)
				end
				end
				end
				
				  setPedStat(thePlayer, 23, getPedStat ( thePlayer, 23 ) + 250)
				  setElementData(Peso, "Peso:Ocupada", false)
				  setElementCollisionsEnabled(Peso, true)
				  setTimer(setPedAnimation, 5000, 1,thePlayer)
				 end, 61900, 1, thePlayer)
		    	 setElementData(thePlayer, "Exercicio", true)
			 end
	    -- end
	 end
end
addEvent("Academia:Peso", true)
addEventHandler("Academia:Peso", getRootElement(), malharPeso)


addEventHandler ( "onPlayerQuit", root,
function ()
     if (getElementData(source, "academia:obj")) then
	     local obj = getElementData(source, "academia:obj")
		 if getElementModel(obj) == 2627 then
		     setElementData(obj, "Esteira:Ocupada", false)
		 end
		 if getElementModel(obj) == 2630 then
		     setElementData(obj, "Bike:Ocupada", false)
		 end
		 if getElementModel(obj) == 2629 then
		     setElementData(obj, "Peso:Ocupada", false)
			 setElementCollisionsEnabled(obj, true)
		 end
		 if isElement(peso[source]) then
		     destroyElement(peso[source])
		 end
		 if isElement(peso2[source]) then
		     destroyElement(peso2[source])
		 end
	 end
end)

--[[
radio = {}

function startR (thePlayer)
     if isElementWithinColShape (thePlayer, my) then
	     if radio[thePlayer] then
			     triggerClientEvent(thePlayer, "setRadio", thePlayer, 1)
				 outputChatBox("#7cc576[RÀDIO ACADEMIA] #FFFFFFRádio desativada.", thePlayer, 255,255,255, true)
                                 radio[thePlayer] = false
			     else
				 triggerClientEvent(thePlayer, "setRadio", thePlayer, 2)
				 outputChatBox("#7cc576[RÀDIO ACADEMIA] #FFFFFFRádio ativada.", thePlayer, 255,255,255, true)
                                 radio[thePlayer] = true
		 end
	 end
end
addCommandHandler("acradio", startR)]]--