local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local const = require "const"
local colors = require "colors"
local util = require "util"
local input = require "input"
local assets = require "assets"
local PauseScene = require "scenes.pause"
local SuckingScene = require "scenes.sucking"
local ScoreScene = require "scenes.score"
local Background = require "entities.background"
local Tshirt = require "entities.tshirt"
local FlyingMosquito = require "entities.flying_mosquito"
local HandShadow = require "entities.hand_shadow"
local HandBody = require "entities.handbody"
local Hungrybar = require "entities.hungrybar"
local DrawingSystem = require "systems.drawing"
local PhysicsSystem = require "systems.physics"

local FlyingScene = class("FlyingScene")

function FlyingScene:init(scenes, time, hungry, level)
    self.scenes = scenes
    self.time = time or 0
    self.level = level or 3
    self.state = { hungry = hungry or 0 }
    if time == nil then
        self.hintTime = 2
    else
        self.hintTime = 0
    end

    self.music = assets.musicGame
    self.music:setLooping(true)
    self.music:setVolume(1)
    self.music:stop()

    self.soundFlying = assets.soundFlying
    self.soundFlying:setLooping(true)
    self.soundFlying:stop()

    self.font = love.graphics.newFont(60)

    self.drawingSystem = DrawingSystem:new()
    self.hand = HandShadow:new(2000, 2000, math.random(3, 5), math.random(7, 11))
    self.mq = FlyingMosquito:new(-100, -100)
    self.world = tiny.world(
        self.drawingSystem,
        PhysicsSystem:new(),
        Background:new(),
        HandBody:new(),
        Tshirt:new(),
        Hungrybar:new(self.state),
        self.mq,
        self.hand
    )
end

function FlyingScene:enter()
    self.music:play()
    self.soundFlying:play()
end

function FlyingScene:leave()
    self.soundFlying:stop()
    self.music:stop()
end

function FlyingScene:resume()
    self.soundFlying:play()
end

function FlyingScene:pause()
    self.soundFlying:pause()
end

function FlyingScene:draw()
    self.drawingSystem:draw()

    if self.hintTime > 0 then
        local g = love.graphics;
        g.setFont(self.font)
        g.setColor(colors.menuTextBg)
        g.rectangle("fill", 30, 500, 964, 100)
        g.setColor(colors.menuText)
        g.print("hit space to bite!", 50, 510)
    end
end

function FlyingScene:update(dt)
    input:update()
    self.time = self.time + dt
    if self.hintTime > 0 then
        self.hintTime = self.hintTime - dt
    end
    self.state.hungry = self.state.hungry + dt * self.level
    self.world:update(dt)
    if self.state.hungry >= const.maxHungry then
        self.scenes:enter(ScoreScene:new(self.scenes, FlyingScene, math.ceil(self.time)))
    end
end

function FlyingScene:keyreleased(key)
    if key == "space" then
        local dx = self.mq.pos.x - self.hand.pos.x;
        local dy = self.mq.pos.y - self.hand.pos.y;
        local distance = math.sqrt(dx*dx + dy*dy)
        self.scenes:enter(SuckingScene:new(self.scenes, FlyingScene, self.time, distance, self.state.hungry, self.level))
    elseif key == "escape" then
        self.scenes:push(PauseScene:new(self.scenes))
    end
end

return FlyingScene
