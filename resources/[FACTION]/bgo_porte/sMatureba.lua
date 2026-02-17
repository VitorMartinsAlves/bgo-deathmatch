function setPorte (thePlayer, ID, Validade, typ,Obs)
     local ID = tonumber(ID)
	 for _, player in ipairs(getElementsByType("player")) do
	     local pID = getElementData(player, "char:id")
         if (pID == ID) then
		 if tonumber(getElementData(player,"char:money") or 0) >= 30000 then
		    local name = getPlayerName(player)
            exports.bgo_admin:outputAdminMessage(" #FFFFFF"..getPlayerName(thePlayer).." #7cc576Efetuo um porte para #FFFFFF"..name.."#7cc576("..getElementData(player, "playerid")..")")
		    exports["bgo_items"]:giveItem(thePlayer,112,toJSON({name,Validade, typ, Obs}),1)
			setElementData(player, "char:money", tonumber(getElementData(player,"char:money") or 0) - 30000) 
			break
			else
			triggerClientEvent(thePlayer, "TS:info", thePlayer, "Esta pessoa não tem 30Mil em mãos", "error")
			triggerClientEvent(player, "TS:info", player, "Você não tem dinheiro suficiente, é preciso ter 30Mil em mãos", "error")
			end
		 end
     end		 
end
addEvent("setCard", true)
addEventHandler("setCard", root, setPorte)

function addPorte (thePlayer, command, id, dd, mm, aa, typ, ...)
if exports.bgo_dashboard:isPlayerInFaction(thePlayer, 9) or getElementData(thePlayer,"char:id") == 1 then
--if tonumber(getElementData(thePlayer,"char:money") or 0) >= 30000 then
local id = tonumber(id)
local dd = tonumber(dd)
local mm = tonumber(mm)
local aa = tonumber(aa)
local text = { ... }
local typMessage = table.concat( text, " " )
     if (id) then
	     if (dd) then
		     if (mm) then
			     if (aa) then
					local data = dd.."/"..mm.."/"..aa
				    setPorte(thePlayer, id, data, typ, typMessage)
					end
				end
			end
		end
	end
end
addCommandHandler("porte", addPorte)


