local class = require "vendor.30log"
local tiny = require "vendor.tiny"

local DrawingSystem = tiny.processingSystem(class "DrawingSystem")

DrawingSystem.filter = tiny.requireAll("draw", "getDrawOrder")

function DrawingSystem:draw()
    local draw = {}
    for _, e in ipairs(self.entities) do
        table.insert(draw, e)
    end
    table.sort(draw, function(a, b) 
        return a:getDrawOrder() < b:getDrawOrder() 
    end)
    for _, e in ipairs(draw) do
        e:draw()
    end
end

return DrawingSystem
