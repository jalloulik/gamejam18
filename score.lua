local score = {}

score.value = 0
score.damageTaken = 0

function score.get()
	return score.value
end

function score.add()
	score.value = score.value + 1
end

function score.damageAdd()
	score.damageTaken = score.damageTaken + 1
end

function score.draw()
	love.graphics.print("Kills : "..score.get(), 600, 50, 0, 2, 2)
	love.graphics.print("Damage taken : "..score.damageTaken, 100, 50, 0, 2, 2)
end

return score
