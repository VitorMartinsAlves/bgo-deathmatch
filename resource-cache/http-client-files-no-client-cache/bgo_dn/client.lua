local customIfp = nil 

function setPedDanceAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
if isElement(ped) then
if animation == "crckdeth1" 
or animation == "crckdeth2" 
or animation == "crckdeth3" 
or animation == "crckdeth4" 
or animation == "crckidle1" 
or animation == "crckidle2" 
or animation == "crckidle3" 
or animation == "crckidle4" then
setPedAnimation(ped, "CUSTOM_BLOCK_1", animation, tiempo, true, false, false) 
if tiempo > 1 then
setTimer(setPedAnimation,tiempo,1,ped,false)
setTimer(setPedAnimation,tiempo+100,1,ped,false)
end
end
end
end
addEvent("setPedDanceAnimation",true)
addEventHandler("setPedDanceAnimation",getRootElement(),setPedDanceAnimation)

addEventHandler("onClientResourceStart", resourceRoot,
    function ( startedRes )
    customIfp = engineLoadIFP ("crack.ifp", "CUSTOM_BLOCK_1")
    if customIfp then 
    
    outputDebugString ("Novas danças ativadas!")
    
    else
    outputDebugString ("Ocorreu algum problema nas novas danças!")
    end
    end
)