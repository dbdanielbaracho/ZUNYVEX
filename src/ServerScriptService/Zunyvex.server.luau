--!strict
-- Session-only exploration and cloud challenge. Server owns all rewards.
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Config = require(RS:WaitForChild("GameConfig"))
local Challenge = require(RS:WaitForChild("CloudChallenge"))
if game.PlaceId ~= 112566849572143 and not game:GetService("RunService"):IsStudio() then return end
local function folder(parent: Instance, name: string): Folder
    local existing = parent:FindFirstChild(name)
    if existing then assert(existing:IsA("Folder")); return existing end
    local f = Instance.new("Folder"); f.Name = name; f.Parent = parent; return f
end
local remotes = folder(RS, "ZunyvexRemotes")
local function remote(name: string): RemoteEvent
    local existing = remotes:FindFirstChild(name)
    if existing then assert(existing:IsA("RemoteEvent")); return existing end
    local e = Instance.new("RemoteEvent"); e.Name = name; e.Parent = remotes; return e
end
local notice = remote("Notice")
local stats = remote("StatsUpdate")
local state: {[Player]: {stars: number, crystals: number, checkpoint: number, challengeActive: boolean}} = {}
local function init(p: Player)
    if state[p] then return end
    state[p] = {stars=0, crystals=0, checkpoint=0, challengeActive=false}
    p.CharacterRemoving:Connect(function()
        local s = state[p]; if s then Challenge.reset(s) end
    end)
end
Players.PlayerAdded:Connect(init)
Players.PlayerRemoving:Connect(function(p) state[p] = nil end)
for _, p in Players:GetPlayers() do init(p) end
local function playerFromHit(hit: BasePart): Player?
    local model = hit:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    local h = model:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return nil end
    local p = Players:GetPlayerFromCharacter(model)
    if p and p.Character == model then return p end
    return nil
end
local function reward(p: Player, points: number, crystals: number, message: string)
    local s = state[p]; if not s then return end
    s.stars += points; s.crystals += crystals
    stats:FireClient(p, s.stars, s.crystals)
    notice:FireClient(p, message)
end
-- Never overwrite an authored world.
if workspace:FindFirstChild("ZunyvexWorld") then return end
local world = folder(workspace, "ZunyvexWorld")
local function part(name: string, pos: Vector3, size: Vector3, color: Color3, solid: boolean): Part
    local p = Instance.new("Part")
    p.Name = name; p.Anchored = true; p.Position = pos; p.Size = size
    p.Color = color; p.CanCollide = solid; p.CanTouch = not solid
    p.Parent = world; return p
end
local grass = Color3.fromRGB(91, 190, 143)
part("DiscoveryIsland", Vector3.new(0,-3,0), Vector3.new(216,2,216), grass, true)
part("CloudIsland", Vector3.new(0,26,-110), Vector3.new(28,2,24), grass, true)
local spawn = Instance.new("SpawnLocation")
spawn.Name = "DiscoverySpawn"; spawn.Anchored = true; spawn.Neutral = true
spawn.Position = Vector3.new(0,-1,0); spawn.Size = Vector3.new(8,2,8); spawn.Parent = world
for i = 1, Config.CrystalCount do
    local angle = i * math.pi * 2 / Config.CrystalCount
    local radius = if i % 2 == 0 then 55 else 85
    local crystal = part("Crystal_"..i, Vector3.new(math.cos(angle)*radius,1,math.sin(angle)*radius), Vector3.new(2,4,2), Color3.fromRGB(90,225,255), false)
    crystal.Material = Enum.Material.Neon
    local available = true
    crystal.Touched:Connect(function(hit)
        local p = playerFromHit(hit)
        if not p or not state[p] or not available then return end
        available = false; crystal.CanTouch = false; crystal.Transparency = 1
        reward(p, Config.CrystalPoints, 1, "Cristal descoberto!")
        task.delay(Config.CrystalRespawnSeconds, function()
            if crystal.Parent then crystal.Transparency = 0; crystal.CanTouch = true; available = true end
        end)
    end)
end
local portal = part("CloudPortal", Vector3.new(-25,3,-75), Vector3.new(8,10,2), Color3.fromRGB(180,100,255), false)
portal.Material = Enum.Material.Neon; portal.Transparency = 0.35
local portalAt: {[Player]: number} = {}
Players.PlayerRemoving:Connect(function(p) portalAt[p] = nil end)
portal.Touched:Connect(function(hit)
    local p = playerFromHit(hit); if not p then return end
    local now = os.clock()
    if portalAt[p] and now - portalAt[p] < 2 then return end
    portalAt[p] = now
    local s = state[p]; if s then Challenge.start(s) end
    if p.Character then p.Character:PivotTo(CFrame.new(Config.PortalDestination)) end
    notice:FireClient(p, "Desafio das Nuvens!")
end)
for i = 1, Config.ObbyCheckpoints do
    local pos = Vector3.new(i*8,26+i,-110)
    part("CloudStep_"..i, pos, Vector3.new(7,2,8), Color3.fromRGB(170,185,255), true)
    local gate = part("CloudCheckpoint_"..i, pos+Vector3.new(0,3,0), Vector3.new(6,4,6), Color3.fromRGB(255,215,90), false)
    gate.Transparency = 0.6
    gate.Touched:Connect(function(hit)
        local p = playerFromHit(hit); if not p then return end
        local s = state[p]; if not s then return end
        local result = Challenge.advance(s, i, Config.ObbyCheckpoints)
        if result == "ignored" then return end
        if result == "finished" then
            reward(p, Config.ObbyFinishPoints, 0, "Desafio concluído!")
            if p.Character then p.Character:PivotTo(CFrame.new(0,5,0)) end
        else
            notice:FireClient(p, string.format("Nuvem %d/%d", i, Config.ObbyCheckpoints))
        end
    end)
end
