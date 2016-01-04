-- Connection menu

local utf8 = require("utf8")
local Menu = {}
local textHeight = 14

Menu.fields = {}
Menu.fields.playerName = {val = "Name", x = 0, y = 0, des = "Your Name", editable = true}
Menu.fields.ip = {val = "IP", x = 0, y = textHeight * 1, des = "Server IP address", editable = true}
Menu.fields.port = {val = "Port", x = 0, y = textHeight * 2, des = "Server port", editable = true}
Menu.fields.doneButton = {val = "", x = 0, y = textHeight * 4, des = "Done", editable = false}
Menu.fields.doneButton.action = function()
	connect()
end

Menu.enabled = true

Menu.selectedField = Menu.fields.playerName

function Menu:textinput(t)
	if (Menu.enabled) then
		if(Menu.selectedField.editable) then
			Menu.selectedField.val = Menu.selectedField.val .. t
		end
	end
end

function Menu:update(dt)
	if(Menu.enabled) then
	
	end
end

function Menu:keypressed(key)
	if(Menu.enabled) then
		
		if(key == "backspace") then
			local byteoffset = utf8.offset(Menu.selectedField.val, -1)
			if byteoffset then
				Menu.selectedField.val = string.sub(Menu.selectedField.val, 1, byteoffset - 1)
			end
		end
		if(key == "tab") then
			Menu.selectedField = getNextField(Menu.selectedField)
		end
		if(key == "return") then
			if not(Menu.selectedField.action == nil) then
				Menu.selectedField.action()
			end
		end
	end
end

function Menu:draw()
	if (Menu.enabled) then
		--Hilight the selected field
		love.graphics.setColor(50, 50, 255)
		love.graphics.rectangle("fill", Menu.selectedField.x, Menu.selectedField.y, love.graphics.getWidth(), textHeight)
		
		-- Draw the actual fields
		love.graphics.setColor(255, 255, 255)
		for k, v in pairs(Menu.fields) do
			if (v.editable) then
				love.graphics.printf(v.des..": "..v.val, v.x, v.y, love.graphics.getWidth())
			else
				love.graphics.printf(v.des.." "..v.val, v.x, v.y, love.graphics.getWidth())
			end
		end
	end
end

function Menu:enable()
	Menu.enabled = true
end

function Menu:disable()
	Menu.enabled = false
end

function Menu:getVal(key)
	return Menu.fields[key].val
end

function getNextField(current)
	local nextField = {}
	nextField[Menu.fields.playerName] = Menu.fields.ip
	nextField[Menu.fields.ip] = Menu.fields.port
	nextField[Menu.fields.port] = Menu.fields.doneButton
	nextField[Menu.fields.doneButton] = Menu.fields.playerName
	
	return nextField[current]
end

return Menu
