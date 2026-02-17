
local myBlip = { }
addEventHandler ("onPlayerWeaponFire", root, 
   function (weapons)
	--setElementData(source, "Fire", false)
         if not (getElementData(source, "Fire")) then
		 setElementData(source, "Fire", true)

		 x,y,z = getElementPosition(source)
		 local weaponName = getWeaponNameFromID(weapons)
		 local localidade = getZoneName(x, y, z)
		 if (weaponName == "Silenced") then
		     local weaponName = "Teaser"
		 end

		for k, v in ipairs(getElementsByType("player")) do 
			if getPlayerTeam(v) == getTeamFromName("Admin") then
					outputChatBox ("Está acontecendo um tiroteio em #7cc576" .. localidade .. " #FFFFFFArma: #7cc576("..weaponName..") #FFFFFFN° da chamada #7cc576(" .. getElementData(source, "playerid")..")", v, 255, 0, 0, true )
					--triggerClientEvent(v, "bgo>info", v,"INFORMAÇÃO DE LOG!", "Está acontecendo um tiroteio em " .. localidade .. " Arma: ("..weaponName..") N° da chamada (" .. getElementData(source, "playerid")..")", "info")
			end
		end

	     exports.bgo_admin:outputAdminMessage("Está acontecendo um tiroteio em #7cc576" .. localidade .. " #FFFFFFArma: #7cc576("..weaponName..") #FFFFFFN° da chamada #7cc576(" .. getElementData(source, "playerid")..")")
		 setTimer(setElementData, 60000, 1, source, "Fire", false)

--[[
		 if getPlayerTeam(source) == getTeamFromName("Policia") then return end

			if isElement(myBlip[source]) then
			destroyElement( myBlip[source] )
			end
			
			myBlip[source] = createBlipAttachedTo (source, 1 )
			setBlipColor ( myBlip[source], 255, 255, 255, 255 )
			setBlipSize ( myBlip[source], 3 )
			setElementVisibleTo ( myBlip[source], root, false )
			local x, y, z = getElementPosition ( source )
			local location = getZoneName ( x, y, z )
			local city = getZoneName ( x, y, z, true )

			setTimer(destroyElement, 3000, 1, myBlip[source])
			exports.bgo_hud:drawNote("Tata", "[Aviso]: A Policia foi informada sobre o suposto tiroteio vaza do local!", source, 255, 255, 255, 10000)
			for k, v in ipairs(getElementsByType("player")) do 
				if getPlayerTeam(v) == getTeamFromName("Policia") then
			setElementVisibleTo ( myBlip[source], v, true )
			exports.bgo_hud:drawNote("Tiro" .. location .. "", "[Tiroteio]: Um suposto tiroteio em " .. location .. " " .. city, v, 255, 255, 255, 10000)
			end
			end
]]--


		 end
   end
)


for k, targetPlayer in ipairs(getElementsByType("player")) do 
	setElementData(targetPlayer, "Fire", false)
end