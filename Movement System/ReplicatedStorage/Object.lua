-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Init
local Object = {}
Object.__index = Object

-- Requirements
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))

-- Object Kinds
local ObjectKinds = {
	["Grass"] = {
		["Walkable"] = true,
		["Jumpable"] = true,
		["Part"] = ReplicatedStorage.Objects.Grass,
	},
	["Wall"] = {
		["Walkable"] = true,
		["Jumpable"] = false,
		["Part"] = ReplicatedStorage.Objects.Wall,
	},
	["Water"] = {
		["Walkable"] = false,
		["Jumpable"] = false,
		["Part"] = ReplicatedStorage.Objects.Water,
	},
	["Stone"] = {
		["Walkable"] = true,
		["Jumpable"] = true,
		["Part"] = ReplicatedStorage.Objects.Stone
	},
	["Air"] = {
		["Walkable"] = false,
		["Part"] = ReplicatedStorage.Objects.Air,
		["Transparency"] = 1,
	},
}

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

-- New
function Object.New(kind: string, override: {})
	local newObject = {}
	if kind == "Random" then
		local keys = {}
		for key in pairs(ObjectKinds) do
			table.insert(keys, key)
		end
		kind = keys[math.random(#keys)]
	end
	
	newObject.Position = {
		x = 0,
		y = 0,
		z = 0
	}
	newObject.GameIndex = 0
	newObject.Kind = kind
	newObject.Part = ObjectKinds[kind]["Part"]:Clone()

	-- loop to assign default or override values
	for Property in ObjectKinds[kind] do
		if override and override[Property] ~= nil then -- if override has a property OR the part has a value
			newObject[Property] = override[Property]
		elseif Property ~= "Part" then
			newObject[Property] = ObjectKinds[kind][Property] -- if it doesn't set it to default kind value
		end
	end

	newObject.Part.Parent = workspace
	setmetatable(newObject, Object)
	return newObject
end

-- Functions/Methods
--		Getters Start
function Object:GetGame()
	return GameHandler.GetGame(self.GameIndex)
end

function Object:GetMap()
	return GameHandler.GetMap(self.GameIndex)
end

function Object:GetEnemies()
	return GameHandler:GetEnemies(self.GameIndex)
end
--		Getters End

function Object:GetNeighbourFrom(direction: string)
	local newX = self.Position.x + Directions[direction].x
	local newY = self.Position.y + Directions[direction].y
	local newZ = self.Position.z + Directions[direction].z
	
	local map = self:GetMap()
	
	if newX <= map.Size.X and newY <= map.Size.Y and newZ <= map.Size.Z then -- if its inside the map
		if newX > 0 and newY > 0 and newZ > 0 then -- if its inside the map
			if map[newX][newY][newZ].Part ~= nil then -- if there is an object
				return map[newX][newY][newZ]
			end
		end
	end
end

function Object:GetNeighbours()
	local neighbours = {}
	for direction in Directions do
		if self:GetNeighbourFrom(direction) ~= nil then
			table.insert(neighbours, self:GetNeighbourFrom(direction))
		end
	end
	return neighbours
end

return Object
