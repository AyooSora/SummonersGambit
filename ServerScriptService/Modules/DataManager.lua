-- @ScriptType: ModuleScript
-- ServerScriptService/Modules/DataManager.lua
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local modules = ServerScriptService:WaitForChild("Modules")

-- CHANGED: ProfileService → ProfileStore
local ProfileStore = require(modules:WaitForChild("ProfileStore"))

local template = require(script:WaitForChild("Template"))
local leaderstats = require(script:WaitForChild("Leaderstats"))

local dataKey = "_DataStore0"

-- CHANGED: GetProfileStore → New
local profileStore = ProfileStore.New(dataKey, template)

local dataManager = {}
dataManager.Profiles = {}
dataManager.key = dataKey

local function PlayerAdded(player: Player)
	-- CHANGED: LoadProfileAsync → StartSessionAsync with Cancel function
	local profile = profileStore:StartSessionAsync("Player_"..player.UserId, {
		Cancel = function()
			return player.Parent ~= Players -- Cancel if player left during load
		end
	})

	if profile ~= nil then
		profile:AddUserId(player.UserId) -- Same
		profile:Reconcile() -- Same

		-- CHANGED: ListenToRelease → OnSessionEnd:Connect
		profile.OnSessionEnd:Connect(function()
			dataManager.Profiles[player] = nil
			player:Kick("Profile session ended - Please rejoin")
		end)

		if player:IsDescendantOf(Players) then
			dataManager.Profiles[player] = profile
			leaderstats:Create(player, profile)
		else
			-- CHANGED: Release → EndSession
			profile:EndSession()
		end
	else
		player:Kick("Profile load failed - Please rejoin")
	end

	warn("Profile loaded:", profile.Data)
end

local function PlayerRemoving(player: Player)
	local profile = dataManager.Profiles[player]

	if profile ~= nil then
		warn("Profile saving:", profile.Data)
		-- CHANGED: Release → EndSession
		profile:EndSession()
	end
end

for _, player in Players:GetPlayers() do
	task.spawn(PlayerAdded, player)
end

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)

return dataManager