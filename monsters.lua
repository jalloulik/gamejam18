local monsters = {}
local slimes = require("slime")

function monsters.spawn()
	monsters.create()
	monsters.init()
end

function monsters.create()
	slimes.create(600, 410)
	slimes.create(500, 411)
end

function monsters.init()
	slimes.init()
end

function monsters.update(dt)
	slimes.update(dt)
end

function monsters.draw()
	slimes.draw()
end

return monsters
