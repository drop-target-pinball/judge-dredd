local spin = require("spin")
local std = require("std")
local jd = require("jd")

local pub = {}

function pub.attract()
    spin.run(jd.ATTRACT_SLIDE_SHOW)
    spin.wait(spin.for_eq(std.GAME_ACTIVE, true))
    spin.run(jd.MAIN)
end

function pub.attract_slide_show()
    local slides = {
        jd.ATTRACT_GAME_OVER,
        jd.ATTRACT_DTP_PRESENTS,
        jd.ATTRACT_JD_REMIX,
        jd.ATTRACT_PAYMENT,
        jd.ATTRACT_GC
    }
    local n = 5
    local curr = 1

    local next = function()
        curr = curr + 1
        if curr > 5 then
            curr = 1
        end
    end

    while true do
        spin.run(slides[curr])
        spin.sleep(4)
        next()
    end
end

function pub.attract_game_over()
    local gfx = spin.gfx(jd.DMD)
    gfx.clear()
    gfx.font(jd.PF_RONDA_SEVEN_BOLD_8)
    gfx.draw_centered_text("GAME OVER")
end

function pub.attract_dtp_presents()
    local gfx = spin.gfx(jd.DMD)
    gfx.clear()
    gfx.font(jd.PF_ARMA_FIVE_8)
    gfx.draw_text_y(3, "DROP TARGET PINBALL")
    gfx.font(jd.PF_RONDA_SEVEN_BOLD_8)
    gfx.draw_text_y(14, "PRESENTS")
end

function pub.attract_jd_remix()
    local gfx = spin.gfx(jd.DMD)
    gfx.clear()
    gfx.font(jd.PF_RONDA_SEVEN_BOLD_8)
    gfx.draw_text_y(3, "JUDGE DREDD")
    gfx.draw_text_y(14, "REMIX")
end

function pub.attract_payment()
    local gfx = spin.gfx(jd.DMD)
    gfx.font(jd.PF_RONDA_SEVEN_BOLD_8)

    local draw = function(on)
        gfx.clear()
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
    local gfx = spin.gfx(jd.DMD)
    gfx.clear()
    gfx.font(jd.PF_RONDA_SEVEN_BOLD_8)
    gfx.draw_text_y(3, "GRAND CHAMPION")
    gfx.draw_text_y(14, "MCG  500,000,000")
end

return pub
