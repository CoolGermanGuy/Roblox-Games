-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
--      it can't have requirements so that children can access their parent game

-- Variables
local games = {}

-- Init
local GameHandler = {}
GameHandler.__index = GameHandler

-- New
function GameHandler.New()
	local newGame = {}
	newGame.GameIndex = #games + 1
	newGame.Map = nil
	newGame.Players = {}
	newGame.Enemies = {}
	
	setmetatable(newGame, GameHandler)
	table.insert(games, newGame)
	return newGame
end

-- Functions/Methods
-- 		Getters
function GameHandler.GetGame(gameIndex: number)
	return games[gameIndex]
end

function GameHandler.GetMap(gameIndex: number)
	return games[gameIndex].Map
end

function GameHandler.GetPlayers(gameIndex: number)
	return games[gameIndex].Players
end

function GameHandler.GetEnemies(gameIndex: number)
	return games[gameIndex].Enemies
end
-- 		Getters End

function GameHandler:AddPlayer(player)
	player.GameIndex = self.GameIndex
	table.insert(self.Players, player)
end

function GameHandler:AddEnemy(enemy)
	enemy.GameIndex = self.GameIndex
	table.insert(self.Enemies, enemy)
end

function GameHandler:AssignMap(map)
	map.GameIndex = self.GameIndex
	self.Map = map
end

return GameHandler
