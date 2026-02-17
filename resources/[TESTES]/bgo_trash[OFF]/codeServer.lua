--kukaterulet = createColSphere(-1003.292, -1600.691, 76.374,25)

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


function hill_Enter ( thePlayer, matchingDimension )
     local time = getRealTime()
     local hours = time.hour
	 if getElementType ( thePlayer ) == "player" then
		--local theTime = getTimeServer()
		if hours < 21 then
			 exports.bgo_info:addNotification(thePlayer,"[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
			 return
		 end
		if hours > 22 then
			 exports.bgo_info:addNotification(thePlayer,"[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
			 return
		 end
		exports.bgo_info:addNotification(thePlayer,"Digite /lixao para vasculhar o lixo","info")
		outputChatBox("#c0c0c0[Lixão]: #ffffffDigite /lixao para vasculhar o lixo!",thePlayer,255,0,0,true)
	end
end
addEventHandler ( "onColShapeHit", kukaterulet, hill_Enter )

for k,v in ipairs(getElementsByType("player")) do
	setElementData(v,"turkalascucc",1)
	setElementData(v,"trukalas",0)
end

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

function turkal3(player)
	local time = getRealTime()
	local hours = time.hour
	 if hours < 21 then
		 exports.bgo_info:addNotification(player,"[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
		 return
	 end
	 if hours > 22 then
		 exports.bgo_info:addNotification(player,"[BGO ERROR]: Horário disponivel do lixão: (21 Hrs ás 23 Hrs).","info")
		 return
	 end

	if getElementData(player,"char:adminduty") == 0 then
		if getElementData(player,"consoleTyping") then 		
			return 
		end
		if not isPedInVehicle(player) then 
			if isElementWithinColShape(player,kukaterulet) then
				
				if getElementData(player,"trukalas") == 1 then
					return
				end
				exports.global:sendLocalMeAction(player,"Começou a vasculhar o lixo!")
				setElementFrozen(player, true)
				setPedAnimation(player, "BOMBER", "BOM_Plant", -1, true, false, false)			
				
				--toggleAllControls(true, true, false)
				
				setElementData(player,"trukalas",1)
				theTimer = setTimer(function()
					setElementData(player,"trukalas",0)
				end,6000,1)
				setTimer(function()
					setElementFrozen(player, false)
					setPedAnimation(player)
					local randomcucc = math.random(1,#randoms)
					local a = math.random(15,30)
					local randomok = math.random(1,a)
					if randomok == 3 then
					if randoms[randomcucc][2] == "item" then
					outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você encontrou com sucesso um: #4183d7".. exports["bgo_items"]:getItemName(randoms[randomcucc][1]).. ".",player,255,0,0,true)


					--exports.bgo_chat:sendLocalMeAction(player," Encontrei um item: ".. exports["bgo_items"]:getItemName(randoms[randomcucc][1]))

				exports.global:giveItem(player,randoms[randomcucc][1],1)
					
					setElementData(player,"char >> showedItem",{true,randoms[randomcucc][1],exports.bgo_items:getItemName(randoms[randomcucc][1]),exports.bgo_items:getItemDescription(randoms[randomcucc][1]),getTickCount()})
					setTimer(function(player)
					setElementData(player,"char >> showedItem",{false,nil,nil,nil,nil})
					end,5000,1, player)
					
					
					elseif randoms[randomcucc][2] == "penz" then
						--exports.bgo_chat:sendLocalMeAction(player,"Encontrou algum dinheiro (R$: ".. randoms[randomcucc][1] ..")")
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você encontrou com sucesso algum dinheiro #4183d7R$: ".. randoms[randomcucc][1] ..".",player,255,0,0,true)
						--givePlayerMoney(player,randoms[randomcucc][1])
					elseif randoms[randomcucc][2] == "hp" then
						--exports.bgo_chat:sendLocalMeAction(player,"Furou a mão em algo enferrujado e perdeu -".. randoms[randomcucc][1] .." de Vida")
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você furou a mão em algo enferrujado e perdeu #D75656-".. randoms[randomcucc][1] .." #ffffffhp.",player,255,0,0,true)
						setElementHealth(player,getElementHealth(player)-randoms[randomcucc][1])
					end
					else
						--exports.bgo_chat:sendLocalMeAction(player,"não encontrou nada")
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você não encontrou nada.",player,255,255,255,true)
					end
				end,5000,1)
			else
			--	outputChatBox("#c0c0c0[Lixão]:#FFFFFF !",player,255,255,255,true)
			--	exports.bgo_info:addNotification(player," ","error")
			end
		else
			outputChatBox("#c0c0c0[Lixão]:#FFFFFFVocê não pode andar desse jeito!",player,255,255,255,true)
		end	
	else
		outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você é um admin seu retardado! sai do serviço para poder usar está função!",player,255,0,0,true)
	end	
end
addCommandHandler("lixao",turkal3)




addEventHandler( "onResourceStop", root,
	function()
		local players = getElementsByType ( "player" ) -- get a table of all the players in the server
	for theKey,player in ipairs(players) do
		setElementFrozen(player, false)
		setPedAnimation(player)
		setElementData(player,"trukalas",0)
	end
    end
)