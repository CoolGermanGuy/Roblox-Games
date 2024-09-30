-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))
local Player = require(ReplicatedStorage:WaitForChild("Player"))
local Utils = require(ReplicatedStorage:WaitForChild("Utils"))

script.Parent.MouseClick:Connect(function(player)
	local player = Player:GetPlayer(player)
	local game1 = GameHandler.GetGame(1)
	game1:AddPlayer(player)
	player:MoveTo(1, 2, 5)
	ReplicatedStorage.RemoteEvents.ToggleMovement:FireClient(player.Player, false)
end)
