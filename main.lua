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

local damage = 0

function love.load()
	window.load()
	player.init()
	monsters.load()
end

function love.update(dt)
	player.update(dt)
	monsters.update(dt)
	player.x = background.update(dt, player.x, window.width)
	player.addHitbox()
	player.addHurtbox()
	for i,monster in ipairs(monsters.list) do
		local bool = tools.CheckCollision(player.hitbox.x, player.hitbox.y, player.hitbox.width, player.hitbox.height, monster.hurtbox.x, monster.hurtbox.y, monster.hurtbox.width, monster.hurtbox.height)
		if (bool and player.isAttacking and player.isAlive) then
			monsters.kill(monster)
		end
	end
	for i,monster in ipairs(monsters.list) do
		local bool = tools.CheckCollision(monster.hitbox.x, monster.hitbox.y, monster.hitbox.width, monster.hitbox.height, player.hurtbox.x, player.hurtbox.y, player.hurtbox.width, player.hurtbox.height)
		if (bool and monster.isAttacking and monster.isAlive and player.isAlive) then
			score.damageAdd()
		end
	end
	if (score.damageTaken > 100) then
		player.kill()
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
