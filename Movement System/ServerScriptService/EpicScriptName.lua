-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")

-- Requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local Map = require(ReplicatedStorage:WaitForChild("Map"))
local Player = require(ReplicatedStorage:WaitForChild("Player"))
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))

-- Script
local myGame = GameHandler.New()
local testMap = Map:New(Vector3.new(0, 4, 0), Vector3.new(10, 4, 10))
testMap:Build("test")
testMap:ShowDebug()

myGame:AssignMap(testMap)

---------------------
local myGame2 = GameHandler.New()
local testMap2 = Map:New(Vector3.new(0, 4, 100), Vector3.new(3, 3, 3))
testMap2:Build("123")
testMap2:ShowDebug()

myGame2:AssignMap(testMap2)


PlayersService.PlayerAdded:Connect(function(player)
	local player = Player.New(player)
	player.Character.HumanoidRootPart.Anchored = true
	myGame:AddPlayer(player)
	player.Position = {
		x = 1,
		y = 2,
		z = 2
	}
	task.wait(2)
	player:MoveTo(1, 2, 4)
	task.wait(3)
	player:Move("Front")
	task.wait(1)
	player:Move("Right")
	task.wait(1)
	player:Move("Front")
end)

local myObject = Object.New("Water")
testMap:SetCell(1, 1, 1, myObject)
print(myObject:GetNeighbours())
