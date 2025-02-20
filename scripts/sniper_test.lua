local spin = require('spin')
local jd = require('jd')
local test = require('test')

local pub = {}

function pub.test_sniper_failure()
    spin.run(jd.SNIPER)
    spin.sleep(8)
    spin.set(jd.SNIPER_SCORE, 3550700)
end

function pub.test_sniper_success()
    spin.run(jd.SNIPER)
    spin.sleep(4)
    spin.switch_updated(jd.RIGHT_POPPER)
    spin.sleep(3)
    spin.switch_updated(jd.RIGHT_POPPER)
end

return pub
