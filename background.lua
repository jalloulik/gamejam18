local background = {}
local monsters = require("monsters")
background.img = love.graphics.newImage("Assets/Backgrounds/emergency.png")

background.img1 = love.graphics.newImage("Assets/Backgrounds/background.png")
-- background.width = background.img1:getWidth()
-- background.height = background.img1:getHeight()
background.width = background.img:getWidth()
background.height = background.img:getHeight()
background.camera = 0

function background.update(dt, player_x, win_width)
	if player_x < 100 and (background.camera < 0) then
		if (background.camera > 0) then
			background.camera = 0
		end
		background.camera = background.camera + (220 * dt )
		player_x = player_x + (220 * dt)
		for i,monster in ipairs(monsters.list) do
			monster.x = monster.x + (220 * dt)
		end
	end
	if ((player_x > win_width - 100) and background.camera > -720) then
		if (background.camera < -720) then
			background.camera = -720
		end
		background.camera = background.camera - (220 * dt)
		player_x = player_x - (220 * dt)
		for i,monster in ipairs(monsters.list) do
			monster.x = monster.x - (220 * dt)
		end
	end
	return player_x
end

function background.draw()
	love.graphics.draw(background.img, 0 + background.camera, 0, 0, 3, 3)
	love.graphics.draw(background.img, background.camera + 720, 0, 0, 3, 3)
	-- love.graphics.draw(background.img1, 0 + background.camera, -500, 0, 1, 1)
end

return background
