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

function readCode(code)
    local index = 1
    local acc = 0
    local wasInstructed = {}
    repeat
        if not wasInstructed[index] then
            wasInstructed[index] = true
            local command = code[index]
            local value = string.sub(command, 5, #command)
            if string.find(command, 'acc') then
                acc = acc + value
                index = index + 1
            elseif string.find(command, 'nop') then
                index = index + 1
            elseif string.find(command, 'jmp') then
                index = index + value
            end
        else
            index = #code
        end
    until index == #code
    print(acc)
end

function fixCode(code)
    local index = 1
    local acc = 0
    local changedSomething = false
    local triedToChange = {}
    local wasInstructed = {}
    repeat
        if not wasInstructed[index] then
            wasInstructed[index] = true
            local command = code[index]
            if not changedSomething and not triedToChange[index] then
                if string.find(command, 'jmp') then   
                    command = command:gsub( "jmp", "nop")
                    changedSomething = true
                    triedToChange[index] = true
                elseif string.find(command, 'nop') then 
                    command = command:gsub("nop",  "jmp")
                    changedSomething = true
                    triedToChange[index] = true
                end
            end
            local value = string.sub(command, 5, #command)
            if string.find(command, 'acc') then
                acc = acc + value
                index = index + 1
            elseif string.find(command, 'nop') then
                index = index + 1
            elseif string.find(command, 'jmp') then
                index = index + value
            end
        else
            index = 1
            acc = 0
            changedSomething = false
            wasInstructed = {}
        end
    until index == #code
    print(acc)
end

local input = readFile("input.lua")
readCode(input)
fixCode(input)