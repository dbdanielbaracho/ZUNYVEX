--!strict
local Codec = require("../src/ServerScriptService/BuildPersistence")
local function piece(x: number, y: number, z: number, color: string)
    return {x=x,y=y,z=z,color=color}
end
local valid = {piece(-104,4,104,"Sky"),piece(0,44,0,"Mint")}
local encoded = assert(Codec.encode(valid))
local decoded = assert(Codec.decode(encoded))
assert(#decoded == 2 and decoded[1].x == -104 and decoded[2].color == "Mint")
assert(Codec.encode({}) ~= nil)
assert(Codec.encode({piece(0,4,0,"Sky"),piece(0,4,0,"Pink")}) == nil)
for _, entry in ipairs({piece(1,4,0,"Sky"),piece(108,4,0,"Sky"),piece(0,0,0,"Sky"),piece(0,48,0,"Sky"),piece(0,4,0,"Invalid"),piece(0/0,4,0,"Sky"),piece(math.huge,4,0,"Sky")}) do
    assert(Codec.encode({entry}) == nil)
end
local many = {}
for i=1,80 do
    table.insert(many,piece((i%20)*4,4,math.floor(i/20)*4,"Gold"))
end
assert(Codec.encode(many) ~= nil)
table.insert(many,piece(-4,4,0,"Gold"))
assert(Codec.encode(many) == nil)
assert(Codec.decode({version=2,pieces={}}) == nil)
assert(Codec.decode({version=1,pieces={{0,4,0,"Sky",true}}}) == nil)
assert(Codec.decode({version=1,pieces={[2]={0,4,0,"Sky"}}}) == nil)
print("BuildPersistence spec passed")
