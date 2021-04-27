local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local MqBody = class "MqBody"

function MqBody:init()
end

function MqBody:getDrawOrder()
    return 800
end

function MqBody:draw()
    love.graphics.setColor(colors.white)
    love.graphics.draw(assets.imgMqBody, 360, 140)
end

return MqBody
