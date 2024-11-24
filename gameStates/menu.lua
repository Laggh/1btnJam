local thisState = {}

function thisState.load()
    randomMenuVariable = "random menu value"
    stateTime = 0
    globalTime = 0
end

function thisState.update(_Dt)
    globalTime = globalTime + _Dt
    stateTime = stateTime + _Dt
end

function thisState.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Menu Screen: " .. randomMenuVariable, 10, 10)
end

function thisState.onInput(_Input)
    if wantToQuit then
        if _Input == "y" then
            love.event.quit()
        else
            wantToQuit = false
        end
    end

    if _Input == "P" then
        changeGameState("game")
    end

    if _Input == "C" then
        changeGameState("config")
    end

    if _Input == "q" then
        wantToQuit = true
    end

end

return thisState
