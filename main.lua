constants = require("constants")
config = require("config")
loadedFiles = require("fileLoader")
screenLib = require("lib/screen")
love.window.setMode(800,600, {resizable=true, vsync=false, minwidth=400, minheight=300})

gameStates = {}
gameState = {}

for i,v in pairs(constants.gameStatesNames) do
    gameStates[v] = require("gameStates/"..v)
end

local img = loadedFiles.img
local sfx = loadedFiles.sfx

function changeGameState(_State)
    gameState = _State
    gameStates[gameState].load()
end


function drawCentered(_Draw, _X, _Y, _R, _Sx , _Sy)
    local width, height = _Draw:getDimensions()
    _Sx = _Sx or width
    _Sy = _Sy or height
    love.graphics.draw(_Draw, _X - width/2, _Y - height/2, _R, _Sx / width , _Sy / height) end
function checkInput()
    if input then 
        inputLenght = inputLenght + 1
        noInputLength = 0
    else 
        if inputLenght > 0 then
            table.insert(inputArr, inputLenght)
            inputLenght = 0
        end
        noInputLength = noInputLength + 1
    end
    if noInputLength > config.maxMorseCodeLength and #inputArr >= 1 then
        inputArr = {}
        noInputLength = 0
        local morseStr = arrToMorseCode(inputArr)
        local character = morseCodeToCharacter(morseStr)
        print(morseStr, character)
        onInput(character)
    end end

function characterToMorseCode(_Character)
    return constants.morseCodeTable[_Character] end

function morseCodeToCharacter(_MorseCode)
    for i, v in pairs(constants.morseCodeTable) do
        if v == _MorseCode then return i end
    end end


function arrToMorseCode(_Arr)
    local morseCode = ""
    for i, v in ipairs(_Arr) do
        if v > config.minDashLength then
            morseCode = morseCode .. "_"
        else
            morseCode = morseCode .. "."
        end
    end
    return morseCode end

function love.keypressed(_Key) input = true end
function love.keyreleased(_Key) input = false end

function love.load()
    input = false
    inputLenght = 0
    noInputLength = 0
    inputArr = {}

    changeGameState("introScreen")
    stateTime = 0
    globalTime = 0
end

function onInput(_Input)
    print("Input: ",_Input)
end

function love.update(dt)
    checkInput()

end

function love.draw(dt)

    screenLib.setScreen(800, 600)
    gameState.draw(dt)

    local morseCode = arrToMorseCode(inputArr) or ""
    love.graphics.print(morseCode, 0, 0)
    love.graphics.print(morseCodeToCharacter(morseCode) or "", 0, 10)
    for i, v in ipairs(inputArr) do
        love.graphics.print(v, 0, 20+(i * 20))
    end



    screenLib.createBorder()
end