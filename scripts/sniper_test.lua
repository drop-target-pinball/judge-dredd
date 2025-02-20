local spin = require('spin')
local std = require('std')
local jd = require('jd')

local pub = {}

function pub.test_sniper_failure()
    spin.run(jd.SNIPER)
    spin.sleep(8)
    spin.set(jd.SNIPER_SCORE, 3550700)
end

return pub
