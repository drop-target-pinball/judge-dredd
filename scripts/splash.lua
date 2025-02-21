local spin = require("spin")
local jd = require("jd")

local pub = {}

function pub.splash()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_TEMPESTA_FIVE_COMPRESSED_BOLD_8
    gfx.draw_text_y(0, string.upper(spin.runtime.prog_description))
    gfx.draw_text_y(10, "V" .. string.upper(spin.runtime.prog_version))
    gfx.draw_text_y(20, string.upper(spin.runtime.prog_date))
    spin.play_music(jd.BOOT, {loops=1})

    spin.wait(spin.for_time(8), spin.for_switch(jd.START_BUTTON))
    spin.stop_music()
end

-------------------------------------------------------------------------------
local test = require("test")

function pub.test_splash()
    spin.run(jd.SPLASH)
    spin.sleep(1)
    test.press(jd.START_BUTTON)
    test.wait(1, "script end", spin.for_script(jd.SPLASH))
end

return pub
