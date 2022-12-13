
TitleScreenState = Class{__includes = BaseState }

function TitleScreenState:update(dt)
    if love.keyboard.waspressed('space') or love.keyboard.waspressed('return') then
        gStateMachine:change('play')
    end
end


function TitleScreenState:render()
    love.graphics.setFont(flappyfont)
    love.graphics.printf('Flapy Helicoptor',0,100,VIRTUAL_WIDTH,'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press enter or space',0,136,VIRTUAL_WIDTH,'center')
    
end

