local tools = require("tools")
local dev = require("dev")

local player = {}
player.x = 172
player.y = 410
player.isRunning = false
player.isAttacking = false
player.isFacing = 1
player.isAlive = true
player.isDying = false
player.attackPermission = true
player.attackTimer = 0

function player.init()
	player.idleInit()
	player.runningInit()
	player.attackInit()
	player.dieInit()
	player.deadInit()
end

function player.idleInit()
	player.idle = {}
	player.idle.img = love.graphics.newImage("Assets/Sprites/adventurer/idle.png")
	player.idleFrame = 1
	player.idleframes = {}
	player.idle.width = 32
	player.idle.height = 36
	for i = 0, 3, 1
	do
		player.idleframes[i + 1] = love.graphics.newQuad(i * player.idle.width, 0, player.idle.width, player.idle.height, player.idle.img:getWidth(), player.idle.img:getHeight())
	end
end

function player.runningInit()
	player.run = {}
	player.run.img = love.graphics.newImage("Assets/Sprites/adventurer/run.png")
	player.run.width = 22.5
	player.run.height = 30
	player.runFrame = 1
	player.runframes = {}
	for i = 0, 5, 1
	do
		player.runframes[i + 1] = love.graphics.newQuad(i * 22.5, 0, 22.5, 30, player.run.img:getWidth(), player.run.img:getHeight())
	end
end

function player.attackInit()
	player.attack = {}
	player.attack.sound = love.audio.newSource("Assets/Sfx/SwordSwing.mp3", "static")
	player.attackFrame = 1
	player.attack.width = 50
	player.attack.height = 37
	player.attack.img = tools.create_anime("Assets/Sprites/adventurer/attack/attack1-", 0, 4)

	player.attack2Frame = 1
	player.attack.img2 = tools.create_anime("Assets/Sprites/adventurer/attack/attack2-", 0, 5)

	player.attack3Frame = 1
	player.attack.img3 = tools.create_anime("Assets/Sprites/adventurer/attack/attack3-", 0, 5)
end

function player.dieInit()
	player.die = {}
	player.dieFrame = 1
	player.die.width = 50
	player.die.height = 37
	player.die.img = tools.create_anime("Assets/Sprites/adventurer/die/adventurer-die-", 0, 6)
end

function player.deadInit()
	player.dead = {}
	player.deadFrame = 1
	player.dead.width = 50
	player.dead.height = 37
	player.dead.img = tools.create_anime("Assets/Sprites/adventurer/die/adventurer-die-", 4, 2)
end

function player.update(dt)
	player.frameAnimation(dt)
	player.attackLaunch(dt)
end

function player.attackSound()
	love.audio.stop(player.attack.sound);
	love.audio.play(player.attack.sound);
end

function player.attackLaunch(dt)
	if (player.attackTimer < 0.7 and player.attackPermission == false) then
		player.attackTimer = player.attackTimer + dt
	end
	if (player.attackTimer >= 0.7) then
		player.attackTimer = 0
		player.attackPermission = true
	end
	if (love.keyboard.isDown("space") and player.isAlive and player.isAttacking == false and player.attackPermission) then
		player.isAttacking = true
		player.attackPermission = false
	end
	if (player.attackFrame >= #player.attack.img + 1) then
		player.attackFrame = 1
		player.isAttacking = false
	end
end

function player.kill()
	if (player.isAlive) then
		player.isAlive = false
		player.isDying = true
	end
end

function player.attackAnimation(dt)
	if (player.isAttacking == true) then
		if (player.isAttacking == false) then
			player.attackSound()
		end
		player.attackFrame = player.attackFrame + 14 * dt
	end
end

function player.runningAnimation(dt)
	if (love.keyboard.isDown("d")) then
		if (player.isFacing == RIGHT) then
			player.x = player.x + (220 * dt)
		end
		if (player.isAttacking == false) then
			player.isRunning = true
		end
		player.isFacing = RIGHT
	elseif (love.keyboard.isDown("a")) then
		if (player.isFacing == LEFT) then
			player.x = player.x - (220 * dt)
		end
		if (player.isAttacking == false) then
			player.isRunning = true
		end
		player.isFacing = LEFT
	else
		player.isRunning = false
	end
	if (player.runFrame >= #player.runframes + 1) then
		player.runFrame = 1
	end
	if (player.idleFrame >= #player.idleframes + 1) then
		player.idleFrame = 1
	end
end

function player.dieAnimation(dt)
	if (player.isAlive == false and player.isDying == true) then
		player.dieFrame = player.dieFrame + 12 * dt
	end
	if (player.dieFrame >= #player.die.img + 1) then
		player.isDying = false
		player.dieFrame = 1
	end
	if (player.isAlive == false and player.isDying == false) then
		player.deadFrame = player.deadFrame + 3 * dt
	end
	if (player.deadFrame >= #player.dead.img + 1) then
		player.deadFrame = 1
	end
end

function player.frameAnimation(dt)
	player.idleFrame = player.idleFrame + 6 * dt
	player.runFrame = player.runFrame + 9 * dt
	if (player.isAlive) then
		player.attackAnimation(dt)
		player.runningAnimation(dt)
	end
	player.dieAnimation(dt)
end

function player.addHurtbox()
	player.hurtbox = {}
	if (player.isFacing == 1) then
		player.hurtbox.x = player.x - player.idle.width + 18
		player.hurtbox.y = player.y - player.idle.height + 6
	else
		player.hurtbox.x = player.x - player.idle.width + 12
		player.hurtbox.y = player.y - player.idle.height + 6
	end
	player.hurtbox.width = (player.idle.width - 14) * 2
	player.hurtbox.height = (player.idle.height - 8) * 2
	return player.hurtbox
end

function player.hurtboxdraw()
	love.graphics.setColor(0, 0, 1, 1)
	love.graphics.rectangle("line", player.hurtbox.x, player.hurtbox.y, player.hurtbox.width, player.hurtbox.height)
	love.graphics.setColor(1, 1, 1, 1)
end

function player.addHitbox()
	player.hitbox = {}

	if (player.isFacing == 1) then
		player.hitbox.x = player.x - player.idle.width + 45
		player.hitbox.y = player.y - player.idle.height - 4
	else
		player.hitbox.x = player.x - player.idle.width - 18
		player.hitbox.y = player.y - player.idle.height - 4
	end
	player.hitbox.width = (player.idle.width - 14) * 2
	player.hitbox.height = (player.idle.height - 0) * 2
	return player.hitbox
end

function player.hitboxdraw()
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.rectangle("line", player.hitbox.x, player.hitbox.y, (player.idle.width - 14) * 2, (player.idle.height - 0) * 2)
	love.graphics.setColor(1, 1, 1, 1)
end

function player.attackDraw()
	local roundedFrame = math.floor(player.attackFrame)
	love.graphics.draw(player.attack.img[roundedFrame], player.x, player.y - 8, 0, (player.isFacing * 2), 2, player.attack.width / 2, player.attack.height / 2)
end

function player.runDraw()
	local roundedFrame = math.floor(player.runFrame)
		love.graphics.draw(player.run.img, player.runframes[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.run.width / 2, player.run.height / 2)
end

function player.idleDraw()
	local roundedFrame = math.floor(player.idleFrame)
	love.graphics.draw(player.idle.img, player.idleframes[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.idle.width / 2, player.idle.height / 2)
end

function player.dieDraw()
	local roundedFrame = math.floor(player.dieFrame)
	love.graphics.draw(player.die.img[roundedFrame], player.x, player.y - 8, 0, (player.isFacing * 2), 2, player.die.width / 2, player.die.height / 2)
end

function player.deadDraw()
	local roundedFrame = math.floor(player.deadFrame)
	love.graphics.draw(player.dead.img[roundedFrame], player.x, player.y - 8, 0, (player.isFacing * 2), 2, player.dead.width / 2, player.dead.height / 2)
end

function player.draw()
	if (player.isAlive) then
		if (player.isAttacking == true) then
			player.attackDraw()
		elseif (player.isRunning == true) then
			player.runDraw()
		else
			player.idleDraw()
		end
	elseif (player.isDying) then
		player.dieDraw()
	else
		player.deadDraw()
	end
	if (dev.boxes) then
		player.hurtboxdraw()
		player.hitboxdraw()
	end
end

return player
