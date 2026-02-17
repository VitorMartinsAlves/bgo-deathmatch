
local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1920), (screenH/1080)

--local font = dxCreateFont("font/font.otf", 22)
local font = dxCreateFont('font/font.otf', 100, false, 'proof') or 'sans'



function DxPainel ()
	local infos = {
		Vida = getElementHealth(localPlayer),
		Colete = getPedArmor(localPlayer),
		Fome = getElementData(localPlayer, "char:hunger") or 0,
		Sede = getElementData(localPlayer, "char:thirst") or 0,
		Defecar = getElementData(localPlayer, "char:Cagar") or 0,
		Quantidade = #getElementsByType("player"),
	}
		if getElementData(localPlayer, "acc:admin") > 0 then
			isAdmin = "Sim"
		else
			isAdmin = "Não"
		end

		playerInfos = {
			"Seu nome: " .. getElementData(localPlayer, "char:name"):gsub("_", " ") or getPlayerName(localPlayer),
			"Id da conta: " .. getElementData(localPlayer, "acc:id"),
			"Seu Level: "..(getElementData(localPlayer, "Sys:Level") or 0).." XP: "..(getElementData(localPlayer, "LSys:EXP") or 0),
			"Seu Telefone: " .. getElementData(localPlayer, "char:playedTime") or 0,
			"Último login: " .. getElementData(localPlayer, "acc:lastlogin") or 0,
			"Admin: " .. isAdmin .. " - Nível: " .. getElementData(localPlayer, "acc:admin") or 0,
			"Nome admin: " .. getElementData(localPlayer, "char:anick") or 0
		}
		exports["BGOBlur"]:dxDrawBluredRectangle(x*0, y*0, x*1920, y*1080, tocolor(255, 255, 255, 255))
	dxDrawImage(x*0, y*0, x*1920, y*1080, "font/tab.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImageSection(x*386, y*285, x*115, y*-(115*(infos.Vida/100)), 0, 0, 35, -(35*(infos.Vida/100)), "font/Fundo.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
	dxDrawImageSection(x*386, y*433, x*115, y*-(115*(infos.Colete/100)), 0, 0, 35, -(35*(infos.Colete/100)), "font/Fundo.png", 0, 0, 0, tocolor(255,255,255, 255), false)
	dxDrawImageSection(x*386, y*578, x*115, y*-(114*(infos.Fome/100)), 0, 0, 35, -(35*(infos.Fome/100)), "font/Fundo.png", 0, 0, 0, tocolor(248, 153, 56, 255), false)
	dxDrawImageSection(x*386, y*725, x*115, y*-(115*(infos.Sede/100)), 0, 0, 35, -(35*(infos.Sede/100)), "font/Fundo.png", 0, 0, 0, tocolor(0, 180, 204, 255), false)
	dxDrawImageSection(x*386, y*872, x*115, y*-(115*(infos.Defecar/100)), 0, 0, 35, -(35*(infos.Defecar/100)), "font/Fundo.png", 0, 0, 0, tocolor(150, 75, 0, 255), false)
	dxDrawImage(x*0, y*0, x*1920, y*1080, "font/vidas.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

	for key, value in ipairs(playerInfos) do
	chatY = y*190+key*(y*147)
	dxDrawText(value, x*596, chatY, x*1424, y*369, tocolor(0, 0, 0, 255), y*2, "sans", "left", "center", false, false, true, false, false)
	end
	
	dinheiro = thousandsStepper(getElementData(localPlayer, "char:money"))
	banco = thousandsStepper(getElementData(localPlayer, "char:bankmoney"))
	pp = thousandsStepper(getElementData(localPlayer, "char:pp"))
	
	dxDrawText("Dinheiro VIP:", x*1125, y*380, x*1424, y*369, tocolor(0, 0, 0, 255), y*1.9, "sans", "left", "center", false, false, true, false, false)
	
	dxDrawText(""..pp.."", x*1125, y*455, x*1424, y*369, tocolor(0, 0, 0, 205), y*0.27, font, "left", "center", false, false, true, false, false)
					

	dxDrawText("Dinheiro:", x*1125, y*630, x*1424, y*369, tocolor(0, 0, 0, 255), y*1.9, "sans", "left", "center", false, false, true, false, false)
		
	dxDrawText(""..dinheiro.."", x*1125, y*695, x*1424, y*369, tocolor(0, 0, 0, 205), y*0.27, font, "left", "center", false, false, true, false, false)
				
				
	dxDrawText("Saldo Bancário:", x*1125, y*780, x*1424, y*369, tocolor(0, 0, 0, 255), y*1.9, "sans", "left", "center", false, false, true, false, false)
		
	dxDrawText(""..banco.."", x*1125, y*845, x*1424, y*369, tocolor(0, 0, 0, 205), y*0.27, font, "left", "center", false, false, true, false, false)

	dxDrawText("Jogadores online: "..infos.Quantidade.."", x*1135, y*90, x*1224, y*169, tocolor(0, 0, 0, 255), y*0.2, font, "left", "center", false, false, true, false, false)
				
	dxDrawText("Jogadores online: "..infos.Quantidade.."", x*1135, y*90, x*1224, y*169, tocolor(255, 255, 255, 255), y*0.2, font, "left", "center", false, false, true, false, false)
	
end



function thousandsStepper(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if k == 0 then
			break
		end
	end
	return formatted
end

local ativo = false

function printMessageFunction() 
    if getElementData(localPlayer, "SEQUESTRANDO:Vitima") then return end
	if (getKeyState( "Tab" ) == true) then
		if not ativo then
		ativo = true
addEventHandler ( "onClientRender", root, DxPainel )
		showChat(false)
		end
	else
		if ativo then
		ativo = false
		showChat(true)
removeEventHandler ( "onClientRender", root, DxPainel )
		end
	end
end
addEventHandler("onClientRender", root,printMessageFunction)





function drawBorde(x, y, w, h, borderColor, bgColor, postGUI)
  if (x and y and w and h) then
      if (not borderColor) then
          borderColor = tocolor(0, 0, 0, 200)
      end
      
      if (not bgColor) then
          bgColor = borderColor
      end        
      postGUI = false

      dxDrawRectangle(x, y, w, h, bgColor, postGUI)

      dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI) -- top
      dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI) -- bottom
      dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI) -- left
      dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI) -- right
  end
end
