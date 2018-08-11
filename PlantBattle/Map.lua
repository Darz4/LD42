require "GameObject"
require "Tile"
Map = GameObject:extend()


function Map:new()
    self.x = 0
    self.y = 0
    self.height = 15
    self.width = 20
    self.tiles = {}
    self:generate()
end

function Map:update(dt)
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:update()
        end
    end
end

function Map:draw()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:draw()
        end
    end
end

function Map:generate()
    self.tiles = {}

    local groundRow = math.floor(self.height / 2) + 1

    for i = 0, groundRow - 1 do
        local row = {}
        for j = 0, self.width do
            table.insert(row, Tile(j * Tile.size, i * Tile.size, Colors.blue))
        end
        table.insert(self.tiles, row)
    end

    for i = groundRow, self.height - 1 do
        local row = {}
        for j = 0, self.width do
            table.insert(row, Tile(j * Tile.size, i * Tile.size, Colors.brown))
        end
        table.insert(self.tiles, row)
    end
end