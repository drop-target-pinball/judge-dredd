local spin = require("spin")
local jd = require("jd")

local pub = {}

function pub.main()
    spin.run(jd.START_SERVICE)
    while true do
        spin.run(jd.ATTRACT)
        spin.wait(spin.for_eq(jd.GAME_ACTIVE, true))
        spin.reset_lights()
        spin.run(jd.GAME)
        spin.wait(spin.forever())
    end
end


return pub
