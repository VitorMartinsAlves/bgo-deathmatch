addEvent("updateFightStyle",true)
addEventHandler("updateFightStyle",getRootElement(),function(thePlayer, fightID)
	setPedFightingStyle(thePlayer,fightID)
end)