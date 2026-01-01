-- @ScriptType: ModuleScript
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Templatemodule = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("CardModule"):WaitForChild("Cards"):WaitForChild("Template"):WaitForChild("Template"))
local Chance = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Chance"))

local CardUI = {}

function CardUI.CreateCardFrame(cardName : string, player : Player, parent)
	
end

return CardUI
