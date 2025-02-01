local spin = require("spin")
local jd = require('jd')

local pub = {}

function pub.plunge()
    spin.run(jd.PLUNGE_AUDIO)
end

function pub.plunge_audio()
    spin.play_music(jd.PLUNGE_LOOP);
    spin.play_vocal(jd.LAW_MASTER_COMPUTER_ONLINE_WELCOME_ABOARD);
    spin.sleep(7)
    spin.play_vocal(jd.USE_FIRE_BUTTON_TO_LAUNCH_BALL);
end

function pub.launch()
    spin.play_music(jd.MAIN_THEME)
    spin.play_sound(jd.MOTORCYCLE_START)
end

return pub



