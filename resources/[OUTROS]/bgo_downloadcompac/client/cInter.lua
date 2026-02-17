local sx, sy = guiGetScreenSize ( );

Inter = { };
Inter.btn = { };
Inter.grid = { };

Inter.window = exports.dgs:dgsCreateWindow((sx/2)-333, (sy/2)-333, 666, 530, "BGO DOWNLOAD EXTERNO.", false)
exports.dgs:dgsSetVisible ( Inter.window,false )
exports.dgs:dgsWindowSetMovable ( Inter.window, false )
Inter.window.visible = false;
Inter.grid.list = exports.dgs:dgsCreateGridList(9, 24, 643, 364, false, Inter.window)
exports.dgs:dgsGridListAddColumn(Inter.grid.list, "Substituir", 0.3)
exports.dgs:dgsGridListAddColumn(Inter.grid.list, "Arquivo", 0.35)
exports.dgs:dgsGridListAddColumn(Inter.grid.list, "Ativar", 0.15)
exports.dgs:dgsGridListAddColumn(Inter.grid.list, "Status", 0.15)
--exports.dgs:dgsGridListSetSortingEnabled ( Inter.grid.list, false );
Inter.btn.enable = exports.dgs:dgsCreateButton(13, 397, 136, 39, "Ativar", false, Inter.window)
Inter.btn.enableAll = exports.dgs:dgsCreateButton(13, 446, 136, 39, "Ativar todos", false, Inter.window)
Inter.btn.disable = exports.dgs:dgsCreateButton(159, 397, 136, 39, "Desativar", false, Inter.window)
Inter.btn.disableAll = exports.dgs:dgsCreateButton(159, 446, 136, 39, "Desativar todos", false, Inter.window)
Inter.btn.refresh = exports.dgs:dgsCreateButton(516, 397, 136, 39, "Atualizar", false, Inter.window)

function Inter.open ( b )
	if ( b == Inter.window.visible ) then return false; end
	
	Inter.window.visible = b;
	--showCursor ( b );
	
	if ( b ) then 
		Inter.btn.enable.enabled = true;
		Inter.btn.disable.enabled = true;
		
		Inter.refresh ( );
		removeEventHandler ( "onDgsMouseClick", root, Inter.onEvent );
		addEventHandler ( "onDgsMouseClick", root, Inter.onEvent );
	else 
		removeEventHandler ( "onDgsMouseClick", root, Inter.onEvent );
	end 
end 

function execdown ( )
	 for i, v in pairs ( Downloader.Mods ) do 
		 Mods.SetModEnabled ( i, true);
	 end 
end 
addEvent ( "start:download", true );
addEventHandler ( "start:download", root, execdown);

function Inter.onEvent ( )
		if ( source == Inter.btn.refresh ) then 
			Inter.refresh ( );
		elseif ( source == Inter.grid.list ) then 
			local row, _ = exports.dgs:dgsGridListGetSelectedItem ( Inter.grid.list );
			--Inter.btn.enable.enabled = ( ( row ~= -1 ) and ( guiGridListGetItemText( Inter.grid.list, row, 3 ) == "No" ) );
			--Inter.btn.disable.enabled = ( ( row ~= -1 ) and ( guiGridListGetItemText( Inter.grid.list, row, 3 ) == "Yes" ) );
		elseif ( source == Inter.btn.enableAll or source == Inter.btn.disableAll ) then 
			if ( localPlayer:getOccupiedVehicle ( ) ) then 
				return outputChatBox ( "#FFA000[BGO INFO] #FFFFFFPor favor, saia do seu veículo antes de ativar ou desativar os mods", 255, 255, 0, true );
			end
			
			for i, v in pairs ( Downloader.Mods ) do 
				Mods.SetModEnabled ( i, source == Inter.btn.enableAll );
			end 
			
			Inter.refresh ( );
		
		elseif ( source == Inter.btn.enable or source == Inter.btn.disable ) then 
			if ( localPlayer:getOccupiedVehicle ( ) ) then 
				return outputChatBox ( "#FFA000[BGO INFO] #FFFFFFPor favor, saia do seu veículo antes de ativar ou desativar os mods", 255, 255, 0, true );
			end
			
			local row, _ = exports.dgs:dgsGridListGetSelectedItem ( Inter.grid.list );
			if ( row == - 1 ) then return end 
			Mods.SetModEnabled ( exports.dgs:dgsGridListGetItemText ( Inter.grid.list, row, 2 ), source == Inter.btn.enable  );
			Inter.refresh ( );
		end 
		
	--end 
end 

function Inter.refresh ( )
	local _row, col = exports.dgs:dgsGridListGetSelectedItem ( Inter.grid.list );

	exports.dgs:dgsGridListClear ( Inter.grid.list );
	
	local t = Downloader.Mods;
	local skins = { }
	local vehs = { }
	local weaps = { }
	
	-- Loop the downloaded mods and seperate mod types
	for index, var in pairs ( t ) do 
		local t = tostring ( var.type ):lower ( );
		if ( t ==  "skins" ) then
			table.insert ( skins, var )
		elseif ( t == "vehicles" ) then 
			table.insert ( vehs, var ) 
		elseif ( t == "weapons" ) then
			table.insert ( weaps, var ) 
		end
	end 
	
	exports.dgs:dgsGridListSetItemText ( Inter.grid.list, exports.dgs:dgsGridListAddRow ( Inter.grid.list ), 1, "Vehicle Mods", true, true )
	
	for i, v in pairs ( vehs ) do
		local r, g, b = 0, 255, 0 -- Assume its downloaded and ready
		local enabled = v.enabled or false 
		local status = "Pronto";
		
		if ( not enabled ) then 
			r, g, b = 255, 0, 0
			enabled = "Desativado";
		else 
			enabled = "Ativado";
		end 
		
		if ( not File.exists ( v.txd ) or not File.exists ( v.dff ) ) then
			status = "Em Download";
			r, g, b = 255, 255, 0
		end 
		
		local row = exports.dgs:dgsGridListAddRow ( Inter.grid.list );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 1, getVehicleNameFromModel ( v.replace ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 2, tostring ( v.name ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 3, tostring ( enabled ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 4, tostring ( status ), false, false );
		for i = 1, 4  do 
			exports.dgs:dgsGridListSetItemColor ( Inter.grid.list, row, i, r, g, b );
		end 
		
		if ( row == _row )then 
			exports.dgs:dgsGridListSetSelectedItem ( Inter.grid.list, row, col );
			triggerEvent ( "onClientGUIClick", Inter.grid.list );
		end 
	end 
	
	
	exports.dgs:dgsGridListSetItemText ( Inter.grid.list, exports.dgs:dgsGridListAddRow ( Inter.grid.list ), 1, "Weapon Mods", true, true )
		
	for i, v in pairs ( weaps ) do
		local r, g, b = 0, 255, 0 -- Assume its downloaded and ready
		local enabled = v.enabled or false 
		local status = "Pronto";
		
		if ( not enabled ) then 
			r, g, b = 255, 0, 0
			enabled = "Desativado";
		else 
			enabled = "Ativado";
		end 
		
		if ( not File.exists ( v.txd ) or not File.exists ( v.dff ) ) then
			status = "Em Download";
			r, g, b = 255, 255, 0
		end 
		
		local row = exports.dgs:dgsGridListAddRow ( Inter.grid.list );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 1, engineGetModelNameFromID ( v.replace ) or tostring ( v.replace ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 2, tostring ( v.name ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 3, tostring ( enabled ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 4, tostring ( status ), false, false );
		for i = 1, 4  do 
			exports.dgs:dgsGridListSetItemColor ( Inter.grid.list, row, i, r, g, b );
		end 
		
		if ( row == _row )then 
			exports.dgs:dgsGridListSetSelectedItem ( Inter.grid.list, row, col );
			triggerEvent ( "onDgsMouseClick", Inter.grid.list );
		end 
	end 
	
	
	exports.dgs:dgsGridListSetItemText ( Inter.grid.list, exports.dgs:dgsGridListAddRow ( Inter.grid.list ), 1, "Skin Mods", true, true )
		
	for i, v in pairs ( skins ) do
		local r, g, b = 0, 255, 0 -- Assume its downloaded and ready
		local enabled = v.enabled or false 
		local status = "Pronto";
		
		if ( not enabled ) then 
			r, g, b = 255, 0, 0
			enabled = "Desativado";
		else 
			enabled = "Ativado";
		end 
		
		if ( not File.exists ( v.txd ) or not File.exists ( v.dff ) ) then
			status = "Em Download";
			r, g, b = 255, 255, 0
		end 
		
		local row = exports.dgs:dgsGridListAddRow ( Inter.grid.list );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 1, tostring ( v.replace ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 2, tostring ( v.name ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 3, tostring ( enabled ), false, false );
		exports.dgs:dgsGridListSetItemText ( Inter.grid.list, row, 4, tostring ( status ), false, false );
		for i = 1, 4  do 
			exports.dgs:dgsGridListSetItemColor ( Inter.grid.list, row, i, r, g, b );
		end 
		
		if ( row == _row )then 
			exports.dgs:dgsGridListSetSelectedItem ( Inter.grid.list, row, col );
			triggerEvent ( "onDgsMouseClick", Inter.grid.list );
		end 
	end 
end 

function windowClosed()
	cancelEvent()
	painel = false
	exports.dgs:dgsAlphaTo(Inter.window,0,false,"OutQuad",1000)
	--exports.dgs:dgsSetVisible (painel,false )
	--showCursor(false)
	setTimer(function()
		 exports.dgs:dgsSetVisible (Inter.window, false)
	end,1100,1)
end
addEventHandler("onDgsWindowClose",Inter.window,windowClosed)


painel = false

addCommandHandler ( "mods", function ( )
	if ( not Downloader.gotResponse ) then 
		outputChatBox ( "#FFA000[BGO INFO] #FFFFFFAinda estamos aguardando que o servidor aceite nossa solicitação. Por favor, espere", 255, 255, 0, true );
		return false;
	end
	--Inter.open ( not Inter.window.visible );
    if not painel then
		exports.dgs:dgsAlphaTo(Inter.window,255,false,"OutQuad",1000)
      	 exports.dgs:dgsSetVisible ( Inter.window, true)
         exports.dgs:dgsWindowSetMovable ( Inter.window, true)
		 Inter.open ( true );
		 painel = true
	else
		windowClosed()
		painel = false
		Inter.open ( false );
	end
end );