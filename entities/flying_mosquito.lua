local class = require "vendor.30log"
local assets = require "assets"
local const = require "const"

local FlyingMosquito = class "FlyingMosquito"

function FlyingMosquito:init(x, y)
    self.sprite = assets.makeFlyingMosquito()

    self.pos = { x = x, y = y }
    self.move = "fly"
    self.tick = 0
    self.tick2 = 0
    self.center = { x = const.world.width / 2 + const.fly.centerOffsetX, y = const.world.height / 2 + const.fly.centerOffsetY }
    self.radius = const.world.height * const.fly.radiusScale
    --self.tracePhys = true
end

function FlyingMosquito:getDrawOrder()
    return 500
end

function FlyingMosquito:draw()
    self.sprite:draw(self.pos.x, self.pos.y)
end

return FlyingMosquito
