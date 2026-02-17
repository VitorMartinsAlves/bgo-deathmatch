addEvent("setDim", true)
addEventHandler("setDim", root, function(dim)
    setElementDimension(source, dim)
end)