-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local Map = require(ReplicatedStorage:WaitForChild("Map"))

local testMap = Map:New(Vector3.new(0, 0, 0), Vector3.new(10, 4, 10))
testMap:Build("test")

local testMap2 = Map:New(Vector3.new(0, 0, 100), Vector3.new(10, 4, 10))
testMap2:Build("test")

task.wait(2)
testMap:SetCell(1, 4, 10, Object.New("Water"))
testMap2:SetCell(1, 4, 10, Object.New("Water"))
