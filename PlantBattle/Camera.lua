require "GameObject"
Camera = GameObject:extend()

function Camera:new()
    self.x = 0
    self.y = 0
    self.winW = love.graphics.getWidth()
    self.winH = love.graphics.getHeight()
end

function Camera:load()
    self.x = (map.width * Tile.size / 2) - (self.winW / 2) + (Tile.size / 2)
    self.y = (map.height * Tile.size / 2) - (self.winH / 2) - (Tile.size * 4)
    self.right = self.x + self.winW
    self.bottom = self.y + self.winH
    self.mapW = map.width * Tile.size
    self.mapH = map.height * Tile.size
end

function Camera:update(dt)
    self.right = self.x + self.winW
    self.bottom = self.y + self.winH

    if love.keyboard.isDown("up") and self.y >= 0 then
        self.y = self.y - scrollSpeed * dt
    end
    if love.keyboard.isDown("down") and self.bottom <= self.mapH then
        self.y = self.y + scrollSpeed * dt
    end
    if love.keyboard.isDown("left") and self.x >= 0 then
        self.x = self.x - scrollSpeed * dt
    end
    if love.keyboard.isDown("right") and self.right <= self.mapW then
        self.x = self.x + scrollSpeed * dt
    end
end

function Camera:draw()
end