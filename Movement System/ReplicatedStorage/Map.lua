-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local GameHandler = require(ReplicatedStorage:WaitForChild("GameHandler"))
-- Init
local Map = {}
Map.__index = Map

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
function Map:New(position: Vector3, size: Vector3)
	local newMap = {}
	newMap.Position = position
	newMap.Size = size
	newMap.GameIndex = 1
	-- init map
	for x = 1, size.X do
		newMap[x] = {}
		for y = 1, size.Y do
			newMap[x][y] = {}
			for z = 1, size.Z do
				newMap[x][y][z] = {}
			end
		end
	end
	setmetatable(newMap, Map)
	return newMap
end

-- Functions/Methods
--		Getters Start
function Map:GetGame()
	return GameHandler.GetGame(self.GameIndex)
end

function Map:GetMap()
	return GameHandler:GetMap(self.GameIndex)
end

function Map:GetEnemies()
	return GameHandler:GetEnemies(self.GameIndex)
end
--		Getters End
function Map:GetObjectPosition(x: number, y: number, z: number)
	-- doesn't work
	--return Vector3.new(self.Position.X + self.Size.X + (8*x), self.Position.Y + self.Size.Y + (8*y), self.Position.Z + self.Size.Z + (8*z))
	-- works
	--return Vector3.new(self.Position.X + self.Size.X + (8*x) - 18, self.Position.Y + self.Size.Y + (8*y) - 12, self.Position.Z + self.Size.Z + (8*z) - 18)
	-- doesn't work
	--return Vector3.new(self.Position.X + self.Size.X + (8*x), self.Position.Y + self.Size.Y + (8*y), self.Position.Z + self.Size.Z + (8*z)) - Vector3.new(18, 12, 18)
	-- works
	return self.Position + Vector3.new(8*x, 8*y, 8*z) - Vector3.new(8, 8, 8)
end

function Map:SetCell(x: number, y: number, z: number, object: Object)
	if self[x][y][z].Part ~= nil then -- if there already is an object, update it instead of setting a new one
		self:UpdateCell(x, y, z, object)
	else
		object.GameIndex = self.GameIndex
		self[x][y][z] = object
		object.Part.Position = self:GetObjectPosition(x, y, z)
		object.Position = {
			x = x,
			y = y,
			z = z
		}
	end
end

function Map:UpdateCell(x: number, y: number, z: number, object: Object)
	object.GameIndex = self.GameIndex
	self[x][y][z] = nil
	self[x][y][z] = object
	object.Part.Position = self:GetObjectPosition(x, y, z)
end

function Map:Build(version: string)
	if version == "test" then
		-- big ass code bullshit
		self:ForEachCell(function(x, y, z)
			if y == 1 then
				self:SetCell(x, y, z, Object.New("Grass"))
			end
			if y > 1 then
				if x == self.Size.X or z == 1 then
					self:SetCell(x, y, z, Object.New("Wall"))
				end

				if x == 6 and z == 3 then
					self:SetCell(x, y, z, Object.New("Wall"))
				end
			end

			self:SetCell(3,1,8, Object.New("Water"))
			self:SetCell(3,1,9, Object.New("Water"))
			self:SetCell(2,1,8, Object.New("Water"))
			self:SetCell(2,1,9, Object.New("Water"))

			self:SetCell(2,2,2, Object.New("Wall"))
			self:SetCell(6,2,8, Object.New("Wall"))
			self:SetCell(4,2,10, Object.New("Wall"))
		end)

		-- bullshit end	
	elseif version == "1" then
		self:SetCell(1, 1, 1, Object.New("Random"))
	elseif version == "123" then
		self:SetCell(1, 1, 1, Object.New("Grass"))
		self:SetCell(2, 2, 2, Object.New("Water"))
		self:SetCell(3, 3, 3, Object.New("Wall"))
	elseif version == "layer" then
		self:ForEachCell(function(x, y, z)
			local layer = ((y - 1) % 3) + 1
			if layer == 1 then
				self:SetCell(x, y, z, Object.New("Grass"))
			elseif layer == 2 then
				self:SetCell(x, y, z, Object.New("Water"))
			elseif layer == 3 then
				self:SetCell(x, y, z, Object.New("Wall"))
			end
		end)
	else
		print("yeah no")
	end
end

function Map:ShowDebug()
	for x = 1, self.Size.X, 1 do
		for y = 1, self.Size.Y, 1 do
			for z = 1, self.Size.Z, 1 do
				-- script
				if self[x][y][z].Part then
					for index, surfacegui in ReplicatedStorage.Debug.ObjectSurfaceGui:GetChildren() do
						local newSurfaceGui = surfacegui:Clone()
						newSurfaceGui.TextLabel.Text = "("..x..","..y..","..z..")"
						newSurfaceGui.TextLabel.TextTransparency = 0
						newSurfaceGui.Parent = self[x][y][z].Part
					end
				end

			end
		end
	end
end

function Map:HideDebug()
	for x = 1, self.Size.X, 1 do
		for y = 1, self.Size.Y, 1 do
			for z = 1, self.Size.Z, 1 do
				-- script
				if self[x][y][z].Part then
					for index, child in self[x][y][z].Part:GetChildren() do
						if child:IsA("SurfaceGui") then
							child:Destroy()
						end
					end
				end
			end
		end
	end
end

function Map:GetNeighbourFrom(x: number, y: number, z: number, direction: StringValue)
	local newX = x + Directions[direction].x
	local newY = y + Directions[direction].y
	local newZ = z + Directions[direction].z
	if newX <= self.Size.X and newY <= self.Size.Y and newZ <= self.Size.Z then -- if its inside the map
		if newX > 0 and newY > 0 and newZ > 0 then -- if its inside the map
			if self[newX][newY][newZ].Part ~= nil then -- if there is an object
				return self [newX][newY][newZ]
			end
		end
	end
end

function Map:GetNeighbours(x: number, y: number, z: number)
	local neighbours = {}
	for direction in Directions do
		if self:GetNeighbourFrom(x, y, z, direction) ~= nil then
			table.insert(neighbours, self:GetNeighbourFrom(x, y, z, direction))
		end
	end
	return neighbours
end

function Map:GetNeighboursAsDict(x: number, y: number, z: number)
	local neighbours = {}
	for direction in Directions do
		if self:GetNeighbourFrom(x, y, z, direction) ~= nil then
			neighbours[direction] = self:GetNeighbourFrom(x, y, z, direction)
		end
	end
	return neighbours
end

function Map:GetObjectFromXYZ(x: number, y: number, z: number)
	return self[x][y][z]
end

function Map:ForEachCell(callback)
	for x = 1, self.Size.X, 1 do
		for y = 1, self.Size.Y, 1 do
			for z = 1, self.Size.Z, 1 do
				callback(x, y, z)
			end
		end
	end
end

return Map
