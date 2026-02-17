local weaponStickers = {
	[30] = "ak",
	[29] = "mp5lng",
	[24] = "deagle",
	[31] = "m4a1t",
	[28] = "uzi",
	[34] = "9f257c2f",
	[25] = "m870t",
	[32] = "Tec9BodyTex",
	[4] = "kabar",
	[5] = "bat",
	[22] = "tex_0189_0",
}

local validStickers = {
	["ak_1"] = true,
	["ak_2"] = true,
	["ak_3"] = true,
	["ak_4"] = true,
	["ak_5"] = true,
	["ak_6"] = true,
	["mp_1"] = true,
	["mp_2"] = true,
	["mp_3"] = true,
	["mp_4"] = true,
	["mp_5"] = true,
	["mp_6"] = true,
	["desert_1"] = true,
	["desert_2"] = true,
	["desert_3"] = true,
	["m4_1"] = true,
	["m4_2"] = true,
	["m4_3"] = true,
	["m4_4"] = true,
	["uzi_1"] = true,
	["uzi_2"] = true,
	["uzi_3"] = true,
	["sniper_1"] = true,
	["sniper_2"] = true,
	["sniper_3"] = true,
	["sniper_4"] = true,
	["sniper_5"] = true,
	["sniper_6"] = true,
	["shoutgun_1"] = true,
	["shoutgun_2"] = true,
	["tec9_1"] = true,
	["tec9_2"] = true,
	["knife_1"] = true,
	["knife_2"] = true,
	["knife_3"] = true,
	["knife_4"] = true,
	["knife_5"] = true,
	["colt_1"] = true,
	["colt_2"] = true,
	["halloween"] = true,
	["m4_halloween"] = true,
	["ak_halloween"] = true,
	["sniper_halloween"] = true,
	
	["ak_brasil"] = true,
	["desert_brasil"] = true,
	["knife_brasil"] = true,
	["m4_brasil"] = true,
	["mp_brasil"] = true,
	["shotgun_brasil"] = true,
	["sniper_brasil"] = true,
	["tec9_brasil"] = true,
	["uzi_brasil"] = true,
	
	["m4_folia"] = true,
	["ak_folia"] = true,
	["sniper_folia"] = true,
	["desert_folia"] = true,
	["ak_vulcan"] = true,
	

	["ak_ouro"] = true,
	["desert_ouro"] = true,
	["knife_ouro"] = true,
	["m4_ouro"] = true,
	["mp_ouro"] = true,
	["shoutgun_ouro"] = true,
	["sniper_ouro"] = true,
	["tec9_ouro"] = true,
	["uzi_ouro"] = true,

	
	["bat_grove"] = true,
	["bat_dragon"] = true,
	
	
	["m4_alpha"] = true,
	["ak_alpha"] = true,
	["sniper_alpha"] = true,
	["desert_reddragon"] = true,
	
	
	["m4_reddragon"] = true,
	["sniper_reddragon"] = true,
	["m4_asiimov"] = true,
	["desert_asiimov"] = true,
	
	
	["m4_vulcan"] = true,
	["ak_vulcan"] = true,
	["awm_vulcan"] = true,
	["desert_vulcan"] = true,	
	["ak_flamengo"] = true,	
	["m4_imperador"] = true,


	["ak_stickbombs"] = true,
	["awm_stickbombs"] = true,
	["desert_stickbombs"] = true,
	["m4_stickbombs"] = true,

	["m4_diablo"] = true,
	["ak_bgo"] = true,

	["m4_rose"] = true,
	["ak_rose"] = true,

	["m4_doce"] = true,
	["ak_doce"] = true,
	["ak_galaxy"] = true,
	["m4_galaxy"] = true,
	["awp_galaxy"] = true,
	["deagle_galaxy"] = true,	
	["faca_galaxy"] = true,
	["pistol_cimento"] = true,
	
	["ak_rio"] = true,
	["m4_rio"] = true,
	["awp_rio"] = true,
	["deagle_rio"] = true,	
	["faca_rio"] = true,
}

function getWeaponWeaponShaderName(wep)
	if wep then
		if weaponStickers[wep] then
			return weaponStickers[wep]
		end
	end
	return false
end

function isStickerValid(value)
	if value then
		if validStickers[value] then
			return true
		end
	end
	return false
end