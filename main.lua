--- Blacktop Saga Main Script
--- @auth: Joshua O'Leary
--- @name main.lua
--- @copyright Conarium Software 2023
--- @

-- Disables Texture Blurring
love.graphics.setDefaultFilter("nearest", "nearest");
-- Preload Game Assets
_G.Assets = require("src.assets");


-- Standard Tiled Loader
-- Tiled is our map editor of choice
local sti = require("include.sti");
local Object = require("include.Object");

-- Declare Objects
local Vector2 = require("include.Vector2");
_G.Vector2 = Vector2;

local entity = require("src.Entity");
local World = require("src.World");

local Skeleton = Object:subclass();

function Skeleton:init()

end


local Bone = Object:subclass();


function Bone:init()
    self.Length = 1;
    self.Angle = 0;
end


local Joint = Object:subclass();

function Joint:init()
    
end







local TestSkelly = Skeleton:new();






function math.lerp(a, b, t)

end


local testScene = World:new();
local testEntity = entity:new();
testScene:AddEntity(testEntity);

Robot = require("src.robot")

local robot = Robot:new();
testScene:AddEntity(robot);


local Camera = require("src.camera");
local cam = Camera:new();

local testMap = sti("assets/maps/MagicLand/map.lua")


local zoom = 0;
local cameraPos = Vector2.new(0,0);

function love.wheelmoved(x, y)
    if x and x ~= 0 then
        print("Weird Joystick? (You can't seriously expect me to support this...)");
    end

    zoom = zoom- y / 10;
end


function love.load()
	love.window.setMode(800, 600, {msaa=0});


end


local prevMous = Vector2.new(love.mouse.getX(), love.mouse.getY());

function love.update(delta)
    testScene:Update(delta);

    testMap:update(delta);





    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    if love.keyboard.isDown("r") then
        love.event.quit("restart")
    end


    local currMous = Vector2.new(love.mouse.getX(), love.mouse.getY());
    if love.mouse.isDown(1) then
        local deltaMous = currMous - prevMous;

    end

end

function love.draw()

    
    local transform = love.math.newTransform();
    transform:translate(cameraPos.X, cameraPos.Y);
    transform:translate(love.graphics.getWidth()/2, love.graphics.getHeight()/2);
    transform:scale(1 - zoom, 1 - zoom);
    love.graphics.applyTransform(transform);

    -- Draw Range culls unnecessary tiles
	--testMap:setDrawRange(0, 0, love.graphics.getWidth(), love.graphics.getHeight());
    
    testMap:draw(cameraPos.X, cameraPos.Y);
    testScene:Draw();

    love.graphics.setColor(1,1,1);
    love.graphics.setLineWidth(0.2);
    -- draw line from -inf < X < +inf
    local inf = 9999; -- todo;
    love.graphics.line(-inf, 0, inf, 0);
    -- draw line from -inf < Y < +inf
    love.graphics.line(0, inf, 0, inf);
    love.graphics.setLineWidth(0.1);
    for i = -inf, inf, 10 do
        love.graphics.line(-10, i, 10, i);
    end

    for i = -inf, inf, 10 do
        love.graphics.line(-10, i, 10, i);
    end
    for i = -inf, inf, 10 do
        love.graphics.line(i, -10, i, 10);
    end

    for i = -inf, inf, 10 do
        love.graphics.line(i, -10, i, 10);
    end


    
end