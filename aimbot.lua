-- Aimbot

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ===== ScreenGui (สำคัญมาก) =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XAYBCZ_UI"
ScreenGui.ResetOnSpawn = false

-- รองรับ executor / local
pcall(function()
	ScreenGui.Parent = game.CoreGui
end)

-- ===== CAMERA LOCK =====
local lockEnabled = false
local connection

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function getNearestTarget()
	local char = getCharacter()
	local root = char:WaitForChild("HumanoidRootPart")

	local nearest, shortest = nil, math.huge
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (plr.Character.HumanoidRootPart.Position - root.Position).Magnitude
			if dist < shortest then
				shortest = dist
				nearest = plr.Character.HumanoidRootPart
			end
		end
	end
	return nearest
end

local function enableLock()
	connection = RunService.RenderStepped:Connect(function()
		local target = getNearestTarget()
		if target then
			camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Position)
		end
	end)
end

local function disableLock()
	if connection then
		connection:Disconnect()
		connection = nil
	end
end

-- ===== PRO INTRO =====
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BY XAYBZC"
gui.ResetOnSpawn = false
pcall(function()
	gui.Parent = game.CoreGui
end)

-- Text
local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.fromScale(0.4, 0.08)
label.Position = UDim2.fromScale(0.3, 0.05)
label.BackgroundTransparency = 1
label.Text = "BY XAYBCZ"
label.TextScaled = true
label.Font = Enum.Font.GothamBlack
label.TextColor3 = Color3.fromRGB(255,0,0)
label.ZIndex = 10

-- Rainbow Effect
task.spawn(function()
	while label.Parent do
		for i = 0, 1, 0.01 do
			label.TextColor3 = Color3.fromHSV(i,1,1)
			task.wait(0.03)
		end
	end
end)

-- Fade Out หลัง 10 วิ
task.delay(10, function()
	local fade = TweenService:Create(
		label,
		TweenInfo.new(1),
		{TextTransparency = 1}
	)
	fade:Play()
	fade.Completed:Wait()
	gui:Destroy()
end)

     - ===== BUTTON LOCK =====
local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.fromScale(0.18, 0.07)
Button.Position = UDim2.fromScale(0.02, 0.12)
Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
Button.TextColor3 = Color3.fromRGB(255,255,255)
Button.TextScaled = true
Button.Font = Enum.Font.GothamBold
Button.Text = "LOCK : OFF"
Button.BorderSizePixel = 0
Button.ZIndex = 10

Instance.new("UICorner", Button).CornerRadius = UDim.new(0,12)

Button.MouseButton1Click:Connect(function()
	lockEnabled = not lockEnabled
	if lockEnabled then
		enableLock()
		Button.Text = "LOCK : ON"
		Button.BackgroundColor3 = Color3.fromRGB(40,120,40)
	else
		disableLock()
		Button.Text = "LOCK : OFF"
		Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
	end
end)
