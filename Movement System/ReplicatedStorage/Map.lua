-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
local Object = require(ReplicatedStorage.Object)

-- Init
local Map = {}

-- New Map
function Map.New(size: Vector3)
	local newMap = {}
	size = size
	
	-- init map
	for x = 1, size.X do
		newMap[x] = {}
		for y = 1, size.Y do
			newMap[x][y] = {}
			for z = 1, size.Z do
				newMap[x][y][z] = {
					["position"] = Vector3.new(size.X + (8*x), size.Y + (8*y), size.Z + (8*z)),
					["part"] = Object.New("Air", Vector3.new(size.X + (8*x), size.Y + (8*y), size.Z + (8*z)), {}),
					--Object.New("Air", Vector3.new(size.X + (8*x), size.Y + (8*y), size.Z + (8*z)), {})
				}
			end
		end
	end
	setmetatable(newMap, Map)
	return newMap
end

return Map
