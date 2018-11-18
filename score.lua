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
	love.graphics.print("Kills : "..score.get(), 500, 50, 0, 2, 2)
	local health = 100 - score.damageTaken
	if health < 0 then
		health = 0
	end
	love.graphics.print("Health : "..health, 50, 50, 0, 2, 2)
	love.graphics.print("F1 to quit, F2 to restart", 500, 10, 0, 1, 1)
end

return score
