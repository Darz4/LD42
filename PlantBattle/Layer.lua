require "GameObject"
Layer = GameObject:extend()


function Layer:new(width, height)
    self.tiles = {}
end

function Layer:load()
end

function Layer:update(dt)
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:update()
        end
    end
end

function Layer:draw()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:draw()
        end
    end
end