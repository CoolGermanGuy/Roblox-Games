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


-- New Object
function Object.New(kind: string, position: Vector3, override: {})
	local newObject = {}
	newObject.Kind = kind
	newObject.Part = ObjectKinds[kind].Part:Clone()
	newObject.Part.Position = position
	
	-- loop to assign default or override values
	for ObjectKind, ValueTable in ObjectKinds do
		for i, v in ValueTable do
			if override[i] ~= nil then -- if override has e.g. "walkable" then set it to that value
				newObject[i] = override[i]
			else -- if it doesn't set it to the default value
				newObject[i] = ObjectKinds[kind][i]
			end
		end
	end
	newObject.Part.Parent = workspace
	setmetatable(newObject, Object)
	return newObject
end

-- Functions
function Object:Appear()
	self.Part.Transparency = 0
end

function Object:Disappear()
	self.Part.Transparency = 1
end

return Object
