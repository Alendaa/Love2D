local module = {}
module.__index = module

---@class Part
---@field Type string Type of the part.
---@field Position Vector2 Part position.

---@class Damage: Part
---@field Damage number Damage of the part.

---@return Part | Damage
function module.new(damage)
    ---@type Part | Damage
    local part = {
        Type = type,
        Position = Vector2.new()
    }

    if type and type == "Damage" then
        part.Damage = damage or 25
    end

    part.Position = Vector2.new()

    return part
end

return module
