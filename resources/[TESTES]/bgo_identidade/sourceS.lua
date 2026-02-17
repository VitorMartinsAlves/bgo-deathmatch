

addEvent("giveItems",true)
addEventHandler("giveItems",getRootElement(),function(player,name,azon,kep,erv)
	if not exports['bgo_items']:hasItemS(player, 29) then 
	exports["bgo_items"]:giveItem(player,29,toJSON({name,azon,kep,erv}),1)
	end
	
end)