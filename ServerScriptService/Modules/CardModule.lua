-- @ScriptType: ModuleScript
-- ServerScriptService/CardModule.lua
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Chance = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Chance"))
local Config = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Config"))

local CardModule = {}

-- ═══════════════════════════════════════════════════════════
-- HELPER: Print table in Lua syntax (like the tutorial)
-- ═══════════════════════════════════════════════════════════
local function printTableAsLua(tbl, indent)
	indent = indent or ""
	local result = "{\n"

	for key, value in pairs(tbl) do
		local keyStr = '["' .. tostring(key) .. '"]'

		if type(value) == "table" then
			result = result .. indent .. "  " .. keyStr .. " = "
			result = result .. printTableAsLua(value, indent .. "  ") .. ",\n"
		elseif type(value) == "string" then
			result = result .. indent .. "  " .. keyStr .. ' = "' .. value .. '",\n'
		elseif type(value) == "boolean" then
			result = result .. indent .. "  " .. keyStr .. " = " .. tostring(value) .. ",\n"
		else
			result = result .. indent .. "  " .. keyStr .. " = " .. tostring(value) .. ",\n"
		end
	end

	result = result .. indent .. "}"
	return result
end

-- Generate full card data table with rolled stats
function CardModule.GetCardDataTable(player, cardName, playerPotential)
	playerPotential = playerPotential or 0

	-- Load the card template
	local success, cardMod = pcall(function()
		return require(script.Cards[cardName].TemplateModule)
	end)

	if not success or not cardMod then
		warn("Failed to load card template for: " .. cardName)
		return nil
	end

	-- Create card data table
	local cardDataTable = {
		-- Basic info
		name = cardMod.name,
		cardId = cardMod.cardId,
		cardType = cardMod.type,
		element = cardMod.element,
		rarity = cardMod.rarity,
		stars = cardMod.stars,
		cardCost = cardMod.cost,

		-- Base stats (before multipliers)
		baseDamage = cardMod.baseDamage,
		baseCriticalChance = cardMod.baseCriticalChance,
		criticalMultiplier = cardMod.criticalMultiplier,
		baseHealth = cardMod.baseHealth,
		baseDefense = cardMod.baseDefense,

		-- Progression
		level = cardMod.level,
		maxLevel = cardMod.maxLevel,
		potential = playerPotential,

		-- ROLLED STATS (use player's potential for better rolls)
		damageStat = Config.getRandomStat(playerPotential),
		criticalStat = Config.getRandomStat(playerPotential),
		healthStat = Config.getRandomStat(playerPotential),
		defenseStat = Config.getRandomStat(playerPotential),

		-- ROLLED TRAIT (use player's potential)
		trait = Config.getRandomTrait(playerPotential),

		-- ROLLED SHINY (no luck, just RNG)
		shiny = Config.getRandomShiny(),

		-- Flags
		tradeable = cardMod.tradeable,

		-- Generate unique instance ID
		instanceId = game:GetService("HttpService"):GenerateGUID(false),
	}

	-- PRINT THE TABLE IN LUA SYNTAX
	print(printTableAsLua(cardDataTable))

	return cardDataTable
end

-- Rest of your code...
local RarityChance = Chance.new({
	Common = 50.0,
	Rare = 28.0,
	Epic = 13.0,
	Legendary = 6.0,
	Mythic = 2.5,
	Divine = 0.5,
})

local PITY_THRESHOLDS = {
	Mythic = 75,
	Divine = 150,
}

function CardModule.ChooseCard(player, cards, luckModifier, forcedRarity)
	luckModifier = luckModifier or 0

	local hiddenStats = player:FindFirstChild("HiddenStats")
	local pityStats = hiddenStats and hiddenStats:FindFirstChild("PityStats")
	local pullsSinceMythic = pityStats and pityStats:FindFirstChild("PullsSinceMythic")
	local pullsSinceDivine = pityStats and pityStats:FindFirstChild("PullsSinceDivine")

	local categorizedCards = {
		["Common"] = {},
		["Rare"] = {},
		["Epic"] = {},
		["Legendary"] = {},
		["Mythic"] = {},
		["Divine"] = {},
	}

	for _, Card in cards:GetChildren() do
		if Card.Name == "Template" then
			continue
		end

		local rarity = Card:FindFirstChild("Rarity")
		if rarity and categorizedCards[rarity.Value] then
			table.insert(categorizedCards[rarity.Value], Card)
		end
	end

	local chosenRarity

	if forcedRarity and categorizedCards[forcedRarity] then
		chosenRarity = forcedRarity
		print("Forced Rarity: " .. forcedRarity)

	elseif pullsSinceDivine and pullsSinceDivine.Value >= PITY_THRESHOLDS.Divine then
		chosenRarity = "Divine"
		print("🌟 PITY TRIGGERED: Guaranteed Divine! (" .. pullsSinceDivine.Value .. " pulls)")

	elseif pullsSinceMythic and pullsSinceMythic.Value >= PITY_THRESHOLDS.Mythic then
		chosenRarity = "Mythic"
		print("💎 PITY TRIGGERED: Guaranteed Mythic! (" .. pullsSinceMythic.Value .. " pulls)")

	else
		RarityChance:SetLuck(luckModifier)
		chosenRarity = RarityChance:Run()
	end

	if pullsSinceMythic and pullsSinceDivine then
		pullsSinceMythic.Value += 1
		pullsSinceDivine.Value += 1

		if chosenRarity == "Mythic" or chosenRarity == "Divine" then
			pullsSinceMythic.Value = 0
		end

		if chosenRarity == "Divine" then
			pullsSinceDivine.Value = 0
		end
	end

	local chosenCards = categorizedCards[chosenRarity]
	if #chosenCards > 0 then
		local randomIndex = math.random(1, #chosenCards)
		local chosenCard = chosenCards[randomIndex]
		local cardName = chosenCard.Name
		print("Chosen Card: " .. cardName .. " (Rarity: " .. chosenRarity .. ")")
		return cardName, chosenRarity
	else
		warn("No cards available for rarity: " .. chosenRarity)
		local fallbackCards = categorizedCards["Common"]
		if #fallbackCards > 0 then
			local fallbackCard = fallbackCards[math.random(1, #fallbackCards)]
			return fallbackCard.Name, "Common"
		end
		return nil, nil
	end
end

return CardModule