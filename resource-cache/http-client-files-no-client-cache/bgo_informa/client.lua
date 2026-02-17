if fileExists("Kliens.lua") then
	fileDelete("Kliens.lua")
end



local screenSize = Vector2(guiGetScreenSize())

local webBrowser
addEventHandler("onClientResourceStart", resourceRoot, 
function()

	webBrowser = createBrowser(screenSize, true, true)

	
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
	loadBrowserURL(webBrowser, "http://mta/local/ui/nui.html")
	end
	)
	focusBrowser(webBrowser)
	painel = true
	removeEventHandler("onClientRender", root, createLogin)
	addEventHandler("onClientRender",  root, createLogin) 

	


	
end
)



local screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx2,sy2 = (screenW/resW), (screenH/resH)

function createLogin ()
if not getElementData (localPlayer, "loggedin") then return end
	--dxDrawImage(sx2*1-2,sy2*1-2, sx2*1390,sy2*800, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
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





function mensagem(titulo, text, clase)
	if clase == "info" then
	execute(string.format("info('%s', '%s')", tostring(titulo), tostring(text)))
	elseif clase == "sucesso" then
	execute(string.format("success('%s', '%s')", tostring(titulo), tostring(text)))
	elseif clase == "aviso" then
	execute(string.format("warning('%s', '%s')", tostring(titulo), tostring(text)))
	elseif clase == "erro" then
	execute(string.format("error('%s', '%s')", tostring(titulo), tostring(text)))
	end
end
addEvent ("bgo>info",true)
addEventHandler ("bgo>info",getRootElement(),mensagem)


function execute(eval)
  executeBrowserJavascript(webBrowser, eval)
end


