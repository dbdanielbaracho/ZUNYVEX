--!strict
-- Explicit creative controls; server remains authoritative.
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local config = require(RS:WaitForChild("GameConfig")).Build
local remotes = RS:WaitForChild("ZunyvexRemotes")
local request = remotes:WaitForChild("BuildRequest") :: RemoteEvent
local result = remotes:WaitForChild("BuildResult") :: RemoteEvent
local share = remotes:WaitForChild("BuildShareRequest") :: RemoteEvent
local shareResult = remotes:WaitForChild("BuildShareResult") :: RemoteEvent
local gui = Instance.new("ScreenGui")
gui.Name = "ZUNYVEX_Build"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
-- Keep controls inside the Roblox safe area; only the reticle uses viewport space.
gui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
local reticleGui = Instance.new("ScreenGui")
reticleGui.Name = "ZUNYVEX_BuildReticle"
reticleGui.ResetOnSpawn = false
reticleGui.IgnoreGuiInset = true
reticleGui.ScreenInsets = Enum.ScreenInsets.None
reticleGui.ClipToDeviceSafeArea = false
reticleGui.Parent = gui.Parent
local reticle = Instance.new("Frame")
reticle.Name = "BuildReticle"
reticle.AnchorPoint = Vector2.new(0.5, 0.5)
reticle.Position = UDim2.fromScale(0.5, 0.5)
reticle.Size = UDim2.fromOffset(18, 18)
reticle.BackgroundTransparency = 1
reticle.Active = false
reticle.Visible = false
reticle.Parent = reticleGui
local function reticleBar(size: UDim2)
    local bar = Instance.new("Frame")
    bar.AnchorPoint = Vector2.new(0.5, 0.5)
    bar.Position = UDim2.fromScale(0.5, 0.5)
    bar.Size = size
    bar.BackgroundColor3 = Color3.new(1, 1, 1)
    bar.BorderSizePixel = 0
    bar.Active = false
    bar.Parent = reticle
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.new(0, 0, 0)
    outline.Thickness = 1
    outline.Parent = bar
end
reticleBar(UDim2.fromOffset(18, 2))
reticleBar(UDim2.fromOffset(2, 18))
local panel = Instance.new("ScrollingFrame")
panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
panel.CanvasSize = UDim2.fromOffset(0, 0)
panel.ScrollBarThickness = 5
panel.Size = UDim2.fromOffset(184, 226)
panel.Position = UDim2.new(0, 12, 0.12, 0)
panel.BackgroundColor3 = Color3.fromRGB(28,36,75)
panel.Parent = gui
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = panel
local function button(name: string): TextButton
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,0,40)
    b.Text = name
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(55,75,130)
    b.TextColor3 = Color3.new(1,1,1)
    b.Parent = panel
    return b
end
local toggle = button("Criar")
local palette = button("Cor: Sky")
local place = button("Colocar")
local remove = button("Remover")
local recolor = button("Pintar bloco")
local sample = button("Copiar cor")
local status = button("0 / "..config.MaxPieces)
status.Active = false
local selectGuest = button("Escolher colaborador")
local grant = button("Permitir")
local revoke = button("Revogar")
local feedback = button("Sem seleção")
feedback.Active = false
local guestId: number? = nil
local function chooseGuest()
    local guests = {}
    for _, guest in ipairs(Players:GetPlayers()) do
        if guest ~= player then table.insert(guests, guest) end
    end
    table.sort(guests, function(a, b) return a.UserId < b.UserId end)
    local nextIndex = 1
    for i, guest in ipairs(guests) do
        if guest.UserId == guestId then nextIndex = i % #guests + 1; break end
    end
    local guest = guests[nextIndex]
    guestId = if guest then guest.UserId else nil
    selectGuest.Text = if guest then "@" .. guest.Name else "Sem colaboradores"
    feedback.Text = "Selecione uma ação"
end
selectGuest.Activated:Connect(chooseGuest)
local function changeAccess(allowed: boolean)
    local id = guestId
    if id and Players:GetPlayerByUserId(id) then
        share:FireServer(id, allowed)
        feedback.Text = "Aguardando servidor"
    end
end
grant.Activated:Connect(function() changeAccess(true) end)
revoke.Activated:Connect(function() changeAccess(false) end)
shareResult.OnClientEvent:Connect(function(id: number, allowed: boolean)
    if id == guestId then feedback.Text = if allowed then "Acesso permitido" else "Acesso revogado" end
end)
Players.PlayerRemoving:Connect(function(guest)
    if guest.UserId == guestId then
        guestId = nil
        selectGuest.Text = "Escolher colaborador"
        feedback.Text = "Jogador saiu"
    end
end)
local active = false
local BuildPalette = require(RS:WaitForChild("BuildPalette"))
local colors = {}
for i, entry in ipairs(BuildPalette.entries) do colors[i] = entry.name end
local index = 1
local last = -math.huge
local function refresh()
    reticle.Visible = active
    toggle.Text = if active then "Fechar criação" else "Criar"
    palette.Visible = active
    place.Visible = active
    remove.Visible = active
    recolor.Visible = active
    sample.Visible = active
    status.Visible = active
    selectGuest.Visible = active
    grant.Visible = active
    revoke.Visible = active
    feedback.Visible = active
    panel.Size = if active then UDim2.new(0, 184, 0.75, 0) else UDim2.fromOffset(184, 40)
end
local function snap(p: Vector3): Vector3
    local g = config.Grid
    return Vector3.new(math.round(p.X/g)*g,math.round(p.Y/g)*g,math.round(p.Z/g)*g)
end
local function aim(): RaycastResult?
    if not active then return nil end
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    local center = camera.ViewportSize/2
    local ray = camera:ViewportPointToRay(center.X,center.Y)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = if player.Character then {player.Character} else {}
    return workspace:Raycast(ray.Origin,ray.Direction*config.MaxDistance,params)
end
local highlight = Instance.new("Highlight")
highlight.Name = "CreativeTargetPreview"
highlight.DepthMode = Enum.HighlightDepthMode.Occluded
highlight.FillTransparency = 1
highlight.OutlineColor = Color3.fromRGB(255, 220, 90)
highlight.Enabled = false
highlight.Parent = workspace
-- Local-only placement preview; never participates in physics or raycasts.
local ghost = Instance.new("Part")
ghost.Name = "CreativePlacementPreview"
ghost.Size = Vector3.new(config.Grid, config.Grid, config.Grid)
ghost.Anchored = true
ghost.CanCollide = false
ghost.CanTouch = false
ghost.CanQuery = false
ghost.CastShadow = false
ghost.Material = Enum.Material.ForceField
ghost.Transparency = 1
ghost.Parent = workspace
local function placementPosition(hit: RaycastResult): Vector3
    return snap(hit.Position + hit.Normal*(config.Grid/2))
end
local elapsed = 0
RunService.RenderStepped:Connect(function(dt)
    if not active then
        highlight.Enabled = false
        highlight.Adornee = nil
        ghost.Transparency = 1
        return
    end
    elapsed += dt
    if elapsed < 0.1 then return end
    elapsed = 0
    local hit = aim()
    if hit then
        ghost.Position = placementPosition(hit)
        ghost.Transparency = 0.55
    else
        ghost.Transparency = 1
    end
    local target = if hit then hit.Instance else nil
    if target and target:IsA("BasePart") and target.Name == "CreativeBlock" then
        highlight.Adornee = target
        highlight.Enabled = true
    else
        highlight.Enabled = false
        highlight.Adornee = nil
    end
end)
local function submit(action: string)
    if not active or os.clock()-last < config.MinInterval then return end
    local hit = aim()
    if not hit then return end
    local target = hit.Instance
    if action == "sample" then
        if not target:IsA("BasePart") or target.Name ~= "CreativeBlock" then return end
        local matched = BuildPalette.match(target.Color.R, target.Color.G, target.Color.B)
        if matched then
            index = matched
            palette.Text = "Cor: "..colors[index]
        end
        return
    end
    local position: Vector3
    if action == "remove" or action == "recolor" then
        if not target:IsA("BasePart") or target.Name ~= "CreativeBlock" then return end
        position = target.Position
    else
        position = placementPosition(hit)
    end
    last = os.clock()
    request:FireServer(action,position,colors[index])
end
toggle.Activated:Connect(function() active = not active; refresh() end)
palette.Activated:Connect(function() index = index % #colors + 1; palette.Text = "Cor: "..colors[index] end)
place.Activated:Connect(function() submit("place") end)
remove.Activated:Connect(function() submit("remove") end)
recolor.Activated:Connect(function() submit("recolor") end)
sample.Activated:Connect(function() submit("sample") end)
UIS.InputBegan:Connect(function(input, processed)
    if processed or not active then return end
    if input.KeyCode == Enum.KeyCode.E then submit("place") end
    if input.KeyCode == Enum.KeyCode.Q then submit("remove") end
end)
result.OnClientEvent:Connect(function(_action: string, count: number, max: number)
    status.Text = string.format("%d / %d",count,max)
end)
refresh()
