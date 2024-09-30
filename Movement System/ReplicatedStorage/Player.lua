-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Requirements
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))
local Utils = require(ReplicatedStorage:WaitForChild("Utils"))

-- Variables
local Directions = {
	["Left"] = {
		x = 0,
		y = 0,
		z = -1
	},
	["Right"] = {
		x = 0,
		y = 0,
		z = 1
	},
	["Back"] = {
		x = -1,
		y = 0,
		z = 0
	},
	["Front"] = {
		x = 1,
		y = 0,
		z = 0
	},
	["Down"] = {
		x = 0,
		y = -1,
		z = 0
	},
	["Up"] = {
		x = 0,
		y = 1,
		z = 0
	}
}
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
	return GameHandler.GetMap(self.GameIndex)
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

function Player:MoveTo(x: number, y: number, z: number)
	self.Position = {
		x = x,
		y = y,
		z = z
	}
	self.Character.HumanoidRootPart.Position = Utils:GetObjectPosition(x, y, z, self)
end

function Player:Move(direction: string)
	local newX = self.Position.x + Directions[direction].x
	local newY = self.Position.y + Directions[direction].y
	local newZ = self.Position.z + Directions[direction].z

	local map = self:GetMap()

	if map[newX][newY - 1][newZ].Walkable then
		self.Position.x = newX
		self.Position.y = newY
		self.Position.z = newZ
		
		self.Character.HumanoidRootPart.Position = map:GetObjectPosition(newX, newY, newZ)
	end
end

return Player
