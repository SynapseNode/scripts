local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 300)
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

local function createSlider(text, min, max, default, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(0, 250, 0, 50)
	container.BackgroundTransparency = 1
	container.Parent = buttonHolder

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text .. ": " .. tostring(default)
	label.TextColor3 = Color3.fromRGB(240, 240, 240)
	label.Font = Enum.Font.Gotham
	label.TextSize = 18
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, 0, 0, 12)
	sliderBg.Position = UDim2.new(0, 0, 0, 30)
	sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container

	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 6)
	bgCorner.Parent = sliderBg

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 6)
	fillCorner.Parent = sliderFill

	local sliderButton = Instance.new("Frame")
	sliderButton.Size = UDim2.new(0, 24, 0, 24)
	sliderButton.Position = UDim2.new((default - min) / (max - min), -12, 0, -6)
	sliderButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	sliderButton.BorderSizePixel = 0
	sliderButton.Parent = sliderBg

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(1, 0)
	buttonCorner.Parent = sliderButton

	-- Добавим тень для кнопки
	local shadow = Instance.new("ImageLabel")
	shadow.Image = "rbxassetid://1316045217" -- simple circle shadow image
	shadow.Size = UDim2.new(1.5, 0, 1.5, 0)
	shadow.Position = UDim2.new(-0.25, 0, -0.25, 0)
	shadow.BackgroundTransparency = 1
	shadow.ZIndex = sliderButton.ZIndex - 1
	shadow.Parent = sliderButton

	local dragging = false

	local function updateSlider(input)
		local x = math.clamp(input.Position.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
		local percent = x / sliderBg.AbsoluteSize.X
		sliderFill.Size = UDim2.new(percent, 0, 1, 0)
		sliderButton.Position = UDim2.new(percent, -12, 0, -6)
		local value = math.floor(min + (max - min) * percent)
		label.Text = text .. ": " .. value
		callback(value)
	end

	sliderButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)
	sliderButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			updateSlider(input)
			dragging = true
		end
	end)
	sliderBg.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSlider(input)
		end
	end)
end


local function updateWalkSpeed(speed)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speed
	end
end

local function updateJumpPower(jump)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = jump
	end
end

local godModeActive = false
local godModeConnection

local godModeButton = Instance.new("TextButton")
godModeButton.Size = UDim2.new(0, 250, 0, 40)
godModeButton.Text = "God Mode"
godModeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
godModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
godModeButton.Font = Enum.Font.Gotham
godModeButton.TextSize = 18
local godCorner = Instance.new("UICorner")
godCorner.CornerRadius = UDim.new(0, 8)
godCorner.Parent = godModeButton
godModeButton.Parent = buttonHolder

godModeButton.MouseEnter:Connect(function()
	if not godModeActive then
		godModeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end
end)
godModeButton.MouseLeave:Connect(function()
	if not godModeActive then
		godModeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end
end)

local function enableGodMode()
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	humanoid.MaxHealth = 1e9
	humanoid.Health = humanoid.MaxHealth

	if godModeConnection then
		godModeConnection:Disconnect()
	end

	godModeConnection = humanoid.HealthChanged:Connect(function()
		if godModeActive and humanoid.Health < humanoid.MaxHealth then
			humanoid.Health = humanoid.MaxHealth
		end
	end)
end

local function disableGodMode()
	if godModeConnection then
		godModeConnection:Disconnect()
		godModeConnection = nil
	end
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	-- Возвращаем стандартные значения
	humanoid.MaxHealth = 100
	humanoid.Health = 100
end

godModeButton.MouseButton1Click:Connect(function()
	godModeActive = not godModeActive
	if godModeActive then
		godModeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		enableGodMode()
	else
		godModeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		disableGodMode()
	end
end)

-- Чтобы god mode работал при респавне, можно добавить слушатель персонажа:
player.CharacterAdded:Connect(function(char)
	if godModeActive then
		wait(0.1)
		enableGodMode()
	end
end)


-- Создаём слайдеры
createSlider("Speed", 10, 100, 16, updateWalkSpeed) -- По умолчанию 16 (стандартная скорость)
createSlider("Jump", 20, 150, 50, updateJumpPower) -- По умолчанию 50 (стандартный прыжок)

-- Остальной твой функционал

local noclipActive = false
local noclipConnection

local function setNoclip(canClip)
	if player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = canClip
			end
		end
	end
end

local function startNoclip()
	noclipConnection = game:GetService("RunService").Stepped:Connect(function()
		if player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)
end

local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0, 250, 0, 40)
noclipButton.Text = "Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Font = Enum.Font.Gotham
noclipButton.TextSize = 18
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = noclipButton
noclipButton.Parent = buttonHolder

noclipButton.MouseEnter:Connect(function()
	if noclipButton.BackgroundColor3 ~= Color3.fromRGB(0, 170, 0) then
		noclipButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end
end)
noclipButton.MouseLeave:Connect(function()
	if noclipButton.BackgroundColor3 ~= Color3.fromRGB(0, 170, 0) then
		noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end
end)

noclipButton.MouseButton1Click:Connect(function()
	noclipActive = not noclipActive
	if noclipActive then
		noclipButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		startNoclip()
	else
		noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end
		setNoclip(true)
	end
end)

local instantClickTPActive = false
local mouse = player:GetMouse()

local instantClickTPButton = Instance.new("TextButton")
instantClickTPButton.Size = UDim2.new(0, 250, 0, 40)
instantClickTPButton.Text = "Instant Click TP"
instantClickTPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
instantClickTPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
instantClickTPButton.Font = Enum.Font.Gotham
instantClickTPButton.TextSize = 18
local instantClickTPCorner = Instance.new("UICorner")
instantClickTPCorner.CornerRadius = UDim.new(0, 8)
instantClickTPCorner.Parent = instantClickTPButton
instantClickTPButton.Parent = buttonHolder

instantClickTPButton.MouseEnter:Connect(function()
	if not instantClickTPActive then
		instantClickTPButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end
end)
instantClickTPButton.MouseLeave:Connect(function()
	if not instantClickTPActive then
		instantClickTPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end
end)

local function teleportToMousePosition()
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
	local hrp = player.Character.HumanoidRootPart
	local mousePos = mouse.Hit.p
	-- Чтобы избежать телепорта на слишком низкую позицию (например, под землю), можно подстроить Y:
	local newPos = Vector3.new(mousePos.X, math.max(mousePos.Y, 1), mousePos.Z)
	hrp.CFrame = CFrame.new(newPos + Vector3.new(0, 3, 0)) -- немного выше, чтобы не провалиться
end

local clickConnection

instantClickTPButton.MouseButton1Click:Connect(function()
	instantClickTPActive = not instantClickTPActive
	if instantClickTPActive then
		instantClickTPButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		clickConnection = mouse.Button1Down:Connect(function()
			teleportToMousePosition()
		end)
	else
		instantClickTPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		if clickConnection then
			clickConnection:Disconnect()
			clickConnection = nil
		end
	end
end)

local smoothTPActive = false
local smoothTPConnection

local smoothTPButton = Instance.new("TextButton")
smoothTPButton.Size = UDim2.new(0, 250, 0, 40)
smoothTPButton.Text = "Smooth TP"
smoothTPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
smoothTPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothTPButton.Font = Enum.Font.Gotham
smoothTPButton.TextSize = 18
local smoothTPCorner = Instance.new("UICorner")
smoothTPCorner.CornerRadius = UDim.new(0, 8)
smoothTPCorner.Parent = smoothTPButton
smoothTPButton.Parent = buttonHolder

smoothTPButton.MouseEnter:Connect(function()
	if not smoothTPActive then
		smoothTPButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end
end)
smoothTPButton.MouseLeave:Connect(function()
	if not smoothTPActive then
		smoothTPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end
end)

local RunService = game:GetService("RunService")

local function lerp(a, b, t)
	return a + (b - a) * t
end

local function smoothTeleport(destination)
	local character = player.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end
	local hrp = character.HumanoidRootPart

	-- Для плавности используем Heartbeat
	local speed = 1 -- studs в секунду
	local connection
	connection = RunService.Heartbeat:Connect(function(dt)
		local currentPos = hrp.Position
		local direction = (destination - currentPos)
		local distance = direction.Magnitude
		if distance < 0.1 then
			hrp.CFrame = CFrame.new(destination)
			connection:Disconnect()
			return
		end

		local step = speed * dt
		if step > distance then
			step = distance
		end

		local newPos = currentPos + direction.Unit * step
		hrp.CFrame = CFrame.new(newPos)
	end)
	return connection
end

local currentSmoothTPConnection

smoothTPButton.MouseButton1Click:Connect(function()
	smoothTPActive = not smoothTPActive
	if smoothTPActive then
		smoothTPButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		currentSmoothTPConnection = mouse.Button1Down:Connect(function()
			if currentSmoothTPConnection then
				currentSmoothTPConnection:Disconnect()
			end
			-- Начинаем плавное перемещение к позиции мыши
			local dest = mouse.Hit.p
			-- Подстраиваем Y, чтоб не проваливаться в землю:
			dest = Vector3.new(dest.X, math.max(dest.Y, 1), dest.Z) + Vector3.new(0,3,0)
			currentSmoothTPConnection = smoothTeleport(dest)
		end)
	else
		smoothTPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		if currentSmoothTPConnection then
			currentSmoothTPConnection:Disconnect()
			currentSmoothTPConnection = nil
		end
	end
end)

local removeButton = Instance.new("TextButton")
removeButton.Size = UDim2.new(0, 250, 0, 40)
removeButton.Text = "Remove GUI"
removeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
removeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
removeButton.Font = Enum.Font.Gotham
removeButton.TextSize = 18
local removeCorner = Instance.new("UICorner")
removeCorner.CornerRadius = UDim.new(0, 8)
removeCorner.Parent = removeButton
removeButton.Parent = buttonHolder

removeButton.MouseEnter:Connect(function()
	if removeButton.BackgroundColor3 ~= Color3.fromRGB(0, 170, 0) then
		removeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end
end)
removeButton.MouseLeave:Connect(function()
	if removeButton.BackgroundColor3 ~= Color3.fromRGB(0, 170, 0) then
		removeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end
end)

removeButton.MouseButton1Click:Connect(function()
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
	mainFrame.Size = isMinimized and UDim2.new(0, 300, 0, 35) or UDim2.new(0, 300, 0, 300)
end)
