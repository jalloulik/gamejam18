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

return tools
