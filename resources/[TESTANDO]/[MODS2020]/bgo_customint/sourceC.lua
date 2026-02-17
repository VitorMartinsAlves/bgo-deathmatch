 local screenWidth, screenHeight = guiGetScreenSize()

function reMap(value, low1, high1, low2, high2)
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

local responsiveMultiplier = reMap(screenWidth, 1024, 1920, 0.75, 1)

function resp(value)
	return value * responsiveMultiplier
end

function respc(value)
	return math.ceil(value * responsiveMultiplier)
end


bindKey ("m", "down",
function()
    showCursor( not isCursorShowing() )
end)



local objectsToLoad = {
	{"files/models/wall",3271}, -- corner
	{"files/models/wall2",3269}, -- normal wall
	{"files/models/wall3",3270}, -- x wall16256
	{"files/models/wall4",16256}, -- wall közép
	{"files/models/wall5",6040}, -- normal wall
	{"files/models/wall6",7431}, -- wall one side
	{"files/models/wall7",7462}, -- wall lyukas
	{"files/models/floor",7429}, -- wall one side
	{"files/models/door",8859},
	{"files/models/door2",9082},
  -- Premium items
  {"files/models/tv1",2648, "files/models/tv"},
  {"files/models/tv2",14772, "files/models/tv"},
  {"files/models/urma4k",1786},
  {"files/models/xmas",7027},
}

local dbIDmultiplier = 7777
local selectedTextureIndex = 0
local texturechanger = {}
local createdWallObjects = {}
createdWallObjects[1] = {}
createdWallObjects[2] = {}

local walltexturechanger = {}
local innerwalltexturechanger = {}
local innerwalltexturechanger2 = {}

local itemsToTexture = {}
local headDoorApplied = false
local headDoorSaveTable = {}
local inDoorTable = {}
local inDoorObj = nil
local objTable = {}

local saveTextureTable = {}
local saveCreatedWalls = {}
local saveCreatedWalls2 = {}
local saveFurnitures = {}
local saveFloorTexture = {}
local saveCeilTexture = {}
local saveInnerWallTexture = {}
local saveInnerWallTexture2 = {}
local saveDoorObjects = {}
local saveDoorTextures = {}


wallDataTable = {
	wallBuildingClickState = false,
	wallCursorPosX = 0,
	wallCursorPosY = 0,
	wallType = "",
	wallIndex = 0,
	wallIndexActColumn = 0,
	wallClickedIndex = 0,
	wallClickedIndexActColumn = 0,
	wallSelectedTable = {},
}

renderData = {
	editState = false,
	actualPage = 1,
	menuPage = 1,
	selectedLine = 1,
	ceilState = false,
	rightTabMenu = {
		{"files/icons/save.png", "save", "", "Sair e Salvar"},
		{"files/icons/lightoff.png", "light", "files/icons/lighton.png", "Luz on/off"},
		{"files/icons/gridoff.png", "grid", "files/icons/gridon.png", "Linhas on/off"},
		{"files/icons/test.png", "test", "", "Modo teste on"},
		{"files/icons/musicoff.png", "music", "files/icons/musicon.png", "Musica on/off"},
		{"files/icons/soundoff.png", "sound", "files/icons/soundon.png", "Sons on/off"},
		{"files/icons/exit.png", "exit", "", "Sair"},
	},
	lightState = true,
	musicState = true,
	soundState = true,
	gridState = true,
  testState = false,
	rightMenuDirectX = "",
}

scrollData = {
	scrollNum = 0,
	menuMaxShowing = 15,
	tableNumber = 0
}

local loadTextureChanger = nil
function receiveTextureClient(element, texture, texName)
	texture = dxCreateTexture(texture)
	loadTextureChanger = dxCreateShader("files/texturechanger.fx")
	engineApplyShaderToWorldTexture(loadTextureChanger, texName, element)
	dxSetShaderValue (loadTextureChanger, "gTexture", texture)
end
addEvent( "receiveTextureClient", true )
addEventHandler( "receiveTextureClient", localPlayer, receiveTextureClient )

function receiveWallsClient(dbid, wallTable1, wallTable2)

end
addEvent( "receiveWallsClient", true )
addEventHandler( "receiveWallsClient", localPlayer, receiveWallsClient )


function startLoading(s)
	if s then
			for i,c in ipairs(objectsToLoad) do
				if tostring(i) ~= tostring(c) then
					ChangeObjectModel(c[1],c[2],c[3])
				end
			end
	end
end

function ChangeObjectModel (filename,id, spec)
	if id and filename then
    if not spec then
  		if fileExists(filename..".txd") then
  			txd = engineLoadTXD( filename..".txd", true)
  			engineImportTXD( txd, id )
  		else
  			txd = engineLoadTXD( "files/models/wall.txd", true)
  			engineImportTXD( txd, id )
  		end
    else
      txd = engineLoadTXD(spec..".txd", true)
      engineImportTXD( txd, id )
    end
		if fileExists(filename..".dff") then
			dff = engineLoadDFF( filename..".dff", 0)
			engineReplaceModel( dff, id )
		end
		if fileExists(filename..".col") then
			col = engineLoadCOL( filename..".col" )
			engineReplaceCOL( col, id )
		end
	end
end


addEventHandler("onClientResourceStart",getResourceRootElement(), function()
	startLoading(true)
	--setSkyGradient( 212, 217, 255, 255, 255, 255 )
	--setSkyGradient( 255, 255, 255, 121, 163, 196 )
	--setCloudsEnabled ( false )
end)

--[[
------------
-- FLOORS --
------------
local wallLength = 3.21
local wallLength2 = .17


local ox, oy, oz = 1165.2939453125, -3872.89453125, 1300.72039794922
local floorTable = {}
local row, column = 8, 8
local total = row*column

local actColumn = 0
local counter = 0

for i = 1, total do
	counter = counter + 1
	floorTable[i] = createObject(7429, ox+counter*3.21, oy+actColumn*3.21, oz)
	setElementRotation(floorTable[i], 0, 90,0)
--	dxDrawRectangle(1920/2+counter*55, 1080/2+actColumn*55, 50, 50)
	if counter == row then
		counter = 0
		actColumn = actColumn + 1
	end
end

------------
-- FLOORS --
------------

------------
-- ROOF ----
------------
local actColumn = 0
local counter = 0
local roofTable = {}
for i = 1, total do
	counter = counter + 1
	roofTable[i] = createObject(7429, 0+counter*3.21, 0+actColumn*3.21, 0+wallLength+wallLength2)
	setElementRotation(roofTable[i], 0, 90,0)

--	dxDrawRectangle(1920/2+counter*55, 1080/2+actColumn*55, 50, 50)
	if counter == row then
		counter = 0
		actColumn = actColumn + 1
	end
end

-- WALLS --

local wallTable = {}
local row, column = 8, 8
local total = row*4
local actColumn = 0
local counter = 0
local wallObjID = 3269
local doorObj = nil
local lastWallOffSet = 0

for i = 1, total do
	if i > total/2 then
		--counter = counter + 1
		if actColumn ~= row then
			actColumn = actColumn +1
		end
		if i == total then
			wallObjID = 8859
		end
		wallTable[i] = createObject(wallObjID, ox+wallLength+(actColumn-1)*wallLength, oy-wallLength/2-wallLength2+(counter)*wallLength+wallLength2, oz+1.66)
		if i == total then
			doorObj = createObject(1494, 0,0,0)
			attachElements(doorObj, wallTable[i],0,-0.74,-1.75,0,0,90)
		end
		if i > total/2+total/4 then
			setElementRotation(wallTable[i], 0,0,-90)
			setElementData(wallTable[i], "wallIndex", 4)
		else
			setElementRotation(wallTable[i], 0,0,90)
			setElementData(wallTable[i], "wallIndex", 3)
		end
		if actColumn == row then
			actColumn = 0
			counter = row
		end
	else
		counter = counter + 1
		if i <= total/4 then
			lastWallOffSet = 0
		else
			lastWallOffSet = -wallLength2/2*row+wallLength2/2
		end

		wallTable[i] = createObject(wallObjID, ox+wallLength/2-wallLength2/2+actColumn*(wallLength+(wallLength2/2))+lastWallOffSet, oy+(counter-1)*wallLength, oz+1.66)
		if counter == row then
			counter = 0
			actColumn = column
		end
		if i <= total/4 then
			setElementData(wallTable[i], "wallIndex", 1)
		else
			setElementData(wallTable[i], "wallIndex", 2)
		end

		if i == total/2 then
			counter = 0
			actColumn = 0
		end
	end
end
]]

local camRotating = false
local ox, oy, oz = 1165.2939453125, -3872.89453125, 1300.72039794922
local wallLength = 3.21
local wallLength2 = .17
local camObj = nil
local editedInteriorDBID = 0
local backGroundMusic = nil

addCommandHandler("editar", function(playerSource)
    for k, v in pairs(getElementsByType("marker")) do
      if getElementData(v, "isIntMarker") then
        if getElementData(v, "customint") == 1 then
		if getElementData(v,"owner") == getElementData(localPlayer,"acc:id") then
          if isElementWithinMarker(localPlayer, v) then
			deleteEditorObjects()
            rotX, rotY = -2.4942306143592,-0.26175
            editedInteriorDBID = getElementData(v,"acc:id")
						editableSize = getElementData(v,"size")
        		setElementDimension(localPlayer, getElementData(v,"acc:id")+dbIDmultiplier)
            setElementAlpha(localPlayer, 0)
            setElementData(localPlayer, "allseeoff", true)
						triggerServerEvent("changeDimInt", localPlayer, localPlayer, getElementData(v,"acc:id")+dbIDmultiplier, getElementData(v,"acc:id")+dbIDmultiplier, ox, oy, oz)
            triggerServerEvent("checkForSavingsServer", localPlayer, localPlayer,getElementData(v,"acc:id"))
          	renderData.editState = true
            setTime(12, 0)
            setWeather(0)
						--fadeCamera(false)
            camObj = createObject(1271, ox+editableSize/2*wallLength+1.2, oy+editableSize/2*wallLength-wallLength/2, oz+0.5)
            setElementDimension(camObj, getElementData(v,"acc:id")+dbIDmultiplier)
            setElementAlpha(camObj, 0)
            setCustomCameraTarget(camObj)
						--fadeCamera(true, 2)
						setSkyGradient( 255, 255, 255, 73, 133, 230 )
						setCloudsEnabled(false)
            setBirdsEnabled(false)
            showChat(false)
            local randomMusic = math.random(1,7)
            backGroundMusic = playSound("files/sound/background"..randomMusic..".mp3", true)
			 end
			 end
        end
      end
    end
end)

--local receivedTextureTable = false
function receiveClientEditDatas(dbid, state, textureTable)
--	iprint(textureTable)
	if state then
	--	receivedTextureTable = textureTable
	--	iprint(receivedTextureTable)
	--	saveTextureTable = textureTable
	end
--	createClientHouse(dbid, editableSize)
end
addEvent( "receiveClientEditDatas", true )
addEventHandler( "receiveClientEditDatas", getRootElement(), receiveClientEditDatas )


local floorTable = {}
local roofTable = {}
local wallTable = {}
local editableSize = 4
local editDimension = 0
local doorObj = nil
function createClientHouse(dimID, size, receivedTextureTable, wallObjects1, wallObjects2, furnitures, floorTextureTable, ceilTextureTable, innerWallTexture, innerWallTexture2, receivedDoors, receivedDoorTextures, headDoorTable)
	-- FLOORS --
	if not receivedTextureTable then
		for k = 1, size*4 do
			saveTextureTable[k] = {}
			--outputChatBox("lefutcreate")
		end
	else
		saveTextureTable = receivedTextureTable
	end

	local row, column = (size), (size)
	editableSize = size
	editDimension = dimID
	local total = row*column

	local actColumn = 0
	local counter = 0

	for i = 1, total do
		counter = counter + 1
		floorTable[i] = createObject(7429, ox+counter*3.21, oy+actColumn*3.21, oz)
		setElementRotation(floorTable[i], 0, 90,0)
		setElementDimension(floorTable[i], dimID+dbIDmultiplier)
		if counter == row then
			counter = 0
			actColumn = actColumn + 1
		end
	end


	-- ROOF ---
	local actColumn = 0
	local counter = 0

	for i = 1, total do
		counter = counter + 1
		roofTable[i] = createObject(7429, 0+counter*3.21, 0+actColumn*3.21, 0+wallLength+wallLength2)
		setElementRotation(roofTable[i], 0, 90,0)
		setElementDimension(roofTable[i], dimID+dbIDmultiplier)
		if counter == row then
			counter = 0
			actColumn = actColumn + 1
		end
	end

	-- WALLS --


	local row, column = tonumber(size), tonumber(size)
	local total = row*4
	local actColumn = 0
	local counter = 0
	local wallObjID = 3269
	local lastWallOffSet = 0

	for i = 1, total do
		if i > total/2 then
			--counter = counter + 1
			if actColumn ~= row then
				actColumn = actColumn +1
			end
      if not headDoorTable then
  			if i == total then
  				wallObjID = 8859
  			end
      else
        if i == headDoorTable[1] then
  				wallObjID = 8859
        else
          wallObjID = 3269
  			end
      end
			wallTable[i] = createObject(wallObjID, ox+wallLength+(actColumn-1)*wallLength, oy-wallLength/2-wallLength2+(counter)*wallLength+wallLength2, oz+1.66)
		--	setElementInterior(wallTable[i], dimID)
			setElementDimension(wallTable[i], dimID+dbIDmultiplier)
      if not headDoorTable then
  			if i == total then
  				doorObj = createObject(1494, 0,0,0)
  				setElementDimension(doorObj, dimID+dbIDmultiplier)
  				attachElements(doorObj, wallTable[i],0,-0.74,-1.75,0,0,90)
  			end
      else
        headDoorSaveTable = headDoorTable
        doorObj = createObject(1494, 0,0,0)
        setElementDimension(doorObj, dimID+dbIDmultiplier)
        attachElements(doorObj, wallTable[headDoorTable[1]],0,-0.74,-1.75,0,0,90)
        for i,player in pairs(getElementsByType("player")) do
          local texture = dxCreateTexture(headDoorTable[2])
          loadTextureChanger = dxCreateShader("files/texturechanger.fx")
          engineApplyShaderToWorldTexture(loadTextureChanger, "*", doorObj)
          dxSetShaderValue (loadTextureChanger, "gTexture", texture)
        end
      end
			if i > total/2+total/4 then
				setElementRotation(wallTable[i], 0,0,-90)
				setElementData(wallTable[i], "wallIndex", 4)
			else
				setElementRotation(wallTable[i], 0,0,90)
				setElementData(wallTable[i], "wallIndex", 3)
			end
			if actColumn == row then
				actColumn = 0
				counter = row
			end
		else
			counter = counter + 1
			if i <= total/4 then
				lastWallOffSet = 0
			else
				lastWallOffSet = -wallLength2/2*row+wallLength2/2
			end
      if headDoorTable then
				if i == headDoorTable[1] then
	  			wallObjID = 8859
				else
					wallObjID = 3269
	  		end
			end
			wallTable[i] = createObject(wallObjID, ox+wallLength/2-wallLength2/2+actColumn*(wallLength+(wallLength2/2))+lastWallOffSet, oy+(counter-1)*wallLength, oz+1.66)
		--	setElementInterior(wallTable[i], dimID)
			setElementDimension(wallTable[i], dimID+dbIDmultiplier)
			if counter == row then
				counter = 0
				actColumn = column
			end
			if i <= total/4 then
				setElementData(wallTable[i], "wallIndex", 1)
			else
				setElementData(wallTable[i], "wallIndex", 2)
			end

			if i == total/2 then
				counter = 0
				actColumn = 0
			end
		end
	end

	-- // From SQL saved Things \\ --
	if receivedTextureTable then
		for k, v in pairs(wallTable) do
			for textureK, textureV in pairs(receivedTextureTable) do
				if textureV.index1 then
					if textureV.index1[1] == k then
						for i,player in pairs(getElementsByType("player")) do
							local texture = dxCreateTexture(textureV.index1[2])
							loadTextureChanger = dxCreateShader("files/texturechanger.fx")
							engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index1[3], v)
							dxSetShaderValue (loadTextureChanger, "gTexture", texture)
						end
					end
				end
				if textureV.index2 then
					if textureV.index2[1] == k then
						for i,player in pairs(getElementsByType("player")) do
							local texture = dxCreateTexture(textureV.index2[2])
							loadTextureChanger = dxCreateShader("files/texturechanger.fx")
							engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index2[3], v)
							dxSetShaderValue (loadTextureChanger, "gTexture", texture)
						end
					end
				end
			end
		end
	end
	if wallObjects1 then
		for k, v in pairs(wallObjects1) do
			createdWallObjects[1][k] = createObject(v[2],v[3],v[4],v[5],v[6],v[7],v[8])
			setElementDimension(createdWallObjects[1][k], dimID+dbIDmultiplier)
		end
	end
	if wallObjects2 then
		for k, v in pairs(wallObjects2) do
			createdWallObjects[2][k] = createObject(v[2],v[3],v[4],v[5],v[6],v[7],v[8])
			setElementDimension(createdWallObjects[2][k], dimID+dbIDmultiplier)
		end
	end
	if receivedDoors then
    for doorK, doorV in pairs(receivedDoors) do
      if doorV.index1 then
          if not inDoorTable[doorK] then
            inDoorTable[doorK] = {}
          end
          inDoorTable[doorK]["index1"] = createObject(doorV.index1[2],doorV.index1[3],doorV.index1[4],doorV.index1[5],doorV.index1[6],doorV.index1[7],doorV.index1[8])
          setElementDimension(inDoorTable[doorK]["index1"], dimID+dbIDmultiplier)
      end
    end
    for doorK, doorV in pairs(receivedDoors) do
      if doorV.index2 then
          if not inDoorTable[doorK] then
            inDoorTable[doorK] = {}
          end
          inDoorTable[doorK]["index2"] = createObject(doorV.index2[2],doorV.index2[3],doorV.index2[4],doorV.index2[5],doorV.index2[6],doorV.index2[7],doorV.index2[8])
          setElementDimension(inDoorTable[doorK]["index2"], dimID+dbIDmultiplier)
      end
    end
	end
  if receivedDoorTextures then

    saveDoorTextures = receivedDoorTextures

    for k, v in pairs(inDoorTable) do
      for textureK, textureV in pairs(receivedDoorTextures) do
        --for doorK, doorV in pairs(doorObjects) do
        if k == textureK then
          if textureV.index1 then
            for i,player in pairs(getElementsByType("player")) do
							local texture = dxCreateTexture(textureV.index1[2])
							loadTextureChanger = dxCreateShader("files/texturechanger.fx")
							engineApplyShaderToWorldTexture(loadTextureChanger, "*", inDoorTable[k]["index1"])
							dxSetShaderValue (loadTextureChanger, "gTexture", texture)
						end
          end
          if textureV.index2 then
            for i,player in pairs(getElementsByType("player")) do
							local texture = dxCreateTexture(textureV.index2[2])
							loadTextureChanger = dxCreateShader("files/texturechanger.fx")
							engineApplyShaderToWorldTexture(loadTextureChanger, "*", inDoorTable[k]["index2"])
							dxSetShaderValue (loadTextureChanger, "gTexture", texture)
						end
          end
        end
      end
    end
  end
	if innerWallTexture then
    saveInnerWallTexture = innerWallTexture
		for k, v in pairs(createdWallObjects[1]) do
			for textureK, textureV in pairs(innerWallTexture) do
        if k == textureK then
  				if textureV.index1 then
  						local texture = dxCreateTexture(textureV.index1[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index1[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
          if textureV.index2 then
  						local texture = dxCreateTexture(textureV.index2[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index2[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
          if textureV.index3 then
  						local texture = dxCreateTexture(textureV.index3[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index3[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
          if textureV.index4 then
  						local texture = dxCreateTexture(textureV.index4[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index4[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
        end
			end
		end
	else
	--	for k, v in pairs(createdWallObjects[1]) do
	--		saveInnerWallTexture[k] = {}
	--	end
	end
	if innerWallTexture2 then
    saveInnerWallTexture2 = innerWallTexture2
		for k, v in pairs(createdWallObjects[2]) do
			for textureK, textureV in pairs(innerWallTexture2) do
        if k == textureK then
          if textureV.index1 then
  						local texture = dxCreateTexture(textureV.index1[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index1[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
          if textureV.index2 then
  						local texture = dxCreateTexture(textureV.index2[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index2[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
          if textureV.index3 then
  						local texture = dxCreateTexture(textureV.index3[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index3[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
          if textureV.index4 then
  						local texture = dxCreateTexture(textureV.index4[2])
  						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
  						engineApplyShaderToWorldTexture(loadTextureChanger, textureV.index4[3], v)
  						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
  				end
        end
			end
		end
	else
	--	for k, v in pairs(createdWallObjects[2]) do
		--	saveInnerWallTexture2[k] = {}
	--	end
	end
	if furnitures then
		for k, v in pairs(furnitures) do
      local furnOffSetX, furnOffSetY, furnOffSetZ = 0,0,0
      local r = 0
      local xOffset = 0
      local yOffset = 0
      if furnitureOffSetTable[v[1]] then
        furnOffSetX, furnOffSetY, furnOffSetZ = furnitureOffSetTable[v[1]][1], furnitureOffSetTable[v[1]][2], furnitureOffSetTable[v[1]][3]
        if v[5] > 0 then
          r = -v[5]*math.pi/180
          xOffset = math.cos(r)*furnOffSetX+math.sin(r)*furnOffSetY
          yOffset = -math.sin(r)*furnOffSetX+math.cos(r)*furnOffSetY
        else
          xOffset = furnOffSetX
          yOffset = furnOffSetY
        end
      end
			objTable[k] = {
					obj = createObject(v[1],v[2]+xOffset,v[3]+yOffset,v[4]+furnOffSetZ,0,0,v[5]),
					middlePosX = v[2],
					middlePosY = v[3],
					middlePosZ = v[4],
					rotation = v[5],
          fromSQLLoaded = true,
			}
			setElementDimension(objTable[k].obj, dimID+dbIDmultiplier)
			setElementData(objTable[k].obj, "obj:index", k)
		end
	end
	if floorTextureTable then
		saveFloorTexture = floorTextureTable
		for k, v in pairs(floorTable) do
			for textureK, textureV in pairs(floorTextureTable) do
				if textureV[1] then
					if textureV[1] == k then
						local texture = dxCreateTexture(textureV[4])
						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
						engineApplyShaderToWorldTexture(loadTextureChanger, "la_carp"..textureV[2], v)
						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
					end
				end
			end
		end
	else
		local row, column = size*2, size*2
		local total = row*column
		for i = 1, total do
			saveFloorTexture[i] = {}
		end
	end
	if ceilTextureTable then
		saveCeilTexture = ceilTextureTable
		for k, v in pairs(roofTable) do
			for textureK, textureV in pairs(ceilTextureTable) do
				if textureV[1] then
					if textureV[1] == k then
						local texture = dxCreateTexture(textureV[4])
						loadTextureChanger = dxCreateShader("files/texturechanger.fx")
						engineApplyShaderToWorldTexture(loadTextureChanger, "la_carp"..textureV[2], v)
						dxSetShaderValue (loadTextureChanger, "gTexture", texture)
					end
				end
			end
		end
	else
		local row, column = size*2, size*2
		local total = row*column
		for i = 1, total do
			saveCeilTexture[i] = {}
		end
	end
end
addEvent("createHouseObjectsClient", true)
addEventHandler("createHouseObjectsClient",getRootElement(), createClientHouse)


function deleteEditorObjects()
	for k, v in pairs(floorTable) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	floorTable = {}
	for k, v in pairs(roofTable) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	roofTable = {}
	for k, v in pairs(wallTable) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	wallTable = {}
	for k, v in pairs(createdWallObjects[1]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	createdWallObjects[1] = {}
  saveCreatedWalls = {}
	for k, v in pairs(createdWallObjects[2]) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	createdWallObjects[2] = {}
  saveCreatedWalls2 = {}

  for k, v in pairs(objTable) do
		if isElement(v.obj) then
			destroyElement(v.obj)
		end
	end
  objTable = {}

  if isElement(inDoorObj) then
    destroyElement(inDoorObj)
  end
  inDoorObj = nil
  if isElement(doorObj) then
    destroyElement(doorObj)
  end
  doorObj = nil

  for k, v in pairs(inDoorTable) do
    if isElement(v["index1"]) then
      destroyElement(v["index1"])
    end
    if isElement(v["index2"]) then
      destroyElement(v["index2"])
    end
  end
  inDoorTable = {}
end


-- \\ CAMERA FUNCTIONS //  --

local options = {
	key_fastMove = "lshift",
	key_slowMove = "lalt",
	key_forward = "forwards",
	key_backward = "backwards",
	key_left = "left",
	key_right = "right",
	key_forward_veh = "accelerate",
	key_backward_veh = "brake_reverse",
	key_left_veh = "vehicle_left",
	key_right_veh = "vehicle_right"
}

local controlToKey = {
	["forwards"] = "w",
	["backwards"] = "s",
	["left"] = "a",
	["right"] = "d",
	["accelerate"] = "w",
	["brake_reverse"] = "s",
	["vehicle_left"] = "a",
	["vehicle_right"] = "d",
}


local rotX, rotY, rotRadius, maxRadius = 890.115055, -1.35104, 40, 40
local isCustomCamera = false
local cameraTarget = nil
local sX, sY = guiGetScreenSize()

local mta_getKeyState = getKeyState
function getKeyStatePlus(key)
	if isMTAWindowActive() then
		return false
	end
	if key == "lshift" or key == "lalt" or key == "arrow_u" or key == "arrow_d" or key == "arrow_l" or key == "arrow_r" then
		return mta_getKeyState(key)
	end
	if isPedDead(localPlayer) then
		-- We must use getKeyState when dead we also have to hope they're using WASD
		return mta_getKeyState(controlToKey[key])
	else
		-- We can use getControlState
		return getPedControlState(key)
	end
end



function getRotationFromCamera(offset)
	local cameraX, cameraY, _, faceX, faceY = getCameraMatrix()
	local deltaX, deltaY = faceX - cameraX, faceY - cameraY
	local rotation = math.deg(math.atan(deltaY / deltaX))

	if (deltaY >= 0 and deltaX <= 0) or (deltaY <= 0 and deltaX <= 0) then
		rotation = rotation + 180
	end

	return -rotation + 90 + offset
end


addEventHandler("onClientPreRender", root,
    function()
        if isCustomCamera and isElement(cameraTarget) and renderData.editState then

            local x, y, z = getElementPosition( cameraTarget )
            local cx, cy, cz

            cx = x + rotRadius * math.sin(rotY) * math.cos(rotX)
            cy = y + rotRadius * math.sin(rotY) * math.sin(rotX)
            cz = z + rotRadius * math.cos(rotY)

            local hit, hitX, hitY, hitZ = processLineOfSight(x, y, z, cx, cy, cz, false, false, false, false, _, _, _, _, cameraTarget)
            if hit then
                cx, cy, cz = hitX, hitY, hitZ
            end

            setCameraMatrix( cx, cy, cz, x, y, z )
        end
    end
)

addEventHandler("onClientKey", root,
    function(button)
      if renderData.editState and not isCursorWithinPanel() then
          if button == "mouse_wheel_up" then
              rotRadius = math.max(2, rotRadius - 1)
          elseif button == "mouse_wheel_down" then
              rotRadius = math.min(maxRadius, rotRadius + 1)
          end
      end
    end
)

addEventHandler("onClientCursorMove", root,
    function(cX,cY,aX,aY)
        if isCursorShowing() or isMTAWindowActive() or not renderData.editState or not camRotating then return end

        aX = aX - sX/2
        aY = aY - sY/2

        rotX = rotX - aX * 0.01745 * 0.3
        rotY = math.min(-0.02, math.max( rotY + aY * 0.01745 * 0.3, -3.11 ) )
    end
)

function setCustomCameraTarget(element)
    if isElement(element) then
        cameraTarget = element
        isCustomCamera = true
        return true
    else
        cameraTarget = nil
        isCustomCamera = false
    end
end

-- CAMERA FUNCTIONS END --

function addLabelOnClick ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if not renderData.editState then
		return
	end
	local row, column = editableSize*2, editableSize*2
	local total = row*column
	local actColumn = 0
	local counter = 0
	local plusZ = 0.1
	local szorzo = 3.21
	local wh = 1.6
	local textureString = ""
	local hitCollision, hitPosX, hitPosY, hitPosZ
	local cameraPosX, cameraPosY, cameraPosZ = getCameraMatrix()
	local cursorWorldPosX, cursorWorldPosY, cursorWorldPosZ = getWorldFromScreenPosition(cursorX, cursorY, 1000)
	local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ = processLineOfSight(cameraPosX, cameraPosY, cameraPosZ, cursorWorldPosX, cursorWorldPosY, cursorWorldPosZ, true, true, true, true, true, true, false, true)
	hitCollision, hitPosX, hitPosY, hitPosZ = hit, hitX, hitY, hitZ
	if not hitCollision then
		hitPosX, hitPosY, hitPosZ = -1000, -1000, -1000
	end
	local normIndex = 0
	local rightleftIndex = 0
	if button == "left" and state == "down" then
		--[[
		if renderData.actualPage == 2 then
		 	if clickedElement then
				for i = 1, total do
					texturechanger[i] = dxCreateShader("files/texturechanger.fx")
					counter = counter + 1
					if (hitPosX >= ox+counter*3.21/2 and hitPosX <= ox+counter*3.21/2 + 1.6 and hitPosY >= oy+actColumn*3.21/2-1.6 and hitPosY <= oy+actColumn*3.21/2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
						print(i)
						if counter %2 ~= 0 then
							if actColumn %2 ~= 0 then
								engineApplyShaderToWorldTexture(texturechanger[i], "la_carp6", clickedElement)
								dxSetShaderValue (texturechanger[i], "gTexture", textureDataTable[selectedTextureIndex][1])
							end
						end
						if counter %2 == 0 then
							if actColumn %2 ~= 0 then
								engineApplyShaderToWorldTexture(texturechanger[i], "la_carp5", clickedElement)
								dxSetShaderValue (texturechanger[i], "gTexture", textureDataTable[selectedTextureIndex][1])
							end
						end
						if counter %2 == 0 then
							if actColumn %2 == 0 then
								engineApplyShaderToWorldTexture(texturechanger[i], "la_carp4", clickedElement)
								dxSetShaderValue (texturechanger[i], "gTexture", textureDataTable[selectedTextureIndex][1])
							end
						end
						if counter %2 ~= 0 then
							if actColumn %2 == 0 then
								engineApplyShaderToWorldTexture(texturechanger[i], "la_carp3", clickedElement)
								dxSetShaderValue (texturechanger[i], "gTexture", textureDataTable[selectedTextureIndex][1])
							end
						end
					end
					if counter == row then
						counter = 0
						actColumn = actColumn + 1
					end
				end
			end
		end]]
	end
	--[[
	if button == "left" and state == "up" then
		if renderData.actualPage == 1 then
			if renderData.selectedLine == 1 then
				for i = 1, total do
					counter = counter + 1
					if counter %2 ~= 0 and actColumn %2 == 0 then
						if (hitPosX >= ox+counter*szorzo/2 and hitPosX <= ox+counter*szorzo/2 + (wh) and hitPosY >= oy+actColumn*szorzo/2-wh + (wh)-0.1 and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
							createdWallObjects[#createdWallObjects+1] = createObject(7431, ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh + (wh), oz+1.66,0,0,-90)
						elseif (hitPosX >= ox+counter*szorzo/2+wh and hitPosX <= ox+counter*szorzo/2 + wh*2 and hitPosY >= oy+actColumn*szorzo/2-wh-0.1 + wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
							createdWallObjects[#createdWallObjects+1] = createObject(7431, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+1.66,0,0,-90)
						elseif (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2-wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
							createdWallObjects[#createdWallObjects+1] = createObject(7431, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2-wh, oz+1.66,0,0,0)
						elseif (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2 and hitPosY <= oy+actColumn*szorzo/2-wh + wh*2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
							createdWallObjects[#createdWallObjects+1] = createObject(7431, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+1.66,0,0,0)
						end
					end
					if counter == row then
						counter = 0
						actColumn = actColumn + 1
					end
				end
			end
		end
		wallDataTable.wallBuildingClickState = false
		wallDataTable.wallType = ""
	end]]
	if button == "left" and state == "up" then
		if wallDataTable.wallBuildingClickState then
			if renderData.actualPage == 1 and renderData.menuPage == 1 then
				if renderData.selectedLine == 1 then
					local actColumn = 0
					local counter = 0
					local row, column = editableSize*2, editableSize*2
					local total = row*column
					for i = 1, total do
						counter = counter + 1
						normIndex = normIndex + 1
						rightleftIndex = rightleftIndex + 1
						if counter %2 ~= 0 and actColumn %2 == 0 then
							if wallDataTable.wallType == "updown" then
								if boxesIntersect(wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, oy+actColumn*szorzo/2-wh, (oy+actColumn*szorzo/2-wh + wh)-(oy+actColumn*szorzo/2-wh)) then
									if wallDataTable.wallIndex == counter then
										if not isElement(createdWallObjects[1][normIndex]) then
											if isElement(createdWallObjects[1][normIndex+1]) then
												setElementModel(createdWallObjects[1][normIndex+1], 3269)
											else
												createdWallObjects[1][normIndex] = createObject(7431, ox+wallDataTable.wallIndex*szorzo/2+wh, oy+actColumn*szorzo/2-wh, oz+1.66)
												setElementDimension(createdWallObjects[1][normIndex], editDimension+dbIDmultiplier)
											end
										end
									end
								end
								normIndex = normIndex +1
								if boxesIntersect(wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, oy+actColumn*szorzo/2, (oy+actColumn*szorzo/2-wh + wh*2)-(oy+actColumn*szorzo/2)) then
									if wallDataTable.wallIndex == counter then
										if not isElement(createdWallObjects[1][normIndex]) then
											if isElement(createdWallObjects[1][normIndex-1]) then
												createdWallObjects[1][normIndex] = createObject(3269, ox+wallDataTable.wallIndex*szorzo/2+wh, oy+actColumn*szorzo/2, oz+1.66)
												setElementDimension(createdWallObjects[1][normIndex], editDimension+dbIDmultiplier)
												destroyElement(createdWallObjects[1][normIndex-1])
											else
												createdWallObjects[1][normIndex] = createObject(7431, ox+wallDataTable.wallIndex*szorzo/2+wh, oy+actColumn*szorzo/2, oz+1.66)
												setElementDimension(createdWallObjects[1][normIndex], editDimension+dbIDmultiplier)
											end
										end
									end
								end
							end
							if wallDataTable.wallType == "leftright" then
								if boxesIntersect(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+counter*szorzo/2+wh, wh) then
									if wallDataTable.wallIndexActColumn == actColumn then
										if not isElement(createdWallObjects[2][rightleftIndex]) then
											if isElement(createdWallObjects[2][rightleftIndex+1]) then
												createdWallObjects[2][rightleftIndex] = createObject(3269, ox+counter*szorzo/2+wh, oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + (wh), oz+1.66)
												setElementRotation(createdWallObjects[2][rightleftIndex], 0,0,-90)
												destroyElement(createdWallObjects[2][rightleftIndex+1])
												setElementDimension(createdWallObjects[2][rightleftIndex], editDimension+dbIDmultiplier)
											else
												createdWallObjects[2][rightleftIndex] = createObject(7431, ox+counter*szorzo/2+wh, oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + (wh), oz+1.66)
												setElementRotation(createdWallObjects[2][rightleftIndex], 0,0,-90)
												setElementDimension(createdWallObjects[2][rightleftIndex], editDimension+dbIDmultiplier)
											end
										end
									end
								end
								rightleftIndex = rightleftIndex + 1
								if boxesIntersect(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+counter*szorzo/2, wh) then
									if wallDataTable.wallIndexActColumn == actColumn then
										if not isElement(createdWallObjects[2][rightleftIndex]) then
											if isElement(createdWallObjects[2][rightleftIndex-1]) then
												setElementModel(createdWallObjects[2][rightleftIndex-1], 3269)
											else
												createdWallObjects[2][rightleftIndex] = createObject(7431, ox+counter*szorzo/2, oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + (wh), oz+1.66)
												setElementRotation(createdWallObjects[2][rightleftIndex], 0,0,-90)
												setElementDimension(createdWallObjects[2][rightleftIndex], editDimension+dbIDmultiplier)
											end
										end
									end
								end
							end
						end
						if counter == row then
							counter = 0
							actColumn = actColumn + 1
						end
					end
				end
				if renderData.selectedLine == 3 then
					local szamol = 0
					for i = 1, total do
						counter = counter + 1
						normIndex = normIndex + 1
						if counter %2 ~= 0 and actColumn %2 == 0 then
							if boxesIntersect(wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, oy+actColumn*szorzo/2, wh) and boxesIntersect(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+counter*szorzo/2+wh, wh) then
								szamol = szamol + 1
								for k, v in pairs(createdWallObjects[1]) do
									if isElement(v) then
										local wallX,wallY,wallZ = getElementPosition(v)
										if boxesIntersectVH(ox+counter*szorzo/2, wh*2, oy+actColumn*szorzo/2-wh, wh*2, wallX,wallLength2, wallY,wh-0.1) then
											destroyElement(v)
                      createdWallObjects[1][k] = nil
                      if inDoorTable[k] then
                        if isElement(inDoorTable[k]["index1"]) then
                          destroyElement(inDoorTable[k]["index1"])
                        end
                        if isElement(inDoorTable[k]["index2"]) then
                          destroyElement(inDoorTable[k]["index2"])
                        end
                      end
										end
									end
								end
								for k, v in pairs(createdWallObjects[2]) do
									if isElement(v) then
										local wallX,wallY,wallZ = getElementPosition(v)
										if boxesIntersectVH(ox+counter*szorzo/2, wh*2, oy+actColumn*szorzo/2-wh, wh*2, wallX,wh-0.1, wallY,wallLength2) then
											destroyElement(v)
                      createdWallObjects[2][k] = nil
                      if inDoorTable[k] then
                        if isElement(inDoorTable[k]["index1"]) then
                          destroyElement(inDoorTable[k]["index1"])
                        end
                        if isElement(inDoorTable[k]["index2"]) then
                          destroyElement(inDoorTable[k]["index2"])
                        end
                      end
										end
									end
								end
							end
						end
						if counter == row then
							counter = 0
							actColumn = actColumn + 1
						end
					end
				end
			end
		end
		if selectedTextureIndex > 0 then
			--// APPLY SHADER to FLOOR \\--
      if not isCursorWithinPanel() then
  			if renderData.actualPage == 2 then
  				for k, v in pairs(itemsToTexture) do
  					texturechanger[v[3]] = dxCreateShader("files/texturechanger.fx")
  					engineApplyShaderToWorldTexture(texturechanger[v[3]], "la_carp"..v[2], v[1])
  					dxSetShaderValue (texturechanger[v[3]], "gTexture", textureDataTable[selectedTextureIndex][1])
  					saveFloorTexture[v[3]] = {v[4], v[2], v[3], textureDataTable[selectedTextureIndex][2]}
  				end

  				itemsToTexture = {}
  			end
  			if renderData.ceilState then
  				for k, v in pairs(itemsToTexture) do
  					texturechanger[v[3]] = dxCreateShader("files/texturechanger.fx")
  					engineApplyShaderToWorldTexture(texturechanger[v[3]], "la_carp"..v[2], v[1])
  					dxSetShaderValue (texturechanger[v[3]], "gTexture", textureDataTable[selectedTextureIndex][1])
  					saveCeilTexture[v[3]] = {v[4], v[2], v[3], textureDataTable[selectedTextureIndex][2]}
  				end
  				itemsToTexture = {}
  			end
      end

			--// DOOR CREATION - Clicking \\--
			if renderData.actualPage == 3 then
				if renderData.menuPage == 1 then
					if selectedTextureIndex == 1 then
						for k, v in pairs(createdWallObjects[1]) do
							if isElement(v) then
								if hitElement then
									if inDoorTable[k] then
										if isElement(inDoorTable[k]["index1"]) then
											indexedDoor = inDoorTable[k]["index1"]
										else
											indexedDoor = false
										end
									else
										indexedDoor = false
									end
									if hitElement == v or hitElement == indexedDoor then
										if isElement(inDoorTable[k]["index1"]) then
											destroyElement(inDoorTable[k]["index1"])
											setElementModel(v, 3269)
										end
									end
								end
							end
						end
						for k, v in pairs(createdWallObjects[2]) do
							if isElement(v) then
								if hitElement then
									if inDoorTable[k] then
										if isElement(inDoorTable[k]["index2"]) then
											indexedDoor2 = inDoorTable[k]["index2"]
										else
											indexedDoor2 = false
										end
									else
										indexedDoor2 = false
									end
									if hitElement == v or hitElement == indexedDoor2 then
										if isElement(inDoorTable[k]["index2"]) then
											destroyElement(inDoorTable[k]["index2"])
											setElementModel(v, 3269)
										end
									end
								end
							end
						end
					end
						  if selectedTextureIndex > 1 and selectedTextureIndex < 11 then
									for k, v in pairs(wallTable) do
										--if isElement(v) then
												--if hitElement then
									--if lastHitWall ~= v then
									--if not headDoorApplied then
									if hitElement == v and not isCursorWithinPanel() then
										triggerServerEvent("changeInteriorEntrance", localPlayer, editedInteriorDBID, k, editableSize*4)
										headDoorSaveTable = {k, textureDataTable[selectedTextureIndex][2]}
										headDoorApplied = true
									  end
									--end
								 -- end
								--end
							  --end
							end
						  end
					if selectedTextureIndex > 10 and selectedTextureIndex < 17 then
						for k, v in pairs(createdWallObjects[1]) do
							if isElement(v) then
								if hitElement then
									--if lastHitWall2 ~= v then
										if hitElement == v then
											if not inDoorTable[k] then
												inDoorTable[k] = {}
											end
											if not isElement(inDoorTable[k]["index1"]) then
												local id = getElementModel(v)
											--	local lastHitID = getElementModel(lastHitWall2)
												if id ~= 7431 then
													--lastHitWall2 = v
													setElementModel(v, 8859)
													if isElement(inDoorObj) then
														destroyElement(inDoorObj)
													end
													inDoorTable[k]["index1"] = createObject(itemsTable[3]["Doors"][selectedTextureIndex][4], 0,0,0)
													setElementDimension(inDoorTable[k]["index1"], editDimension+dbIDmultiplier)
													setElementData(inDoorTable[k]["index1"], "openState", true)
													attachElements(inDoorTable[k]["index1"],v,0,-0.74,-1.75,0,0,90)
                          -- texturizing
													local doorTexture = dxCreateShader("files/texturechanger.fx")
													engineApplyShaderToWorldTexture(doorTexture, "*", inDoorTable[k]["index1"])
													dxSetShaderValue (doorTexture, "gTexture", itemsTable[3]["Doors"][selectedTextureIndex][1])
													detachElements(inDoorTable[k]["index1"])
                          if not saveDoorTextures[k] then
                            saveDoorTextures[k] = {}
                          end
                          saveDoorTextures[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2]}
												end
											end
										end
									--end
								end
							end
						end
						for k, v in pairs(createdWallObjects[2]) do
							if isElement(v) then
								if hitElement then
									--if lastHitWall2 ~= v then
										if hitElement == v then
											if not inDoorTable[k] then
												inDoorTable[k] = {}
											end
											if not isElement(inDoorTable[k]["index2"]) then
												local id = getElementModel(v)
											--	local lastHitID = getElementModel(lastHitWall2)
												--outputChatBox(id)
												if id ~= 7431 then
													--lastHitWall2 = v
													setElementModel(v, 8859)
													if isElement(inDoorObj) then
														destroyElement(inDoorObj)
													end

													inDoorTable[k]["index2"] = createObject(itemsTable[3]["Doors"][selectedTextureIndex][4], 0,0,0)
													setElementDimension(inDoorTable[k]["index2"], editDimension+dbIDmultiplier)
													setElementData(inDoorTable[k]["index2"], "openState", true)
													attachElements(inDoorTable[k]["index2"],v,0,-0.74,-1.75,0,0,90)
													local doorTexture = dxCreateShader("files/texturechanger.fx")
													engineApplyShaderToWorldTexture(doorTexture, "*", inDoorTable[k]["index2"])
													dxSetShaderValue (doorTexture, "gTexture", itemsTable[3]["Doors"][selectedTextureIndex][1])
													detachElements(inDoorTable[k]["index2"])
                          if not saveDoorTextures[k] then
                            saveDoorTextures[k] = {}
                          end
                          saveDoorTextures[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2]}
												end
											end
										end
									--end
								end
							end
						end
					end
				end
			end
		end
		wallDataTable.wallBuildingClickState = false
		wallDataTable.wallType = ""
	end
	if button == "left" and state == "down" then
		if not wallDataTable.wallBuildingClickState then
			if renderData.actualPage == 1 and renderData.menuPage == 1 then
				--if renderData.selectedLine == 1 then
					for i = 1, total do
						counter = counter + 1
						if counter %2 ~= 0 and actColumn %2 == 0 then
							if (hitPosX >= ox+counter*szorzo/2 and hitPosX <= ox+counter*szorzo/2 + (wh) and hitPosY >= oy+actColumn*szorzo/2-wh + (wh)-0.1 and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								local cursorX, cursorY = getCursorPosition()
								wallDataTable.wallCursorPosX = hitPosX
								wallDataTable.wallCursorPosY = hitPosY
								wallDataTable.wallBuildingClickState = true
								wallDataTable.wallType = "leftright"
								wallDataTable.wallIndexActColumn = actColumn
							elseif (hitPosX >= ox+counter*szorzo/2+wh and hitPosX <= ox+counter*szorzo/2 + wh*2 and hitPosY >= oy+actColumn*szorzo/2-wh-0.1 + wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								local cursorX, cursorY = getCursorPosition()
								wallDataTable.wallCursorPosX = hitPosX
								wallDataTable.wallCursorPosY = hitPosY
								wallDataTable.wallBuildingClickState = true
								wallDataTable.wallType = "leftright"
								wallDataTable.wallIndexActColumn = actColumn
							elseif (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2-wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								local cursorX, cursorY = getCursorPosition()
								wallDataTable.wallCursorPosX = hitPosX
								wallDataTable.wallCursorPosY = hitPosY
								wallDataTable.wallBuildingClickState = true
								wallDataTable.wallType = "updown"
								wallDataTable.wallIndex = counter
								wallDataTable.wallIndexActColumn = actColumn
							elseif (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2 and hitPosY <= oy+actColumn*szorzo/2-wh + wh*2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								local cursorX, cursorY = getCursorPosition()
								wallDataTable.wallCursorPosX = hitPosX
								wallDataTable.wallCursorPosY = hitPosY
								wallDataTable.wallBuildingClickState = true
								wallDataTable.wallType = "updown"
								wallDataTable.wallIndex = counter
								wallDataTable.wallIndexActColumn = actColumn
							end
						end
						if counter == row then
							counter = 0
							actColumn = actColumn + 1
						end
					end
			end
			if renderData.actualPage == 2 or renderData.ceilState then
				for i = 1, total do
					counter = counter + 1
					if (hitPosX >= ox+counter*3.21/2 and hitPosX <= ox+counter*3.21/2 + 1.6 and hitPosY >= oy+actColumn*3.21/2-1.6 and hitPosY <= oy+actColumn*3.21/2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
						wallDataTable.wallCursorPosX = hitPosX
						wallDataTable.wallCursorPosY = hitPosY
						wallDataTable.wallBuildingClickState = true
						wallDataTable.wallIndex = counter
						wallDataTable.wallIndexActColumn = actColumn
					end
					if counter == row then
						counter = 0
						actColumn = actColumn + 1
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), addLabelOnClick )
--if (number % 2 == 0) then
--    .....it is páros
--else
--    .....it is páratlan
--end
local totalGridNum = 28*28

local lastHitWall = nil
local lastHitWall2 = nil
local lastHitWallIndex = 0

local redcircle = dxCreateTexture("files/green.png")

addEventHandler("onClientPreRender",root,
    function()
		--	dxSetRenderTarget(groundTarget, true)
		--			dxDrawRectangle(0,0, 800, 800)
		--	dxSetRenderTarget()
		--	dxDrawMaterialLine3D( 0+200, 0, 0-0.1, 0-200, 0, 0-0.1, groundTarget, 400, tocolor(212, 217, 255,255),false, 0, 0, 0-10)
		end
)


local groundTarget = dxCreateRenderTarget (400, 400, false)
local groundTarget2 = dxCreateRenderTarget (400, 400, true)

function render()
	if not renderData.editState then
		return
	end
	local ox, oy, oz = 1165.2939453125, -3872.89453125, 1300.72039794922 -- Basic position
  dxDrawImage(0, 0, screenWidth, screenHeight, "files/vin.png")
  dxDrawRectangle(respc(15), respc(15), respc(25), respc(25), tocolor(0,0,0,180))
  dxDrawImage(respc(15), respc(15), respc(24), respc(24), "files/icons/info.png")
  -- \\ CAMERA MOVING // --
  local camBoxX,camBoxY,camBoxZ = getElementPosition(camObj)
  if not renderData.testState then
    if getKeyState("w") then
      setElementPosition(camObj, camBoxX-0.2*math.sin(rotY)*math.cos(rotX),camBoxY-0.2*math.sin(rotY)*math.sin(rotX),camBoxZ)
      showCursor(false)
    elseif getKeyState("s") then
      setElementPosition(camObj, camBoxX+0.2*math.sin(rotY)*math.cos(rotX),camBoxY+0.2*math.sin(rotY)*math.sin(rotX),camBoxZ)
      showCursor(false)
    elseif getKeyState("d") then
      local angle = getRotationFromCamera(90)
      angle = math.rad(angle)
      setElementPosition(camObj, camBoxX + math.sin(angle) * 0.2 * 1,camBoxY + math.cos(angle) * 0.2 * 1,camBoxZ)
      showCursor(false)
    elseif getKeyState("a") then
      local angle = getRotationFromCamera(90)
      angle = math.rad(angle)
      setElementPosition(camObj, camBoxX - math.sin(angle) * 0.2 * 1,camBoxY - math.cos(angle) * 0.2 * 1,camBoxZ)
      showCursor(false)
    elseif getKeyState("mouse2") then
      setCursorPosition(screenWidth/2, screenHeight/2)
      showCursor(false)
      camRotating = true
    else
      camRotating = false
      showCursor(true)
    end
  end
	if not renderData.ceilState then
	--	dxSetRenderTarget(groundTarget, true)
	--			dxDrawRectangle(0,0, 100, 100)
	--	dxSetRenderTarget()
	--	dxDrawMaterialLine3D( ox+200, oy, oz-0.1, ox-200, oy, oz-0.1, groundTarget, 400, tocolor(212, 217, 255,255), ox, oy, oz-10)
	--	dxDrawRectangle3D(ox, oy, oz-0.1,500,500, tocolor(212, 217, 255,255))
		--dxSetRenderTarget(groundTarget, true)
		--		dxDrawRectangle(0,0, 800, 800)
		--dxSetRenderTarget()
		--dxDrawMaterialLine3D( ox+200, oy, oz-0.1, ox-200, oy, oz-0.1, groundTarget, 400, tocolor(212, 217, 255,255),false, ox, oy, oz-10)

    if renderData.gridState then
  		local gridCounter = 0
  		local gridColumn = 0
  		for grid = 1, totalGridNum do
  		--	print(grid)
  			gridCounter = gridCounter + 1
  			drawStripeBorder(ox-14*wallLength+gridCounter*wallLength-wallLength/2, oy-14*wallLength+gridColumn*wallLength-wallLength/2, oz-0.1, ox-14*wallLength+wallLength+gridCounter*wallLength-wallLength/2, oy-14*wallLength+wallLength+gridColumn*wallLength-wallLength/2, oz-0.1,2, tocolor(255,255,255,255), false)

  			if gridCounter == 28 then
  				gridCounter = 0
  				gridColumn = gridColumn +1
  			end
  		end
    end
	end


	local hitCollision, hitPosX, hitPosY, hitPosZ
	local cameraPosX, cameraPosY, cameraPosZ = getCameraMatrix()
	local cursorWorldPosX, cursorWorldPosY, cursorWorldPosZ = getWorldFromScreenPosition(cursorX, cursorY, 1000)
	local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ = processLineOfSight(cameraPosX, cameraPosY, cameraPosZ, cursorWorldPosX, cursorWorldPosY, cursorWorldPosZ, true, true, true, true, true, true, false, true)
	hitCollision, hitPosX, hitPosY, hitPosZ = hit, hitX, hitY, hitZ
	if not hitCollision then
		hitPosX, hitPosY, hitPosZ = -1000, -1000, -1000
	end

	local row, column = editableSize*2, editableSize*2
	local total = row*column
	local actColumn = 0
	local counter = 0
	local plusZ = 0.1
	local szorzo = 3.21
	local wh = 1.6
	local textureString = ""
	local normIndex = 0
	-- // Texturizing Floor \\ --
	if not renderData.ceilState then
		if renderData.actualPage == 2 then
			for i = 1, total do
				counter = counter + 1
				--if (hitPosX >= ox+counter*3.21/2 and hitPosX <= ox+counter*3.21/2 + 1.6 and hitPosY >= oy+actColumn*3.21/2-1.6 and hitPosY <= oy+actColumn*3.21/2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
				drawStripeBorder(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ,1, tocolor(255,255,255,255))
				if wallDataTable.wallBuildingClickState then
					if boxesIntersectVH(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, ox+counter*szorzo/2, wh, oy+actColumn*szorzo/2-wh, wh) and not isCursorWithinPanel() then
						drawStripeBorder(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, 2.5)
						if counter %2 ~= 0 then
							if actColumn %2 ~= 0 then
								textureString = "6"
							end
						end
						if counter %2 == 0 then
							if actColumn %2 ~= 0 then
								textureString = "5"
							end
						end
						if counter %2 == 0 then
							if actColumn %2 == 0 then
								textureString = "4"
							end
						end
						if counter %2 ~= 0 then
							if actColumn %2 == 0 then
								textureString = "3"
							end
						end
						--local lastHitElement = false
						for k, v in pairs(floorTable) do
							if isElement(v) then
								local floorX,floorY,floorZ = getElementPosition(v)
								if boxesIntersectVH(ox+counter*szorzo/2, wh*2, oy+actColumn*szorzo/2-wh, wh*2, floorX,szorzo,floorY,szorzo) then
									lastHitElement = v
									indexFloor = k
								end
							end
						end
						if not itemsToTexture[i] then
							itemsToTexture[i] = {lastHitElement, textureString, i, indexFloor}
						end
					else
						itemsToTexture[i] = nil
					end
				else
					if (hitPosX >= ox+counter*szorzo/2 and hitPosX <= ox+counter*3.21/2 + 1.6 and hitPosY >= oy+actColumn*szorzo/2-wh and hitPosY <= oy+actColumn*szorzo/2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) and not isCursorWithinPanel() then
						drawStripeBorder(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, 2.5)
					end
				end
				if counter == row then
					counter = 0
					actColumn = actColumn + 1
				end
			end
		else
			local szamol = 0
			for i = 1, total do
				counter = counter + 1
				normIndex = normIndex + 1
				if counter %2 ~= 0 and actColumn %2 == 0 then
				--	if (hitPosX >= ox+counter*3.21/2 and hitPosX <= ox+counter*3.21/2 + 1.6 and hitPosY >= oy+actColumn*3.21/2-1.6 and hitPosY <= oy+actColumn*3.21/2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
					--	drawStripeBorder2(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, 2.5)
					drawStripeBorder2(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ,2, tocolor(255,255,255,255))
					if not wallDataTable.wallBuildingClickState then
						if renderData.selectedLine == 1 then
							if (hitPosX >= ox+counter*szorzo/2 and hitPosX <= ox+counter*szorzo/2 + (wh) and hitPosY >= oy+actColumn*szorzo/2-wh + (wh)-0.1 and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								dxDrawLine3D(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh + (wh), oz+plusZ, ox+counter*szorzo/2 + (wh), oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(124, 197, 118, 255), 2, false) -- alja
							elseif (hitPosX >= ox+counter*szorzo/2+wh and hitPosX <= ox+counter*szorzo/2 + wh*2 and hitPosY >= oy+actColumn*szorzo/2-wh-0.1 + wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, ox+counter*szorzo/2 + wh*2, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, color or tocolor(124, 197, 118), 2, false)
							elseif (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2-wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(124, 197, 118), 2, false)
							elseif (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2 and hitPosY <= oy+actColumn*szorzo/2-wh + wh*2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, ox+counter*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh*2, oz+plusZ, color or tocolor(124, 197, 118), 2, false)
							end
						end
						if renderData.selectedLine == 3 then
							if (hitPosX >= ox+counter*szorzo/2 and hitPosX <= ox+counter*szorzo/2 + (wh) and hitPosY >= oy+actColumn*szorzo/2-wh + (wh)-0.1 and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) or (hitPosX >= ox+counter*szorzo/2+wh and hitPosX <= ox+counter*szorzo/2 + wh*2 and hitPosY >= oy+actColumn*szorzo/2-wh-0.1 + wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh+0.1 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) or (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2-wh and hitPosY <= oy+actColumn*szorzo/2-wh + wh and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) or (hitPosX >= ox+counter*szorzo/2+wh-0.1 and hitPosX <= ox+counter*szorzo/2 + wh+0.1 and hitPosY >= oy+actColumn*szorzo/2 and hitPosY <= oy+actColumn*szorzo/2-wh + wh*2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
								dxDrawLine3D(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh + (wh), oz+plusZ, ox+counter*szorzo/2 + (wh), oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(217, 83, 79, 255), 2, false) -- alja
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, ox+counter*szorzo/2 + wh*2, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, color or tocolor(217, 83, 79, 255), 2, false)
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(217, 83, 79), 2, false)
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, ox+counter*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh*2, oz+plusZ, color or tocolor(217, 83, 79), 2, false)
							end
						end
					else
						if renderData.selectedLine == 1 then
							if wallDataTable.wallType == "updown" then
						--		if (wallDataTable.wallCursorPosY+(hitPosY-wallDataTable.wallCursorPosY) >= oy+actColumn*szorzo/2-wh) and wallDataTable.wallCursorPosY <= oy+actColumn*szorzo/2-wh + wh then
								if boxesIntersect(wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, oy+actColumn*szorzo/2-wh, wh, wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+wallDataTable.wallIndex*szorzo/2+wh-szorzo/2, wh) then
									if wallDataTable.wallIndex == counter then
											dxDrawLine3D(ox+wallDataTable.wallIndex*szorzo/2+wh, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+wallDataTable.wallIndex*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(124, 197, 118, 255), 2, false) -- alja
									end
								end
								normIndex = normIndex + 1
								if boxesIntersect(wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, oy+actColumn*szorzo/2, (oy+actColumn*szorzo/2-wh + wh*2)-(oy+actColumn*szorzo/2), wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+wallDataTable.wallIndex*szorzo/2+wh-szorzo/2, wh) then
									if wallDataTable.wallIndex == counter then
										dxDrawLine3D(ox+wallDataTable.wallIndex*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, ox+wallDataTable.wallIndex*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh*2, oz+plusZ, color or tocolor(124, 197, 118), 2, false)
									end
								end
								--if (wallDataTable.wallCursorPosY+(hitPosY-wallDataTable.wallCursorPosY) >= oy+actColumn*szorzo/2) then
								--	dxDrawLine3D(ox+wallDataTable.wallIndex*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, ox+wallDataTable.wallIndex*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh*2, oz+plusZ, color or tocolor(124, 197, 118), 2, false)
								--end
							end
							if wallDataTable.wallType == "leftright" then
								if boxesIntersect(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+counter*szorzo/2, wh) then
									if wallDataTable.wallIndexActColumn == actColumn then
										dxDrawLine3D(ox+counter*szorzo/2, oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + (wh), oz+plusZ, ox+counter*szorzo/2 + (wh), oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(124, 197, 118, 255), 2, false) -- alja
									end
								end
								if boxesIntersect(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+counter*szorzo/2+wh, wh) then
									if wallDataTable.wallIndexActColumn == actColumn then
										dxDrawLine3D(ox+counter*szorzo/2+wh, oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + (wh), oz+plusZ, ox+counter*szorzo/2 + (wh*2), oy+wallDataTable.wallIndexActColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(124, 197, 118, 255), 2, false) -- alja
									end
								end
							end
						end
						if renderData.selectedLine == 3 then
							if boxesIntersect(wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, oy+actColumn*szorzo/2, wh) and boxesIntersect(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, ox+counter*szorzo/2+wh, wh) then
								szamol = szamol +1
								dxDrawLine3D(ox+counter*szorzo/2, oy+actColumn*szorzo/2, oz+plusZ, ox+counter*szorzo/2 + (wh), oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(217, 83, 79, 255), 2, false) -- alja
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, ox+counter*szorzo/2 + wh*2, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, color or tocolor(217, 83, 79, 255), 2, false)
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2-wh, oz+plusZ, ox+counter*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh, oz+plusZ, tocolor(217, 83, 79), 2, false)
								dxDrawLine3D(ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+plusZ, ox+counter*szorzo/2 + wh, oy+actColumn*szorzo/2-wh + wh*2, oz+plusZ, color or tocolor(217, 83, 79), 2, false)
								wallDataTable.wallIndexActColumn = actColumn
								wallDataTable.wallIndex = counter
							end
						end
					end
				end
				if counter == row then
					counter = 0
					actColumn = actColumn + 1
				end
			end
		end

		-- // Door Creation in Render \\ --
		if renderData.actualPage == 3 then
			if renderData.menuPage == 1 then
        -- HEAD DOOR --
				if selectedTextureIndex > 1 and selectedTextureIndex < 11 then
					for k, v in pairs(wallTable) do
						if isElement(v) then
							if hitElement then
								if lastHitWall ~= v then
                  if not headDoorApplied then
  									if hitElement == v and not isCursorWithinPanel() then
  										lastHitWall = v
                      lastHitWallIndex = k
  										setElementModel(v, 8859)
  										attachElements(doorObj, v,0,-0.74,-1.75,0,0,90)
  										setElementModel(doorObj, itemsTable[3]["Doors"][selectedTextureIndex][4])
                      -- DOOR TEXTURE
  										local doorTexture = dxCreateShader("files/texturechanger.fx")
  										engineApplyShaderToWorldTexture(doorTexture, "*", doorObj)
  										dxSetShaderValue (doorTexture, "gTexture", itemsTable[3]["Doors"][selectedTextureIndex][1])
                      -- WALL RETEXTURE
                      local wRetexture = dxCreateShader("files/texturechanger.fx")
  										engineApplyShaderToWorldTexture(wRetexture, "*", v)
  										dxSetShaderValue (wRetexture, "gTexture", dxCreateTexture("files/texture.png"))
                      saveTextureTable[k] = {} -- delete the existing applied texture, otherwise it won't work
  									else
  										setElementModel(v, 3269)
  									end
                  end
								end
							end
						end
					end
				end
        -- INDOORS --
				if selectedTextureIndex > 10 and selectedTextureIndex < 17 then
					for k, v in pairs(createdWallObjects[1]) do
						if not inDoorTable[k] then
							inDoorTable[k] = {}
						end
						if isElement(v) then
							if hitElement then
								if lastHitWall2 ~= v then
									if hitElement == v then
										if not isElement(inDoorTable[k]["index1"]) then
											local id = getElementModel(v)
										  lastHitID = 0
                      if lastHitWall2 then
                        lastHitID = getElementModel(lastHitWall2)
                      end
											if id ~= 7431 and lastHitID ~= 7431 then
												lastHitWall2 = v
                        lastHitWallIndex2 = k
												setElementModel(v, 8859)
												if isElement(inDoorObj) then
													destroyElement(inDoorObj)
												end
												inDoorObj = createObject(itemsTable[3]["Doors"][selectedTextureIndex][4], 0,0,0)
												setElementDimension(inDoorObj, editDimension+dbIDmultiplier)
												attachElements(inDoorObj, v,0,-0.74,-1.75,0,0,90)
												local doorTexture = dxCreateShader("files/texturechanger.fx")
												engineApplyShaderToWorldTexture(doorTexture, "*", inDoorObj)
												dxSetShaderValue (doorTexture, "gTexture", itemsTable[3]["Doors"][selectedTextureIndex][1])
											end
										end
									else
										if getElementModel(v) == 8859 then
											if not isElement(inDoorTable[k]["index1"]) then
												setElementModel(v, 3269)
											end
										end
									end
								end
							end
						end
					end
					for k, v in pairs(createdWallObjects[2]) do
						if not inDoorTable[k] then
							inDoorTable[k] = {}
						end
						if isElement(v) then
							if hitElement then
								if lastHitWall2 ~= v then
									if hitElement == v then
										if not isElement(inDoorTable[k]["index2"]) then
											local id = getElementModel(v)
											lastHitID = 0
                      if lastHitWall2 then
                        lastHitID = getElementModel(lastHitWall2)
                      end
											--outputChatBox(id)
											if id ~= 7431 and lastHitID ~= 7431 then
												lastHitWall2 = v
												lastHitWallIndex2 = k
												setElementModel(v, 8859)
												if isElement(inDoorObj) then
													destroyElement(inDoorObj)
												end
												inDoorObj = createObject(itemsTable[3]["Doors"][selectedTextureIndex][4], 0,0,0)
												setElementDimension(inDoorObj, editDimension+dbIDmultiplier)
												attachElements(inDoorObj, v,0,-0.74,-1.75,0,0,90)
												local doorTexture = dxCreateShader("files/texturechanger.fx")
												engineApplyShaderToWorldTexture(doorTexture, "*", inDoorObj)
												dxSetShaderValue (doorTexture, "gTexture", itemsTable[3]["Doors"][selectedTextureIndex][1])
											end
										end
									else
										if getElementModel(v) == 8859 then
											if not isElement(inDoorTable[k]["index2"]) then
												setElementModel(v, 3269)
                        --setElementRotation(v, 0,0,180)
											end
										end
									end
								end
							end
						end
					end
				end
			else
				if isElement(inDoorObj) then
					destroyElement(inDoorObj)
				end
				if not isElement(inDoorTable[lastHitWallIndex2]["index1"]) and not isElement(inDoorTable[lastHitWallIndex2]["index2"]) then
					setElementModel(lastHitWall2, 3269)
          --setElementRotation(lastHitWall2, 0,0,0)
				end
			end
		else
			if isElement(inDoorObj) then
				destroyElement(inDoorObj)
			end
      if lastHitWallIndex2 then
        if not isElement(inDoorTable[lastHitWallIndex2]["index1"]) and not isElement(inDoorTable[lastHitWallIndex2]["index2"]) then
          setElementModel(lastHitWall2, 3269)
        end
      end
		end
	else
		-- // Texturizing Ceil \\ --
		local counter = 0
		local actColumn = 0
		for i = 1, total do
			counter = counter + 1
			drawStripeBorder(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+wallLength+0.05, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+wallLength+0.05,0.5, tocolor(255,255,255,255))
			if wallDataTable.wallBuildingClickState then
				if boxesIntersectVH(wallDataTable.wallCursorPosX, hitPosX-wallDataTable.wallCursorPosX, wallDataTable.wallCursorPosY, hitPosY-wallDataTable.wallCursorPosY, ox+counter*szorzo/2, wh, oy+actColumn*szorzo/2-wh, wh) then
					drawStripeBorder(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+wallLength+0.05, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+wallLength+0.05, 2.5)
					if counter %2 ~= 0 then
						if actColumn %2 ~= 0 then
							textureString = "6"
						end
					end
					if counter %2 == 0 then
						if actColumn %2 ~= 0 then
							textureString = "5"
						end
					end
					if counter %2 == 0 then
						if actColumn %2 == 0 then
							textureString = "4"
						end
					end
					if counter %2 ~= 0 then
						if actColumn %2 == 0 then
							textureString = "3"
						end
					end
					--local lastHitElement = false
					for k, v in pairs(roofTable) do
						if isElement(v) then
							local roofX,roofY,roofZ = getElementPosition(v)
							if boxesIntersectVH(ox+counter*szorzo/2, wh*2, oy+actColumn*szorzo/2-wh, wh*2, roofX,szorzo,roofY,szorzo) then
								lastHitElement = v
								indexCeil = k
							end
						end
					end
					if not itemsToTexture[i] then
						itemsToTexture[i] = {lastHitElement, textureString, i, indexCeil}
					end
				else
					itemsToTexture[i] = nil
				end
			else
				if (hitPosX >= ox+counter*szorzo/2 and hitPosX <= ox+counter*3.21/2 + 1.6 and hitPosY >= oy+actColumn*szorzo/2-wh and hitPosY <= oy+actColumn*szorzo/2 and hitPosZ >= hitPosZ - 0.5 and hitPosZ <= hitPosZ + 0.5) then
					drawStripeBorder(ox+counter*szorzo/2, oy+actColumn*szorzo/2-wh, oz+wallLength+0.05, ox+counter*szorzo/2+wh, oy+actColumn*szorzo/2, oz+wallLength+0.05, 2.5)
				end
			end
			if counter == row then
				counter = 0
				actColumn = actColumn + 1
			end
		end
	end

	-- // Wall Painting \\ --
	if renderData.actualPage == 1 and textureDataTable and selectedTextureIndex > 0 then
		if renderData.menuPage == 2 or renderData.menuPage == 3 or renderData.menuPage == 4 then
			local index = 0
			local innerIndex = 0
			if getKeyState("mouse1") and not isCursorWithinPanel() then
				for k, v in pairs(wallTable) do
					local wallPosX, wallPosY, wallPosZ = getElementPosition(v)
					local rot1,rot2,rot3 = getElementRotation(v)
					--outputChatBox(k)
					if hitElement then
						if hitElement == v then
							if getElementModel(v) == 3269 then
								if getElementData(v, "wallIndex") == 1 then
										index = index + 1

										if (hitPosY >= wallPosY and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
											walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp6", v)
											dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
											saveTextureTable[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp6"}
											--drawStripeBorderZ(wallPosX+wallLength2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX+wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
										end
										index = index + 1
										if (hitPosY >= wallPosY-wallLength/2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
											walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp5", v)
											dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
											saveTextureTable[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
												--drawStripeBorderZ(wallPosX+wallLength2, wallPosY-wallLength/2, wallPosZ-wallLength/2+wallLength2, wallPosX+wallLength2/2, wallPosY, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
										end
								end
								if getElementData(v, "wallIndex") == 2 then
									index = index + 1
									if (hitPosY >= wallPosY-wallLength/2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp4", v)
										dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveTextureTable[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp4"}

									end
									index = index + 1
									if (hitPosY >= wallPosY and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp3", v)
										dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveTextureTable[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}

									end
								--	drawStripeBorderZ(wallPosX-wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
								end
								if getElementData(v, "wallIndex") == 3 then
									index = index + 1
									if (hitPosX >= wallPosX and hitPosX <= wallPosX+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp5", v)
										dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveTextureTable[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
										--	drawStripeBorderZ(wallPosX, wallPosY+wallLength2, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength/2, wallPosY+wallLength2, wallPosZ+wallLength/2+wallLength2)
									end
									index = index + 1
									if (hitPosX >= wallPosX-wallLength/2 and hitPosX <= wallPosX and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp6", v)
										dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveTextureTable[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp6"}
									end
								end
								if getElementData(v, "wallIndex") == 4 then
									index = index + 1
									if (hitPosX >= wallPosX and hitPosX <= wallPosX+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp6", v)
										dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveTextureTable[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp6"}
										--	drawStripeBorderZ(wallPosX, wallPosY+wallLength2, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength/2, wallPosY+wallLength2, wallPosZ+wallLength/2+wallLength2)
									end
									index = index + 1
									if (hitPosX >= wallPosX-wallLength/2 and hitPosX <= wallPosX and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp5", v)
										dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveTextureTable[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
									end
								end
							end
							if getElementModel(v) == 8859 then
								index = index + 1
								walltexturechanger[index] = dxCreateShader("files/texturechanger.fx")
								engineApplyShaderToWorldTexture(walltexturechanger[index], "la_carp3", v)
								dxSetShaderValue (walltexturechanger[index], "gTexture", textureDataTable[selectedTextureIndex][1])
								saveTextureTable[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
							end
						end
					end
				end
				for k, v in pairs(createdWallObjects[1]) do
					if isElement(v) then
						local wallPosX, wallPosY, wallPosZ = getElementPosition(v)
						local rot1,rot2,rot3 = getElementRotation(v)
						if hitElement then
							if hitElement == v then
								if getElementModel(v) == 7431 then -- only one sided wall
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX+wallLength2/2 and hitPosX <= wallPosX+wallLength2 and hitPosY >= wallPosY and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                  	innerwalltexturechanger[k]["index1"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index1"], "la_carp4", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index1"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp4"}
									--	drawStripeBorderZ(wallPosX+wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX+wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength2 and hitPosX <= wallPosX and hitPosY >= wallPosY and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                    innerwalltexturechanger[k]["index2"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index2"], "la_carp3", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index2"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
										--drawStripeBorderZ(wallPosX-wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
									end
								end
								if getElementModel(v) == 3269 then -- normal double sided wall
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX+wallLength2/2 and hitPosX <= wallPosX+wallLength2 and hitPosY >= wallPosY and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                  	innerwalltexturechanger[k]["index1"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index1"], "la_carp6", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index1"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp6"}
                    print("la_carp6")
									--	drawStripeBorderZ(wallPosX+wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX+wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength2 and hitPosX <= wallPosX and hitPosY >= wallPosY and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                  	innerwalltexturechanger[k]["index2"] = dxCreateShader("files/texturechanger.fx")
                    if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index2"], "la_carp3", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index2"], "gTexture", textureDataTable[selectedTextureIndex][1])
										saveInnerWallTexture[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
                    --print("la_carp3")
										--drawStripeBorderZ(wallPosX-wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX+wallLength2/2 and hitPosX <= wallPosX+wallLength2 and hitPosY >= wallPosY-wallLength/2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                  	innerwalltexturechanger[k]["index3"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index3"], "la_carp5", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index3"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index3"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
                    --print("la_carp5")
									--	drawStripeBorderZ(wallPosX+wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX+wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength2 and hitPosX <= wallPosX and hitPosY >= wallPosY-wallLength/2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                    innerwalltexturechanger[k]["index4"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index4"], "la_carp4", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index4"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index4"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp4"}
                    --print("la_carp4")
										--drawStripeBorderZ(wallPosX-wallLength2/2, wallPosY, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength2/2, wallPosY+wallLength/2, wallPosZ+wallLength/2+wallLength2, tocolor(255,255,255,255))
									end
								end
								if getElementModel(v) == 8859 then
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength2 and hitPosX <= wallPosX and hitPosY >= wallPosY-wallLength/2 and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
										--outputChatBox("Namost")
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
										innerwalltexturechanger[k]["index1"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index1"], "la_carp5", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index1"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX+wallLength2/2 and hitPosX <= wallPosX+wallLength2 and hitPosY >= wallPosY-wallLength/2 and hitPosY <= wallPosY+wallLength/2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger[k] then
											innerwalltexturechanger[k] = {}
										end
                  	innerwalltexturechanger[k]["index2"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger[k]["index2"], "la_carp3", v)
										dxSetShaderValue (innerwalltexturechanger[k]["index2"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture[k] then
											saveInnerWallTexture[k] = {}
										end
										saveInnerWallTexture[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
									end
								end
							end
						end
					end
				end
				local innerIndex = 0
				for k, v in pairs(createdWallObjects[2]) do
					local wallPosX, wallPosY, wallPosZ = getElementPosition(v)
					local rot1,rot2,rot3 = getElementRotation(v)
					if isElement(v) then
						if hitElement then
							if hitElement == v then
								if getElementModel(v) == 7431 then -- only one sided wall
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX and hitPosX <= wallPosX+wallLength/2 and hitPosY >= wallPosY+wallLength2/2 and hitPosY <= wallPosY+wallLength2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                      if not innerwalltexturechanger2[k] then
                        innerwalltexturechanger2[k] = {}
                      end
                      innerwalltexturechanger2[k]["index1"] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index1"], "la_carp3", v)
											dxSetShaderValue (innerwalltexturechanger2[k]["index1"], "gTexture", textureDataTable[selectedTextureIndex][1])
											if not saveInnerWallTexture2[k] then
												saveInnerWallTexture2[k] = {}
											end
											saveInnerWallTexture2[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
										--	drawStripeBorderZ(wallPosX, wallPosY+wallLength2, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength/2, wallPosY+wallLength2, wallPosZ+wallLength/2+wallLength2)
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX and hitPosX <= wallPosX+wallLength/2 and hitPosY >= wallPosY-wallLength2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                      if not innerwalltexturechanger2[k] then
                        innerwalltexturechanger2[k] = {}
                      end
                    	innerwalltexturechanger2[k]["index2"] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index2"], "la_carp4", v)
											dxSetShaderValue (innerwalltexturechanger2[k]["index2"], "gTexture", textureDataTable[selectedTextureIndex][1])
											if not saveInnerWallTexture2[k] then
												saveInnerWallTexture2[k] = {}
											end
											saveInnerWallTexture2[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp4"}
									end
								end
								if getElementModel(v) == 3269 then -- normal double sided wall
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX and hitPosX <= wallPosX+wallLength/2 and hitPosY >= wallPosY+wallLength2/2 and hitPosY <= wallPosY+wallLength2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                      if not innerwalltexturechanger2[k] then
                        innerwalltexturechanger2[k] = {}
                      end
                      innerwalltexturechanger2[k]["index1"] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index1"], "la_carp3", v)
											dxSetShaderValue (innerwalltexturechanger2[k]["index1"], "gTexture", textureDataTable[selectedTextureIndex][1])
											if not saveInnerWallTexture2[k] then
												saveInnerWallTexture2[k] = {}
											end
											saveInnerWallTexture2[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
										--	drawStripeBorderZ(wallPosX, wallPosY+wallLength2, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength/2, wallPosY+wallLength2, wallPosZ+wallLength/2+wallLength2)
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX and hitPosX <= wallPosX+wallLength/2 and hitPosY >= wallPosY-wallLength2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                      if not innerwalltexturechanger2[k] then
                        innerwalltexturechanger2[k] = {}
                      end
                    	innerwalltexturechanger2[k]["index2"] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index2"], "la_carp6", v)
											dxSetShaderValue (innerwalltexturechanger2[k]["index2"], "gTexture", textureDataTable[selectedTextureIndex][1])
											if not saveInnerWallTexture2[k] then
												saveInnerWallTexture2[k] = {}
											end
											saveInnerWallTexture2[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp6"}
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength/2 and hitPosX <= wallPosX and hitPosY >= wallPosY+wallLength2/2 and hitPosY <= wallPosY+wallLength2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                      if not innerwalltexturechanger2[k] then
                        innerwalltexturechanger2[k] = {}
                      end
                    	innerwalltexturechanger2[k]["index3"] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index3"], "la_carp4", v)
											dxSetShaderValue (innerwalltexturechanger2[k]["index3"], "gTexture", textureDataTable[selectedTextureIndex][1])
											if not saveInnerWallTexture2[k] then
												saveInnerWallTexture2[k] = {}
											end
											saveInnerWallTexture2[k]["index3"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp4"}
										--	drawStripeBorderZ(wallPosX, wallPosY+wallLength2, wallPosZ-wallLength/2+wallLength2, wallPosX-wallLength/2, wallPosY+wallLength2, wallPosZ+wallLength/2+wallLength2)
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength/2 and hitPosX <= wallPosX and hitPosY >= wallPosY-wallLength2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                      if not innerwalltexturechanger2[k] then
                        innerwalltexturechanger2[k] = {}
                      end
                    	innerwalltexturechanger2[k]["index4"] = dxCreateShader("files/texturechanger.fx")
											engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index4"], "la_carp5", v)
											dxSetShaderValue (innerwalltexturechanger2[k]["index4"], "gTexture", textureDataTable[selectedTextureIndex][1])
											if not saveInnerWallTexture2[k] then
												saveInnerWallTexture2[k] = {}
											end
											saveInnerWallTexture2[k]["index4"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
									end
								end
								if getElementModel(v) == 8859 then
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength/2 and hitPosX <= wallPosX+wallLength/2 and hitPosY >= wallPosY+wallLength2/2 and hitPosY <= wallPosY+wallLength2 and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger2[k] then
                      innerwalltexturechanger2[k] = {}
                    end
                  	innerwalltexturechanger2[k]["index1"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index1"], "la_carp5", v)
										dxSetShaderValue (innerwalltexturechanger2[k]["index1"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture2[k] then
											saveInnerWallTexture2[k] = {}
										end
										saveInnerWallTexture2[k]["index1"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp5"}
									end
									innerIndex = innerIndex + 1
									if (hitPosX >= wallPosX-wallLength/2 and hitPosX <= wallPosX+wallLength/2 and hitPosY >= wallPosY-wallLength2 and hitPosY <= wallPosY and hitPosZ >= wallPosZ-wallLength/2+wallLength2 and hitPosZ <= wallPosZ+wallLength/2+wallLength2) then
                    if not innerwalltexturechanger2[k] then
                      innerwalltexturechanger2[k] = {}
                    end
                    innerwalltexturechanger2[k]["index2"] = dxCreateShader("files/texturechanger.fx")
										engineApplyShaderToWorldTexture(innerwalltexturechanger2[k]["index2"], "la_carp3", v)
										dxSetShaderValue (innerwalltexturechanger2[k]["index2"], "gTexture", textureDataTable[selectedTextureIndex][1])
										if not saveInnerWallTexture2[k] then
											saveInnerWallTexture2[k] = {}
										end
										saveInnerWallTexture2[k]["index2"] = {k, textureDataTable[selectedTextureIndex][2], "la_carp3"}
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), render )


function boxesIntersect(y1, h1, y2, h2)
	local vertical = (y1 < y2) ~= (y1 < y2 + h2) or (y1 + h1 < y2) ~= (y1 + h1 < y2 + h2) or (y1 < y2) ~= (y1 + h1 < y2) or (y1 < y2 + h2) ~= (y1 + h1 < y2 + h2)
	--local horizontal = (x1 < x2) ~= (x1 < x2 + w2) or (x1 + w1 < x2) ~= (x1 + w1 < x2 + w2) or (x1 < x2) ~= (x1 + w1 < x2) or (x1 < x2 + w2) ~= (x1 + w1 < x2 + w2)

	return (vertical)
end

function boxesIntersectVH(x1, w1, y1, h1, x2,w2, y2,h2)
	local horizontal = (x1 < x2) ~= (x1 < x2 + w2) or (x1 + w1 < x2) ~= (x1 + w1 < x2 + w2) or (x1 < x2) ~= (x1 + w1 < x2) or (x1 < x2 + w2) ~= (x1 + w1 < x2 + w2)
	local vertical = (y1 < y2) ~= (y1 < y2 + h2) or (y1 + h1 < y2) ~= (y1 + h1 < y2 + h2) or (y1 < y2) ~= (y1 + h1 < y2) or (y1 < y2 + h2) ~= (y1 + h1 < y2 + h2)

	return (horizontal and vertical)
end

local RobotoFont = dxCreateFont("files/Roboto.ttf", resp(14), false, "antialiased")
local RobotoFontHeight = dxGetFontHeight(1, RobotoFont)
local RobotoLightFont = dxCreateFont("files/Roboto.ttf", resp(15), false, "cleartype")
local RobotoLightFont12 = dxCreateFont("files/Roboto.ttf", resp(12), false, "cleartype")
local RobotoLightFontHeight = dxGetFontHeight(1, RobotoLightFont)

local panelCategoryPages = {}
local panelCategoryOldPages = {}

local roadmarksList = {}

local isEditorActive = false
local isPanelActive = false

local panelFadeProgress = 0
local panelFadeIn = false
local panelFadeOut = false

local panelWidth = screenWidth
local panelHeight = respc(140)
local panelPosX = 0
local panelPosY = screenHeight - panelHeight

local panelVisibleItems = math.ceil((screenWidth / 140) + 1)
local panelItemWidth = screenWidth / panelVisibleItems
local panelItemHeight = panelHeight
local panelItemScale = 0.75

local activePanelCategory = 1
local selectedPanelItem = false

local activeItem = false
local snapRotation = false

local adminMode = false

local menuPaddingX = 12
local menuPaddingY = 8
local menuIconSize = 36
local menuIconSpace = 30
--local menuWidth = menuPaddingX * 2 + menuIconSize * #textureData + menuIconSpace * (#textureData - 1)
local menuHeight = menuPaddingY * 2 + menuIconSize
local menuPosY = panelPosY - menuHeight

local activeColorInput = false
local hoveredInputfield = false

local mainMenuWidth = 0
local mainMenuPosX = screenWidth + 1000

local mainMenuData = {}



local selectedObjID = 0
local selectedIndex = 0

local moveIcon = dxCreateTexture("files/icons/move.png")
local rotateIcon = dxCreateTexture("files/icons/rotate.png")



function processMainMenu()
	mainMenuData = {
		{"exit", "", {215, 89, 89}},
		{"save", "", {124, 197, 118}}
	}

	if activeItem then
		if not activeItem.isStripe then
			local snapImage = "snapoffr"
			local snapText = "Off"
			if snapRotation == 5 then
				snapImage = "snap1r"
				snapText = "5°"
			elseif snapRotation == 10 then
				snapImage = "snap2r"
				snapText = "10°"
			elseif snapRotation == 90 then
				snapImage = "snap3r"
				snapText = "90°"
			end

			table.insert(mainMenuData, {snapImage, "Rotation settings: " .. snapText})
		end

		table.insert(mainMenuData, {"color", tonumber(getElementData(localPlayer, "acc:admin")or 0) >= 1 and "Colorpanel " .. tonumber(colorState) or "Colorpanel" .. tonumber(colorState)})
	end

	if (getElementData(localPlayer, "acc:admin") or 0) >= 1 then
		if adminMode then
			mainMenuData[2] = nil
			mainMenuData[3] = nil
		end
		table.insert(mainMenuData, {"admin", "Adminmode" .. (adminMode and "off" or "on")})
	else
		adminMode = false
	end

	mainMenuWidth = menuPaddingX * 2 + menuIconSize * #mainMenuData + menuIconSpace * (#mainMenuData - 1)
	mainMenuPosX = screenWidth - mainMenuWidth
end
processMainMenu()



function renderMainMenu()
	-- // Right Menu \\ --
	--dxDrawRectangle(screenWidth-respc(55), 55, 330)
  if renderData.editState or renderData.testState then
  	local plusY = #renderData.rightTabMenu*respc(45)/2
  	local color = tocolor(255,255,255,255)
  	dxDrawRectangle(screenWidth-respc(55), screenHeight/2-respc(65)-plusY, respc(55), respc(10), tocolor(0,0,0,100))
  	rightMenuDirectX = ""
  	for k, v in pairs(renderData.rightTabMenu) do
  		if isCursorInBox(screenWidth-respc(55), screenHeight/2-respc(100)+k*respc(45)-plusY,respc(55), respc(45)) then
  			color = tocolor(106, 200, 210, 255)
  			rightMenuDirectX = v[2]
        drawTooltipLeft(v[4])
  		else
  			color = tocolor(255,255,255,255)
  		end
  		dxDrawRectangle(screenWidth-respc(55), screenHeight/2-respc(100)+k*respc(45)-plusY,respc(55), respc(45), tocolor(0,0,0,200))
  		if (v[2] == "light" and renderData.lightState) or (v[2] == "grid" and renderData.gridState) or (v[2] == "music" and renderData.musicState) or (v[2] == "sound" and renderData.soundState) then
  			dxDrawImage(screenWidth-respc(41.5), screenHeight/2-respc(100)+k*respc(45)-#renderData.rightTabMenu*respc(45)/2+respc(10), (30), (30), v[3],0,0,0,color)
  		else
  			dxDrawImage(screenWidth-respc(41.5), screenHeight/2-respc(100)+k*respc(45)-#renderData.rightTabMenu*respc(45)/2+respc(10), (30), (30), v[1],0,0,0,color)
  		end
  	end
  end

  if not renderData.editState then
		return
	end
	-- // Down Menu \\ --
	dxDrawRectangle(0, screenHeight-respc(175), screenWidth, respc(35), tocolor(0,0,0,200))
	dxDrawRectangle(0, screenHeight-respc(140), screenWidth, respc(140), tocolor(0,0,0,255))

	local index = 0
	local alindex = 0
	local plusX = 0
	local debugX = 0

	for k, v in pairs(menuTable) do
		index = index +1
		if index > 1 then
			plusX = plusX+dxGetTextWidth(menuTable[index-1][1], 1, RobotoLightFont12)+respc(62)
		end
		if menuTable[2][4] and index == 3 then
			debugX = respc(20)
		elseif menuTable[3][4] and index == 4 then
			debugX = (respc(5))
		else
			debugX = 0
		end
		dxDrawText(v[1], respc(20)+plusX+respc(32)+debugX, screenHeight-respc(175), 0, screenHeight-respc(175)+respc(35), tocolor(255,255,255,255), 1, RobotoLightFont12, "left", "center")
		dxDrawImage(respc(20)+plusX+debugX, screenHeight-respc(170), respc(25),respc(25), v[2])
		if renderData.actualPage == k then
			dxDrawRectangle(respc(20)+plusX+debugX, screenHeight-respc(140), dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)+respc(37), 2, tocolor(153, 204, 153,255))
		else
			if isCursorInBox(respc(20)+plusX+debugX, screenHeight-respc(165), dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)+respc(37), respc(20)) then
				dxDrawRectangle(respc(20)+plusX+debugX, screenHeight-respc(140), dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)+respc(37), 2, tocolor(153, 204, 153,255))
			end
		end
	--	dxDrawRectangle(respc(20)+plusX, screenHeight-respc(165), dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)+respc(37), respc(20))
		if v[4] then
			for alK, alV in pairs(v[3]) do
					alindex = alindex + 1
					if alindex > 1 then
						plusX = plusX+dxGetTextWidth(menuTable[index][3][alindex-1].." / ", 0.9, RobotoLightFont12)
					else
						plusX = plusX+dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)
					end
					if alK == renderData.menuPage then
						dxDrawText("#99cc99"..alV.."#646464 / ", respc(20)+plusX+respc(50), screenHeight-respc(175), 0, screenHeight-respc(175)+respc(35), tocolor(100,100,100,255), 0.9, RobotoLightFont12, "left", "center",false,false,false,true)
					else
						if isCursorInBox(respc(20)+plusX+respc(50), screenHeight-respc(165), dxGetTextWidth(menuTable[index][3][alindex].. "", 0.9, RobotoLightFont12), respc(20)) then
							dxDrawText("#99cc99"..alV.."#646464 / ", respc(20)+plusX+respc(50), screenHeight-respc(175), 0, screenHeight-respc(175)+respc(35), tocolor(100,100,100,255), 0.9, RobotoLightFont12, "left", "center",false,false,false,true)
						else
							dxDrawText(""..alV.." / ", respc(20)+plusX+respc(50), screenHeight-respc(175), 0, screenHeight-respc(175)+respc(35), tocolor(100,100,100,255), 0.9, RobotoLightFont12, "left", "center")
						end
					end
					--dxDrawRectangle(respc(20)+plusX+respc(50), screenHeight-respc(165), dxGetTextWidth(menuTable[index][3][alindex].. "", 0.9, RobotoLightFont12), respc(20))
			end
		end
	end
	if renderData.actualPage == 1 then
		if renderData.menuPage == 1 then
			for k, v in pairs(itemsTable[1]["Drawing"]) do
				drawHoverRectangle(respc(20)+(k-1)*respc(130), screenHeight-respc(125), respc(110), respc(110), tocolor(30,30,30,255), tocolor(50,50,50,255))
				if renderData.selectedLine == k then
					dxDrawBorder(respc(20)+(k-1)*respc(130), screenHeight-respc(125), respc(110), respc(110), 3, 255,153,204,153)
				end
				dxDrawImage(respc(20)+(k-1)*respc(130), screenHeight-respc(125), respc(110),respc(110), v[1])
				--dxDrawText(v[2].."#99cc99("..v[3].."$)", respc(20)+(k-1)*respc(130), screenHeight-respc(25), respc(20)+(k-1)*respc(130)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				dxDrawText(v[2].."", respc(20)+(k-1)*respc(130), screenHeight-respc(25), respc(20)+(k-1)*respc(130)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)


			end
		elseif renderData.menuPage == 2 then
			local index = 0
			scrollData.tableNumber = #itemsTable[1]["Paints"]
			textureDataTable = itemsTable[1]["Paints"]
			for k, v in pairs(itemsTable[1]["Paints"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		elseif renderData.menuPage == 3 then
			local index = 0
			scrollData.tableNumber = #itemsTable[1]["Wallpapers"]
			textureDataTable = itemsTable[1]["Wallpapers"]
			for k, v in pairs(itemsTable[1]["Wallpapers"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		elseif renderData.menuPage == 4 then
			local index = 0
			scrollData.tableNumber = #itemsTable[1]["Tiles"]
			textureDataTable = itemsTable[1]["Tiles"]
			for k, v in pairs(itemsTable[1]["Tiles"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		elseif renderData.menuPage == 5 then
			local index = 0
			scrollData.tableNumber = #itemsTable[1]["Ceils"]
			textureDataTable = itemsTable[1]["Ceils"]
			for k, v in pairs(itemsTable[1]["Ceils"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		end
	elseif renderData.actualPage == 2 then
		if renderData.menuPage == 1 then
			local index = 0
			scrollData.tableNumber = #itemsTable[2]["WoodenFloors"]
			textureDataTable = itemsTable[2]["WoodenFloors"]
			for k, v in pairs(itemsTable[2]["WoodenFloors"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		elseif renderData.menuPage == 2 then
			local index = 0
			scrollData.tableNumber = #itemsTable[2]["Tiles"]
			textureDataTable = itemsTable[2]["Tiles"]
			for k, v in pairs(itemsTable[2]["Tiles"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		elseif renderData.menuPage == 3 then
			local index = 0
			scrollData.tableNumber = #itemsTable[2]["Carpets"]
			textureDataTable = itemsTable[2]["Carpets"]
			for k, v in pairs(itemsTable[2]["Carpets"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		end
	elseif renderData.actualPage == 3 then
		if renderData.menuPage == 1 then
			local index = 0
			scrollData.tableNumber = #itemsTable[3]["Doors"]
      textureDataTable = itemsTable[3]["Doors"]
			for k, v in pairs(itemsTable[3]["Doors"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					if selectedTextureIndex == k then
						dxDrawBorder(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), 3, 255,153,204,153)
					end
					if k == 1 then
						dxDrawImage(respc(30)+(index-1)*respc(127), screenHeight-respc(120), respc(100),respc(100), v[1])
						--dxDrawText(v[3], respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
					else
						dxDrawImage(respc(50)+(index-1)*respc(127), screenHeight-respc(120), respc(49),respc(98), v[1])
						--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
					end
				end
			end
		elseif renderData.menuPage == 2 then
			local index = 0
			scrollData.tableNumber = #itemsTable[3]["Windows"]
			for k, v in pairs(itemsTable[3]["Windows"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		end
	elseif renderData.actualPage == 4 then
		if renderData.menuPage == 1 then
			local index = 0
			scrollData.tableNumber = #itemsTable[4]["Bedroom"]
			for k, v in pairs(itemsTable[4]["Bedroom"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		end
		if renderData.menuPage == 2 then
			local index = 0
			scrollData.tableNumber = #itemsTable[4]["LivingR"]
			for k, v in pairs(itemsTable[4]["LivingR"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		end
    if renderData.menuPage == 3 then
			local index = 0
			scrollData.tableNumber = #itemsTable[4]["Bathroom"]
			for k, v in pairs(itemsTable[4]["Bathroom"]) do
				if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
					index = index +1
					drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
					dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
					--dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
				end
			end
		end
    if renderData.menuPage == 4 then
      local index = 0
      scrollData.tableNumber = #itemsTable[4]["Kitchen"]
      for k, v in pairs(itemsTable[4]["Kitchen"]) do
        if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
          index = index +1
          drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
          dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
          --dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
        end
      end
    end
    if renderData.menuPage == 5 then
      local index = 0
      scrollData.tableNumber = #itemsTable[4]["Electronics"]
      for k, v in pairs(itemsTable[4]["Electronics"]) do
        if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
          index = index +1
          drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
          dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
          --dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
        end
      end
    end
    if renderData.menuPage == 6 then
      local index = 0
      scrollData.tableNumber = #itemsTable[4]["Decoration"]
      for k, v in pairs(itemsTable[4]["Decoration"]) do
        if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
          index = index +1
          drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
          dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
          --dxDrawText("("..v[3].."$)", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
        end
      end
    end
    if renderData.menuPage == 7 then
      local index = 0
      scrollData.tableNumber = #itemsTable[4]["Premium"]
      for k, v in pairs(itemsTable[4]["Premium"]) do
        if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
          index = index +1
          drawHoverRectangle(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108), tocolor(30,30,30,255), tocolor(60,60,60,255))
          dxDrawImage(respc(25)+(index-1)*respc(127), screenHeight-respc(120), respc(98),respc(98), v[1])
          --dxDrawText("#286b84"..v[3].." PP", respc(20)+(index-1)*respc(127), screenHeight-respc(25), respc(20)+(index-1)*respc(127)+respc(110), 0, tocolor(255,255,255,255), 0.8, RobotoLightFont12, "center", "top",false,false,false,true)
        end
      end
    end
	end
end
addEventHandler("onClientRender", getRootElement(), renderMainMenu)


function mainMenuClick(button, state)
  if button == "left" and state == "down" then
    -- // Right Menu Click \\ --
    if renderData.editState or renderData.testState then
      if rightMenuDirectX == "light" then
        if renderData.lightState then
          renderData.lightState = false
          setTime(0,0)
        else
          renderData.lightState = true
          setTime(12, 0)
        end
      end
      if rightMenuDirectX == "grid" then
        if renderData.gridState then
          renderData.gridState = false
        else
          renderData.gridState = true
        end
      end
      if rightMenuDirectX == "music" then
        if renderData.musicState then
          renderData.musicState = false
          if isElement(backGroundMusic) then
            stopSound(backGroundMusic)
          end
        else
          local randomMusic = math.random(1,7)
          backGroundMusic = playSound("files/sound/background"..randomMusic..".mp3", true)
          renderData.musicState = true
        end
      end
      if rightMenuDirectX == "sound" then
        if renderData.soundState then
          renderData.soundState = false
        else
          renderData.soundState = true
        end
      end
      if rightMenuDirectX == "test" then
        if renderData.testState then
          for k, v in pairs(roofTable) do
            if isElement(v) then
              setElementPosition(v, 0,0,0)
            end
          end

          renderData.testState = false
          setElementPosition(localPlayer, 0,0,0)
          setElementAlpha(localPlayer, 0)
          setCustomCameraTarget(camObj)
        --  setFreecamEnabled (saveCamX, saveCamY, saveCamZ)
          --rotX, rotY = saveRotX, saveRotY
          renderData.editState = true
          renderData.rightTabMenu = {
		{"files/icons/save.png", "save", "", "Sair e Salvar"},
		{"files/icons/lightoff.png", "light", "files/icons/lighton.png", "Luz on/off"},
		{"files/icons/gridoff.png", "grid", "files/icons/gridon.png", "Linhas on/off"},
		{"files/icons/test.png", "test", "", "Modo teste on"},
		{"files/icons/musicoff.png", "music", "files/icons/musicon.png", "Musica on/off"},
		{"files/icons/soundoff.png", "sound", "files/icons/soundon.png", "Sons on/off"},
		{"files/icons/exit.png", "exit", "", "Sair"},
          }
		  

	
        else
          local actColumn = 0
          local counter = 0
          local row = editableSize
          for k, v in pairs(roofTable) do
            counter = counter + 1
            if isElement(v) then
              setElementPosition(v, ox+counter*3.21, oy+actColumn*3.21, oz+wallLength+wallLength2)
            end
            if counter == row then
              counter = 0
              actColumn = actColumn + 1
            end
          end
          renderData.rightTabMenu = {
            {"files/icons/lightoff.png", "light", "files/icons/lighton.png", "Luz on/off"},
            {"files/icons/test.png", "test", "", "Voltar para o editor"},
          }
          saveCamX, saveCamY, saveCamZ = getCameraMatrix()
          saveRotX, saveRotY = rotX, rotY
          renderData.testState = true
          renderData.editState = false
        --  setFreecamDisabled()
          setCustomCameraTarget(false)
          setCameraTarget(localPlayer, localPlayer)
          setElementAlpha(localPlayer, 255)
          showCursor(false)
          local doorX, doorY, doorZ = getElementPosition(doorObj)
          local _,_,doorRot = getElementRotation(doorObj)
          local interiorEntranceX, interiorEntranceY, interiorEntranceZ = getPositionInfrontOfElement(doorX, doorY, oz+1.2, doorRot, -1)
          setElementPosition(localPlayer, interiorEntranceX, interiorEntranceY, interiorEntranceZ)
          setElementRotation(localPlayer, 0,0,180)
        end
      end
  		if rightMenuDirectX == "save" then
        setCustomCameraTarget(false)
        setCameraTarget(localPlayer, localPlayer)
        setElementAlpha(localPlayer, 255)
        resetSkyGradient()
        setCloudsEnabled(true)
        setBirdsEnabled (true)
        setElementData(localPlayer, "allseeoff", false)
        showChat(true)
        showCursor(false)
        destroyElement(doorObj)
        if isElement(inDoorObj) then
  				destroyElement(inDoorObj)
  			end
        if lastHitWallIndex2 then
          if not isElement(inDoorTable[lastHitWallIndex2]["index1"]) and not isElement(inDoorTable[lastHitWallIndex2]["index2"]) then
            setElementModel(lastHitWall2, 3269)
          end
        end
        lastHitWallIndex2 = false
  			--outputChatBox("save")
  			for k, v in pairs(createdWallObjects[1]) do
  				if isElement(v) then
  					local modelID = getElementModel(v)
  					local objX, objY, objZ = getElementPosition(v)
  					local rotX, rotY, rotZ = getElementRotation(v)
  					saveCreatedWalls[k] = {k, modelID, objX, objY, objZ, rotX, rotY, rotZ}
  				end
  			end
  			for k, v in pairs(createdWallObjects[2]) do
  				if isElement(v) then
  					local modelID = getElementModel(v)
  					local objX, objY, objZ = getElementPosition(v)
  					local rotX, rotY, rotZ = getElementRotation(v)
  					saveCreatedWalls2[k] = {k, modelID, objX, objY, objZ, rotX, rotY, rotZ}
  				end
  			end
  			for k, v in pairs(objTable) do
  				if isElement(v.obj) then
  					local modelID = getElementModel(v.obj)
            local furnOffSetX, furnOffSetY, furnOffSetZ = 0,0,0
            if furnitureOffSetTable[modelID] then -- Offset for all the interior objects that are having shitty offsets
          --    furnOffSetX, furnOffSetY, furnOffSetZ = furnitureOffSetTable[modelID][1], furnitureOffSetTable[modelID][2], furnitureOffSetTable[modelID][3]
            --  outputChatBox(furnOffSetX.." "..furnOffSetY.." "..furnOffSetZ)
            end
  					local objX, objY, objZ = v.middlePosX, v.middlePosY, v.middlePosZ
  					local objRot = v.rotation
  					saveFurnitures[k] = {modelID, objX, objY, objZ, objRot}
  				end
  			end
  			for k, v in pairs(inDoorTable) do
  				if isElement(v["index1"]) then
  					local modelID = getElementModel(v["index1"])
  					local objX, objY, objZ = getElementPosition(v["index1"])
  					local objRotX, objRotY, objRotZ = getElementRotation(v["index1"])
  					if not saveDoorObjects[k] then
  						saveDoorObjects[k] = {}
  					end
  					saveDoorObjects[k]["index1"] = {k, modelID, objX, objY, objZ, objRotX, objRotY, objRotZ}
  				end
  				if isElement(v["index2"]) then
  					local modelID = getElementModel(v["index2"])
  					local objX, objY, objZ = getElementPosition(v["index2"])
  					local objRotX, objRotY, objRotZ = getElementRotation(v["index2"])
  					if not saveDoorObjects[k] then
  						saveDoorObjects[k] = {}
  					end
  					saveDoorObjects[k]["index2"] = {k, modelID, objX, objY, objZ, objRotX, objRotY, objRotZ}
  				end
  			end
        if headDoorSaveTable then
          if not headDoorSaveTable[1] then
            headDoorSaveTable = false
          end
        end
  			triggerServerEvent("receiveEditedInfosFromClient", localPlayer, localPlayer, editDimension, saveTextureTable, saveCreatedWalls, saveCreatedWalls2, saveFurnitures, saveFloorTexture, saveCeilTexture, saveInnerWallTexture, saveInnerWallTexture2, saveDoorObjects, saveDoorTextures, headDoorSaveTable)
  			triggerServerEvent("regenerateHouseServer", localPlayer, editDimension, editableSize, saveTextureTable, saveCreatedWalls, saveCreatedWalls2, saveFurnitures, saveFloorTexture, saveCeilTexture, saveInnerWallTexture, saveInnerWallTexture2, saveDoorObjects, saveDoorTextures, headDoorSaveTable)
  			for k, v in pairs(getElementsByType("marker")) do
  	      if getElementData(v, "isIntOutMarker") then
  					if (getElementDimension(localPlayer)-dbIDmultiplier) == getElementDimension(v) then
  						triggerServerEvent("changeDimInt", localPlayer, localPlayer, 0,0, getElementData(v, "outx"), getElementData(v, "outy"), getElementData(v, "outz"))
  						setElementPosition(localPlayer, getElementData(v, "outx"), getElementData(v, "outy"), getElementData(v, "outz"))
  					end
  				end
  			end
        if isElement(backGroundMusic) then
          stopSound(backGroundMusic)
        end
  			renderData.editState = false
        renderData.soundState = true
        renderData.musicState = true
        renderData.gridState = true
        renderData.lightState = true
        deleteEditorObjects()
  		end
      if rightMenuDirectX == "exit" then
        setCustomCameraTarget(false)
        setCameraTarget(localPlayer, localPlayer)
        setElementAlpha(localPlayer, 255)
        resetSkyGradient()
        setCloudsEnabled(true)
        setBirdsEnabled (true)
        setElementData(localPlayer, "allseeoff", false)
        showChat(true)
        showCursor(false)
        destroyElement(doorObj)
        if isElement(inDoorObj) then
  				destroyElement(inDoorObj)
  			end
        if lastHitWallIndex2 then
          if not isElement(inDoorTable[lastHitWallIndex2]["index1"]) and not isElement(inDoorTable[lastHitWallIndex2]["index2"]) then
            setElementModel(lastHitWall2, 3269)
          end
        end
        lastHitWallIndex2 = false
  			triggerServerEvent("regenerateHouseServer", localPlayer, editDimension)
        triggerServerEvent("exitWithoutSaving", localPlayer, localPlayer)
  			for k, v in pairs(getElementsByType("marker")) do
  	      if getElementData(v, "isIntOutMarker") then
  					if (getElementDimension(localPlayer)-dbIDmultiplier) == getElementDimension(v) then
  						triggerServerEvent("changeDimInt", localPlayer, localPlayer, 0,0, getElementData(v, "outx"), getElementData(v, "outy"), getElementData(v, "outz"))
  						setElementPosition(localPlayer, getElementData(v, "outx"), getElementData(v, "outy"), getElementData(v, "outz"))
  					end
  				end
  			end
        if isElement(backGroundMusic) then
          stopSound(backGroundMusic)
        end
  			renderData.editState = false
        renderData.soundState = true
        renderData.musicState = true
        renderData.gridState = true
        renderData.lightState = true
        deleteEditorObjects()
  		end
    end
  end
	if not renderData.editState then
		return
	end
	if button == "left" and state == "down" then
		local index = 0
		local alindex = 0
		local plusX = 0
		local row = editableSize

		for k, v in pairs(menuTable) do
			index = index +1
			if index > 1 then
				plusX = plusX+dxGetTextWidth(menuTable[index-1][1], 1, RobotoLightFont12)+respc(62)
			end
			if menuTable[2][4] and index == 3 then
				debugX = respc(20)
			elseif menuTable[3][4] and index == 4 then
				debugX = (respc(5))
			else
				debugX = 0
			end
			if renderData.actualPage ~= k then
				if isCursorInBox(respc(20)+plusX+debugX, screenHeight-respc(165), dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)+respc(37), respc(20)) then
					menuTable[renderData.actualPage][4] = false
					scrollData.scrollNum = 0
					renderData.actualPage = k
          headDoorApplied = false
					itemsToTexture = {}
					renderData.menuPage = 1
					menuTable[renderData.actualPage][4] = true
					renderData.selectedLine = 0
					selectedTextureIndex = 0

					if renderData.ceilState then
          --  setFreecamDisabled()
            --setFreecamEnabled (saveCamX, saveCamY, saveCamZ)
            rotX, rotY = saveRotX, saveRotY
						renderData.ceilState = false
						for k, v in pairs(roofTable) do
							if isElement(v) then
								setElementPosition(v, 0,0,0)
							end
						end
						local actColumn = 0
						local counter = 0
						for k, v in pairs(floorTable) do
							counter = counter + 1
							if isElement(v) then
								setElementPosition(v, ox+counter*3.21, oy+actColumn*3.21, oz)
							end
							if counter == row then
								counter = 0
								actColumn = actColumn + 1
							end
						end
					end
				end
			end
			if v[4] then
				for alK, alV in pairs(v[3]) do
						alindex = alindex + 1
						if alindex > 1 then
							plusX = plusX+dxGetTextWidth(menuTable[index][3][alindex-1].. " / ", 0.9, RobotoLightFont12)
						else
							plusX = plusX+dxGetTextWidth(menuTable[index][1], 1, RobotoLightFont12)
						end
						if alK ~= renderData.menuPage then
							if isCursorInBox(respc(20)+plusX+respc(50), screenHeight-respc(165), dxGetTextWidth(menuTable[index][3][alindex].. "", 0.9, RobotoLightFont12), respc(20)) then

								if renderData.ceilState then
                --  setFreecamDisabled()
                --  setFreecamEnabled (saveCamX, saveCamY, saveCamZ)
                  rotX, rotY = saveRotX, saveRotY
									renderData.ceilState = false
									for k, v in pairs(roofTable) do
										if isElement(v) then
											setElementPosition(v, 0,0,0)
										end
									end
									local actColumn = 0
									local counter = 0
									for k, v in pairs(floorTable) do
										counter = counter + 1
										if isElement(v) then
											setElementPosition(v, ox+counter*3.21, oy+actColumn*3.21, oz)
										end
										if counter == row then
											counter = 0
											actColumn = actColumn + 1
										end
									end
								end
								scrollData.scrollNum = 0
								renderData.menuPage = alK
								itemsToTexture = {}
								if renderData.actualPage == 1 then
									if renderData.menuPage == 5 then
                    saveCamX, saveCamY, saveCamZ = getCameraMatrix()
                    saveRotX, saveRotY = rotX, rotY
										renderData.ceilState = true
                  --  setFreecamDisabled()
                  --  setFreecamEnabled (1174.9016113281, -3851.0532226563, 1276.4622802734)
                    rotX, rotY = 4.7207846928204, -2.780195
										for k, v in pairs(floorTable) do
											if isElement(v) then
												setElementPosition(v, 0,0,0)
											end
										end
										local actColumn = 0
										local counter = 0
										for k, v in pairs(roofTable) do
											counter = counter + 1
											if isElement(v) then
												setElementPosition(v, ox+counter*3.21, oy+actColumn*3.21, oz+wallLength+wallLength2)
											end
											if counter == row then
												counter = 0
												actColumn = actColumn + 1
											end
										end
									end
								end
							end
						end
				end
			end
		end
		if renderData.actualPage == 1 then
			if renderData.menuPage == 1 then
				for k, v in pairs(itemsTable[1]["Drawing"]) do
					if isCursorInBox(respc(20)+(k-1)*respc(130), screenHeight-respc(125), respc(110), respc(110)) then
						renderData.selectedLine = k
					end
				end
			elseif renderData.menuPage == 2 then
				local index = 0
				for k, v in pairs(textureDataTable) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
							selectedTextureIndex = k
						end
					end
				end
			elseif renderData.menuPage == 3 then
				local index = 0
				for k, v in pairs(textureDataTable) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
							selectedTextureIndex = k
						end
					end
				end
			elseif renderData.menuPage == 4 then
				local index = 0
				for k, v in pairs(textureDataTable) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
							selectedTextureIndex = k
						end
					end
				end
			elseif renderData.menuPage == 5 then
				local index = 0
				for k, v in pairs(textureDataTable) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
							selectedTextureIndex = k
						end
					end
				end
			end
		elseif renderData.actualPage == 2 then
				local index = 0
				for k, v in pairs(textureDataTable) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
							selectedTextureIndex = k
						end
					end
				end
		elseif renderData.actualPage == 3 then
			if renderData.menuPage == 1 then
				local index = 0
				for k, v in pairs(itemsTable[3]["Doors"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
							selectedTextureIndex = k
              headDoorApplied = false
						end
					end
				end
			end
		end
--	end
		if renderData.actualPage == 4 then
			if renderData.menuPage == 1 then
				local index = 0
				for k, v in pairs(itemsTable[4]["Bedroom"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
			if renderData.menuPage == 2 then
				local index = 0
				for k, v in pairs(itemsTable[4]["LivingR"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
      if renderData.menuPage == 3 then
				local index = 0
				for k, v in pairs(itemsTable[4]["Bathroom"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
      if renderData.menuPage == 4 then
				local index = 0
				for k, v in pairs(itemsTable[4]["Kitchen"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
      if renderData.menuPage == 5 then
				local index = 0
				for k, v in pairs(itemsTable[4]["Electronics"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
      if renderData.menuPage == 6 then
				local index = 0
				for k, v in pairs(itemsTable[4]["Decoration"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
      if renderData.menuPage == 7 then
				local index = 0
				for k, v in pairs(itemsTable[4]["Premium"]) do
					if (k > scrollData.scrollNum and index < scrollData.menuMaxShowing) then
						index = index +1
						if isCursorInBox(respc(20)+(index-1)*respc(127), screenHeight-respc(125), respc(108),respc(108)) then
						--	objTable[#objTable+1] = {}
							table.insert(objTable, {
									obj = createObject(v[4], 0,0,0),
									middlePosX = 0,
									middlePosY = 0,
									middlePosZ = 0,
									rotation = 0,
								}
							)
							print(v[3])
							selectedIndex = #objTable
							setElementData(objTable[selectedIndex].obj, "obj:index", selectedIndex)
							selectedObjID = v[4]
							processItemSelect()
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), mainMenuClick)

bindKey("mouse_wheel_down", "down",
	function()
		if renderData.editState and isCursorWithinPanel() then
			if scrollData.scrollNum < scrollData.tableNumber - scrollData.menuMaxShowing then
				scrollData.scrollNum = scrollData.scrollNum + 1
			end
		end
	end
)

bindKey("mouse_wheel_up", "down",
	function()
		if renderData.editState and isCursorWithinPanel() then
			if scrollData.scrollNum > 0 then
				scrollData.scrollNum = scrollData.scrollNum - 1
			end
		end
	end
)
local furnOffSetX, furnOffSetY, furnOffSetZ = 0,0,0
function processItemSelect(id, copy, x, y, z)
	if not renderData.editState then
		return
	end
	if not x then
		if id then
			if copy then
				activeItem = {
					material = roadmarksList[realRoadmarks[id].section][realRoadmarks[id].textureId],
					textureData = realRoadmarks[id].section .. ";" .. realRoadmarks[id].textureId,
					canFreeMove = true,
					mode = "move",
					rotation = realRoadmarks[id].rotation,
					scale = realRoadmarks[id].scale,
					color = realRoadmarks[id].color
				}
			else
				activeItem = {
					tableId = id,
					canFreeMove = false,
					mode = "move",
					rotation = objTable[id].rotation,
					middlePosX = objTable[id].middlePosX,
					middlePosY = objTable[id].middlePosY,
					middlePosZ = objTable[id].middlePosZ,
					rotated = objTable[id].rotated,
					middlePosZForIcon = oz+0.1,
					canPlace = true,
          fromSQLLoaded = objTable[id].fromSQLLoaded or false,
				}
      --  if furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)] then
        --  furnOffSetX = furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)][1]
      --    furnOffSetY = furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)][2]
      --    furnOffSetZ = furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)][3]
      --    outputChatBox("jah")
      --  end
			end
		else
			local _, _, playerRotZ = getElementRotation(localPlayer)

			activeItem = {
				objID = selectedObjID,
				scale = getObjectScale(objTable[selectedIndex].obj),
				canFreeMove = true,
				mode = "move",
				rotation = (playerRotZ - 90) % 360,
			}
		end
	else
		activeItem = {
			isStripe = true,
			canFreeMove = false,
			mode = "create",
			canResize = true,
			createdPosX = x,
			createdPosY = y,
			createdPosZ = z,
			middlePosX = x,
			middlePosY = y,
			middlePosZ = z,
			width = 0,
			height = 0,
			color = tocolor(255, 255, 255)
		}
	end

	processMainMenu()
end



addEventHandler("onClientPreRender", getRootElement(),
	function ()
		if not renderData.editState then
			return
		end
	--	coroutine.resume(streamerThread)
		active3dDirectX = false
		currentInterior = getElementInterior(localPlayer)
		currentDimension = getElementDimension(localPlayer)
		cursorX, cursorY = -1, -1
		if isCursorShowing() then
			local relativeX, relativeY = getCursorPosition()
			cursorX, cursorY = relativeX * screenWidth, relativeY * screenHeight
		end

		if not activeItem then
			return
		end

		local hitCollision, hitPosX, hitPosY, hitPosZ
		if isCursorShowing() then
			local cameraPosX, cameraPosY, cameraPosZ = getCameraMatrix()
			local cursorWorldPosX, cursorWorldPosY, cursorWorldPosZ = getWorldFromScreenPosition(cursorX, cursorY, 1000)
			local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ = processLineOfSight(cameraPosX, cameraPosY, cameraPosZ, cursorWorldPosX, cursorWorldPosY, cursorWorldPosZ, true, true, true, true, true, true, false, true, objTable[selectedIndex].obj)
			hitCollision, hitPosX, hitPosY, hitPosZ = hit, hitX, hitY, hitZ
			--- FONTOS

			if hitCollision and not isCursorWithinPanel() then
				local goodPlace = (normalX > -0.5 and normalX <= 0.5) and (normalY > -0.5 and normalY <= 0.5) and (normalZ > -0.5 and normalZ <= 1)

				if activeItem.mode == "move" and not activeItem.canFreeMove and getKeyState("mouse1") and activeItemOffsets and activeItemOffsets[7] == "move" and goodPlace then
					activeItem.zLevelForMoveArrows = hitPosZ + 0.07
				end

				if activeItem.isStripe and activeItem.mode == "scale" and goodPlace then
					activeItem.zLevelForMoveArrows = hitPosZ + 0.07
				end

				if not activeItem.isStripe then
					if (activeItem.mode == "move" and activeItem.canFreeMove) then
						if (activeItem.canFreeMove and goodPlace) or not activeItem.canFreeMove then
							if activeItem.canFreeMove and activeItem.mode == "move" then
								activeItem.oldPosX = false
								activeItem.oldNormalX = false
							else
								hitX, hitY, hitZ = activeItem.oldPosX, activeItem.oldPosY, activeItem.oldPosZ

								if activeItem.oldNormalX then
									normalX, normalY, normalZ = activeItem.oldNormalX, activeItem.oldNormalY, activeItem.oldNormalZ
								end
							end

							local middlePosX = hitX
							local middlePosY = hitY
							local middlePosZ = hitZ


							if not activeItem.oldPosX then
								activeItem.oldPosX = hitX
								activeItem.oldPosY = hitY
								activeItem.oldPosZ = hitZ
							end

							if not activeItem.oldNormalX then
								activeItem.oldNormalX = normalX
								activeItem.oldNormalY = normalY
								activeItem.oldNormalZ = normalZ
							end

							if furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)] then
								furnOffSetX = furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)][1]
								furnOffSetY = furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)][2]
								furnOffSetZ = furnitureOffSetTable[getElementModel(objTable[selectedIndex].obj)][3]
							end

							activeItem.middlePosX = hitX
							activeItem.middlePosY = hitY
							activeItem.middlePosZ = hitZ
							activeItem.rotation = getElementRotation(objTable[selectedIndex].obj)
							activeItem.rotated = false
							activeItem.middlePosZForIcon = oz+0.1

							if not activeItem.canPlace then
								activeItem.canPlace = true
							end
						elseif activeItem.canPlace then
							activeItem.canPlace = false
						end
					end
				end
			end
		end

		if not hitCollision then
			hitPosX, hitPosY, hitPosZ = -1000, -1000, -1000
		end

		if activeItem.canPlace and activeItem.middlePosX and activeItem.middlePosY and activeItem.middlePosZ then
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(objTable[selectedIndex].obj)
			local matrix = objTable[selectedIndex].obj.matrix
			local a = matrix:transformPosition(Vector3(minX, minY, maxZ))
			local b = matrix:transformPosition(Vector3(maxX, minY, maxZ))
			local c = matrix:transformPosition(Vector3(minX, maxY, maxZ))
			local d = matrix:transformPosition(Vector3(maxX, maxY, maxZ))

			local r = -activeItem.rotation*math.pi/180
			local xOffset = math.cos(r)*furnOffSetX+math.sin(r)*furnOffSetY
			local yOffset = -math.sin(r)*furnOffSetX+math.cos(r)*furnOffSetY


			--outputChatBox(tostring(activeItem.rotated))
			if activeItem.canFreeMove then
        if not activeItem.fromSQLLoaded then
  				setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+furnOffSetX, activeItem.middlePosY+furnOffSetY, activeItem.middlePosZ+furnOffSetZ)
        else
          setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZ)
        end
			end
			setElementDimension(objTable[selectedIndex].obj, getElementDimension(localPlayer))
			setElementInterior(objTable[selectedIndex].obj, getElementInterior(localPlayer))
			objTable[selectedIndex].middlePosX = activeItem.middlePosX
			objTable[selectedIndex].middlePosY = activeItem.middlePosY
			objTable[selectedIndex].middlePosZ = activeItem.middlePosZ
			objTable[selectedIndex].rotated = activeItem.rotated
			objTable[selectedIndex].rotation = activeItem.rotation
			--setElementRotation(objTable[selectedIndex], 0,0,activeItem.rotation)
		--	dxDrawMaterialLine3D(activeItem.startPosX, activeItem.startPosY, activeItem.startPosZ, activeItem.endPosX, activeItem.endPosY, activeItem.endPosZ, activeItem.material, activeItem.scale, activeItem.color or -1, activeItem.faceTowardX, activeItem.faceTowardY, activeItem.faceTowardZ)
		end

		if not activeItem.isStripe then
			if activeItem.mode == "rotate" then
				local matrix = objTable[selectedIndex].obj.matrix
				local x0, y0, z0, x1, y1, z1 = getElementBoundingBox ( objTable[selectedIndex].obj )
				local objX, objY, objZ = getElementPosition(objTable[selectedIndex].obj)
				local realX1, realY1, realZ1 = x0+objX, y0+objY, z0+objZ
				local realX2, realY2, realZ2 = x1+objX, y1+objY, z1+objZ
				local a = matrix:transformPosition(Vector3(x0, y0, z1))
				local b = matrix:transformPosition(Vector3(x1, y0, z1))
				local c = matrix:transformPosition(Vector3(x0, y1, z1))
				local d = matrix:transformPosition(Vector3(x1, y1, z1))
				local smallerScale = 0
				if getDistanceBetweenPoints3D(a, b) > getDistanceBetweenPoints3D(a, c) then
				 	smallerScale = getDistanceBetweenPoints3D(a, b)/2+0.5
				else
				 	smallerScale = getDistanceBetweenPoints3D(a, c)/2+0.5
				end

				--local smallerScale = getDistanceBetweenPoints3D(realX1, realY1, realZ1, realX2, realY2, realZ2)

				if not isCursorWithinPanel() and not activeItemOffsets and not activeDirectX and (hitPosX >= activeItem.middlePosX - smallerScale and hitPosX <= activeItem.middlePosX + smallerScale and hitPosY >= activeItem.middlePosY - smallerScale and hitPosY <= activeItem.middlePosY + smallerScale and hitPosZ >= activeItem.middlePosZForIcon - 0.5 and hitPosZ <= activeItem.middlePosZForIcon + 0.5) or activeItemOffsets and activeItemOffsets[4] == "rotate" then
					moveRoadmark(hitPosX, hitPosY, "rotate")
					active3dDirectX = "rotate3dbutton"
					dxDrawMaterialLine3D(activeItem.middlePosX - smallerScale, activeItem.middlePosY, activeItem.middlePosZForIcon, activeItem.middlePosX + smallerScale, activeItem.middlePosY, activeItem.middlePosZForIcon, rotateIcon, smallerScale * 2, tocolor(124, 197, 118, 200), activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZForIcon + 10)
				else
					dxDrawMaterialLine3D(activeItem.middlePosX - smallerScale, activeItem.middlePosY, activeItem.middlePosZForIcon, activeItem.middlePosX + smallerScale, activeItem.middlePosY, activeItem.middlePosZForIcon, rotateIcon, smallerScale * 2, tocolor(255, 255, 255, 200), activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZForIcon + 10)
				end
			elseif activeItem.mode == "scale" then
				local matrixX,matrixY,matrixZ = getPositionFromElementOffset(objTable[selectedIndex].obj,0.4,0,0)
				local objX, objY, objZ = getElementPosition(objTable[selectedIndex].obj)

				local smallerScale = getDistanceBetweenPoints3D(matrixX,matrixY,matrixZ, objX, objY, objZ)

				if not isCursorWithinPanel() and not activeItemOffsets and not activeDirectX and (hitPosX >= activeItem.middlePosX - smallerScale and hitPosX <= activeItem.middlePosX + smallerScale and hitPosY >= activeItem.middlePosY - smallerScale and hitPosY <= activeItem.middlePosY + smallerScale and hitPosZ >= activeItem.middlePosZ - 0.5 and hitPosZ <= activeItem.middlePosZ + 0.5) or activeItemOffsets and activeItemOffsets[4] == "scale" then
					moveRoadmark(hitPosX, hitPosY, "scale")
					dxDrawMaterialLine3D(activeItem.middlePosX - smallerScale, activeItem.middlePosY, activeItem.middlePosZ, activeItem.middlePosX + smallerScale, activeItem.middlePosY, activeItem.middlePosZ, scaleIcon, smallerScale * 2, tocolor(124, 197, 118, 200), activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZ + 10)
				else
					dxDrawMaterialLine3D(activeItem.middlePosX - smallerScale, activeItem.middlePosY, activeItem.middlePosZ, activeItem.middlePosX + smallerScale, activeItem.middlePosY, activeItem.middlePosZ, scaleIcon, smallerScale * 2, tocolor(255, 255, 255, 200), activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZ + 10)
				end
			elseif activeItem.mode == "move" and not activeItem.canFreeMove then -- PLACE UTAÁNI
				local matrix = objTable[selectedIndex].obj.matrix
				local x0, y0, z0, x1, y1, z1 = getElementBoundingBox ( objTable[selectedIndex].obj )
				local objX, objY, objZ = getElementPosition(objTable[selectedIndex].obj)
				local realX1, realY1, realZ1 = x0+objX, y0+objY, z0+objZ
				local realX2, realY2, realZ2 = x1+objX, y1+objY, z1+objZ
				local a = matrix:transformPosition(Vector3(x0, y0, z1))
				local b = matrix:transformPosition(Vector3(x1, y0, z1))
				local c = matrix:transformPosition(Vector3(x0, y1, z1))
				local d = matrix:transformPosition(Vector3(x1, y1, z1))
				local smallerScale = 0
        local rotationCalc = math.floor(activeItem.rotation * 10) / 10
				--local smallerScale = getDistanceBetweenPoints3D(realX1, realY1, realZ1, realX2, realY2, realZ2)/2

				local zLevel = oz+0.15
				smallerScale = getDistanceBetweenPoints3D(a, b)/2
        if (rotationCalc < 311 and rotationCalc > 239) or (rotationCalc < 121 and rotationCalc > 69) then
          smallerScale = getDistanceBetweenPoints3D(a, c)/2
        end

				if not isCursorWithinPanel() and not activeItemOffsets and not activeDirectX and (hitPosX >= activeItem.middlePosX - smallerScale - 1 and hitPosX <= activeItem.middlePosX - smallerScale and hitPosY >= activeItem.middlePosY - 0.5 and hitPosY <= activeItem.middlePosY + 0.5 and hitPosZ >= zLevel - 0.5 and hitPosZ <= zLevel + 0.5) or activeItemOffsets and activeItemOffsets[7] == "move" and activeItemOffsets[3] == -1 then
					moveRoadmark(hitPosX, hitPosY, "move", -1, 0)
					active3dDirectX = "move3dbutton"
					dxDrawMaterialLine3D(activeItem.middlePosX - smallerScale - 1, activeItem.middlePosY, zLevel, activeItem.middlePosX - smallerScale, activeItem.middlePosY, zLevel, moveIcon, 1, tocolor(124, 197, 118, 200), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				else
					dxDrawMaterialLine3D(activeItem.middlePosX - smallerScale - 1, activeItem.middlePosY, zLevel, activeItem.middlePosX - smallerScale, activeItem.middlePosY, zLevel, moveIcon, 1, tocolor(255, 255, 255, 255), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				end

				local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(objTable[selectedIndex].obj)

				dxDrawLine3D(minX, maxY, maxZ, maxX, maxY, maxZ, tocolor(255,255,255,255), 10) -- cd
				dxDrawLine3D(maxX, maxY, maxZ, maxX, minY, maxZ, tocolor(255,255,255,255), 10) -- db

				if not isCursorWithinPanel() and not activeItemOffsets and not activeDirectX and (hitPosX >= activeItem.middlePosX + smallerScale and hitPosX <= activeItem.middlePosX + smallerScale + 1 and hitPosY >= activeItem.middlePosY - 0.5 and hitPosY <= activeItem.middlePosY + 0.5 and hitPosZ >= zLevel - 0.5 and hitPosZ <= zLevel + 0.5) or activeItemOffsets and activeItemOffsets[7] == "move" and activeItemOffsets[3] == 1 then
					moveRoadmark(hitPosX, hitPosY, "move", 1, 0)
					active3dDirectX = "move3dbutton"
					dxDrawMaterialLine3D(activeItem.middlePosX + smallerScale + 1, activeItem.middlePosY, zLevel, activeItem.middlePosX + smallerScale, activeItem.middlePosY, zLevel, moveIcon, 1, tocolor(124, 197, 118, 200), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				else
					dxDrawMaterialLine3D(activeItem.middlePosX + smallerScale + 1, activeItem.middlePosY, zLevel, activeItem.middlePosX + smallerScale, activeItem.middlePosY, zLevel, moveIcon, 1, tocolor(255, 255, 255, 255), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				end

				smallerScale = getDistanceBetweenPoints3D(a, c)/2
        if (rotationCalc < 311 and rotationCalc > 239) or (rotationCalc < 121 and rotationCalc > 69) then
          smallerScale = getDistanceBetweenPoints3D(a, b)/2
        end
				if not isCursorWithinPanel() and not activeItemOffsets and not activeDirectX and (hitPosX >= activeItem.middlePosX - 0.5 and hitPosX <= activeItem.middlePosX + 0.5 and hitPosY >= activeItem.middlePosY - smallerScale - 1 and hitPosY <= activeItem.middlePosY - smallerScale and hitPosZ >= zLevel - 0.5 and hitPosZ <= zLevel + 0.5) or activeItemOffsets and activeItemOffsets[7] == "move" and activeItemOffsets[4] == -1 then
					moveRoadmark(hitPosX, hitPosY, "move", 0, -1)
					active3dDirectX = "move3dbutton"
					dxDrawMaterialLine3D(activeItem.middlePosX, activeItem.middlePosY - smallerScale - 1, zLevel, activeItem.middlePosX, activeItem.middlePosY - smallerScale, zLevel, moveIcon, 1, tocolor(124, 197, 118, 200), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				else
					dxDrawMaterialLine3D(activeItem.middlePosX, activeItem.middlePosY - smallerScale - 1, zLevel, activeItem.middlePosX, activeItem.middlePosY - smallerScale, zLevel, moveIcon, 1, tocolor(255, 255, 255, 255), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				end

				if not isCursorWithinPanel() and not activeItemOffsets and not activeDirectX and (hitPosX >= activeItem.middlePosX - 0.5 and hitPosX <= activeItem.middlePosX + 0.5 and hitPosY >= activeItem.middlePosY + smallerScale and hitPosY <= activeItem.middlePosY + smallerScale + 1 and hitPosZ >= zLevel - 0.5 and hitPosZ <= zLevel + 0.5) or activeItemOffsets and activeItemOffsets[7] == "move" and activeItemOffsets[4] == 1 then
					moveRoadmark(hitPosX, hitPosY, "move", 0, 1)
					active3dDirectX = "move3dbutton"
					dxDrawMaterialLine3D(activeItem.middlePosX, activeItem.middlePosY + smallerScale + 1, zLevel, activeItem.middlePosX, activeItem.middlePosY + smallerScale, zLevel, moveIcon, 1, tocolor(124, 197, 118, 200), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				else
					dxDrawMaterialLine3D(activeItem.middlePosX, activeItem.middlePosY + smallerScale + 1, zLevel, activeItem.middlePosX, activeItem.middlePosY + smallerScale, zLevel, moveIcon, 1, tocolor(255, 255, 255, 255), activeItem.middlePosX, activeItem.middlePosY, zLevel + 10)
				end
			end
		end
	end
)


addCommandHandler("testcord", function ()
	local x,y,z = getElementPosition(objTable[selectedIndex])
	local x0, y0, z0, x1, y1, z1 = getElementBoundingBox ( objTable[selectedIndex] )
	outputChatBox(x+x0.." "..y+y0.." "..z+z0.." - "..x+x1.." "..y+y1.." "..z+z1)
	outputChatBox(x.." "..y.." "..z)
end)

function moveRoadmark(x, y, mode, x2, y2, z, relY)
	if not renderData.editState then
		return
	end
	if getKeyState("mouse1") then
		--setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+xOffset, activeItem.middlePosY+yOffset, activeItem.middlePosZ+furnOffSetZ)
		if mode == "rotate" then
			if not activeItemOffsets then
				activeItemOffsets = {
					activeItem.middlePosX,
					activeItem.middlePosY,
					math.atan2(y - activeItem.middlePosY, x - activeItem.middlePosX) + math.rad(90) - math.rad(activeItem.rotation),
					mode
				}
			end

			if x ~= -1000 then
				local preRotation = math.atan2(y - activeItemOffsets[2], x - activeItemOffsets[1]) + math.rad(90) - activeItemOffsets[3]

				if snapRotation then
					preRotation = math.ceil(preRotation / math.rad(snapRotation)) * math.rad(snapRotation)
				end

				activeItem.rotation = math.ceil(math.deg(preRotation) % 360)

				if snapRotation == 90 and math.floor(lastPreRotation) ~= activeItem.rotation and getTickCount() - rotationSoundTick >= 175 then
					playSound("files/sounds/rotate.mp3")
					rotationSoundTick = getTickCount()
				end
				lastPreRotation = activeItem.rotation
				local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(objTable[selectedIndex].obj)
				local matrix = objTable[selectedIndex].obj.matrix
				local a = matrix:transformPosition(Vector3(minX, minY, maxZ))
				local b = matrix:transformPosition(Vector3(maxX, minY, maxZ))
				local c = matrix:transformPosition(Vector3(minX, maxY, maxZ))
				local d = matrix:transformPosition(Vector3(maxX, maxY, maxZ))
				local xLength = getDistanceBetweenPoints3D(a, d)
				local yLength = getDistanceBetweenPoints3D(a, c)
				local objX, objY, objZ = getElementPosition(objTable[selectedIndex].obj)
				local distance = getDistanceBetweenPoints2D(objX+furnOffSetX, objY+furnOffSetY, objX, objY)
			--	outputChatBox(math.sin(math.rad(activeItem.rotation)))
			--	outputChatBox(math.cos(math.rad(activeItem.rotation)))
				local r = -activeItem.rotation*math.pi/180
				local xOffset = math.cos(r)*furnOffSetX+math.sin(r)*furnOffSetY
				local yOffset = -math.sin(r)*furnOffSetX+math.cos(r)*furnOffSetY
				--outputChatBox(xOffset)
				--local yOffset =
				setElementRotation(objTable[selectedIndex].obj, 0,0,activeItem.rotation)
				activeItem.rotated = true
				setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+xOffset, activeItem.middlePosY+yOffset, activeItem.middlePosZ)
				--setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+xOffset, activeItem.middlePosY+yOffset, activeItem.middlePosZ+furnOffSetZ)
			end
		elseif mode == "scale" then
			local cameraX, cameraY, cameraZ, faceTowardX, faceTowardY, faceTowardZ = getCameraMatrix()
			local cameraAndItemRotation = math.atan2(faceTowardX - cameraX, faceTowardY - cameraY) + math.rad(activeItem.rotation)

			if not activeItemOffsets then
				local xoff = ((activeItem.middlePosY - y) * math.sin(cameraAndItemRotation) + (activeItem.middlePosX - x) * -math.cos(cameraAndItemRotation))
				local yoff = ((activeItem.middlePosY - y) * math.cos(cameraAndItemRotation) + (activeItem.middlePosX - y) * math.sin(cameraAndItemRotation))
				activeItemOffsets = {
					activeItem.middlePosX,
					activeItem.middlePosY,
					activeItem.scale + (xoff + yoff),
					mode
				}
			end

			if x ~= -1000 then
				local xoff = ((activeItemOffsets[2] - y) * math.sin(cameraAndItemRotation) + (activeItemOffsets[1] - x) * -math.cos(cameraAndItemRotation))
				local yoff = ((activeItemOffsets[2] - y) * math.cos(cameraAndItemRotation) + (activeItemOffsets[1] - y) * math.sin(cameraAndItemRotation))
				activeItem.scale = activeItemOffsets[3] - (xoff + yoff)
				activeItem.scale = math.max(itemScaleMinimum, math.min(itemScaleMaximum, activeItem.scale))
			end
		elseif mode == "move" then
			--outputChatBox("move")
			if not activeItemOffsets then
				activeItemOffsets = {x, y, x2, y2, activeItem.middlePosX, activeItem.middlePosY, mode, activeItem.startPosX, activeItem.startPosY, activeItem.endPosX, activeItem.endPosY, activeItem.faceTowardX, activeItem.faceTowardY, activeItem.createdPosX, activeItem.createdPosY, activeItem.normalPosX, activeItem.normalPosY}
			end

			if x ~= -1000 then
				local xoff = (x - activeItemOffsets[1]) * math.abs(activeItemOffsets[3])
				local yoff = (y - activeItemOffsets[2]) * math.abs(activeItemOffsets[4])

				activeItem.middlePosX = activeItemOffsets[5] + xoff
				activeItem.middlePosY = activeItemOffsets[6] + yoff

			end
      local furnOffSetX, furnOffSetY, furnOffSetZ = 0,0,0
      local modelID = getElementModel(objTable[selectedIndex].obj)
      if furnitureOffSetTable[modelID] then
        furnOffSetX, furnOffSetY, furnOffSetZ = furnitureOffSetTable[modelID][1], furnitureOffSetTable[modelID][2], furnitureOffSetTable[modelID][3]
      end
      local r = -activeItem.rotation*math.pi/180
      local xOffset = math.cos(r)*furnOffSetX+math.sin(r)*furnOffSetY
      local yOffset = -math.sin(r)*furnOffSetX+math.cos(r)*furnOffSetY
      if activeItem.rotated then
        setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+xOffset, activeItem.middlePosY+yOffset, activeItem.middlePosZ)
      else
        setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+furnOffSetX, activeItem.middlePosY+furnOffSetY, activeItem.middlePosZ+furnOffSetZ)
      end
		end
	else
		if activeItemOffsets then
			activeItemOffsets = nil
		end
		--activeItem.middlePosX =
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(90 - angle);

    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;

    return x+dx, y+dy;

end

local size32 = respc(32)
function drawActiveMarkMenu()
	if not renderData.editState then
		return
	end
	lastActiveDirectX = activeDirectX
	activeDirectX = false
	if activeItem and not adminMode then
		if not activeItem.canFreeMove and not activeItem.isStripe or not activeItem.canFreeMove and activeItem.isStripe and activeItem.width >= stripeMinWidth and activeItem.height >= stripeMinHeight then
			local menuPosX, menuPosY = getScreenFromWorldPosition(activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZ + 0.25)
			if menuPosX and menuPosY then
				local cameraX, cameraY, cameraZ = getCameraMatrix()
				local distanceBetweenMark = getDistanceBetweenPoints3D(cameraX, cameraY, cameraZ, activeItem.middlePosX, activeItem.middlePosY, activeItem.middlePosZ + 0.25)

				if distanceBetweenMark <= 60 then
					local distanceMultiplier = interpolateBetween(1, 0, 0, 0, 0, 0, distanceBetweenMark / 100, "OutQuad")

					if distanceMultiplier > 0 then
						local menuIconSize = size32 * distanceMultiplier
						local barY = menuPosY - menuIconSize

						if not activeItem.isStripe then
							local barX = menuPosX - (menuIconSize * 5) * 0.5

							dxDrawRectangle(barX, barY, menuIconSize * 5, menuIconSize, tocolor(0, 0, 0, 200))

							if isCursorWithinArea(cursorX, cursorY, barX, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:rotate"
								drawTooltip("Rotacionar")
								dxDrawImage(barX, barY, menuIconSize, menuIconSize, "files/icons/rotateicon.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							elseif activeItem.mode == "rotate" then
								dxDrawImage(barX, barY, menuIconSize, menuIconSize, "files/icons/rotateicon.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							else
								dxDrawImage(barX, barY, menuIconSize, menuIconSize, "files/icons/rotateicon.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end

							if isCursorWithinArea(cursorX, cursorY, barX + menuIconSize, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:move"
								drawTooltip("Mover")
								dxDrawImage(barX + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/moveicon.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							elseif activeItem.mode == "move" then
								dxDrawImage(barX + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/moveicon.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							else
								dxDrawImage(barX + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/moveicon.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end

							if isCursorWithinArea(cursorX, cursorY, barX + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:putOnFloor"
								drawTooltip("Coloque no chão")
								dxDrawImage(barX + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/onfloor.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							elseif activeItem.mode == "putOnFloor" then
								dxDrawImage(barX + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/onfloor.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							else
								dxDrawImage(barX + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/onfloor.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end

							if isCursorWithinArea(cursorX, cursorY, barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:updown"
								drawTooltip("Mover cima/baixo")
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/updown.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							else
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/updown.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end

							if activeItem.moveUpDown then
								local relX, relY = getCursorPosition()
								setCursorPosition(screenWidth / 2, screenHeight / 2)
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/updown.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
								activeItem.middlePosZ = activeItem.middlePosZ - ((relY - 0.5) * 5)
                local modelID = getElementModel(objTable[selectedIndex].obj)
                if furnitureOffSetTable[modelID] then
                  furnOffSetX, furnOffSetY, furnOffSetZ = furnitureOffSetTable[modelID][1], furnitureOffSetTable[modelID][2], furnitureOffSetTable[modelID][3]
                end
								local r = -activeItem.rotation*math.pi/180
								local xOffset = math.cos(r)*furnOffSetX+math.sin(r)*furnOffSetY
								local yOffset = -math.sin(r)*furnOffSetX+math.cos(r)*furnOffSetY
								if activeItem.rotated then
									setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+xOffset, activeItem.middlePosY+yOffset, activeItem.middlePosZ)
								else
									setElementPosition(objTable[selectedIndex].obj, activeItem.middlePosX+furnOffSetX, activeItem.middlePosY+furnOffSetY, activeItem.middlePosZ+furnOffSetZ)
								end
							end

							if isCursorWithinArea(cursorX, cursorY, barX + menuIconSize + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:delete"
								drawTooltip("Deletar")
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/delete.png", 0, 0, 0, tocolor(153, 204, 153, alpha255))
							else
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/delete.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end

							if activeItem.mode == "rotate" then
								local barText = math.floor(activeItem.rotation * 10) / 10 .. "°"
								local barWidth = dxGetTextWidth(barText, 1, RobotoLightFont) * distanceMultiplier
								local barX = menuPosX - barWidth * 0.5
								local barY = barY - menuIconSize - respc(5) * distanceMultiplier
								local barHeight = (RobotoLightFontHeight + respc(4)) * distanceMultiplier
								barWidth = barWidth + respc(6) * distanceMultiplier

								dxDrawRectangle(barX, barY, barWidth, barHeight, tocolor(0, 0, 0, 180))
								dxDrawText(barText, barX, barY, barX + barWidth, barY + barHeight, tocolor(255, 255, 255, alpha255), distanceMultiplier, RobotoLightFont, "center", "center")
							elseif activeItem.mode == "scale" then
								local barText = math.floor(activeItem.scale * 10) / 10 .. "x"
								local barWidth = dxGetTextWidth(barText, 1, RobotoLightFont) * distanceMultiplier
								local barX = menuPosX - barWidth * 0.5
								local barY = barY - menuIconSize - respc(5) * distanceMultiplier
								local barHeight = (RobotoLightFontHeight + respc(4)) * distanceMultiplier
								barWidth = barWidth + respc(6) * distanceMultiplier

								dxDrawRectangle(barX, barY, barWidth, barHeight, tocolor(0, 0, 0, 150 * panelFadeProgress))
								dxDrawText(barText, barX, barY, barX + barWidth, barY + barHeight, tocolor(255, 255, 255, alpha255), distanceMultiplier, RobotoLightFont, "center", "center")
							end
						else
							local barX = menuPosX - (menuIconSize * 4) * 0.5

							dxDrawRectangle(barX, barY, menuIconSize * 4, menuIconSize, tocolor(32, 30, 32, 225 * panelFadeProgress))

							if isCursorWithinArea(cursorX, cursorY, barX, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:move"
								drawTooltip("Modo Mover (Mover com o mouse: clique duplo)")
								dxDrawImage(barX, barY, menuIconSize, menuIconSize, "files/icons/move.png", 0, 0, 0, tocolor(0, 149, 217, alpha255))
							elseif activeItem.mode == "move" then
								dxDrawImage(barX, barY, menuIconSize, menuIconSize, "files/icons/move.png", 0, 0, 0, tocolor(0, 149, 217, alpha255))
							else
								dxDrawImage(barX, barY, menuIconSize, menuIconSize, "files/icons/move.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end

							if isCursorWithinArea(cursorX, cursorY, barX + menuIconSize, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:scale"
								drawTooltip("Modo de escala")
								dxDrawImage(barX + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/scale.png", 0, 0, 0, tocolor(0, 149, 217, alpha255))
							elseif activeItem.mode == "scale" then
								dxDrawImage(barX + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/scale.png", 0, 0, 0, tocolor(0, 149, 217, alpha255))
							else
								dxDrawImage(barX + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/scale.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end


							if isCursorWithinArea(cursorX, cursorY, barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize) then
								activeDirectX = "activeMode:delete"
								drawTooltip("Delete")
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/trash.png", 0, 0, 0, tocolor(0, 149, 217, alpha255))
							else
								dxDrawImage(barX + menuIconSize + menuIconSize + menuIconSize, barY, menuIconSize, menuIconSize, "files/icons/trash.png", 0, 0, 0, tocolor(255, 255, 255, alpha255))
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), drawActiveMarkMenu)


function onClientPanelClick(button, state, _, _, worldX, worldY, worldZ, clickedElement)

	--if colorPanel.isActive and button == "left" and state == "down" then
	--	activeColorInput = false
	--	if hoveredInputfield then
--			activeColorInput = hoveredInputfield
	--	end
--	end
	if not renderData.editState then
		return
	end
	if button == "left" and state == "up" then
		if activeItem and activeItem.moveUpDown then
			activeItem.moveUpDown = false
			setCursorAlpha(255)
		end
		if activeDirectX then
			local splitData = split(activeDirectX, ":")

			if splitData[1] == "category" then
				activePanelCategory = tonumber(splitData[2])
				textBoxWidthTarget = menuPaddingX * 2 + dxGetTextWidth(categoryNames[activePanelCategory], 1, RobotoLightFont)
				playSound("files/sounds/category.mp3")
				selectedPanelItem = false
			elseif splitData[1] == "panelItem" then
				selectedPanelItem = tonumber(splitData[2])
				playSound("files/sounds/select.mp3")

				if activePanelCategory == stripeCategory[1] and selectedPanelItem == stripeCategory[2] and not activeItem then
					processItemSelect(false, false, -1000, -1000, -1000)
				end

				if activeItem and not activeItem.isStripe then
					if activePanelCategory == stripeCategory[1] and selectedPanelItem == stripeCategory[2] then
						return
					end

					activeItem.material = roadmarksList[activePanelCategory][selectedPanelItem]
					activeItem.textureData = activePanelCategory .. ";" .. selectedPanelItem
				end
			elseif splitData[1] == "nav" then
        if string.find(splitData[2], "snap") then
					if splitData[2] == "snapoffr" then
						snapRotation = 5
					elseif splitData[2] == "snap1r" then
						snapRotation = 10
					elseif splitData[2] == "snap2r" then
						snapRotation = 90
					elseif splitData[2] == "snap3r" then
						snapRotation = false
					end

					processMainMenu()
					playSound("files/sounds/select.mp3")
				elseif splitData[2] == "save" then
					if activeItem then
						if activeItem.isStripe then
							if activeItem.width <= stripeMinWidth or activeItem.height <= stripeMinHeight then
								outputChatBox("#32b3ef[BGO CASA]:#ffffff O tamanho da grade é muito pequeno!", 255, 255, 255, true)
								return
							end

							if activeItem.width > stripeMaxWidth or activeItem.height > stripeMaxHeight then
								outputChatBox("#32b3ef[BGO CASA]:#ffffff O tamanho da grade é muito grande!", 255, 255, 255, true)
								return
							end
						end

						triggerServerEvent("createRoadmark", localPlayer, activeItem)
						activeItem = false
						processMainMenu()
					else
						outputChatBox("#32b3ef[BGO CASA]:#ffffff Não há nada para salvar!", 255, 255, 255, true)
						playSound("files/sounds/fail.mp3")
					end
				elseif splitData[2] == "admin" then
					setElementData(localPlayer, "isEditingRoadmark", false)
					adminMode = not adminMode
					processMainMenu()
					playSound("files/sounds/select.mp3")
				elseif splitData[2] == "color" then
					showColorPicker()
					playSound("files/sounds/select.mp3")
				end
			elseif splitData[1] == "activeMode" and activeItem then
				if splitData[2] == "delete" then
					destroyElement(objTable[selectedIndex].obj)
					--table.remove(objTable, selectedIndex)
					objTable[selectedIndex] = {}
					activeItem = false
					playSound("files/sounds/delete.mp3")
				elseif splitData[2] == "putOnFloor" then
				--	setElementData(localPlayer, "isEditingRoadmark", false)
				--	activeItem = false
				--	processMainMenu()
          processMainMenu()
					playSound("files/sounds/select.mp3")
				elseif splitData[2] == "move" then
					activeItem.mode = "move"
					processMainMenu()
					playSound("files/sounds/select.mp3")
				elseif activeItem.mode ~= splitData[2] then
					activeItem.canFreeMove = false
					activeItem.mode = splitData[2]
					playSound("files/sounds/select.mp3")
				end
			elseif not activeItem then
				if splitData[1] == "editMark" and not splitData[3] then
					local roadmarkId = splitData[2]
					if realRoadmarks[roadmarkId] and not realRoadmarks[roadmarkId].isEditing then
						setElementData(localPlayer, "isEditingRoadmark", false)
						setElementData(localPlayer, "isEditingRoadmark", roadmarkId)
						playSound("files/sounds/select2.mp3")
					end
				elseif splitData[1] == "editMark" and splitData[3] == "copy" then
					local roadmarkId = splitData[2]
					if realRoadmarks[roadmarkId] then
						processItemSelect(roadmarkId, true)
						playSound("files/sounds/select2.mp3")
					end
				elseif splitData[1] == "deleteStripe" then
					local roadmarkId = splitData[2]
					if realRoadmarks[roadmarkId] then
						if not realRoadmarks[roadmarkId].isProtected then
							triggerServerEvent("deleteRoadmark", localPlayer, roadmarkId, realRoadmarks[roadmarkId])
							playSound("files/sounds/select2.mp3")
						end
					end
				end
			end
		end
	elseif button == "left" and state == "down" then
		if not isCursorWithinPanel() and renderData.actualPage == 4 then -- ITTT FOLYTASDSDSDSDSDS
			--[[if activePanelCategory == stripeCategory[1] and selectedPanelItem == stripeCategory[2] then
				if not activeItem or activeItem and activeItem.createdPosX == -1000 then
					selectedIndex = 0
					processItemSelect(false, false, worldX, worldY, worldZ)
					playSound("files/sounds/select2.mp3")
				end]]

			if activeItem and activeItem.canFreeMove then
				if activeItem.canPlace then
					activeItem.canFreeMove = false
					print("placed")
					playSound("files/sounds/place.mp3")
				else
					playSound("files/sounds/fail.mp3")
				end
			elseif clickedElement and getElementData(clickedElement, "obj:index") and not activeDirectX and selectedIndex ~= getElementData(clickedElement, "obj:index") then
					selectedIndex = getElementData(clickedElement, "obj:index")
					processItemSelect(getElementData(clickedElement, "obj:index"), false, false, false, false)
			else
				if not active3dDirectX and not activeDirectX then
					activeItem = false
					selectedIndex = 0
				end
			end
			if activeItem and activeDirectX then
				if activeDirectX == "activeMode:updown" then
					setCursorPosition(screenWidth / 2, screenHeight / 2)
					activeItem.moveUpDown = true
					setCursorAlpha(0)
				end
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), onClientPanelClick)

function onClientPanelDoubleClick(button)
	if button == "left" and activeItem and not adminMode and activeDirectX then
		local splitData = split(activeDirectX, ":")
		if splitData[1] == "activeMode" then
			if splitData[2] == "move" then
				activeItem.mode = "move"
				activeItem.canFreeMove = true
				processMainMenu()
				playSound("files/sounds/select.mp3")
			end
		end
	end

	if activePanelCategory == stripeCategory[1] and selectedPanelItem == stripeCategory[2] then
		return
	end

	if button == "left" and selectedPanelItem and not adminMode then
		if isCursorWithinArea(cursorX, cursorY, panelPosX, panelPosY, panelWidth, panelHeight) then
			setElementData(localPlayer, "isEditingRoadmark", false)
			processItemSelect()
			playSound("files/sounds/select2.mp3")
		end
	end
end

function isCursorWithinPanel()
	if isCursorInBox(0, screenHeight-respc(175), screenWidth, respc(175)) then
		return true
	end

	return false
end


function isCursorInBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(isCursorXY(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end
end


function isCursorWithinArea(cx, cy, x, y, w, h)
	if isCursorShowing() then
		if cx >= x and cx <= x + w and cy >= y and cy <= y + h then
			return true
		end
	end

	return false
end

function isCursorXY(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end


function drawHoverText(hX, hY, hW, hH, activecolor, text, x, y, width, height, color, scale, font, alignX, alignY )
	if isCursorInBox(hX, hY, hW, hH) then
		dxDrawText(text, x, y, width, height, activecolor, scale, font, alignX, alignY)
	else
		dxDrawText(text, x, y, width, height, color, scale, font, alignX, alignY)
	end
end


function drawHoverRectangle(x,y,w,h,color,activecolor)
	if isCursorInBox(x,y,w,h) then
		dxDrawRectangle(x,y,w,h, activecolor)
	else
		dxDrawRectangle(x,y,w,h, color)
	end
end

function drawTooltip(text)
	local tooltipWidth = dxGetTextWidth(text, 0.8, RobotoLightFont) + 15
	dxDrawRectangle(cursorX + 16.5, cursorY + 15.5, tooltipWidth, RobotoLightFontHeight, tocolor(0, 0, 0, 230), true)
	dxDrawText(text, cursorX + 16.5, cursorY + 15.5, cursorX + 16.5 + tooltipWidth, cursorY + 15.5 + RobotoLightFontHeight, tocolor(255, 255, 255, 255), 0.8, RobotoLightFont, "center", "center", false, false, true)
end

function drawTooltipLeft(text)
  local cursorX, cursorY = -1, -1
  if isCursorShowing() then
    local relativeX, relativeY = getCursorPosition()
    cursorX, cursorY = relativeX * screenWidth, relativeY * screenHeight
  end
	local tooltipWidth = dxGetTextWidth(text, 0.8, RobotoLightFont) + 15
	dxDrawRectangle(cursorX - 16.5-tooltipWidth, cursorY-RobotoLightFontHeight/2, tooltipWidth, RobotoLightFontHeight, tocolor(0, 0, 0, 200), true)
	dxDrawText(text, cursorX - 16.5 - tooltipWidth, cursorY-RobotoLightFontHeight/2, cursorX - 16.5, cursorY+RobotoLightFontHeight/2, tocolor(255, 255, 255, 255), 0.8, RobotoLightFont, "center", "center", false, false, true)
end


function rotateAround(angle, x, y)
	angle = math.rad(angle)
	local cosinus, sinus = math.cos(angle), math.sin(angle)
	return x * cosinus - y * sinus, x * sinus + y * cosinus
end


function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end

function getMatrixLeft(m)
    return m[1][1], m[1][2], m[1][3]
end
function getMatrixForward(m)
    return m[2][1], m[2][2], m[2][3]
end
function getMatrixUp(m)
    return m[3][1], m[3][2], m[3][3]
end
function getMatrixPosition(m)
    return m[4][1], m[4][2], m[4][3]
end

function drawStripeBorder(x1, y1, z1, x2, y2, z2,size, color, state)
	local w = x2 - x1
	local h = y2 - y1
	state = state or false

	dxDrawLine3D(x1, y1, z1, x1 + w, y1, z1, color or tocolor(124, 197, 118), size, state) -- teteje
	dxDrawLine3D(x1, y1 + h, z1, x1 + w, y1 + h, z1, color or tocolor(124, 197, 118), size, state) -- alja
	dxDrawLine3D(x1, y1, z1, x1, y1 + h, z1, color or tocolor(124, 197, 118), size, state) -- bal
	dxDrawLine3D(x1 + w, y1, z1, x1 + w, y1 + h, z1, color or tocolor(124, 197, 118), size, state) -- jobb
end

function drawStripeBorder2(x1, y1, z1, x2, y2, z2,size, color)
	local w = x2 - x1
	local h = y2 - y1

	dxDrawLine3D(x1, y1 + h, z1, x1 + w, y1 + h, z1, color or tocolor(124, 197, 118), size, false) -- alja
	dxDrawLine3D(x1, y1 + h, z1, x1 + w*2, y1 + h, z1, color or tocolor(124, 197, 118), size, false) -- alja2
	dxDrawLine3D(x1 + w, y1, z1, x1 + w, y1 + h, z1, color or tocolor(124, 197, 118), size, false) -- jobb
	dxDrawLine3D(x1 + w, y1, z1, x1 + w, y1 + h*2, z1, color or tocolor(124, 197, 118), size, false) -- jobb2
end

function drawStripeBorderZ(x1, y1, z1, x2, y2, z2,size, color)
	local w = y2 - y1
	local h = z2 - z1

	dxDrawLine3D(x1, y1, z1+h, x1, y1 + w, z1+h, color or tocolor(124, 197, 118), size, false) -- teteje
	dxDrawLine3D(x1, y1, z1-h, x1, y1+w, z1-h, color or tocolor(124, 197, 118), size, false) -- alja
	dxDrawLine3D(x1, y1, z1, x1, y1, z1+h, color or tocolor(124, 197, 118), size, false) -- bal
	dxDrawLine3D(x1, y1 + w, z1, x1, y1 + w, z1+h, color or tocolor(124, 197, 118), size, false) -- jobb
end

function dxDrawBorder(x, y, sz, m, vastagsag, alpha,r,g,b, state)
	if not alpha then
		alpha = 180
	end
	if not r and not g and not b then
		r,g,b = 0,0,0
	end
	state = state or false
	dxDrawRectangle ( x, y-vastagsag, sz, vastagsag, tocolor(r,g,b,alpha), state ) -- Felso
	dxDrawRectangle ( x-vastagsag, y-vastagsag, vastagsag, m+(vastagsag*2), tocolor(r,g,b,alpha), state ) -- Bal
	dxDrawRectangle ( x+sz, y-vastagsag, vastagsag, m+(vastagsag*2), tocolor(r,g,b,alpha), state ) -- Jobb
	dxDrawRectangle ( x, y+m, sz, vastagsag, tocolor(r,g,b,alpha), state ) -- Also
end


function getPositionInfrontOfElement(x,y,z, rot, meters)
    local meters = (type(meters) == "number" and meters) or 3
    local posX, posY, posZ = x,y,z
    posX = posX - math.sin(math.rad(rot)) * meters
    posY = posY + math.cos(math.rad(rot)) * meters
    rot = rot + math.cos(math.rad(rot))
    return posX, posY, posZ , rot
end
