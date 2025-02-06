local spin = require("spin")
local std = require("std")
local jd = require("jd")

local pub = {}

function pub.add_player_watch()
    spin.wait(spin.for_eq(std.PLAYER_COUNT, 2))
    spin.play_vocal(jd.PLAYER_2)

    spin.wait(spin.for_eq(std.PLAYER_COUNT, 3))
    spin.play_vocal(jd.PLAYER_3)

    spin.wait(spin.for_eq(std.PLAYER_COUNT, 4))
    spin.play_vocal(jd.PLAYER_4)
end

function pub.main()
    spin.run(jd.PLUNGE)
    spin.run(jd.ADD_PLAYER_WATCH)
end

return pub