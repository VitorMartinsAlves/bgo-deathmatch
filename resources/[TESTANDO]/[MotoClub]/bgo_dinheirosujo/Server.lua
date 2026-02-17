function SellOre(element)
	if isElement(element) then
		--print(exports.bgo_admin:getPorcentagem (1, 55000))
		if exports['bgo_items']:hasItemS(element, 22) then
		exports["bgo_items"]:deleteItemById(element, 22, 1)
		end
	end
end
addEvent("bgoMTA->#dinheirosujo", true)
addEventHandler("bgoMTA->#dinheirosujo", root, SellOre)



function porcentagem(thePlayer, command, valor)
if getElementData(thePlayer, "char:dutyfaction") == 13 or getElementData(thePlayer, "char:dutyfaction") == 25 then
if tonumber(valor) then
local time = getRealTime()
local hours = time.hour
local minutes = time.minute
exports.bgo_chat:sendLocalMeAction(thePlayer, "#00ff00Do Valor #ffffff"..valor.." #00ff00vou ficar com #ffffff"..exports.bgo_admin:getPorcentagem (20, valor).." #00ff00- ( Hora da informação: "..hours..":"..minutes.." ) ")
triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Porcentagem", "Do Valor "..valor.." vou ficar com "..exports.bgo_admin:getPorcentagem (20, valor).."", "info")
else
triggerClientEvent(thePlayer, "bgo>info", thePlayer,"Ops!", "Uso correto: /% [valor]", "erro")
end
end
end
addCommandHandler("%", porcentagem)






function transfSujo(element)
	if isElement(element) then
		if exports['bgo_items']:hasItemS(element, 230) then
		exports["bgo_items"]:deleteItemIlegal(element, 230, 1)
		end
	end
end
addEvent("bgoMTA->#blocodedinheiro", true)
addEventHandler("bgoMTA->#blocodedinheiro", root, transfSujo)
