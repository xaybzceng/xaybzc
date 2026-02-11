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
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local text = "XAYBCZ LOCK"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.4,0.1)
frame.Position = UDim2.fromScale(0.3,0.1)
frame.BackgroundTransparency = 1

local letters = {}
for i = 1, #text do
	local lbl = Instance.new("TextLabel")
	lbl.Parent = frame
	lbl.Size = UDim2.fromScale(1/#text,1)
	lbl.Position = UDim2.fromScale((i-1)/#text,0)
	lbl.BackgroundTransparency = 1
	lbl.Text = string.sub(text,i,i)
	lbl.TextScaled = true
	lbl.Font = Enum.Font.GothamBlack
	table.insert(letters, lbl)
end

local hue = 0

RunService.RenderStepped:Connect(function(dt)
	hue = (hue + dt * 0.4) % 1
	for i, lbl in ipairs(letters) do
		local offset = (i/#text)
		lbl.TextColor3 = Color3.fromHSV((hue + offset) % 1, 1, 1)
	end
end)

-- ===== BUTTON LOCK =====
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
