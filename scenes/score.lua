local class = require "vendor.30log"
local const = require "const"
local util = require "util"
local colors = require "colors"
local assets = require "assets"

local ScoreScene = class("ScoreScene")

function ScoreScene:init(scenes, GameScene, score)
    self.scenes = scenes
    self.cycle = 0
    self.tick = 0
    self.score = score
    self.GameScene = GameScene

    self.largeFont = love.graphics.newFont(80)
    self.font = love.graphics.newFont(60)
end

function ScoreScene:enter()
end

function ScoreScene:leave()
end

function ScoreScene:draw()
    local scene = self
    local g = love.graphics;

    g.setColor(colors.white)
    g.draw(assets.imgBackground, 0, 0)

    g.draw(assets.imgWasted, -60, 20)

    g.setFont(self.largeFont)
    g.setColor(colors.menuTextHi)
    g.print("sucked for " .. self.score .. "s", 50, 50)

    g.setColor(colors.menuTextBg)
    g.rectangle("fill", 30, 410, 964, 200)

    g.setFont(self.font)

    local flashGray = util.colorTranslate(scene.cycle, colors.menuTextFade, colors.menuText)
    g.setColor(flashGray)
    g.print("press space to retry", 50, 430)

    local flashRed = util.colorTranslate(scene.cycle, colors.menuTextHiFade, colors.menuTextHi)
    g.setColor(flashRed)
    g.print("press escape to exit", 50, 510)
end

function ScoreScene:update(dt)
    self.tick = self.tick + dt
    self.cycle = math.sin(self.tick *3)
end

function ScoreScene:keyreleased(key)
    if key == "space" then
        self.scenes:enter(self.GameScene:new(self.scenes))
    elseif key == "escape" then
        love.event.quit()
    end
end

return ScoreScene
