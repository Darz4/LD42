require "GameObject"
Layer = GameObject:extend()


function Layer:new(name, width, height)
    self.tiles = {}
    self.name = name
    self.width = width
    self.height = height
end

function Layer:load()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:load()
        end
    end
end

function Layer:update(dt)
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:update(dt)
        end
    end
end

function Layer:draw()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:draw()
        end
    end
end

function Layer:getTile(row, col)
    if row < 1 or row > self.height or col < 1 or col > self.width then
        return Tile.default
    end
    return self.tiles[row][col]
end

function Layer:getTileNeighbours(row, col)
    return
    {
        self:getTile(row, col - 1),
        self:getTile(row - 1, col),
        self:getTile(row, col + 1),
        self:getTile(row + 1, col),
    }
end