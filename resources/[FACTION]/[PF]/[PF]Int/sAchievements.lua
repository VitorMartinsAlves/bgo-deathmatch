mk1 = createMarker(1568.7557373047,-1690.4477539063,5.890625 -1,"cylinder",1.1,255,255,255,70)


mksaida = createMarker(-2026.9200439453,-104.17700958252,1035.171875 -1,"cylinder",1.1,255,255,255,70)
setElementDimension(mksaida, 2)
setElementInterior(mksaida, 3)

function tele1 (source)
     if exports.bgo_dashboard:isPlayerInFaction(source , 11) then
     setElementPosition(source,-2029.6000976563,-105.39453125,1035.171875)
     setElementDimension(source,2)
     setElementInterior(source,3)
     end
end
addEventHandler("onMarkerHit",mk1,tele1)

function saida(source)
     if getElementDimension(mksaida) == getElementDimension(source) then
         setElementPosition(source,1568.8009033203,-1696.7954101563,5.890625)
         setElementDimension(source,0)
         setElementInterior(source,0)
	 end
end  
addEventHandler("onMarkerHit",mksaida,saida)

	 
