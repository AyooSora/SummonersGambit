-- @ScriptType: Script
-- ServerScriptService/CardModule/Summon.lua
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Summon")
local dataManager = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("DataManager"))
local CardModule = require(script.Parent)

-- Summon costs
local SUMMON_COSTS = {
	Single = {
		Yen = 100,
		Gems = 0
	},
	Multi = {
		Yen = 900,
		Gems = 0
	}
}

remote.OnServerEvent:Connect(function(player, summonType)
	local profile = dataManager.Profiles[player]

	if not profile then
		warn("Profile not loaded for " .. player.Name)
		return
	end

	if summonType ~= "Single" and summonType ~= "Multi" then
		warn("Invalid summon type: " .. tostring(summonType))
		return
	end

	local cost = SUMMON_COSTS[summonType]
	local leaderstats = player:FindFirstChild("leaderstats")

	if not leaderstats then
		warn("Leaderstats not found for " .. player.Name)
		return
	end

	local yen = leaderstats:FindFirstChild("Yen")
	local gems = leaderstats:FindFirstChild("Gems")

	if not yen or not gems then
		warn("Currency not found for " .. player.Name)
		return
	end

	-- Check if player can afford
	if yen.Value < cost.Yen then
		remote:FireClient(player, "Error", "Not enough Yen! Need " .. cost.Yen .. ", have " .. yen.Value)
		return
	end

	if gems.Value < cost.Gems then
		remote:FireClient(player, "Error", "Not enough Gems! Need " .. cost.Gems .. ", have " .. gems.Value)
		return
	end

	-- Deduct currency
	yen.Value -= cost.Yen
	gems.Value -= cost.Gems

	-- Get card folder
	local cardFolder = script.Parent:WaitForChild("Cards")

	-- Perform summons
	local pulledCards = {}
	local pullCount = (summonType == "Multi") and 10 or 1
	local failedPulls = 0

	for i = 1, pullCount do
		-- Step 1: Choose which card to summon (determines rarity)
		local cardName, rarity = CardModule.ChooseCard(player, cardFolder, 0)

		if cardName and rarity then

			-- Step 2: Get player's potential for this card type
			local cardPotential = profile.Data.CardPotential[cardName] or 0

			-- Step 3: Generate FULL card data with rolled stats/traits/shiny
			local cardDataTable = CardModule.GetCardDataTable(player, cardName, cardPotential)

			if not cardDataTable then
				warn("Failed to generate card data for: " .. cardName)
				failedPulls += 1
				continue
			end

			-- Step 4: Update player's profile
			if not profile.Data.Cards[cardName] then
				profile.Data.Cards[cardName] = 0
			end
			profile.Data.Cards[cardName] += 1

			-- Step 5: Update HiddenStats display
			local hiddenStats = player:FindFirstChild("HiddenStats")
			if hiddenStats then
				local cardsFolder = hiddenStats:FindFirstChild("Cards")
				if cardsFolder then
					-- Update CardValues IntValue
					local cardValues = cardsFolder:FindFirstChild("CardValues")
					if cardValues then
						local cardValue = cardValues:FindFirstChild(cardName)
						if not cardValue then
							cardValue = Instance.new("IntValue")
							cardValue.Name = cardName
							cardValue.Value = 0
							cardValue.Parent = cardValues
						end
						cardValue.Value = profile.Data.Cards[cardName]
					end

					-- Clone card object to inventory
					local cardTemplate = cardFolder:FindFirstChild(cardName)
					if cardTemplate then
						local cardClone = cardTemplate:Clone()
						cardClone.Parent = cardsFolder
						print("Cloned " .. cardName .. " to inventory!")
					else
						warn("Card template not found: " .. cardName)
					end
				end
			end

			-- Step 6: Add COMPLETE card data to results
			table.insert(pulledCards, cardDataTable)

			print(player.Name .. " pulled: " .. cardName .. " (" .. rarity .. ")")
			print("  Stats: DMG=" .. cardDataTable.damageStat .. " HP=" .. cardDataTable.healthStat)
			print("  Trait: " .. cardDataTable.trait)
			print("  Shiny: " .. tostring(cardDataTable.shiny))

		else
			failedPulls += 1
			warn("Failed to pull card for " .. player.Name .. " on pull #" .. i)
		end

		if summonType == "Multi" then
			task.wait(0.1)
		end
	end

	-- Check if any cards were actually pulled
	if #pulledCards > 0 then
		-- Send FULL card data to client
		remote:FireClient(player, "Success", pulledCards)
		print(player.Name .. " summoned " .. #pulledCards .. " card(s)")

		if failedPulls > 0 then
			warn(failedPulls .. " pulls failed!")
		end
	else
		warn("No cards pulled for " .. player.Name .. " - REFUNDING CURRENCY")
		yen.Value += cost.Yen
		gems.Value += cost.Gems

		remote:FireClient(player, "Error", "Failed to summon cards. Currency refunded.")
		error("CRITICAL: All " .. pullCount .. " pulls failed for " .. player.Name)
	end
end)