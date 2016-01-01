-- Connection menu

local utf8 = require("utf8")
local connectionMenu = {}
local textHeight = 12

connectionMenu.fields = {}
connectionMenu.fields.ip = {val = "IP", x = 0, y = 0, des = "Server IP address"}
connectionMenu.fields.port = {val = "Port", x = 0, y = 12, des = "Server port"}
connectionMenu.fields.playerName = {val = "Name", x = 0, y = 24, des = "Your Name"}

connectionMenu.enabled = true

connectionMenu.selectedField = connectionMenu.fields.playerName

function connectionMenu:textinput(t)
	if (connectionMenu.enabled) then
		connectionMenu.selectedField.val = connectionMenu.selectedField.val .. t
	end
end

function connectionMenu:update(dt)
	if(connectionMenu.enabled) then
	
	end
end

function connectionMenu:keypressed(key)
	if(connectionMenu.enabled) then
		if(key == "backspace") then
			local byteoffset = utf8.offset(connectionMenu.selectedField.val, -1)
			if byteoffset then
				connectionMenu.selectedField.val = string.sub(connectionMenu.selectedField.val, 1, byteoffset - 1)
			end
		end
		if(key == "tab") then
			connectionMenu.selectedField = getNextField(connectionMenu.selectedField)
		end
	end
end

function connectionMenu:draw()
	if (connectionMenu.enabled) then
		
		-- love.graphics.printf("Your name: "..connectionMenu.fields.playerName.val, connectionMenu.fields.playerName.x, connectionMenu.fields.playerName.y, love.graphics.getWidth())
		for k, v in pairs(connectionMenu.fields) do
			love.graphics.printf(v.des..": "..v.val, v.x, v.y, love.graphics.getWidth())
		end
	end
end

function connectionMenu:enable()
	connectionMenu.enabled = true
end

function connectionMenu:disable()
	connectionMenu.enabled = false
end

function getNextField(current)
	local nextField = {}
	nextField[connectionMenu.fields.ip] = connectionMenu.fields.port
	nextField[connectionMenu.fields.port] = connectionMenu.fields.playerName
	nextField[connectionMenu.fields.playerName] = connectionMenu.fields.ip
	return nextField[current]
end

return connectionMenu
