local spin = require("spin")
local std = require("std")
local jd = require("jd")

local pub = {}

function pub.attract()
    spin.wait(spin.for_eq(std.GAME_ACTIVE, true))
    spin.run(jd.START_GAME)
end

return pub
