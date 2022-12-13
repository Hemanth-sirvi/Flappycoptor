


WINDOW_WIDTH = 1270
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'



local background = love.graphics.newImage('images/background.png')
local backgroundscrol = 0


local ground = love.graphics.newImage('images/ground.png')
local groundscrol = 0

BACKGROUND_SPEED = 30
GROUND_SPEED = 200

BACKGROUND_LOOPING_POINT =  512

function love.load()

    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('Flappycopter')
    

    smallFont = love.graphics.newFont('fonts/font.ttf',10)
    mediumFont = love.graphics.newFont('fonts/font.ttf',20)
    hugeFont = love.graphics.newFont('fonts/font.ttf',50)
    flappyfont = love.graphics.newFont('fonts/font.ttf',30)
    love.graphics.setFont(flappyfont)

    math.randomseed(os.time())
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })


    gStateMachine = StateMachine(
    {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountdownState() end
                        
    })

    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav','static'),
        ['crash'] = love.audio.newSource('sounds/crash.wav','static'),
        ['scoreSound'] = love.audio.newSource('sounds/score.wav','static'),
        ['backtrack']  = love.audio.newSource('sounds/backmusic.wav','static')


    }

    sounds['backtrack']:setLooping(true)
    sounds['backtrack']:play()
    gStateMachine:change('title')

    love.keyboard.keyPressed = {}

end



function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)

    love.keyboard.keyPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end

function love.update(dt)
    backgroundscrol = (backgroundscrol + BACKGROUND_SPEED * dt) % BACKGROUND_LOOPING_POINT 
    groundscrol = (groundscrol + GROUND_SPEED * dt) % VIRTUAL_WIDTH
    
    gStateMachine:update(dt)

    love.keyboard.keyPressed = {}
end

function love.draw()
        push:start()

        love.graphics.draw(background,-backgroundscrol,0)

        gStateMachine:render()

        love.graphics.draw(ground,-groundscrol,VIRTUAL_HEIGHT-20)
        
        push:finish()


        
end


function love.keyboard.waspressed(key)
    if love.keyboard.keyPressed[key] then 
        return true
    else 
        return false
    end
end