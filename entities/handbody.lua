local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local HandBody = class "HandBody"

function HandBody:getDrawOrder()
    return 50
end

function HandBody:draw()
    local g = love.graphics
    g.setColor(colors.white)
    g.draw(assets.imgHandBody, 200, -180)
end

return HandBody
