local jobPed = {}
local roboto = "default"--dxCreateFont("Roboto.ttf",14)

local job_PedPos = {
	{105, 2589.6901855469,2824.3962402344,10.8203125, "Lavagem de dinheiro!",90.818702697754, 13},
	--{213, -54.808082580566,-1636.3120117188,7.0945730209351, "Lavagem de dinheiro!", 28.373329162598, 25},
}

local jobPed2 = {}
local job_PedPos2 = {
	{105, -2521.4267578125,2295.1782226563,4.984375, "Blocos de dinheiro!",177.46943664551},
}


local bloqueio = false
keyTable = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "w","a","s","d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b", "c", "e", "f", "g", "h", "i", "j", "k",
 "l", "n", "o", "p", "q", "r", "t", "u", "v", "x", "y", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "num_enter", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "escape", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=" }

addEventHandler("onClientKey", root, function(button, press) 
     if (bloqueio) then
	     for i,bindsK in ipairs(keyTable) do
             if (button == bindsK) then
                 cancelEvent() 
			 end
		 end
     end 
end)  

function createPeds() 
	for index,value in ipairs (job_PedPos2) do
		if isElement(jobPed2[index]) then destroyElement(jobPed2[index]) end
		jobPed2[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed2[index], true)
		setPedRotation(jobPed2[index], value[6])
		jobPed2[index]:setData("ped:blocodedinheiro", true)
		jobPed2[index]:setData("Ped:Name",value[5])
		
		blip = createBlipAttachedTo ( jobPed2[index], 32 )
		setElementData(blip ,"blipName", "Cidade do Crime")
		
	end
	
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		
		
		
		blip = createBlipAttachedTo ( jobPed[index], 23 )
		setElementData(blip, "blipName","Lavanderia")
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:dinheirosujo", true)
		jobPed[index]:setData("Ped:Name",value[5])
		jobPed[index]:setData("Ped:JOB",value[7])
	end
	
	
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
--createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:dinheirosujo") then
			cancelEvent ()
		end
		if getElementData(source,"ped:blocodedinheiro") then
			cancelEvent ()
		end
	end
)





local iniciou = false
addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
			if element and element:getData("ped:dinheirosujo") and not iniciou then 
					if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
			--if getElementData(localPlayer, "char:dutyfaction") == element:getData("Ped:JOB") then
			if not exports['bgo_items']:hasItem(localPlayer, 22) then
			triggerEvent("bgo>info", localPlayer,"Lavagem!", "Você não tem dinheiro sujo irmão!", "info")
			return
			end
					triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 20000, true, false, false)
					triggerEvent("progressService", localPlayer, 20, "#ffffffLavando dinheiro sujo!")
					iniciou = true
					bloqueio = true
					setTimer(function()
					iniciou = false
					bloqueio = false
					triggerServerEvent("bgoMTA->#dinheirosujo", localPlayer, localPlayer)
					end,20000,1)

					elements = element
				--end
			end
		end
	end
	
	if element and element:getData("ped:blocodedinheiro") and not iniciou then 
	
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
			if not exports['bgo_items']:hasItem(localPlayer, 230) then
			triggerEvent("bgo>info", localPlayer,"Bloco de Dinheiro!", "Você não tem blocos de dinheiro irmão!", "info")
			return
			end
			
				triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 20000, true, false, false)
				triggerEvent("progressService", localPlayer, 20, "#ffffffPegando dinheiro sujo!!")
				iniciou = true
				bloqueio = true
				
				setTimer(function()
				iniciou = false
				bloqueio = false
				triggerServerEvent("bgoMTA->#blocodedinheiro", localPlayer, localPlayer)
				end,20000,1)
				elements = element
		end
	end
	end
end
)




