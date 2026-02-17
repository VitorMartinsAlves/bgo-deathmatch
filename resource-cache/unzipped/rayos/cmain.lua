addEvent("zm-rayo",true)

local root = getRootElement()
local rayos = {}
local lplayer = getLocalPlayer()

addEventHandler("zm-rayo",root,function(data)
	data[9] = 0
	
	local z = getGroundPosition(data[6],data[7],data[3])
	if z then
		local _,x,y,lz = processLineOfSight(data[4],data[5],data[3]-75,data[6],data[7],z)
		if lz then
			data[6],data[7] = x,y
		end
	end
	data[8] = lz or z or 0
	data[9] = (data[3]-data[8])/2
	
	table.insert(rayos,data)
	local sound = playSound3D("trueno.ogg",data[6],data[7],data[8])
	setSoundMaxDistance(sound,100)
	createExplosion(data[6],data[7],data[8],12,false)
end)

addEventHandler("onClientRender",root,function()
	for k,v in ipairs(rayos) do
		local color = tocolor(200,200,255)
		dxDrawLine3D(v[1],v[2],v[3],v[1],v[2],v[3]-v[9],color,5)
		dxDrawLine3D(v[1],v[2],v[3]-v[9],v[4],v[5],v[3]-v[9],color,5)
		dxDrawLine3D(v[4],v[5],v[3]-v[9],v[6],v[7],v[8],color,5)
		v[9] = v[9] + 1
		if v[9] > 3 then
			table.remove(rayos,k)
		end
	end
end)