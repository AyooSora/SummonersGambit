-- @ScriptType: ModuleScript
-- ReplicatedStorage/Modules/StatsModule.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Chance = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Chance"))

local StatsModule = {}

local STAT_MULTIPLIERS = {
	["F"] = 0.5,
	["E"] = 0.65,
	["D"] = 0.8,
	["C"] = 1.0,
	["B"] = 1.2,
	["A"] = 1.5,
	["S"] = 2.0,
	["SS"] = 2.5,
	["SSS"] = 3.0,
}

-- //STAT ROLL CHANCES (Using Chance module)
local STAT_CHANCES = {
	F = 15.0,   -- //15%
	E = 15.0,   -- //15%
	D = 18.0,   -- //18%
	C = 20.0,   -- //20% (most common)
	B = 15.0,   -- //15%
	A = 10.0,   -- //10%
	S = 5.0,    -- //5%
	SS = 1.5,   -- //1.5%
	SSS = 0.5,  -- //0.5% (rarest)
}

local StatRoller = Chance.new(STAT_CHANCES)

-- //TRAIT CHANCES (Using Chance module)
local TRAIT_CHANCES = {
	-- //Common traits (35%)
	["Haste"] = 8.0,
	["Regeneration"] = 8.0,
	["Vigilant"] = 8.0,
	["Blaze"] = 6.0,
	["Stun"] = 5.0,

	-- //Uncommon traits (30%)
	["Long Reach"] = 7.0,
	["Guardian"] = 7.0,
	["Soul Link"] = 7.0,
	["First Blood"] = 5.0,
	["Commander"] = 4.0,

	-- //Rare traits (25%)
	["Flying"] = 8.0,
	["Inspire"] = 7.0,
	["Cleave"] = 5.0,
	["Counter Strike"] = 5.0,

	-- //Epic traits (8%)
	["Executioner"] = 3.0,
	["True Strike"] = 2.5,
	["Untargetable"] = 2.5,

	-- //Legendary traits (2%)
	["Divine Shield"] = 1.0,
	["Undying"] = 1.0,
}

local TraitRoller = Chance.new(TRAIT_CHANCES)

local SHINY_CHANCES = {
	["NotShiny"] = 95.0,
	["IsShiny"] = 5.0,
}

local ShinyRoller = Chance.new(SHINY_CHANCES)

-- //POTENTIAL TO LUCK CONVERSION
     -- //Converts potential (0-100) to luck modifier (0-10)
function StatsModule.potentialToLuck(potential)
	-- //0 potential = 0 luck
	-- //50 potential = 5 luck
	-- //100 potential = 10 luck (max)
	return math.clamp(potential / 10, 0, 10)
end

-- //ROLL RANDOM STAT (with potential/luck)
function StatsModule.getRandomStat(potential)
	potential = potential or 0

	-- //Convert potential to luck (0-10 scale)
	local luck = StatsModule.potentialToLuck(potential)

	-- //Apply luck and roll
	StatRoller:SetLuck(luck)
	local stat = StatRoller:Run()

	return stat
end

-- //ROLL RANDOM TRAIT (with potential/luck)
function StatsModule.getRandomTrait(potential)
	potential = potential or 0

	-- //Convert potential to luck (0-10 scale)
	local luck = StatsModule.potentialToLuck(potential)

	-- //Apply luck and roll
	TraitRoller:SetLuck(luck)
	local trait = TraitRoller:Run()

	return trait
end

function StatsModule.getRandomShiny()
	local result = ShinyRoller:Run()

	if result == "IsShiny" then
		return true
	else
		return false
	end
end

-- //APPLY STAT MULTIPLIER
function StatsModule.applyStat(value, statValue)
	local multiplier = STAT_MULTIPLIERS[tostring(statValue)]
	if multiplier then
		return math.floor(value * multiplier)
	else
		warn("Invalid stat value: " .. tostring(statValue))
		return value
	end
end

-- //GET STAT MULTIPLIER (without applying)
function StatsModule.getStatMultiplier(statValue)
	return STAT_MULTIPLIERS[tostring(statValue)] or 1.0
end


-- DEBUG: View chances with luck applied
function StatsModule.debugStatChances(potential)
	potential = potential or 0
	local luck = StatsModule.potentialToLuck(potential)

	print("=== STAT CHANCES (Potential: " .. potential .. ", Luck: " .. luck .. ") ===")

	local items = StatRoller:GetItems(luck)
	for _, item in ipairs(items) do
		print(item.Item .. ": " .. math.floor(item.Chance * 100) / 100 .. "%")
	end
end

function StatsModule.debugTraitChances(potential)
	potential = potential or 0
	local luck = StatsModule.potentialToLuck(potential)

	print("=== TRAIT CHANCES (Potential: " .. potential .. ", Luck: " .. luck .. ") ===")

	local items = TraitRoller:GetItems(luck)
	for _, item in ipairs(items) do
		print(item.Item .. ": " .. math.floor(item.Chance * 100) / 100 .. "%")
	end
end

return StatsModule