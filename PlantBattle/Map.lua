require "GameObject"
require "Tile"
Map = GameObject:extend()


function Map:new()
    self.tiles =
    {
        Tile(10, 20, randomColor(0.2, 1)),
        Tile(100, 200, randomColor(0.2, 1)),
        Tile(150, 20, randomColor(0.2, 1)),
        Tile(10, 150, randomColor(0.2, 1)),
        Tile(300, 300, randomColor(0.2, 1)),
    }
end

function Map:update(dt)
    for _,v in pairs(self.tiles) do
        v:update()
    end
end

function Map:draw()
    for _,v in pairs(self.tiles) do
        v:draw()
    end
end


function randomColor(min, max)
    if min == nil then min = 0 end
    if max == nil then max = 1 end
    return {
        r = math.random(min, max),
        g = math.random(min, max),
        b = math.random(min, max),
    }
end