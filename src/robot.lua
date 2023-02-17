-----------------------------------------
-- Test Robot Entity
local Entity = require "src.Entity";
local Robot = Entity:subclass("Robot");

local x, y = Assets.Images.Robot:getDimensions();

Robot.Frames = {
    -- x, y, x+w, y+h
    IDLE1 = love.graphics.newQuad(12, 8, 36, 80, x, y),
    IDLE2 = love.graphics.newQuad(56, 8, 36, 80, x, y),
    IDLE3 = love.graphics.newQuad(98, 8, 36, 80, x, y),
    IDLE4 = love.graphics.newQuad(150, 8, 50, 80, x, y),
    IDLE5 = love.graphics.newQuad(210, 8, 42, 80, x, y),
    WALK1 = love.graphics.newQuad(0, 104, 50, 80, x, y),
    WALK2 = love.graphics.newQuad(56, 104, 36, 80, x, y),
    WALK3 = love.graphics.newQuad(106, 104, 36, 80, x, y),
    WALK4 = love.graphics.newQuad(152, 104, 36, 80, x, y),
    WALK5 = love.graphics.newQuad(198, 104, 36, 80, x, y),
    WALK6 = love.graphics.newQuad(250, 104, 36, 80, x, y),
    WALK7 = love.graphics.newQuad(303, 104, 50, 80, x, y),
};

Robot.Animations = {};
Robot.Animations.Walk = {
    [1] = {Frame = Robot.Frames.WALK1, Speed = 5};
    [2] = {Frame = Robot.Frames.WALK2, Speed = 5};
    [3] = {Frame = Robot.Frames.WALK3, Speed = 5};
    [4] = {Frame = Robot.Frames.WALK4, Speed = 5};
    [5] = {Frame = Robot.Frames.WALK5, Speed = 5};
    [6] = {Frame = Robot.Frames.WALK6, Speed = 5};
    [7] = {Frame = Robot.Frames.WALK7, Speed = 5};
};

function Robot:init(...)
    Entity.init(self, ...);
    self.Animation = Robot.Animations.Walk;
    self.AnimationTimer = 0;
end

function Robot:Update(delta)
    if self.Animation then

        local frameIndex = (math.floor(self.AnimationTimer) % #self.Animation) + 1;

        local animSpeed = self.Animation[frameIndex].Speed;
        self.AnimationTimer = self.AnimationTimer + delta * animSpeed;
    end

    


end

function Robot:drawFrame(quad)


    
end



function Robot:Draw()
    print(#self.Animation)
    local frameIndex = (math.floor(self.AnimationTimer) % #self.Animation) + 1;
    print(frameIndex);
    local frame = self.Animation[frameIndex];
    local quad = frame.Frame;

    love.graphics.draw(Assets.Images.Robot, quad, self.Position.X, self.Position.Y);
end

return Robot;