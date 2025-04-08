local spin = require("spin")
local vars = spin.vars
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

function pub.game()
    spin.reset_lights()
    spin.run(jd.SCORE_DRAW)
    spin.run(jd.PLUNGE)
    spin.run(jd.ADD_PLAYER_WATCH)
end

function pub.plunge()
    if not spin.switches[jd.RIGHT_SHOOTER_LANE].active then
        spin.pulse_driver(jd.TROUGH)
    end
    spin.run(jd.PLUNGE_AUDIO)
    spin.wait(spin.for_switch(jd.RIGHT_FIRE_BUTTON))
    spin.run(jd.MANUAL_LAUNCH)
    spin.kill_group(jd.PLUNGE)
end

function pub.plunge_audio()
    spin.play_music(jd.PLUNGE_LOOP)
    if vars.player == 1 and vars.ball == 1 and not vars.is_extra_ball then
        spin.play_vocal(jd.LAW_MASTER_COMPUTER_ONLINE_WELCOME_ABOARD)
    end
    spin.sleep(7)
    spin.run(jd.PLUNGE_USE_FIRE_BUTTON_TO_LAUNCH_BALL)
end

function pub.plunge_use_fire_button_to_launch_ball()
    local gfx = spin.gfx(jd.DMD, 1)

    spin.play_vocal(jd.USE_FIRE_BUTTON_TO_LAUNCH_BALL)

    local chevrons = {
        "   ",
        ">  ",
        ">> ",
        ">>>"
    }

    for i=0,7*4 do
        gfx.fill(spin.BLACK)
        gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
        gfx.draw_text_y(3, "USE")
        gfx.draw_text_y(14, "FIRE BUTTON")

        gfx.draw_text_x(110, chevrons[(i % 4) + 1])
        spin.sleep(0.1)
    end
    gfx.fill(spin.CLEAR)
end

function pub.manual_launch()
    spin.stop_vocal()
    spin.pulse_driver(jd.RIGHT_SHOOTER_LANE)
    spin.play_music(jd.MAIN_THEME)
    spin.play_sound(jd.MOTORCYCLE_START)
end


return pub