-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local Map = require(ReplicatedStorage:WaitForChild("Map"))

local testMap = Map:New(Vector3.new(10, 4, 10))
print(testMap)

testMap:Build("test")

print(testMap)

task.wait(2)
testMap:ShowDebug()

task.wait(5)
testMap:HideDebug()
