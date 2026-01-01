-- @ScriptType: ModuleScript
-- ServerScriptService/Modules/CardModule/CardInstanceCreator.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Config"))

local CardInstanceCreator = {}

function CardInstanceCreator.CreateCardInstance(cardTemplate, playerPotential)
	-- Clone the template
	local newCard = {}
	for key, value in pairs(cardTemplate) do
		newCard[key] = value
	end

	-- Set the player's current potential
	newCard.potential = playerPotential or 0

	-- Re-roll stats using the player's potential
	newCard.damageStat = Config.getRandomStat(newCard.potential)
	newCard.criticalStat = Config.getRandomStat(newCard.potential)
	newCard.healthStat = Config.getRandomStat(newCard.potential)
	newCard.defenseStat = Config.getRandomStat(newCard.potential)

	-- Re-roll trait using the player's potential
	newCard.trait = Config.getRandomTrait(newCard.potential)

	-- Generate unique instance ID
	newCard.instanceId = game:GetService("HttpService"):GenerateGUID(false)

	return newCard
end

return CardInstanceCreator