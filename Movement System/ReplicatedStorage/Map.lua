-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))

-- Init
local Map = {}
Map.__index = Map

-- New
function Map:New(position: Vector3, size: Vector3)
	local newMap = {}
	newMap.Position = position
	newMap.Size = size
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

-- Methods
function Map:GetPosition(x: int, y: int, z: int)
	return Vector3.new(self.Position.X + self.Size.X + (8*x), self.Position.Y + self.Size.Y + (8*y), self.Position.Z + self.Size.Z + (8*z))
end

function Map:SetCell(x: int, y: int, z: int, Object: Object)
	if self[x][y][z].Part ~= nil then -- if there already is an object, update it instead of setting a new one
		self:UpdateCell(x, y, z, Object)
		return
	end
	self[x][y][z] = Object
	Object.Part.Position = self:GetPosition(x, y, z)
end

function Map:UpdateCell(x: int, y: int, z: int, Object: Object)
	self[x][y][z] = nil
	self[x][y][z] = Object
	Object.Part.Position = self:GetPosition(x, y, z)
end

function Map:Build(version: string)
	if version == "test" then
		-- big ass code bullshit
		for x = 1, self.Size.X, 1 do
			for y = 1, self.Size.Y, 1 do
				for z = 1, self.Size.Z, 1 do
					-- script
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
					
					
				end
			end
		end
		
		-- bullshit end
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


return Map
