-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- requirements
local Object = require(ReplicatedStorage.Object)
local Map = require(ReplicatedStorage.Map)

-- Script
local myMap = Map.New(Vector3.new(10,5,10))
print(myMap)
myMap[1][1][1]["part"] = Object.New("Grass", myMap[1][1][1]["position"], {})
myMap[10][5][10]["part"] = Object.New("Wall", myMap[10][5][10]["position"], {})

myMap[5][2][5]["part"] = Object.New("Water", myMap[5][2][5]["position"], {})

print(myMap)
