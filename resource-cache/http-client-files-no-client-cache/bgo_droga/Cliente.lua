local jobPed = {}
local job_PedPos = {
	-- MACONHA
	{105, -2134.5104980469,-2504.4086914063,31.816270828247, 228.48181152344, "Americano!", 144},
	{105, -2075.0554199219,-2526.3833007813,31.066806793213, 224.16423034668, "Americano!", 144},
	{105, -2102.541015625,-2480.8015136719,30.625, 231.51069641113, "Americano!", 144},
	{105, -2057.5405273438,-2464.5009765625,31.1796875, 139.83079528809, "Americano!", 144},
	{105, -2130.4931640625,-2434.7421875,30.625, 323.79373168945, "Americano!", 144},
	{105, -2102.38671875,-2418.55078125,30.625,  51.286998748779, "Americano!", 144},
	{105, -2142.8310546875,-2383.5971679688,30.625,  322.29943847656, "Americano!", 144},
	{105, -2089.0944824219,-2344.5529785156,30.625,  136.33764648438, "Americano!", 144},
	{105, -2075.8010253906,-2312.4499511719,31.13125038147, 53.094718933105, "Americano!", 144},
	{105,-2084.1484375,-2266.3701171875,30.753021240234,  143.64874267578, "Americano!", 144},
	{105, -2136.638671875,-2261.8129882813,30.631902694702,  318.15368652344, "Americano!", 144},
	{105, -2193.4562988281,-2255.41796875,30.692874908447, 140.67752075195, "Americano!", 144},
	{105, -2209.5932617188,-2288.1647949219,30.625,  319.36032104492, "Americano!", 144},
	{105, -2186.6726074219,-2311.412109375,30.625,  51.016731262207, "Americano!", 144},
	{105, -2202.07421875,-2340.2211914063,30.625, 51.097900390625, "Americano!", 144},
	{105, -2238.8664550781,-2424.1411132813,32.70726776123,  233.06878662109, "Americano!", 144},
	{105, -2238.8256835938,-2479.6477050781,31.200551986694, 317.95965576172, "Americano!", 144},
	{105, -2176.7961425781,-2474.4562988281,30.6171875,  127.45121765137, "Americano!", 144},
	{105, -2199.3864746094,-2512.0270996094,31.816270828247, 321.9052734375, "Americano!", 144},
	{105, -2159.9758300781,-2535.3659667969,31.816270828247, 10.149296760559, "Americano!", 144},
	{105, -2133.8139648438,-2514.5290527344,31.816272735596, 174.62754821777, "Americano!", 144},
	{105, -2175.5944824219,-2426.6518554688,30.625,  211.79466247559, "Americano!", 144},
	{105, -2198.8374023438,-2387.0388183594,30.625,  254.24012756348, "Americano!", 144},
	{105, -2234.9230957031,-2563.7465820313,31.921875, 59.099521636963, "Americano!", 144},
	
	
	
	--HEROINA
	{158, -206.01533508301,1032.7448730469,19.945363998413, 270.20034790039, "Americano!", 15},
	{158, -179.00344848633,1071.5697021484,19.7421875, 181.80752563477, "Americano!", 15},
	{158, -206.47264099121,1087.1635742188,19.7421875, 324.34362792969, "Americano!", 15},
	{158, -206.47264099121,1087.1635742188,19.7421875, 324.34362792969, "Americano!", 15},
	{158, -258.43206787109,1083.8087158203,20.939867019653, 281.01605224609, "Americano!", 15},
	{158, -253.26609802246,1118.5970458984,20.939867019653, 176.46612548828, "Americano!", 15},
	{158, -305.8515625,1120.5494384766,19.7421875, 172.416015625, "Americano!", 15},
	{158, -330.24395751953,1120.3950195313,20.939863204956, 159.12817382813, "Americano!", 15},
	{158, -362.48068237305,1111.2080078125,20.939865112305, 235.55888366699, "Americano!", 15},
	{158, -369.00054931641,1168.8454589844,20.27187538147, 224.90539550781, "Americano!", 15},
	{158, -330.15151977539,1172.6518554688,20.939863204956, 87.03742980957, "Americano!", 15},
	{158, -290.46740722656,1175.7384033203,20.939867019653, 212.47631835938, "Americano!", 15},
	{158, -251.11778259277,1174.6973876953,20.939863204956, 358.25881958008, "Americano!", 15},
	{158, -206.32205200195,1212.7347412109,19.890625, 263.23684692383, "Americano!", 15},
	{158, -207.33703613281,1157.5794677734,19.7421875, 7.2325143814087, "Americano!", 15},
	{158, -176.8384552002,1112.0299072266,19.7421875, 128.39790344238, "Americano!", 15},
	{158, -145.09761047363,1079.0670166016,20.4921875, 58.732902526855, "Americano!", 15},
	{158, -90.563804626465,1118.5759277344,20.786022186279, 345.53991699219, "Americano!", 15},
	{158, -43.697113037109,1082.9088134766,20.939863204956, 65.521865844727, "Americano!", 15},
	{158, -25.560539245605,1119.4145507813,19.7421875, 173.59956359863, "Americano!", 15},
	{158, 6.5228037834167,1082.6314697266,19.7421875, 70.198692321777, "Americano!", 15},
	{158, 14.336779594421,1120.7860107422,20.939867019653, 261.12484741211, "Americano!", 15},
	{158, 12.167748451233,1182.4957275391,19.576717376709, 176.00186157227, "Americano!", 15},
	{158, 12.167748451233,1182.4957275391,19.576717376709, 176.00186157227, "Americano!", 15},
	{158, -36.06799697876,1214.7774658203,19.352293014526, 176.41973876953, "Americano!", 15},
	{158, -52.51586151123,1178.9967041016,19.386161804199, 148.55609130859, "Americano!", 15},
	{158, -89.965957641602,1229.1927490234,19.7421875, 177.80076599121, "Americano!", 15},
	{158, -155.41738891602,1232.3516845703,19.7421875, 114.50691986084, "Americano!", 15},
	{158, -142.57623291016,1163.9846191406,19.7421875, 176.23416137695, "Americano!", 15},
	{158, -94.938949584961,1075.6818847656,19.749971389771, 233.55139160156, "Americano!", 15},
	{158, -32.754173278809,1038.5709228516,20.939867019653, 123.46594238281, "Americano!", 15},
	{158, -3.8628072738647,951.72961425781,19.703125, 355.31140136719, "Americano!", 15},
	{158, -86.752517700195,915.75933837891,21.098932266235, 62.051963806152, "Americano!", 15},
	{158, -151.67575073242,933.46759033203,19.723056793213, 264.86163330078, "Americano!", 15},
	
	
	--COCAINA
	{158, 1038.3555908203,1840.1163330078,11.468292236328, 89.395126342773, "Americano!", 14},
	{158, 984.35229492188,1895.8531494141,11.4609375, 185.56605529785, "Americano!", 14},
	{158, 1073.5205078125,1911.4715576172,10.8203125, 0.48890492320061, "Americano!", 14},
	{158, 1065.6059570313,1996.9685058594,10.8203125, 87.854370117188, "Americano!", 14},
	{158, 982.52197265625,1985.0853271484,11.468292236328, 1.0922291278839, "Americano!", 14},
	{158, 1030.7467041016,2040.6799316406,11.468292236328, 0.98775458335876, "Americano!", 14},
	{158, 1054.7664794922,2148.1071777344,10.8203125, 89.71981048584, "Americano!", 14},
	{158, 966.98156738281,2132.91015625,10.8203125, 269.13372802734, "Americano!", 14},
	{158, 1027.4487304688,2244.2043457031,10.8203125, 89.80094909668, "Americano!", 14},
	{158, 988.84283447266,2320.4738769531,11.4609375, 231.84661865234, "Americano!", 14},
	{158, 1036.5665283203,2347.3227539063,10.8203125, 183.30281066895, "Americano!", 14},
	{158, 947.07421875,2270.2685546875,11.46875, 6.0590062141418, "Americano!", 14},
	{158, 885.92736816406,2047.1123046875,11.4609375, 253.25805664063, "Americano!", 14},
	{158, 928.6376953125,2013.3627929688,11.4609375, 92.435455322266, "Americano!", 14},
	{158, 884.27111816406,1975.361328125,11.4609375, 180.04187011719, "Americano!", 14},
	{158, 938.49865722656,1920.4603271484,11.468292236328, 86.876586914063, "Americano!", 14},
	{158, 991.6669921875,1841.7716064453,10.705236434937, 305.32974243164, "Americano!", 14},
	{158, 1029.0258789063,1940.7019042969,11.468292236328, 2.6469163894653, "Americano!", 14},
	{158, 1028.0025634766,1992.4991455078,11.4609375, 180.18081665039, "Americano!", 14},
	{158, 958.75756835938,2044.6501464844,10.8203125, 202.00988769531, "Americano!", 14},
	{158, 1084.1385498047,2365.9086914063,10.8203125, 270.21270751953, "Americano!", 14},
	
}



function cDown ( )
    seconds = seconds - 1
    local mins,secds = secsToMin(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer( countDown )
        exports.bgo_hud:drawStat("Item", "", "", 200, 0, 0)
    else
        exports.bgo_hud:drawStat("Item", "Tempo de fuga: ", mins..":"..secds, 200, 0, 0)
    end
end
exports.bgo_hud:drawStat("Item", "", "", 200, 0, 0)


function secsToMin(seconds)
        local hours = 0
        local minutes = 0
        local secs = 0
        local theseconds = seconds
        if theseconds >= 60*60 then
            hours = math.floor(theseconds / (60*60))
            theseconds = theseconds - ((60*60)*hours)
        end
        if theseconds >= 60 then
            minutes = math.floor(theseconds / (60))
            theseconds = theseconds - ((60)*minutes)
        end
        if theseconds >= 1 then
            secs = theseconds
        end 
        if minutes < 10 then
            minutes = "0"..minutes
        end
        if secs < 10 then
            secs = "0"..secs
        end
    return minutes,secs
end




local bloqueio = false
local iniciou = false
keyTable = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b", "c", "e", "f", "g", "h", "i", "j", "k",
 "l", "n", "o", "p", "q", "r", "t", "u", "v", "x", "y", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "num_enter", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "escape", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=", "w", "a", "s", "d" }

addEventHandler("onClientKey", root, function(button, press) 
     if (bloqueio) then
	     for i,bindsK in ipairs(keyTable) do
             if (button == bindsK) then
                 cancelEvent() 
			 end
		 end
     end 
end)  

maleSkins = {0, 2, 7, 14, 15, 16, 17, 9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304,34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 310, 311, 312}



tabelaanim = {
[1] = {"bbalbat_idle_01"},
[2] = {"bbalbat_idle_02"},
[3] = {"crckdeth2"},
[4] = {"crckidle1"},
[5] = {"crckidle2"},
[6] = {"crckidle3"},
[7] = {"crckidle4"},
}


function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[5])
		jobPed[index]:setData("ped:vendadroga", true)
		jobPed[index]:setData("Ped:Name",value[6])
		jobPed[index]:setData("Ped:JOBa",value[7])
		pos = math.random(#maleSkins)
		setElementModel(jobPed[index], pos)
		setPedAnimation(jobPed[index] , "crack", tabelaanim[math.random(#tabelaanim)][1], -1, true, false, false)	
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:vendadroga") then
			cancelEvent ()
		end
	end
)

addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:vendadroga") and not iniciou then 
		if state == "down" and button == "right" and not isPedInVehicle(localPlayer) then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 3 then 
			if not exports['bgo_items']:hasItem(localPlayer, element:getData("Ped:JOBa")) then
			triggerEvent("bgo>info", localPlayer,"Americano!", "Você não tem o que eu quero! vaza daqui!", "info")
			uSound = playSound("some.ogg") 
			setSoundVolume(uSound, 0.5)
			return
			end
			elements = element
			CameraNoNPC(element)
			addEventHandler("onClientPreRender", root, createPanel)
					triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 13000, true, false, false)
					triggerEvent("progressService", localPlayer, 13, "#ffffffNegociando com o americano!")
					setTimer(function()
					bloqueio = true
					end,100,1)
					iniciou = true
					setPedAnimation(element, "GHANDS", "gsign4", 13000, true, false, false)
					tempo = setTimer(function()
					ResetCameraNPC()
					setElementData(element,"bgo:Negociou", true)
					iniciou = false
					elements = nil
					setPedAnimation(element)
					bloqueio = false
					triggerServerEvent("bgoMTA->#vendadedroga", localPlayer, localPlayer, element:getData("Ped:JOBa"))
					end,13000,1)
					
			end
		end
	end
end
)

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)
function createPanel()
		if iniciou then
 		local r, g, b = 255, 255, 255	
		if not isInSlot(sx*633,sy*615, sx*135,sy*30) then			
		dxDrawRectangle(sx*633,sy*615, sx*135,sy*30, tocolor(r, g, b, 255))
		else
		dxDrawRectangle(sx*633,sy*615, sx*135,sy*30, tocolor(r, g, b, 210))
		end	
		dxDrawText("Cancelar!", sx*1400, sy*1260, sx/2, 0, tocolor(0, 0, 0, 255), sy/0.7, "default", "center", "center", false, false, false, true)
	end
end

function teste(button, state, x, y, elementx, elementy, elementz, element)
	if state == "down" and button == "left" then 
	if iniciou then
	if isInSlot(sx*633,sy*615, sx*135,sy*30) then
	cancelRender()
	end
	end
	end
end
addEventHandler( "onClientClick", root, teste )

function cancelRender()
if isTimer(tempo) then
killTimer(tempo)
end
	removeEventHandler("onClientPreRender", root, createPanel)
	triggerEvent("bgo>info", localPlayer,"Americano!", "Vai maluco some daqui seu ramelão!", "erro")
	ResetCameraNPC()
	setElementData(elements,"bgo:Negociou", true)
	triggerServerEvent('btcMTA->#setPlayerAnimation', localPlayer, localPlayer, "GHANDS", "gsign4", 1000, true, false, false)
	triggerEvent("progressService", localPlayer, 0.1, "#ffffff")
	iniciou = false
	setPedAnimation(elements)
	bloqueio = false
	elements = nil
end




 function isInSlot( posX, posY, width, height )
  if isCursorShowing( ) then
    local mouseX, mouseY = getCursorPosition( )
    local clientW, clientH = guiGetScreenSize( )
    local mouseX, mouseY = mouseX * clientW, mouseY * clientH
    if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
      return true
    end
  end
  return false
end







local stoneTimer = {}
addEventHandler("onClientElementDataChange", root, function(dataName)
	if source and getElementType(source) == 'ped' and getElementData(source, 'ped:vendadroga') then 
		if tostring(dataName) == 'bgo:Negociou' then 
			if getElementData(source, dataName) == true then 
				setElementDimension(source, 500)
				stoneTimer[source] = setTimer(function(source)
					setElementData(source, 'bgo:Negociou', false)
				end, 1000*60*10, 1, source)
			elseif getElementData(source, dataName) == false then 
				setElementDimension(source, 0)
				setPedAnimation(source , "crack", tabelaanim[math.random(#tabelaanim)][1], -1, true, false, false)	
			end
		end
	end
end)



function acionar()
	if isTimer(countDown) then
	killTimer(countDown)
	seconds = 0
	end
	seconds = 300
	countDown = setTimer ( cDown, 1000, 300 )
end
addEvent("bgo->#darfuga", true)
addEventHandler("bgo->#darfuga", root, acionar)



function agradece(x,y,z)

local uSound = playSound3D("agradece.ogg", x,y,z) 
setSoundVolume(uSound, 0.5)
setSoundMaxDistance(uSound, 10)
		
end
addEvent("bgo->#agradece", true)
addEventHandler("bgo->#agradece", root, agradece)

function agradece(x,y,z)

local uSound = playSound3D("some.ogg", x,y,z) 
setSoundVolume(uSound, 0.5)
setSoundMaxDistance(uSound, 10)
		
end
addEvent("bgo->#somedaqui", true)
addEventHandler("bgo->#somedaqui", root, agradece)


		
		
local myBlip = {}


function blip()
			local players = getElementsByType ( "ped" ) -- get a table of all the players in the server
			for theKey,thePlayer in ipairs(players) do
			if thePlayer:getData("ped:vendadroga") then
			if exports['bgo_items']:hasItem(localPlayer, thePlayer:getData("Ped:JOBa")) then
			if thePlayer:getData("bgo:Negociou") then
			if isElement(myBlip[thePlayer]) then
			destroyElement(myBlip[thePlayer])
			end
				end
				if not isElement(myBlip[thePlayer]) then
				if not thePlayer:getData("bgo:Negociou") then
				myBlip[thePlayer] = createBlipAttachedTo (thePlayer,0 )
				setElementData(myBlip[thePlayer] ,"blipName", "Americano!")
				setBlipColor ( myBlip[thePlayer], 255, 255, 255, 255 )
				setBlipSize ( myBlip[thePlayer], 0.3 )
				end
				end
				else
				if isElement(myBlip[thePlayer]) then
				destroyElement(myBlip[thePlayer])
				end
			end
		end
	end
end
setTimer ( blip, 1000, 0 )


function onQuitGame( reason )
	if isElement(myBlip[source]) then
		destroyElement(myBlip[source])
	end
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )






-----------------------------------------------------
------CAMERA NPC
-----------------------------------------------------

local save_cam_matrix = {}

function CameraNoNPC(npc_id)

	npc = npc_id
	  

	save_cam_matrix.x, save_cam_matrix.y, save_cam_matrix.z, save_cam_matrix.lx, save_cam_matrix.ly, save_cam_matrix.lz = getCameraMatrix()
	x, y, z = getPositionFromElementOffset(npc,  0 , 3 , 1 ) 
		
	smoothMoveCamera(save_cam_matrix.x, save_cam_matrix.y, save_cam_matrix.z, save_cam_matrix.lx, save_cam_matrix.ly, save_cam_matrix.lz,
					x, y, z, npc.position.x, npc.position.y, npc.position.z + 0.6, 1500)
					
	--setPedAnimation(npc, "ped", "IDLE_chat")
end

function ResetCameraNPC()
	local x, y, z, lx, ly, lz = getCameraMatrix()
	smoothMoveCamera(x, y, z, lx, ly, lz, save_cam_matrix.x, save_cam_matrix.y, save_cam_matrix.z, save_cam_matrix.lx, save_cam_matrix.ly, save_cam_matrix.lz, 1500)
	
	setTimer(setCameraTarget, 1600, 1, localPlayer)
	setTimer(setCameraTarget, 1800, 1, localPlayer)
	
	setElementFrozen(npc, false)
	setElementFrozen(npc, true)
	setPedAnimation(npc)
	npc = nil
end








 
local sm = {
	moov = 0;
}

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end

local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientPreRender",root,camRender)
	end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	if not y2 then
		local _x1,_y1,_z1,_x1t,_y1t,_z1t = getCameraMatrix( )
		smoothMoveCamera(_x1,_y1,_z1,_x1t,_y1t,_z1t, x1,y1,z1,x1t,y1t,z1t, x2)
		return
	end

	sm.object1 = createObject(1337,x1,y1,z1)
	setElementCollisionsEnabled(sm.object1, false)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementCollisionsEnabled(sm.object2, false)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	addEventHandler("onClientPreRender",root,camRender)
	return true
end








function getPositionFromElementOffset(element,offX,offY,offZ) 
    local m = getElementMatrix ( element ) 
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1] 
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2] 
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3] 
    return x, y, z 
end 
  
  
  