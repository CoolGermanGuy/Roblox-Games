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
local testMap2 = Map:New(Vector3.new(0, 4, 100), Vector3.new(10, 4, 10))
testMap2:Build("test")
testMap2:ShowDebug()

myGame2:AssignMap(testMap2)


PlayersService.PlayerAdded:Connect(function(player)
	local player = Player.New(player)
	myGame:AddPlayer(player)
	
	print(player:GetGame())
end)
