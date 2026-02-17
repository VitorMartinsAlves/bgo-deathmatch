ballNames={
	[2995]="Bola número 1 listrada",
	[2996]="Bola número 2 listrada",
	[2997]="Bola número 3 listrada",
	[2998]="Bola número 4 listrada",
	[2999]="Bola número 5 listrada",
	[3000]="Bola número 6 listrada",
	[3001]="Bola número 7 listrada",

	[3002]="Bola número 1 sólida", 

	[3003]="Bola branca",

	[3100]="Bola número 2 sólida",
	[3101]="Bola número 3 sólida",
	[3102]="Bola número 4 sólida",
	[3103]="Bola número 5 sólida",
	[3104]="Bola número 6 sólida",
	[3105]="Bola número 7 sólida",
	[3106]="Bola número oito",
}


function shuffle(t)
  local n = #t
 
  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
 
  return t
end

function findRotation(startX, startY, targetX, targetY)	-- Doomed-Space-Marine
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	
	if t < 0 then
		t = t + 360
	end
	
	return t
end
