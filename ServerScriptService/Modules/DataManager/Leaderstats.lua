-- @ScriptType: ModuleScript
-- ServerScriptService/Modules/DataManager/Leaderstats.lua
local module = {}
local ServerScriptService = game:GetService("ServerScriptService")

local CardTable = {
	"AUnit",
}

function module:Create(player: Player, profile)
	-- Main stats folder
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local hiddenStats = Instance.new("Folder")
	hiddenStats.Name = "HiddenStats"
	hiddenStats.Parent = player

	local Cards = Instance.new("Folder")
	Cards.Name = "Cards"
	Cards.Parent = hiddenStats

	local CardValues = Instance.new("Folder")
	CardValues.Name = "CardValues"
	CardValues.Parent = Cards

	local Decks = Instance.new("Folder")
	Decks.Name = "Decks"
	Decks.Parent = hiddenStats

	local Values = Instance.new("Folder")
	Values.Name = "Values"
	Values.Parent = hiddenStats

	-- Primary free currency - earnable through gameplay
	local Yen = Instance.new("IntValue")
	Yen.Name = "Yen"
	Yen.Value = profile.Data.Yen
	Yen.Parent = leaderstats

	-- Premium currency - purchasable, some from events
	local Gems = Instance.new("IntValue")
	Gems.Name = "Gems"
	Gems.Value = profile.Data.Gems
	Gems.Parent = leaderstats

	-- Level
	local Level = Instance.new("IntValue")
	Level.Name = "Level"
	Level.Value = profile.Data.Level
	Level.Parent = leaderstats -- Changed from player to leaderstats

	-- Pity System Counters (ONLY for Mythic and Divine)
	local PityStats = Instance.new("Folder")
	PityStats.Name = "PityStats"
	PityStats.Parent = hiddenStats

	local PullsSinceMythic = Instance.new("IntValue")
	PullsSinceMythic.Name = "PullsSinceMythic"
	PullsSinceMythic.Value = profile.Data.PullsSinceMythic
	PullsSinceMythic.Parent = PityStats

	local PullsSinceDivine = Instance.new("IntValue")
	PullsSinceDivine.Name = "PullsSinceDivine"
	PullsSinceDivine.Value = profile.Data.PullsSinceDivine
	PullsSinceDivine.Parent = PityStats

	-- Hidden Values
	local MinCards = Instance.new("IntValue")
	MinCards.Name = "MinimumCards"
	MinCards.Value = profile.Data.MinCards
	MinCards.Parent = Values

	local MaxCards = Instance.new("IntValue")
	MaxCards.Name = "MaximumCards"
	MaxCards.Value = profile.Data.MaxCards
	MaxCards.Parent = Values

	-- Load saved cards from profile data
	for cardName, count in pairs(profile.Data.Cards) do
		if count > 0 then
			-- Create IntValue to track count
			local cardValue = Instance.new("IntValue")
			cardValue.Name = cardName
			cardValue.Value = count
			cardValue.Parent = CardValues

			-- Clone card objects for display (optional)
			local cardTemplate = ServerScriptService:WaitForChild("CardModule"):WaitForChild("Cards"):FindFirstChild(cardName)
			if cardTemplate then
				for i = 1, count do
					local cardClone = cardTemplate:Clone()
					cardClone.Parent = Cards
				end
			end
		end
	end
end

return module