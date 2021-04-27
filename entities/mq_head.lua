local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local MqHead = class "MqHead"

function MqHead:init()
end

function MqHead:getDrawOrder()
    return 850
end

function MqHead:draw()
    love.graphics.setColor(colors.white)
    love.graphics.draw(assets.imgMqHead, 280, 260)
end

return MqHead
