 --[[
local panelX,panelY = guiGetScreenSize()


local panelW,panelH = 660,200
local sx, sy = panelX/2 - panelW/2,panelY/2 - panelH/2
]]--

local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx, sy = (screenW/resW), (screenH/resH)


local jobPed = {}
local roboto = dxCreateFont("files/Roboto.ttf",14)



local job_PedPos = {
	{227, 1098.9729003906,-1684.8519287109,13.538749694824, "Empregos para LS", 359.13549804688},
	-- {2, 2035.3885498047, -2448.5388183594, 13.611819267273, "PentiX egy köcsög buzi aki kitörölte a városháza mappot...."},
}
local startTick = getTickCount()
local progress = ""
local elements = ""

local jobs_Table = { 
	{"Ifood", "ifood", 155, 0}, 
	{"Transporte de Gasolina", "Transporte de Gasolina", 182, 3},
	{"Transporte de Valores", "Transporte de Valores", 71, 7},
	{"Eletricista", "Eletrecista", 260, 10}, 
}

local maxElem = 7
local nextPage = 0
local show = false

function createPeds() 
	for index,value in ipairs (job_PedPos) do
		if isElement(jobPed[index]) then destroyElement(jobPed[index]) end
		jobPed[index] = createPed(value[1], value[2], value[3], value[4])
		setElementFrozen(jobPed[index], true)
		setPedRotation(jobPed[index], value[6])
		jobPed[index]:setData("ped:jobLS", true)
		jobPed[index]:setData("Ped:Name",value[5])
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createPeds)
createPeds()

addEventHandler ( "onClientPedDamage", getRootElement(), 
	function ()
		if getElementData(source,"ped:jobLS") then
			cancelEvent ()
		end
	end
)

function createPanel()
		local jX, jY, jZ = getElementPosition(getLocalPlayer())
		local bX, bY, bZ = getElementPosition(elements)
		if (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then removeEventHandler("onClientRender", root, createPanel) removeEventHandler("onClientKey",root,keyControl) show = false return end

		local x, y, _ = interpolateBetween ( 
		-500, 0 ,0,
		0, 0, 0,
		(getTickCount()-startTick)/1000, "OutQuad")
		
		dxDrawImage(x, y,sx*1300,sy*800, "files/bg.png", 0, 0, 0, tocolor(255,255,255,255))
		local x2, _, _ = interpolateBetween ( 
		sy/0.5, 0 ,0,
		sy/0.6, 0, 0,
		(getTickCount()-startTick2)/2000, "CosineCurve")
		
		
		local x, y, _ = interpolateBetween ( 
		sx*371, sy*11 ,0,
		sx*371, sy*91, 0,
		(getTickCount()-startTick)/1000, "OutQuad")
		
		
		dxDrawText("BGO Empregos",x+1, y+1, sx/2, 0,tocolor(0,0,0,255),x2,"default","center","top",false,false,false,true)
		dxDrawText("BGO #FFFFFFEmpregos",x, y, sx/2, 0,tocolor(255,255,255,255),x2,"default","center","top",false,false,false,true)
		

		local alpha, _, _ = interpolateBetween ( 
		100, 0 ,0,
		155, 0, 0,
		(getTickCount()-startTick2)/3000, "CosineCurve")
		
		local alpha2, _, _ = interpolateBetween ( 
		0, 0 ,0,
		255, 0, 0,
		(getTickCount()-startTick)/2000, "OutQuad")
		
		
		local xx2, yy2, _ = interpolateBetween ( 
		sx*171, sy*296 ,0,
		sx*171, sy*266, 0,
		(getTickCount()-startTick)/2000, "OutQuad")
	
		local xx3, yy3, _ = interpolateBetween ( 
		sx*371, sy*656 ,0,
		sx*371, sy*596, 0,
		(getTickCount()-startTick)/2000, "OutQuad")
		
		local xa, _, _ = interpolateBetween ( 
		sy/0.5, 0 ,0,
		sy/0.6, 0, 0,
		(getTickCount()-startTick2)/5000, "CosineCurve")
		
		dxDrawText("Gire a bolinha do mouse para descer/subir",xx3, yy3, sx/2, 0,tocolor(255,255,155,alpha2),xa-1.1,"default","center","top",false,false,false,true)
		
		
		local elem = 0
		for index, value in ipairs (jobs_Table) do 
		if (index > nextPage and elem < maxElem) then
		elem = elem + 1
		local text = ""
		local r, g, b = 124, 197, 118

		if localPlayer:getData("job") ==  value[2] then 
		text = "Demitir"
		r, g, b = 220,20,60
		else
		text = "Trabalhar"
		r, g, b = 124, 197, 118

		end

		
		dxDrawText(value[1].."", xx2, yy2-100+elem*(sy*50), sx/2, sy/0, tocolor(0, 0, 0, alpha2), sy/0.7, "default", "center", "top", false, false, false, true)
		dxDrawText(value[1].."", xx2, yy2-100+elem*(sy*50), sx/2, sy/0, tocolor(255, 255, 255, alpha2), sy/0.7, "default", "center", "top", false, false, false, true)

		dxDrawText("Level: #ffffff"..value[4].."", xx2+851, yy2-109+elem*(sy*50), sx/2, sy/0, tocolor(0, 0, 0, alpha2), sy/0.7, "default", "center", "top", false, false, false, true)

		dxDrawText("#00ff00Level: #ffffff"..value[4].."", xx2+850, yy2-110+elem*(sy*50), sx/2, sy/0, tocolor(255, 255, 255, alpha2), sy/0.7, "default", "center", "top", false, false, false, true)

		
		if aprovar then
		local xx, yy, _ = interpolateBetween ( 
		sx*1-100, sy*250 ,0,
		sx*210, sy*250, 0,
		(getTickCount()-startTick3)/1500, "OutQuad")
		


		if isInSlot(xx, yy-95+elem*(sy*50), sx*120, sy*40) then
		dxDrawButton(text, xx, yy-95+elem*(sy*50), sx*120, sy*40, tocolor(r, g, b, alpha))
		else
		dxDrawButton(text, xx, yy-95+elem*(sy*50), sx*120, sy*40, tocolor(r, g, b, alpha-100))
		end
		end
		
		end
		

		if isInSlot(sx*110, sy*650, sx*120, sy*40) then
		dxDrawButton("Sair", sx*110, sy*650, sx*120, sy*40, tocolor(124, 197, 118, alpha))
		else
		dxDrawButton("Sair", sx*110, sy*650, sx*120, sy*40, tocolor(124, 197, 118, alpha-100))
		end
		
		
	end
end


function dxDrawButton(text, startX, startY, width, height, color)
	dxDrawRectangle(startX - 1, startY, 1, height, bgColor) --left
	dxDrawRectangle(startX + width, startY, 1, height, bgColor) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, bgColor) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, bgColor) --bottom
	dxDrawRectangle(startX, startY, width, height, color)
	dxDrawText(text, startX+1, startY+1, startX + width, startY + height, tocolor(0, 0, 0,255), 1.5, "default", "center", "center", false, false, false, true)
	dxDrawText(text, startX, startY, startX + width, startY + height, tocolor(255, 255, 255,255), 1.5, "default", "center", "center", false, false, false, true)

end
				
local altura = 0
addEventHandler("onClientClick", root, function (button, state, x, y, elementx, elementy, elementz, element)
	if element and element:getData("ped:jobLS") and not show then 
		if state == "down" and button == "right" then 
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, elementx, elementy, elementz) <= 5 then 
				startTick = getTickCount()
				startTick2 = getTickCount()
				aprovar = true
				startTick3 = getTickCount()
				
				progress = "OutBack"
				removeEventHandler("onClientRender", root, createPanel)
				addEventHandler("onClientRender", root, createPanel)
				removeEventHandler("onClientKey",root,keyControl)
				addEventHandler("onClientKey",root,keyControl)
				show = true
				elements = element
			end
		end
	elseif state == "down" and button == "left" and show then 
	if isInSlot(sx*110, sy*650, sx*120, sy*40) then
	removeEventHandler("onClientRender", root, createPanel)
	removeEventHandler("onClientKey",root,keyControl)
	show = false
	elements = nil
	aprovar = false
	end
	
		elem = 0
		for index, value in ipairs (jobs_Table) do 
			if (index > nextPage and elem < maxElem) then
				elem = elem + 1
				--if isInSlot(sx/2+70, sy/2.8-95+elem*(60), 120, 40) then 
				if dobozbaVan(sx*210, sy*250-95+elem*(sy*50), sx*120, sy*40, x, y) then 
						--exports.bgo_infobox:addNotification("teste !","success")
					local level = localPlayer:getData("Sys:Level") 
					if level >= jobs_Table[index][4] then
					if localPlayer:getData("job") == jobs_Table[index][2] then 
						triggerServerEvent("trabalhoLS", resourceRoot, localPlayer, "SemEmprego", 0)
						triggerServerEvent("demitirLS", resourceRoot, localPlayer)
					elseif jobs_Table[index][2] ~= localPlayer:getData("job") or localPlayer:getData("job") == "SemEmprego" or localPlayer:getData("job") == "0" or localPlayer:getData("job") == "" then 
						triggerServerEvent("trabalhoLS", resourceRoot, localPlayer, jobs_Table[index][2],tonumber(jobs_Table[index][3]))
						--exports.bgo_infobox:addNotification("Você pegou com sucesso o emprego de "..jobs_Table[index][1].." !","success")
					else
						exports.bgo_infobox:addNotification("Você já tem um emprego para demitir use /demitir!","error")
					end
					currentjob = jobs_Table[index][2]
					else
					exports.bgo_infobox:addNotification("Você precisa ser level "..jobs_Table[index][4].." para trabalhar!","error")
					end

				end
			end
		end
		end
end)

function keyControl(k, s)
	if k == "mouse_wheel_up" then
		if(nextPage>0)then
			nextPage = nextPage - 1
		end
	elseif k == "mouse_wheel_down" then
		nextPage = nextPage + 1
		if(nextPage > #jobs_Table-maxElem)then
			nextPage = #jobs_Table-maxElem
		end
	elseif k == "backspace" then
		removeEventHandler("onClientRender", root, createPanel)
		removeEventHandler("onClientKey",root,keyControl)
		show = false
	end
end	

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

--[[
function startPlayerJob(ID)
	if not localPlayer then return end
	--outputChatBox(ID)
	if (tonumber(ID) == 1) then 
		startTransportJob()	
	elseif (tonumber(ID) == 2) then 
		startJob()	
	elseif (tonumber(ID) == 3) then 
		createMarkerToJob()	
	elseif (tonumber(ID) == 6) then 
		createMarkerFunction()
	end
end

function destroyPlayerJob(ID)
	if not localPlayer then return end
	if (tonumber(ID) == 1) then 
		destroyTransportJob()	
	elseif (tonumber(ID) == 2) then 
		destroyJob()	
	end
end

function munkaSpawn()
	local Loggedin = getElementData(localPlayer, "loggedin")

	if (Loggedin) then
		jelenlegiMunka = tonumber(localPlayer:getData("job"))
		if (jelenlegiMunka == 1) then -- Járműszállító
			startTransportJob()
		else
			destroyTransportJob()
		end		
		if (jelenlegiMunka == 2) then -- Pizza
			startJob()
		else
			destroyJob()
		end		
	end
end

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "player" and dataName == "job" then
		if getElementData(source,dataName) == 1 then
			startTransportJob()
		else
			destroyTransportJob()
		end		
		if getElementData(source,dataName) == 2 then
			startJob()
		else
			destroyJob()
		end		
		if getElementData(source,dataName) == 3 then
			createMarkerToJob()
		else
			destroyStorageBox()
		end		
	end
end )


addEventHandler("onClientPlayerSpawn", localPlayer, 
	function()
		setTimer(munkaSpawn, 1000, 1)
	end
)

addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( resource )
		if (resource ~= getThisResource()) then return end
        setTimer(munkaSpawn, 1000, 1)
    end
)]]--


addEvent ("hudids",true)
function fechar22()
	exports.bgo_hud:drawStat("PizzaID", "", "", 255, 200, 0)
	exports.bgo_hud:drawStat("BusDriver", "", "")
	exports.bgo_hud:drawProgressBar("BusLoad", "")
	exports.bgo_hud:drawStat("MailCarrier", "", "", 255, 200, 0)
	triggerServerEvent("GTImailcarrier.terminateJob", resourceRoot, ig_shift)
	exports.bgo_hud:drawStat("TrainDriver", "", "")
	exports.bgo_hud:drawProgressBar("TrainLoad", "")
	local x,y,z = getElementPosition(localPlayer)
	--exports.bgo_util:markPlayer(x,y,z)
	exports.bgo_util:unmark(player)
end

addEventHandler ("hudids", root,  fechar22)
