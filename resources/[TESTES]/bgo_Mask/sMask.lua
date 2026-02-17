

addEventHandler("onPlayerQuit", root,
	function()
		triggerClientEvent("removeMask", source);
	end
)

function removerMask(source)
	triggerClientEvent("removeMask", source, source)
end
addCommandHandler ("remvitem", removerMask)


addEvent("removeMask2", true)
addEventHandler("removeMask2", root,
function(source)
	triggerClientEvent("removeMask", source, source)
end
)




function playerDamage_text ( attacker, weapon, bodypart, loss ) --when a player is damaged
	if ( attacker and attacker ~= source ) then
	triggerClientEvent("cairmask", source, source)
	end
end
--addEventHandler ( "onPlayerDamage", root, playerDamage_text )