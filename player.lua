local tools = require("tools")

local player = {}
player.x = 172
player.y = 410
player.isRunning = false
player.isAttacking = false
player.isFacing = 1

function player.init()
	player.idleInit()
	player.runningInit()
	player.attackInit()
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

function player.update(dt)
	player.frameAnimation(dt)
end

function player.attackSound()
	love.audio.stop(player.attack.sound);
	love.audio.play(player.attack.sound);
end

function player.frameAnimation(dt)
	player.idleFrame = player.idleFrame + 6 * dt
	player.runFrame = player.runFrame + 9 * dt

	if (love.keyboard.isDown("space") or player.isAttacking == true) then
		if (player.isAttacking == false) then
			player.attackSound()
		end
		player.attackFrame = player.attackFrame + 9 * dt
		player.isAttacking = true
	elseif (love.keyboard.isDown("d")) then
		if (player.isFacing == RIGHT) then
			player.x = player.x + 2
		end
		player.isRunning = true
		player.isFacing = RIGHT
	elseif (love.keyboard.isDown("a")) then
		if (player.isFacing == LEFT) then
			player.x = player.x - 2
		end
		player.isRunning = true
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
	if (player.attackFrame >= #player.attack.img + 1) then
		player.attackFrame = 1
		player.isAttacking = false
	end
end

function player.hurtbox()
	love.graphics.setColor(0, 0, 1, 1)
	if (player.isFacing == RIGHT) then
		love.graphics.rectangle("line", player.x - player.idle.width + 18, player.y - player.idle.height + 6, (player.idle.width - 14) * 2, (player.idle.height - 8) * 2)
	else
		love.graphics.rectangle("line", player.x - player.idle.width + 12, player.y - player.idle.height + 6, (player.idle.width - 14) * 2, (player.idle.height - 8) * 2)
	end
	love.graphics.setColor(1, 1, 1, 1)
end

function player.draw()
	if (player.isAttacking == true) then
		local roundedFrame = math.floor(player.attackFrame)
		love.graphics.draw(player.attack.img[roundedFrame], player.x, player.y - 8, 0, (player.isFacing * 2), 2, player.attack.width / 2, player.attack.height / 2)
	elseif (player.isRunning == true) then
		local roundedFrame = math.floor(player.runFrame)
			love.graphics.draw(player.run.img, player.runframes[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.run.width / 2, player.run.height / 2)
	else
		local roundedFrame = math.floor(player.idleFrame)
		love.graphics.draw(player.idle.img, player.idleframes[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.idle.width / 2, player.idle.height / 2)
	end
	player.hurtbox()
end

return player
