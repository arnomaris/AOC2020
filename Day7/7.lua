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

function getSize(t) -- you cant get the size of a dictionary :/
    local size = 0
    for _, _ in pairs (t) do
        size = size + 1
    end
    return size
end

function getRules(rules)
    local colors = {}
    for i = 1, #rules do
        local str = rules[i]
        local color = string.match(str, "%a+%s%a+")
        local canContain = {}
        local current = {}
        string.gsub(string.match(str, "contain (.+)"), "(%w+),*", function (w)
            if w ~= "bags" and w ~= "bag" then
                table.insert(current, w)
            else
                table.insert(canContain, table.concat(current, " "))
                current = {}
            end
        end)
        colors[color] = canContain
    end
    return colors
end

function findValidRules(rules)
    local coloredRules = getRules(rules)
    local validBags = {}
    local prevSize = 0
    for color, canContain in pairs(coloredRules) do
        for i = 1, #canContain do
            local v = canContain[i]
            if string.match(v, "shiny gold") then
                validBags[color] = v
            end
        end
    end
    repeat -- part1
        prevSize = getSize(validBags)
        for valid, _ in pairs(validBags) do
            for color, canContain in pairs(coloredRules) do
                for i = 1, #canContain do
                    local v = canContain[i]
                    if string.match(v, valid) then
                        validBags[color] = v
                    end
                end
            end
        end
    until prevSize == getSize(validBags)
    print(getSize(validBags))

    local function findBags(clr, size)
        local total = 0
        for _, v in pairs(coloredRules[clr]) do
            if v ~= "no other" then
                local amount = string.sub(v, 1, 1)
                local color = string.sub(v, 3, #v)
                total = total + size * amount
                total = total + findBags(color, size * amount)
            end
        end
        return total
    end

    print(findBags("shiny gold", 1))
end






local rules = readFile("input.lua")

findValidRules(rules)