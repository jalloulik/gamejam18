local menu = {}

menu.font = love.graphics.setNewFont("Assets/Font/Amatic-Bold.ttf", 36)

local ui = require("ui")

function menu.load(window)
	menuName = ui.newButton(window.width / 2 - 50, window.height / 2 - 120, 100, 50, "MENU", menu.font)
	continue = ui.newButton(window.width / 2 - 50, window.height / 2 - 70, 100, 50, "Continue", menu.font)
	newGame = ui.newButton(window.width / 2 - 50, window.height / 2 - 20, 100, 50, "New Game", menu.font)
	exitGame = ui.newButton(window.width / 2 - 50, window.height / 2 + 30, 100, 50, "Exit", menu.font)
	groupTest = ui.newGroup()
	groupTest:addElement(menuName)
	groupTest:addElement(continue)
	groupTest:addElement(newGame)
	groupTest:addElement(exitGame)
end

function menu.update(dt, inGame)
	groupTest:update(dt)
end

function menu.draw()
	love.graphics.setBackgroundColor(0, 0, 0)
	groupTest:draw()
end

return menu