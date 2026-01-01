-- @ScriptType: ModuleScript
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local UiModule = {}

local Camera = game.Workspace:WaitForChild("Camera")
local Blur = Lighting.Blur

local TT = 0.2 --Tween Time


local function animateGradient(UIGradient, animType)
	if animType == "SpinAnim" then
		while wait(0.05) do
			gradient.Rotation += 5
		end
	end
end

--UI Blur
function UIModule.Toggle(value : boolean)
	if value == true then
		TweenService:Create(Camera, TweenInfo(TT), {FieldOfView = 60}):Play()
		TweenService:Create(Blur, TweenInfo(TT), {Size = 10}):Play()
	else
		TweenService:Create(Camera, TweenInfo(TT), {FieldOfView = 70}):Play()
		TweenService:Create(Blur, TweenInfo(TT), {Size = 0}):Play()
	end
end





--Animate Gradients
function UIModule.UIGradientEffects(player : Player)
	for _, desc in player:WaitForChild("PlayerGui"):GetDescendants() do
		if desc:IsA("UIGradient") then
			if desc:FindFirstChildWhichIsA("BoolValue") then
				animateGradient(desc, desc.Name)
				print("Success ".. desc.Name .. " With " .. desc.Name)
			end
		end
	end
end

return UiModule
