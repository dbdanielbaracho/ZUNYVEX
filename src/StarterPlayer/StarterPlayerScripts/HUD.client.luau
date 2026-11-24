--!strict
-- Lightweight, touch-friendly HUD: no purchases and no mandatory onboarding.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("ZunyvexRemotes")
local notice = remotes:WaitForChild("Notice") :: RemoteEvent
local statsUpdate = remotes:WaitForChild("StatsUpdate") :: RemoteEvent

local gui = Instance.new("ScreenGui")
gui.Name = "ZUNYVEX_HUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = player:WaitForChild("PlayerGui")
local function label(name: string, text: string, position: UDim2, size: UDim2, alignment: Enum.TextXAlignment): TextLabel
    local l = Instance.new("TextLabel")
    l.Name = name
    l.Text = text
    l.Position = position
    l.Size = size
    l.BackgroundColor3 = Color3.fromRGB(28, 36, 75)
    l.BackgroundTransparency = 0.12
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.GothamBold
    l.TextScaled = true
    l.TextXAlignment = alignment
    l.Parent = gui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = l
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.Parent = l
    return l
end
local heading = label("Title", "🌟 ZUNYVEX", UDim2.fromScale(0.025, 0.035), UDim2.fromScale(0.30, 0.075), Enum.TextXAlignment.Left)
local stats = label("Scores", "⭐ 0   💎 0", UDim2.fromScale(0.69, 0.035), UDim2.fromScale(0.285, 0.075), Enum.TextXAlignment.Center)
local hint = label("Hint", "Cristais • Desafio das Nuvens • Portal", UDim2.fromScale(0.16, 0.88), UDim2.fromScale(0.68, 0.065), Enum.TextXAlignment.Center)
local notification = label("Notification", "", UDim2.fromScale(0.23, 0.14), UDim2.fromScale(0.54, 0.078), Enum.TextXAlignment.Center)
notification.Visible = false
local token = 0
notice.OnClientEvent:Connect(function(message: string)
    token += 1
    local thisToken = token
    notification.Text = tostring(message)
    notification.Visible = true
    task.delay(4, function()
        if thisToken == token then notification.Visible = false end
    end)
end)
statsUpdate.OnClientEvent:Connect(function(stars: number, crystals: number)
    stats.Text = string.format("⭐ %d   💎 %d", stars, crystals)
end)
