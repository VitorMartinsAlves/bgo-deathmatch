addEvent("giveitemLixao",true)
addEventHandler("giveitemLixao",root,
function(thePlayer, id, quant)

              if exports.bgo_items:giveItem(thePlayer, id, 1, quant, 0, false) then 
			  
			  local a = math.random(1,30)
                exports.bgo_hud:drawNote("daritem"..a.."", "Você pegou um item do lixão", thePlayer, 255, 255, 255, 7000)
               --else
                  -- outputChatBox("", thePlayer)  
             end
     -- end
end)


addEvent ("Lixao_setPedAnim", true )
addEventHandler ("Lixao_setPedAnim", root, 
    function (thePlayer)
		exports.bgo_anims:setJobAnimation(thePlayer, "BOMBER", "BOM_Plant", 10000, true, false, false)
    end
)


addEvent ("Lixao_stopPedAnim", true )
addEventHandler ("Lixao_stopPedAnim", root, 
    function (thePlayer)
		exports.bgo_anims:setJobAnimation(thePlayer)
		setPedAnimation(thePlayer)
    end
)