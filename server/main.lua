-- SERVER

local Net = require("../Net")
local serverInfo = {
	name = "TestServer1",
	gameMode = "FFA"
}

function love.load()
	-- netCommands
	Net:registerCMD("ClientInfo", netClientInfo)
	Net:registerCMD("PlayerAction", netPlayerAction)
	
	port = 4444
	
	Net:init("Server")
	Net:connect(nil, port)
end

function love.update(dt)
	-- Net stuff
	Net:update(dt)
	
	-- Map stuff
	

end

function love.draw()
	
end

--------------------- Net Commands -----------------------

-- Recept
-- Recieves info about a connected player
function netClientInfo(table, parameters, id, dt)
	print("Player \""..table.playerName.."\" connected with id: "..id)
end

-- Recieves a specific player action
function netPlayerAction(table, parameters, id, dt)

end

-- Send
-- Sends server info to a specific ID
function netSendServerInfo(id)
	Net:send(serverInfo, "ServerInfo", nil, id)
end

function netSendStateUpdate(updatedStuff, playerId)

end

function netSendMapUpdate(map, mapId, playerId)

end

