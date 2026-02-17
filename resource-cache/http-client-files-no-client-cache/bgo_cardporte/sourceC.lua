local s = {guiGetScreenSize()}
local kep = {408,248}
local panelP = {s[1]/2 - kep[1]/2,s[2]/2 - kep[2]/2}


local font2 = dxCreateFont("files/font2.otf",10)

local namep
local valid
local obs
porteap = false

function showCardP(type,nome, valid, typ, obs)
	if type == 3 then
		porteap = true
		validade = valid
		observacao = obs
		nomeporte = nome
		tipo = typ
		addEventHandler("onClientRender",getRootElement(),drawCard)
	end
end
addEvent("showCardP",true)
addEventHandler("showCardP",getRootElement(),showCardP)

function destroyCardP(type)
	if type == 3 then
		porteap = false
		valid = ""
		obs = ""
		nomeporte = ""
		tipo = ""
		removeEventHandler("onClientRender",getRootElement(),drawCard)
	end
end
addEvent("destroyCardP",true)
addEventHandler("destroyCardP",getRootElement(),destroyCardP)

function drawCard()
	if not porteap then return end
	dxDrawImage(panelP[1]+15,panelP[2]+35,kep[1],kep[2],"files/pa.png")
	
	
	dxDrawText("Nome: "..nomeporte.."\nValidade: "..validade.."\nTipo do porte: "..tipo.."\nObservação: "..observacao.."",panelP[1]+180,panelP[2]+136,0,0,tocolor(74, 74, 74,255),1,font2, 'left', 'top', false, false, false, true) 
	
	
	
	--[[
	dxDrawText("Nome: "..nomeporte,panelP[1]+135,panelP[2]+76,0,0,tocolor(0,0,0,255),1,"default-bold", 'left', 'top', false, false, false, true) -- N�v
	dxDrawText("Nome: #00AEFF"..nomeporte,panelP[1]+134,panelP[2]+75,0,0,tocolor(255,255,255,255),1,"default-bold", 'left', 'top', false, false, false, true) -- N�v
	
	dxDrawText("Validade: "..validade,panelP[1]+136,panelP[2]+96,0,0,tocolor(0,0,0,255),1,"default-bold", 'left', 'top', false, false, false, true) -- vali�m
	dxDrawText("Validade: #FFA700"..validade,panelP[1]+135,panelP[2]+95,0,0,tocolor(255,255,255,255),1,"default-bold", 'left', 'top', false, false, false, true) -- vali�m
	
	dxDrawText("Tipo do porte: "..tipo,panelP[1]+136,panelP[2]+116,0,0,tocolor(0,0,0,255),1,"default-bold", 'left', 'top', false, false, false, true) -- �rv�nyess�g
	dxDrawText("Tipo do porte: #bebebe"..tipo,panelP[1]+135,panelP[2]+115,0,0,tocolor(255,255,255,255),1,"default-bold", 'left', 'top', false, false, false, true) -- �rv�nyess�g
	
	dxDrawText("Observação: "..observacao,panelP[1]+136,panelP[2]+136,0,0,tocolor(0,0,0,255),1,"default-bold", 'left', 'top', false, false, false, true) -- �rv�nyess�g
	dxDrawText("Observação: #D24D57"..observacao,panelP[1]+135,panelP[2]+135,0,0,tocolor(255,255,255,255),1,"default-bold", 'left', 'top', false, false, false, true) -- �rv�nyess�g
	]]--
end



function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end