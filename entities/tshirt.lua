local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local Tshirt = class "Tshirt"

function Tshirt:getDrawOrder()
    return 100
end

function Tshirt:draw()
    local g = love.graphics
    g.setColor(colors.white)
    g.draw(assets.imgTshirt, 204, 0)
end

return Tshirt
