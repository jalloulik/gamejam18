-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

local background = require("background")
local player = require("player")
local monsters = require("monsters")
local tools = require("tools")
local score = require("score")
require("constants")
require("window")

function love.load()
	window.load()
	player.init()
end

function love.update(dt)
	player.update(dt)
	monsters.update(dt)
	player.x = background.update(dt, player.x, window.width)
	player.addHitbox()
	if (player.isFacing == 1) then
		for i,monster in ipairs(monsters.list) do
			local bool = tools.CheckCollision(player.hitbox.xr, player.hitbox.yr, player.hitbox.width, player.hitbox.height, monster.hurtbox.x, monster.hurtbox.y, monster.hurtbox.width, monster.hurtbox.height)
			if (bool and player.isAttacking) then
				monsters.kill(monster)
			end
		end
	else
		for i,monster in ipairs(monsters.list) do
			local bool = tools.CheckCollision(player.hitbox.xl, player.hitbox.yl, player.hitbox.width, player.hitbox.height, monster.hurtbox.x, monster.hurtbox.y, monster.hurtbox.width, monster.hurtbox.height)
			if (bool and player.isAttacking) then
				monsters.kill(monster)
			end
		end
	end
end

function love.draw()
	background.draw()
	monsters.draw()
	player.draw()
	score.draw()
end

function love.keypressed(key)
	if (key == "escape") then
		love.event.quit()
	end
end
