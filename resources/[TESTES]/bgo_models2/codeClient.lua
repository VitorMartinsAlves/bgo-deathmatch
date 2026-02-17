local dir = "files"
function loadMod ( f, m )
	if fileExists ( dir..'/'.. f ..'.txd' ) then
		txd = engineLoadTXD ( dir ..'/'.. f ..'.txd' )
		engineImportTXD ( txd, m )
	end
	if fileExists ( dir..'/'.. f ..'.dff' ) then
		dff = engineLoadDFF ( dir..'/'.. f ..'.dff', m )
		engineReplaceModel ( dff, m )
	end
	if fileExists(dir..'/'.. f ..'.col') then
		col = engineLoadCOL(dir..'/'.. f ..'.col')
		engineReplaceCOL ( col, m )
	end
end



addEventHandler("onClientResourceStart", resourceRoot, 
function()
	loadMod ( "wls_marihuana", 18470)
	loadMod ( "wls_cserep", 16404)
	--loadMod ( "wls_koka", 18214)

	loadMod ( "wls_mak", 18471)
	
--[[
	loadMod ( "wls_garazs", 14784 )
	loadMod ( "wls_jail", 14795 )
	loadMod ( "wls_traffipax", 16101 )
	loadMod ( "wls_bandahaz", 3271 )
	loadMod ( "wls_vehicleshopfix", 6490 )
	loadMod ( "wls_tuning", 7834 )
	loadMod ( "wls_tuningaljafix", 5864 )
	
	loadMod ( "wls_garazs2", 14771 )
	loadMod ( "wls_garazs3", 14798 )
	loadMod ( "wls_ammodoboz", 2969 )
	loadMod ( "wls_gold", 954)
	loadMod ( "wls_safelock", 2003)
	loadMod ( "wls_safeunlock", 2003)
	loadMod ( "wls_lucky", 16257)
	loadMod ( "wls_fixtraffi", 6962)
	loadMod ( "wls_shield", 1631)



	
	
loadMod ( "wls_cellak", 16240 )

	
	loadMod ( "wls_jail", 14795 )
		loadMod ( "wls_monitor", 16340)
	
]]--





	loadMod ( "wls_rakmonitor", 2927)
	loadMod ( "wls_kures2", 16146)
	--loadMod ( "wls_ktele2", 13638)
	
	loadMod ( "wls_boja", 11434)
		
end
)


--engineSetAsynchronousLoading ( true, false )



---- KRESZ ----

-- 14802
--local kreszid = 14802

function addkreszobject(dffneve,txdneve,kreszid)
	removeWorldModel(tonumber(kreszid),10000,0,0,0) -- először töröljük!


end

function replaceut(id,txdnev)
	local txd = engineLoadTXD("comy_kresz/utak/"..txdnev..".txd")
    engineImportTXD(txd, id)
end


