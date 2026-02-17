addCommandHandler ( "susto",
 function ( thePlayer, commandName, who)
        if tonumber(getElementData( thePlayer, "acc:admin" ) or 0) >= 9 then
             if not ( who ) then
                  outputChatBox ( "#7cc576[Use]:#ffffff /" .. commandName .. "[ID]", thePlayer, 255, 0, 0, true )
             else 
                     local targetPlayer, targetPlayerName = exports.bgo_core:findPlayer(thePlayer, who)
                     if ( targetPlayer ) then

  triggerClientEvent ( "showBSODToPlayer", targetPlayer, targetPlayer );
                     end
                    end
                end
 end
);