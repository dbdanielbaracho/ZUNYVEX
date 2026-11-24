--!strict
-- Race feedback is display-only; the server owns all checkpoint progress.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local event = ReplicatedStorage:WaitForChild("ZunyvexRaceFeedback") :: RemoteEvent
local gui = Instance.new("ScreenGui")
gui.Name = "ZunyvexRaceHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
local label = Instance.new("TextLabel")
label.Name = "RaceStatus"
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.fromScale(0.5, 0.08)
label.Size = UDim2.new(0.75, 0, 0, 48)
label.BackgroundColor3 = Color3.fromRGB(22, 29, 54)
label.BackgroundTransparency = 0.15
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Visible = false
label.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = label
-- Client-only victory flourish: no rewards or server state can be forged here.
local function celebrate()
    for i = 1, 12 do
        local spark = Instance.new("TextLabel")
        spark.Name = "VictorySpark"
        spark.BackgroundTransparency = 1
        spark.Text = if i % 2 == 0 then "★" else "✦"
        spark.TextColor3 = if i % 2 == 0 then Color3.fromRGB(255, 218, 90) else Color3.fromRGB(87, 227, 255)
        spark.TextScaled = true
        spark.Size = UDim2.fromOffset(28, 28)
        local x = 0.15 + (i % 6) * 0.14
        spark.Position = UDim2.fromScale(x, 0.42)
        spark.Parent = gui
        local tween = TweenService:Create(spark, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(x, 0.14 + math.floor((i - 1) / 6) * 0.16),
            TextTransparency = 1,
        })
        tween.Completed:Connect(function() spark:Destroy() end)
        tween:Play()
    end
end
local sequence = 0
event.OnClientEvent:Connect(function(status: unknown, value: unknown, total: unknown)
    if typeof(status) ~= "string" or typeof(value) ~= "number" or typeof(total) ~= "number" then return end
    if total ~= 5 then return end
    sequence += 1
    local current = sequence
    if status == "start" then
        label.Text = "🏁 Corrida iniciada! Passe pelos 5 portais!"
    elseif status == "checkpoint" then
        label.Text = string.format("✨ Portal %d de %d!", value, total)
    elseif status == "finished" then
        label.Text = string.format("🏆 Chegada! Tempo: %.1f segundos", value)
        celebrate()
    elseif status == "timed_out" then
        label.Text = "⏱ Tempo esgotado! Tente novamente!"
    else
        return
    end
    label.Visible = true
    task.delay(5, function()
        if sequence == current then label.Visible = false end
    end)
end)
