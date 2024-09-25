-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local Map = require(ReplicatedStorage:WaitForChild("Map"))

-- Script
local myMap = Map.New(Vector3.new(10,5,10))
-- test all kinds
myMap:SetObject(1, 1, 1, Object:New("Grass", {}))
myMap:SetObject(5, 2, 5, Object:New("Water", {}))

myMap:SetObject(10, 5, 10, Object:New("Wall", {}))
-- test override
--myMap:SetObject(1, 1, 2, Object:New("Grass", {}))
myMap:SetObject(1, 1, 3, Object:New("Grass", {["Transparency"] = 0.5}))
--myMap:SetObject(1, 1, 4, Object:New("Grass", {["Walkable"] = false}))

print(myMap)
