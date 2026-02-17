    function vehicleGodMod(player)
        if not (hasObjectPermissionTo(player,"general.adminpanel",false)) then
        outputChatBox("Voçe Não Tem Acesso Á Este Comando" ,player,255) return end
        if (isVehicleDamageProof(getPedOccupiedVehicle(player))) then
        setVehicleDamageProof(getPedOccupiedVehicle(player),false)
        outputChatBox("Seu Veiculo Não Esta Mas Protegido",player,255)
    else
        setVehicleDamageProof(getPedOccupiedVehicle(player),true)
        outputChatBox("Seu Veiculo Esta Protegido",player,0,255)
        end
    end
    addCommandHandler("prov",vehicleGodMod)
    addCommandHandler("protegerveiculo",vehicleGodMod)