require "GameObject"
require "Tile"
Map = GameObject:extend()


scrollSpeed = 500


function Map:new()
    self.x = 0
    self.y = 0
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

    if love.keyboard.isDown("up") then
        self.y = self.y + scrollSpeed * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y - scrollSpeed * dt
    end
    if love.keyboard.isDown("left") then
        self.x = self.x + scrollSpeed * dt
    end
    if love.keyboard.isDown("right") then
        self.x = self.x - scrollSpeed * dt
    end

    for _,v in pairs(self.tiles) do
        v:update()
    end
end

function Map:draw()
    for _,v in pairs(self.tiles) do
        v:draw(self.x, self.y)
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