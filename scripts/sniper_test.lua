local spin = require('spin')
local jd = require('jd')
local test = require('test')

local pub = {}

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
