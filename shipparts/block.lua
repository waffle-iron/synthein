local Part = require("shipparts/part")

local Block = {}
Block.__index = Block
setmetatable(Block, Part)

function Block.create(world, x, y)
	local self = Part.create()
	setmetatable(self, Block)

	self.image = love.graphics.newImage("res/images/block.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	self.physicsShape = love.physics.newRectangleShape(self.width, self.height)

	return self
end

return Block
