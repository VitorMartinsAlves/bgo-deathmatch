
addEventHandler( "onClientKey", root, function(button,press) 
     if not setBind then
         if button == "arrow_u" or button == "pgup" then
             cancelEvent()
		 end
    end
end )

setBind = true

addEventHandler("onClientVehicleStartEnter", getRootElement(),
    function(thePlayer, seat)
        local vtype = getVehicleType(source)
		if vtype == "Bike" and getElementModel(source) == 448 or getElementModel(source) == 523 then
		    if setBind then
			    if thePlayer == getLocalPlayer() then
			        setBind = false
			     end
			end
        end
    end
)

addEventHandler("onClientVehicleStartExit", getRootElement(),
    function(thePlayer, seat)
        local vtype = getVehicleType(source)
		if vtype == "Bike" and getElementModel(source) == 448 or getElementModel(source) == 523 then
		    if not setBind then
			    if thePlayer == getLocalPlayer() then
			        setBind = true
				end
			end
        end
    end
)