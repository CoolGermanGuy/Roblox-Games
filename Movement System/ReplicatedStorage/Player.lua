-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Requirements
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))

-- Variables

-- Init
local Player = {}
Player.__index = Player

-- New
function Player.New(player: Player)
	local newPlayer = {}

	newPlayer.GameIndex = nil
	newPlayer.Player = player
	newPlayer.Character = player.Character or player.CharacterAdded:Wait()
	newPlayer.MaxHealth = 100
	newPlayer.Healt = 100
	newPlayer.Position = {
		x = 0,
		y = 0,
		z = 0
	}

	setmetatable(newPlayer, Player)
	return newPlayer
end

-- Functions/Methods
--		Getters Start
function Player:GetGame()
	return GameHandler.GetGame(self.GameIndex)
end

function Player:GetMap()
	return GameHandler:GetMap(self.GameIndex)
end

function Player:GetEnemies()
	return GameHandler:GetEnemies(self.GameIndex)
end
--		Getters End

function Player:Die()
	print("im gonna make this later")
end

function Player:Damage(amount: number)
	if (self.Health - amount) <= 0 then -- if health would go below zero
		self:Die()
	else -- if player would survive the damage
		self.Health -= amount
		-- !! add some animation or idk
	end
end

function Player:Heal(amount: number)
	if (self.Health + amount) > 100 then -- if health would be more than the max
		self.Health = self.MaxHealth
	else
		self.Health += amount
	end
end

return Player
