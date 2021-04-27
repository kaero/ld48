local roomy = require "vendor.roomy"
local TitleScene = require "scenes.title"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    local scenes = roomy.new()
    scenes:hook({
        include = {
            "update",
            "draw",
            "keypressed",
            "keyreleased"
        }
    })
    scenes:enter(TitleScene:new(scenes))
end
