-- Connection menu

local utf8 = require("utf8")
local Menu = {}
local textHeight = 14
local hilightColor = {50, 50, 255}

Menu.x = 0
Menu.y = 0
Menu.height = love.graphics.getHeight()
Menu.width = love.graphics.getWidth()

Menu.fields = {}

Menu.enabled = true

Menu.selectedField = Menu.fields.playerName
Menu.firstField = nil
Menu.lastField = nil
Menu.numFields = 0

function Menu:addField(name, o)
	-- Sanity check
	if (name == nil or not type(name) == "string") then 
		print("Error: fields must have a name")
		return
	end
	o = o or {}
	if(o.val == nil) then o.val = "" end
	if(o.x == nil or o.x < self.x) then o.x = self.x end
	if(o.y == nil or o.y < self.y) then o.y = self.y + (textHeight * self.numFields) end
	if(o.des == nil or not type(o.des) == "string") then o.des = "" end
	if(o.editable == nil) then o.editable = false end
	if(self.firstField == nil) then 
		self.firstField = o 
		self.selectedField = o
	end
	if not (self.lastField == nil) then
		self.lastField.next = o
	end
	o.previous = self.lastField
	self.lastField = o
	self.numFields = self.numFields + 1
	self.fields[name] = o
end
	

function Menu:textinput(t)
	if (self.enabled) then
		if(self.selectedField.editable) then
			self.selectedField.val = self.selectedField.val .. t
		end
	end
end

function Menu:update(dt)
	if(self.enabled) then
	
	end
end

function Menu:keypressed(key)
	if(self.enabled) then
		
		if(key == "backspace") then
			local byteoffset = utf8.offset(self.selectedField.val, -1)
			if byteoffset then
				self.selectedField.val = string.sub(self.selectedField.val, 1, byteoffset - 1)
			end
		end
		if(key == "tab" or key == "down") then
			self.selectedField = self:getNextField(self.selectedField)
		end
		if(key == "up") then
			self.selectedField = self:getPreviousField(self.selectedField)
		end
		if(key == "return") then
			if not(self.selectedField.action == nil) then
				self.selectedField.action()
			end
		end
	end
end

function Menu:draw()
	if (self.enabled) then
		--Hilight the selected field
		love.graphics.setColor(hilightColor)
		love.graphics.rectangle("fill", self.selectedField.x, self.selectedField.y, self.width, textHeight)
		
		-- Draw the actual fields
		love.graphics.setColor(255, 255, 255)
		for k, v in pairs(self.fields) do
			if (v.editable) then
				love.graphics.printf(v.des..": "..v.val, v.x, v.y, self.width)
			else
				love.graphics.printf(v.des.." "..v.val, v.x, v.y, self.width)
			end
		end
	end
end

function Menu:enable()
	self.enabled = true
end

function Menu:disable()
	self.enabled = false
end

function Menu:getVal(key)
	return self.fields[key].val
end

function Menu:getNextField(current)
	if(current.next == nil) then
		return self.firstField
	else
		return current.next
	end
end

function Menu:getPreviousField(current)
	if(current.previous == nil) then
		return self.lastField
	else
		return current.previous
	end
end


function Menu:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end


return Menu
