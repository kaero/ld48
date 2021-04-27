local class = require "vendor.30log"
local util = require "util"
local const = require "const"
local colors = require "colors"
local assets = require "assets"
local FlyingScene = require "scenes.flying"

local TitleScene = class("TitleScene")

function TitleScene:init(scenes)
    self.scenes = scenes
    self.cycle = 0
    self.tick = 0

    self.music = assets.musicMenu
    self.music:setLooping(true)
    self.music:setVolume(1)
    self.music:stop()

    self.font = love.graphics.newFont(60)
    self.mq = assets.makeFlyingMosquito()
    self.handShadow = assets.makeHandShadow()
    self.handShadow.color = { 1, 1, 1, 0.1 }
end


function TitleScene:enter()
    self.music:play()
end

function TitleScene:leave()
    self.music:stop()
end

function TitleScene:draw()
    local scene = self
    local g = love.graphics;
    g.setColor(colors.white)
    g.draw(assets.imgBackground, 0, 0)

    self.mq:draw(
        util.translate(math.sin(self.tick / 5), -1, 1, 100, const.world.width - 100),
        util.translate(math.sin(self.tick / 2) + math.cos(self.tick / 5 - 37), -2, 2, 200, 400)
    )
    self.handShadow:draw(
        util.translate(math.sin(self.tick / 2), -1, 1, const.world.width / 2, const.world.width - 100),
        util.translate(math.cos(self.tick / 2), -1, 1, const.world.height / 3, const.world.height - 50)
    )

    g.setColor(colors.menuTextBg)
    g.rectangle("fill", 30, 30, 964, 100)
    g.rectangle("fill", 30, 500, 964, 100)

    g.setFont(self.font)
    g.setColor(colors.menuText)
    g.print("Mosquito Simulator 2k21", 50, 50)

    local flashGray = util.colorTranslate(scene.cycle, colors.menuTextFade, colors.menuText)
    g.setColor(flashGray)
    g.print("press space to start", 50, 510)
end

function TitleScene:update(dt)
    self.tick = self.tick + dt
    self.cycle = math.sin(self.tick * 3)
end

function TitleScene:keyreleased(key)
    if key == "space" then
        self.scenes:enter(FlyingScene:new(self.scenes))
    elseif key == "escape" then
        love.event.quit()
    end
end

return TitleScene
