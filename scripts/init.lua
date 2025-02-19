local spin = require("spin")
local jd = require("jd")

local pub = {}

function pub.init()
    spin.run(jd.SPLASH)
    spin.wait(spin.for_script(jd.SPLASH))
    spin.run(jd.MAIN)
end

return pub


