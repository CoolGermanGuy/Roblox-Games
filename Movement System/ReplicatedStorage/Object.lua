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
		["Part"] = ReplicatedStorage.Objects.Grass,
	},
	["Wall"] = {
		["Walkable"] = false,
		["Part"] = ReplicatedStorage.Objects.Wall,
	},
	["Water"] = {
		["Walkable"] = false,
		["Part"] = ReplicatedStorage.Objects.Water,
	},
	["Air"] = {
		["Walkable"] = false,
		["Part"] = ReplicatedStorage.Objects.Air,
		["Transparency"] = 1,
	},
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
	return GameHandler:GetMap(self.GameIndex)
end

function Object:GetEnemies()
	return GameHandler:GetEnemies(self.GameIndex)
end
--		Getters End


return Object
