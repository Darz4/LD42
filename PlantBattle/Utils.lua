
require 'string'

debugPrintEnabled = false


function _print(string)
    if debugPrintEnabled then
        print(string)
    end
end

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
