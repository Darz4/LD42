require "GameObject"

Entity = GameObject:extend()

Entity.debugDraw = false

function Entity:new(x, y, spriteName, orientation, scale)
    if not orientation then orientation = 0 end
    if not scale then scale = 1 end

    self.x = x
    self.y = y
    self.spriteName = spriteName
    self.orientation = orientation
    self.scale = scale
end

function Entity:load()
    self.sprite = sprites[self.spriteName]
    self:updateBoundingBox()
end

function Entity:update(dt)
    self:updateBoundingBox()
end

function Entity:draw()
    -- TODO: use Entity.debugDraw
    if Entity.debugDraw then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', self.x - camera.x, self.y - camera.y, self.actualWidth, self.actualHeight)
        love.graphics.setColor(1, 1, 1)
    end

    love.graphics.draw(self.sprite, self.x - camera.x, self.y - camera.y, self.orientation, self.scale, self.scale)
end

function Entity:updateBoundingBox()
    self.actualWidth = self.sprite:getWidth() * self.scale
    self.actualHeight = self.sprite:getHeight() * self.scale
    self.actualRight = self.x + self.actualWidth
    self.actualBottom = self.y + self.actualHeight
end