local score = {}

score.value = 0

function score.get()
	return score.value
end

function score.add()
	score.value = score.value + 1
end

function score.draw()
	love.graphics.print("Kills : "..score.get(), 600, 50, 0, 2, 2)
end

return score