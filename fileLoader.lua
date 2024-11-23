local nImg = love.graphics.newImage
local nSfx = love.audio.newSource

local loadedFiles = {}


loadedFiles.img = {
    
}

loadedFiles.sfx = {

}

loadedFiles.font = {
    small = love.graphics.newFont(12),
    medium = love.graphics.newFont(24),
    big = love.graphics.newFont(48)
}



return loadedFiles