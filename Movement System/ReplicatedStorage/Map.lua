-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))

-- Init
local Map = {}
Map.__index = Map

-- New
function Map:New(size: Vector3)
	local newMap = {}
	newMap.Size = size
	-- init map
	for x = 1, size.X do
		newMap[x] = {}
		for y = 1, size.Y do
			newMap[x][y] = {}
			for z = 1, size.Z do
				newMap[x][y][z] = {}
			end
		end
	end
	setmetatable(newMap, Map)
	return newMap
end

-- Methods
function Map:GetPosition(x: int, y: int, z: int)
	return Vector3.new(self.Size.X + (8*x), self.Size.Y + (8*y), self.Size.Z + (8*z))
end

function Map:SetCell(x: int, y: int, z: int, Object: Object)
	self[x][y][z] = Object
	Object.Part.Position = self:GetPosition(x, y, z)
end

function Map:Build(version: string)
	if version == "test" then
		-- big ass code bullshit
		for i = 1, 10, 1 do
			self:SetCell(i, 1, 1, Object.New("Grass"))
		end
		
		-- bullshit end
	else
		print("yeah no")
	end
end

return Map
