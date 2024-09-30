-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
-- Requirements
local Object = require(ReplicatedStorage:WaitForChild("Object"))
local Map = require(ReplicatedStorage:WaitForChild("Map"))

-- Script 
local map1 = Map:New(Vector3.new(0, 4, -16), Vector3.new(1, 1, 1))
map1:Build("1")
map1:ShowDebug()

local map3 = Map:New(Vector3.new(0, 4, -48), Vector3.new(3, 3, 3))
map3:Build("123")

local maplayer = Map:New(Vector3.new(0, 4, -136), Vector3.new(10, 10, 10))
maplayer:Build("layer")
