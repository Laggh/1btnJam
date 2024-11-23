local thisState = {}

function thisState.load()
    randomAhhVariable = "random ahh value"
    stateTime = 0
    globalTime = 0
end

function thisState.update(_Dt)
    globalTime = globalTime + _Dt
    stateTime = stateTime + _Dt
end

function thisState.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Press any key to start" .. randomAhhVariable, 10, 10)
end

function thisState.onInput(_Input)
    changeGameState("menu")
end


return thisState