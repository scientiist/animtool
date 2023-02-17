local Object = require("include.Object");
local World = Object:subclass("World");

function World:init()
    self.Gravity = 24;
    self.Entities = {};
end

function World:AddEntity(entity)
    return table.insert(self.Entities, entity);
end

local TERMINAL_VELOCITY = 20; -- test value

function World:Update(delta)
    for _, entity in pairs(self.Entities) do
        entity:Update(delta);
    end
end

function World:Draw()
    for _, entity in pairs(self.Entities) do
        entity:Draw();
    end
end


return World;