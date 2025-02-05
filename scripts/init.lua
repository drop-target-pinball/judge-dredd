local spin = require("spin")
local std = require("std")
local jd = require("jd")

local pub = {}

function pub.init()
    spin.run(std.START_SERVICE)
    spin.run(jd.ATTRACT)
end

return pub
