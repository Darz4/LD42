
require 'string'

function randomColor(min, max)
    if min == nil then min = 0 end
    if max == nil then max = 1 end
    return {
        r = math.random(min, max),
        g = math.random(min, max),
        b = math.random(min, max),
    }
end

function startsWith(str, start)
    return string.sub(str, 1, string.len(start)) == start
end

function generateFlagsDict(spriteFlags)
    local result = {}

    for k,v in pairs(spriteFlags) do
        local flagsKey = getFlagsKey(v)
        if not result[flagsKey] then
            result[flagsKey] = {}
        end
        table.insert(result[flagsKey], k)
    end

    return result
end

function getFlagsKey(flags)
    local flagsKey = ''
    local chars = { 'L', 'U', 'R', 'D' }
    for i = 1, #flags do
        if flags[i] then
            flagsKey = flagsKey .. chars[i]
        end
    end
    return flagsKey
end

function getFlags(tiles, tileTypes)
    flags = {}
    for i = 1, #tiles do
        for _,v in pairs(tileTypes) do
            flags[i] = (tiles[i].type == v)
            if flags[i] then break end
        end
    end
    return flags
end