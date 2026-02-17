local scx,scy = guiGetScreenSize()
local sizeX, sizeY = 700, 466
local posX, posY = (scx-sizeX)/2, (scy-sizeY)/2

local ui = {}
local tex = {}

local function CreateFonts()
	fonts = {
		OpenSans20  = "default" --exports.nrp_fonts:DXFont( "OpenSans/OpenSans-Regular.ttf", 20, true );
	}
end

local DGS = exports.dgs
function ShowUI( state, img )
	if state then
		ShowUI(false)

		

		CreateFonts()
		local teste = dxCreateTexture("img/"..img..".png")
		local texlist = {"bg","close"}
		for k,v in pairs(texlist) do
			tex[v] = dxCreateTexture("img/"..v..".png")
		end

		
		showCursor(true)

		ui.black_bg = DGS:dgsCreateImage( 0, 0, scx, scy, nil, false, nil, 0x80495f76 )
		ui.main = DGS:dgsCreateImage( posX, posY-50, sizeX, sizeY, teste, false, ui.black_bg)
		--ui.memo = DGS:dgsCreateLabel(0.02,0.04,0.94,0.2,[[
		--Você viu esta mensagem?
		--]],true,ui.main)
		--DGS:dgsSetFont ( ui.memo, "clear" )
		ui.close = DGS:dgsCreateButton( posX+sizeX-25, posY-80, 25, 25, "", false, ui.black_bg, 0xFFFFFFFF, 1, 1, tex.close, tex.close, tex.close, 0xFFFFFFFF, 0xFFCCCCCC, 0xFF808080 )
		--ui.accept = DGS:dgsCreateButton( sizeX / 2 - 170 / 2, 180, 170, 54, "", false, ui.main, 0xFFFFFFFF, 1, 1, tex.btn, tex.btn, tex.btn, 0xFFDDDDDD, 0xFFFFFFFF, 0xFFFFFFFF )
		--ui.edit = DGS:dgsCreateEdit( 50, 90, 310, 55, "", false, ui.main, 0xBBFFFFFF, 1, 1, tex.edit, 0xFFFFFFFF )
		--DGS:dgsSetProperty(ui.edit,"showPos",10) DGS:dgsSetFont(ui.edit, fonts.OpenSans20)
		exports.dgs:dgsSetVisible (ui.black_bg, true)

		
		for k,v in pairs(ui) do
		DGS:dgsSetAlpha(v,0)
		DGS:dgsAlphaTo(v,200,false,"OutQuad",600)
		end

		
		
		
		
		DGS:dgsMoveTo(ui.main,posX, posY,false,false,"OutQuad",600)
		DGS:dgsMoveTo(ui.close,posX+sizeX-25, posY-30,false,false,"OutQuad",600)

		addEventHandler("onDgsWindowClose",ui.close,windowClosed)
		
		addEventHandler( "onDgsMouseClick", ui.close, function( button, state )
			if button ~= "left" or state ~= "down" then return end
					setTimer(function()
					exports.dgs:dgsSetVisible (ui.black_bg, false)
					ShowUI(false)
					end,1000,1)
		for k,v in pairs(ui) do
		DGS:dgsSetAlpha(v,200)
		DGS:dgsAlphaTo(v,0,false,"OutQuad",600)
		end
		DGS:dgsMoveTo(ui.main,posX, posY-50,false,false,"OutQuad",600)
		DGS:dgsMoveTo(ui.close,posX+sizeX-25, posY-80,false,false,"OutQuad",600)
		
		end)
		--[[
		addEventHandler( "onDgsMouseClick", ui.accept, function( button, state )
			if button ~= "left" or state ~= "down" then return end
			--local sCode = DGS:dgsGetText(ui.edit)
			--triggerServerEvent("OnPlayerTryActivateCode", localPlayer, sCode)
		end)]]--

	else		
		
		

		for k,v in pairs(ui) do
			if isElement(v) then 
			windowClosed()
			destroyElement( v ) 
			end
		end
		for k,v in pairs(tex) do
			if isElement(v) then 
			destroyElement( v ) 
			end
		end

		tex = {}
		ui = {}
		showCursor(false)
	end
end
--addCommandHandler("teste", ShowUI)
addEvent("ShowNovidade", true)
addEventHandler("ShowNovidade", root, ShowUI)



function windowClosed()
	cancelEvent()
		 exports.dgs:dgsSetVisible (ui.black_bg, false)
end