local spin = require("spin")
local jd = require('jd')

local pub = {}

function pub.plunge()
    spin.play_music(jd.PLUNGE_LOOP)
    if spin.int(jd.PLAYER) == 1 and spin.int(jd.BALL) == 1 and spin.bool(jd.IS_EXTRA_BALL) then
        spin.play_vocal(jd.LAW_MASTER_COMPUTER_ONLINE_WELCOME_ABOARD)
    end
    spin.sleep(7)
    spin.run(jd.USE_FIRE_BUTTON_TO_LAUNCH_BALL)
end

function pub.use_fire_button_to_launch_ball()
    local gfx = spin.gfx(jd.DMD, 1)

    spin.play_vocal(jd.USE_FIRE_BUTTON_TO_LAUNCH_BALL)

    local chevrons = {
        "   ",
        ">  ",
        ">> ",
        ">>>"
    }

    for i=0,7*4 do
        gfx.new(gfx.BLACK)
        gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
        gfx.draw_text_y(3, "USE")
        gfx.draw_text_y(14, "FIRE BUTTON")

        gfx.draw_text_x(110, chevrons[(i % 4) + 1])
        spin.sleep(0.1)
    end
    gfx.new(gfx.CLEAR)
end

function pub.launch()
    spin.stop_vocal()
    spin.play_music(jd.MAIN_THEME)
    spin.play_sound(jd.MOTORCYCLE_START)
end

return pub



