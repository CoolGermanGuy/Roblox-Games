-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Requirements
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))

-- Init
local Utils = {}

-- Functions/Methods
function Utils:GetObjectPosition(x: number, y: number, z: number, instance)
	local map = GameHandler.GetMap(instance.GameIndex)
	-- doesn't work
	--return Vector3.new(self.Position.X + self.Size.X + (8*x), self.Position.Y + self.Size.Y + (8*y), self.Position.Z + self.Size.Z + (8*z))
	-- works
	--return Vector3.new(self.Position.X + self.Size.X + (8*x) - 18, self.Position.Y + self.Size.Y + (8*y) - 12, self.Position.Z + self.Size.Z + (8*z) - 18)
	-- doesn't work
	--return Vector3.new(self.Position.X + self.Size.X + (8*x), self.Position.Y + self.Size.Y + (8*y), self.Position.Z + self.Size.Z + (8*z)) - Vector3.new(18, 12, 18)
	-- works
	return map.Position + Vector3.new(8*x, 8*y, 8*z) - Vector3.new(8, 8, 8)
end


return Utils
