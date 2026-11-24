--!strict
-- Playful five-checkpoint starter course; generated only for the ZUNYVEX private Place.
-- Existing authored courses take precedence. No DataStore writes or external calls.
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")
local EXPECTED_PLACE_ID = 112566849572143
if game.PlaceId ~= EXPECTED_PLACE_ID then return end
if #CollectionService:GetTagged("ZunyvexRaceStart") > 0 or #CollectionService:GetTagged("ZunyvexRaceCheckpoint") > 0 then return end
local folder = Instance.new("Folder")
folder.Name = "ZunyvexStarterRace"
folder.Parent = Workspace
local positions = {
    Vector3.new(0, 5, -80),
    Vector3.new(22, 5, -105),
    Vector3.new(45, 5, -85),
    Vector3.new(45, 5, -45),
    Vector3.new(15, 5, -25),
    Vector3.new(-10, 5, -45),
}
local function gate(name: string, pos: Vector3, index: number?)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = Vector3.new(13, 10, 2)
    part.CFrame = CFrame.new(pos)
    part.Anchored = true
    part.CanCollide = false
    part.CanTouch = true
    part.Material = Enum.Material.Neon
    part.Transparency = 0.45
    part.Color = if index then Color3.fromRGB(56, 205, 255) else Color3.fromRGB(94, 240, 132)
    if index then part:SetAttribute("CheckpointIndex", index) end
    part.Parent = folder
    CollectionService:AddTag(part, if index then "ZunyvexRaceCheckpoint" else "ZunyvexRaceStart")
end
gate("Largada", positions[1], nil)
for i = 1, 5 do gate("Checkpoint_" .. i, positions[i + 1], i) end

-- Continuous walkable route: the previous version spawned gates in midair.
-- These anchored platforms and bridges are decorative starter geometry only.
-- Authored courses remain untouched because generation exits when tags exist.
local function platform(name: string, position: Vector3, size: Vector3, color: Color3)
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.CanCollide = true
    part.CanTouch = false
    part.Size = size
    part.Material = Enum.Material.SmoothPlastic
    part.Color = color
    part.Position = position
    part.Parent = folder
end
local deckY = positions[1].Y - 5.5
for index, position in positions do
    platform("RacePlatform_" .. index, Vector3.new(position.X, deckY, position.Z),
        Vector3.new(18, 1, 18), Color3.fromRGB(80, 94, 155))
end
for index = 1, #positions - 1 do
    local a = positions[index]
    local b = positions[index + 1]
    local midpoint = (a + b) / 2
    local delta = b - a
    local bridge = Instance.new("Part")
    bridge.Name = "RaceBridge_" .. index
    bridge.Anchored = true
    bridge.CanCollide = true
    bridge.CanTouch = false
    bridge.Material = Enum.Material.SmoothPlastic
    bridge.Color = Color3.fromRGB(109, 117, 185)
    bridge.Size = Vector3.new(14, 1, delta.Magnitude + 2)
    bridge.CFrame = CFrame.lookAt(Vector3.new(midpoint.X, deckY, midpoint.Z),
        Vector3.new(b.X, deckY, b.Z))
    bridge.Parent = folder
end
