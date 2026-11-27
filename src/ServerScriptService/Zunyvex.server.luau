--!strict
-- Session-only exploration and cloud challenge. Server owns all rewards.
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Config = require(RS:WaitForChild("GameConfig"))
local ContactGuard = require(RS:WaitForChild("ContactGuard"))
local Challenge = require(RS:WaitForChild("CloudChallenge"))
local DiscoveryLedger = require(RS:WaitForChild("DiscoveryLedger"))
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
local function playerFromHit(hit: BasePart, target: BasePart): Player?
    local model = hit:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    local h = model:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return nil end
    local p = Players:GetPlayerFromCharacter(model)
    local root = model:FindFirstChild("HumanoidRootPart")
    if p and p.Character == model and root and root:IsA("BasePart") then
        local radius = target.Size.Magnitude / 2 + 8
        if ContactGuard.near((root.Position - target.Position).Magnitude, radius) then return p end
    end
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
        local p = playerFromHit(hit, crystal)
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
    local p = playerFromHit(hit, portal); if not p then return end
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
        local p = playerFromHit(hit, gate); if not p then return end
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

-- Optional exploration island in the generated world only.
-- A continuous bridge makes the island accessible without teleporting.
part("RainbowBridge", Vector3.new(122,-3,0), Vector3.new(30,2,12), Color3.fromRGB(240,180,100), true)
part("SunsetIsland", Vector3.new(158,-3,0), Vector3.new(44,2,48), Color3.fromRGB(244,188,119), true)
local discovered: DiscoveryLedger.State = {}
for i = 1, 4 do
    local x = 145 + (i-1)*8
    local arch = part("SunsetArch_"..i, Vector3.new(x,2,-12), Vector3.new(2,8,2), Color3.fromRGB(255,130,100), true)
    arch.Material = Enum.Material.SmoothPlastic
end
local beacon = part("SunsetDiscovery", Vector3.new(169,2,10), Vector3.new(6,6,6), Color3.fromRGB(255,220,90), false)
beacon.Material = Enum.Material.Neon
beacon.Shape = Enum.PartType.Ball
beacon.Touched:Connect(function(hit)
    local p = playerFromHit(hit, beacon)
    if not p or not state[p] then return end
    if not DiscoveryLedger.claim(discovered, p.UserId, "sunset") then return end
    reward(p, 25, 0, "Ilha do Pôr do Sol descoberta!")
end)

-- Color Trail: independent timed challenge on the generated island.
local Trail = require(RS:WaitForChild("ColorTrail"))
local Ranking = require(RS:WaitForChild("TrailRanking"))
local bestTimes: Ranking.State = {}
local attempts: {[Player]: Trail.State} = {}
local startAt: {[Player]: number} = {}
Players.PlayerRemoving:Connect(function(p) attempts[p]=nil; startAt[p]=nil end)
local function bindTrailPlayer(p: Player)
    p.CharacterRemoving:Connect(function() attempts[p]=nil end)
end
Players.PlayerAdded:Connect(bindTrailPlayer)
for _, p in Players:GetPlayers() do bindTrailPlayer(p) end
local startPad = part("ColorTrailStart", Vector3.new(-60,1,55), Vector3.new(6,4,6), Color3.fromRGB(255,255,255), false)
local function label(p: Part, message: string)
    local gui = Instance.new("BillboardGui")
    gui.Size=UDim2.fromOffset(180,45); gui.StudsOffset=Vector3.new(0,4,0)
    gui.MaxDistance=65; gui.Parent=p
    local t=Instance.new("TextLabel"); t.Size=UDim2.fromScale(1,1)
    t.BackgroundTransparency=0.25; t.TextScaled=true; t.Text=message; t.Parent=gui
end
label(startPad,"Trilha das Cores: 30s")
local board = part("ColorTrailRanking", Vector3.new(-60,4,63), Vector3.new(10,8,1), Color3.fromRGB(35,45,75), true)
local surface = Instance.new("SurfaceGui")
surface.Face = Enum.NormalId.Front; surface.Parent = board
local rankingText = Instance.new("TextLabel")
rankingText.Size = UDim2.fromScale(1,1); rankingText.TextScaled = true
rankingText.BackgroundColor3 = Color3.fromRGB(35,45,75)
rankingText.TextColor3 = Color3.fromRGB(255,255,255)
rankingText.Parent = surface
local names: {[number]: string} = {}
local function refreshRanking()
    local lines = {"Melhores tempos • sessão"}
    for i, entry in Ranking.top(bestTimes,5) do
        table.insert(lines,string.format("%d. %s — %.3fs",i,names[entry.userId] or tostring(entry.userId),entry.milliseconds/1000))
    end
    rankingText.Text = table.concat(lines,"\n")
end
refreshRanking()
startPad.Touched:Connect(function(hit)
    local p=playerFromHit(hit, startPad); if not p or not state[p] then return end
    local now=os.clock()
    if startAt[p] and now-startAt[p]<2 then return end
    local old=attempts[p]
    if old and old.active and now-old.started<=30 then return end
    startAt[p]=now
    local attempt=Trail.start(now); attempts[p]=attempt
    notice:FireClient(p,"Passe pelos 4 portais em ordem!")
    task.delay(30.1,function()
        if attempts[p]==attempt and attempt.active then
            attempt.active=false
            if state[p] then notice:FireClient(p,"Tempo esgotado. Tente novamente!") end
        end
    end)
end)
local colors={Color3.fromRGB(255,90,90),Color3.fromRGB(255,220,80),Color3.fromRGB(80,220,130),Color3.fromRGB(80,150,255)}
for i=1,4 do
    local gate=part("ColorTrailGate_"..i,Vector3.new(-60+i*15,2,55),Vector3.new(5,6,5),colors[i],false)
    gate.Material=Enum.Material.Neon; gate.Transparency=0.35
    label(gate,tostring(i))
    gate.Touched:Connect(function(hit)
        local p=playerFromHit(hit, gate); if not p or not state[p] then return end
        local attempt=attempts[p]; if not attempt then return end
        local now=os.clock()
        local result=Trail.touch(attempt,i,now)
        if result=="finished" then
            local improved=Ranking.record(bestTimes,p.UserId,now-attempt.started)
            if improved then names[p.UserId]=p.Name; refreshRanking() end
            reward(p,15,0,string.format("Trilha concluída: %.3fs%s",now-attempt.started,if improved then " — recorde pessoal!" else ""))
        elseif result=="advanced" then notice:FireClient(p,string.format("Portal %d/4",i))
        elseif result=="expired" then notice:FireClient(p,"Tempo esgotado. Tente novamente!") end
    end)
end

-- Expedition: find five relics in any order, independently per player.
local Expedition = require(RS:WaitForChild("Expedition"))
local expeditions: {[number]: Expedition.State} = {}
local relicPositions = {
    Vector3.new(-90,2,-35), Vector3.new(85,2,35),
    Vector3.new(150,2,16), Vector3.new(35,2,-85),
    Vector3.new(-85,2,85),
}
for i, pos in relicPositions do
    local relic = part("ExpeditionRelic_"..i,pos,Vector3.new(3,3,3),Color3.fromRGB(255,125,220),false)
    relic.Shape=Enum.PartType.Ball; relic.Material=Enum.Material.Neon
    label(relic,"Relíquia "..i.."/5")
    relic.Touched:Connect(function(hit)
        local p=playerFromHit(hit, relic)
        if not p or not state[p] then return end
        local expedition=expeditions[p.UserId]
        if not expedition then expedition=Expedition.new(); expeditions[p.UserId]=expedition end
        local result=Expedition.collect(expedition,i)
        if result=="finished" then
            reward(p,40,0,"Expedição das Relíquias concluída!")
        elseif result=="advanced" then
            notice:FireClient(p,string.format("Relíquias encontradas: %d/5",expedition.count))
        end
    end)
end

-- Memory challenge: memorize four numbered pads, then reproduce the sequence.
local MemoryMatch = require(RS:WaitForChild("MemoryMatch"))
local memoryAttempts: {[Player]: MemoryMatch.State} = {}
local memoryReady: {[Player]: number} = {}
local memoryCooldown: {[Player]: number} = {}
local rng = Random.new()
local function clearMemory(p: Player)
    memoryAttempts[p]=nil; memoryReady[p]=nil
end
local function bindMemory(p: Player)
    p.CharacterRemoving:Connect(function() clearMemory(p) end)
end
Players.PlayerAdded:Connect(bindMemory)
for _, p in Players:GetPlayers() do bindMemory(p) end
Players.PlayerRemoving:Connect(function(p) clearMemory(p); memoryCooldown[p]=nil end)
local memoryStart=part("MemoryStart",Vector3.new(45,1,75),Vector3.new(6,4,6),Color3.fromRGB(240,240,240),false)
label(memoryStart,"Memória: memorize 4 números")
memoryStart.Touched:Connect(function(hit)
    local p=playerFromHit(hit,memoryStart); if not p or not state[p] then return end
    local now=os.clock()
    if memoryCooldown[p] and now-memoryCooldown[p]<3 then return end
    local old=memoryAttempts[p]
    if old and old.active and now-old.started<=25 then return end
    memoryCooldown[p]=now
    local sequence={rng:NextInteger(1,4),rng:NextInteger(1,4),rng:NextInteger(1,4),rng:NextInteger(1,4)}
    local attempt=MemoryMatch.start(sequence,now+3)
    memoryAttempts[p]=attempt; memoryReady[p]=now+3
    notice:FireClient(p,string.format("Memorize: %d - %d - %d - %d",sequence[1],sequence[2],sequence[3],sequence[4]))
    task.delay(3,function()
        if memoryAttempts[p]==attempt and state[p] then notice:FireClient(p,"Repita a sequência nos painéis!") end
    end)
    task.delay(28.1,function()
        if memoryAttempts[p]==attempt and attempt.active then
            clearMemory(p)
            if state[p] then notice:FireClient(p,"Tempo esgotado!") end
        end
    end)
end)
for i=1,4 do
    local pad=part("MemoryPad_"..i,Vector3.new(30+i*10,1,90),Vector3.new(5,4,5),colors[i],false)
    label(pad,tostring(i))
    local lastTouch: {[Player]: number} = {}
    Players.PlayerRemoving:Connect(function(p) lastTouch[p]=nil end)
    pad.Touched:Connect(function(hit)
        local p=playerFromHit(hit,pad); if not p or not state[p] then return end
        local attempt=memoryAttempts[p]; local ready=memoryReady[p]
        local now=os.clock()
        if not attempt or not ready or now<ready then return end
        if lastTouch[p] and now-lastTouch[p]<0.8 then return end
        lastTouch[p]=now
        local result=MemoryMatch.touch(attempt,i,now)
        if result=="finished" then clearMemory(p); reward(p,20,0,"Desafio da Memória concluído!")
        elseif result=="wrong" or result=="expired" then clearMemory(p); notice:FireClient(p,"Tente novamente!")
        elseif result=="advanced" then notice:FireClient(p,string.format("Memória: %d/4",attempt.nextIndex-1)) end
    end)
end


-- Cooperative portals: two distinct players, one shared arena, session rewards.
local Coop = require(RS:WaitForChild("CoopPortals"))
local coop = Coop.new()
local cooldown: {[number]: number} = {}
local generation = 0
local pads: {Part} = {}
local portalLabels: {TextLabel} = {}
local function resetVisuals()
    for i, pad in pads do
        pad.Color = Color3.fromRGB(100,170,255)
        portalLabels[i].Text = "Dupla: portal "..i.." / 2"
    end
end
local function leaveCoop(p: Player)
    if coop.player == p.UserId then
        Coop.leave(coop,p.UserId)
        generation += 1
        resetVisuals()
    end
end
local function bindCoop(p: Player)
    p.CharacterRemoving:Connect(function() leaveCoop(p) end)
end
Players.PlayerAdded:Connect(bindCoop)
for _, p in Players:GetPlayers() do bindCoop(p) end
Players.PlayerRemoving:Connect(function(p)
    leaveCoop(p)
    cooldown[p.UserId] = nil
end)
for i=1,2 do
    local pad = part("CoopPortalPad_"..i,Vector3.new(20+i*16,1,-48),Vector3.new(8,4,8),Color3.fromRGB(100,170,255),false)
    pad.Material = Enum.Material.Neon
    pad.Transparency = 0.25
    pads[i] = pad
    label(pad,"Dupla: portal "..i.." / 2")
    local gui = pad:FindFirstChildOfClass("BillboardGui")
    assert(gui)
    local textLabel = gui:FindFirstChildOfClass("TextLabel")
    assert(textLabel)
    portalLabels[i] = textLabel
    pad.Touched:Connect(function(hit)
        local p = playerFromHit(hit,pad)
        if not p or not state[p] then return end
        local now = os.clock()
        if cooldown[p.UserId] and now-cooldown[p.UserId]<30 then return end
        local result, partnerId = Coop.touch(coop,p.UserId,i,now)
        if result=="waiting" then
            generation += 1
            local token = generation
            resetVisuals()
            pad.Color = Color3.fromRGB(255,220,80)
            portalLabels[i].Text = "Ativado! Aguarde um amigo"
            portalLabels[3-i].Text = "Toque aqui para ajudar! 8s"
            notice:FireClient(p,"Um amigo deve tocar o outro portal em 8 segundos!")
            task.spawn(function()
                for remaining = 7, 1, -1 do
                    task.wait(1)
                    if generation ~= token or coop.player ~= p.UserId then return end
                    portalLabels[3-i].Text = "Toque aqui para ajudar! "..remaining.."s"
                end
            end)
            task.delay(8.1,function()
                if generation==token and coop.player==p.UserId then
                    Coop.clear(coop)
                    resetVisuals()
                    if state[p] then notice:FireClient(p,"Tempo esgotado. Tentem novamente!") end
                end
            end)
        elseif result=="finished" and partnerId then
            generation += 1
            resetVisuals()
            local partner = Players:GetPlayerByUserId(partnerId)
            if not partner or not state[partner] then return end
            cooldown[p.UserId]=now
            cooldown[partnerId]=now
            reward(p,20,0,"Portais unidos! +20 estrelas")
            reward(partner,20,0,"Portais unidos! +20 estrelas")
            for index, portalPad in pads do
                portalPad.Color=Color3.fromRGB(80,255,150)
                portalLabels[index].Text = "Vitória em dupla! +20 estrelas"
            end
            local token = generation
            task.delay(2,function() if generation==token then resetVisuals() end end)
        end
    end)
end

-- Moon island: optional exploration route, no teleport or purchase required.
-- Main island ends at x=-108; bridge joins the new island at x=-138.
part("MoonBridge", Vector3.new(-123,-3,0), Vector3.new(30,2,12), Color3.fromRGB(135,155,220), true)
part("MoonIsland", Vector3.new(-160,-3,0), Vector3.new(44,2,48), Color3.fromRGB(85,105,165), true)
for i=1,5 do
    local rock=part("MoonRock_"..i,Vector3.new(-146-(i-1)*7,0,-15),Vector3.new(5,4,5),Color3.fromRGB(170,185,230),true)
    rock.Shape=Enum.PartType.Ball
end
local moonBeacon=part("MoonDiscovery",Vector3.new(-175,2,10),Vector3.new(6,6,6),Color3.fromRGB(185,220,255),false)
moonBeacon.Shape=Enum.PartType.Ball
moonBeacon.Material=Enum.Material.Neon
label(moonBeacon,"Ilha da Lua: descubra!")
moonBeacon.Touched:Connect(function(hit)
    local p=playerFromHit(hit,moonBeacon)
    if not p or not state[p] then return end
    if not DiscoveryLedger.claim(discovered,p.UserId,"moon") then return end
    reward(p,25,0,"Ilha da Lua descoberta!")
end)

-- Optional lunar observatory: a short ascending jumping route with a unique discovery.
for i=1,5 do
    local step = part("MoonObservatoryStep_"..i, Vector3.new(-145-(i-1)*7, -0.5+i*2, 18), Vector3.new(6,2,7), Color3.fromRGB(145,165,225), true)
    if i==1 then label(step,"Observatório lunar: suba!") end
end
local observatory = part("MoonObservatory", Vector3.new(-180,11.5,18), Vector3.new(8,2,8), Color3.fromRGB(110,135,210), true)
local star = part("MoonObservatoryStar", Vector3.new(-180,15,18), Vector3.new(3,3,3), Color3.fromRGB(255,230,120), false)
star.Material = Enum.Material.Neon
star.Shape = Enum.PartType.Ball
label(star,"Estrela do observatório")
star.Touched:Connect(function(hit)
    local p = playerFromHit(hit,star)
    if not p or not state[p] then return end
    if not DiscoveryLedger.claim(discovered,p.UserId,"moon-observatory") then return end
    reward(p,30,0,"Observatório lunar descoberto! +30 estrelas")
end)
