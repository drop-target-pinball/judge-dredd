local spin = require('spin')
local std = require('std')
local jd = require('jd')

local pub = {}

function pub.multiball()
    spin.run('multiball_audio')
end

function pub.multiball_audio()
    spin.play_music(jd.MULTIBALL_INTRO, {loops=1, notify=true})
    spin.wait_for(std.MUSIC_ENDED)
    spin.play_music(jd.MULTIBALL)
end

function pub.left_ramp_runway_lights()
    spin.schedule_driver(jd.LEFT_MODE_START, {
        {true, 0.25},
        {false, 0.75},
    })
    spin.schedule_driver(jd.LOCK_1, {
        {false, 0.0625},
        {true, 0.25},
        {false, 0.6875},
    })
    spin.schedule_driver(jd.LOCK_2, {
        {false, 0.125},
        {true, 0.25},
        {false, 0.625},
    })
    spin.schedule_driver(jd.LOCK_3, {
        {false, 0.1875},
        {true, 0.25},
        {false, 0.5625}
    })
    spin.schedule_driver(jd.LEFT_PURSUIT, {
        {false, 0.5},
        {true, 0.0625},
        {false, 0.4375},
    })
end

return pub
