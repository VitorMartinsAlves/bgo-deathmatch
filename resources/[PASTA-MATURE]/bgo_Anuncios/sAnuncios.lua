timerOlx = {}

function sendMessage (message)
	sendOptions = {
          queueName = "dcq",
          connectionAttempts = 3,
          connectTimeout = 500,
          formFields = {
               content="__**"..message.."**__"
          },
     }
	fetchRemote ('https://discord.com/api/webhooks/819474524063268864/2Os38SoApcD7qlF22AYGv4zEF4CVJdyz4mkO2skOynKUL5NvAfvhMw4kUy1WNeJj-l2M', sendOptions, callback )
end

function callback()
end


function Olx (thePlayer, commandName, ...)
     if not getElementData(thePlayer, "loggedin") then return end
	 
	 if isPlayerMuted(thePlayer) then outputChatBox("VOCÊ ESTÁ MUTADO DO CHAT!", thePlayer,255,255,255, true) return end
     local text = { ... }
     local olxMessage = table.concat( text, " " )
     local id = getElementData(thePlayer, "acc:id")
         if not olxMessage then
		     outputChatBox(" ", thePlayer,255,255,255, true)
			 outputChatBox(" ", thePlayer,255,255,255, true)
			 outputChatBox(" ", thePlayer,255,255,255, true)
             outputChatBox("#A102FC[BGO COMANDOS]: #FFFFFFPara usar o sistema OLX Utilize", thePlayer,255,255,255, true)
             outputChatBox("#A102FC[BGO SYNTAX]: #FFFFFF/olx [seu produto valor]", thePlayer,255,255,255, true)
			 outputChatBox("#A102FC[BGO EXEMPLO]: #FFFFFF/olx Gol G5 Semi Novo 20K", thePlayer,255,255,255, true)
		     else
			     if not ... then
			     outputChatBox("#A102FC[BGO INFORMA]: #FFFFFFInforme o produto", thePlayer,255,255,255, true)
				 else
				   if exports.bgo_items:hasItemS(thePlayer, 16) then 
				   
			if ( isPedDead ( thePlayer ) ) then 
			  outputChatBox ('#bebebe[BGO INFORMA]: #FFFFFFMORTO NÃO FALA!!',thePlayer,255,255,255,true)
			  return 
			  end
			  
			         if isTimer(timerOlx[thePlayer]) then outputChatBox ('#A102FC[BGO ERROR]: #FFFFFFAguarde #A102FC1 #FFFFFFminuto para anunciar algo na OLX!',thePlayer,255,255,255,true) return end
			         local Money = 15
			         local money2 = getElementData(thePlayer, "char:money")
			         if money2 >= Money then
				         setElementData(thePlayer, "char:money", money2 - Money)
				         outputChatBox("#A102FC✔ OLX ✘ #FFFFFF"..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "").."#A102FC("..id.."): #FFFFFFAnunciou: #A102FC"..olxMessage:gsub("#%x%x%x%x%x%x", "").."", root, 255,255,255, true)
						 sendMessage ('[OLX] '..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")..' [ID: '..id..'] '..olxMessage:gsub("#%x%x%x%x%x%x", ""))
				         outputChatBox("#A102FC[BGO INFORMA]: #FFFFFF❝ Foi cobrado "..Money.." para enviar a mensagem no chat", thePlayer, 255,255,255, true)	
				         outputServerLog ( "OLX "..getPlayerName(thePlayer).." Anunciou na OLX: "..olxMessage)
				         timerOlx[thePlayer] = setTimer(function() end, 60000, 1)
			         else
				     outputChatBox("#00E6FF❝ Você não tem dinheiro para enviar mensagem no chat", thePlayer, 255,255,255, true)	
				     end
					 				 else
				 outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFVocê precisa de celular para mandar mensagem!", thePlayer, 255,255,255, true)	
				 end
				 
			end
	end
end
addCommandHandler("olx", Olx)

setTimer(function()
	outputChatBox(" ", root)
end, 5000, 0)

twt = {}

function Twitter (thePlayer, commandName, ...)
     if not ... then outputChatBox("#01B7FF[BGO INFORMA]: #FFFFFFVocê precisa escrever algo em seu twitter.", thePlayer,255,255,255, true) return end
     if not getElementData(thePlayer, "loggedin") then return end
	 if isPlayerMuted(thePlayer) then outputChatBox("VOCÊ ESTÁ MUTADO DO CHAT!", thePlayer,255,255,255, true) return end
     local twitterWords = { ... }
     local twitterMessage = table.concat( twitterWords, " " )
     local id = getElementData(thePlayer, "acc:id")
         if twitterMessage == " " then
	     outputChatBox("#01B7FF[BGO INFORMA]: #FFFFFFDigite um comentário.", thePlayer,255,255,255, true)
	     else
		 
		  if exports.bgo_items:hasItemS(thePlayer, 16) then 
		  
		  if ( isPedDead ( thePlayer ) ) then 
			  outputChatBox ('#bebebe[BGO INFORMA]: #FFFFFFMORTO NÃO FALA!!',thePlayer,255,255,255,true)
			  return 
			  end
			  
			  
			 if isTimer(twt[thePlayer]) then outputChatBox ('#01B7FF[BGO INFORMA]: #FFFFFFAguarde alguns instantes para escrever novamente.',thePlayer,255,255,255,true) return end
			 local Money = 15
			 local money2 = getElementData(thePlayer, "char:money")
			     if money2 >= Money then
			     setElementData(thePlayer, "char:money", money2 - Money)
			     outputChatBox("#01B7FF✉ Twitter ✉#FFFFFF "..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "").."("..id.."): #01B7FF"..twitterMessage:gsub("#%x%x%x%x%x%x", ""), root, 255,255,255, true)
				 sendMessage ('[TWT] '..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")..' [ID: '..id..'] '..twitterMessage:gsub("#%x%x%x%x%x%x", ""))
			     twt[thePlayer] = setTimer(function() end, 20000, 1)
			     outputChatBox("#01B7FF[BGO INFORMA]: #FFFFFF❝ Foi cobrado "..Money.." para enviar a mensagem no chat.", thePlayer, 255,255,255, true)	
			     outputServerLog ( "Twitter "..getPlayerName(thePlayer).." Twittou: "..twitterMessage:gsub("#%x%x%x%x%x%x", ""))
			         else
			         outputChatBox("#01B7FF[BGO INFORMA]: #FFFFFFVocê não tem dinheiro para enviar mensagem no chat.", thePlayer, 255,255,255, true)	
	         end
			else
			outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFVocê precisa de celular para mandar mensagem!", thePlayer, 255,255,255, true)	
			end
	end
end
addCommandHandler("twt", Twitter)

fr = {}

local randomColor = {
     {"#00D0FF"}, --azul claro
     {"#FFB700"}, --laranja
     {"#FF00D0"}, --rosa
     {"#00FF91"}, --verde agua
     {"#FFD900"}, --amarelo
	 {"#00FF1E"}, --verde florecente
	 {"#D900FF"}, --roxo
	 {"#FF0400"}, --vermelho
	 {"#DDFF00"}, --amarelo
	 {"#000000"}, --PRETO
	 {"#0f700f"}, --VERDE ESCURO
	 {"#ffffff"}, --BRANCO
	 {"#969696"}, --CINZA
}

function ForadoRP (thePlayer, commandName, ...)
     if not ... then outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFVocê precisa escrever algo.", thePlayer,255,255,255, true) return end
	 
     color = math.random(#randomColor)
     if not getElementData(thePlayer, "loggedin") then return end
	 if isPlayerMuted(thePlayer) then outputChatBox("VOCÊ ESTÁ MUTADO DO CHAT!", thePlayer,255,255,255, true) return end
     local frWords = { ... }
     local frMessage = table.concat( frWords, " " )
     local id = getElementData(thePlayer, "acc:id")
     if frMessage == " " then
         outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFDigite algo Fora do RP.", thePlayer,255,255,255, true)
	 else
	 local Money = 15
	 local money2 = getElementData(thePlayer, "char:money")
	     if getElementData(thePlayer, "VIP") then
	         outputChatBox("#66FC02❝ Fora do RP ❞ "..randomColor[color][1].." ❯ VIP DA CIDADE ❮ #FFFFFF"..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "").." #66FC02("..id.."): "..randomColor[color][1]..""..frMessage:gsub("#%x%x%x%x%x%x", ""), root, 255,255,255, true)
			 sendMessage ('[FR] '..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")..' [ID: '..id..'] '..frMessage:gsub("#%x%x%x%x%x%x", ""))
	         else
			 if exports.bgo_items:hasItemS(thePlayer, 16) then 
			 
			 if ( isPedDead ( thePlayer ) ) then 
			  outputChatBox ('#bebebe[BGO INFORMA]: #FFFFFFMORTO NÃO FALA!!',thePlayer,255,255,255,true)
			  return 
			  end
			 
	         if money2 >= Money then 
	         	 if isTimer(fr[thePlayer]) then 
			     outputChatBox ('#66FC02[BGO INFORMA]: #FFFFFFAguarde #66FC0220 #FFFFFFSegundos para falar novamente!',thePlayer,255,255,255,true)
				 return 
				 end	 
	             outputChatBox("#66FC02❝ Fora do RP ❞ #FFFFFF"..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "").." #66FC02("..id.."): #66FC02"..frMessage:gsub("#%x%x%x%x%x%x", ""), root, 255,255,255, true)
				 sendMessage ('[FR] '..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")..' [ID: '..id..'] '..frMessage:gsub("#%x%x%x%x%x%x", ""))
				 outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFFoi cobrado "..Money.." para enviar a mensagem no chat", thePlayer, 255,255,255, true)	
				 outputServerLog ( "FR [FORA DO RP] "..getPlayerName(thePlayer).." Falou: "..frMessage)
		         fr[thePlayer] = setTimer(function() end, 60000, 1)
		         setElementData(thePlayer, "char:money", money2 - Money)
	             else
	             outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFVocê não tem dinheiro para enviar mensagem no chat", thePlayer, 255,255,255, true)	
		         end
				 else
				 outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFVocê precisa de celular para mandar mensagem!", thePlayer, 255,255,255, true)	
				 end
	         end
     end
end
addCommandHandler("fr", ForadoRP)

--[[
local flood = { }
local flood2 = 0
function infoS (mens)
if not getElementData(source, "loggedin") then return end
local frMessage = table.concat({ mens }, " " )
     cancelEvent()
     outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
	 outputChatBox(" ", source, 255,255,255, true)
     outputChatBox("#FFA000[BGO INFO] #FFFFFFOs chats foram alterados.", source, 255,255,255, true)
     outputChatBox("#01B7FF[BGO TWITTER] #FFFFFF/twt", source, 255,255,255, true)
     outputChatBox("#66FC02[BGO FORA DO RP] #FFFFFF/fr", source, 255,255,255, true)
     outputChatBox("#bbbbbb[BGO ANONIMOS] #FFFFFF/@", source, 255,255,255, true)
     outputChatBox("#A102FC[BGO OLX] #FFFFFF/olx", source, 255,255,255, true)
	 
	 
	 

	flood2 = flood2 + 1
	
	if not isTimer(flood[source]) then
	flood[source] = setTimer(function() flood2 = 0 end, 10000, 1)
	end
	
		if flood2 > 5 then
		flood2 = 0
	 	for k,v in ipairs(getElementsByType("player")) do
		if isElement(v) and getElementData(v, "loggedin") and tonumber(getElementData(v,"acc:admin") or 0) >= 4 then
			outputChatBox("#FF0000[ATENÇÃO] #ffffff" .. getPlayerName(source) .. "(#00ff00" .. getElementData(source, "playerid") .. "#ffffff) #ffffffEstá fazendo um possivel flood no chat para derrubar o servidor ( chame os fundadores! )",v,255,255,255,true)
			outputChatBox("Apenas se está mensagem subir varias vezes no chat!",v,255,255,255,true)
		end
		end
		end

		
	 
end
addEventHandler("onPlayerChat", root, infoS)
]]--


anonymousTimer = {}

function Anonymous (thePlayer, commandName, ...)
     if not ... then outputChatBox("#bebebe[BGO INFORMA]: #FFFFFFVocê precisa escrever algo.", thePlayer,255,255,255, true) return end
     if not getElementData(thePlayer, "loggedin") then return end
	 
	 if isPlayerMuted(thePlayer) then outputChatBox("VOCÊ ESTÁ MUTADO DO CHAT!", thePlayer,255,255,255, true) return end
     local anonymosWords = { ... }
     local anonymosMessage = table.concat( anonymosWords, " " )
         if not anonymosMessage then
         outputChatBox("#bebebe[BGO INFORMA]: #FFFFFFDigite uma mensagem anonima.", thePlayer,255,255,255, true)
         outputChatBox("#bebebe[BGO SYNTAX]: #FFFFFF/@ [Sua mensagem]", thePlayer,255,255,255, true)
         else
             if not anonymosMessage == " " then
	         outputChatBox("#bebebe[ANONIMO]* #FFFFFFDIGITE UM COMENTÁRIO", thePlayer,255,255,255, true)
	         else
			 
			  if exports.bgo_items:hasItemS(thePlayer, 16) then 
			  
			  if ( isPedDead ( thePlayer ) ) then 
			  outputChatBox ('#bebebe[BGO INFORMA]: #FFFFFFMORTO NÃO FALA!!',thePlayer,255,255,255,true)
			  return 
			  end
			  
			  
			  
				 if isTimer(anonymousTimer[thePlayer]) then outputChatBox ('#bebebe[BGO INFORMA]: #FFFFFFAguarde #bebebe1 #FFFFFFminuto para falar no /@ novamente!',thePlayer,255,255,255,true) return end
				 local Money = 25
				 local money2 = getElementData(thePlayer, "char:money")
                 if money2 >= Money then
                 setElementData(thePlayer, "char:money", money2 - Money)
				 for _, v in ipairs(getElementsByType("player")) do
				 
		         if getElementData(v, "char:dutyfaction") == 2 
		         or getElementData(v, "char:dutyfaction") == 5 
		         or getElementData(v, "char:dutyfaction") == 6 
		         or getElementData(v, "char:dutyfaction") == 11 
		         or getElementData(v, "char:dutyfaction") == 16
		         or getElementData(v, "char:dutyfaction") == 17 
		         or getElementData(v, "char:dutyfaction") == 19 
		         or getElementData(v, "char:dutyfaction") == 22
		         or getElementData(v, "char:dutyfaction") == 20
		         or getElementData(v, "char:dutyfaction") == 21 
				 or getElementData(v, "char:dutyfaction") == 24
		         then				 
                 else
                     outputChatBox("#FFFFFFMensagem Anonima: #bebebe"..anonymosMessage:gsub("#%x%x%x%x%x%x", ""), v, 255,255,255, true)
					 anonymousTimer[thePlayer] = setTimer(function() end, 60000, 1)
					 end
				 end
				 outputChatBox("#00E6FF❝ Foi cobrado "..Money.." para enviar v mensagem no chat", thePlayer, 255,255,255, true)	
				-- exports.bgo_admin:outputAdminMessage("#7cc576" .. getPlayerName(thePlayer) .. "(" .. getElementData(thePlayer, "playerid") .. ") #ffffffusou o /@ com v mensagem: #00ff00 "..anonymosMessage)	
 

		for k,v in ipairs(getElementsByType("player")) do
			if isElement(v) and getElementData(v, "loggedin") and tonumber(getElementData(v,"acc:admin") or 0) >= 1 then
				outputChatBox("#7cc576" .. getPlayerName(thePlayer) .. "(" .. getElementData(thePlayer, "playerid") .. ") #ffffffusou o /@ com a mensagem: #00ff00 "..anonymosMessage,v,255,255,255,true)
			end
		end
		sendMessage ('[@] '..getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")..' [ID: '..id..'] '..anonymosMessage:gsub("#%x%x%x%x%x%x", ""))


				else
	             outputChatBox("#00E6FF❝ Você não tem dinheiro para enviar mensagem no chat", thePlayer, 255,255,255, true)	
				 				 end
				 else
				 outputChatBox("#66FC02[BGO INFORMA]: #FFFFFFVocê precisa de celular para mandar mensagem!", thePlayer, 255,255,255, true)	

	         end
	     end
    end
end
addCommandHandler("@", Anonymous)



function convertTime(ms)
	local min = math.floor ( ms/60000 )
	local sec = math.floor( (ms/1000)%60 )
	return min, sec
end
