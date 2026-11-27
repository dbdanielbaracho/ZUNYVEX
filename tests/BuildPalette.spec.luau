local Palette = require("../src/ReplicatedStorage/BuildPalette")
assert(#Palette.entries == 4)
local names = {"Sky", "Pink", "Gold", "Mint"}
for i, entry in ipairs(Palette.entries) do
    assert(entry.name == names[i])
    assert(Palette.match(entry.r/255, entry.g/255, entry.b/255) == i)
    assert(Palette.match(entry.r/255 + 0.001, entry.g/255, entry.b/255) == i)
    assert(table.isfrozen(entry))
end
assert(table.isfrozen(Palette.entries))
assert(table.isfrozen(Palette))
assert(Palette.match(0, 0, 0) == nil)
assert(Palette.match(1, 1, 1) == nil)
assert(Palette.match(0/0, 0, 0) == nil)
assert(Palette.match(math.huge, 0, 0) == nil)
print("BuildPalette spec passed")
