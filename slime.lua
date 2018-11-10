local slimes = {}
slimes.list = {}
slimes.img = love.graphics.newImage("Assets/Sprites/slime/slime-Sheet.png");

function slimes.create(posx, posy)
	local slime = {}
	slime.width = 32
	slime.height = 25
	slime.x = posx
	slime.y = posy
	slime.isAlive = true
	slime.isDying = false
	table.insert(slimes.list, slime)
	-- return slime
end

function slimes.init()
	for i,slime in ipairs(slimes.list) do
		slimes.IdleInit(slime)
	end
	for i,slime in ipairs(slimes.list) do
		slimes.MovingInit(slime)
	end
	for i,slime in ipairs(slimes.list) do
		slimes.DieInit(slime)
	end

end

function slimes.IdleInit(slime)
	slime.idle = {}
	slime.idleFrame = 1
	slime.idleframes = {}
	for i = 0, 3, 1
	do
		slime.idleframes[i + 1] = love.graphics.newQuad(i * slime.width, 0 * slime.height, slime.width, slime.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.MovingInit(slime)
	slime.move = {}
	slime.moveFrame = 1
	slime.moveframes = {}
	for i = 0, 3, 1
	do
		slime.moveframes[i + 1] = love.graphics.newQuad((4 + i) * slime.width, 0 * slime.height, slime.width, slime.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.DieInit(slime)
	slime.die = {}
	slime.dieFrame = 1
	slime.dieframes = {}
	for i = 0, 4, 1
	do
		slime.dieframes[i + 1] = love.graphics.newQuad(i * slime.width, 2 * slime.height, slime.width, slime.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.update(dt)
	for i,slime in ipairs(slimes.list) do
		slimes.frameAnimation(dt, slime)
	end
end

function slimes.frameAnimation(dt, slime)
	slime.idleFrame = slime.idleFrame + 6 * dt
	slime.moveFrame = slime.moveFrame + 11 * dt

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
end

function slimes.hurtbox(slime)
	slime.hurtbox = {}
	slime.hurtbox.x = slime.x - slime.width + 12
	slime.hurtbox.y = slime.y - slime.height + 20
	slime.hurtbox.width = (slime.width - 10) * 2
	slime.hurtbox.height = (slime.height - 10) * 2

	love.graphics.setColor(0, 0, 1, 1)
		love.graphics.rectangle("line", slime.hurtbox.x, slime.hurtbox.y, slime.hurtbox.width, slime.hurtbox.height)
	love.graphics.setColor(1, 1, 1, 1)
end

function slimes.draw()
	for i,slime in ipairs(slimes.list) do
		if (slime.isAlive) then
			local roundedFrame = math.floor(slime.idleFrame)
			love.graphics.draw(slimes.img, slime.idleframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
			slimes.hurtbox(slime)
			-- local roundedFrame = math.floor(slime.moveFrame)
			-- love.graphics.draw(slime.img, slime.moveframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
		elseif (slime.isDying == true) then
			local roundedFrame = math.floor(slime.dieFrame)
			love.graphics.draw(slimes.img, slime.dieframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
		end
	end
end

return slimes
