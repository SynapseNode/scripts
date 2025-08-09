-- Создаем ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 150)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Скругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -30, 1, 0)
titleText.Position = UDim2.new(0, 5, 0, 0)
titleText.Text = "Game Menu"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.SourceSansBold
titleText.TextSize = 18
titleText.BackgroundTransparency = 1
titleText.Parent = titleBar

-- Кнопка сворачивания
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 25, 1, 0)
toggleButton.Position = UDim2.new(1, -25, 0, 0)
toggleButton.Text = "-"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundTransparency = 1
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Parent = titleBar

-- Контейнер для кнопок
local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, 0, 1, -30)
buttonHolder.Position = UDim2.new(0, 0, 0, 30)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Parent = buttonHolder

-- Таблица кнопок
local buttons = {}

local function createButton(text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 160, 0, 35)
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSans
	button.TextSize = 18

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = button

	button.Parent = buttonHolder
	button.MouseButton1Click:Connect(callback)

	table.insert(buttons, button)
	return button
end

-- Кнопки действий
createButton("Set speed 50", function()
	local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 50
	end
end)

createButton("Set jump power 50", function()
	local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = 50
	end
end)

-- Логика сворачивания
local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	buttonHolder.Visible = not isMinimized
	toggleButton.Text = isMinimized and "+" or "-"
end)
