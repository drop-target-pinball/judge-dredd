local spin = require("spin")
local jd = require("jd")

local pub = {}

function pub.init()
    spin.run(jd.START_SERVICE)
    spin.run(jd.ATTRACT)
end

return pub
