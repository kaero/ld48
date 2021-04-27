local class = require "vendor.30log"
local assets = require "assets"
local const = require "const"

local HandShadow = class "HandShadow"

function HandShadow:init(x, y, tickOffset, tick2Offset)
    self.sprite = assets.makeHandShadow()
    self.sprite.color = { 1, 1, 1, const.shadow.alpha }

    self.pos = { x = x, y = y }
    self.move = "fly"
    self.tick = tickOffset
    self.tick2 = tick2Offset
    self.center = { x = const.world.width / 2 + const.shadow.centerOffsetX, y = const.world.height / 2 + const.shadow.centerOffsetY }
    self.radius = const.world.height * const.shadow.radiusScale
    --self.tracePhys = true
end

function HandShadow:getDrawOrder()
    return 700
end

function HandShadow:draw()
    self.sprite:draw(self.pos.x, self.pos.y)
end

return HandShadow
