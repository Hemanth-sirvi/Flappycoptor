ScoreState = Class{__includes = BaseState}



function ScoreState:enter(Params)
    self.score = Params.score
end

function ScoreState:update(dt)
    if love.keyboard.waspressed('return') or love.keyboard.waspressed('space') then
        gStateMachine:change('countdown')
        
    end
end


function ScoreState:render()
    love.graphics.setFont(flappyfont)
    love.graphics.printf('You lost! ',0,70,VIRTUAL_WIDTH,'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score:'..tostring(self.score),0,100, VIRTUAL_WIDTH,'center')

    love.graphics.printf('press Enter or space to Play Again!',0,160,VIRTUAL_WIDTH,'center')
    
end