local background = {}
background.img = love.graphics.newImage("Assets/Backgrounds/emergency.png")

background.img1 = love.graphics.newImage("Assets/Backgrounds/background.png")
-- background.width = background.img1:getWidth()
-- background.height = background.img1:getHeight()
background.width = background.img:getWidth()
background.height = background.img:getHeight()
background.camera = 0

function background.update(dt, player_x, win_width)
	if player_x < 100 then
		background.camera = background.camera + 2
		player_x = player_x + 2
	end
	if player_x > win_width - 100 then
		background.camera = background.camera - 2
		player_x = player_x - 2
	end
	return player_x
end

function background.draw()
	love.graphics.draw(background.img, 0 + background.camera, 0, 0, 3, 3)
	-- love.graphics.draw(background.img1, 0 + background.camera, -500, 0, 1, 1)
end

return background
