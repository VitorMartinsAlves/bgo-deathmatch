function mensagem(player, titulo, mensagem, modo)
	if not titulo then return end
	if not mensagem then return end
	if not modo then return end
    triggerClientEvent(player, "bgo>info", player, titulo, mensagem, modo)
end