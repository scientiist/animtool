local Object = require("include.Object")
local entity = Object:subclass("Entity")
--- @overload
function entity:init() 


   self.Position = Vector2.new(50,50);
   self.Size = Vector2.new(16, 24);
   self.Velocity = Vector2.new(0,0);
   
   self.Color = {math.random(), math.random(), math.random()};

end

function entity:GetTopLeft()
    return self.Position - (self.Size/2);
end
function entity:GetExtents()
    return self.Size*2;
end

function entity:GetBottomRight()

end

function entity:Update(delta)
    -- Euler Integration
    -- Position+Velocity present what is essentially a differential equation
    --self.Velocity = self.Velocity * (1-delta); -- Drag
    --self.Position = self.Position + (self.Velocity*delta);

end

function entity:Draw()
    -- draw bounding box
    local topleft = self:GetTopLeft();
    local bounds = self:GetExtents();
    love.graphics.rectangle("fill", topleft.X, topleft.Y, bounds.X, bounds.Y);

end

return entity;