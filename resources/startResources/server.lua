function _call(_called, ...)
	local co = coroutine.create(_called);
	coroutine.resume(co, ...);
end

function sleep(time)
	local co = coroutine.running();
	local function resumeThisCoroutine()
		coroutine.resume(co);
	end
	setTimer(resumeThisCoroutine, time, 1);
	coroutine.yield();
end

function UpdateStates()
	_call(updateStates); 
end

function updateStates()
	_call(updateStates); 
end
addCommandHandler("saveresources", UpdateStates)


function UpdateStates()
	_call(updateStates); 
end

function updateStates22()
	_call(startResources); 
end
--addEventHandler ( "onResourceStart", resourceRoot, updateStates22 );


function startResources ()
	local _connection = dbConnect("sqlite", ":startResources/main.db");
	if(_connection) then
		local query = dbQuery(_connection, "SELECT nomeResource FROM tblStartResources");
		
		local result = dbPoll(query, -1);
		if(#result > 0) then
			for i = 1, #result do
				local resource = getResourceFromName(result[i]["nomeResource"]);
				local start  = startResource(resource);
				--sleep(1);
			end
		end
		dbFree(query);
	else
	
	end
	destroyElement(_connection);
	--_call(updateStates); 
end
addEventHandler ( "onResourceStart", resourceRoot, startResources );




function updateStates()
	local _connection = dbConnect("sqlite", ":startResources/main.db");
	if(_connection) then
		local query = dbQuery(_connection, "DELETE FROM tblStartResources");
		local result = dbPoll(query, -1);
		dbFree(query);
		for index, resources in ipairs(getResources()) do
			local state = getResourceState(resources);
			if(state == "running") then
				local query1 = dbQuery(_connection, "INSERT INTO tblStartResources (nomeResource) VALUES ('"..tostring(getResourceName(resources)).."')");
				local result1 = dbPoll(query1, -1);
				dbFree(query1);
			end
			print("Resource: " .. getResourceName(resources) .. " inserido na database");
			sleep(200);
		end
	end
	destroyElement(_connection);
	print("Backup de Resources feito com sucesso!");
end
--addCommandHandler("saveresources", UpdateStates)


--setTimer(UpdateStates, 60000*180, 0);
