local spin = require("spin")
local std = require("std")
local jd = require("jd")

local pub = {}

function pub.attract()
    spin.run(jd.ATTRACT_CYCLE_LIGHTS)

    local slides = {
        jd.ATTRACT_GAME_OVER,
        jd.ATTRACT_DTP_PRESENTS,
        jd.ATTRACT_JD_REMIX,
        jd.ATTRACT_PAYMENT,
        jd.ATTRACT_GC,
        jd.ATTRACT_HST_1,
        jd.ATTRACT_HST_2,
        jd.ATTRACT_HST_3,
        jd.ATTRACT_HST_4,
    }
    local n = 9
    local curr = 1

    local next = function()
        curr = curr + 1
        if curr > n then
            curr = 1
        end
    end

    local prev = function()
        curr = curr - 1
        if curr < 1 then
            curr = n
        end
    end

    while true do
        spin.run(slides[curr])
        local kind, msg = spin.wait(
            spin.for_time(4),
            spin.for_switch(jd.LEFT_FLIPPER_BUTTON),
            spin.for_switch(jd.RIGHT_FLIPPER_BUTTON)
        )
        if kind == jd.SWITCH_UPDATED then
            if msg.name == jd.LEFT_FLIPPER_BUTTON then
                prev()
            else
                next()
            end
        else
            next()
        end
    end
end

function pub.attract_game_over()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_centered_text("GAME OVER")
end

function pub.attract_dtp_presents()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_ARMA_FIVE_8
    gfx.draw_text_y(3, "DROP TARGET PINBALL")
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(14, "PRESENTS")
end

function pub.attract_jd_remix()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(3, "JUDGE DREDD")
    gfx.draw_text_y(14, "REMIX")
end

function pub.attract_payment()
    local gfx = spin.gfx(jd.DMD)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8

    local draw = function(on)
        gfx.new(spin.OFF)
        if on then
            gfx.draw_text_y(3, "PRESS START")
        end
        gfx.draw_text_y(14, "FREE PLAY")
    end

    for i=1,5 do
        draw(true)
        spin.sleep(0.2)
        draw(false)
        spin.sleep(0.1)
    end
    draw(true)
end

function pub.attract_gc()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(3, "GRAND CHAMPION")
    gfx.draw_text_y(14, "MCG  500,000,000")
end

function pub.attract_hst_1()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(3, "HIGH SCORES")
    gfx.draw_text_y(14, "1) TSM  450,000,000")
end

function pub.attract_hst_2()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(3, "HIGH SCORES")
    gfx.draw_text_y(14, "2) DLB  400,000,000")
end

function pub.attract_hst_3()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(3, "HIGH SCORES")
    gfx.draw_text_y(14, "3) KID  350,000,000")
end

function pub.attract_hst_4()
    local gfx = spin.gfx(jd.DMD).new(spin.OFF)
    gfx.font = jd.PF_RONDA_SEVEN_BOLD_8
    gfx.draw_text_y(3, "HIGH SCORES")
    gfx.draw_text_y(14, "4) DAG  300,000,000")
end

-------------------------------------------------------------------------------
function pub.attract_cycle_lights()
    local left_ramp = {
        jd.LEFT_MODE_START,
        jd.LOCK_3,
        jd.LOCK_2,
        jd.LOCK_1,
    }

    local inner_loop_crime_scene = {
        jd.INNER_LOOP_CRIME_SCENE_WHITE,
        jd.INNER_LOOP_CRIME_SCENE_RED,
        jd.INNER_LOOP_CRIME_SCENE_YELLOW,
        jd.INNER_LOOP_CRIME_SCENE_GREEN
    }

    local left_loop_crime_scene = {
        jd.LEFT_LOOP_CRIME_SCENE_WHITE,
        jd.LEFT_LOOP_CRIME_SCENE_RED,
        jd.LEFT_LOOP_CRIME_SCENE_YELLOW,
        jd.LEFT_LOOP_CRIME_SCENE_GREEN
    }

    local right_loop_crime_scene = {
        jd.RIGHT_LOOP_CRIME_SCENE_WHITE,
        jd.RIGHT_LOOP_CRIME_SCENE_RED,
        jd.RIGHT_LOOP_CRIME_SCENE_YELLOW,
        jd.RIGHT_LOOP_CRIME_SCENE_GREEN,
    }

    local right_popper_crime_scene = {
        jd.RIGHT_POPPER_CRIME_SCENE_WHITE,
        jd.RIGHT_POPPER_CRIME_SCENE_RED,
        jd.RIGHT_POPPER_CRIME_SCENE_YELLOW,
        jd.RIGHT_POPPER_CRIME_SCENE_GREEN,
    }

    local right_ramp_crime_scene = {
        jd.RIGHT_RAMP_CRIME_SCENE_WHITE,
        jd.RIGHT_RAMP_CRIME_SCENE_RED,
        jd.RIGHT_RAMP_CRIME_SCENE_YELLOW,
        jd.RIGHT_RAMP_CRIME_SCENE_GREEN,
    }

    local crime_levels = {
        jd.CLASS_X_FELONY,
        jd.FELONY,
        jd.MISDEMEANOR,
        jd.WARNING,
        jd.MISDEMEANOR,
        jd.FELONY,
    }

    local chain = {
        jd.STAKEOUT,
        jd.MANHUNT,
        jd.SAFE_CRACKER,
        jd.MELTDOWN,
        jd.BAD_IMPERSONATOR,
        jd.BATTLE_TANK,
        jd.SNIPER,
        jd.BLACKOUT,
        jd.PURSUIT,
        jd.BLACKOUT,
        jd.SNIPER,
        jd.BATTLE_TANK,
        jd.BAD_IMPERSONATOR,
        jd.MELTDOWN,
        jd.SAFE_CRACKER,
        jd.MANHUNT,
    }

    local above_chain = {
        "",
        jd.AWARD_MELTDOWN,
        jd.ULTIMATE_CHALLENGE,
        jd.MYSTERY,
    }

    local judge = {
        jd.DROP_TARGET_E,
        jd.DROP_TARGET_G,
        jd.DROP_TARGET_D,
        jd.DROP_TARGET_U,
        jd.DROP_TARGET_J,
    }

    local below_judge = {
        jd.RIGHT_TANK,
        jd.CENTER_TANK,
        jd.AWARD_SAFE_CRACKER,
        jd.MULTIBALL_JACKPOT,
        jd.AWARD_BAD_IMPERSONATOR,
        jd.LEFT_TANK,
    }

    local upper_right = {
        "",
        "",
        "",
        "",
        jd.EXTRA_BALL,
        jd.AIR_RAID,
        jd.RIGHT_MODE_START,
        jd.AWARD_SNIPER,
    }

    local function cycle(lamps)
        if lamps[1] ~= "" then
            spin.stop_driver(lamps[1])
        end
        table.insert(lamps, 1, table.remove(lamps))
        if lamps[1] ~= "" then
            spin.start_driver(lamps[1])
        end
    end

    while true do
        cycle(left_ramp)
        cycle(inner_loop_crime_scene)
        cycle(left_loop_crime_scene)
        cycle(right_loop_crime_scene)
        cycle(right_popper_crime_scene)
        cycle(right_ramp_crime_scene)
        cycle(crime_levels)
        cycle(chain)
        cycle(above_chain)
        cycle(judge)
        cycle(below_judge)
        cycle(upper_right)
        spin.sleep(0.15)
    end
end


-------------------------------------------------------------------------------
local test = require("test")

function pub.test_attract()
    spin.run(jd.MAIN)
    for i=1,9 do
        test.press(jd.RIGHT_FLIPPER_BUTTON)
        spin.sleep(0.25)
    end
    for i=1,9 do
        test.press(jd.LEFT_FLIPPER_BUTTON)
        spin.sleep(0.25)
    end
    test.press(jd.START_BUTTON)
    test.wait(2, "script end", spin.for_script(jd.ATTRACT))
end


return pub
