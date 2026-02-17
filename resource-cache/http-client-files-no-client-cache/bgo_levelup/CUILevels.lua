local DGS = exports.DGS

local UI_elements = {}
local screen_size_x, screen_size_y = guiGetScreenSize()

local fonts

	

local function CreateFonts()
	fonts = {
		bold_28 = dxCreateFont( "fonts/OpenSans-Bold.ttf", 28, false, "default" ); --"default"; --exports.nrp_fonts:DXFont("OpenSans/OpenSans-Bold.ttf", 28, false, "default");
		regular_13 = dxCreateFont("fonts/OpenSans-Regular.ttf", 13, false, "default" ); --"default"; --exports.nrp_fonts:DXFont("OpenSans/OpenSans-Regular.ttf", 13, false, "default");
	}
end

function ShowUILevelUp(new_level)
	if isElement(UI_elements.bg_img) then return end

	CreateFonts()

	showCursor(true)

	selected_city = 0

	UI_elements.bg_img					= DGS:dgsCreateImage(	0, 0, screen_size_x, screen_size_y,
																nil, false, nil, 0xF2344554)
	DGS:dgsSetAlpha(UI_elements.bg_img, 0)
	DGS:dgsAlphaTo(UI_elements.bg_img, 1, false, "Linear", 250)

	UI_elements.info_texture			= dxCreateTexture("images/info.png")
	UI_elements.info_img				= DGS:dgsCreateImage(	(screen_size_x - 302) / 2, (screen_size_y - 218) / 2, 302, 218,
																UI_elements.info_texture, false, UI_elements.bg_img)

	UI_elements.label_city				= DGS:dgsCreateLabel(	130, 60, 0, 0,
																new_level, false, UI_elements.info_img)
	DGS:dgsSetProperty(UI_elements.label_city, "textcolor", 0xFFFFFFFF)
	DGS:dgsSetProperty(UI_elements.label_city, "rightbottom", {"center","center"})
	DGS:dgsSetFont(UI_elements.label_city, fonts.bold_28)


	UI_elements.button_okey_idle_tex = dxCreateTexture("images/button_okey_idle.png")
	UI_elements.button_okey_hover_tex = dxCreateTexture("images/button_okey_hover.png")
	UI_elements.button_okey_click_tex = dxCreateTexture("images/button_okey_click.png")
	UI_elements.button_okey = DGS:dgsCreateButton(	(screen_size_x - 174) / 2, (screen_size_y + 268) / 2, 174, 56,
													"", false, UI_elements.bg_img, 0xFFFFFFFF, 1, 1,
													UI_elements.button_okey_idle_tex, UI_elements.button_okey_hover_tex, UI_elements.button_okey_click_tex,
													0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF)

	addEventHandler("onDgsMouseClick", UI_elements.button_okey, function(button, state)
		if button ~= "left" or state ~= "up" then return end

		DGS:dgsAlphaTo(UI_elements.bg_img, 0, false, "Linear", 250)
		setTimer(DestroyUI, 250, 1)

		--if new_level == 4 or new_level == 6 then
		--	Timer(function() triggerEvent( "ShowPremiumOffer", localPlayer, true ) end, 1000, 1)
		--end

		--if new_level == 3 then
		--	Timer(function() triggerEvent( "RPRShowNotification", localPlayer ) end, 1000, 1)
		--end

	end)

	playSound("sounds/levelup.wav")
end
addEvent("PlayerLevelUp", true)
addEventHandler("PlayerLevelUp", root, function( new_level )
	setTimer(ShowUILevelUp, 3500, 1, new_level)
end)

function DestroyUI()
	if isElement(UI_elements.bg_img) then destroyElement(UI_elements.bg_img) end
	
	for _, element in pairs(UI_elements) do
		if isElement(element) then destroyElement(element) end
	end

	UI_elements = {}

	showCursor(false)
end