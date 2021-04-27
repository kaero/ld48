local class = require "vendor.30log"
local util = require "util"
local assets = require "assets"
local colors = require "colors"

local PauseScene = class("PauseScene")

function PauseScene:init(scenes)
    self.scenes = scenes
    self.cycle = 0
    self.tick = 0

    self.font = love.graphics.newFont(60)
    self.handShadow = assets.makeHandShadow()
    self.handShadow.color = { 1, 1, 1, 0.1 }
end

function PauseScene:enter()
end

function PauseScene:leave()
end

function PauseScene:draw()
    local scene = self
    local g = love.graphics;

    g.setColor(colors.white)
    g.draw(assets.imgBackground, 0, 0)

    g.setColor(colors.menuTextBg)
    g.rectangle("fill", 30, 410, 964, 200)

    self.handShadow:draw(700, 400)

    g.setFont(self.font)

    local flashGray = util.colorTranslate(scene.cycle, colors.menuTextFade, colors.menuText)
    g.setColor(flashGray)
    g.print("press space to resume", 50, 430)

    local flashRed = util.colorTranslate(scene.cycle, colors.menuTextHiFade, colors.menuTextHi)
    g.setColor(flashRed)
    g.print("press escape to exit", 50, 510)
end

function PauseScene:update(dt)
    self.tick = self.tick + dt
    self.cycle = math.sin(self.tick * 3)
end

function PauseScene:keyreleased(key)
    if key == "space" then
        self.scenes:pop()
    elseif key == "escape" then
        love.event.quit()
    end
end

return PauseScene
