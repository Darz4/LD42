require "GameObject"

Cloud = GameObject:extend()

Cloud.minSpeed = 5
Cloud.maxSpeed = 15
Cloud.minScale = 1
Cloud.maxScale = 3

function Cloud:new(x, y)
    self.x = x
    self.y = y
    self.speed = math.random(Cloud.minSpeed, Cloud.maxSpeed)
    self.scale = math.random(Cloud.minScale, Cloud.maxScale)
    self.currentTimer = 0
    self.spriteName = 'cloud/cloud' .. math.random(1, 6) .. '.png'
end

function Cloud:load()
    self.sprite = sprites[self.spriteName]
end

function Cloud:update(dt)
    self.x = self.x - (self.speed * dt)
end

function Cloud:draw()
    love.graphics.draw(self.sprite, self.x - camera.x, self.y - camera.y, 0, self.scale, self.scale)
end