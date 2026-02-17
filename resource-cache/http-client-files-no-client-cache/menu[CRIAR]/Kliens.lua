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
	loadBrowserURL(webBrowser, "http://mta/local/ui/ui.html")
	focusBrowser(webBrowser)
	end
	)
	
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
	
	if getElementData(localPlayer, "acc:id") == 1 then
	dxDrawImage(0,0, screenW,screenH, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
	end
end


addEventHandler("onClientClick", root,
    function(button, state)
        if state == "down" and painel then
            injectBrowserMouseDown(webBrowser, button)
        else
            injectBrowserMouseUp(webBrowser, button)
        end 
    end
)


addEventHandler("onClientCursorMove", root,
    function (relativeX, relativeY, absoluteX, absoluteY)
	if painel then
        injectBrowserMouseMove(webBrowser, absoluteX, absoluteY)
    end
	end
)

function cmsg(command)
if painel then
	if (command == "fechar") then
	print("fechou")
	removeEventHandler("onClientRender", root, createLogin)
	painel = false
	elseif (command == "oi") then
	print("oi")
	elseif (command == "tudobem") then
	print("tudobem")
	elseif (command == "consegui") then
	print("consegui")
	end
	end
end
addEvent("cmsg", true)
addEventHandler("cmsg", root, cmsg)