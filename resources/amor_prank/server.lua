addCommandHandler ( "amar",
 function ( thePlayer, commandName, who)
        if getElementData( thePlayer, "acc:admin" ) >= 2 then
             if not ( who ) then
                  outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. "[ID]", thePlayer, 255, 0, 0, true )
             else 
                     local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, who)
                     if ( targetPlayer ) then

  triggerClientEvent ( "showBSODToPlayeramar", targetPlayer, targetPlayer );
                     end
                    end
                end
 end
);



addCommandHandler('amarall',
function(thePlayer, commandName,  lib, lib2)
	  if getElementData( thePlayer, "acc:admin" ) >= 2 then
	local px, py, pz = getElementPosition(thePlayer)
	for k, v in ipairs(getElementsByType("player")) do 
		vx, vy, vz = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if dist <= 10 then

				
		triggerClientEvent ( "showBSODToPlayeramar", v, v );
		triggerClientEvent(v,"JoinQuitGtaV:sendClientMessage", v,"#FFFFFFDEUS AMA VOCÊ", 255, 255, 255, pos, 26 )
			end
		end
	end
end
)