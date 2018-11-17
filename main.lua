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
local menu = require("menu")
require("constants")
require("window")

local damage = 0
local scene = "game"
local inGame = false

function love.load()
	window.load()
	player.init()
	monsters.load()
	menu.load(window)
end

function love.update(dt)
	if scene == "game" then
		inGame = true
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
	elseif scene == "menu" then
		menu.update(dt, inGame)
	end
end

function love.draw()
	if scene == "game" then
		background.draw()
		monsters.draw()
		player.draw()
		score.draw()
	elseif scene == "menu" then
		menu.draw()
	end
end

function love.keypressed(key)
	if (key == "escape") then
		if scene == "game" then
			scene = "menu"
		else
			scene = "game"
		end
	end
	if (key == "f1") then
		love.event.quit()
	end
end
