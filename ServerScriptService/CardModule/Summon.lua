-- @ScriptType: Script


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
	Multi = { -- 10-pull
		Yen = 900, -- 10% discount
		Gems = 0
	}
}

remote.OnServerEvent:Connect(function(player, summonType)
	local profile = dataManager.Profiles[player]
	
	if profile then
		if summonType ~= "Single" and summonType ~= "Multi" then
			warn("Invalid summon type")
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

		for i = 1, pullCount do
			local cardName, rarity = CardModule.ChooseCard(player, cardFolder, 0) -- 0 luck for now

			if cardName then
				-- Update player's data profile
				if not profile.Data.Cards[cardName] then
					profile.Data.Cards[cardName] = 0
				end
				profile.Data.Cards[cardName] = profile.Data.Cards[cardName] + 1
				
				-- Update HiddenStats display
				local hiddenCards = player:WaitForChild("HiddenStats"):WaitForChild("Cards"):WaitForChild("CardValues")		
				if not hiddenCards:FindFirstChild(cardName) then
					local cardValue = Instance.new("IntValue")
					cardValue.Name = cardName
					cardValue.Value = 0
					cardValue.Parent = hiddenCards
				end
				hiddenCards[cardName].Value = profile.Data.Cards[cardName]
				
				-- Add to results
				table.insert(pulledCards, {
					Name = cardName,
					Rarity = rarity
				})
				
			end

			if summonType == "Multi" then
				task.wait(0.1) -- Delay for animation
			end
		end

		-- Send results to client
		remote:FireClient(player, "Success", pulledCards)
		print(player.Name .. " summoned " .. pullCount .. " card(s)")
	end
	
end)