-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

RIGHT = 1
LEFT = -1

background = love.graphics.newImage("Assets/Backgrounds/emergency.png")
window = {}
window.width = 720
window.height = 480
player = {}
player.x = 172
player.y = 410
player.isRunning = false
player.isAttacking = false
player.isFacing = 1
slime = {}
slime.img = love.graphics.newImage("Assets/Sprites/slime/slime-Sheet.png");
slime.width = 32
slime.height = 25
slime.x = 600
slime.y = 410
slime.isAlive = true
slime.isDying = false

function attackSound()

end

function slimeIdleInit()
	slime.idle = {}
	slime.idleFrame = 1
	slime.idleframes = {}
	for i = 0, 3, 1
	do
		slime.idleframes[i + 1] = love.graphics.newQuad(i * slime.width, 0 * slime.height, slime.width, slime.height, slime.img:getWidth(), slime.img:getHeight())
	end
end

function slimeMovingInit()
	slime.move = {}
	slime.moveFrame = 1
	slime.moveframes = {}
	for i = 0, 3, 1
	do
		slime.moveframes[i + 1] = love.graphics.newQuad((4 + i) * slime.width, 0 * slime.height, slime.width, slime.height, slime.img:getWidth(), slime.img:getHeight())
	end
end

function slimeDieInit()
	slime.die = {}
	slime.dieFrame = 1
	slime.dieframes = {}
	for i = 0, 4, 1
	do
		slime.dieframes[i + 1] = love.graphics.newQuad(i * slime.width, 2 * slime.height, slime.width, slime.height, slime.img:getWidth(), slime.img:getHeight())
	end
end

function idleInit()
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

function runningInit()
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

function attackInit()
	player.attack = {}
	player.attack.sound = love.audio.newSource("Assets/Sfx/SwordSwing.mp3", "static")
	player.attackFrame = 1
	player.attack.width = 50
	player.attack.height = 37
	player.attack.img = {}
	player.attack.img[1] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack1-00.png")
	player.attack.img[2] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack1-01.png")
	player.attack.img[3] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack1-02.png")
	player.attack.img[4] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack1-03.png")
	player.attack.img[5] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack1-04.png")

	player.attack2Frame = 1
	player.attack.img2 = {}
	player.attack.img2[1] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack2-00.png")
	player.attack.img2[2] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack2-01.png")
	player.attack.img2[3] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack2-02.png")
	player.attack.img2[4] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack2-03.png")
	player.attack.img2[5] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack2-04.png")
	player.attack.img2[6] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack2-05.png")

	player.attack3Frame = 1
	player.attack.img3 = {}
	player.attack.img3[1] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack3-00.png")
	player.attack.img3[2] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack3-01.png")
	player.attack.img3[3] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack3-02.png")
	player.attack.img3[4] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack3-03.png")
	player.attack.img3[5] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack3-04.png")
	player.attack.img3[6] = love.graphics.newImage("Assets/Sprites/adventurer/attack/attack3-05.png")
end

function love.load()
	love.window.setMode(window.width, window.height)
	idleInit()
	runningInit()
	attackInit()
	slimeIdleInit()
	slimeMovingInit()
	slimeDieInit()
end

function love.update(dt)
	-- slime
	slime.idleFrame = slime.idleFrame + 6 * dt
	slime.moveFrame = slime.moveFrame + 11 * dt
	-- player
	player.idleFrame = player.idleFrame + 6 * dt
	player.runFrame = player.runFrame + 9 * dt
	if (slime.idleFrame >= #slime.idleframes + 1) then
		slime.idleFrame = 1;
	end
	if (slime.moveFrame >= #slime.moveframes + 1) then
		slime.moveFrame = 1;
	end
	if (love.keyboard.isDown("x") and slime.isAlive) then
		slime.isAlive = false
		slime.isDying = true
	end
	if (slime.isAlive == false and slime.isDying == true) then
		slime.dieFrame = slime.dieFrame + 5 * dt
	end
	if (slime.dieFrame >= #slime.dieframes + 1) then
		slime.isDying = false
		slime.dieFrame = 1;
	end
	if (love.keyboard.isDown("space") or player.isAttacking == true) then
		if (player.isAttacking == false) then
			love.audio.stop(player.attack.sound);
			love.audio.play(player.attack.sound);
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

function love.draw()
	love.graphics.draw(background, 0, 0, 0, 3, 3)
	if (slime.isAlive) then
		local roundedFrame = math.floor(slime.idleFrame)
		love.graphics.draw(slime.img, slime.idleframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
	elseif (slime.isDying == true) then
		local roundedFrame = math.floor(slime.dieFrame)
		love.graphics.draw(slime.img, slime.dieframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
	end
	-- local roundedFrame = math.floor(slime.moveFrame)
	-- love.graphics.draw(slime.img, slime.moveframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
	-- local roundedFrame = math.floor(slime.dieFrame)
	-- love.graphics.draw(slime.img, slime.dieframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
	if (player.isAttacking == true) then
		local roundedFrame = math.floor(player.attackFrame)
		love.graphics.draw(player.attack.img[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.attack.width / 2, player.attack.height / 2)
	elseif (player.isRunning == true) then
		local roundedFrame = math.floor(player.runFrame)
			love.graphics.draw(player.run.img, player.runframes[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.run.width / 2, player.run.height / 2)
	else
		local roundedFrame = math.floor(player.idleFrame)
		love.graphics.draw(player.idle.img, player.idleframes[roundedFrame], player.x, player.y, 0, (player.isFacing * 2), 2, player.idle.width / 2, player.idle.height / 2)
	end
	love.graphics.rectangle("line", player.x - player.idle.width, player.y - player.idle.height, player.idle.width * 2, player.idle.height * 2)

end

function love.keypressed(key)
	if (key == "escape") then
		love.event.quit()
	end
end
