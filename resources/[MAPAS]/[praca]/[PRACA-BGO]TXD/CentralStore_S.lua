local objeto = createObject(1933, 1881.6999511719, -1681.8000488281, 19.49999961853)
setElementRotation(objeto, 0, 0, 0)

setTimer(function()
   local rx, ry, rz = getElementRotation(objeto)
     setElementRotation(objeto, 0, 0, (rz +1))
end, 10, 0)