local background = {}
background.img = love.graphics.newImage("Assets/Backgrounds/emergency.png")

function background.draw()
	love.graphics.draw(background.img, 0, 0, 0, 3, 3)
end

return background
