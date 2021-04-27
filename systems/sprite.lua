local class = require "vendor.30log"
local tiny = require "vendor.tiny"

local SpriteSystem = tiny.processingSystem(class "SpriteSystem")

SpriteSystem.filter = tiny.requireAll("sprite")

function SpriteSystem:process(e, dt)
    e.sprite:update(dt)
end

return SpriteSystem