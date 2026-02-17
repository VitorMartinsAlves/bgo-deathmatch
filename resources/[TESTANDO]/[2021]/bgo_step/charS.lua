addEvent('repairWheel', true)
addEventHandler('repairWheel', root, function(p, vehicle, lf, lb, rf, rb, itemID)

	if lf == 0 then
		setVehicleWheelStates(vehicle, 2, lb, rf, rb)
	elseif lb == 0 then
		setVehicleWheelStates(vehicle, lf, 2, rf, rb)
	elseif rf == 0 then
		setVehicleWheelStates(vehicle, lf, lb, 2, rb)
	elseif rb == 0 then
		setVehicleWheelStates(vehicle, lf, lb, rf, 2)
	end

	exports['bgo_items']:takePlayerItemToID(p, itemID, 1)
	exports['bgo_hud']:dm(p, 'Você está trocando o pneu do seu veiculo.', 255, 255, 255)

	setPedAnimation(p, 'bomber', 'bom_plant')
	setElementFrozen(vehicle, true)
	toggleAllControls(p, false)

	setTimer(function()
		setVehicleWheelStates(vehicle, lf, lb, rf, rb)
		setPedAnimation(p, nil)
		toggleAllControls(p, true)
		setElementFrozen(vehicle, false)
	end, 10000, 1)
end)





stepes = {
 {1925.9978027344, -1778.0946044922, 13.878125190735},
 {1464.9001464844, -1812.0505371094, 13.785937309265},
 {1236.7746582031, -1449.6873779297, 13.548749923706},
 {1015.3548583984, -931.26892089844, 42.1796875},
 --{-1688.736, 417.723, 6.18},
}


for i,v in pairs(stepes) do
     mark = createMarker (v[1], v[2], v[3], "cylinder", 1.5, getColorFromString("#FFA00001"))
     icon = createPickup(v[1], v[2], v[3] + 0.5, 3, 1083, 0.5)
     function enterInfo (thePlayer)
         exports.bgo_hud:dm("Digite /comprar para adquirir um estepe.",thePlayer, 255, 255, 255)
	     exports.bgo_hud:dm("Valor de cada estepe, R$800.00",thePlayer, 0, 255, 0)
		 setElementData(thePlayer, "Galao", true)
     end	 
	 addEventHandler("onMarkerHit", mark, enterInfo)
     function exitInfo (thePlayer)
		 setElementData(thePlayer, "Galao", false)
     end	 
	 addEventHandler("onMarkerLeave", mark, exitInfo)

end

function buyObject (thePlayer, commandName, mode)
     local theVehicle = getPedOccupiedVehicle ( thePlayer )
	 if theVehicle then exports.bgo_hud:dm("Saia do veiculo para comprar um estepe",thePlayer, 255, 0, 0) return end
	 if not (tonumber(getElementData(thePlayer, "char:money") or 0) >= 800) then
     exports.bgo_hud:dm("Dinheiro insulficiente.",thePlayer, 255, 255, 255)
	 else
         if getElementData(thePlayer, "Galao") then
		     if exports['bgo_items']:hasItemS(thePlayer, 280) then
	 		     exports.bgo_hud:dm("Você já possui um estepe na mochila.",thePlayer, 255, 255, 255)
			 else
			     setElementData(thePlayer, "char:money", getElementData(thePlayer, "char:money") - 800)
                 exports['bgo_items']:giveItem(thePlayer, 280, 1, 1, 0, true)
		   	     exports.bgo_hud:dm("estepe adquirido com sucesso.",thePlayer, 255, 255, 255)
			 end
		 end
	 end
end
addCommandHandler("comprar", buyObject)