-- add 	local tools = require("tools")	 in file for use this class
local tools = {}

function tools.create_anime(name_frames_package, nb_frame_start, nb_frames)
	local container = {}
	for i = 0, nb_frames, 1 do
		if i < 10 then
			container[i + 1] = love.graphics.newImage(name_frames_package.."0"..tostring(i+nb_frame_start)..".png")
		else
			container[i + 1] = love.graphics.newImage(name_frames_package..tostring(i+nb_frame_start)..".png")
		end
	end
	return container
end

function tools.CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
		x2 < x1+w1 and
		y1 < y2+h2 and
		y2 < y1+h1
end

return tools
