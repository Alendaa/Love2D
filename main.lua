_G.love = require("love")

--Load the game
require("src.Game")

local Player = Players.new("Miguel", 100, 16)
Player.Position.x = love.graphics.getWidth() / 2
Player.Position.y = love.graphics.getHeight() / 2

local DamageBlock = Parts.new("Damage", 25)

local DamageDebounce = false
local DamageTimer = 1

local Acceleration = {
    Speed = 1,
    Activated = false
}

local Holding = {
    a = false,
    w = false,
    s = false,
    d = false
}

---@param p1 table Position.
---@param p2 table Position.
local function Distance(p1, p2)
    return math.sqrt((p2.x - p1.x)^2 + (p2.y-p1.y)^2)
end

function love.load()
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(deltaTime)

    if Player then
        if not DamageDebounce and Distance(Player.Position, DamageBlock.Position) <= 50 then
            Player = Player:TakeDamage(DamageBlock.Damage)
            pcall(function()
                print(Player.Name.." life: "..Player.Life)
            end)
            
            DamageDebounce = true
        elseif DamageDebounce then
            DamageTimer = DamageTimer - deltaTime
            if DamageTimer <= 0 then
                DamageTimer = 2
                DamageDebounce = false
            end
        end


        if Acceleration.Activated then
            if Acceleration.Speed < 3 then
                Acceleration.Speed = Acceleration.Speed + .001
                if Acceleration.Speed > 3 then
                    Acceleration.Speed = 3
                end
            end
        else
            if Acceleration.Speed > 1 then
                Acceleration.Speed = Acceleration.Speed - .005
                if Acceleration.Speed < 1 then
                    Acceleration.Speed = 1
                end
            end
        end
        

        pcall(function ()
            if love.keyboard.isDown("a") then
                Holding.a = true
                Player.Position.x = Player.Position.x - Acceleration.Speed * Player.Speed * deltaTime
            else
                Holding.a = false
            end
        
            if love.keyboard.isDown("w") then
                Holding.w = true
                Player.Position.y = Player.Position.y - Acceleration.Speed * Player.Speed * deltaTime
            else
                Holding.w = false
            end
        
            if love.keyboard.isDown("s") then
                Holding.s = true
                Player.Position.y = Player.Position.y + Acceleration.Speed * Player.Speed * deltaTime
            else
                Holding.s = false
            end
        
            if love.keyboard.isDown("d") then
                Holding.d = true
                Player.Position.x = Player.Position.x + Acceleration.Speed * Player.Speed * deltaTime
            else
                Holding.d = false
            end
        end)

        if Holding.a or Holding.w or Holding.s or Holding.d then
            Acceleration.Activated = true
        else
            Acceleration.Activated = false
        end
    end
end

function love.draw()
    if Player then
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("fill", Player.Position.x, Player.Position.y, 50, 50)
    end


    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", DamageBlock.Position.x, DamageBlock.Position.y, 50, 50)
end