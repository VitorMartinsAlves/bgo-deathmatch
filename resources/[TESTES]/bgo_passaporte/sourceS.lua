

addEvent("giveItemsPassaporte",true)
addEventHandler("giveItemsPassaporte",getRootElement(),function(player,name,azon,kep,erv)
	local money = tonumber(getElementData(player,"char:money") or 0)
	if money > 10000 then
	if not exports['bgo_items']:hasItemS(player, 111) then 
	exports["bgo_items"]:giveItem(player,111,toJSON({name,azon,kep,erv}),1)
	setElementData(player,"char:money", money - 10000)
	exports.bgo_hud:dm("Passaporte emitido com sucesso boa viajem!", player, 200, 255, 0)
	end
	else
	exports.bgo_hud:dm("Dinheiro insufiente para comprar o passaporte, Preço: R$:10,000", player, 200, 255, 0)
	end
end)


	


local pontepTrem = createColSphere ( 2766.969, 473.473, 6.997, 25 )

function pontepassaporte1Trem ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
	
	if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	
	exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	setElementPosition(thePlayer,2767.419, 528.878, 8.597)


	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,2767.419, 528.878, 8.597)
	setElementVelocity(theVehicle, 0, 0, 0)
	end
	end
end
addEventHandler ("onColShapeHit", pontepTrem, pontepassaporte1Trem )





local pontep = createColSphere ( 1735.463, 513.116, 26.072, 25 )

function pontepassaporte1 ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	
	setElementPosition(thePlayer,1760.222, 558.794, 25.405)
	exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	

	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,1760.222, 558.794, 25.405)
	setElementVelocity(theVehicle, 0, 0, 0)
	end

	
	end
end
addEventHandler ("onColShapeHit", pontep, pontepassaporte1 )




local pontemeio = createColSphere (501.139, 500.451, 18.922, 15 )

function pontepassaporte2 ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	setElementPosition(thePlayer,477.962, 532.956, 18.922)
		exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,477.962, 532.956, 18.922)
	setElementVelocity(theVehicle, 0, 0, 0)
	end

	end
	end

addEventHandler ("onColShapeHit", pontemeio, pontepassaporte2 )




local pontemeio2 = createColSphere (-162.313, 388.678, 12.078, 15 )

function pontepassaporte3 ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	setElementPosition(thePlayer,-146.113, 450.677, 12.078)
		exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,-146.113, 450.677, 12.078)
	setElementVelocity(theVehicle, 0, 0, 0)
	end

end
end
addEventHandler ("onColShapeHit", pontemeio2, pontepassaporte3 )



local ponteSF = createColSphere (-1397.927, 827.955, 46.597, 25 )

function pontepassaporte4 ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	setElementPosition(thePlayer,-1344.583, 872.903, 47.197)
		exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,-1344.583, 872.903, 47.197)
	setElementVelocity(theVehicle, 0, 0, 0)
	end

end
end
addEventHandler ("onColShapeHit", ponteSF, pontepassaporte4 )



local ponteSFTrem = createColSphere (-1294.792, 736.64, 33.297, 25 )

function pontepassaporte4Trem ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	setElementPosition(thePlayer,-1240.405, 776.456, 35.197)
		exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,-1240.405, 776.456, 35.197)
	setElementVelocity(theVehicle, 0, 0, 0)
	end

end
end
addEventHandler ("onColShapeHit", ponteSFTrem, pontepassaporte4Trem )




local ponteSF2 = createColSphere (-2681.517, 1737.529, 67.997, 30 )

function pontepassaporte5 ( thePlayer )
	if getElementType ( thePlayer ) == "player" then
		if exports.bgo_admin:isPlayerDuty(thePlayer) or getElementData(thePlayer, "char:dutyfaction") == 4 then
	return
	end	
	
	
	if exports['bgo_items']:hasItemS(thePlayer, 111) or getElementData(thePlayer,"VIP") == true then 
	exports.bgo_hud:dm("FRONTEIRA LIBERADA", thePlayer, 200, 255, 0)
	return
	end
	setElementPosition(thePlayer,-2674.094, 1799.251, 69.397)
		exports.bgo_hud:dm("VOCÊ NÃO POSSUI PASSAPORTE COMPRE UM NA PREFEITURA!!", thePlayer, 200, 255, 0)
	 local theVehicle = getPedOccupiedVehicle ( thePlayer )
	if theVehicle then
	setElementPosition(theVehicle,-2674.094, 1799.251, 69.397)
	setElementVelocity(theVehicle, 0, 0, 0)
	end
end
end
addEventHandler ("onColShapeHit", ponteSF2, pontepassaporte5 )


