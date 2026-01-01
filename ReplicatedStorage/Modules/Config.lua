-- @ScriptType: ModuleScript
-- ReplicatedStorage/Modules/Config.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatsMod = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("StatsModule"))

local Config = {}

-- //WRAPPER FUNCTIONS (pass potential through)
function Config.applyStat(value, statValue)
	return StatsMod.applyStat(value, statValue)
end

function Config.getRandomStat(potential)
	return StatsMod.getRandomStat(potential)
end

function Config.getRandomTrait(potential)
	return StatsMod.getRandomTrait(potential)
end

function Config.potentialToLuck(potential)
	return StatsMod.potentialToLuck(potential)
end

function Config.getRandomShiny()
	return StatsMod.getRandomShiny()
end


-- //GAME CONSTANTS
Config.maxLevel = 100
Config.maxPotential = 100

-- //Potential gain per battle
Config.potentialGainPerWin = 1 -- //+1 potential per win with this unit
Config.potentialGainPerLoss = 0.5 -- //+0.5 potential even if you lose

return Config