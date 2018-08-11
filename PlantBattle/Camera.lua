require "GameObject"
Camera = GameObject:extend()

function Camera:new()
    self.x = 0
    self.y = 0
end

function Camera:update(dt)
    if love.keyboard.isDown("up") then
        self.y = self.y - scrollSpeed * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + scrollSpeed * dt
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - scrollSpeed * dt
    end
    if love.keyboard.isDown("right") then
        self.x = self.x + scrollSpeed * dt
    end
end

function Camera:draw(camera)
end