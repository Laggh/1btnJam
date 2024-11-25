local thisState = {}

maxId = 0

function spawnAnt(_X, _Y, _Team)
    local newAnt = {
        id = maxId + 1,
        type = "ant",
        x = _X,
        y = _Y,
        team = _Team,
        speed = 3,
        hp = 100,
        timeSinceHit = 0,
        atackCharge = 0,
        direction = math.random(2*math.pi),
        sprites = loadedFiles.img.ant,
        spriteIndex = 1,
        spriteTime = 0,

        action = "idle",
        movePos = {x = _X, y = _Y},
        atackTarget = nil
        objective = nil 

    }
    maxId = maxId + 1
    newAnt.direction = 0
    table.insert(ants, newAnt)
    return newAnt.id
end

function runAnt(_Ant)
    if _Ant.hp < 0 then
        table.remove(ants, _Ant.id)
        return
    end
    _Ant.atackCharge = setLimits(0,_Ant.atackCharge + 1,35)
    --Sprite animation
    if _Ant.spriteTime == 10 then
        _Ant.spriteIndex = _Ant.spriteIndex + 1
        if _Ant.spriteIndex > #_Ant.sprites then
            _Ant.spriteIndex = 1
        end
        _Ant.spriteTime = 0
    end

    --Random idle action
    if (_Ant.action == "idle" and math.random(1000) == 1) then
        local randomIndex = math.random(#ants)
        if _Ant.id ~= randomIndex then
            local randomAnt = ants[math.random(#ants)]
            if randomAnt.team == _Ant.team then
                _Ant.action = "move"
                _Ant.movePos = {x = randomAnt.x, y = randomAnt.y}
            else
                _Ant.action = "atack"
                _Ant.movePos = {x = randomAnt.x, y = randomAnt.y}
            end
        end
    end

    local diff = angleDiff(_Ant.direction, math.atan2(_Ant.movePos.y - _Ant.y, _Ant.movePos.x - _Ant.x))
    local dist = math.sqrt((_Ant.movePos.x - _Ant.x)^2 + (_Ant.movePos.y - _Ant.y)^2)
        
    --moving logic
    if _Ant.action == "move" then
        _Ant.spriteTime = _Ant.spriteTime + 1
        --Diference of the 2 angles
        if diff > 0.1 then
            _Ant.direction = _Ant.direction + 0.1
        elseif diff < -0.1 then
            _Ant.direction = _Ant.direction - 0.1
        end

        _Ant.x = _Ant.x + math.cos(_Ant.direction) * _Ant.speed
        _Ant.y = _Ant.y + math.sin(_Ant.direction) * _Ant.speed

        if dist < 10 then
            _Ant.action = "idle"
        end
    end

    --atacking logic
    if _Ant.action == "atack" then
        if diff > 0.1 then
            _Ant.direction = _Ant.direction + 0.1
        elseif diff < -0.1 then
            _Ant.direction = _Ant.direction - 0.1
        end

        _Ant.x = _Ant.x + math.cos(_Ant.direction) * _Ant.speed
        _Ant.y = _Ant.y + math.sin(_Ant.direction) * _Ant.speed


    end
end



function thisState.load(_Level)
    ants = {}
    for i = 1,5 do
        local newId = spawnAnt(math.random(100,700), math.random(100,500), 1)
        local newAnt = ants[newId]
        newAnt.action = "move"
        newAnt.movePos = {x = math.random(100,700), y = math.random(100,500)}
    end
end

function thisState.update(_Dt)
    globalTime = globalTime + _Dt
    stateTime = stateTime + _Dt

    for i,v in ipairs(ants) do
        runAnt(v)
    end
end

function thisState.draw()
    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.rectangle("fill", 0, 0, 800, 600)
    love.graphics.setColor(1, 1, 1, 1)

    for i,v in ipairs(ants) do
        drawCentered(v.sprites[v.spriteIndex], v.x, v.y, v.direction)
        local str = string.interpolate("Ant: ${id}-${action}",
            {id = v.id, action = v.action})
        love.graphics.print(str, v.x, v.y)

        love.graphics.line(v.x, v.y, v.movePos.x, v.movePos.y)

        love.graphics.setColor(1,1,1,0.1)
        love.graphics.circle("line", v.x, v.y, 10)
        love.graphics.setColor(1,1,1,1)
    end
end

function thisState.onInput(_Input)
    if _Input == "a" then
        local newId = spawnAnt(math.random(100,700), math.random(100,500), 1)
        local newAnt = ants[newId]
        newAnt.action = "move"
        newAnt.movePos = {x = math.random(100,700), y = math.random(100,500)}
    end
end


return thisState