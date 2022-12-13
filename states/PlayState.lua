

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.heli = Bird()
    self.pipes = {}
    self.timer = 0

    self.score = 0
  
end

function PlayState:update(dt)
    
    self.timer = self.timer + dt

    if self.timer > 1 then 
        table.insert(self.pipes, Pipe())
        self.timer = 0
    end

    self.heli:update(dt)

    for k,pipe in pairs(self.pipes) do

        if not pipe.scored then
            if pipe.x < self.heli.x  then
                self.score = self.score +1
                pipe.scored = true
                sounds['scoreSound']:play()
            end
        end
        pipe:update(dt)
        
        if pipe:collide(self.heli) then 
            gStateMachine:change('score',{score = self.score})
            sounds['crash']:play()
        end

        

        if pipe.x < -pipe.width then
            table.remove(self.pipes,k)
        end
    end

    if self.heli.y > VIRTUAL_HEIGHT then
        sounds['crash']:play()
        gStateMachine:change('score', {score = self.score })        
    end
    
end


function PlayState:render()
    for k,pipe in pairs(self.pipes) do
        pipe:render()
    end

    self.heli:render()
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: '..tostring(self.score),10,10,VIRTUAL_WIDTH/2)
end
