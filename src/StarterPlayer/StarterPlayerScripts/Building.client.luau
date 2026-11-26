--!strict
-- Explicit creative controls; server remains authoritative.
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
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
local colors = {"Sky","Pink","Gold","Mint"}
local index = 1
local last = -math.huge
local function refresh()
    toggle.Text = if active then "Fechar criação" else "Criar"
    palette.Visible = active
    place.Visible = active
    remove.Visible = active
    recolor.Visible = active
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
local function submit(action: string)
    if not active or os.clock()-last < config.MinInterval then return end
    local camera = workspace.CurrentCamera
    if not camera then return end
    local center = camera.ViewportSize/2
    local ray = camera:ViewportPointToRay(center.X,center.Y)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = if player.Character then {player.Character} else {}
    local hit = workspace:Raycast(ray.Origin,ray.Direction*config.MaxDistance,params)
    if not hit then return end
    local target = hit.Instance
    local position: Vector3
    if action == "remove" or action == "recolor" then
        if not target:IsA("BasePart") or target.Name ~= "CreativeBlock" then return end
        position = target.Position
    else
        position = snap(hit.Position + hit.Normal*(config.Grid/2))
    end
    last = os.clock()
    request:FireServer(action,position,colors[index])
end
toggle.Activated:Connect(function() active = not active; refresh() end)
palette.Activated:Connect(function() index = index % #colors + 1; palette.Text = "Cor: "..colors[index] end)
place.Activated:Connect(function() submit("place") end)
remove.Activated:Connect(function() submit("remove") end)
recolor.Activated:Connect(function() submit("recolor") end)
UIS.InputBegan:Connect(function(input, processed)
    if processed or not active then return end
    if input.KeyCode == Enum.KeyCode.E then submit("place") end
    if input.KeyCode == Enum.KeyCode.Q then submit("remove") end
end)
result.OnClientEvent:Connect(function(_action: string, count: number, max: number)
    status.Text = string.format("%d / %d",count,max)
end)
refresh()
