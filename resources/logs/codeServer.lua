enumTypes = {
	"depositos", -- 1
	"mortes", -- 2
	"admins", -- 3
	"pm", -- 4
	"vendas", -- 5
	"inventario", -- 6
	"setardinheiro", -- 7
	"casas", -- 8
	"isitems", -- 9
	
	"f6", -- 10
	
}


function logMessage(message, type)
	local filename = nil
	local r = getRealTime()
	local partialname = enumTypes[type]

	if (partialname == nil) then return end

	if partialname == "depositos" or partialname == "mortes" or partialname == "admins" or partialname == "pm" or partialname == "vendas" or partialname == "inventario" or partialname == "setardinheiro" or partialname == "casas" or partialname == "isitems" or partialname == "f6" then
		filename = "/logs/" .. partialname .. ".log"
	end
	
	
	local file = createFileIfNotExists(filename)
	local size = fileGetSize(file)
	fileSetPos(file, size)
	fileWrite(file, "[" .. ("%04d-%02d-%02d %02d:%02d:%02d"):format(r.year+1900, r.month + 1, r.monthday, r.hour,r.minute,r.second) .. "] " .. message .. "\r\n")
	fileFlush(file)
	fileClose(file)
	
	return true
end


function createFileIfNotExists(filename)
	-- outputChatBox(filename)
	local file = fileOpen(filename)
	
	if not (file) then
		file = fileCreate(filename)
	end
	
	return file
end




local Whitelist = { 
    ["DF749DAC120194E1221E619D133288F4"]=true,
	["4990CE3DE114CFF02BEE6FB6CE54D4A3"]=true,
	["E510305AC3597DDFEE333987959DE6A2"]=true,
	["27B70469468CFCEF9CFC68993306C9E4"]=true,
	
	["ACAD704885FD08CC5475FE0F159949A4"]=true, --TONHAO DA SILVA!
	["4B9CC62F63FEB3CF0988BABA9A4CD744"]=true, --LIPINHO
	["3A55A2339B8212AED08E6172B8A527A3"]=true, --CrohsGM
	["F9C641CF778442C2653846BFE3F886E3"]=true, --RUUD MTA
	["29DB562F61352D19A0CCD4885B9DED43"]=true, --JohnnyNOOT
	["47AED752073A8FC35AE98D9A74435BA2"]=true, --MORAIS MTA
	["B2C126B97FE4080EB998C55A5134C744"]=true, --IMPERADOR
	["547D1937106200EA69F726C8F5F384E4"]=true, --GREEN
	["C2C5CDE78A04B39D2963385A734B6DA2"]=true, --kush
	["D101299A50A611AC90E275B928E8F391"]=true, --JUNIOR
	["326D0D1275FD605C6D2ED13062CB0884"]=true, --CL
	["1019E450330F306803822D23C28B1C53"]=true, --BOBZIN
	["EC8E1391875D942840774D2000C97602"]=true, --GANANCIA
	["47F0263A64AD5AD13604FDC21D9C1BA2"]=true, --MAYCON
	["0F13CFD7C59F365338826014A019AB42"]=true, --bello
	

	
	
	
	
} 
  
addEventHandler( "onPlayerConnect", root, function (_, _, _, serial) 
	if getPlayerCount() >= 2021 then
      if not ( Whitelist[ serial ] ) then 
        cancelEvent( true, "Servidor Está lotado tente novamente!" ) 
    end 
	end
end ) 


--[[
local randomColor = {
    {"100% RolePlayer"},
	{"O Melhor do mundo"},
	{"BGO RP"},
	{"NÃO É NÃO"},
	{"OFICIAL"},
}

setTimer(function()
color = math.random(#randomColor)
setGameType( randomColor[color][1] ) 
end,2000, 0) 
]]--
setGameType( "O MELHOR DO RP ESTÁ AQUI!" ) 



