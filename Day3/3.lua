
local function readFile(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = {}
    for line in io.lines(path) do
        table.insert(content, file:read('*l'))
    end
    file:close()
    return content
end

function checkSlope(map, downSize, sideSize)
    local foundTree = 0
    local j = 1
    for i = 1, #map, downSize do
        if string.sub(map[i], j , j) == '#' then
            foundTree = foundTree + 1
        end
        j = j + sideSize > #map[i] and j + sideSize - #map[i] or j + sideSize
    end
    return foundTree
end

local map = readFile("input.lua")
print(checkSlope(map, 1, 3))
print(checkSlope(map, 1, 1) * checkSlope(map, 1, 3) * checkSlope(map, 1, 5) * checkSlope(map, 1, 7) * checkSlope(map, 2, 1))
