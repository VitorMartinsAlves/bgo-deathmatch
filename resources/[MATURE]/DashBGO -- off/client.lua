--[[
===========================================================
# Minha página: https://www.facebook.com/TioSteinScripter/#
#      ╔════╗╔══╗╔═══╗     ╔═══╗╔════╗╔═══╗╔══╗╔═╗─╔╗     #
#      ║╔╗╔╗║╚╣─╝║╔═╗║     ║╔═╗║║╔╗╔╗║║╔══╝╚╣─╝║║╚╗║║     #
#      ╚╝║║╚╝─║║─║║─║║     ║╚══╗╚╝║║╚╝║╚══╗─║║─║╔╗╚╝║     #
#      ──║║───║║─║║─║║     ╚══╗║──║║──║╔══╝─║║─║║╚╗║║     #
#      ──║║──╔╣─╗║╚═╝║     ║╚═╝║──║║──║╚══╗╔╣─╗║║─║║║     #
#      ──╚╝──╚══╝╚═══╝     ╚═══╝──╚╝──╚═══╝╚══╝╚╝─╚═╝     #
===========================================================
--]]

local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1920), (screenH/1080)

local painel = {
	Fonte01 = dxCreateFont("font/gotham_light.ttf", x*10),
	Fonte02 = dxCreateFont("font/OpenSans-Bold.ttf", x*12),
	Fonte03 = "default",--dxCreateFont("font/gotham_light.ttf", x*9),
	state = false,
}

local messages = {
	msg1 = nil,
	msg2 = nil,
	msg3 = nil,
	msg4 = nil,
	qnt = 0,
}
--[[
         ><><><><><><><><><><><><><><><><><><><><
         ><          Painel Inicial            ><
         ><><><><><><><><><><><><><><><><><><><><
--]]



function DxPainel ()
	local infos = {
		Vida = getElementHealth(localPlayer),
		Colete = getPedArmor(localPlayer),
		Name = getElementData(localPlayer, "char:name") or getPlayerName(localPlayer),
		Fome = getElementData(localPlayer, "char:hunger") or 0,
		Sede = getElementData(localPlayer, "char:thirst") or 0,
		Defecar = getElementData(localPlayer, "char:Cagar") or 0,
		Urinar = getElementData(localPlayer, "char:urinar") or 0,
		ID = getElementData(localPlayer, "acc:id") or "N/A",
		Level = getElementData(localPlayer, "Sys:Level") or 0,
		XP = getElementData(localPlayer, "LSys:EXP") or 0,
		Emprego = getElementData(localPlayer, "job") or "Desempregado",
		Quantidade = #getElementsByType("player"),
	}
	--exports["BGOBlur"]:dxDrawBluredRectangle(x*0, y*0, x*1920, y*1080, tocolor(255, 255, 255, 255))
	dxDrawImage(x*0, y*0, x*1920, y*1080, "font/dashboard.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if messages.qnt >= 1 then
		dxDrawImage(x*0, y*0, x*1920, y*1080, "font/circulo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(messages.qnt, x*1425, y*508, x*1447, y*526, tocolor(255, 255, 255, 255), 1.00, painel.Fonte01, "center", "center", false, true, true, false, false)
	end
	dxDrawText(infos.Quantidade.." ON", x*1399, y*462, x*1443, y*475, tocolor(255, 255, 255, 255), 1.00, painel.Fonte01, "right", "bottom", false, false, true, false, false)
	dxDrawText(infos.Name.." - "..infos.ID.."", x*1266, y*352, x*1424, y*369, tocolor(255, 255, 255, 255), 1.00, painel.Fonte02, "left", "center", false, false, true, false, false)
	dxDrawText("Emprego :\n"..infos.Emprego.."", x*1262, y*379, x*1306, y*392, tocolor(255, 255, 255, 255), 1.00, painel.Fonte03, "left", "top", false, false, true, false, false)
	dxDrawText("\nID : "..infos.ID, x*1262, y*396, x*1306, y*409, tocolor(255, 255, 255, 255), 1.00, painel.Fonte03, "left", "top", false, false, true, false, false)
	dxDrawText("\nLevel : "..infos.Level.."  |  XP : "..infos.XP.."", x*1262, y*411, x*1306, y*424, tocolor(255, 255, 255, 255), 1.00, painel.Fonte03, "left", "top", false, false, true, false, false)
	
	drawBorde(x*534, y*421, x*186/100*infos.Vida, y*189, tocolor(255, 79, 79, 255), false)
	drawBorde(x*748, y*418, x*134/100*infos.Fome, y*131, tocolor(248, 153, 56, 255), false)
	drawBorde(x*908, y*418, x*134/100*infos.Sede, y*131, tocolor(93, 136, 160, 255), false)
	drawBorde(x*530, y*634, x*194/100*infos.Colete, y*80, tocolor(130, 130, 130, 255), false)
	drawBorde(x*750, y*580, x*133/100*infos.Defecar, y*134, tocolor(134, 138, 92, 255), false)
	drawBorde(x*909, y*580, x*133/100*infos.Urinar, y*134, tocolor(131, 160, 93, 255), false)

	dxDrawImage(x*0, y*0, x*1920, y*1080, "font/necessidades.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	if messages.msg1 then
		dxDrawImage(x*1142, y*540, x*310, y*53, "font/"..messages.msg1[2]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(messages.msg1[1], x*1185, y*541, x*1447, y*583, tocolor(255, 255, 255, 255), 1.00, painel.Fonte01, "center", "center", false, true, false, false, false)
	end
	if messages.msg2 then
		dxDrawImage(x*1142, y*597, x*310, y*53, "font/"..messages.msg2[2]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(messages.msg2[1], x*1185, y*598, x*1447, y*640, tocolor(255, 255, 255, 255), 1.00, painel.Fonte01, "center", "center", false, true, false, false, false)
	end
	if messages.msg3 then
		dxDrawImage(x*1142, y*654, x*310, y*53, "font/"..messages.msg3[2]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(messages.msg3[1], x*1185, y*655, x*1447, y*697, tocolor(255, 255, 255, 255), 1.00, painel.Fonte01, "center", "center", false, true, false, false, false)
	end
	if messages.msg4 then
		dxDrawImage(x*1142, y*714, x*310, y*53, "font/"..messages.msg4[2]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(messages.msg4[1], x*1185, y*715, x*1447, y*757, tocolor(255, 255, 255, 255), 1.00, painel.Fonte01, "center", "center", false, true, false, false, false)
	end
end


--[[
         ><><><><><><><><><><><><><><><><><><><><
         ><      Configurações N Altere        ><
         ><><><><><><><><><><><><><><><><><><><><
--]]

function AbrirDash ()
	if painel.state == false then
		addEventHandler ( "onClientRender", root, DxPainel )
		painel.state = true
		--showCursor ( true )
		playSoundFrontEnd ( 43 )
	else
		removeEventHandler ( "onClientRender", root, DxPainel )
		painel.state = false
		--showCursor ( false )
		playSoundFrontEnd ( 43 )
		messages.qnt = 0
	end
end
bindKey("TAB", "both", AbrirDash)

function onPlayerSendInfobox(msg, tipo)
	if tipo ~= "sucesso" and tipo ~= "error" and tipo ~= "info" then
		tipo = "info"
	end
    if msg and tipo then
		triggerEvent("serverNotifys2", root, "Você tem uma nova notificação!!", "error")
		playSound("font/sound.mp3")
		if messages.msg1 then
			messages.msg4 = messages.msg3
			messages.msg3 = messages.msg2
			messages.msg2 = messages.msg1
			messages.msg1 = {msg, tipo}
		else
			messages.msg1 = {msg, tipo}
		end
		messages.qnt = messages.qnt+1
    end
end
addEvent("TS:info", true)
addEventHandler("TS:info", root, onPlayerSendInfobox)

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
