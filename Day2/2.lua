
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

local function strip(str)
    local num1, rest = str:match("(.+)-(.+)")
    rest = rest:match("(.+):(.+)")
    local num2 = rest:match("%d*")
    local letter = rest:match("%a")
    return tonumber(num1), tonumber(num2), letter
end


function findMatchingPasswords(strings)
    local matching = 0
    for _, v in pairs(strings) do
        local num1, num2, letter = strip(v)
        _, count = string.match(v, ": (.*)"):gsub(letter, "")
        if count >= num1 and count <= num2 then
            matching = matching + 1
        end
    end
    print(matching)
end

function findMatchingPasswords2(strings)
    local matching = 0
    for _, v in pairs(strings) do
        local num1, num2, letter = strip(v)
        local str = string.match(v, ": (.*)")
        local match1 = string.sub(str, num1, num1) == letter
        local match2 = string.sub(str, num2, num2) == letter
        if (match1 or match2) and not (match1 and match2) then
            matching = matching + 1
        end
    end
    print(matching)
end


findMatchingPasswords(readFile("input.lua"))
findMatchingPasswords2(readFile("input.lua"))