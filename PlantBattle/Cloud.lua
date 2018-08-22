require "Entity"

Cloud = Entity:extend()

Cloud.minSpeed = 5
Cloud.maxSpeed = 30
Cloud.minScale = 1
Cloud.maxScale = 3

function Cloud:new(x, y)
    local spriteName = 'cloud/cloud' .. math.random(1, 6) .. '.png'
    local scale = Cloud.minScale + (math.random() * (Cloud.maxScale - Cloud.minScale))
    local orientation = 0
    self.speed = math.random(Cloud.minSpeed, Cloud.maxSpeed)
    Cloud.super.new(self, x, y, spriteName, orientation, scale)
end

function Cloud:update(dt)
    self.x = self.x - (self.speed * dt)
    Cloud.super.update(self, dt)
end