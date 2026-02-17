-- Scripted by: Bence Developer
screenX, screenY = guiGetScreenSize()
x, y = 1366, 768
relX, relY = screenX/x, screenY/y
chaletlondon = dxCreateFont("fonts/chaletlondon.ttf", 24*relY, false, "antialiased")
signpainter = dxCreateFont("fonts/signpainter.ttf", 24*relY, false, "antialiased")

local enabledKeys = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "ö", "ü", "ó", "ű", "q", "w", "e", "r", "t", "z", "u", "i", "o", "p", "ő", "ú", "a", "s", "d", "f", "g", "h", "j", "k", "l", "é", "á", "í", "y", "x", "c", "v", "b", "n", "m", ",", ".", "-"}
local rshiftKeys = {
	[0] = "§",
	[1] = "'",
	[2] = "\"",
	[3] = "+",
	[4] = "!",
	[5] = "%",
	[6] = "/",
	[7] = "=",
	[8] = "(",
	[9] = ")",
	[","] = "?",
	["."] = ":",
	["-"] = "_",
}
local raltKeys = {
	[1] = "~",
	[2] = "ˇ",
	[3] = "^",
	[4] = "˘",
	[5] = "°",
	[6] = "˛",
	[7] = "`",
	[8] = "˙",
	[9] = "´",
	["q"] = "\\",
	["w"] = "|",
	["e"] = "Ä",
	["u"] = "€",
	["i"] = "Í",
	["ő"] = "÷",
	["ú"] = "×",
	["a"] = "ä",
	["s"] = "đ",
	["d"] = "Đ",
	["f"] = "[",
	["g"] = "]",
	["j"] = "í",
	["k"] = "ł",
	["l"] = "Ł",
	["é"] = "$",
	["á"] = "ß",
	["í"] = "<",
	["y"] = ">",
	["x"] = "#",
	["c"] = "&",
	["v"] = "@",
	["b"] = "{",
	["n"] = "}",
	["m"] = "<",
	[","] = ";",
	["."] = ">",
	["-"] = "*",
}

function isKeyRshift(key)
	for k, v in pairs(rshiftKeys) do
		if (tostring(k)==tostring(key)) then
			return tostring(v)
		end
	end
	return false
end

function isKeyRalt(key)
	for k, v in pairs(raltKeys) do
		if (tostring(k) == tostring(key)) then
			return tostring(v)
		end
	end
	return false
end

function getKeyAction(key)
	if (key == "backspace") then
		return "backspace"
	end
	if (key=="enter") then
		return "enter"
	end
	if (getKeyState("rshift") and isKeyRshift(key)) then
		return isKeyRshift(key)
	end
	if (getKeyState("ralt") and isKeyRalt(key)) then
		return isKeyRalt(key)
	end
	for i, v in ipairs(enabledKeys) do
		if (tostring(v) == tostring(key)) then
			if (getKeyState("lshift") or getKeyState("rshift")) then
				return v:gsub("^%l", string.upper)
			else
				return v
			end
		end	
	end
	return false
end

function backspace(text)
	local ki = ""
	for i=0, utfLen(text)-2 do
		ki = ki..utfSub( text, i+1, i+1 )
	end
	return ki
end

function passwordCode (password)
	local length = utfLen(password)
	return string.rep ("*", length)
end

function isMouseInPosition (x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end


cabelo = { 
	[0] = {0, 50},
	[1] = {1, 50},
	[2] = {2, 50},
	[3] = {3, 50},
	[4] = {4, 50},
	[5] = {5, 50},
	[6] = {6, 50},
	[7] = {7, 50},
	[8] = {8, 50},
	[9] = {9, 50},
	[10] = {10, 50},
	[11] = {11, 50},
	[12] = {12, 50},
	[13] = {13, 50},
	[14] = {14, 50},
	[15] = {15, 50},
	[16] = {16, 50},
	[17] = {17, 50},
	[18] = {18, 50},
	[19] = {19, 50},
	[20] = {20, 50},
	[21] = {21, 50},
	[22] = {22, 50},
	[23] = {23, 50},
	[24] = {24, 50},
	[25] = {25, 50},
	[26] = {26, 50},
	[27] = {27, 50},
	[28] = {28, 50},
	[29] = {29, 50},
	[30] = {30, 50},
	[31] = {31, 50},
	[32] = {32, 50},


}


