
 local zone = createColCuboid(2177.89014, -1203.16345, 1021.19550, 77.53369140625, 67.890625, 19.602453613281)


function animationCommand ( source )
if isElementWithinColShape ( source, zone ) then
setPedAnimation ( source, "sex","sex_1_cum_p", -0, true, false, false )
end
end
addCommandHandler ( "sexo1", animationCommand )

function animationCommand ( source )
if isElementWithinColShape ( source, zone ) then
setPedAnimation ( source, "sex","sex_1_cum_w", -0, true, false, false )
end
end
addCommandHandler ( "sexo2", animationCommand )



function animationCommand ( source )
setPedAnimation ( source, "GANGS", "smkcig_prtl_f", -0, true, false, false )
end
addCommandHandler ( "fumar", animationCommand )
