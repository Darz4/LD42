require "GameObject"
TilePicker = GameObject:extend()

function TilePicker:new()
    self.currentTile = nil
    self.debugDraw = false
end

function TilePicker:load()
    self.layer = map:addLayer('tilePicker')
    self.row = 1
    self.col = 1
    self.x = 0
    self.y = 0
end

function TilePicker:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    local tileRow = math.floor((mouseY + camera.y) / Tile.size) + 1
    local tileCol = math.floor((mouseX + camera.x) / Tile.size) + 1

    if tileRow > 0 and tileRow <= map.height and tileCol > 0 and tileCol <= map.width then
        self.row = tileRow
        self.col = tileCol
        self.x = (self.col - 1) * Tile.size
        self.y = (self.row - 1) * Tile.size
    end
end

function TilePicker:draw()
    love.graphics.setColor(1, 1, 1, 0.3)
    love.graphics.rectangle("fill", self.x - camera.x, self.y - camera.y, Tile.size, Tile.size)

    if self.debugDraw then
        self.layer:clear()
        local n = self.layer:getTileNeighbours(self.row, self.col)

        for _, v in pairs(n) do
            love.graphics.setColor(1, 0, 0, 0.5)
            love.graphics.rectangle("fill", v.x - camera.x, v.y - camera.y, Tile.size, Tile.size)
        end
    end
end