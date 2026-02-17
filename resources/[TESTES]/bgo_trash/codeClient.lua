function checkForConsole()
	if isConsoleActive() then
		setElementData(getLocalPlayer(), "consoleTyping", true)	
	elseif not isConsoleActive() then
		setElementData(getLocalPlayer(), "consoleTyping", false)
	end
end
setTimer ( checkForConsole, 100, 0 )




addEventHandler ("onClientKey", getRootElement(), function (button, state)
	if not state then return end
	if not getElementData (localPlayer, "bindPermission") then
		local keys = getBoundKeys ("lixao") -- Obtém uma lista com todas as teclas com binds deste comando.
		if keys then
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








--kukaterulet = createColCuboid(-1038.35449, -1626.14758, 73.78632, 75.851806640625, 51.164184570313, 22.9)
kukaterulet = createColCuboid(-1038.39160, -1626.39221, 73.66710, 75.868530273438, 51.463134765625, 3.2998718261719)

local randoms = {
	{20,"hp"},
	{1,"item"},
	{160,"item"},
	{2,"item"},
	{3,"item"},
		{50,"hp"},
	{161,"item"},
	{4,"item"},
	{162,"item"},
	{5,"item"},
	{6,"item"},
	{163,"item"},
	{7,"item"},
	{8,"item"},
	{164,"item"},
	{9,"item"},
	{10,"item"},
	{165,"item"},
	{11,"item"},
	{13,"item"},
	{166,"item"},
		{80,"hp"},
	{20,"item"},
	{25,"item"},
	{167,"item"},
	{38,"item"},
	{88,"item"},
	{168,"item"},
	{1,"item"},
	{2,"item"},
	{169,"item"},
	{3,"item"},
	{4,"item"},
	{170,"item"},
	{5,"item"},
	{6,"item"},
	{171,"item"},
		{40,"hp"},
	{7,"item"},
	{8,"item"},
	{172,"item"},
	{9,"item"},
	{10,"item"},
	{173,"item"},
	{11,"item"},
	{13,"item"},
	{174,"item"},
	{20,"item"},
	{25,"item"},
	{175,"item"},
	{38,"item"},
	{176,"item"},
	{88,"item"},
	{1,"item"},
	{177,"item"},
	{2,"item"},
	{3,"item"},
	{178,"item"},
	{4,"item"},
		{20,"hp"},
	{5,"item"},
	{179,"item"},
	{6,"item"},
	{7,"item"},
	{180,"item"},
	{8,"item"},
	{9,"item"},
	{181,"item"},
	{10,"item"},
	{11,"item"},
	{182,"item"},
	{13,"item"},
	{183,"item"},
	{20,"item"},
	{184,"item"},
	{25,"item"},
		{20,"hp"},
	{38,"item"},
	{185,"item"},
	{88,"item"},
	{1,"item"},
	{186,"item"},
	{2,"item"},
	{3,"item"},
	{188,"item"},
	{4,"item"},
	{187,"item"},
	{5,"item"},
	{6,"item"},
	{189,"item"},
	{7,"item"},
	{8,"item"},
	{190,"item"},
	{9,"item"},
	{10,"item"},
	{191,"item"},
	{11,"item"},
	{13,"item"},
	{192,"item"},
	{20,"item"},
	{25,"item"},
	{193,"item"},
	{38,"item"},
	{194,"item"},
		{20,"hp"},
	{88,"item"},
	{1,"item"},
	{195,"item"},
	{2,"item"},
	{3,"item"},
	{196,"item"},
	{4,"item"},
	{198,"item"},
	{5,"item"},
	{197,"item"},
	{6,"item"},
	{200,"item"},
	{7,"item"},
	{199,"item"},
	{8,"item"},
	{202,"item"},
	{9,"item"},
	{201,"item"},
	{10,"item"},
	{203,"item"},
	{11,"item"},
	{13,"item"},
	{204,"item"},
	{20,"item"},
	{25,"item"},
	{205,"item"},
	{38,"item"},
	{88,"item"},
	{206,"item"},
	{1,"item"},
		{20,"hp"},
	{2,"item"},
	{207,"item"},
	{3,"item"},
	{4,"item"},
	{208,"item"},
	{5,"item"},
	{6,"item"},
	{210,"item"},
	{7,"item"},
	{209,"item"},
	{8,"item"},
	{9,"item"},
		{80,"hp"},
	{211,"item"},
	{10,"item"},
	{11,"item"},
	{212,"item"},
	{13,"item"},
	{20,"item"},
	{213,"item"},
	{25,"item"},
	{38,"item"},
		{20,"hp"},
	{214,"item"},
	{88,"item"},
	{1,"item"},
	{2,"item"},
	{3,"item"},
	{4,"item"},
	{5,"item"},
		{20,"hp"},
	{6,"item"},
	{7,"item"},
	{8,"item"},
	{9,"item"},
	{10,"item"},
	{11,"item"},
	{13,"item"},
	{20,"item"},
	{25,"item"},
		{30,"hp"},
	{38,"item"},
	{88,"item"},
	{1,"item"},
	{2,"item"},
	{3,"item"},
	{4,"item"},
	{5,"item"},
	{6,"item"},
	{7,"item"},
	{8,"item"},
	{9,"item"},
	{10,"item"},
		{20,"hp"},
	{11,"item"},
	{13,"item"},
	{20,"item"},
	{25,"item"},
	{38,"item"},
	{88,"item"},
	{1,"item"},
	{2,"item"},
	{3,"item"},
	{4,"item"},
	{5,"item"},
	{6,"item"},
		{20,"hp"},
	{7,"item"},
	{8,"item"},
	{9,"item"},
	{10,"item"},
	{11,"item"},
	{13,"item"},
	{20,"item"},
	{25,"item"},
		{70,"hp"},
	{38,"item"},
	{88,"item"},
	{1,"item"},
	{2,"item"},
	{3,"item"},
	{4,"item"},
	{5,"item"},
	{6,"item"},
	{7,"item"},
	{8,"item"},
	{9,"item"},
	{10,"item"},
	{11,"item"},
		{20,"hp"},
	{13,"item"},
	{20,"item"},
	{25,"item"},
	{38,"item"},
	{88,"item"},
	{1,"item"},
	{2,"item"},
	{3,"item"},
	{4,"item"},
		{60,"hp"},
	{5,"item"},
	{6,"item"},
	{7,"item"},
	{8,"item"},
	{9,"item"},
	{10,"item"},
		{20,"hp"},
	{11,"item"},
	{13,"item"},
	{20,"item"},
	{25,"item"},
		{50,"hp"},
	{38,"item"},
	{88,"item"},
}


function hill_Enter ( thePlayer )
if ( thePlayer == localPlayer ) then
     local time = getRealTime()
     local hours = time.hour
	 --if getElementType ( thePlayer ) == "player" then
	
		if hours < 21 then
			 exports.bgo_info:addNotification("[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
			 return
		 end
		if hours > 23 then
			 exports.bgo_info:addNotification("[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
			 return
		 end
		 
		
		exports.bgo_info:addNotification("Digite /lixao para vasculhar o lixo","info")
		outputChatBox("#c0c0c0[Lixão]: #ffffffDigite /lixao para vasculhar o lixo!",255,0,0,true)
	--end
	end
end
addEventHandler ( "onClientColShapeHit", kukaterulet, hill_Enter )

function getTimeServer()
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
	if hours < 10 then
		hours = "0"..hours
	end
	if minutes < 10 then
		minutes = "0"..minutes
	end
	if seconds < 10 then
		seconds = "0"..seconds
	end
	return hours..":"..minutes..":"..seconds
end

function turkal3()

	local time = getRealTime()
	local hours = time.hour
	 if hours < 21 then
		 exports.bgo_info:addNotification("[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
		 return
	 end
	 if hours > 23 then
		 exports.bgo_info:addNotification("[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
		 return
	 end

	if getElementData(localPlayer,"char:adminduty") == 0 then
		if getElementData(localPlayer,"consoleTyping") then 		
			return 
		end
		if not isPedInVehicle(localPlayer) then 
			if isElementWithinColShape(localPlayer,kukaterulet) then
				
				if getElementData(localPlayer,"trukalas") == 1 then
					return
				end
				setElementFrozen(localPlayer, true)
				--setPedAnimation(localPlayer, "BOMBER", "BOM_Plant", -1, true, false, false)			
				
				triggerEvent( "progressService",localPlayer,  10, "#ffffffVasculhando o lixo")
				triggerServerEvent("Lixao_setPedAnim",localPlayer, localPlayer)
				
				--toggleAllControls(true, true, false)
				
				setElementData(localPlayer,"trukalas",1)
				theTimer = setTimer(function()
					setElementData(localPlayer,"trukalas",0)
				end,11000,1)
				setTimer(function()
					setElementFrozen(localPlayer, false)
					setPedAnimation(localPlayer)
					
					
					triggerServerEvent("Lixao_stopPedAnim",localPlayer, localPlayer)
					
					
					
					
					local randomcucc = math.random(1,#randoms)
					local a = math.random(15,30)
					local randomok = math.random(1,a)
					if randomok == 3 then
					if randoms[randomcucc][2] == "item" then
					outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você encontrou com sucesso um: #4183d7".. exports["bgo_items"]:getItemName(randoms[randomcucc][1]).. ".",255,0,0,true)
					
					
					--exports.global:giveItem(player,randoms[randomcucc][1],1)

					triggerServerEvent("giveitemLixao",localPlayer, localPlayer, randoms[randomcucc][1],1)
					
					elseif randoms[randomcucc][2] == "dinheiro" then
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você encontrou com sucesso algum dinheiro #4183d7R$: ".. randoms[randomcucc][1] ..".",255,0,0,true)
					elseif randoms[randomcucc][2] == "hp" then
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você furou a mão em algo enferrujado e perdeu #D75656-".. randoms[randomcucc][1] .." #ffffffhp.",255,0,0,true)
						setElementHealth(localPlayer,getElementHealth(localPlayer)-randoms[randomcucc][1])
					end
					else
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você não encontrou nada.",255,255,255,true)
					end
				end,10000,1)
			end
		else
			outputChatBox("#c0c0c0[Lixão]:#FFFFFFVocê não pode andar desse jeito!",255,255,255,true)
		end	
	else
		outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você é um admin seu retardado! sai do serviço para poder usar está função!",255,0,0,true)
	end	
end
addCommandHandler("lixao",turkal3)



addEventHandler( "onClientResourceStop", resourceRoot,
	function()
		local players = getElementsByType ( "player" ) -- get a table of all the players in the server
	for theKey,player in ipairs(players) do
	if getElementData(player,"trukalas") == 1 then
		setElementFrozen(player, false)
		setPedAnimation(player)
		setElementData(player,"trukalas",0)
	end
	end
    end
)