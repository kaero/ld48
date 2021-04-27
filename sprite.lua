local class = require "vendor.30log"
local anim8 = require "vendor.anim8"
local colors = require "colors"

local Sprite = class("Sprite")

function Sprite:init(image, anim8, width, height, baseX, baseY)
    self.image = image
    self.anim8 = anim8
    self.width = width
    self.height = height
    self.baseX = baseX
    self.baseY = baseY
    self.color = colors.white
end

function Sprite:update(dt)
    self.anim8:update(dt)
end

function Sprite:draw(x, y)
    love.graphics.setColor(self.color)
    self.anim8:draw(self.image, x - self.baseX, y - self.baseY)
end

function Sprite.from(image, width, height, baseX, baseY, makeFrames, duration)
    local grid = anim8.newGrid(width, height, image:getWidth(), image:getHeight())
    local frames = makeFrames(grid)
    local anim8 = anim8.newAnimation(frames, duration or 1)

    return Sprite:new(image, anim8, width, height, baseX, baseY)
end

function Sprite.maker(image, width, height, baseX, baseY, makeFrames, duration)
    return function()
        return Sprite.from(image, width, height, baseX, baseY, makeFrames, duration)
    end
end

return Sprite