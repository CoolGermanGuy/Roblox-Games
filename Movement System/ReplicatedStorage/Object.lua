-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Init
local Object = {}
Object.__index = Object

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
	newObject.Kind = kind
	newObject.Part = ObjectKinds[kind].Part:Clone()
	
	-- loop to assign default or override values
	for ObjectKind, ValueTable in ObjectKinds do
		for Property in ValueTable do
			if override and override[Property] ~= nil then -- if override has a property OR the part has a value
				newObject[Property] = override[Property]
			else
				newObject[Property] = ObjectKinds[kind][Property] -- if it doesn't set it to default kind value
			end
		end
	end
	
	newObject.Part.Parent = workspace
	setmetatable(newObject, Object)
	return newObject
	
end

-- Methods

return Object
