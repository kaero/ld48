local const = require "const"

local util = {}

function util.translate(value, fromMin, fromMax, toMin, toMax)
    local scale = (toMax - toMin) / (fromMax - fromMin)
    return toMin + (value - fromMin) * scale
end

function util.rgb255(r, g, b, a)
    return {
        util.translate(r, 0, 255, 0, 1),
        util.translate(g, 0, 255, 0, 1),
        util.translate(b, 0, 255, 0, 1),
        1
    }
end

function util.colorTranslate(cycle, fromColor, toColor)
    return {
        util.translate(cycle, -1, 1, fromColor[1],      toColor[1]     ),
        util.translate(cycle, -1, 1, fromColor[2],      toColor[2]     ),
        util.translate(cycle, -1, 1, fromColor[3],      toColor[3]     ),
        util.translate(cycle, -1, 1, fromColor[4] or 1, toColor[4] or 1),
    }
end

function util.clamp(value, min, max) 
    return value < min and min or value > max and max or value
end

function util.distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

function util.direction(val)
    return val == 0 and 0 or val / math.abs(val)
end

function util.sign(val)
    return val == 0 and 1 or val / math.abs(val)
end

return util
