--[[
						                                     
						`7MM"""Yp,    .g8"""bgd     .g8""8q.   
						  MM    Yb  .dP'     `M   .dP'    `YM. 
						  MM    dP  dM'       `   dM'      `MM 
						  MM"""bg.  MM            MM        MM 
						  MM    `Y  MM.    `7MMF 'MM.      ,MP 
						  MM    ,9  `Mb.     MM   `Mb.    ,dP' 
						.JMMmmmd9     `"bmmmdPY     `"bmmd"'  
						B R A S I L  G A M I N G  O N L I N E  

]]



loadstring(exports.dgs:dgsImportFunction())()
screenW,screenH = guiGetScreenSize()
resW, resH = 1366,768
sx,sy = (screenW/resW), (screenH/resH)
panel = false
dgsElement = {}
section = 'home'
transRecentes = {}

local zone1 = createColCuboid(1467.84705, -1003.55267, 23.70787, 25.068603515625, 8.2955932617188, 5.9999946594238)
local zone2 = createColCuboid(2403.06445, 1114.15454, 9.84090, 8.768310546875, 19.332275390625, 3.2999977111816)

addEvent('UPDATE:TRANS', true)
addEventHandler('UPDATE:TRANS', root, function(arg1, arg2, arg3)
	table.insert(transRecentes, 
	{
		['TransType'] = arg1,
		['text'] = arg2,
		['data'] = arg3,
	}
)
end)

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

dgsElement[1] = dgsCreateWindow(sx*381, sy*137, sx*600, sy*500,"",false, false, 60, ':bgo_bank/assets/logo.png', tocolor(255, 255, 255, 255), false, tocolor(41, 40, 46, 255))
dgsElement[2] = dgsCreateTabPanel ( sx*268, sy*103, sx*323, sy*317, false, dgsElement[1]) 
dgsCreateTab( " ULTIMAS TRANSAÇÕES ", dgsElement[2], sx*1, sx*1, tocolor(192, 192, 192, 255)) 
dgsSetProperty(dgsElement[1], "sizable", false)

dgsElement[3] = dgsCreateGridList (sx*7, sy*27, sx*312, sy*284, false, dgsElement[2])
transType = dgsGridListAddColumn( dgsElement[3], "TIPO", 0.05)
transIndex = dgsGridListAddColumn( dgsElement[3], "TRANSAÇÃO", 1.00, nil, 'center')
transData = dgsGridListAddColumn( dgsElement[3], "DATA", 0.30)
dgsSetProperty(dgsElement[3],"rowHeight",30)
dgsSetFont(dgsElement[2], 'default-bold')
function  refresh ()
	dgsGridListClearRow(dgsElement[3]) 
	for i, v in ipairs(transRecentes) do
		local row = dgsGridListAddRow ( dgsElement[3] )
		if v['TransType'] ~= 'transfer' then
			local w, h = 25, 25
			dgsGridListSetItemImage ( dgsElement[3], row, 1, dxCreateTexture('assets/type/'..v['TransType']..'.png'),tocolor(255,255,255,255),0,0,w,h,false)
		else
			local w, h = 25, 19.57
			dgsGridListSetItemImage ( dgsElement[3], row, 1, dxCreateTexture('assets/type/'..v['TransType']..'.png'),tocolor(255,255,255,255),0,6,w,h,false)
		end
		dgsGridListSetItemText ( dgsElement[3], row, transIndex, v['text'], false, false )
		dgsGridListSetItemText ( dgsElement[3], row, transData, v['data'], false, false )
	end
end 
dgsSetVisible(dgsElement[1], false)

function home(mode)
	if mode == 'normal' then
		dgsElement[4] = dgsCreateImage(sx*22, sy*15, sx*428, sy*100, 'assets/account.png', false, dgsElement[1])
		dgsElement[5] = dgsCreateLabel(sx*156,sy*37,sx*383,sy*35,localPlayer:getData('acc:name'),false,dgsElement[1], false, sx*2, sy*2)
		dgsElement[6] = dgsCreateLabel(sx*156,sy*65,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:money'))..',00',false,dgsElement[1], false, sx*1, sy*1)
		dgsElement[7] = dgsCreateLabel(sx*156,sy*80,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:bankmoney'))..',00',false,dgsElement[1], false, sx*1, sy*1)
		dgsElement[8] = dgsCreateButton(sx*33, sy*152, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/deposit/deposit_button.png', ':bgo_bank/assets/deposit/deposit_button_on.png', ':bgo_bank/assets/deposit/deposit_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
		dgsElement[9] = dgsCreateButton(sx*33, sy*233, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/transfer/transfer_button.png', ':bgo_bank/assets/transfer/transfer_button_on.png', ':bgo_bank/assets/transfer/transfer_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
		dgsElement[10] = dgsCreateButton(sx*33, sy*314, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/withdraw/withdraw_button.png', ':bgo_bank/assets/withdraw/withdraw_button_on.png', ':bgo_bank/assets/withdraw/withdraw_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))

	else
		dgsElement[4] = dgsCreateImage(sx*22, sy*15, sx*428, sy*100, 'assets/account.png', false, dgsElement[1])
		dgsElement[5] = dgsCreateLabel(sx*156,sy*37,sx*383,sy*35,localPlayer:getData('acc:name'),false,dgsElement[1], false, sx*2, sy*2)
		dgsElement[6] = dgsCreateLabel(sx*156,sy*65,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:money'))..',00',false,dgsElement[1], false, sx*1, sy*1)
		dgsElement[7] = dgsCreateLabel(sx*156,sy*80,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:bankmoney'))..',00',false,dgsElement[1], false, sx*1, sy*1)
		dgsElement[10] = dgsCreateButton(sx*33, sy*152, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/withdraw/withdraw_button.png', ':bgo_bank/assets/withdraw/withdraw_button_on.png', ':bgo_bank/assets/withdraw/withdraw_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))		
	end
end

function CreateDeposit()
	dgsElement[4] = dgsCreateImage(sx*22, sy*15, sx*428, sy*100, 'assets/account.png', false, dgsElement[1])
	dgsElement[5] = dgsCreateLabel(sx*156,sy*37,sx*383,sy*35,localPlayer:getData('acc:name'),false,dgsElement[1], false, sx*2, sy*2)
	dgsElement[6] = dgsCreateLabel(sx*156,sy*65,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:money'))..',00',false,dgsElement[1], false, sx*1, sy*1)
	dgsElement[7] = dgsCreateLabel(sx*156,sy*80,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:bankmoney'))..',00',false,dgsElement[1], false, sx*1, sy*1)
	dgsElement[8] = dgsCreateEdit(sx*33, sy*152, sx*216, sy*65, "VALOR", false, dgsElement[1], tocolor(90, 90, 90, 255), sx*1.5, sx*1.5, false, tocolor(200, 200, 200, 255), true)
	dgsElement[9] = dgsCreateButton(sx*33, sy*233, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/deposit/deposit_button.png', ':bgo_bank/assets/deposit/deposit_button_on.png', ':bgo_bank/assets/deposit/deposit_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
	dgsElement[10] = dgsCreateButton(sx*33, sy*314, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/back/back_button.png', ':bgo_bank/assets/back/back_button_on.png', ':bgo_bank/assets/back/back_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
	dgsSetFont(dgsElement[8], 'default-bold')
	dgsEditSetHorizontalAlign( dgsElement[8], "center" )
end

function CreateTransfer()
	dgsElement[4] = dgsCreateImage(sx*22, sy*15, sx*428, sy*100, 'assets/account.png', false, dgsElement[1])
	dgsElement[5] = dgsCreateLabel(sx*156,sy*37,sx*383,sy*35,localPlayer:getData('acc:name'),false,dgsElement[1], false, sx*2, sy*2)
	dgsElement[6] = dgsCreateLabel(sx*156,sy*65,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:money'))..',00',false,dgsElement[1], false, sx*1, sy*1)
	dgsElement[7] = dgsCreateLabel(sx*156,sy*80,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:bankmoney'))..',00',false,dgsElement[1], false, sx*1, sy*1)
	dgsElement[8] = dgsCreateEdit(sx*33, sy*152, sx*216, sy*65, "ID DA PESSOA", false, dgsElement[1], tocolor(90, 90, 90, 255), sx*1.5, sx*1.5, false, tocolor(200, 200, 200, 255), true)
	dgsElement[9] = dgsCreateEdit(sx*33, sy*233, sx*216, sy*65, "VALOR", false, dgsElement[1], tocolor(90, 90, 90, 255), sx*1.5, sx*1.5, false, tocolor(200, 200, 200, 255), true)
	dgsElement[10] = dgsCreateButton(sx*33, sy*314, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/transfer/transfer_button.png', ':bgo_bank/assets/transfer/transfer_button_on.png', ':bgo_bank/assets/transfer/transfer_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
	dgsElement[11] = dgsCreateButton(sx*40, sy*380, sx*201, sy*50, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/back/back_button.png', ':bgo_bank/assets/back/back_button_on.png', ':bgo_bank/assets/back/back_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
	dgsSetFont(dgsElement[8], 'default-bold')
	dgsEditSetHorizontalAlign( dgsElement[8], "center" )
	dgsSetFont(dgsElement[9], 'default-bold')
	dgsEditSetHorizontalAlign( dgsElement[9], "center" )
end

function CreateWithdraw()
	dgsElement[4] = dgsCreateImage(sx*22, sy*15, sx*428, sy*100, 'assets/account.png', false, dgsElement[1])
	dgsElement[5] = dgsCreateLabel(sx*156,sy*37,sx*383,sy*35,localPlayer:getData('acc:name'),false,dgsElement[1], false, sx*2, sy*2)
	dgsElement[6] = dgsCreateLabel(sx*156,sy*65,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:money'))..',00',false,dgsElement[1], false, sx*1, sy*1)
	dgsElement[7] = dgsCreateLabel(sx*156,sy*80,sx*383,sy*35,'$'..convertNumber(localPlayer:getData('char:bankmoney'))..',00',false,dgsElement[1], false, sx*1, sy*1)
	dgsElement[8] = dgsCreateEdit(sx*33, sy*152, sx*216, sy*65, "VALOR", false, dgsElement[1], tocolor(90, 90, 90, 255), sx*1.5, sx*1.5, false, tocolor(200, 200, 200, 255), true)
	dgsElement[9] = dgsCreateButton(sx*33, sy*233, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/withdraw/withdraw_button.png', ':bgo_bank/assets/withdraw/withdraw_button_on.png', ':bgo_bank/assets/withdraw/withdraw_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
	dgsElement[10] = dgsCreateButton(sx*33, sy*314, sx*216, sy*65, " ", false, dgsElement[1], false, sx*1, sx*1, ':bgo_bank/assets/back/back_button.png', ':bgo_bank/assets/back/back_button_on.png', ':bgo_bank/assets/back/back_button_clicked.png', tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255), tocolor(255, 255, 255, 255))
	dgsSetFont(dgsElement[8], 'default-bold')
	dgsEditSetHorizontalAlign( dgsElement[8], "center" )
end

function changeSection(action, aba)
	if action == 'close' then
		if aba == 'home' then
			for i=1,#dgsElement do
				if i ~= 1 and i ~=2 and i ~= 3 then
					if isElement(dgsElement[i]) then
						destroyElement(dgsElement[i])
					end
				end
				section = 'home'
				showCursor(false)
				dgsSetVisible(dgsElement[1], false)
				panel = false
			end
		end
	elseif action == 'changeSection' then
		if aba == 'deposit' then
			for i=1,#dgsElement do
				if i ~= 1 and i ~=2 and i ~= 3 then
					if isElement(dgsElement[i]) then
						destroyElement(dgsElement[i])
					end
				end
			end
			CreateDeposit()
			section = 'deposit'
		elseif aba == 'transfer' then
			for i=1,#dgsElement do
				if i ~= 1 and i ~=2 and i ~= 3 then
					if isElement(dgsElement[i]) then
						destroyElement(dgsElement[i])
					end
				end
			end
			CreateTransfer()
			section = 'transfer'
		elseif aba == 'withdraw' then
			for i=1,#dgsElement do
				if i ~= 1 and i ~=2 and i ~= 3 then
					if isElement(dgsElement[i]) then
						destroyElement(dgsElement[i])
					end
				end
			end
			CreateWithdraw()
			section = 'withdraw'
		elseif aba == 'home' then
			for i=1,#dgsElement do
				if i ~= 1 and i ~=2 and i ~= 3 then
					if isElement(dgsElement[i]) then
						destroyElement(dgsElement[i])
					end
				end
			end
			section = 'home'
			if isElementWithinColShape(localPlayer, zone1) or isElementWithinColShape(localPlayer, zone2) then
				home('normal')
			else
				home('atm')
			end
		end

	end
end

addEventHandler("onDgsWindowClose", dgsElement[1], function()
	changeSection('close', 'home')
	cancelEvent()
end)

addEventHandler ( "onDgsMouseClick", getRootElement( ), function(b, s)
	if b == 'left' and s == 'down' then
		if section == 'home' then
			if source == dgsElement[8] then
				changeSection('changeSection', 'deposit')
			elseif source == dgsElement[9] then
				changeSection('changeSection', 'transfer')
			elseif source == dgsElement[10] then
				changeSection('changeSection', 'withdraw')
			end
		elseif section == 'deposit' then
			if source == dgsElement[8] then
				dgsEditSetWhiteList(dgsElement[8] ,"[^0-9$]")
				dgsEditClearText(dgsElement[8])
				dgsEditSetMaxLength(dgsElement[8], 6)
			elseif source == dgsElement[9] then
				if tonumber(dgsGetText(dgsElement[8])) and tonumber(dgsGetText(dgsElement[8])) >= 10 then
					depositar(tonumber(dgsGetText(dgsElement[8])))
				else
					exports.bgo_informa:mensagem("Valor inválido!", 'Digite um valor acima de R$10,00', "erro")
				end
			elseif source == dgsElement[10] then
				changeSection('changeSection', 'home')
			end
		elseif section == 'withdraw' then
			if source == dgsElement[8] then
				dgsEditSetWhiteList(dgsElement[8] ,"[^0-9$]")
				dgsEditClearText(dgsElement[8])
				dgsEditSetMaxLength(dgsElement[8], 6)
			elseif source == dgsElement[9] then
				if tonumber(dgsGetText(dgsElement[8])) and tonumber(dgsGetText(dgsElement[8])) >= 10 then
					sacar(tonumber(dgsGetText(dgsElement[8])))
				else
					exports.bgo_informa:mensagem("Valor inválido!", 'Digite um valor acima de R$10,00', "erro")
				end
			elseif source == dgsElement[10] then
				changeSection('changeSection', 'home')
			end
		elseif section == 'transfer' then
			if source == dgsElement[9] then
				dgsEditSetWhiteList(dgsElement[9] ,"[^0-9$]")
				dgsEditClearText(dgsElement[9])
				dgsEditSetMaxLength(dgsElement[9], 6)
			elseif source == dgsElement[8] then
				dgsEditSetWhiteList(dgsElement[8] ,"[^0-9$]")
				dgsEditClearText(dgsElement[8])
				dgsEditSetMaxLength(dgsElement[8], 10)
			elseif source == dgsElement[10] then
				if tonumber(dgsGetText(dgsElement[8])) and tonumber(dgsGetText(dgsElement[8])) >= 1 then
					if tonumber(dgsGetText(dgsElement[8])) ~= tonumber(localPlayer:getData('acc:id')) then
						if tonumber(dgsGetText(dgsElement[9])) and tonumber(dgsGetText(dgsElement[9])) >= 10 then
							transferir(tonumber(dgsGetText(dgsElement[8])), tonumber(dgsGetText(dgsElement[9])))
						else
							exports.bgo_informa:mensagem("Valor inválido!", 'Digite um valor acima de R$10,00', "erro")
						end
					else
						exports.bgo_informa:mensagem("OPS!", 'Você não pode transferir dinheiro para você mesmo !', "erro")
					end
				else
					exports.bgo_informa:mensagem("OPS!", 'Digite o id da pessoa!', "erro")
				end
			elseif source == dgsElement[11] then
				changeSection('changeSection', 'home')
			end
		end
	end
end)

function depositar(value)
	changeSection('close', 'home')
	triggerServerEvent('BGO:DEPOSIT',localPlayer, localPlayer, value)
end

function sacar(value)
	changeSection('close', 'home')
	triggerServerEvent('BGO:WITHDRAW',localPlayer, localPlayer, value)
end

function transferir(id, value)
	changeSection('close', 'home')
	triggerServerEvent('BGO:TRANSFER',localPlayer, localPlayer, id, value)
end

addEventHandler('onClientClick', root, function(b, s, _, _, _, _, _, clickedElement)
	if s == 'down' then
		if clickedElement then
			local x, y, z = getElementPosition(localPlayer)
			local ex, ey, ez = getElementPosition(clickedElement)
			if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 2 then
			if clickedElement:getData('bankThing') then
			
			setElementData(localPlayer, "Click:atm", clickedElement)
			
			
				if not panel then
					if isElementWithinColShape(localPlayer, zone1) or isElementWithinColShape(localPlayer, zone2) then
						home('normal')
						refresh()
						showCursor(true)
						panel = true
						dgsSetVisible(dgsElement[1], true)
					else
						home('atm')
						refresh()
						panel = true
						showCursor(true)
						dgsSetVisible(dgsElement[1], true)
						end
					end
				end
			end
		end
	end
end)


addEventHandler('onClientRender', root, function()
	local x,y,z = getElementPosition(localPlayer)
    local tabela = getElementsWithinRange( x, y, z, 2.5, "object" )
    if localPlayer:getData('showatm') then
	    for i,v in ipairs(tabela) do
	    	if getElementModel(v) == 2942 then
	    		dxDrawTextOnElement(v, 'ID: '..v:getData('bankID'), 1.5, 20, 255, 255, 255, 255, 1.5, 'arial')
	    	end
	    end
	end
end)

addEventHandler("onClientObjectDamage", root, function()
	if getElementModel(source) == 2942 then
		cancelEvent()
	end
end)

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+5, sy+5, sx, sy, tocolor(0, 0, 0, 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end


local hit = 0



addEventHandler("onClientRender", root, function()
	for k,v in ipairs(getElementsByType("object", getResourceRootElement(getThisResource()), true)) do
		if isElement(v) and tonumber(getElementData(v, 'bankID') or 0) > 0 then 
			local x, y ,z = getElementPosition(v)
			local wx, wy, wz = getScreenFromWorldPosition(x , y, z)
			if wx and wy then
				local playerx, playery, playerz = getElementPosition(getLocalPlayer())
				if getDistanceBetweenPoints3D(playerx, playery, playerz, x, y ,z) <= 6 then
					local stone_HP = (getElementData(v, 'atm >> Health') or 0)
					local mensagem = getElementData(v, 'atm >> mensagem')
					local quant = getElementData(v, 'atm >> quantidade')
					
					if quant > 1 and stone_HP > 0 then
					--[[
						if not getElementData(v, 'Dono >> stone') == false then
						dxDrawRectangle(wx-200/2,wy,200,30,tocolor(0,0,0,170))
						dxDrawRectangle(wx-200/2+2,wy+2, (stone_HP/1000)*(200 - 4) ,26,tocolor(124, 197, 118, 190))
						dxDrawText(math.floor(stone_HP/10) .. '% - Já tem um dono!',  wx-200/2 + 200/2+1, wy+30/2, wx-200/2 + 200/2+1, wy+30/2, tocolor(0, 0, 0,255),1, font, "center","center",false,false,false,true,false)
						dxDrawText(math.floor(stone_HP/10) .. '% - Já tem um dono!', wx-200/2 + 200/2, wy+30/2, wx-200/2 + 200/2, wy+30/2, tocolor(255, 255, 255,255),1, font, "center","center",false,false,false,true,false)

						else
						]]--
						dxDrawRectangle(wx-200/2,wy,200,30,tocolor(0,0,0,170))
						dxDrawRectangle(wx-200/2+2,wy+2, (stone_HP/1000)*(200 - 4) ,26,tocolor(124, 197, 118, 190))
						dxDrawText('R$:'..format(math.floor(quant)) .. '',  wx-200/2 + 200/2+1, wy+30/2, wx-200/2 + 200/2+1, wy+30/2, tocolor(0, 0, 0,255),1, "default", "center","center",false,false,false,true,false)
						dxDrawText('R$:'..format(math.floor(quant)) .. '', wx-200/2 + 200/2, wy+30/2, wx-200/2 + 200/2, wy+30/2, tocolor(255, 255, 255,255),1, "default", "center","center",false,false,false,true,false)
						--dxDrawText(math.floor(stone_HP/10) .. '%',  wx-200/2 + 200/2+1, wy+30/2, wx-200/2 + 200/2+1, wy+30/2, tocolor(0, 0, 0,255),1, "default", "center","center",false,false,false,true,false)
						--dxDrawText(math.floor(stone_HP/10) .. '%', wx-200/2 + 200/2, wy+30/2, wx-200/2 + 200/2, wy+30/2, tocolor(255, 255, 255,255),1, "default", "center","center",false,false,false,true,false)
						--end
			else
					
						dxDrawRectangle(wx-200/2,wy,200,30,tocolor(0,0,0,170))
						dxDrawText('Este caixa está sem dinheiro!',  wx-200/2 + 200/2+1, wy+30/2, wx-200/2 + 200/2+1, wy+30/2, tocolor(0, 0, 0,255),1, "default", "center","center",false,false,false,true,false)
						dxDrawText('Este caixa está sem dinheiro!', wx-200/2 + 200/2, wy+30/2, wx-200/2 + 200/2, wy+30/2, tocolor(255, 255, 255,255),1, "default", "center","center",false,false,false,true,false)
					end
				end
			end
		end
	end
end)


 
function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end 




local originalGetPlayerCount = getPlayerCount

function getPlayerCount()
    return originalGetPlayerCount and originalGetPlayerCount() or #getElementsByType("player")
end



function outputLoss(loss)
if getElementModel(source) == 2943 then
cancelEvent()
end
end
--addEventHandler("onClientObjectDamage", root, outputLoss)