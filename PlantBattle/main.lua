
require "Utils"
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
    map = Map(50, 30)
    picker = TilePicker()

    flagsSprites.roots = generateFlagsDict(spriteFlags.roots)
    flagsSprites.seed = generateFlagsDict(spriteFlags.seed)

    camera:load()
    map:load()
    picker:load()
end

function love.update(dt)
    camera:update(dt)
    map:update(dt)
    picker:update(dt)
end

function love.draw()
    camera:draw()
    map:draw()
    picker:draw()
end


--[[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Love Mouse/Keyboard Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]]

function love.keypressed(key, scancode, isrepeat)
end

function love.mousereleased(x, y, button, istouch, presses)
    local tile = map:getTile(picker.row, picker.col)
    local nexts = map:getTileNeighbours(picker.row, picker.col)

    if tile['background1'].type == TileTypes.ground or tile['background1'].type == TileTypes.floor then
        if tile['roots'].type == TileTypes.root then return end
        
        local flags = getFlags(nexts['roots'], { TileTypes.root, TileTypes.seed })
        local flagsKey = getFlagsKey(flags)

        if flagsSprites.roots[flagsKey] then
            if flags[1] then nexts['roots'][1]:setFlag(3, true) end
            if flags[2] then nexts['roots'][2]:setFlag(4, true) end
            if flags[3] then nexts['roots'][3]:setFlag(1, true) end
            if flags[4] then nexts['roots'][4]:setFlag(2, true) end
            local newTile = Tile(map.layers['roots'], TileTypes.root, picker.row, picker.col, flagsSprites.roots[flagsKey])
            newTile:setFlags(flags)
        end
    end
end