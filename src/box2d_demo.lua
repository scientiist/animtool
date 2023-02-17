local Object = require "include.Object"
local Box2dDemo = Object:subclass("Box2dDemo");

function Box2dDemo:init()
    love.physics.setMeter(64);
    self.World = love.physics.newWorld(0, 9,81*64, true);
    self.Objects = {};
    self.Objects.Ground = {};
    self.Objects.Ground.Body = love.physics.newBody(world, 650/2, 650-50/2);
    self.Objects.Ground.Shape = love.physics.newRectangleShape(650, 50);
    self.Objects.Ground.Fixture = love.physics.newFixture(self.Objects.Ground.Body, self.Objects.Ground.Shape);


    self.

end



return Box2dDemo;