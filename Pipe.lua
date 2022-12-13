
Pipe = Class{}


local PIPE_IMAGE_BELOW = love.graphics.newImage('images/pipe_below.png')
local PIPE_IMAGE_ABOVE = love.graphics.newImage('images/pipe_above.png')
local PIPE_SCROOL = -200
local PIPE_GAP = 100

function Pipe:init()
    self.x = VIRTUAL_WIDTH
    self.y = math.random(144,240)
    self.gap = 288 + PIPE_GAP + math.random(-10,60)
    self.height = PIPE_IMAGE_BELOW:getHeight()
    self.width = PIPE_IMAGE_BELOW:getWidth()

    self.scored = false

end

function Pipe:update(dt)

    self.x = self.x + PIPE_SCROOL *dt

    
end


function Pipe:render()
    love.graphics.draw(PIPE_IMAGE_BELOW,self.x,self.y)
    love.graphics.draw(PIPE_IMAGE_ABOVE , self.x,self.y - self.gap )

    
end

function Pipe:collide(bird)
    if (bird.x + 15) + (bird.width-6) >= self.x and (bird.x + 15) <= self.x + self.width then
        if (bird.y + 6) + (bird.height-10) >= self.y and bird.y <= self.y + self.height then
            return true
        end
    end
    if (bird.x + 15) + (bird.width-6) >= self.x and (bird.x + 15) <= self.x + self.width then
        if (bird.y + 6) + (bird.height-10) >= self.y - self.gap and  bird.y <= self.y - self.gap + self.height then
            return true
        end
    end

    return false

end