local Camera = require("camera")

local Screen = {}
Screen.__index = Screen

Screen.cameras = {}

function Screen.createCamera()
	newCamera = Camera.create()
	newCamera:setX(0)
	newCamera:setY(0)
	Screen.camera = newCamera
	table.insert(Screen.cameras, newCamera)
	Screen.arrange()
	return newCamera
end

function Screen.arrange()
	local n = #Screen.cameras
	local screenArea = SCREEN_WIDTH * SCREEN_HEIGHT
	local cameraArea = screenArea / n
	local columns = math.ceil(SCREEN_WIDTH/math.sqrt(cameraArea)-0.5)
	local rows = math.ceil(n/columns)
	local cameraWidth  = math.floor(SCREEN_WIDTH/columns)
	local cameraHeight = math.floor(SCREEN_HEIGHT/rows)
	for i, camera in ipairs(Screen.cameras) do
		local x = (i-1)%columns 
		local y = (i-x -1)/columns
		camera:setScissor(x*cameraWidth, y*cameraHeight, 
						  cameraWidth, cameraHeight)
	end
end

function Screen.setCamera(currentCamera)
	Screen.camera = currentCamera
end

function Screen.getCursorCoords(X, Y)
	return Screen.camera:getCursorCoords(X, Y)
end

function Screen.draw(image, x, y, angle, sx, sy, ox, oy)
	for i, camera in ipairs(Screen.cameras) do
		camera:draw(image, x, y, angle, sx, sy, ox, oy)
	end
end

function Screen.drawExtras()
	for i, camera in ipairs(Screen.cameras) do
		camera:drawExtras()
	end
end

return Screen
