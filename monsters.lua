local monsters = {}
monsters.list = {}
local slimes = require("slime")
local player = require("player")

global_id = 0

monsters.hurtboxes = {}

function monsters.create(posx, posy, type)
	global_id = global_id + 1
	local monster = {}
	monster.id = global_id
	monster.x = posx
	monster.y = posy
	monster.isAlive = true
	monster.isDying = false
	monster.width = 30
	monster.height = 30
	monster.type = type
	if (monster.type == "slime") then
		slimes.create(monster)
		slimes.init(monster)
	end
	table.insert(monsters.list, monster)
end

function monsters.spawn()
	monsters.create(600, 410, "slime")
	monsters.create(400, 410, "slime")
end

function monsters.kill(monster)
	if (monster.isAlive) then
		monster.isAlive = false
		monster.isDying = true
	end
end

function monsters.update(dt)
	for i,monster in ipairs(monsters.list) do
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
			local roundedFrame = math.floor(monster.idleFrame)
			love.graphics.draw(monster.img, monster.idleframes[roundedFrame], monster.x, monster.y, 0, 2, 2, monster.width / 2, monster.height / 2)
			monsters.drawHurtbox(monster)
			-- local roundedFrame = math.floor(slime.moveFrame)
			-- love.graphics.draw(slime.img, slime.moveframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
		elseif (monster.isDying == true) then
			local roundedFrame = math.floor(monster.dieFrame)
			love.graphics.draw(monster.img, monster.dieframes[roundedFrame], monster.x, monster.y, 0, 2, 2, monster.width / 2, monster.height / 2)
		end
	end

end

return monsters
