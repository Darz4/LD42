require "GameObject"
require "Tile"
Map = GameObject:extend()


function Map:new()
    self.x = 0
    self.y = 0
    self.height = 50
    self.width = 100
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

    local groundRow = math.floor(self.height / 2)

    for i = 0, groundRow - 1 do
        local row = {}
        for j = 0, self.width - 1 do
            local spriteNameSuffix = groundRow - i
            if spriteNameSuffix > 6 then spriteNameSuffix = 6 end
            table.insert(row, Tile(j * Tile.size, i * Tile.size, 'Tile_sky' .. spriteNameSuffix))
        end
        table.insert(self.tiles, row)
    end

    local row = {}
    for j = 0, self.width - 1 do
        if j % 2 == 0 then
            table.insert(row, Tile(j * Tile.size, groundRow * Tile.size, spriteGroups.floor1))
        else
            table.insert(row, Tile(j * Tile.size, groundRow * Tile.size, spriteGroups.floor2))
        end
    end
    table.insert(self.tiles, row)

    for i = groundRow + 1, self.height - 1 do
        local row = {}
        for j = 0, self.width - 1 do
            local spriteNameSuffix = (j % 2) + 1
            table.insert(row, Tile(j * Tile.size, i * Tile.size, 'Tile_ground_' .. spriteNameSuffix))
        end
        table.insert(self.tiles, row)
    end
end