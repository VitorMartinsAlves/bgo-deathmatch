local renderData = {}

local skinID = 26
local panelState = false
local doingDrive = false 

renderData.sWidth, renderData.sHeight = guiGetScreenSize()
renderData.wWidth, renderData.wHeight = renderData.sWidth / 2 - 369.5, renderData.sHeight / 2 - 154.5

local panelFont = dxCreateFont("files/calibri.ttf", 20)

--útvonal
local route = {}
route[1] = { 2434.02734375,-2072.0981445313,12.928670883179 } -- 1
route[2] = { 2415.5324707031,-2081.0671386719,12.768716812134 }	-- 2
route[3] = { 2416.1008300781,-2000.7106933594,12.783744812012 }	-- 3
route[4] = { 2399.5590820313,-1970.8562011719,13.390551567078 }		-- 4   
route[5] = { 2315.979, -1957.645, 13.386 }		-- 5
--route[5] = { 2221.019, -1882.52, 13.391 }		-- 6
route[6] = { 2221.019, -1882.52, 13.391 }		-- 7   
route[7] = { 2228.157, -1664.443, 15.175 }	-- 8   TROCAR
route[8] = { 2205.103, -1618.4, 16.82 }	-- 9
route[9] = { 2225.157, -1385.77, 23.843}	-- 10
route[10] = { 2373.108, -1368.636, 23.844 }	-- 11
route[11] = { 2386.165, -1175.005, 27.884 }	-- 12
route[12] = { 2584.088, -1185.417, 61.862 }	-- 13
route[13] = { 2721.32, -1198.702, 68.396 }	-- 14
route[14] = { 2720.944, -1432.239, 30.313 }	-- 15
route[15] = { 2752.663, -1490.108, 29.876 }	-- 16 
route[16] = { 2868.517, -1503.748, 10.868 }	-- 17 
route[17] = { 2822.066, -1645.721, 10.715 }	-- 18
route[18] = { 2849.449, -1676.045, 10.884 }	-- 19
route[19] = { 2820.735, -1904.586, 10.949 }	-- 20
route[20] = { 2820.397, -2063.804, 10.938 }	-- 21
route[21] = { 2716.379, -2141.826, 10.903 }	-- 22
route[22] = { 2699.192, -2047.174, 13.297 }	-- 23
route[23] = { 2275.5, -2068.824, 13.393 }	-- 24
route[24] = { 2216.083, -1959.124, 13.362 }	-- 25
route[25] = { 2230.732, -1750.924, 13.402 }	-- 26
route[26] = { 2411.628, -1763.813, 13.401 }	-- 27
route[27] = { 2397.745, -2075.612, 13.523 }	-- 28
route[28] = { 2397.745, -2075.612, 13.523 }	-- 28
route[29] = { 2397.745, -2075.612, 13.523 }	-- 28

renderData.routeCounter = 1


generatedQuestion = 0
--jelenlegi kérdés index. 


local questions = {
	{"É permitido estacionar no estacionamento de taxi?", "Não", "Sim", "Se eu quiser", 1, false}, -- 1
	{"Você pode correr em alta velocidade pela cidade?", "Se eu quiser", "Não", "Sim", 2, false}, -- 2
	{"Ao estacionar o carro em uma rua, você deve:", "Ligar o pisca alerta", "Desligar o carro", "Buzinar", 1, false}, -- 3
	{"Sempre atravesse o sinal vermelho. Esta informção é...", "Neutra", "Falsa", "Verdadeira", 2, false}, -- 4
	{"Você sempre precisa renovar sua habilitação para dirigir?", "Sim", "Não", "Se eu quiser", 1, false}, -- 5
	{"As avenidas são locais de racha?", "Não", "Sim", "Só a noite", 1, false}, -- 6
	{"Você pode dirigir embriagado pela cidade?", "Se for policial, sim", "Sim", "Não", 3, false}, -- 7
	{"Qual é o sinônimo de drift?", "É o Toretto!", "É o BamBam!", "É o Braia!", 3, false}, -- 8
	{"Você pode parar o veículo em qualquer lugar da cidade?", "Sim", "Não", "Talvez", 2, false}, -- 9
	{"Você deve atravessar cruzamentos em alta velocidade. Esta informação é...", "Neutra", "Falsa", "Verdadeira", 2, false}, -- 10
} 

addEventHandler("onClientResourceStart", getResourceRootElement(), 
	function() 
		
		local drivingLicensePed = createPed(skinID, 2458.5913085938,-2089.6782226563,13.546875)
		setPedRotation( drivingLicensePed,  90 )
		setElementDimension( drivingLicensePed, 0 )
		setElementInterior( drivingLicensePed , 0 )
		setElementData(drivingLicensePed, "quest:ped", true)
		setElementData(drivingLicensePed, "drivingLicense", true)
		setElementData(drivingLicensePed, "Ped:Name", "Habilitação")
		setElementFrozen(drivingLicensePed,true)
	end
)

function renderPanel()
	if panelState then

		dxDrawRectangle(renderData.wWidth, renderData.wHeight+30, 739, 250, tocolor(0, 0, 0, 150), false)
		dxDrawRectangle(renderData.wWidth, renderData.wHeight+30, 739, 40, tocolor(0, 0, 0, 200), false)
		dxDrawRectangle(renderData.wWidth + 65, renderData.wHeight + 220, 150, 40, tocolor(124, 197, 118, 150), false)
		dxDrawRectangle(renderData.wWidth + 295, renderData.wHeight + 220, 150, 40, tocolor(124, 197, 118, 150), false)
		dxDrawRectangle(renderData.wWidth + 525, renderData.wHeight + 220, 150, 40, tocolor(124, 197, 118, 150), false)
		dxDrawRectangle(renderData.wWidth + 708, renderData.wHeight - 5, 30, 30, tocolor(215, 85, 85, 150), false)
		

		dxDrawText("BGO Auto-Escola", renderData.wWidth + 372, renderData.wHeight + 32, renderData.wWidth + 372, renderData.wHeight + 17, tocolor(0, 0, 0), 1, panelFont, "center", "top", false, false, true, true)
		dxDrawText("#7cc576BGO #ffffffMTA #7cc576Auto #ffffffEscola", renderData.wWidth + 370, renderData.wHeight + 30, renderData.wWidth + 370, renderData.wHeight + 15, tocolor(255, 255, 255, 225), 1, panelFont, "center", "top", false, false, true, true)
		dxDrawText("X", renderData.wWidth + 1075, renderData.wHeight - 8, renderData.wWidth + 372, renderData.wHeight + 17, tocolor(255, 255, 255), 1, panelFont, "center", "top", false, false, true, true)
		dxDrawText("A obtenção de uma carteira de motorista requer um total de R$:1.000!\n Todos os exames errados custam R$: 500!", renderData.wWidth + 371, renderData.wHeight + 281, renderData.wWidth + 371, renderData.wHeight + 16, tocolor(0, 0, 0), 0.6, panelFont, "center", "top", false, false, true, true)
		dxDrawText("A obtenção de uma carteira de motorista requer um total de R$:1.000!\n Todos os exames errados custam R$: 500!", renderData.wWidth + 370, renderData.wHeight + 280, renderData.wWidth + 370, renderData.wHeight + 15, tocolor(255, 0, 0, 225), 0.6, panelFont, "center", "top", false, false, true, true)

	
	--	dxDrawText("Kérdés: \n"..questions[generatedQuestion][1], renderData.wWidth + 372, renderData.wHeight + 102, renderData.wWidth + 372, renderData.wHeight + 102, tocolor(0, 0, 0), 0.6, panelFont, "center", "top", false, false, true)
		dxDrawText("#FFA700Questão: \n#ffffff"..questions[generatedQuestion][1], renderData.wWidth + 370, renderData.wHeight + 100, renderData.wWidth + 370, renderData.wHeight + 100, tocolor(255, 255, 255, 225), 0.6, panelFont, "center", "top", false, false, true, true)
		
		dxDrawText(questions[generatedQuestion][2], renderData.wWidth + 142, renderData.wHeight + 232, renderData.wWidth + 142, renderData.wHeight + 232, tocolor(0, 0, 0), 0.5, panelFont, "center", "top", false, false, true)
		dxDrawText(questions[generatedQuestion][2], renderData.wWidth + 140, renderData.wHeight + 230, renderData.wWidth + 140, renderData.wHeight + 230, tocolor(255, 255, 255, 225), 0.5, panelFont, "center", "top", false, false, true)
	
		dxDrawText(questions[generatedQuestion][3], renderData.wWidth + 372, renderData.wHeight + 232, renderData.wWidth + 372, renderData.wHeight + 232, tocolor(0, 0, 0), 0.5, panelFont, "center", "top", false, false, true)
		dxDrawText(questions[generatedQuestion][3], renderData.wWidth + 370, renderData.wHeight + 230, renderData.wWidth + 370, renderData.wHeight + 230, tocolor(255, 255, 255, 225), 0.5, panelFont, "center", "top", false, false, true)
		
		dxDrawText(questions[generatedQuestion][4], renderData.wWidth + 602, renderData.wHeight + 232, renderData.wWidth + 602, renderData.wHeight + 232, tocolor(0, 0, 0), 0.5, panelFont, "center", "top", false, false, true)
		dxDrawText(questions[generatedQuestion][4], renderData.wWidth + 600, renderData.wHeight + 230, renderData.wWidth + 600, renderData.wHeight + 230, tocolor(255, 255, 255, 225), 0.5, panelFont, "center", "top", false, false, true)
		
	end 
end

local startedName = false
addEventHandler("onClientClick", getRootElement(), 
	function(button, state, x, y, wx, wy, wz, element) 
		if button and state and state == "down" and isElement(element) and getElementData(element, "drivingLicense") and not panelState and not doingDrive then

			--if getElementData(localPlayer, "license.car") == 1 then exports['bgo_info']:createDebugNotification("Você já tem uma licença!", 1) return end

			if exports.bgo_items:hasItem(localPlayer,28) then exports['bgo_info']:createDebugNotification("Você já tem uma licença!", 1) return end


				if getElementData(localPlayer, "char:money") >= 1 then
					addEventHandler("onClientRender", getRootElement(), renderPanel)
					panelState = true 
					generateQuestion()
					exports.bgo_info:addNotification("O dinheiro será deduzido apenas no final do teste!", "info")
					exports['bgo_info']:createDebugNotification("Responda as perguntas!", 1)
					--startedName = getElementData(localPlayer, "char:Name")
					startedName = getPlayerName(localPlayer)
				else 
					exports['bgo_info']:createDebugNotification("Você não tem dinheiro suficiente para começar!", 1)
				end

		end 

		if button and state == "down" and panelState then
			if x >= renderData.wWidth + 40 and x <= renderData.wWidth + 250 then
				if y >= renderData.wHeight + 220 and y <= renderData.wHeight + 271 then
					processAnswering(1)
				end 
			end 

			if x >= renderData.wWidth + 270 and x <= renderData.wWidth + 480 then
				if y >= renderData.wHeight + 220 and y <= renderData.wHeight + 271 then
					processAnswering(2)
				end 
			end 

			if x >= renderData.wWidth + 500 and x <= renderData.wWidth + 710 then
				if y >= renderData.wHeight + 220 and y <= renderData.wHeight + 271 then
					processAnswering(3)
				end 
			end 

			if x >= renderData.wWidth + 708 and x <= renderData.wWidth + 800 then
				if y >= renderData.wHeight + 15 and y <= renderData.wHeight + 55 then
					closePanel()
				end 
			end 
		end 
	end 

)

oldBlip = false
currentMarker = 1

function nextMarker()

	currentMarker = currentMarker + 1
	for k, v in pairs(getElementsByType("marker")) do 
		if getElementData(v, "license") then
			destroyElement(v)
		end 
	end

	for k, v in pairs(getElementsByType("blip")) do 
		if getElementData(v, "license") then
			destroyElement(v)
		end 
	end


	if currentMarker < 28 then
		local startMarker = createMarker(route[currentMarker][1], route[currentMarker][2], route[currentMarker][3], "checkpoint", 4, 124, 197, 118, 255)
		
		setMarkerTarget(startMarker,route[currentMarker+1][1], route[currentMarker+1][2], route[currentMarker+1][3])
		
		--triggerServerEvent("setaInfor", root, localPlayer, route[currentMarker][1], route[currentMarker][2], route[currentMarker][3])
		local oldBlip = createBlip(route[currentMarker][1], route[currentMarker][2], route[currentMarker][3], 0, 2, 255, 0, 255, 255) -- 54, 1
		setElementData(startMarker, "license", true)
		setElementData(startMarker, "name", "Checkpoint")
		setElementData(oldBlip, "license", true)

		addEventHandler("onClientMarkerHit", startMarker, 
			function(hitPlayer)
				if hitPlayer == localPlayer then 
					nextMarker()
					playSoundFrontEnd(12)
				end 
			end
		)
	else 
		finishLicense()
	end
end

local characters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y"}
function createNewKey(size)
	local code = math.random(100, 500)
	for i = 1, size do
		a = math.random(1,#characters)
		x=string.upper(characters[a])
		code = code .. x
	end
	return code
end

local monthDays = {
	[1] = 31, -- jan
	[2] = 28, -- feb
	[3] = 31, -- márc
	[4] = 30, -- ápr
	[5] = 31, -- máj
	[6] = 30, -- jún
	[7] = 31, -- júl
	[8] = 31, -- aug
	[9] = 30, -- szept
	[10] = 31, -- okt
	[11] = 30, -- nov
	[12] = 31, -- dec
}



function generateDate(year,month,day)
	local realTime = getRealTime()
	local year, month, day = year or realTime.year + 1900, month or realTime.month + 1, day or realTime.monthday
	if day+28 > monthDays[month] then
		if month+1 > 12 then
			year = year + 1
			month = month - 11
		else
			month = month + 1
		end
	else
		day = day + 28
	end
	if day > monthDays[month] then
		day = monthDays[month]
	elseif month > 12 then
		month = 12
	end
	if month < 10 then
		month = "0"..month
	end
	if day < 10 then
		day = "0"..day
	end
	return year.."."..month.."."..day.."."
end


function finishLicense()
	triggerServerEvent("finishLicense", getRootElement(), localPlayer)
	exports.bgo_info:addNotification("Parabéns, você liberou sua licença com sucesso.", "info")
	currentMarker = 1
	renderData.routeCounter = 1
	generatedQuestion = 0	
	setElementData(localPlayer, "license.car", 1)
	triggerServerEvent("giveJogsi",localPlayer,localPlayer,getPlayerName(localPlayer):gsub("_"," "),createNewKey(4),getElementModel(localPlayer),generateDate())
	doPay(2)
	for k, v in pairs(getElementsByType("blip")) do
		if getElementData(v, "license") then
			destroyElement(v)
		end 
	end 
	for k, v in pairs(getElementsByType("marker")) do
		if getElementData(v, "license") then
			destroyElement(v)
		end 
	end
	--exports['bgo_items']:giveItem(source, 54, 1, 1, 1, false)
end

local counter = 0
function generateQuestion()
	if panelState then
		
		counter = counter + 1
		
		if counter < 10 then
			repeat
				generatedQuestion = generatedQuestion + 1 --math.random(10)
			until not questions[generatedQuestion][12]		
		else 

		end 
	end 
end

local totalPoints = 0

function processAnswering(number)
	if panelState and number then
		if tonumber(number) == tonumber(questions[generatedQuestion][5]) then
			totalPoints = totalPoints + 10
		--	playSoundFrontEnd(40)	
		--else 
		--	playSoundFrontEnd(4)		
		end 
		--outputChatBox(totalPoints)
		questions[generatedQuestion][8] = true
		if counter < 10 then
			generateQuestion()
		else 
			
			if totalPoints >= 50 then
				if totalPoints >= 100 then
					exports['bgo_info']:createDebugNotification("Parabéns passou no exame de sucesso!", 1)
				else
					exports['bgo_info']:createDebugNotification("Você teve alguns erro, mas o exame foi bem sucedido!", 1)
				end
				exports.bgo_info:addNotification("Vá até o marcador e siga pela rota selecionada!", "info")
				local startingMarker = createMarker(route[1][1], route[1][2], route[1][3], "checkpoint", 4, 255, 0, 0, 255)
				local startingBlip = createBlip(route[1][1], route[1][2], route[1][3], 0, 2, 255, 0, 255, 255) -- 54, 1
				setElementData(startingMarker, "license", true)
				setElementData(startingMarker, "name", "Checkpoint")
				setElementData(startingBlip, "license", true)
				doPay(1)
				removeEventHandler("onClientRender", getRootElement(), renderPanel)
				totalPoints = 0
				panelState = false
				doingDrive = true

				addEventHandler("onClientMarkerHit", startingMarker, 
					function(hitPlayer)
						if hitPlayer == localPlayer then
							triggerServerEvent("createLicenseVehicle", getRootElement(), localPlayer)
							nextMarker()
						end
					end 
				)
		else
				exports['bgo_info']:createDebugNotification("Desculpe, não pude tentar novamente!", 1)
				removeEventHandler("onClientRender", getRootElement(), renderPanel)
				totalPoints = 0
				panelState = false
				doingDrive = false
			end 
		end 
	end
end

function doPay(num)
	if num then
		if num == 1 then
			
			if getElementData(localPlayer, "char:money") >= 1 then
				setElementData(localPlayer, "char:money", getElementData(localPlayer, "char:money") - 1000)
			else 
			--	exports.bgo_info:addNotification("Nincs elég pénzed.", "error")
				exports['bgo_info']:createDebugNotification("Você não tem dinheiro suficiente!", 1)
			end 

		elseif num == 2 then
			
			if getElementData(localPlayer, "char:money") >= 1 then
				setElementData(localPlayer, "char:money", getElementData(localPlayer, "char:money") - 500)
			else 
				--exports.bgo_info:addNotification("Nincs elég pénzed.", "error")
				exports['bgo_info']:createDebugNotification("Você não tem dinheiro suficiente!", 1)
			end			
		end 
	end 
end 

function closePanel()
	if panelState then
		panelState = false
		removeEventHandler("onClientRender", getRootElement(), renderPanel)
		currentMarker = 1
		renderData.routeCounter = 1
		generatedQuestion = false
		counter = 0

		
		local questions = {
			--{"Pode usar um farol em vez de uma luz de cruzamento se \num farol pode ofuscar o condutor de um veículo que percorre a via navegável paralela à estrada?", "Igen", "Nem", "Éjszaka", 2, false}, -- 1
			--{"Vezethet-e gépjárművet az a személy, akit a vezetéstől jogerős bírói ítélettel eltiltottak, de \nvezetői engedélyét még nem adta le?", "Nem", "Igen", "Józanul igen", 1, false}, -- 2
			--{"Szabad-e hátramenetet végezni autópályán, illetve autóúton?", "Igen", "Utánfutó nélkül igen", "Nem", 3, false}, -- 3
			--{"Szabad-e elakadés jelzőt használni lakott területen belül?", "Igen", "Indokolt esetben", "Nem", 2, false}, -- 4
			{"Você pode andar pelo túnel como um pedestre?", "Não", "Sim", "Sim durante o dia", 1, false}, -- 5
			{"Você precisa marcar a carga que está sobre o veículo?", "Sim, em qualquer caso", "A mais de 40 cm", "Apenas no escuro", 1, false}, -- 6
			{"É obrigatório cumprir as instruções da polícia?", "Não", "Sim", "Onde apropriado, não", 2, false}, -- 7
			{"Você pode andar com seu carro se detectar uma falha no motor?", "Sim", "Se sim, sim", "não", 3, false}, -- 8
			{"É prioridade para um pedestre que passa pela área designada?", "Sim", "Não", "Se você vem de um emprego, não", 1, false}, -- 9
			{"Você deve usar um sinal de direção quando for fazer a estrada à esquerda e à direita?", "Não", "Sim", "a mesma coisa", 2, false}, -- 10
			{"Você pode dar um sinal sonoro para indicar sua intenção de escapar?", "Se for policia, sim", "Sim", "Não", 3, false}, -- 11
			{"O que fazer se você ver um homem deitado na beira da estrada?", "ajudar", "Continuar", "Chamar socorro", 1, false}, -- 12
			--{"Onde você pode sair da estrada?", "acostamento", "Você não pode voltar", "em qualquer lugar", 2, false}, -- 13
			{"Você pode forçar alguém a parar de frear?", "Não", "Sim", "Sim, Se você for policial", 1, false}, -- 14
			{"É um dever usar o cinto de segurança?", "Apenas em uma área residencial", "Sim, Se você ver um policial", "Sim", 3, false}, -- 15
		} 

	end 
end




function finishLicense2()
	triggerServerEvent("finishLicense", getRootElement(), localPlayer)
	exports.bgo_info:addNotification("VOCÊ FALHOU NO EXAME.", "info")
	--panelState = false
	doingDrive = false

	panelState = false
	removeEventHandler("onClientRender", getRootElement(), renderPanel)
	currentMarker = 1
	renderData.routeCounter = 1
	generatedQuestion = false
	counter = 0
	setElementData(localPlayer, "license.car", 1)
	local x, y, z = getElementPosition(localPlayer)
	triggerServerEvent("setaInfor", root, localPlayer, x, y, z)
	for k, v in pairs(getElementsByType("blip")) do
		if getElementData(v, "license") then
			destroyElement(v)
		end 
	end 
	for k, v in pairs(getElementsByType("marker")) do
		if getElementData(v, "license") then
			destroyElement(v)
		end 
	end
end
addEvent("finishLicense2", true)
addEventHandler("finishLicense2", getRootElement(), finishLicense2)