-- @ScriptType: ModuleScript
-- ServerScriptService/Modules/CardModule/Cards/Template/TemplateModule.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Config"))

local TemplateModule = {}

-- //BASIC INFO
TemplateModule.name = "Template Card"
TemplateModule.cardId = 0000
TemplateModule.cardType = "Creature"
TemplateModule.element = "Neutral"
TemplateModule.rarity = "Common"
TemplateModule.stars = 1
TemplateModule.cost = 1

-- //BASE STATS (before stat multipliers)
TemplateModule.baseDamage = 100
TemplateModule.baseCriticalChance = 10
TemplateModule.criticalMultiplier = 2.0
TemplateModule.baseHealth = 500
TemplateModule.baseDefense = 10

-- //PROGRESSION SYSTEM
TemplateModule.level = 1
TemplateModule.maxLevel = Config.maxLevel
TemplateModule.potential = 0 -- //0-100, increases with use


-- //RANDOM STATS (Rolled using potential)
-- ///NOTE: When creating a NEW card instance, pass the player's potential for this unit
-- ///Default to 0 potential for template
TemplateModule.damageStat = Config.getRandomStat(TemplateModule.potential) -- //F, E, D, C, B, A, S, SS, SSS
TemplateModule.criticalStat = Config.getRandomStat(TemplateModule.potential)
TemplateModule.healthStat = Config.getRandomStat(TemplateModule.potential)
TemplateModule.defenseStat = Config.getRandomStat(TemplateModule.potential)

-- //RANDOM TRAIT (Rolled using potential)
TemplateModule.trait = Config.getRandomTrait(TemplateModule.potential)

-- //FLAGS
TemplateModule.shiny = Config.getRandomShiny()
TemplateModule.tradeable = true

return TemplateModule