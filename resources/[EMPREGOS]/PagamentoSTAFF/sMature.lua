local ResgatePolicia = 10000
local SalarioPublico = 500

local SalarioStaff = 7000
function salario()
	players = getElementsByType ( "player" )
	for k,v in ipairs(players) do
	if getElementData(v, "adminjail") == 1 then
	else
	if getElementData(v, "loggedin") then 	
		local money = getElementData(v, "char:money") or 0

	local bankmoneyc = getElementData(v, "char:bankmoney") or 0
	 if bankmoneyc <= 0 then
	 triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"O imposto do banco não foi cobrado por baixa renda", 255, 255, 255, pos, 20 )
	 elseif bankmoneyc > 0 and bankmoneyc < 140000 then
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"O imposto da sua conta não foi cobrado.", 255, 255, 255, pos2, 20 )
						elseif bankmoneyc > 130000 and bankmoneyc < 1000000 then
							local bankpay = math.random(800, 2000)
							triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"O Banco cobrou : #FF0000-R$"..bankpay.." #FFFFFF de taxas de sua conta bancária", 255, 255, 255, pos2, 20 )
							setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0) - bankpay)
						elseif bankmoneyc > 5000000 and bankmoneyc < 10000000 then
							local bankpay = math.random(1000000, 3000000)
							triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"O Banco cobrou : #FF0000-R$"..bankpay.." #FFFFFF de taxas de sua conta bancária", 255, 255, 255, pos2, 20 )
							setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0) - bankpay)
						elseif bankmoneyc > 20000000 then
							local bankpay = math.random(10000000, 15000000)
							triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"O Banco cobrou : #FF0000-R$"..bankpay.." #FFFFFF de taxas de sua conta bancária", 255, 255, 255, pos2, 20 )
							setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0) - bankpay)
					end


		local count = getPlayerCount()
		if count > 50 then
		--setTimer ( pagamento, 600000 * 3, 0)
		
		
		if exports.bgo_admin:isPlayerDuty(v) then
		if count > 99 and count < 150 then
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como POLICIAL: #00FF00+R$10000 ", 255, 255, 255, pos, 20 )
		setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + 10000)
		exports.bgo_Level:givePlayerExp(v, 150)
		--print("Policia Recebeu R$:4000 de pagamento")
		elseif count > 150 and count < 250 then
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como POLICIAL: #00FF00+R$10000 ", 255, 255, 255, pos, 20 )
		setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + 10000)
		exports.bgo_Level:givePlayerExp(v, 150)
		--print("Policia Recebeu R$:6000 de pagamento")
		elseif count > 250 and count < 300 then
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como POLICIAL: #00FF00+R$10000 ", 255, 255, 255, pos, 20 )
		setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + 10000)
		exports.bgo_Level:givePlayerExp(v, 150)
		--print("Policia Recebeu R$:7000 de pagamento")
		elseif count > 300 and count < 400 then
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como POLICIAL: #00FF00+R$10000 ", 255, 255, 255, pos, 20 )
		setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + 10000)
		exports.bgo_Level:givePlayerExp(v, 150)
		--print("Policia Recebeu R$:8000 de pagamento")
		
		
		elseif count > 400 then
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como POLICIAL: #00FF00+R$10000 ", 255, 255, 255, pos, 20 )
		setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + 10000)
		exports.bgo_Level:givePlayerExp(v, 150)
		--print("Policia Recebeu R$:10000 de pagamento")		
		else
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como POLICIAL: #00FF00+R$10000 ", 255, 255, 255, pos, 20 )
		setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + 10000)
		exports.bgo_Level:givePlayerExp(v, 150)
		--print("Policia Recebeu R$:4000 de pagamento")
		end
		end


		 if getElementData(v, "char:adminduty") == 1 then
			triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como STAFF: #00FF00+R$"..SalarioStaff.." ", 255, 255, 255, pos, 20 )
			--setElementData(v, "char:money", (getElementData(v,"char:money") or 0) + SalarioStaff)
			exports.bgo_Level:givePlayerExp(v, 150)
			setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + SalarioStaff)

		end

		 if getElementData(v, "char:dutyfaction") == 4  then
			triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como RESGATE: #00FF00+R$"..ResgatePolicia.." ", 255, 255, 255, pos, 20 )
			--setElementData(v, "char:money", (getElementData(v,"char:money") or 0) + ResgatePolicia)
			exports.bgo_Level:givePlayerExp(v, 150)
			setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + ResgatePolicia)


		 end
	
		 if getElementData(v, "char:dutyfaction") == 1  then
			triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"Seu salário como DETRAN: #00FF00+R$"..ResgatePolicia.." ", 255, 255, 255, pos, 20 )
			--setElementData(v, "char:money", (getElementData(v,"char:money") or 0) + ResgatePolicia)
			exports.bgo_Level:givePlayerExp(v, 150)
			setElementData(v, "char:bankmoney", (getElementData(v,"char:bankmoney") or 0)  + ResgatePolicia)

		 end
		else
			triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"#FF0000SALÁRIO #FFFFFFCANCELADO DEVIDO A POUCO JOGADOR NA CIDADE MINIMO 50 JOGADORES!", 255, 255, 255, pos, 20 )
		end
			end
		end
	end
end
--end, 600000*6,0)
addEventHandler( "onResourceStart", resourceRoot, salario ) 

salario2 = setTimer(salario,math.random(2400000,3600000),0)

--end, math.random(2400000,3600000), 0)



function atmGetTimeOut ( player )
	if isTimer ( salario2 ) then
		local miliseconds = getTimerDetails ( salario2 )
		return math.ceil( miliseconds / 1000 )
	else
		return false
	end
end


function salarioo ( thePlayer )
		local value = getElementData(thePlayer,"char:adminduty")
		if value == 0 and not (tonumber(getElementData(thePlayer, "acc:admin") or 0) >= 7)  then outputChatBox("#7cc576Você não está no modo admin!!",thePlayer, 255, 194, 14, true) return end
		if getElementData(thePlayer, "acc:admin") >= 7 then
		if isTimer ( salario2 ) then
		triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Informação staff", "Salario vai cair em "..atmGetTimeOut ( thePlayer ).." segundos!", "info")
		end
	end
end
addCommandHandler("tsalario", salarioo)
	