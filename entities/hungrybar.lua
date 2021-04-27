local class = require "vendor.30log"
local colors = require "colors"
local const = require "const"
local util = require "util"

local Hungrybar = class "Hungrybar"

function Hungrybar:init(state)
    self.state = state
    self.font = love.graphics.newFont(24)
end

function Hungrybar:getDrawOrder()
    return 9999
end

function Hungrybar:draw()
    local g = love.graphics
    g.setColor(colors.hungrybar)
    g.rectangle("fill", 0, 0, util.translate(self.state.hungry, 0, const.maxHungry, 0, const.world.width), 34);
    g.setFont(self.font)
    g.setColor(colors.white)
    g.print("hunger", 5, 2)
end

return Hungrybar
