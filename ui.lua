local ui = {}

function ui.newGroup()
	local myGroup = {}
	myGroup.elements = {}

	function myGroup:addElement(pElement)
		table.insert(self.elements, pElement)
	end

	function myGroup:setVisible(pVisible)
		for n, v in pairs(myGroup.elements) do
			v:setVisible(pvisible)
		end
	end

	function myGroup:draw()
		love.graphics.push()
		for n, v in pairs(myGroup.elements) do
			v:draw()
		end
		love.graphics.pop()
	end
	return myGroup
end

local function newElement(pX, pY)
	local myElement = {}
	myElement.X = pX
	myElement.Y = pY
	myElement.Visible = true
	
	function myElement:draw()
		print("newElement / draw / Not implemented")
	end
	function myElement:setVisible(pVisible)
		self.Visible = pVisible
	end
	return myElement
end

function ui.newPanel(pX, pY, pW, pH)
	local myPanel = newElement(pX, pY)
	myPanel.W = pW
	myPanel.H = pH
	myPanel.Image = nil

	function myPanel:setImage(pImage)
		self.Image = pImage
		self.W = pImage:getWidth()
		self.H = pImage:getHeight()
	end

	function myPanel:drawPanel()
		love.graphics.setColor(1, 1, 1)
		if self.Image == nil then
			love.graphics.rectangle("fill", self.X, self.Y, self.W, self.H)
		else
			love.graphics.draw(self.Image, self.X, self.Y, sefl.W, self.H)
		end
	end

	function myPanel:draw()
		if self.Visible == false then return end
		self:drawPanel()
	end
	return myPanel
end

function ui.newText(pX, pY, pW, pH, pText, pFont, pHAlign, pVAlign)
	local myText = ui.newPanel(pX, pY, pW, pH)
	myText.Text = pText
	myText.Font = pFont
	myText.TextW = pFont:getWidth(pText)
	myText.TextH = pFont:getHeight(pText)
	myText.HAlign = pHAlign
	myText.VAlign = pVAlign

	function myText:drawText()
		love.graphics.setColor(0.5, 0.5, 0.5)
		love.graphics.setFont(self.Font)
		local x = self.X
		local y = self.Y
		if self.HAlign == "center" then
			x = x + ((self.W - self.TextW) / 2)
		end
		if self.VAlign == "center" then
			y = y + ((self.H - self.TextH) / 2)
		end
		love.graphics.print(self.Text, x, y)
	end

	function myText:draw()
		if self.Visible == false then return end
		self:drawText()
	end
	return myText
end

return ui