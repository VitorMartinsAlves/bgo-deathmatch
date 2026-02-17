function checkLogged(p)
	local isLogged = getElementData(p,"loggedin")
	if isLogged then
		return true
	else
		return false
	end
end

local adminTitle = {
	[1] = {"#ff00a0SUPORTE EM TESTE"},
	[2] = {"#2d3ceeSUPORTE"},
	[3] = {"#01f827MODERADOR"},
	[4] = {"#00dcffSUB ADMINISTRADOR"},
	[5] = {"#00ff90ADMINISTRADOR"},
	[6] = {"#999595ADMINISTRADOR GERAL"},
	[7] = {"#030303SUB GAME MASTER"},
	[8] = {"#000000GAME MASTER"},
	[9] = {"#FF0000SUPORTE DE CONTAS"},
	[10] = {"#C25151FUNDADOR"},
}



local asTitle = {
	[1] = {"Administrador Temporário -"},
	[2] = {"Assistente de administração -"},
}

function checkAdmin(p)
	local admin = getElementData(p,"acc:admin")
	if admin >= 1 then
		return true
	end
end

function isAdminDuty(p)
	local aduty = getElementData(p,"char:adminduty")
	if aduty == 1 then
		return true
	end
end

function getPlayerAdminLevel(p)
	return adminTitle[getElementData(p,"acc:admin")][1]
end

function getPlayerAsLevel(p)
	return asTitle[getElementData(p,"acc:aseged")][1]
end

function checkNagyonAdmin(p)
	local admin = getElementData(p,"acc:admin")
	if admin <= 7 then
		return true
	end
end

local youtubersEstreamers = { 
	["DF749DAC120194E1221E619D133288F4"]=true, --	ABINIS
	["4990CE3DE114CFF02BEE6FB6CE54D4A3"]=true, --	JOHNNY
	["D1C72A4976E2B72C9F00B381BC000052"]=true, --	johnny
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --	LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --	CrohsGM
	["52F3EF9012696BDDF80D8FC5DC5BF5B3"]=true, --	RUUD MTA
	["46B46D198C95471CA9DE87180ED062F4"]=true, --	MORAIS MTA
	["F07D405DD62F8ACDC2E5859D56107CA3"]=true, --	zoio
	["E672055C01AB812B5484416A1F80CE42"]=true, --	baiano
	["E53674AAAC2B1D0619D4C80FA77D53F2"]=true, --	PANDOX
	["EDE5659E2619A6CFB5EB3492F4F196B2"]=true, --	EDU_BROTHERS
	["365774517B279F8A8AC20CA57A2D11A1"]=true, --	SRPAULO
	["D6BA0AA974AA50C95810743E807DFDA4"]=true, --	PEDRAO
	["F5FB7A12D32534796C8889DD63C39D12"]=true, --   THORQUE
	["6C6585972CF9A843D1CD8DDAA0C127B3"]=true, --   MOTOCA
	["E92597C4232B297C8B8C14F8DD286FF3"]=true, --   RINEZIN
	["357443CD11A37C79FA6DA7A47B843C62"]=true, --   GUIZIN
	["D6E7988C57185A69A54B497744FAB783"]=true, --   PITBUL
	["0F13CFD7C59F365338826014A019AB42"]=true, --   BELLO
	["411FA240EC09824F431E943F15BF52E3"]=true, --   TIRINGA
	["7869609F5045B387A0CF8D507C4B3642"]=true, --   ALEX MTA
	["81C485138B43E2C75D27EF7500A72642"]=true, -- ANGEL
} 

function beneficiario(p)
	if youtubersEstreamers[getPlayerSerial(p)] then
	return true
	else
	return false
	end
end

function setarskinP(p)
		local playeraccount = getPlayerAccount ( p )
		local menina = getAccountData(playeraccount, "skin:femi") or 0
		local genero = getElementData(p, "char:genero")
		if genero == "mulher" then 
		setElementModel(p, menina)
		--return 
		end
		if genero == "homem" then 
		setElementModel(p, 0)
		--return 175
		end
end

function checkPermission(p,szint)
	local admin = getElementData(p,"acc:admin")
	if admin >= tonumber(szint) then
		return true
	end
end

function checkPermissionIG(p,szint)
	local admin = getElementData(p,"acc:admin")
	if admin <= tonumber(szint) then
		return true
	end
end

function getPorcentagem (porce, valor)
     if porce and valor then
         local valor_01 = porce/100
         if valor_01 then
             local valor_02 = valor_01*valor
             if valor_02 then
                 local valor = math.floor(valor_02)
                 return tonumber(valor)
             end
         end
     end
end

function isPlayerDuty(p)
	if getElementData(p, "char:dutyfaction") == 2
	or getElementData(p, "char:dutyfaction") == 5 
	or getElementData(p, "char:dutyfaction") == 6 
	or getElementData(p, "char:dutyfaction") == 11 
	or getElementData(p, "char:dutyfaction") == 16  
	or getElementData(p, "char:dutyfaction") == 17 
	or getElementData(p, "char:dutyfaction") == 19 
	or getElementData(p, "char:dutyfaction") == 20 
	or getElementData(p, "char:dutyfaction") == 21
	or getElementData(p, "char:dutyfaction") == 22
	or getElementData(p, "char:dutyfaction") == 24 
	or getElementData(p, "char:dutyfaction") == 28	then
		return true
	end
end

function isPlayerFaccao(p)
	if getElementData(p, "char:dutyfaction") == 7
	or getElementData(p, "char:dutyfaction") == 8 
	or getElementData(p, "char:dutyfaction") == 10 
	or getElementData(p, "char:dutyfaction") == 13 
	or getElementData(p, "char:dutyfaction") == 14  
	or getElementData(p, "char:dutyfaction") == 15 
	or getElementData(p, "char:dutyfaction") == 18 
	or getElementData(p, "char:dutyfaction") == 23 
	or getElementData(p, "char:dutyfaction") == 25
	or getElementData(p, "char:dutyfaction") == 26
	or getElementData(p, "char:dutyfaction") == 27	then
		return true
	end
end


-- eletricista
local payEletri = 250
local expEletri = 80

-- transporte de valores
local payValores = 800
local expValores = 110


-- ifood
local payifood = 200
local expifood = 90 

-- Pedreiro
local payPedreiro = 70 
local expPedreiro = 50 

	
-- lixeiro
local payLixeiro = 1500 
local expLixeiro = 200 

-- limpador
local payLimpador = 300 
local expLimpador = 200 

-- sedex
local paySedex = 200 
local expSedex = 150 

-- entregador de gas
local payEDG = 160 
local expEDG = 160 

-- motorista
local payMotorista = 300 
local expMotorista = 200 

-- motorista rodoviario
local payMotoristaR = 450 
local expMotoristaR = 300 


-- maquinista	
local payMaquinista = 600 
local expMaquinista = 300 
	
-- Gasolina	
local payGasolina = 200 
local expGasolina = 100 

local antisalario = {}
function setPlayerPagamento(player)
	if isTimer(antisalario[player]) then 
	
exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." trabalhando como "..getElementData(player, "job").." possivelmente está bugando o salario!")
		
	return 
	end
	if isPlayerDuty(player) then 
	outputAdminMessage(" ")
	outputAdminMessage(" ")
	outputAdminMessage(" ")
	outputAdminMessage("#7cc576"..getPlayerName(player).." ("..getElementData(player, "char:id")..") está com o #fff000/trabalhar #7cc576ativado e trabalhando no emprego "..getElementData(player, "job").." #ffffff.")
	return 
	end

	antisalario[player] = setTimer(function() end, 10000, 1)
	
	
	local emprego = getElementData(player, "job")
	if emprego == "Pedreiro" then 
	--[[
		local lv = tonumber(getElementData( player, "Sys:Level" ) or 0)
		if lv >= 4 then 
		exports.bgo_hud:dm("O Pedreiro agora é só para level do 0 ao 3 você ja é level acima disso! pegue outro emprego", player, 255, 200, 0)
		return 
		end]]--
		
		setElementData(player,"char:money", getElementData(player,"char:money") + payPedreiro)
		exports.bgo_hud:dm("Você Ganhou +R$"..payPedreiro.." por entregar a caixa", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expPedreiro )
		--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payPedreiro.." | XP"..expPedreiro.." como "..getElementData(player, "job").." ")
		
		return

	elseif emprego == "Transporte de Valores" then 	
		
		setElementData(player,"char:money", getElementData(player,"char:money") + payValores)
		exports.bgo_hud:dm("Você Ganhou +R$"..payValores.." por entregar o malote", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expValores)
		--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payValores.." | XP"..expValores.." como "..getElementData(player, "job").." ")
		return

		
	elseif emprego == "Eletrecista" then 	
		
		setElementData(player,"char:money", getElementData(player,"char:money") + payEletri)
		exports.bgo_hud:dm("Você Ganhou +R$"..payEletri.." por concertar o poste!", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expEletri )
		
		--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payEletri.." | XP"..expEletri.." como "..getElementData(player, "job").." ")
		
		return
	elseif emprego == "ifood" then 	
		
		setElementData(player,"char:money", getElementData(player,"char:money") + payifood)
		exports.bgo_hud:dm("Você Ganhou +R$"..payifood.." por entregar a pizza", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expifood )
		
		--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payifood.." | XP"..expifood.." como "..getElementData(player, "job").." ")
		
		return
	elseif emprego == "Lixeiro" then 
		setElementData(player,"char:money", getElementData(player,"char:money") + payLixeiro)
		exports.bgo_hud:dm("Você Ganhou +R$"..payLixeiro.." por entregar os lixos", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expLixeiro )
		
		--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payLixeiro.." | XP"..expLixeiro.." como "..getElementData(player, "job").." ")
		
		return
	elseif emprego == "Limpador" then 
		setElementData(player,"char:money", getElementData(player,"char:money") + payLimpador)
		exports.bgo_hud:dm("Você Ganhou +R$"..payLimpador.." por chegar no ponto!", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expLimpador )
		
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payLimpador.." | XP"..expLimpador.." como "..getElementData(player, "job").." ")
		
		return
	elseif emprego == "Sedex" then
		setElementData(player,"char:money", getElementData(player,"char:money") + paySedex)
		exports.bgo_hud:dm("Você Ganhou +R$"..paySedex.." por entregar o produto!", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expSedex )
		
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..paySedex.." | XP"..expSedex.." como "..getElementData(player, "job").." ")
		
		
		
		return
	elseif emprego == "Entregador de Gas" then 
		setElementData(player,"char:money", getElementData(player,"char:money") + payEDG)
		exports.bgo_hud:dm("Você Ganhou +R$"..payEDG.." por entregar o produto!", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expEDG )
		
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payEDG.." | XP"..expEDG.." como "..getElementData(player, "job").." ")
		
		
		return
	elseif emprego == "Motorista" then
		setElementData(player,"char:money", getElementData(player,"char:money") + payMotorista)
		exports.bgo_hud:dm("Você Ganhou +R$"..payMotorista.." por chegar no ponto!", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expMotorista )
		
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payMotorista.." | XP"..expMotorista.." como "..getElementData(player, "job").." ")
		
		
		return
	elseif emprego == "MotoristaR" then 
		setElementData(player,"char:money", getElementData(player,"char:money") + payMotoristaR)
		exports.bgo_hud:dm("Você Ganhou +R$"..payMotoristaR.." por chegar no ponto!", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expMotoristaR )
		
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payMotoristaR.." | XP"..expMotoristaR.." como "..getElementData(player, "job").." ")
		
		return
	elseif emprego == "Maquinista" then
		setElementData(player, "char:money", getElementData(player, "char:money")+payMaquinista)
		exports.bgo_hud:dm("Você Ganhou +R$"..payMaquinista.." por ir na estação", player, 255, 200, 0)
		exports.bgo_Level:givePlayerExp(player, expMaquinista ) 
	
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..payMaquinista.." | XP"..expMaquinista.." como "..getElementData(player, "job").." ")
		
		return
	elseif emprego == "Transporte de Gasolina" then
	local bonus = getElementData(player, "bonusPay") or 0
		setElementData(player, "char:money", getElementData(player, "char:money")+ (math.floor(bonus/3)))
		exports.bgo_hud:dm("Você Ganhou +R$"..(math.floor(bonus/3)).." por abastecer o posto!", player, 255, 200, 0)
		setElementData(player,"bonusPay", false)
		exports.bgo_Level:givePlayerExp(player, expGasolina ) 
		
--exports.bgo_discordlogs:sendDiscordMessage(6, false, ""..getPlayerName(player):gsub("#%x%x%x%x%x%x", "").." ganhou $"..(math.floor(bonus/3)).." | XP"..expGasolina.." como "..getElementData(player, "job").." ")
		
		return
	else
	return false
end
end

local TempoComando = {}

function AntiComandTempo( player )
	return not isTimer(TempoComando[player])
end

function AntiComandGetTime ( player )
	if isTimer ( TempoComando[player] ) then
		local miliseconds = getTimerDetails ( TempoComando[player] )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end


function AntiComandoTime ( player, time )
	TempoComando[player] = setTimer( 
	function (player) 
	if TempoComando[player] then
	TempoComando[player] = {} 
	end
	end, time, 1, player)
end

addEventHandler("onPlayerQuit", root,
	function ()
		if isTimer ( TempoComando[source] ) then
		killTimer(TempoComando[source])
		if TempoComando[source] then
			TempoComando[source] = {} 
		end
		end
	end
)


