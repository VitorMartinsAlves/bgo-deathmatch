
repairSoundPath = "sound.wav"
repairTime = 20

--Ezredmásodpercre konvertálás
repairTime = repairTime * 1000

priceTable = {
	["Motor"] = {110,120,130,140},
	["windscreen_dummy"] = {110, 115, 120},
	["bump_front_dummy"] = {115, 120, 125},
	["bump_rear_dummy"] = {115, 120, 125},
	["bonnet_dummy"] = {115, 120, 125, 130},
	["boot_dummy"] = {115, 120, 125, 130},
	["door_lf_dummy"] = {115, 120, 125, 130},
	["door_rf_dummy"] = {115, 120, 125, 130},
	["door_lr_dummy"] = {115, 120, 125, 130},
	["door_rr_dummy"] = {115, 120, 125, 130},
	
	["wheel_rf_dummy"] = {115, 120, 125, 130},
	["wheel_lf_dummy"] = {115, 120, 125, 130},
	["wheel_rb_dummy"] = {115, 120, 125, 130},
	["wheel_lb_dummy"] = {115, 120, 125, 130},
	
	["wheel_rear"] = {115, 120, 125, 130},
	["wheel_front"] = {115, 120, 125, 130},
}
defPrice = 10 --Ha a táblában nem lenne benne az ár, mennyi lenne az alapértelmezett.