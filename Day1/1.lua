-- this is going to be fun in lua :)

local function readFile(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = {}
    for line in io.lines(path) do
        table.insert(content, tonumber(file:read('*l')))
    end
    file:close()
    return content
end

local function findCombination1(input)
    for i = 1, #input do
        local number1 = input[i]
        for j = 1, #input do
            local number2 = input[j]
            if number1 ~= number2 then
                if number1 + number2 == 2020 then
                    return number1 * number2
                end
            end
        end
    end
end

local function findCombination2(input)
    for i = 1, #input do
        local number1 = input[i]
        for j = 1, #input do
            local number2 = input[j]
            for k = 1, #input do
                local number3 = input[k]
                if number1 ~= number2 and number2 ~= number3 and number3 ~= number1 then
                    if number1 + number2 + number3 == 2020 then
                        return number1 * number2 * number3
                    end
                end
            end
        end
    end
end

print(findCombination1(readFile("input1.lua")))
print(findCombination2(readFile("input1.lua")))