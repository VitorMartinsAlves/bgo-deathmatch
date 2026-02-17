function setAnimation(animationBlock,animationID)
setPedAnimation(source,animationBlock,animationID)
end
addEvent("setAnimation",true)
addEventHandler ("setAnimation",getRootElement(),setAnimation)