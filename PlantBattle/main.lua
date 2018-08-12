
require "Map"
require "Camera"
require "TilePicker"

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

map = nil
camera = nil
picker = nil

scrollSpeed = 300

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Love Mouse/Keyboard Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function love.load()
    love.window.setTitle('Gangplant')
    love.window.setMode(1280, 720)
    math.randomseed(os.time())
    camera = Camera()
    map = Map()
    picker = TilePicker()

    map:load()
    camera:load()
    picker:load()
end

function love.update(dt)
    camera:update(dt)
    map:update(dt)
    picker:update(dt)
end

function love.draw()
    map:draw()
    picker:draw()
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Love Mouse/Keyboard Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function love.keypressed(key, scancode, isrepeat)
end

function love.mousereleased(x, y, button, istouch, presses)
    local plantLayer = map.layers['plant']
    local selectedTile = plantLayer:getTile(picker.row, picker.col)

    if selectedTile.type == TileTypes.root then return end

    local neighbours = plantLayer:getTileNeighbours(picker.row, picker.col)

    flags = {}
    local anyConnection = false
    for i = 1, #neighbours do
        flags[i] = neighbours[i].type == TileTypes.root
        if flags[i] then anyConnection = true end
    end

    local flagsString = getFlagsString(flags)

    if flagsSprites[flagsString] then
        if flags[1] then neighbours[1]:setFlag(3, true) end
        if flags[2] then neighbours[2]:setFlag(4, true) end
        if flags[3] then neighbours[3]:setFlag(1, true) end
        if flags[4] then neighbours[4]:setFlag(2, true) end
        local newTile = Tile(plantLayer, TileTypes.root, picker.row, picker.col, flagsSprites[flagsString])
        newTile:load()

        for i = 1, #flags do
            newTile:setFlag(i, flags[i])
        end
    end
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]
