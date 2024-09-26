-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local Map = require(ReplicatedStorage:WaitForChild("Map"))

local testMap = Map:New(Vector3.new(0, 4, 0), Vector3.new(10, 4, 10))
testMap:Build("test")
testMap:ShowDebug()

print(testMap.Position)
print("1 1 1", testMap:GetPosition(1, 1, 1))
print("1 1 2", testMap:GetPosition(1, 1, 2))
print("2 2 2", testMap:GetPosition(2, 2, 2))
