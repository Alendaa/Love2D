---@diagnostic disable: missing-fields

local module = {}
module.__index = module

---@class Player
---@field Name string Player name.
---@field Life number Player life.
---@field Speed number Player speed
---@field Position Vector2 Player position.
---@field Destroy function Delete the player.
---@field SetSpeed function Change player speed.
---@field TakeDamage function Make the player take damage.

---@param name string
---@param life number?
---@param speed number?
---@return Player
function module.new(name, life, speed)
    ---@type Player
    local plr = {}
    plr.Name = name
    plr.Life = life or 100

    plr.Speed = speed * 8 or 16 * 8

    plr.Position = Vector2.new()

    function plr:SetSpeed(speed)
        plr.Speed = speed * 8
    end
    
    ---@param damage number
    function plr:TakeDamage(damage)
        self.Life = self.Life - (damage or 25)
        if self.Life <= 0 then
            self.Life = 0
            return self:Destroy()
        end
    
        return plr
    end

    function plr:Destroy()
        plr = nil
        return nil
    end

    return plr
end

return module
