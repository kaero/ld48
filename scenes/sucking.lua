local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local const = require "const"
local colors = require "colors"
local util = require "util"
local input = require "input"
local assets = require "assets"
local PauseScene = require "scenes.pause"
local ScoreScene = require "scenes.score"
local Background = require "entities.background"
local Hungrybar = require "entities.hungrybar"
local Ground = require "entities.ground"
local MqBody = require "entities.mq_body"
local MqHead = require "entities.mq_head"
local DrawingSystem = require "systems.drawing"

local SuckingScene = class("SuckingScene")

function SuckingScene:init(scenes, NextScene, time, distance, hungry, level)
    self.scenes = scenes
    self.NextScene = NextScene
    self.time = time or 0
    self.level = level or 1
    self.state = { killed = false, hungry = hungry or 0 }
    self.distance = distance
    if level == 3 then
        self.hintTime = 2
    else
        self.hintTime = 0
    end

    self.music = assets.musicGame
    self.music:setLooping(true)
    self.music:setVolume(0.6)
    self.music:stop()

    self.soundSucking = assets.soundSucking
    self.soundSucking:setLooping(false)
    self.soundSucking:stop()

    self.font = love.graphics.newFont(60)

    self.drawingSystem = DrawingSystem:new()
    self.world = tiny.world(
        self.drawingSystem,
        Background:new(),
        Ground:new(),
        MqBody:new(),
        MqHead:new(self.state),
        Hungrybar:new(self.state)
    )
end

function SuckingScene:enter()
    self.music:play()
end

function SuckingScene:leave()
    self.music:stop()
    self.soundSucking:stop()
end

function SuckingScene:resume()
end

function SuckingScene:pause()
    self.soundSucking:stop()
end

function SuckingScene:draw()
    self.drawingSystem:draw()

    local g = love.graphics;

    if self.hintTime > 0 then
        g.setFont(self.font)
        g.setColor(colors.menuTextBg)
        g.rectangle("fill", 30, 410, 964, 200)
        g.setColor(colors.menuText)
        g.print("smash enter to suck!", 50, 430)
        g.print("press space to fly out", 50, 510)
    end

    if self.distance < 60 then
        local alpha = util.translate(self.distance, 0, 60, 1, 0)
        g.setColor({ 0, 0, 0, alpha })
        g.rectangle("fill", 0, 0, const.world.width, const.world.height)
    end
end

function SuckingScene:update(dt)
    input:update()
    self.time = self.time + dt
    if self.hintTime > 0 then
        self.hintTime = self.hintTime - dt
    end
    if self.distance > 0 then
        self.distance = self.distance - dt * self.level * 10
    end
    if self.distance <=0 then
        self.state.killed = true
    end
    print(string.format("d = %.2f", self.distance))
    self.state.hungry = self.state.hungry + dt * self.level
    self.world:update(dt)
    if self.state.killed or self.state.hungry >= const.maxHungry then
        self.scenes:enter(ScoreScene:new(self.scenes, self.NextScene, math.ceil(self.time)))
    end
end

function SuckingScene:keyreleased(key)
    if key == "return" then
        self.hintTime = 0
        self.soundSucking:play()
        self.state.hungry = self.state.hungry - 1
        if not self.state.killed and self.state.hungry <= 0 then
            self.scenes:enter(self.NextScene:new(self.scenes, self.time, 0, self.level + 1))
        end
    elseif key == "space" then
        if not self.state.killed and self.state.hungry < const.maxHungry then
            self.scenes:enter(self.NextScene:new(self.scenes, self.time, self.state.hungry, self.level + 1))
        end
    elseif key == "escape" then
        self.scenes:push(PauseScene:new(self.scenes))
    end
end

return SuckingScene
