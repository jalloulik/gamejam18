-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

local background = require("background")
local player = require("player")
slimes = {}

slimes[1] = require("slime")

RIGHT = 1
LEFT = -1


window = {}
window.width = 720
window.height = 480

function attackSound()
	love.audio.stop(player.attack.sound);
	love.audio.play(player.attack.sound);
end

function love.load()
	love.window.setMode(window.width, window.height)
	player.init()
	for i,slime in ipairs(slimes) do
		slime.init()
	end
end

function love.update(dt)
	-- player
	player.frameAnimation(dt)
	for i,slime in ipairs(slimes) do
		slime.frameAnimation(dt)
	end
	-- slime.frameAnimation(dt)

end

function love.draw()
	background.draw()
	for i,slime in ipairs(slimes) do
		slime.draw(d)
	end
	player.draw()
end

function love.keypressed(key)
	if (key == "escape") then
		love.event.quit()
	end
end
