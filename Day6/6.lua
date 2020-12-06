
local function readFile(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = {[1] = {}}
    local groupIndex = 1
    for _ in io.lines(path) do
        local line = file:read('*l')
        if line == "" then
            groupIndex = groupIndex + 1
            content[groupIndex] = {}
        else
            table.insert(content[groupIndex], line)
        end
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

function evaluateString(groupCount, str)
    for i = 1, #str do
        local question = string.sub(str, i, i)
        if not groupCount[question] then
            groupCount[question] = 0
        end
        groupCount[question] = groupCount[question] + 1
    end
    return groupCount
end

function evaluateAnswers(answers)
    local totalCount = 0
    local totalCount2 = 0
    for i = 1, #answers do
        local group = answers[i]
        local groupCount = {}
        for _, questions in pairs(group) do
            groupCount = evaluateString(groupCount, questions)
        end
        for _, v in pairs(groupCount) do
            if v == #group then
                totalCount2 = totalCount2 + 1
            end
        end
        totalCount = totalCount + getSize(groupCount)
    end
    print(totalCount)
    print(totalCount2)
end

evaluateAnswers(readFile("input.lua"))