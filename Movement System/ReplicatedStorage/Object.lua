-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Init
local Object = {}
Object.__index = Object

-- Object Kinds
local ObjectKinds = {
	["Grass"] = {
		["walkable"] = true,
		["part"] = ReplicatedStorage.Objects.Grass,
	},
	["Wall"] = {
		["walkable"] = false,
		["part"] = ReplicatedStorage.Objects.Wall,
	},
	["Water"] = {
		["walkable"] = false,
		["part"] = ReplicatedStorage.Objects.Water,
	},
	["Air"] = {
		["walkable"] = false,
		["part"] = ReplicatedStorage.Objects.Air,
		["transparency"] = 1,
	},
}


-- New Object
function Object.New(kind: string, position: Vector3, override: {})
	print(override)
	local newObject = {}
	newObject.Kind = kind
	--newObject.Position = position
	if override["walkable"] ~= nil then
		newObject.Walkable = override["walkable"]
	else
		newObject.Walkable = ObjectKinds[kind]["walkable"] 
	end
	newObject.Part = ObjectKinds[kind]["part"]:Clone()
	newObject.Part.Position = position
	newObject.Part.Transparency = ObjectKinds[kind]["transparency"] or override["transparency"] or 0
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
