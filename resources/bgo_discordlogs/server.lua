local logs = {
    {"https://discord.com/api/webhooks/1012838307446669323/plxMzVWDQ-BIVuiv3ayZ0pPpqt4eyBjw20GbvwMYtSv7PAecr4FW6Y61xHP4oJM8u7dH"}, --1 - LOGS ADMIN
	{"https://discord.com/api/webhooks/814666546055610428/jUAK_ixfbCnRh7n0h2xBz_fUWWx5CsY54_R0C-dmYHgyJEfyVoMOMyW1ugLPQ6N4965e"}, -- 2   - LOGS VENDAS
	{"https://discord.com/api/webhooks/814666747378139177/i1KdsnYQlQZmego5cbxLE3jrdIvS1tL7ajWa7Cd6IyJfEt0aq7qDx3emBhmfz34i7tbD"}, -- 3   - LOGS DINHEIRO
	{"https://discord.com/api/webhooks/814666892223578152/vrdxyxFUJVD51HZ4f1v_NG_wwvtRJ9xBupOdxA9OP2fI59AgeZ4l_tzZeAvazqoNEDwk"}, -- 4   - LOGS GRUPOS
	{"https://discord.com/api/webhooks/814667031705288704/P0O95RmOqiO2p5lTdMCIfuapZp7YUhuWPMFrS9pe8sGJb-nrw-r51Zk5L_urbTVD1kVQ"}, -- 5   - LOGS MORTES
	{"https://discord.com/api/webhooks/815408956163489842/sGeke7PRSh3WAOM79gHjWWo2Lv3EZ-c4xb7oeBtAZTW6YPx2emAzIfrZJNax0912n46H"}, -- 6   - LOGS SALARIOS
	{"https://discord.com/api/webhooks/1012838307446669323/plxMzVWDQ-BIVuiv3ayZ0pPpqt4eyBjw20GbvwMYtSv7PAecr4FW6Y61xHP4oJM8u7dH"}, -- 7   - LOGS CAIXAS
}

function sendDiscordMessage(typ, everyone, message)
     if logs[tonumber(typ)][1] then
         if everyone then
             sendOptions = {
             queueName = "dcq",
             connectionAttempts = 3,
             connectTimeout = 4900,
             formFields = {
                  content=
				  "***@everyone***\n **"..message.."**"
                 },
             }
         else
		
             sendOptions = {
             queueName = "dcq",
             connectionAttempts = 3,
             connectTimeout = 5000,
             formFields = {
                  content=
				  "*** ***\n **"..message.."**",
                 },
             }


         end
     end
	 

	 fetchRemote ( logs[tonumber(typ)][1], sendOptions, callback )
	 

	 
	 
end

function callback()
end



