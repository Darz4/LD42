require "GameObject"

Cloud = GameObject:extend()

Cloud.xIncrement = 10

function Cloud:new(x, y)
    self.x = x
    self.y = y
    self.speed = 1000
    self.currentTimer = 0
end

function Cloud:load()
    self.sprite = sprites['cloud/cloud' .. math.random(1, 6)]
end

function Cloud:update(dt)
    self.currentTimer = self.currentTimer + dt
    if self.currentTimer >= 1000/self.speed then
        self.currentTimer = 0
        self.x = self.x + Cloud.xIncrement
    end
end

function Cloud:draw()
    love.graphics.draw(self.sprite, self.x - camera.x, self.y - camera.y)
end