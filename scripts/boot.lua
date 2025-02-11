local spin = require("spin")
local jd = require("jd")

local pub = {}

function pub.boot()
    local gfx = spin.gfx(jd.DMD)
    gfx.clear()
    gfx.dot_on()
    gfx.font(jd.PF_TEMPESTA_FIVE_COMPRESSED_BOLD)
    gfx.draw_text_y(4, string.upper(spin.runtime.prog_description))
    gfx.draw_text_y(14, "V" .. string.upper(spin.runtime.prog_version))
    gfx.draw_text_y(24, string.upper(spin.runtime.prog_date))
    spin.play_music(jd.BOOT)
end

return pub
