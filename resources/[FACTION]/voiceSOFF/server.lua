local allowedACL =
{
	[aclGetGroup("Console")] = true,
	--[aclGetGroup("Admin")] = true,
	--[aclGetGroup("Moderator")] = true,
}

function adminSpeaker(source, command, ...)
	for group,_ in pairs(allowedACL) do
		local account = getPlayerAccount(source)
		local name = getAccountName(account)
			if isObjectInACLGroup("user."..name,group) then
     local frWords = { ... }
     local txt = table.concat( frWords, " " )
		triggerClientEvent("client_textToSpeech", source, txt)
	end
  end
end
addCommandHandler("anunciov", adminSpeaker)



-- use: /customanunciov [linguage] [texto]
function adminLangSpeak(source, command, lang, ...)
	for group,_ in pairs(allowedACL) do
		local account = getPlayerAccount(source)
		local name = getAccountName(account)
			if isObjectInACLGroup("user."..name,group) then
			local txt = table.concat({...}, " ")
		triggerClientEvent("client_textToSpeech", source, txt, lang)
	end
  end
end
addCommandHandler("customanunciov", adminLangSpeak)