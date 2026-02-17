-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
local list = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CORDENADAS DAS ARVORES
-----------------------------------------------------------------------------------------------------------------------------------------
local arvores = {
	[1] = { 2162.2795410156,-2058.4233398438,7.984375 },
	[2] = { 2140.5166015625,-2038.6884765625,7.984375 },
	[3] = { 2144.5251464844,-2028.3121337891,7.984375},
	[4] = { 2129.6010742188,-2019.0562744141,7.984375},
	[5] = { 2135.4870605469,-2016.2955322266,7.984375},
	[6] = { 2137.3466796875,-2021.9177246094,7.984375 },
	[7] = { 2150.4079589844,-2034.6899414063,7.984375 },
	[8] = { 2148.279296875,-2045.7225341797,7.984375 },
	[9] = { 2174.9716796875,-2070.3984375,7.984375 },
	[10] = { 2187.00390625,-2082.5944824219,7.984375 },
		[11] = {2176.2080078125,-2058.8474121094,7.984375},
		
		[12] = {2169.5187988281,-2053.7485351563,7.984375},
	[13] = {2182.4992675781,-2072.1091308594,7.984375},
	[14] = {2194.1591796875,-2089.5590820313,7.984375},
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
local screenSize = Vector2(guiGetScreenSize())

local tem = false
local tem2 = false
local processo = false	



function funcao()
	while true do
		Wait(1)

		if not processo then
			--for i,func in pairs(arvores) do
			for i = 1, #arvores do
			

	 
	 
				local ped = localPlayer
				x2, y2, z2 = getElementPosition ( ped )
				x3,y3,z3 = arvores[i][1], arvores[i][2], arvores[i][3] --getElementPosition ( func[1] )
				local distancia = getDistanceBetweenPoints3D ( x3,y3,z3, x2, y2, z2 )
				if distancia <= 50 and list[i] == nil then

	local time = getRealTime()
	local hours = time.hour
	 if hours < 19 then
	 exports.bgo_Symbol:removeSymbol("lixo"..i.."")

		 return
	 end
	 if hours > 21 then
	 exports.bgo_Symbol:removeSymbol("lixo"..i.."")

		 return
	 end

				exports.bgo_Symbol:addSymbol("lixo"..i.."", arvores[i][1], arvores[i][2], arvores[i][3]+0.1, "farmer", false, 0, true, 20)
				
				
					if distancia <= 2.2 then

				local texto = Vector2(screenSize.x/1, screenSize.y/0.96)
				dxDrawText("Pressione 'E' para vasculhar o lixo", Vector2(screenSize.x/1.001, screenSize.y/0.96), 2, 0, tocolor(0,0,0, 255), 2, "default", "center", "center", false, false, false, false)
				dxDrawText("Pressione 'E' para vasculhar o lixo", texto, 2, 0, tocolor(255,255,255, 255), 2, "default", "center", "center", false, false, false, false)
	
					
						if getKeyState( "e" ) == true then
						if not processo then
								list[i] = true
								processo = true

								exports.bgo_Symbol:removeSymbol("lixo"..i.."")
								setElementFrozen(localPlayer, true)	
								

								setElementPosition(ped,arvores[i][1], arvores[i][2], arvores[i][3])
								
								triggerServerEvent("Lixao_setPedAnim",localPlayer, localPlayer)
								setPedAnimation(localPlayer, "BOMBER", "BOM_Plant", 10000, true, false, false)
								
								setElementData(localPlayer, "Exercicio", true)
								
								segundos = 6
								
								triggerEvent( "progressService",localPlayer,  5, "#ffffffVasculhando o lixo "..i.." ")
							end
							end
					end
				end		
			end
		end
		if processo then
		setElementFrozen(localPlayer, true)	
		end
	end
end
--addEventHandler ( "onClientRender", root, funcao)


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
	
	{25,"item"},
		{50,"hp"},
	{38,"item"},
	{88,"item"},
}




function segundo()
	while true do
		Wait(1000)
		if processo then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					tem2 = false
					segundos = 0
					local randomcucc = math.random(1,#randoms)
					local a = math.random(15,30)
					local randomok = math.random(1,a)
					if randomok == 3 then
					if randoms[randomcucc][2] == "item" then
					outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você encontrou com sucesso um: #4183d7".. exports["bgo_items"]:getItemName(randoms[randomcucc][1]).. ".",255,0,0,true)
					triggerServerEvent("giveitemLixao",localPlayer, localPlayer, randoms[randomcucc][1],1)
					elseif randoms[randomcucc][2] == "dinheiro" then
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você encontrou com sucesso algum dinheiro #4183d7R$: ".. randoms[randomcucc][1] ..".",255,0,0,true)
					elseif randoms[randomcucc][2] == "hp" then
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você furou a mão em algo enferrujado e perdeu #D75656-".. randoms[randomcucc][1] .." #ffffffhp.",255,0,0,true)
						setElementHealth(localPlayer,getElementHealth(localPlayer)-randoms[randomcucc][1])
					end
					else
						outputChatBox("#c0c0c0[Lixão]:#FFFFFF Você não encontrou nada.",255,255,255,true)
						processo = false
					end
					
						
					--toggleAllControls (true ) 
					processo = false
					setPedAnimation(localPlayer)
					triggerServerEvent("Lixao_stopPedAnim",localPlayer, localPlayer)
					setElementData(localPlayer, "Exercicio", false)
					setElementFrozen(localPlayer, false)
					
				end
			end
		end
	end
end

--addEventHandler ( "onClientRender", root,segundo) 


function tempo()
	while true do
		Wait(300000)
		tem = false
		list = {}
	end
end
--addEventHandler ( "onClientRender", root, tempo) 






function callFunctionWithSleeps(calledFunction, ...) 
    local co = coroutine.create(calledFunction) --we create a thread 
    coroutine.resume(co, ...) --and start its execution 
end 
  
function Wait(time) 
    local co = coroutine.running() 
    local function resumeThisCoroutine() --since setTimer copies the argument values and coroutines cannot be copied, co cannot be passed as an argument, so we use a nested function with co as an upvalue instead 
        coroutine.resume(co) 
    end 
    setTimer(resumeThisCoroutine, getTime() + time, 1) --we set a timer to resume the current thread later 
    coroutine.yield() --we pause the execution, it will be continued when the timer calls the resume function 
end 


addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
     callFunctionWithSleeps(funcao)
	callFunctionWithSleeps(segundo) 
	callFunctionWithSleeps(tempo) 
	
setElementData(localPlayer, "Exercicio", false)
setElementFrozen(localPlayer, false)
    end
);


