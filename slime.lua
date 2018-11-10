local slime = {}
slime.img = love.graphics.newImage("Assets/Sprites/slime/slime-Sheet.png");
slime.width = 32
slime.height = 25
slime.x = 600
slime.y = 410
slime.isAlive = true
slime.isDying = false

function slime.init()
	slime.IdleInit()
	slime.MovingInit()
	slime.DieInit()
end

function slime.IdleInit()
	slime.idle = {}
	slime.idleFrame = 1
	slime.idleframes = {}
	for i = 0, 3, 1
	do
		slime.idleframes[i + 1] = love.graphics.newQuad(i * slime.width, 0 * slime.height, slime.width, slime.height, slime.img:getWidth(), slime.img:getHeight())
	end
end

function slime.MovingInit()
	slime.move = {}
	slime.moveFrame = 1
	slime.moveframes = {}
	for i = 0, 3, 1
	do
		slime.moveframes[i + 1] = love.graphics.newQuad((4 + i) * slime.width, 0 * slime.height, slime.width, slime.height, slime.img:getWidth(), slime.img:getHeight())
	end
end

function slime.DieInit()
	slime.die = {}
	slime.dieFrame = 1
	slime.dieframes = {}
	for i = 0, 4, 1
	do
		slime.dieframes[i + 1] = love.graphics.newQuad(i * slime.width, 2 * slime.height, slime.width, slime.height, slime.img:getWidth(), slime.img:getHeight())
	end
end

function slime.frameAnimation(dt)
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

function slime.draw()
	if (slime.isAlive) then
		-- local roundedFrame = math.floor(slime.idleFrame)
		-- love.graphics.draw(slime.img, slime.idleframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
		local roundedFrame = math.floor(slime.moveFrame)
		love.graphics.draw(slime.img, slime.moveframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
	elseif (slime.isDying == true) then
		local roundedFrame = math.floor(slime.dieFrame)
		love.graphics.draw(slime.img, slime.dieframes[roundedFrame], slime.x, slime.y, 0, 2, 2, slime.width / 2, slime.height / 2)
	end

end

return slime
