local Sprite = require "sprite"

function makeFullRowOf(framesCount, row)
    return function(grid)
        return grid('1-' .. framesCount, row or 1)
    end
end

function makeSingle(col, row)
    return function(grid)
        return grid(col or 1, row or 1)
    end
end

love.graphics.setDefaultFilter("nearest", "nearest")

local newImage = love.graphics.newImage
local imgMqSmall = newImage("assets/mq_small.png")
local imgHandShadow = newImage("assets/hand_shadow.png")

return {
    imgGround = newImage("assets/hand_suck.png"),
    imgBackground = newImage("assets/background.png"),
    imgTshirt = newImage("assets/tshirt.png"),
    imgHandBody = newImage("assets/hand_body.png"),
    imgMqHead = newImage("assets/mq_head.png"),
    imgMqBody = newImage("assets/mq_body.png"),
    imgWasted = newImage("assets/wasted.png"),

    makeFlyingMosquito = Sprite.maker(imgMqSmall, 102, 100, 51, 50, makeSingle()),
    makeHandShadow = Sprite.maker(imgHandShadow, 1024, 825, 265, 282, makeSingle()),

    musicMenu       = love.audio.newSource("assets/menu.ogg", "static"),
    musicGame       = love.audio.newSource("assets/game.ogg", "static"),
    soundFlying     = love.audio.newSource("assets/flying.ogg", "static"),
    soundSucking    = love.audio.newSource("assets/sucking.ogg", "static"),
}
