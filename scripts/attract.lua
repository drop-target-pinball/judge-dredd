local spin = require("spin")
local std = require("std")
local jd = require("jd")

local pub = {}

function pub.attract()
    spin.run(jd.ATTRACT_SLIDE_SHOW)
end

function pub.attract_slide_show()
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

return pub
