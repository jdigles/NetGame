-- CLIENT

local Net = require("../Net")
local Menu = require("Menu")
local CM = Menu:new({x = 50, y = 50, height  = 200, width = 200})
local selectedField
local info = {
	playerName = "Testy263",
	class = "rogue"
}

function love.load()
	-- Net commands
	Net:registerCMD("ServerInfo", netServerInfo)
	Net:registerCMD("StateUpdate", netStateUpdate)
	Net:registerCMD("MapUpdate", netMapUpdate)
	CM:addField("playerName", {val = "", des = "Your Name", editable = true})
	CM:addField("ip", {val = "", des = "Server IP Address", editable = true})
	CM:addField("port", {val = "", des = "Server Port", editable = true})
	CM:addField("doneButton", {val = "", des = "Done", editable = false, action = connect})
	
	Net:init("Client")
	CM:enable()
end

function connect()
	if(CM.enabled) then 
		-- Connect using the connection menu
		Net:connect(CM:getVal("ip"), CM:getVal("port"))
		info.playerName = CM:getVal("playerName")
		netSendClientInfo()
		
		-- Stop using the menu
		CM:disable()
	end
end

function love.update(dt)
	if(Net.connected) then Net:update(dt) end
end

function love.textinput(t)
	CM:textinput(t)
end

function love.keypressed(k)
	CM:keypressed(k)
end

function love.draw()
	CM:draw()
end

--------------------- Net Commands -----------------------

-- Recept
-- Info about the server etc.
function netServerInfo(table, parameters, id, dt)

end

-- Updates the state of the current map
function netStateUpdate(table, parameters, id, dt)

end

-- Gives a full update of a given map (make sure this was requested first)
function netMapUpdate(table, parameters, id, dt)

end

-- Send

function netSendAction(actionType, target, args)

end

function netSendClientInfo()
	Net:send(info, "ClientInfo", nil)
end


