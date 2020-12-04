-- strings in lua are hell

local function readFile(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = {}
    local i = 1
    for line in io.lines(path) do
        if not content[i] then
            content[i] = ""
        end
        local str = file:read('*l')
        if str ~= "" then
            content[i] = content[i] .. ' ' .. str
        else
            i = i + 1
        end
    end
    file:close()
    return content
end

local requiredMatches = {
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid',
}

local eyeColors = {
    'amb',
    'blu',
    'brn',
    'gry',
    'grn',
    'hzl',
    'oth',
}

function stripFind(str, field) -- this is extremely ugly
    local stripped = string.match(str, field .. ":(%S+)")
    if not stripped then return false end
    if field == 'byr' then
        local result = tonumber(string.sub(stripped, 1, 4))
        return result >= 1920 and result <= 2002
    elseif field == 'iyr' then
        local result = tonumber(string.sub(stripped, 1, 4))
        return result >= 2010 and result <= 2020
    elseif field == 'eyr' then
        local result = tonumber(string.sub(stripped, 1, 4))
        return result >= 2020 and result <= 2030
    elseif field == 'hgt' then
        if string.match(stripped, "in") and #stripped == 4 then
            local result = tonumber(string.sub(stripped, 1, 2))
            return result >= 59 and result <= 76
        elseif string.match(stripped, "cm") and #stripped == 5 then
            local result = tonumber(string.sub(stripped, 1, 3))
            return result >= 150 and result <= 193
        else
            return false
        end
    elseif field == 'hcl' then
        if string.sub(stripped, 1, 1) == '#' and #stripped == 7 then
            return string.match(stripped, "%x+") == string.sub(stripped, 2, 7)
        else
            return false
        end
    elseif field == 'ecl' then
        if #stripped == 3 then
            for _, v in pairs(eyeColors) do
                if string.find(stripped, v) then
                    return true
                end
            end
            return false
        else
            return false
        end
    elseif field == 'pid' then
        if #stripped == 9 then
            return tonumber(stripped)
        else
            return false
        end
    end
end

local function validatePassports(passports)
    local valid = 0
    local strictValid = 0
    for i = 1, #passports do
        local str = passports[i]
        local matches = true
        local strictMatches = true
        for _, v in pairs(requiredMatches) do
            if not string.find(str, v) then
                matches= false
                strictMatches = false
            else
                if not stripFind(str, v) then
                    strictMatches = false
                end
            end
        end
        if matches then
            valid =  valid + 1
        end
        if strictMatches then
            strictValid =  strictValid + 1
        end
    end
    print(valid)
    print(strictValid)
end

local passports = readFile("input.lua")
validatePassports(passports)