local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local Ground = class "Ground"

function Ground:init()
end

function Ground:getDrawOrder()
    return 840
end

function Ground:draw()
    love.graphics.setColor(colors.white)
    love.graphics.draw(assets.imgGround, -100, 500)
end

return Ground
