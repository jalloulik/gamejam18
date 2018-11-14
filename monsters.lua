local slimes = require("slime")
local player = require("player")
local score = require("score")

local monsters = {}
monsters.list = {}
monsters.spawn = {}
monsters.spawn.timer = 0
monsters.spawn.min = 100
monsters.spawn.max = 700
global_id = 0

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

function monsters.spawner(dt)
	monsters.spawn.timer = monsters.spawn.timer + dt
	if (monsters.spawn.timer > 1) then
		monsters.create(love.math.random(monsters.spawn.min, monsters.spawn.max), 410, "slime")
		monsters.spawn.timer = 0
	end
end

function monsters.kill(monster)
	if (monster.isAlive) then
		monster.isAlive = false
		monster.isDying = true
		score.add()
	end
end

function monsters.move(monster)
	if (math.abs(monster.x - player.x) > 20) then
		monster.isRunning = true
		if (monster.x > player.x) then
			monster.x = monster.x - 1
			monster.isFacing = 1
		else
			monster.x = monster.x + 1
			monster.isFacing = -1
		end
	else
		monster.isRunning = false
	end
end

function monsters.ia(monster)
	monsters.move(monster)
end
i = 0
function monsters.update(dt)
	monsters.spawner(dt)
	for i,monster in ipairs(monsters.list) do
		monsters.ia(monster)
		if (monster.type == "slime") then
			slimes.addHurtbox(monster)
			slimes.update(dt, monster)
		end
	end
end

function monsters.drawHurtbox(monster)
		love.graphics.setColor(0, 0, 1, 1)
			love.graphics.rectangle("line", monster.hurtbox.x, monster.hurtbox.y, monster.hurtbox.width, monster.hurtbox.height)
		love.graphics.setColor(1, 1, 1, 1)
end

function monsters.draw()
	for i,monster in ipairs(monsters.list) do
		if (monster.isAlive) then
			if (monster.isRunning == false) then
				local roundedFrame = math.floor(monster.idleFrame)
				love.graphics.draw(monster.img, monster.idleframes[roundedFrame], monster.x, monster.y, 0, (monster.isFacing * 2), 2, monster.width / 2, monster.height / 2)
				monsters.drawHurtbox(monster)
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
