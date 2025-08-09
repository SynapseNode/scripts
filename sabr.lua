local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -35, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.Text = "Game Menu"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 20
titleText.BackgroundTransparency = 1
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 35, 1, 0)
toggleButton.Position = UDim2.new(1, -35, 0, 0)
toggleButton.Text = "-"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundTransparency = 1
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 20
toggleButton.Parent = titleBar

local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, 0, 1, -35)
buttonHolder.Position = UDim2.new(0, 0, 0, 35)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Parent = buttonHolder

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.Parent = buttonHolder

local function createButton(text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 250, 0, 40)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 18

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = button

	button.MouseEnter:Connect(function()
		if button.BackgroundColor3 ~= Color3.fromRGB(0, 170, 0) then
			button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		end
	end)
	button.MouseLeave:Connect(function()
		if button.BackgroundColor3 ~= Color3.fromRGB(0, 170, 0) then
			button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
	end)

	button.Parent = buttonHolder
	button.MouseButton1Click:Connect(function()
		callback(button)
	end)
end

createButton("Set speed 50", function()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 50
	end
end)

createButton("Set jump power 100", function()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = 100
	end
end)

local noclipActive = false
local noclipConnection

createButton("Noclip", function(btn)
	noclipActive = not noclipActive
	if noclipActive then
		btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		noclipConnection = game:GetService("RunService").Stepped:Connect(function()
			if player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end
		if player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end)


createButton("Remove GUI", function()
	if screenGui then
		screenGui:Destroy()
		script:Destroy()
	end
end)

local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	buttonHolder.Visible = not isMinimized
	toggleButton.Text = isMinimized and "+" or "-"
	mainFrame.Size = isMinimized and UDim2.new(0, 300, 0, 35) or UDim2.new(0, 300, 0, 250)
end)
