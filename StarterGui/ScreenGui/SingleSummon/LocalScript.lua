-- @ScriptType: LocalScript
script.Parent.MouseButton1Click:Connect(function()
	local event = game.ReplicatedStorage:WaitForChild("Summon")
	event:FireServer("Single")
end)