local customIfp = nil 

function setPedDanceAnimation (ped,animation,tiempo,repetir,mover,interrumpible)
if (type(animation) ~= "string" or type(tiempo) ~= "number" or type(repetir) ~= "boolean" or type(mover) ~= "boolean" or type(interrumpible) ~= "boolean") then return false end
if isElement(ped) then
setPedAnimation(ped, "aaa", "continencia", -1, true, false)
if tiempo > 1 then
setTimer(setPedAnimation,tiempo,1,ped,false)
setTimer(setPedAnimation,tiempo+100,1,ped,false)
end
end
end
addEvent("setPedDanceAnimationCont",true)
addEventHandler("setPedDanceAnimationCont",getRootElement(),setPedDanceAnimation)

addEventHandler("onClientResourceStart", resourceRoot,
    function ( startedRes )
	local ifp = engineLoadIFP( "anim.ifp", "aaa" )
	--customIfp = engineLoadIFP( "anim.ifp", "newAnimBlock" )
    if ifp then 
    
    outputDebugString ("Novas animações ativadas!")
    
    else
    outputDebugString ("Ocorreu algum problema nas novas animações!")
    end
    end
)