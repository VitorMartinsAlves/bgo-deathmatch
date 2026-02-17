Gasolina = {
 {1926.079, -1790.24, 12.878},
 {1464.928, -1803.035, 12.786},
 {1233.348, -1438.959, 12.601},
 {1008.96, -929.943, 41.328},
 --{-1688.736, 417.723, 6.18},
}

for i,v in pairs(Gasolina) do
     mark = createMarker (v[1], v[2], v[3], "cylinder", 1.5, getColorFromString("#FFA00001"))
     icon = createPickup(v[1], v[2], v[3] + 1.5, 3, 1650, 0.5)
     function enterInfo (thePlayer)
         exports.bgo_hud:dm("Digite /comprar para adquirir um galão de gasolina.",thePlayer, 255, 255, 255)
	     exports.bgo_hud:dm("Valor de cada galão, R$800.00",thePlayer, 0, 255, 0)
		 setElementData(thePlayer, "Galao2", true)
     end	 
	 addEventHandler("onMarkerHit", mark, enterInfo)
     function exitInfo (thePlayer)
		 setElementData(thePlayer, "Galao2", false)
     end	 
	 addEventHandler("onMarkerLeave", mark, exitInfo)

end

function buyObject (thePlayer, commandName, mode)
     local theVehicle = getPedOccupiedVehicle ( thePlayer )
	 if theVehicle then exports.bgo_hud:dm("Saia do veiculo para comprar um galão de combustivel",thePlayer, 255, 0, 0) return end
	 if not (getElementData(thePlayer, "char:money") >= 800) then
     exports.bgo_hud:dm("Dinheiro insulficiente.",thePlayer, 255, 255, 255)
	 else
         if getElementData(thePlayer, "Galao2") then
		     if exports['bgo_items']:hasItemS(thePlayer, 26) then
	 		     exports.bgo_hud:dm("Você já possui um galão de combustivel.",thePlayer, 255, 255, 255)
			 else
			     setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - 800)
                 exports['bgo_items']:giveItem(thePlayer, 26, 1, 1, 0, false)
		   	     exports.bgo_hud:dm("Galão adquirido com sucesso.",thePlayer, 255, 255, 255)
			 end
		 end
	 end
end
addCommandHandler("comprar", buyObject)

function clicktheCar (thePlayer, car)
local theVehicle = getPedOccupiedVehicle ( thePlayer )
     if theVehicle then return end
     if car then
	     if not exports['bgo_items']:hasItemS(thePlayer, 26) then
		     return
		 end
			 if getElementData(car, "veh:fuel") <= 50 then
		         triggerEvent('btcMTA->#takePlayerItemToID', thePlayer, thePlayer, 26, false)
			     exports.bgo_hud:dm("Veiculo abastecido com sucesso, + 50%",thePlayer, 0, 255, 0)
			     setElementData(car, "veh:fuel", getElementData(car, "veh:fuel") + 50)
				 exports.bgo_chat:sendLocalMeAction(thePlayer, "Está abastecendo o veiculo ("..getVehicleName(car)..") com um galão de gasolina.")
				 else
				 exports.bgo_hud:dm("O tanque deste veiculo está cheio.",thePlayer, 255, 255, 255)
			 end
	 end
end
addEvent ( "BTC:Galao", true )
addEventHandler ( "BTC:Galao", root, clicktheCar)