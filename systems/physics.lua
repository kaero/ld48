local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local util = require "util"
local const = require "const"

local PhysicsSystem = tiny.processingSystem(class "PhysicsSystem")

PhysicsSystem.filter = tiny.requireAll("pos", "center", "radius", "move", "tick", "tick2")

local nan = 0/0

function PhysicsSystem:init()
    self.m1 = math.random(10, 20)
    self.m2 = math.random(20, 40)
    self.m3 = math.random(10, 20)
    self.m4 = math.random(20, 40)
end

function PhysicsSystem:process(e, dt)
    if e.skipPhys then
        return
    end

    local pos, c, r = e.pos, e.center, e.radius

    e.tick = e.tick + dt
    e.tick2 = e.tick2 + dt * math.random(1, 3)
    local cx = c.x + math.sin(e.tick) * r
    local cy = c.y + math.cos(e.tick) * r
    if e.move == "fly" then
        ccx = cx + math.sin(e.tick2 * 3 + self.m1) * r * 0.3
        ccy = cy + math.cos(e.tick2 * 3 + self.m2) * r * 0.3
        pos.x = ccx + math.sin(e.tick * 2 + self.m3) * r * 0.7
        pos.y = ccy + math.cos(e.tick * 2 + self.m4) * r * 0.7
    elseif e.move == "circle" then
        pos.x, pos.y = cx, cy
    end

    if e.tracePhys then
        print(
            string.format(
                "px=%.2f py=%.2f tick=%.2f",
                pos.x, pos.y, e.tick
            )
        )
    end

    pos.x = util.clamp(pos.x, 5, const.world.width - 5)
    pos.y = util.clamp(pos.y, 5, const.world.height - 5)
end

return PhysicsSystem
