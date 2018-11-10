-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

local background = require("background")
local player = require("player")
local monsters = require("monsters")

require("constants")
require("window")

function love.load()
	window.load()
	player.init()
	monsters.spawn()
end

function love.update(dt)
	player.update(dt)
	monsters.update(dt)

end

function love.draw()
	background.draw()
	monsters.draw()
	player.draw()
end

function love.keypressed(key)
	if (key == "escape") then
		love.event.quit()
	end
end
