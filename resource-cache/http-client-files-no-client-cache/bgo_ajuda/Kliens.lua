if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end


local screenWidth, screenHeight = guiGetScreenSize( )
local screenSize = Vector2(guiGetScreenSize())

local webBrowser

addEventHandler("onClientResourceStart", resourceRoot, 
function()
	webBrowser = createBrowser(screenSize, true, true)
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
	loadBrowserURL(webBrowser, "http://mta/local/ui/index.html")
	end
	)
end
)



	
local open = false
function showTheVIP ()
--if getElementData(localPlayer,"acc:id") == 1 then
if not open then
if not isEventHandlerAdded("onClientRender", root, createLogin) then
	focusBrowser(webBrowser)
	
	showCursor(true)
	
	
		executeBrowserJavascript ( webBrowser, "showmenu()")
		
	open = true
	addEventHandler("onClientRender",  root, createLogin)
	addEventHandler("onClientClick", root,botoes)
	addEventHandler("onClientKey", root, onKey)
	addEventHandler("onClientCursorMove", root, cursor)
end 
else
if isEventHandlerAdded("onClientRender", root, createLogin) then

	showCursor(false)
	
	executeBrowserJavascript ( webBrowser, "hidemenu()")
	
	open = false
	
	reloadBrowserPage(webBrowser)
removeEventHandler("onClientRender", root, createLogin)
removeEventHandler("onClientClick", root,botoes)
removeEventHandler("onClientKey", root, onKey)
removeEventHandler("onClientCursorMove", root, cursor)
end
end
end
--end
bindKey ("F9", "up", showTheVIP)




function botoes(button, state)
        if state == "down" and open and isCursorShowing() and isEventHandlerAdded("onClientRender", root, createLogin) then
            injectBrowserMouseDown(webBrowser, button)
        else
            injectBrowserMouseUp(webBrowser, button)
    end 
end



function onKey(button)
if open and isCursorShowing() and isEventHandlerAdded("onClientRender", root, createLogin) then
	if button == "mouse_wheel_down" then
		injectBrowserMouseWheel(webBrowser, -40, 0)
	elseif button == "mouse_wheel_up" then
		injectBrowserMouseWheel(webBrowser, 40, 0)
	end
	end
end





    function cursor(relativeX, relativeY, absoluteX, absoluteY)
	
	if open and isCursorShowing() and isEventHandlerAdded("onClientRender", root, createLogin) then
        injectBrowserMouseMove(webBrowser, absoluteX, absoluteY)
	end
	cancelEvent()
	end




function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if 
        type( sEventName ) == 'string' and 
        isElement( pElementAttachedTo ) and 
        type( func ) == 'function' 
    then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end

    return false
end





local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx2,sy2 = (screenW/resW), (screenH/resH)

function createLogin ()
if not getElementData (localPlayer, "loggedin") then return end
	--dxDrawImage(sx2*1-2,sy2*1-2, sx2*1390,sy2*800, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
	dxDrawImage(0,0, sx2*1350,sy2*800, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
end




