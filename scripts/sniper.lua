local spin = require('spin')
local jd = require('jd')

local pub = {}

function pub.sniper()
    spin.run(jd.SNIPER_AUDIO)
end

function pub.sniper_audio()
    spin.play_music(jd.MODE_THEME_1)
    spin.play_vocal(jd.SNIPER_IS_SHOOTING_INTO_THE_CROWD_FROM_JOHNSON_TOWER)
    spin.sleep(4)
    spin.play_vocal(jd.SHOOT_SNIPER_TOWER)
end

function pub.sniper2()
    spin.run(jd.SNIPER2_AUDIO)
end

function pub.sniper2_audio()
    spin.play_sound(jd.SUCCESS)
    spin.sleep(2.5)
    spin.play_vocal(jd.SHOOT_SNIPER_TOWER, {notify=true})
    spin.wait_for(jd.VOCAL_ENDED)
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

function pub.sniper_success()
    spin.play_music(jd.MAIN_THEME)
    spin.play_sound(jd.SNIPER_SPLAT)
    spin.sleep(1)
    spin.play_vocal(jd.SNIPER_ELIMINATED)
    spin.sleep(2)
    spin.play_sound(jd.SUCCESS)
end

return pub
