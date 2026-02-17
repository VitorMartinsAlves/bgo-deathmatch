-- // Script Created by Steve Scott // --
-- // Change these datas to your own! // --

local host = "localhost"
local username = "bgo"
local password = "3u29fH0k8fUBwRGh"
local database = "bgo"
local connection = dbConnect( "mysql", "dbname="..database..";host="..host, username, password, "charset=utf8" )

addCommandHandler("addinterior",
	function(playerSource, commandName, intid, inttype, cost, ...)
		if getElementData(playerSource, "acc:admin") >= 8 then
			if intid and inttype and cost and (...) then
				name = table.concat({...}, " ")
				x,y,z = getElementPosition(playerSource)
				intbel = interiorok[tonumber(intid)]
				if intbel then
					local interiorid = intbel[1]
					local ix = intbel[2]
					local iy = intbel[3]
					local iz = intbel[4]
					local marker_int = getElementInterior(playerSource)
					local marker_dim = getElementDimension(playerSource)
					local query = dbQuery(connection, "INSERT INTO interiors SET x = ?, y = ?, z = ?, interiorx = ?, interiory = ?, interiorz = ?, name = ?, type = ?, cost = ?, interior = ?, interiorwithin = ?, dimensionwithin = ?, customint = ?, owner = ?",x, y, z, ix, iy, iz, name, inttype, cost, interiorid, marker_int, marker_dim, 0, 0)
					local insertered, _, insertid = dbPoll(query, -1)
					if insertered then
						loadOneInteriorWhereID(insertid)
					end
					outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff Interior created, ID: #33ccff"..insertid, playerSource,124, 197, 118,true)
				end
			else
				outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff /" .. commandName .. " [InteriorID] [Type] [Price] [Name]", playerSource,124, 197, 118,true)
				outputChatBox("#99cc99[Types]:#ffffff [0 - House] [1 - Bussiness] [2 - State building] [4 - Garage]", playerSource,124, 197, 118,true)
			end
		end
	end
)

addCommandHandler("delinterior",
	function (playerSource, cmd, id)
		if getElementData(playerSource, "acc:admin") >= 8 then
			if not id then outputChatBox("#99cc99[BGOMTA - Interior]#ffffff /".. cmd .." [InteriorID]",playerSource, 124, 197, 118, true) return end
			local delMarker = nil
			for k, v in pairs(getElementsByType("marker")) do
				if tostring(getElementData(v, "acc:id")) == tostring(id) then
					delMarker = v
					break
				end
			end
			if isElement(delMarker) then destroyElement(delMarker) end
			if dbPoll(dbQuery(connection,"DELETE FROM interiors WHERE id=?",id),-1) then
				outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff Interior deleted! #33ccff("..id..")",playerSource,124, 197, 118,true)
			end
		end
	end
)

addEventHandler("onResourceStart",resourceRoot,function()
	local loadCount = 0
	local Query = dbPoll(dbQuery(connection,"SELECT * FROM interiors"),-1)
	if (Query) then
		for k, v in ipairs(Query) do
			loadOneInteriorWhereID(v["id"])
			loadCount = loadCount+1
		end
	end
end)

function loadOneInteriorWhereID(id)
	local Query = dbPoll(dbQuery(connection,"SELECT * FROM interiors WHERE id=?",id),-1)
	if (Query) then
		for i,row in ipairs(Query) do
			if row["owner"] <= 0 and row["type"] == 0 then -- 102, 204, 255
				markerElement = createMarker( row["x"], row["y"], row["z"]-1, "cylinder", 0.7, 102, 204, 255, 100)
				intmarkerElement = createMarker( row["interiorx"], row["interiory"], row["interiorz"]-1, "cylinder", 0.7, 102, 204, 255, 100)
			elseif row["type"] == 1 then
				markerElement = createMarker( row["x"], row["y"], row["z"]-1, "cylinder", 0.7, 221, 118, 0, 100)
				intmarkerElement = createMarker( row["interiorx"], row["interiory"], row["interiorz"]-1, "cylinder", 0.7, 221, 118, 0, 100)
			elseif row["type"] == 2 then
				markerElement = createMarker( row["x"], row["y"], row["z"]-1, "cylinder", 0.7, 221, 118, 0, 100)
				intmarkerElement = createMarker( row["interiorx"], row["interiory"], row["interiorz"]-1, "cylinder", 0.7, 221, 118, 0, 100)
			elseif row["type"] == 4 then
				markerElement = createMarker( row["x"], row["y"], row["z"]-1, "cylinder", 0.7, 56, 66, 71, 100)
				intmarkerElement = createMarker( row["interiorx"], row["interiory"], row["interiorz"]-1, "cylinder", 0.7, 56, 66, 71, 100)
			else
				markerElement = createMarker( row["x"], row["y"], row["z"]-1, "cylinder", 0.7, 102, 204, 255, 100)
				intmarkerElement = createMarker( row["interiorx"], row["interiory"], row["interiorz"]-1, "cylinder", 0.7, 102, 204, 255, 100)
			end
			local Query = dbPoll(dbQuery(connection,"SELECT * FROM characters WHERE id=?", row["owner"]),-1)
			if Query then
				for k, v in ipairs(Query) do
					ownerName = v["charname"]
				end
			end
			setElementData(markerElement,"ownerName",ownerName)
			setElementData(intmarkerElement,"ownerName",ownerName)
			setElementData(markerElement,"isIntMarker",true)
			setElementData(intmarkerElement,"isIntOutMarker",true)
			setElementData(markerElement,"other",intmarkerElement)
			setElementData(intmarkerElement,"other",markerElement)
			setElementData(markerElement,"acc:id",row["id"])
			setElementData(intmarkerElement,"acc:id",row["id"])
			setElementData(markerElement,"inttype",row["type"])
			setElementData(intmarkerElement,"inttype",row["type"])
			setElementData(markerElement,"owner",row["owner"])
			setElementData(intmarkerElement,"owner",row["owner"])

			setElementData(markerElement,"x",row["x"])
			setElementData(intmarkerElement,"x",row["interiorx"])
			setElementData(markerElement,"y",row["y"])
			setElementData(intmarkerElement,"y",row["interiory"])
			setElementData(markerElement,"z",row["z"])
			setElementData(intmarkerElement,"z",row["interiorz"])

			setElementData(intmarkerElement,"outx",row["x"])
			setElementData(intmarkerElement,"outy",row["y"])
			setElementData(intmarkerElement,"outz",row["z"])

			setElementData(markerElement, "angle", row["angle"])
			setElementData(markerElement, "locked", row["locked"])
			setElementData(markerElement, "cost", row["cost"])
			setElementData(markerElement, "name", row["name"])
			setElementData(markerElement, "fee", row["fee"])
			setElementData(markerElement, "customint", row["customint"])
			setElementData(markerElement, "light", row["light"])
			setElementDimension(markerElement, row["dimensionwithin"])
			setElementInterior(markerElement, row["interiorwithin"])
			setElementData(markerElement, "size", row["size"])

			setElementData(intmarkerElement, "angle", row["angleexit"])
			setElementData(intmarkerElement, "locked", row["locked"])
			setElementData(intmarkerElement, "cost", row["cost"])
			setElementData(intmarkerElement, "name", row["name"])
			setElementData(intmarkerElement, "fee", row["fee"])
			setElementData(intmarkerElement, "customint", row["customint"])
			setElementData(intmarkerElement, "light", row["light"])
			setElementInterior(intmarkerElement, row["interior"])
			if row["interior"] == 0 and not row["customint"] then
				setElementDimension(intmarkerElement, 0)
			else
				setElementDimension(intmarkerElement, row["id"])
			end
		end
	end
end

addEvent("lockIntToClient",true)
addEventHandler("lockIntToClient",getRootElement(),function(playerSource,id,lock)
	dbExec(connection, "UPDATE interiors SET locked = ? WHERE id = ?",lock,id)
end)

function updateInteriorOwner(intID,playerSource,intCost)
	--if exports.sas_items:giveItem(playerSource, 2, intID, 1,0) then
		local res = dbPoll(dbQuery(connection, "UPDATE interiors SET owner=? WHERE id = ?",getElementData(playerSource,"acc:id"),intID),-1)
		for k, v in ipairs(getElementsByType("marker")) do
			if getElementData(v, "acc:id") == intID then
				destroyElement(v)
			end
		end
		loadOneInteriorWhereID(intID)
		setElementData(playerSource,"char:money",(getElementData(playerSource,"char:money") or 0)-intCost)
end
addEvent("updateInteriorOwner", true)
addEventHandler("updateInteriorOwner", getRootElement(), updateInteriorOwner)

function changeInterior(playerSource, x, y, z, int, dim, customInt, dbID)
	if customInt then
		exports.bgo_customint:callLoadInteriorTextures(playerSource, dbID)
	end
	setElementPosition(playerSource, x, y, z)
	if int == 0 and not customInt then
		setElementDimension(playerSource, 0)
	else
		setElementDimension(playerSource, dim)
	end
	setElementInterior(playerSource, int)
	if dim == 0 then
		local hour, minute = getTime()
		triggerClientEvent(playerSource, "setBackToActualTime", playerSource, hour, minute)
	end
end
addEvent("changeInterior", true)
addEventHandler("changeInterior", getRootElement(), changeInterior)

function changeVehInterior(playerSource,veh, x, y, z, int, dim)
	local veh = getPedOccupiedVehicle(playerSource)
	if veh then
		setElementPosition(veh, x, y, z)
		setElementDimension(veh, dim)
		setElementInterior(veh, int)
		setElementPosition(playerSource, x, y, z)
		setElementDimension(playerSource, dim)
		setElementInterior(playerSource, int)
	end
end
addEvent("changeVehInterior", true)
addEventHandler("changeVehInterior", getRootElement(), changeVehInterior)

function giveInteriorKey(playerSource,value, pay)
	--if exports.sas_items:giveItem(playerSource, 2, value, 1,0) then
		--setElementData(playerSource,"char:money",(getElementData(playerSource,"char:money") or 0)-pay)
--	end
end
addEvent("giveInteriorKey",true)
addEventHandler("giveInteriorKey",getRootElement(),giveInteriorKey)


addCommandHandler("setinteriorname",function(playerSource,cmd,id,...)
	if getElementData(playerSource, "acc:admin") >= 8 then
		if id and (...) then
			id = tonumber(id)
			reName = table.concat({...}, " ")
			for k,v in ipairs(getElementsByType("marker")) do
				if getElementData(v,"acc:id") == id then
					outputChatBox("#99cc99[BGOMTA]:#ffffff Interior renamed #33ccff("..getElementData(v,"name")..")#ffffff -> #33ccff"..reName.."#ffffff.",playerSource,124, 197, 118,true)
					setElementData(v,"name",reName)
					dbExec(connection, "UPDATE interiors SET name = ? WHERE id = ?",reName,id)
				end
			end
		else
			outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff /"..cmd.." [interiorID] [Name]",playerSource,124, 197, 118,true)
		end
	end
end)

addCommandHandler("setinteriorcost",function(playerSource,cmd,markerID,newCost)
	--if getElementData(playerSource, "acc:admin") >= 8 then
		if markerID and newCost then
			markerID = tonumber(markerID)
			newCost = tonumber(newCost)
			for k,v in ipairs(getElementsByType("marker")) do
				if getElementData(v,"acc:id") == markerID then
					setElementData(v,"cost",newCost)
					dbExec(connection, "UPDATE interiors SET cost = ? WHERE id = ?",newCost,markerID)
				end
			end
			outputChatBox("#99cc99[BGOMTA]:#ffffff Price changed -> #33ccff"..newCost.."#ffffff.",playerSource,124, 197, 118,true)
		else
			outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff /"..cmd.." [interiorID] [NewPrice]",playerSource,124, 197, 118,true)
		end
	--end
end)

addCommandHandler("getinteriorcost",function(playerSource)
--	if getElementData(playerSource, "acc:admin") >= 8 then
		if getElementData(playerSource, "isInIntMarker") == true then
			local theIntElement = getElementData(playerSource,"int:Marker")
			if getElementData(theIntElement,"isIntMarker") == true then
				local defaultCost = getElementData(theIntElement,"cost")
				outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff This interior costs #33ccff"..defaultCost.."#ffffff $.",playerSource,124, 197, 118,true)
			end
		else
			outputChatBox("#d9534f[BGOMTA - Interior]:#ffffff You are not in a marker.",playerSource,124, 197, 118,true)
		end
--	end
end)

addCommandHandler("sellinterior",function(playerSource)
	if getElementData(playerSource, "isInIntMarker") == true then
		local theMarkElement = getElementData(playerSource,"int:Marker")
		local theMarkOwner = getElementData(theMarkElement,"owner")
		if getElementData(theMarkElement,"isIntMarker") == true then
			if tonumber(getElementData(playerSource,"acc:id")) == tonumber(theMarkOwner) then
				local theMarkCost = getElementData(theMarkElement,"cost")
				local theMarkID = getElementData(theMarkElement,"acc:id")
				setElementData(playerSource,"char:money",getElementData(playerSource,"char:money")-(theMarkCost/2))
				outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff You have successfully sold your interior for #33ccff"..(theMarkCost/2).."#ffffff $.",playerSource,124, 197, 118,true)
				dbExec(connection, "UPDATE interiors SET owner = ? WHERE id = ?",0,theMarkID)
				for k, v in ipairs(getElementsByType("marker")) do
					if getElementData(v, "acc:id") == theMarkID then
						destroyElement(v)
					end
				end
				loadOneInteriorWhereID(theMarkID)
				setElementData(playerSource,"isInIntMarker",false)
				setElementData(playerSource,"int:Marker",nil)
			else
				outputChatBox("#d9534f[BGOMTA]:#ffffff This is not your interior.",playerSource,124, 197, 118,true)
			end
		end
	else
		outputChatBox("#d9534f[BGOMTA]:#ffffff You are not in marker.",playerSource,124, 197, 118,true)
	end
end)

addCommandHandler("asell",function(playerSource)
--	if getElementData(playerSource, "acc:admin") >= 10 then
		if getElementData(playerSource, "isInIntMarker") == true then
			local theMarkElement = getElementData(playerSource,"int:Marker")
			local theMarkOwner = getElementData(theMarkElement,"owner")
			if getElementData(theMarkElement,"isIntMarker") == true then
				--if tonumber(getElementData(playerSource,"acc:id")) == tonumber(theMarkOwner) then
					local theMarkCost = getElementData(theMarkElement,"cost")
					local theMarkID = getElementData(theMarkElement,"acc:id")
					--setElementData(playerSource,"char:money",getElementData(playerSource,"char:money")-(theMarkCost/2))
					outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff You have sold this interior for #33ccff"..(theMarkCost/2).."#ffffff $.",playerSource,124, 197, 118,true)
					dbExec(connection, "UPDATE interiors SET owner = ? WHERE id = ?",0,theMarkID)
					for k, v in ipairs(getElementsByType("marker")) do
						if getElementData(v, "acc:id") == theMarkID then
							destroyElement(v)
						end
					end
					loadOneInteriorWhereID(theMarkID)
					setElementData(playerSource,"isInIntMarker",false)
					setElementData(playerSource,"int:Marker",nil)

			end
		else
			outputChatBox("#d9534f[BGOMTA]:#ffffff You are not in marker.",playerSource,124, 197, 118,true)
		end
--	end
end)


addCommandHandler("gotohouse",function(playerSource,cmd,number)
	if getElementData(playerSource,"acc:admin") >= 2 then
		number = tonumber(number)
		if number then
			for k,v in ipairs(getElementsByType("marker")) do
				if getElementData(v,"isIntMarker") == true then
					if getElementData(v,"acc:id") == number then
						local markX,markY,markZ = getElementPosition(v)
						local markInt = getElementInterior(v)
						local markDim = getElementDimension(v)
						setElementPosition(playerSource,markX,markY,markZ+1)
						setElementInterior(playerSource,markInt)
						setElementDimension(playerSource,markDim)
						outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff You have been teleported to the interior. #33ccff("..number..")", playerSource,124, 197, 118,true)
					end
				end
			end
		else
			outputChatBox("#99cc99[BGOMTA]:#ffffff /"..cmd.." [interiorID]", playerSource,124, 197, 118,true)
		end
	end
end)

addCommandHandler("setinteriorid",function(playerSource,cmd,reID)
	if getElementData(playerSource, "acc:admin") >= 8 then
		if reID then
			reID = tonumber(reID)
			if getElementData(playerSource, "isInIntMarker") == true then
				local theInteriorElement = getElementData(playerSource,"int:Marker")
				if getElementData(theInteriorElement,"isIntOutMarker") == true then
					intOut = interiorok[tonumber(reID)]
					if intOut then
						local interiorid = intOut[1]
						local ix = intOut[2]
						local iy = intOut[3]
						local iz = intOut[4]
						setElementPosition(playerSource,ix,iy,iz)
						setElementInterior(playerSource,interiorid)
						setElementPosition(theInteriorElement,ix,iy,iz-1)
						setElementInterior(theInteriorElement,interiorid)
						setElementData(theInteriorElement,"x",ix)
						setElementData(theInteriorElement,"y",iy)
						setElementData(theInteriorElement,"z",iz)
						dbExec(connection, "UPDATE interiors SET interiorx = ?, interiory = ?, interiorz = ?, interior = ? WHERE id = ?",ix,iy,iz,interiorid,getElementData(theInteriorElement,"acc:id"))
						outputChatBox("#99cc99[BGOMTA]:#ffffff Interior ID changed.",playerSource,124, 197, 118,true)
					end
				end
			else
				outputChatBox("#d9534f[BGOMTA]:#ffffff You are not in marker.",playerSource,124, 197, 118,true)
			end
		else
			outputChatBox("#99cc99[BGOMTA]:#ffffff /"..cmd.." [interiorID]",playerSource,124, 197, 118,true)
		end
	end
end)

addCommandHandler("setinteriorexit",function(playerSource,cmd,number)
	if getElementData(playerSource,"acc:admin") >= 8 then
		number = tonumber(number)
		if number then
			for k,v in ipairs(getElementsByType("marker")) do
				if getElementData(v,"isIntOutMarker") == true then
					if getElementData(v,"acc:id") == number then
						local newX,newY,newZ = getElementPosition(playerSource)
						local newInt = getElementInterior(playerSource)
						setElementPosition(v,newX,newY,newZ-1)
						setElementInterior(v,newInt)
						setElementData(v,"x",newX)
						setElementData(v,"y",newY)
						setElementData(v,"z",newZ)
						dbExec(connection, "UPDATE interiors SET interiorx = ?, interiory = ?, interiorz = ?, interior = ? WHERE id = ?",newX,newY,newZ,newInt,getElementData(v,"acc:id"))
						outputChatBox("#99cc99[BGOMTA - Interior]:#ffffff Interior exit has been changed. #33ccff("..number..")", playerSource,124, 197, 118,true)
					end
				end
			end
		else
			outputChatBox("#99cc99[BGOMTA]:#ffffff /"..cmd.." [interiorID]", playerSource,124, 197, 118,true)
		end
	end
end)
