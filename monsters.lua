local slimes = require("slime")
local player = require("player")
local score = require("score")

local dev = require("dev")

local startTime = love.timer.getTime()

local monsters = {}
monsters.list = {}
monsters.spawn = {}
monsters.spawn.timer = 0
monsters.spawn.speed = 5
monsters.spawn.min = 0
monsters.spawn.max = 700
global_id = 0

function monsters.load()
	monsters.create(500, 410, "slime")
end

function monsters.create(posx, posy, type)
	global_id = global_id + 1
	local monster = {}
	monster.id = global_id
	monster.x = posx
	monster.y = posy
	monster.isAlive = true
	monster.isDying = false
	monster.isRunning = false
	monster.isFacing = 1
	monster.isAttacking = false
	monster.attackTimer = 0
	monster.attackPermission = false
	monster.width = 30
	monster.height = 30
	monster.type = type
	if (monster.type == "slime") then
		slimes.create(monster)
		slimes.init(monster)
	end
	table.insert(monsters.list, monster)
end

spawnTimer = 0
i = 1

function monsters.spawner(dt)
	monsters.spawn.timer = monsters.spawn.timer + dt
	if (monsters.spawn.timer > monsters.spawn.speed) then
		monsters.create(love.math.random(monsters.spawn.min, monsters.spawn.max), 410, "slime")
		monsters.spawn.timer = 0
	end
	if ((love.timer.getTime() - startTime) > i) then
		i = i + 10
		monsters.spawn.speed = monsters.spawn.speed / 2
	end
end

function monsters.kill(monster)
	if (monster.isAlive) then
		monster.isAlive = false
		monster.isDying = true
		score.add()
	end
end

function monsters.move(dt, monster)
	if (player.isAlive) then
		if (math.abs(monster.x - player.x) > 20) then
			monster.isRunning = true
			if (monster.x > player.x) then
				monster.x = monster.x - (100 * dt)
				monster.isFacing = 1
			else
				monster.x = monster.x + (100 * dt)
				monster.isFacing = -1
			end
		else
			monster.isRunning = false
		end
	end
end

function monsters.attack(dt, monster)
	if (monster.attackTimer < 2 and monster.attackPermission == false) then
		monster.attackTimer = monster.attackTimer + dt
	end
	if (monster.attackTimer >= 2) then
		monster.attackTimer = 0
		monster.attackPermission = true
	end
	if (math.abs(monster.x - player.x) <= 20 and monster.attackPermission and player.isAlive) then
		monster.isAttacking = true
		monster.attackPermission = false
	end
end

function monsters.ia(dt, monster)
	if (dev.move == false) then
		monsters.move(dt, monster)
	end
	monsters.attack(dt, monster)
end

function monsters.update(dt)
	if (dev.spawn == false) then
		monsters.spawner(dt)
	end
	for i,monster in ipairs(monsters.list) do
		monsters.ia(dt, monster)
		if (monster.type == "slime") then
			slimes.addHurtbox(monster)
			slimes.addHitbox(monster)
			slimes.update(dt, monster)
		end
	end
end

function monsters.drawHurtbox(monster)
		love.graphics.setColor(0, 0, 1, 1)
			love.graphics.rectangle("line", monster.hurtbox.x, monster.hurtbox.y, monster.hurtbox.width, monster.hurtbox.height)
		love.graphics.setColor(1, 1, 1, 1)
end

function monsters.drawHitbox(monster)
		love.graphics.setColor(1, 0, 0, 1)
			love.graphics.rectangle("line", monster.hitbox.x, monster.hitbox.y, monster.hitbox.width, monster.hitbox.height)
		love.graphics.setColor(1, 1, 1, 1)
end

function monsters.draw()
	for i,monster in ipairs(monsters.list) do
		if (monster.isAlive) then
			if (dev.boxes) then
				monsters.drawHurtbox(monster)
				monsters.drawHitbox(monster)
			end
			if (monster.isAttacking == true) then
				local roundedFrame = math.floor(monster.attackFrame)
				love.graphics.draw(monster.img, monster.attackframes[roundedFrame], monster.x, monster.y, 0, (monster.isFacing * 2), 2, monster.width / 2, monster.height / 2)
			elseif (monster.isRunning == false) then
				local roundedFrame = math.floor(monster.idleFrame)
				love.graphics.draw(monster.img, monster.idleframes[roundedFrame], monster.x, monster.y, 0, (monster.isFacing * 2), 2, monster.width / 2, monster.height / 2)
			else
				local roundedFrame = math.floor(monster.moveFrame)
				love.graphics.draw(monster.img, monster.moveframes[roundedFrame], monster.x, monster.y, 0, (monster.isFacing * 2), 2, monster.width / 2, monster.height / 2)

			end
		elseif (monster.isDying == true) then
			local roundedFrame = math.floor(monster.dieFrame)
			love.graphics.draw(monster.img, monster.dieframes[roundedFrame], monster.x, monster.y, 0, (monster.isFacing * 2), 2, monster.width / 2, monster.height / 2)
		end
	end
end

return monsters
