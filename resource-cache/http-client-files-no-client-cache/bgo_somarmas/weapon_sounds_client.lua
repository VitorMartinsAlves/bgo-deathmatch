function playGunfireSound(weaponID)
	local muzzleX, muzzleY, muzzleZ = getPedWeaponMuzzlePosition(source)
	local dim = getElementDimension(source)
	local int = getElementInterior(source)
	setAmbientSoundEnabled( "gunfire", false )
setWorldSoundEnabled ( 5, false )
	local weaponSounds = {
		[22] = "sounds/Colt45.ogg",
		[23] = "sounds/Silenced.ogg",
		[24] = "sounds/Deagle.ogg",
		[25] = "sounds/Shotgun.ogg",
		[26] = "sounds/Sawed-Off.ogg",
		[27] = "sounds/Combat-Shotgun.ogg",
		[28] = "sounds/UZI_Tec9.ogg",
		[29] = "sounds/MP5.ogg",
		[30] = "sounds/AK47.ogg",
		[31] = "sounds/M4.ogg",
		[32] = "sounds/UZI_Tec9.ogg",
		[33] = "sounds/Rifle.ogg",
		[34] = "sounds/Sniper.ogg",
	}
	if weaponSounds[weaponID] then
		sound = playSound3D(weaponSounds[weaponID], muzzleX, muzzleY, muzzleZ, false)
		setSoundMaxDistance(sound, 120)
		setElementDimension(sound, dim)
		setElementInterior(sound, int)
		setSoundVolume(sound, 0.6)
	end
end
addEventHandler("onClientPlayerWeaponFire", root, playGunfireSound)