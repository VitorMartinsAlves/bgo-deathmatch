
addEvent("TirarNoVeiculo", true)
addEventHandler("TirarNoVeiculo",root, function(thePlayer, Player)
					
					for k,player2 in ipairs(getElementsByType("player")) do
					if player2 ~= thePlayer then
					local pX,pY,pZ = getElementPosition(thePlayer)
					vX,vY,vZ = getElementPosition(player2)
					local dist = getDistanceBetweenPoints3D(pX,pY,pZ,vX,vY,vZ)
					if dist <= 10 then
					local theVehicle = getPedOccupiedVehicle ( player2 )
					if theVehicle then
					if (getElementModel(theVehicle) == 416) then
					removePedFromVehicle( player2 )
					setElementPosition(player2, pX+1,pY,pZ)
					exports.bgo_chat:sendLocalMeAction(thePlayer, "removendo o homem do veículo.")
					end
					end
				end		
			end
		end		
		end
)
