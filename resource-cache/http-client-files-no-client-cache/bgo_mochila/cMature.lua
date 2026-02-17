
local armas = {
-- Desert
44,
119,
243,
287,
310,
326,
343,
347,
352,
363,
306,
338,

-- ak e m4
52,
53,
120,
126,
133,
241,
242,
248,
298,
299,
303,
304,
307,
308,
318,
319,
322,
323,
324,
334,
335,
336,
339,
342,
344,
345,
348,
349,
350,
353,
354,
355,
356,
357,
358,
360,
361,


-- MP5 E UZI
49,
50,
53,
116,
117,
118,
121,
122,
123,
124,
131,
132,
244,
256,
312,
314,
315,
327,
329,
330,


}

local tem = false
local mochila = false

function teste()
	if not getElementData(localPlayer, "loggedin") then return end
	
	local item = exports['bgo_items']:hasItem(localPlayer, 22)
	local item2 = exports['bgo_items']:hasItem(localPlayer, 230)
	
	if item2 then 
	triggerServerEvent("setElementBolsa2",localPlayer,localPlayer)
	mochila = true
	else
	mochila = false
	if not getElementData(localPlayer, "setElementBolsa2OFF") then
	triggerServerEvent("setElementBolsa2OFF",localPlayer,localPlayer)
	end
	end
	
	if mochila == false then	
	if item then
	triggerServerEvent("setElementBolsa",localPlayer,localPlayer)
	else
	if not getElementData(localPlayer, "setElementBolsaOFF") then
	triggerServerEvent("setElementBolsaOFF",localPlayer,localPlayer)
	end
	end
	else
	if not getElementData(localPlayer, "setElementBolsaOFF") then
	triggerServerEvent("setElementBolsaOFF",localPlayer,localPlayer)
	end
	end	
	
	
	
	local item = exports['bgo_items']:hasItem(localPlayer, 24)
	if item then 
	triggerServerEvent("setAttachC4",localPlayer,localPlayer)
	else
	if not getElementData(localPlayer, "AttachC4OFF") then
	triggerServerEvent("setAttachC4OFF",localPlayer,localPlayer)
	end
	end



--[[
    for k, v in ipairs(getElementsByType("player"), root, true) do             
	local item = exports['bgo_items']:hasItem(v, 280)
	if item then 	

                local block, animation = getPedAnimation(v)
                if animation ~= "crry_prtial" then
				setPedAnimation(v, "CARRY", "crry_prtial", 0, false, false, true, true)
				setPedAnimationSpeed(v,"crry_prtial", 0)
				setPedAnimationProgress(v, 'crry_prtial', 0)
            end
        end
    end
	]]--


	local item = exports['bgo_items']:hasItem(localPlayer, 21) --getElementData(localPlayer,"acc:id") == 1
	if item then 
	triggerServerEvent("setAttachLockPick",localPlayer,localPlayer)
	else
	if not getElementData(localPlayer, "setAttachLockOFF") then
	triggerServerEvent("setAttachLockOFF",localPlayer,localPlayer)
	end
	end
	
	local item = exports['bgo_items']:hasItem(localPlayer, 145) --getElementData(localPlayer,"acc:id") == 1
	if item then 
	triggerServerEvent("setAttachMaconha",localPlayer,localPlayer)
	else
	if not getElementData(localPlayer, "setAttachMaconhaOFF") then
	triggerServerEvent("setAttachMaconhaOFF",localPlayer,localPlayer)
	end
	end
	
	
	
	local item = exports['bgo_items']:hasItem(localPlayer, 280) --getElementData(localPlayer,"acc:id") == 1
	if item then 
	triggerServerEvent("setAttachMec",localPlayer,localPlayer)
	else
	if not getElementData(localPlayer, "setAttachMecOFF") then
	triggerServerEvent("setAttachMecOFF",localPlayer,localPlayer)
	end
	end
	



	for a,b in ipairs(armas) do
	if exports['bgo_items']:hasItem(localPlayer, b) then 
	triggerServerEvent("setAttachColdri",localPlayer,localPlayer)
	tem = true
	return
	else
	tem = false
	end
	end
	
	if tem then 
	tem = false
	return
	end
	

	if not getElementData(localPlayer, "setAttachColdriOFF") then
	triggerServerEvent("setAttachColdriOFF",localPlayer,localPlayer)
	end
	


	
	--[[
	--local weaponType =exports['bgo_items']:hasItem(localPlayer, 44)
	
	if ( weaponType ) then
	triggerServerEvent("setAttachColdri",localPlayer,localPlayer)
	else
	if not getElementData(localPlayer, "setAttachColdriOFF") then
	triggerServerEvent("setAttachColdriOFF",localPlayer,localPlayer)
	end
	end
	]]--
	
	
end
setTimer( teste, 1000,0)





addEventHandler( "onClientResourceStart", getRootElement( ),
    function ()
	txd_floors = engineLoadTXD ( "model/drill.txd" )
	engineImportTXD ( txd_floors, 1548 )
	dff_floors = engineLoadDFF ( "model/drill.dff" )
	engineReplaceModel ( dff_floors, 1548 )

	--[[
	txd = engineLoadTXD ( "model/mec.txd" )
	engineImportTXD ( txd, 1510 )
	dff = engineLoadDFF ( "model/mec1.dff" )
	engineReplaceModel ( dff, 1510 )
	
	txd2 = engineLoadTXD ( "model/mec.txd" )
	engineImportTXD ( txd2, 1665 )
	dff2 = engineLoadDFF ( "model/mec2.dff" )
	engineReplaceModel ( dff2, 1665 )
	]]--
	txd3 = engineLoadTXD ( "model/coldri.txd" )
	engineImportTXD ( txd3, 1510 )
	dff3 = engineLoadDFF ( "model/coldri.dff" )
	engineReplaceModel ( dff3, 1510 )	
	
	txd4 = engineLoadTXD ( "model/moc.txd" )
	engineImportTXD ( txd4, 1511 )
	dff4 = engineLoadDFF ( "model/moc.dff" )
	engineReplaceModel ( dff4, 1511 )
	
	    end
	
);
