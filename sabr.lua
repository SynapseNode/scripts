local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 150)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true -- для драга
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Верхняя панель
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -30, 1, 0)
titleText.Position = UDim2.new(0, 5, 0, 0)
titleText.Size = UDim2.new(1, -35, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.Text = "Game Menu"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.SourceSansBold
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 20
titleText.BackgroundTransparency = 1
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Кнопка сворачивания
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 25, 1, 0)
toggleButton.Position = UDim2.new(1, -25, 0, 0)
toggleButton.Size = UDim2.new(0, 35, 1, 0)
toggleButton.Position = UDim2.new(1, -35, 0, 0)
toggleButton.Text = "-"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundTransparency = 1
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 20
toggleButton.Parent = titleBar

-- Контейнер для кнопок
local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, 0, 1, -30)
buttonHolder.Position = UDim2.new(0, 0, 0, 30)
buttonHolder.Size = UDim2.new(1, 0, 1, -35)
buttonHolder.Position = UDim2.new(0, 0, 0, 35)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Parent = buttonHolder

local buttons = {}
local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.Parent = buttonHolder

-- Создание кнопок
local function createButton(text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 160, 0, 35)
	button.Size = UDim2.new(0, 250, 0, 40)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSans
	button.Font = Enum.Font.Gotham
	button.TextSize = 18

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = button

	-- Эффект наведения
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end)

	button.Parent = buttonHolder
	button.MouseButton1Click:Connect(callback)

	table.insert(buttons, button)
	return button
end

-- Кнопки
createButton("Set speed 50", function()
	local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 50
	end
end)

createButton("Set jump power 50", function()
	local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
createButton("Set jump power 100", function()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = 50
		humanoid.JumpPower = 100
	end
end)

createButton("Remove GUI", function()
	if screenGui then
		screenGui:Destroy()
		script:Destroy()
	end
end)

-- Сворачивание
local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	buttonHolder.Visible = not isMinimized
	toggleButton.Text = isMinimized and "+" or "-"
	mainFrame.Size = isMinimized and UDim2.new(0, 300, 0, 35) or UDim2.new(0, 300, 0, 250)
end)
