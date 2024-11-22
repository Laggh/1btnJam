constants = require("constants")
config = require("config")
loadedFiles = require("fileLoader")
img = loadedFiles.img
sfx = loadedFiles.sfx


function checkInput()
    if input then inputLenght = inputLenght + 1
    else if inputLenght > 0 then
        table.insert(inputArr, inputLenght)
        inputLenght = 0
    end
        noInputLength = noInputLength + 1
    end
    if noInputLength > 60 then
        inputArr = {}
        noInputLength = 0
    end
end

function characterToMorseCode(_Character)
    return constants.morseCodeTable[_Character]
end

function morseCodeToCharacter(_MorseCode)
    for i, v in pairs(constants.morseCodeTable) do
        if v == _MorseCode then return i end
    end
end


function arrToMorseCode(_Arr)
    local morseCode = ""
    for i, v in ipairs(_Arr) do
        if v > 20 then
            morseCode = morseCode .. "_"
        else
            morseCode = morseCode .. "."
        end
    end
    return morseCode
end

function love.keypressed(_Key) input = true end
function love.keyreleased(_Key) input = false end

function love.load()
    input = false
    inputLenght = 0
    noInputLength = 0
    inputArr = {}
end

function love.update(dt)
    checkInput()

end

function love.draw(dt)
    local morseCode = arrToMorseCode(inputArr)
    love.graphics.print(morseCode, 0, 0)
    love.graphics.print(morseCodeToCharacter(morseCode), 0, 10)
    for i, v in ipairs(inputArr) do
        love.graphics.print(v, 0, 20+(i * 20))
    end
end