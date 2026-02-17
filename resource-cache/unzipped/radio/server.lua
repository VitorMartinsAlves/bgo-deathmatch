local parent	= Element("radio_parent", "radio_parent")
local instances = {}
local radio = {
	create = function(self, player, attachto)
		local pos = player:getPosition()

		self.owner	 = player
		self.object	 = Object(SETTINGS.RADIO_MODEL, pos.x, pos.y, pos.z - 1, 0, 0, 0, true)
		self.station = 1
		self.volume	 = 0.5
		instances[self.object] = self
		
		self.object:setInterior(player:getInterior())
		self.object:setDimension(player:getDimension())
		self.object:setParent(parent)

		if attachto then
			self.attachto = attachto
			self.object:attach(unpack(attachto))
			self.object:setAlpha(0)
		else
			player:setAnimation("misc", "pickup_box", -1, false, false, false, false)
		end
		triggerClientEvent(player, "toggleRadioPanel", resourceRoot, self.object)
	end,

	destroy = function(self)
		triggerClientEvent("onRadioPickup", self.object)
		instances[self.object] = nil
		self.object:destroy()
		self = nil
	end,

	pickup = function(self, player)
		self:destroy()
		player:setAnimation("misc", "pickup_box", -1, false, false, false, false)
	end,

	getByElement = function(self, element) -- static
		return instances[element]
	end,

	sendDetailsToClient = function(self, player)
		triggerClientEvent(player, "receiveRadioDetails", self.object, self)
	end,

	nextStation = function(self)
		self.station = self.station == #SETTINGS.STATIONS and 1 or self.station + 1
		self:sendDetailsToClient(root)
	end,

	prevStation = function(self)
		self.station = self.station == 1 and #SETTINGS.STATIONS or self.station - 1
		self:sendDetailsToClient(root)
	end,

	changeStation = function(self, data)
		if type(data) == "number" then
			self.station = data
			self:sendDetailsToClient(root)
		elseif data == "prev" then self:prevStation() else self:nextStation() end
	end,

	setVolume = function(self, volume)
		self.volume = volume
		self:sendDetailsToClient(root)
	end,
}

addEvent("placeRadio", true)
addEventHandler("placeRadio", root, function(...)
	setmetatable({}, {__index = radio}):create(source, ...)
end)

addEvent("pickupRadio", true)
addEventHandler("pickupRadio", parent, function()
	radio:getByElement(source):pickup(client)
end)

addEvent("requestRadioDetails", true)
addEventHandler("requestRadioDetails", parent, function()
	radio:getByElement(source):sendDetailsToClient(client)
end)

addEvent("changeRadioStation", true)
addEventHandler("changeRadioStation", parent, function(type)
	radio:getByElement(source):changeStation(type)
end)

addEvent("setRadioVolume", true)
addEventHandler("setRadioVolume", parent, function(volume)
	radio:getByElement(source):setVolume(volume)
end)

addEvent("moveRadio", true)
addEventHandler("moveRadio", parent, function(type, args)
	local instance = radio:getByElement(source)
	
	if instance.attachto then
		source:detach(instance.attachto[1])
		source:setAlpha(255)
		instance.attachto = nil
	end
	
	if type == "ground" then
		source:setPosition(unpack(args))
	elseif type == "attach" then
		source:attach(unpack(args))
		source:setAlpha(0)
		instance.attachto = args
	end
	
	instance:sendDetailsToClient(root)
	triggerClientEvent(client, "toggleRadioPanel", resourceRoot, source)
end)


addEventHandler("onPlayerQuit", root, function()
	for instance, v in pairs(instances) do
		if v.owner == source then
			return instance:destroy()
		end
	end
end)