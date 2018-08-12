require "GameObject"
Layer = GameObject:extend()


function Layer:new(name, width, height)
    self.tiles = {}
    self.name = name
end

function Layer:load()
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:load()
        end
    end
end

function Layer:update(dt)
    for _,tileRow in pairs(self.tiles) do
        for _,tile in pairs(tileRow) do
            tile:update(dt)
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