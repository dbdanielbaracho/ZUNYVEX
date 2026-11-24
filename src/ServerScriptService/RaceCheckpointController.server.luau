--!strict
-- Server owns race progress; physical tagged gates only.
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local feedback = ReplicatedStorage:FindFirstChild("ZunyvexRaceFeedback")
if not feedback then
    feedback = Instance.new("RemoteEvent")
    feedback.Name = "ZunyvexRaceFeedback"
    feedback.Parent = ReplicatedStorage
end
assert(feedback:IsA("RemoteEvent"), "Invalid race feedback instance")
local feedbackEvent = feedback :: RemoteEvent
local Race = require(script.Parent:WaitForChild("CheckpointRace"))
local CHECKPOINT_COUNT = 5
local race = Race.new(CHECKPOINT_COUNT, 180)
local connections: {[Instance]: RBXScriptConnection} = {}
local lastTouch: {[number]: {[Instance]: number}} = {}
local lastGate: {[number]: {position: Vector3, at: number}} = {}
local MAX_PLAUSIBLE_SPEED = 120

local function playerFromHit(hit: BasePart): Player?
    local model = hit:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return nil end
    local player = Players:GetPlayerFromCharacter(model)
    if not player or player.Character ~= model then return nil end
    return player
end

local function attach(part: Instance, isStart: boolean)
    if connections[part] or not part:IsA("BasePart") then return end
    connections[part] = part.Touched:Connect(function(hit: BasePart)
        local player = playerFromHit(hit)
        if not player then return end
        local now = os.clock()
        local touches = lastTouch[player.UserId]
        if not touches then
            touches = {}
            lastTouch[player.UserId] = touches
        end
        if touches[part] and now - touches[part] < 0.15 then return end
        touches[part] = now
        if isStart then
            if race.start(player.UserId, now) then
                lastGate[player.UserId] = {position = part.Position, at = now}
                feedbackEvent:FireClient(player, "start", 0, CHECKPOINT_COUNT)
            end
            return
        end
        local index = part:GetAttribute("CheckpointIndex")
        if typeof(index) ~= "number" or index % 1 ~= 0 or index < 1 or index > CHECKPOINT_COUNT then return end
        local previous = lastGate[player.UserId]
        if not previous then return end
        if now - previous.at < (part.Position - previous.position).Magnitude / MAX_PLAUSIBLE_SPEED then return end
        local status, elapsed = race.touch(player.UserId, index, now)
        if status == "checkpoint" then
            lastGate[player.UserId] = {position = part.Position, at = now}
            feedbackEvent:FireClient(player, "checkpoint", index, CHECKPOINT_COUNT)
        elseif status == "finished" then
            lastGate[player.UserId] = nil
            feedbackEvent:FireClient(player, "finished", elapsed, CHECKPOINT_COUNT)
        elseif status == "timed_out" then
            lastGate[player.UserId] = nil
            feedbackEvent:FireClient(player, "timed_out", 0, CHECKPOINT_COUNT)
        end
    end)
end

local function resetPlayer(player: Player)
    race.leave(player.UserId)
    lastTouch[player.UserId] = nil
    lastGate[player.UserId] = nil
end
local function watchPlayer(player: Player)
    player.CharacterRemoving:Connect(function() resetPlayer(player) end)
end
Players.PlayerAdded:Connect(watchPlayer)
for _, player in Players:GetPlayers() do watchPlayer(player) end
local function detach(part: Instance)
    local connection = connections[part]
    if connection then connection:Disconnect(); connections[part] = nil end
    for _, touches in lastTouch do touches[part] = nil end
end
for _, part in CollectionService:GetTagged("ZunyvexRaceStart") do attach(part, true) end
for _, part in CollectionService:GetTagged("ZunyvexRaceCheckpoint") do attach(part, false) end
CollectionService:GetInstanceAddedSignal("ZunyvexRaceStart"):Connect(function(part) attach(part, true) end)
CollectionService:GetInstanceAddedSignal("ZunyvexRaceCheckpoint"):Connect(function(part) attach(part, false) end)
CollectionService:GetInstanceRemovedSignal("ZunyvexRaceStart"):Connect(detach)
CollectionService:GetInstanceRemovedSignal("ZunyvexRaceCheckpoint"):Connect(detach)
Players.PlayerRemoving:Connect(resetPlayer)
