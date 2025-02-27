local spin = require("spin")
local jd = require("jd")

local pub = {}

function pub.init()
    spin.run(jd.GI_ON)
    spin.run(jd.SPLASH)
    spin.wait(spin.for_script(jd.SPLASH))
    spin.run(jd.MAIN)
end

function pub.gi_on()
    spin.start_driver(jd.GI_1)
    spin.start_driver(jd.GI_2)
    spin.start_driver(jd.GI_3)
    spin.start_driver(jd.GI_4)
    spin.start_driver(jd.GI_5)
end

return pub


