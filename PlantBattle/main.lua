
require "Map"
require "Camera"
require "TilePicker"

--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

map = nil
camera = nil
picker = nil
plant = nil

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

    rootSprites = generateFlagsDict(rootFlags)
    seedSprites = generateFlagsDict(seedFlags)

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
    local selectedRoot = map.layers['roots']:getTile(picker.row, picker.col)
    local selectedGround = map.layers['background1']:getTile(picker.row, picker.col)

    if selectedGround.type == TileTypes.ground or selectedGround.type == TileTypes.floor then
        if selectedRoot.type == TileTypes.root then return end

        local nextRoots = map.layers['roots']:getTileNeighbours(picker.row, picker.col)

        flags = {}
        for i = 1, #nextRoots do
            flags[i] = nextRoots[i].type == TileTypes.root
        end

        local flagsKey = getFlagsKey(flags)

        if rootSprites[flagsKey] then
            if flags[1] then nextRoots[1]:setFlag(3, true) end
            if flags[2] then nextRoots[2]:setFlag(4, true) end
            if flags[3] then nextRoots[3]:setFlag(1, true) end
            if flags[4] then nextRoots[4]:setFlag(2, true) end
            local newTile = Tile(map.layers['roots'], TileTypes.root, picker.row, picker.col, rootSprites[flagsKey])
            newTile:load()

            for i = 1, #flags do
                newTile:setFlag(i, flags[i])
            end
        end
    end
end