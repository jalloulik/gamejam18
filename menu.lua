local menu = {}

menu.font = love.graphics.setNewFont("Assets/Font/Amatic-Bold.ttf", 36)

local ui = require("ui")

function menu.load(window)
	menuName = ui.newText(window.width / 2 - 50, window.height / 2 - 100, 100, 50, "MENU", menu.font, "center", "center")
	continue = ui.newText(window.width / 2 - 50, window.height / 2 - 70, 100, 50, "Continue", menu.font, "center", "center")
	newGame = ui.newText(window.width / 2 - 50, window.height / 2 - 40, 100, 50, "New Game", menu.font, "center", "center")
	exitGame = ui.newText(window.width / 2 - 50, window.height / 2 - 10, 100, 50, "Exit", menu.font, "center", "center")
	groupTest = ui.newGroup()
	groupTest:addElement(menuName)
	groupTest:addElement(continue)
	groupTest:addElement(newGame)
	groupTest:addElement(exitGame)
end

function menu.update(inGame)
	continue:setVisible(inGame)
end

function menu.draw()
	love.graphics.setBackgroundColor(0, 0, 0)
	groupTest:draw()
end

return menu