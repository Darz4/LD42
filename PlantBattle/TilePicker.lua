require "GameObject"
TilePicker = GameObject:extend()

function TilePicker:new()
    self.currentTile = nil
end

function TilePicker:load()
end

function TilePicker:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    local tileRow = math.floor((mouseY + camera.y) / Tile.size) + 1
    local tileCol = math.floor((mouseX + camera.x) / Tile.size) + 1
    self.currentTile = nil

    if tileRow > 0 and tileRow <= map.height and tileCol > 0 and tileCol <= map.width then
        self.currentTile = map.layers['background1'].tiles[tileRow][tileCol]
    end
end

function TilePicker:draw()
    if self.currentTile then
        love.graphics.setColor(1, 1, 1, 0.3)
        love.graphics.rectangle("fill", self.currentTile.x - camera.x, self.currentTile.y - camera.y, Tile.size, Tile.size)
    end
end
