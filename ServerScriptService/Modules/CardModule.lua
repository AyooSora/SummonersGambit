-- @ScriptType: ModuleScript
local CardModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Chance = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Chance"))

--[[ Rarity chances
local RARITY_CHANCES = {
	["Common"] = 50.0,
	["Rare"] = 28.0,
	["Epic"] = 13.0,
	["Legendary"] = 6.0,
	["Mythic"] = 2.5,
	["Divine"] = 0.5,
}
]]--

local RarityChance = Chance.new({
	Common = 50.0,
	Rare = 28.0,
	Epic = 13.0,
	Legendary = 6.0,
	Mythic = 2.5,
	Divine = 0.5,
})

-- Pity thresholds (ONLY Mythic and Divine)
local PITY_THRESHOLDS = {
	Mythic = 75,   -- Guaranteed Mythic every 75 pulls
	Divine = 150,  -- Guaranteed Divine every 150 pulls
}

function CardModule.ChooseCard(player, cards, luckModifier, forcedRarity)
	luckModifier = luckModifier or 0

	-- Get pity stats
	local hiddenStats = player:FindFirstChild("HiddenStats")
	local pityStats = hiddenStats and hiddenStats:FindFirstChild("PityStats")

	local pullsSinceMythic = pityStats and pityStats:FindFirstChild("PullsSinceMythic")
	local pullsSinceDivine = pityStats and pityStats:FindFirstChild("PullsSinceDivine")

	-- Categorize cards by rarity
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

	-- Check if rarity is forced (for starter packs/rewards)
	if forcedRarity and categorizedCards[forcedRarity] then
		chosenRarity = forcedRarity
		print("Forced Rarity: " .. forcedRarity)

		-- Check pity thresholds (DIVINE first, then MYTHIC)
	elseif pullsSinceDivine and pullsSinceDivine.Value >= PITY_THRESHOLDS.Divine then
		chosenRarity = "Divine"
		print("🌟 PITY TRIGGERED: Guaranteed Divine! (" .. pullsSinceDivine.Value .. " pulls)")

	elseif pullsSinceMythic and pullsSinceMythic.Value >= PITY_THRESHOLDS.Mythic then
		chosenRarity = "Mythic"
		print("💎 PITY TRIGGERED: Guaranteed Mythic! (" .. pullsSinceMythic.Value .. " pulls)")

	else
		-- Normal RNG roll
		RarityChance:SetLuck(luckModifier)
		chosenRarity = RarityChance:Run()
	end

	-- Update pity counters
	if pullsSinceMythic and pullsSinceDivine then
		pullsSinceMythic.Value += 1
		pullsSinceDivine.Value += 1

		-- Reset counters based on what was pulled
		if chosenRarity == "Mythic" or chosenRarity == "Divine" then
			pullsSinceMythic.Value = 0
		end

		if chosenRarity == "Divine" then
			pullsSinceDivine.Value = 0
		end
	end

	-- Pick random card from chosen rarity
	local chosenCards = categorizedCards[chosenRarity]
	if #chosenCards > 0 then
		local randomIndex = math.random(1, #chosenCards)
		local chosenCard = chosenCards[randomIndex]

		local cardName = chosenCard.Name
		print("Chosen Card: " .. cardName .. " (Rarity: " .. chosenRarity .. ")")

		return cardName, chosenRarity
	else
		warn("No cards available for rarity: " .. chosenRarity)

		-- Fallback to Common
		local fallbackCards = categorizedCards["Common"]
		if #fallbackCards > 0 then
			local fallbackCard = fallbackCards[math.random(1, #fallbackCards)]
			return fallbackCard.Name, "Common"
		end

		return nil, nil
	end
end

return CardModule