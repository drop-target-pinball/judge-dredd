local spin = require('spin')
local message = require('message')
local jd = require('jd')

local pub = {}

function pub.multiball()
    spin.run('multiball_audio')
end

function pub.multiball_audio()
    spin.play_music(jd.MULTIBALL_INTRO, {loops=1, notify=true})
    spin.wait_for(message.MUSIC_ENDED)
    spin.play_music(jd.MULTIBALL)
end

return pub
