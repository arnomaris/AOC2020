
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

function getSeat(str, type)
    local splitStr = type == "Row" and string.sub(str, 1, 7) or string.sub(str, 8, 10)
    local upper = type == "Row" and 127 or 7
    local lower = 0
    for i = 1, #str do
        local letter = string.sub(splitStr, i, i)
        if letter == "F" or letter == "L" then
            upper = math.floor(upper - ((upper - lower) / 2))
        elseif letter == "B" or letter == "R" then
            lower = math.ceil(lower + ((upper - lower) / 2))
        end
    end
    return(upper)
end

local function evaluateBoardingPasses(passes)
    local highest = 0
    local seatIds = {}
    for i = 1, #passes do
        local pass = passes[i]
        local id = getSeat(pass, "Row") * 8 + getSeat(pass, "Colum")
        table.insert(seatIds, id)
        if id > highest then 
            highest = id 
        end
    end

    print(highest)

    table.sort(seatIds)
    local previousId = seatIds[1]
    local myId = 0
    for i = 2, #seatIds do 
        local id = seatIds[i]
        if id ~= previousId + 1 then
            myId = id - 1
            break
        end
        previousId = id
    end

    print(myId)
end

local passes = readFile("input.lua")
evaluateBoardingPasses(passes)