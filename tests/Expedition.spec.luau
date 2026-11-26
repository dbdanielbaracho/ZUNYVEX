local E = require("../src/ReplicatedStorage/Expedition")
local a,b=E.new(),E.new()
for _, id in {0,6,1.5,0/0,math.huge} do assert(E.collect(a,id)=="ignored") end
assert(E.collect(a,5)=="advanced")
assert(E.collect(a,5)=="ignored")
assert(b.count==0)
for _, id in {3,1,4} do assert(E.collect(a,id)=="advanced") end
assert(E.collect(a,2)=="finished")
assert(a.count==5 and a.finished)
assert(E.collect(a,2)=="ignored")
assert(E.collect(b,2)=="advanced")
assert(b.count==1 and not b.finished)
print("Expedition spec passed")
