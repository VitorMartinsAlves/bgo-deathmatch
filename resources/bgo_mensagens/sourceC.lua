
local tips = {
	{'#fff000Digite /discord para acessar o link do nosso Discord.'},
}
	local rand = math.random(1, #tips)
	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox(tips[rand][1], root, 255, 255, 255, true)
         	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)

setTimer( function()
	local rand = math.random(1, #tips)

	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox(tips[rand][1], root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)
end, 120000, 0)