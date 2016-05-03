local Debug = require("debugTools")
local Player = require("player")
local Structure = require("structure")
local World = require("world")
local MainMenu = require("mainMenu")
local InGame = require("inGame")
local NewGame = require("newGame")

local physics
local player1
-- These are global for now.
--local globalOffsetX
--local globalOffsetY
local mouseWorldX
local mouseWorldY

function love.load()
	state = MainMenu
end

function love.update(dt)
	state = state.update(dt)

	if debugmode then Debug.update(mouseWorldX, mouseWorldY) end
end

function love.draw()
	SCREEN_WIDTH = love.graphics.getWidth()
	SCREEN_HEIGHT = love.graphics.getHeight()
	state = state.draw()
	

	-- Print debug info.
	if debugmode then Debug.draw() end
end

function love.keypressed(key)
	if key == "f11" then love.window.setFullscreen(not love.window.getFullscreen(), "desktop") end
	if key == "f12" then debugmode = not debugmode end

	state = state.keypressed(key)

	if debugmode == true then
		Debug.keyboard(key, globalOffsetX, globalOffsetY)
	end
end

function love.mousepressed(x, y, button, istouch)
	state = state.mousepressed(x, y, button)

	if debugmode == true then
		Debug.mousepressed(x, y, button, mouseWorldX, mouseWorldY)
	end
end

function love.mousereleased(x, y, button, istouch)
	state = state.mousereleased(x, y, button)

	if debugmode == true then
		Debug.mousereleased(x, y, button, mouseWorldX, mouseWorldY)
	end
end
