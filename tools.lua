-- add 	local tools = require("tools")	 in file for use this class
local tools = {}

function tools.create_anime(name_frames_package, nb_frame_start, nb_frame_end)
	local container = {}
	for i = nb_frame_start, nb_frame_end, 1 do
		if i < 10 then
			container[i] = love.graphics.newImage(name_frames_package.."0"..tostring(i)..".png")
		else
			container[i] = love.graphics.newImage(name_frames_package..tostring(i)..".png")
		end
	end
	return container
end

return tools