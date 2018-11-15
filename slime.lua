local slimes = {}
slimes.list = {}
slimes.img = love.graphics.newImage("Assets/Sprites/slime/slime-Sheet.png");

function slimes.create(monster)
	monster.img = slimes.img
	monster.width = 32
	monster.height = 25
end

function slimes.init(monster)
	slimes.IdleInit(monster)
	slimes.MovingInit(monster)
	slimes.DieInit(monster)
	slimes.AttackInit(monster)
end

function slimes.IdleInit(monster)
	monster.idle = {}
	monster.idleFrame = 1
	monster.idleframes = {}
	for i = 0, 3, 1
	do
		monster.idleframes[i + 1] = love.graphics.newQuad(i * monster.width, 0 * monster.height, monster.width, monster.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.MovingInit(monster)
	monster.move = {}
	monster.moveFrame = 1
	monster.moveframes = {}
	for i = 0, 3, 1
	do
		monster.moveframes[i + 1] = love.graphics.newQuad((4 + i) * monster.width, 0 * monster.height, monster.width, monster.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.AttackInit(monster)
	monster.attack = {}
	monster.attackFrame = 1
	monster.attackframes = {}
	for i = 0, 3, 1
	do
		monster.attackframes[i + 1] = love.graphics.newQuad(i * monster.width, 1 * monster.height, monster.width, monster.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.DieInit(monster)
	monster.die = {}
	monster.dieFrame = 1
	monster.dieframes = {}
	for i = 0, 4, 1
	do
		monster.dieframes[i + 1] = love.graphics.newQuad(i * monster.width, 2 * monster.height, monster.width, monster.height, slimes.img:getWidth(), slimes.img:getHeight())
	end
end

function slimes.update(dt, monster)
	slimes.frameAnimation(dt, monster)
end

function slimes.frameAnimation(dt, monster)
	monster.idleFrame = monster.idleFrame + 6 * dt
	monster.moveFrame = monster.moveFrame + 11 * dt

	if (monster.isAttacking == true) then
		monster.attackFrame = monster.attackFrame + 8 * dt
	end
	if (monster.idleFrame >= #monster.idleframes + 1) then
		monster.idleFrame = 1;
	end
	if (monster.moveFrame >= #monster.moveframes + 1) then
		monster.moveFrame = 1;
	end
	if (love.keyboard.isDown("x") and monster.isAlive) then
		monster.isAlive = false
		monster.isDying = true
	end
	if (monster.isAlive == false and monster.isDying == true) then
		monster.dieFrame = monster.dieFrame + 12 * dt
	end
	if (monster.dieFrame >= #monster.dieframes + 1) then
		monster.isDying = false
		monster.dieFrame = 1;
	end
	if (monster.attackFrame >= #monster.attackframes + 1) then
		monster.attackFrame = 1
		monster.isAttacking = false
	end
end

function slimes.addHurtbox(monster)
	monster.hurtbox = {}
	monster.hurtbox.x = monster.x - monster.width + 12
	monster.hurtbox.y = monster.y - monster.height + 20
	monster.hurtbox.width = (monster.width - 10) * 2
	monster.hurtbox.height = (monster.height - 10) * 2
end

function slimes.addHitbox(monster)
	monster.hitbox = {}
	if (monster.isFacing == 1) then
		monster.hitbox.x = monster.x - monster.width + 2
		monster.hitbox.y = monster.y - monster.height + 10
	else
		monster.hitbox.x = monster.x - monster.width + 24
		monster.hitbox.y = monster.y - monster.height + 10
	end
	monster.hitbox.width = (monster.width - 13) * 2
	monster.hitbox.height = (monster.height - 5) * 2
end

return slimes
