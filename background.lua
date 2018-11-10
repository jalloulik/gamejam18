local background = {}
background.img = love.graphics.newImage("Assets/Backgrounds/emergency.png")

background.img1 = love.graphics.newImage("Assets/Backgrounds/background.png")
background.width = background.img1:getWidth()
background.height = background.img1:getHeight()
background.camera = 0

function background.update(dt, player_x, win_width)
	if player_x < 100 then
		background.camera = background.camera + 2
	end
	if player_x > win_width - 100 then
		background.camera = background.camera - 2
	end
end

function background.draw()
	love.graphics.draw(background.img1, 0 + background.camera, -500, 0, 1, 1)
end

return background
