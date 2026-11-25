--!strict
-- Reconstructed server entrypoint: shared, session-only creative building.
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Config = require(RS:WaitForChild("GameConfig")).Build
local Codec = require(script.Parent:WaitForChild("BuildPersistence"))
local function folder(parent: Instance, name: string): Folder
    local existing = parent:FindFirstChild(name)
    if existing then assert(existing:IsA("Folder")); return existing end
    local f = Instance.new("Folder"); f.Name = name; f.Parent = parent; return f
end
local remotes = folder(RS, "ZunyvexRemotes")
local function remote(name: string): RemoteEvent
    local existing = remotes:FindFirstChild(name)
    if existing then assert(existing:IsA("RemoteEvent")); return existing end
    local r = Instance.new("RemoteEvent"); r.Name = name; r.Parent = remotes; return r
end
local request = remote("BuildRequest")
local result = remote("BuildResult")
local builds = folder(workspace, "ZunyvexBuilds")
local colors = {Sky = Color3.fromRGB(80,180,255), Pink = Color3.fromRGB(255,120,190), Gold = Color3.fromRGB(255,210,70), Mint = Color3.fromRGB(100,230,170)}
local occupied: {[string]: Part} = {}
local ledger = require(script.Parent:WaitForChild("BuildLedger")).new(Config.MaxPieces)
local last: {[Player]: number} = {}
local function key(p: Vector3): string
    return string.format("%d:%d:%d", p.X, p.Y, p.Z)
end
request.OnServerEvent:Connect(function(player: Player, action: any, position: any, color: any)
    local now = os.clock()
    if last[player] and now - last[player] < Config.MinInterval then return end
    last[player] = now
    if action ~= "place" and action ~= "remove" then return end
    if typeof(position) ~= "Vector3" then return end
    local entry = {x=position.X,y=position.Y,z=position.Z,color=if action == "remove" then "Sky" else color}
    if not Codec.encode({entry}) then return end
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not root or not root:IsA("BasePart") or not humanoid or humanoid.Health <= 0 then return end
    if (root.Position-position).Magnitude > Config.MaxDistance then return end
    local id = key(position)
    local existing = occupied[id]
    if action == "remove" then
        if not existing or not ledger.remove(player.UserId, id) then return end
        occupied[id] = nil
        existing:Destroy()
    else
        if existing or not ledger.canPlace(player.UserId, id) then return end
        local overlap = OverlapParams.new()
        overlap.RespectCanCollide = true
        if #workspace:GetPartBoundsInBox(CFrame.new(position), Vector3.one*(Config.Grid-0.1), overlap) > 0 then return end
        local part = Instance.new("Part")
        part.Name = "CreativeBlock"; part.Anchored = true
        part.Size = Vector3.one*Config.Grid; part.Position = position
        part.Color = colors[color]; part:SetAttribute("OwnerUserId",player.UserId)
        if not ledger.place(player.UserId, id) then part:Destroy(); return end
        part.Parent = builds; occupied[id] = part
    end
    result:FireClient(player, action, ledger.count(player.UserId), Config.MaxPieces)
end)
Players.PlayerRemoving:Connect(function(player)
    for _, id in ipairs(ledger.clear(player.UserId)) do
        local part = occupied[id]
        occupied[id] = nil
        if part then part:Destroy() end
    end
    last[player] = nil
end)
