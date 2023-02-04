local Vector2 = require("src.Vector2");
_G.Vector2 = Vector2;

local entity = require("src.Entity");

local World = {};
World.__index = World;

function World.new()
    local self = setmetatable({}, World);
    self.Gravity = 24;
    self.Entities = {};
    return self;
end


function World:AddEntity(entity)
    return table.insert(self.Entities, entity);
end

local TERMINAL_VELOCITY = 20; -- test value

function World:Update(delta)
    
    for _, entity in pairs(self.Entities) do

        -- Apply Gravity
        if entity.Velocity.Y < TERMINAL_VELOCITY then
            entity.Velocity = entity.Velocity + Vector2.new(0, self.Gravity*delta);
        end

        entity:Update(delta);
    end
end

function World:Draw()
    for _, entity in pairs(self.Entities) do
        entity:Draw();
    end
end

function math.lerp(a, b, t)

end

local testScene = World.new();
local testEntity = entity.new();
testScene:AddEntity(testEntity);

function love.load()

end

function love.update(delta)
    testScene:Update(delta);
end

function love.draw()
    testScene:Draw();
end