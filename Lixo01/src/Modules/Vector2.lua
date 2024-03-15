local module = {}
module.__index = module

---@param x? number
---@param y? number
function module.new(x, y)
    ---@class Vector2
    local vector = setmetatable({}, module)
    vector.x = x or 0
    vector.y = y or 0

    return vector
end

return module
