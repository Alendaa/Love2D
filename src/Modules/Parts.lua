local module = {}
module.__index = module

---@class Part
---@field Position Vector2 Part position.

---@class Damage: Part
---@field Damage number Damage of the part.

---@return Part | Damage
function module.new(damage)
    ---@type Part | Damage
    local part = {}
    part.Damage damage or 25
    part.Position = Vector2.new()

    return part
end

return module
