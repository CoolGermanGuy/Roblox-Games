-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Requirements
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))

-- Init
local Enemy = {}
Enemy.__index = Enemy

-- Enemy Kinds
local EnemyKinds = {
	["Blob"] = {
		["Health"] = 100,
		["MaxHealth"] = 100,
		["Attack"] = "!! ADD ATTACK TYPE SYSTEM",
		["MoveAmount"] = 3,
	}
}
-- New
function Enemy.New(kind: string, override: {})
	local newEnemy = {}
	newEnemy.GameIndex = nil
	newEnemy.kind = kind
	-- loop to assign or override default kind values
	for Property in EnemyKinds[kind] do
		if override and override[Property] ~= nil then -- if override has something, assign that
			newEnemy[Property] = override[Property]
		else
			newEnemy[Property] = EnemyKinds[kind][Property] -- if it doesn't, assign default value
		end
	end

	setmetatable(newEnemy, Enemy)
	return newEnemy
end

-- Functions/Methods
--		Getters Start
function Enemy:GetGame()
	return GameHandler.GetGame(self.GameIndex)
end

function Enemy:GetMap()
	return GameHandler:GetMap(self.GameIndex)
end

function Enemy:GetEnemies()
	return GameHandler:GetEnemies(self.GameIndex)
end
--		Getters End
function Enemy:Die()
	print("!! add dying")
end

function Enemy:Damage(amount: number)
	if (self.Health - amount) >= 0 then
		self:Die()
	else
		self.Health -= amount
	end
end

function Enemy:Heal(amount: number)
	if (self.Health + amount) > self.MaxHealth then -- if health would go over maximum health
		self.Health = self.MaxHealth -- get maximum amount of health

	else -- if it wouldn't go over max health
		self.Health += amount
	end
end


return Enemy
