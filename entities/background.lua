local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local Background = class "Background"

function Background:getDrawOrder()
    return -1
end

function Background:draw()
    local g = love.graphics
    g.setColor(colors.white)
    g.draw(assets.imgBackground, 0, 0)
end

return Background
