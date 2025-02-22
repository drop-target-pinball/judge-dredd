local spin = require('spin')
local std = require('std')
local jd = require('jd')

local pub = {}

local function blinking_score(title)
    local gfx = spin.gfx(jd.DMD, 1)
    local function draw(on)
        gfx.new(spin.OFF)
        gfx.font = jd.PF_ARMA_FIVE_8
        gfx.draw_text_y(-2, title)
        if on then
            gfx.font = jd.DMD_14X10
            gfx.draw_text_y(12, spin.format_score(spin.player().int(jd.SNIPER_BONUS)))
        end
    end

    for i=1,6 do
        draw(true)
        spin.sleep(0.25)
        draw(false)
        spin.sleep(0.10)
    end
end

function pub.sniper()
    spin.reset_timer(jd.SNIPER_SCORE)
    spin.run(jd.SNIPER_DRAW)
    spin.run(jd.SNIPER_AUDIO)

    spin.sleep(5.25)
    spin.blink_driver(jd.AWARD_SNIPER)
    spin.start_timer(jd.SNIPER_SCORE)
    spin.pulse_driver(jd.RIGHT_POPPER)

    local kind = spin.wait(
        spin.for_ball(jd.RIGHT_POPPER, 0.5),
        spin.for_any(std.TIMER_EXPIRED)
    )
    if kind == std.BALL_ARRIVED then
        spin.stop_timer(jd.SNIPER_SCORE)
        spin.run(jd.SNIPER_FALL)
        spin.player().add_int(jd.SNIPER_BONUS, spin.int(jd.SNIPER_SCORE))
    else
        spin.kill_group(jd.SNIPER)
        spin.play_music(jd.MAIN_THEME)
        spin.gfx(jd.DMD, 1).new(spin.CLEAR)
        spin.stop_driver(jd.AWARD_SNIPER)
    end
end

function pub.sniper_draw()
    spin.run(jd.SNIPER_INTRO_DRAW)
    spin.wait(spin.for_script(jd.SNIPER_INTRO_DRAW))
    spin.run(jd.SNIPER_SCORE_DRAW)
end

function pub.sniper_intro_draw()
    local gfx = spin.gfx(jd.DMD, 1)

    local function draw(on)
        gfx.new(spin.OFF)
        gfx.font = jd.PF_ARMA_FIVE_8
        gfx.draw_text_y(-2, "SNIPER")
        if on then
            gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
            gfx.draw_text_y(8, "SHOOT")
            gfx.draw_text_y(18, "SNIPER TOWER")
        end
    end

    for i=0,9 do
        draw(true)
        spin.sleep(0.25)
        draw(false)
        spin.sleep(0.10)
    end
end

function pub.sniper_score_draw()
    local gfx = spin.gfx(jd.DMD, 1)
    while true do
        gfx.new(spin.OFF)
        gfx.font = jd.PF_ARMA_FIVE_8
        gfx.draw_text_y(-2, "SNIPER")
        gfx.font = jd.DMD_14X10
        gfx.draw_text_y(12, spin.format_score(spin.int(jd.SNIPER_SCORE)))
        spin.wait(spin.for_any(std.TICK))
    end
end

function pub.sniper_audio()
    spin.play_music(jd.MODE_THEME_1)
    spin.play_vocal(jd.SNIPER_IS_SHOOTING_INTO_THE_CROWD_FROM_JOHNSON_TOWER)
    spin.sleep(4)
    spin.play_vocal(jd.SHOOT_SNIPER_TOWER)
    spin.sleep(1)
    while true do
        spin.play_sound(jd.GUN_LOAD_SNIPER)
        spin.sleep(1.5)
        spin.play_sound(jd.GUNFIRE)
        spin.sleep(1.5)
    end
end

-------------------------------------------------------------------------------
function pub.sniper_fall()
    spin.reset_timer(jd.SNIPER_FALL)
    spin.stop_driver(jd.AWARD_SNIPER)

    spin.run(jd.SNIPER_FALL_DRAW)
    spin.run(jd.SNIPER_FALL_AUDIO)

    spin.sleep(4)
    spin.blink_driver(jd.AWARD_SNIPER)
    spin.pulse_driver(jd.RIGHT_POPPER)
    spin.start_timer(jd.SNIPER_FALL)

    local kind = spin.wait(
        spin.for_ball(jd.RIGHT_POPPER, 0.5),
        spin.for_any(std.TIMER_EXPIRED)
    )
    if kind == std.BALL_ARRIVED then
        spin.player().add_int(jd.SNIPER_BONUS, spin.int(jd.SNIPER_SCORE))
        spin.stop_timer(jd.SNIPER_FALL)
        spin.run(jd.SNIPER_SUCCESS)
    else
        spin.run(jd.SNIPER_FAILURE)
    end
end

function pub.sniper_fall_draw()
    spin.run(jd.SNIPER_FALL_INTRO_DRAW)
    spin.wait(spin.for_script(jd.SNIPER_FALL_INTRO_DRAW))
    spin.run(jd.SNIPER_FALL_TIMER_DRAW)
end

function pub.sniper_fall_intro_draw()
    blinking_score("SNIPER")
end

function pub.sniper_fall_timer_draw()
    local gfx = spin.gfx(jd.DMD, 1)
    local dmd = spin.video(jd.DMD)

    while true do
        gfx.new(spin.OFF)
        gfx.font = jd.PF_ARMA_FIVE_8
        gfx.draw_text_y(-2, "SNIPER")
        gfx.draw_text_y(dmd.height, "SHOOT TOWER", {bottom=true})

        gfx.font = jd.DMD_14X10
        gfx.draw_text_x(5, spin.int(jd.SNIPER_FALL_TIMER))

        gfx.font = jd.DMD_09X7
        gfx.draw_text_x(dmd.width - 2, spin.format_score(spin.int(jd.SNIPER_SCORE)), {right=true})
        spin.wait(spin.for_any(std.TICK))
    end
end


function pub.sniper_fall_audio()
    spin.stop_vocal()
    spin.play_music(jd.MODE_THEME_1, {no_restart=true})
    spin.play_sound(jd.SUCCESS_SNIPER)
    spin.sleep(2.5)
    spin.play_vocal(jd.SHOOT_SNIPER_TOWER, {notify=true})
    spin.wait(spin.for_any(std.VOCAL_ENDED))
    spin.play_vocal(jd.AAAAAH)
    spin.sleep(3)
    spin.play_vocal(jd.ITS_A_LONG_WAY_DOWN)
    spin.sleep(2.5)
    spin.play_vocal(jd.AAAAAH)
    spin.sleep(3.5)
    spin.play_vocal(jd.I_CAN_SEE_MY_HOUSE_FROM_HERE)
    spin.sleep(2)
    spin.play_vocal(jd.AAAAAH)
end

function pub.sniper_failure()
    spin.stop_driver(jd.AWARD_SNIPER)

    local gfx = spin.gfx(jd.DMD, 1).new(spin.OFF)
    gfx.font = jd.PF_ARMA_FIVE_8
    gfx.draw_text_y(-2, "SNIPER")
    gfx.font = jd.DMD_14X10
    gfx.draw_text_y(12, spin.format_score(spin.player().int(jd.SNIPER_BONUS)))

    spin.stop_vocal()
    spin.play_music(jd.MAIN_THEME)
    spin.play_sound(jd.SNIPER_SPLAT)
    spin.sleep(1)
    spin.play_vocal(jd.SNIPER_ELIMINATED)
    spin.sleep(2)
    spin.gfx(jd.DMD, 1).new(spin.CLEAR)
end

function pub.sniper_success()
    spin.stop_driver(jd.AWARD_SNIPER)

    spin.stop_vocal()
    spin.play_music(jd.MAIN_THEME)
    spin.play_sound(jd.SNIPER_SPLAT)
    spin.sleep(1)
    spin.play_vocal(jd.SNIPER_ELIMINATED)
    spin.sleep(2)
    spin.play_sound(jd.SUCCESS_SNIPER)
    blinking_score("SNIPER TOTAL")
    spin.pulse_driver(jd.RIGHT_POPPER)
    spin.gfx(jd.DMD, 1).new(spin.CLEAR)
end

-------------------------------------------------------------------------------
local test = require("test")

function pub.test_sniper_failure()
    spin.run(jd.SNIPER)
    spin.sleep(8)
    spin.set(jd.SNIPER_SCORE, 3550700)
    test.wait(10, "script end", spin.for_script(jd.SNIPER))
end

function pub.test_sniper_fall_failure()
    spin.run(jd.SNIPER)
    spin.sleep(6)
    spin.switch_updated(jd.RIGHT_POPPER)
    spin.sleep(7)
    spin.set(jd.SNIPER_FALL_TIMER, 2)
    test.wait(10, "script end", spin.for_script(jd.SNIPER_FAILURE))
end

function pub.test_sniper_success()
    spin.run(jd.SNIPER)
    spin.sleep(6)
    spin.switch_updated(jd.RIGHT_POPPER)
    spin.sleep(7)
    spin.switch_updated(jd.RIGHT_POPPER)
    test.wait(10, "script end", spin.for_script(jd.SNIPER_SUCCESS))
end

return pub
