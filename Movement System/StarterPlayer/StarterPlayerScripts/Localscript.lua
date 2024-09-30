-- Services
local Runservice = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local PlayerModuleControls = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()

-- Disable Movement on RemoteEvent
ReplicatedStorage.RemoteEvents.ToggleMovement.OnClientEvent:Connect(function(bool: boolean)
	if bool then
		PlayerModuleControls:Enable()
	else
		PlayerModuleControls:Disable()
	end
end)

ReplicatedStorage.RemoteEvents.PlayerTurn.OnClientEvent:Connect(function()
	
end)
