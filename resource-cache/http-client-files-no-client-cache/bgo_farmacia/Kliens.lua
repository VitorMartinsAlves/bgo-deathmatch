if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end

local screenW,screenH = guiGetScreenSize()
local screenSize = Vector2(guiGetScreenSize())
local painel = false
local webBrowser
addEventHandler("onClientResourceStart", resourceRoot, 
function()
	webBrowser = createBrowser(screenSize, true, true)
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
	loadBrowserURL(webBrowser, "http://mta/local/nui/ui.html")
	--focusBrowser(webBrowser)
	end
	)

end
)

function ComprarLoja(command, valor)
if valor == "" then
executeBrowserJavascript ( webBrowser, "erroquant()")
return 
end
if tonumber(valor) < 1 then 
executeBrowserJavascript ( webBrowser, "erroquant()")
return 
end

if tonumber(valor) > 10 then 
executeBrowserJavascript ( webBrowser, "erroquantvez()")
return 
end

	if isTimer(tempo) then return end
	tempo = setTimer(function() end,3000,1)
	if painel then
	if (command == "dipiroca") then
	triggerServerEvent("give:dipiroca",localPlayer, valor)
	end
	end
end
addEvent("ComprarRemedio", true)
addEventHandler("ComprarRemedio", root, ComprarLoja)




local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx2,sy2 = (screenW/resW), (screenH/resH)

function createLogin ()
if not getElementData (localPlayer, "loggedin") then return end
	dxDrawImage(0,0, screenW,screenH, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
end


addEventHandler("onClientClick", root,
    function(button, state)
        if state == "down" and painel then
            injectBrowserMouseDown(webBrowser, button)
        else
            injectBrowserMouseUp(webBrowser, button)
        end 
		cancelEvent()
    end
)


addEventHandler("onClientCursorMove", root,
    function (relativeX, relativeY, absoluteX, absoluteY)
	if painel then
        injectBrowserMouseMove(webBrowser, absoluteX, absoluteY)
		end
		cancelEvent()
	end
)



addEvent("loja:remedioON",true)
addEventHandler("loja:remedioON",localPlayer,
function()
if isTimer(tempo) then
killTimer(tempo)
end
 if not isEventHandlerAdded("onClientRender", root, createLogin) then
	addEventHandler("onClientRender",  root, createLogin) 
	end
	painel = true
	focusBrowser(webBrowser)
	executeBrowserJavascript ( webBrowser, "showmenu()")
end)


addEvent("loja:remedioOFF",true)
addEventHandler("loja:remedioOFF",localPlayer,
function()
	painel = false
	executeBrowserJavascript ( webBrowser, "hidemenu()")
	tempo = setTimer(function()
		removeEventHandler("onClientRender", root, createLogin)
		end,1000,1)
end)


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






