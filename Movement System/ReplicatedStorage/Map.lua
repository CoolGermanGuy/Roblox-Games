-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))

-- Init
local Map = {}
Map.__index = Map
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
				newMap[x][y][z] = {}
				newMap[x][y][z].Position = Vector3.new(size.X + (8*x), size.Y + (8*y), size.Z + (8*z))
				--newMap[x][y][z].Part = Object.Init("Air", Vector3.new(size.X + (8*x), size.Y + (8*y), size.Z + (8*z)), {})
				--newMap:SetObject(x, y, z, Object:New("Air", {}))
				newMap[x][y][z].Part = Object:New("Air", {})
			end
		end
	end
	setmetatable(newMap, Map)
	return newMap
end

-- Functions
function Map:SetObject(x: int, y: int, z: int, Object: Object)
	print(self[x][y][z].Position)
	Object.Position = self[x][y][z].Position
	Object.Part.Position = Object.Position
	self[x][y][z].Part = Object
end

return Map
