
require "Map"

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

map = nil
scrollSpeed = 500
Colors =
{
    blue = {r = 0.4, g = 0.8, b = 1},
    brown = {r = 0.83, g = 0.61, b = 0.14},
}

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Love Mouse/Keyboard Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function love.load()
    math.randomseed(os.time())
    map = Map()
end

function love.update(dt)
    if love.keyboard.isDown("up") then
        map.y = map.y + scrollSpeed * dt
    end
    if love.keyboard.isDown("down") then
        map.y = map.y - scrollSpeed * dt
    end
    if love.keyboard.isDown("left") then
        map.x = map.x + scrollSpeed * dt
    end
    if love.keyboard.isDown("right") then
        map.x = map.x - scrollSpeed * dt
    end

    map:update(dt)
end

function love.draw()
    map:draw()
    
    local mouseX, mouseY = love.mouse.getPosition()
    local x = math.floor(mouseX / Tile.size)
    local y = math.floor(mouseY / Tile.size)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x * Tile.size, y * Tile.size, Tile.size, Tile.size)
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Love Mouse/Keyboard Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function love.keypressed(key, scancode, isrepeat)
end

function love.mousereleased(x, y, button, istouch, presses)
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]
